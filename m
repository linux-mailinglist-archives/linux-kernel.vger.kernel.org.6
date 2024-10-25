Return-Path: <linux-kernel+bounces-381883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E509B05DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D631C22A96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D29C20BB45;
	Fri, 25 Oct 2024 14:30:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522AB208234;
	Fri, 25 Oct 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866656; cv=none; b=Xdpm+nILQIqyIMy+niTB5mWfr5lN9lBwVWR+MoAqYFKDF2TQO0xgCc+IAk2P0FQu9OWydFjRiTuKShk9MLFEJ5u5B//NDF8OKlakZauUkFXfYWMcfbiwAF26YpqZ7O7ypnvDRfBvyRLYzRl6Z3bJhDczNrFyPElSEBtH83wH3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866656; c=relaxed/simple;
	bh=uRdY02G16xee66yZv3V9LaXcJX6pSUexpS2ItdhLEno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r64GsoymYNn/9PfDk2bEEqQ7WAWpCu9ugSS4tonRuZpde7idrKKLncc1dIeuZ0fC8+6ifbLyqdvEElGq4pZTYHJz/Jh6SdBJatoQZBdDfm73s6oQn9T/kUIDr8W8sml1BrJ8Ji1jVOhme5mSnqhmfz+qQfV5waOwnfPO+8j9Y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68830497;
	Fri, 25 Oct 2024 07:31:23 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 632793F73B;
	Fri, 25 Oct 2024 07:30:51 -0700 (PDT)
From: Graham Woodward <graham.woodward@arm.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	Graham Woodward <graham.woodward@arm.com>
Subject: [PATCH v1 1/4] perf arm-spe: Set sample.addr to target address for instruction sample
Date: Fri, 25 Oct 2024 15:30:06 +0100
Message-Id: <20241025143009.25419-2-graham.woodward@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241025143009.25419-1-graham.woodward@arm.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an instruction sample, assign the target address to the field
'to_ip'.
If it is a non-branch record, to_ip will be 0, presenting a non-valid
target address.

Signed-off-by: Graham Woodward <graham.woodward@arm.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 856cc36f33d7..49b763807360 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -418,7 +418,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 
 	sample.id = spe_events_id;
 	sample.stream_id = spe_events_id;
-	sample.addr = record->virt_addr;
+	sample.addr = record->to_ip;
 	sample.phys_addr = record->phys_addr;
 	sample.data_src = data_src;
 	sample.period = spe->instructions_sample_period;
-- 
2.40.1



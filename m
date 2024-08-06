Return-Path: <linux-kernel+bounces-276865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAD1949950
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9A31C217B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82391171E5F;
	Tue,  6 Aug 2024 20:42:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB204170A33
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976920; cv=none; b=dGxabG5pOatsYV2qyKftJ8diGlMGWXY8nNNch5aJcguaiYMl7Rqeua2w1+XiUrHy6xZQw3RklU8QcLnUAaU8cKIpi/sd7GJYFanTs8aQb0nb4vtk3PQAMZknsXfi44tRf/OZTvgNTmiqgC/6NZln0U+mqHpj2ndx8q/pca1WaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976920; c=relaxed/simple;
	bh=YA3ytoZ3dE4WexVWQOHm9xtdsLrRLOKdK2fcvnoi2gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0a2+jfaDXz8ZsfY8APiLMiKH8sdRq+G2ru8t6R1YvuHEHQaEoObTCXYBbdGBFfAqHyM0ATbREPKRqkyOZfqpC9opgxAsjyQatWlkO/0OpqZVUtJq1smpJZCFYQgP0kjkp9ljJLEXxvPduVF7BQrcKkt3yoGRNj47NysIT11oVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 204571063;
	Tue,  6 Aug 2024 13:42:24 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79AFD3F766;
	Tue,  6 Aug 2024 13:41:56 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 6/9] perf hisi-ptt: Remove the unused 'pmu_type' field
Date: Tue,  6 Aug 2024 21:41:27 +0100
Message-Id: <20240806204130.720977-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204130.720977-1-leo.yan@arm.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'pmu_type' field is not used, remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/hisi-ptt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 57dd98afb0d2..859e1bc38e12 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -32,7 +32,6 @@ struct hisi_ptt {
 	u32 auxtrace_type;
 	struct perf_session *session;
 	struct machine *machine;
-	u32 pmu_type;
 };
 
 static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf)
@@ -166,7 +165,6 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->session = session;
 	ptt->machine = &session->machines.host; /* No kvm support */
 	ptt->auxtrace_type = auxtrace_info->type;
-	ptt->pmu_type = auxtrace_info->priv[0];
 
 	ptt->auxtrace.process_event = hisi_ptt_process_event;
 	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
-- 
2.34.1



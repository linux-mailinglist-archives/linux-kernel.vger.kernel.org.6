Return-Path: <linux-kernel+bounces-281453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A294D711
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CAD281C21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDDB161339;
	Fri,  9 Aug 2024 19:15:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181815E5B5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230958; cv=none; b=i57ofXmd0hWwjVAtEdG4yDN9aVoKaq23JSeZx0OiZtaZVa5EDNt1YOlZKOvqlK3R6j9pfU4bH+kaY8HAGNa1anH/Do/5EJRVG0I3qI3uLk2LGEB1gH0k0689HZUxUiWvWB6rSLRbm36bgO4lnB8ASu4XXTTfmgFuoN4PgvxRLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230958; c=relaxed/simple;
	bh=xdAWkUwY/Qe+K0aawD46w1bViDiUNXnLqsAFfvbVdog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cp2DO6imiWml3h2yX6AViPFvtqdMO86NnqS3cyv+jzmtvE1kyhSwQjt0ot9da7lfWfePSUof5rKYyGssnV/KTzou3ScSmPujNdBOJ9ybbvsLvdv7YNS6dfJ5ZBsFlFT75hI+cUGw+Tlv1IPEh5SXepbVli+aToDHx3AUcdu2mys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3274B168F;
	Fri,  9 Aug 2024 12:16:22 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9722A3F71E;
	Fri,  9 Aug 2024 12:15:55 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 3/8] perf/arm-cmn: Ensure dtm_idx is big enough
Date: Fri,  9 Aug 2024 20:15:42 +0100
Message-Id: <aa9d45b10814dc6b2c59dfb2c1be49f333dae1dc.1723229941.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1723229941.git.robin.murphy@arm.com>
References: <cover.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While CMN_MAX_DIMENSION was bumped to 12 for CMN-650, that only supports
up to a 10x10 mesh, so bumping dtm_idx to 256 bits at the time worked
out OK in practice. However CMN-700 did finally support up to 144 XPs,
and thus needs a worst-case 288 bits of dtm_idx for an aggregated XP
event on a maxed-out config. Oops.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 0e2e12e2f4fb..c9a2b21a7aec 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -563,7 +563,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
 
 struct arm_cmn_hw_event {
 	struct arm_cmn_node *dn;
-	u64 dtm_idx[4];
+	u64 dtm_idx[5];
 	s8 dtc_idx[CMN_MAX_DTCS];
 	u8 num_dns;
 	u8 dtm_offset;
-- 
2.39.2.101.g768bb238c484.dirty



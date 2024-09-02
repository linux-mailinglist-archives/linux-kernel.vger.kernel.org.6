Return-Path: <linux-kernel+bounces-311741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD71968CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B144B20C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4545201269;
	Mon,  2 Sep 2024 17:52:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86B31CB52F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299537; cv=none; b=jifxebNQuFZo92tNLDhQpE/z7nmbADhWdwFF+Vc8rVccAfrg1ZvV6/u5SjJkxQ1JuqpbgzhFhp2vtG+k8IK3SRctgpqE8QcOoP0nHlE2POyxZKUarXNfGU1AzwLnXmSqqWawhVNvEtijUzDSxnJuKA0i67gayMFcXCFzTrEeV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299537; c=relaxed/simple;
	bh=ZtJLgsADsHiv8LBjx8dNXVe9UR+YpfECXKXafKjOe1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQA3bHjjFJcyVu83WE/u6zAV0TIzFip0PvchOGAqw7MAsoUNjMkSJok3UP9e4f3Veqmhsb+Nm2JogMHOaBpuw00PKra+27ZMt78PMruy3ONmS7TL8nbdr8a6ewMYHvmgBqu3LTWjrmoIrtD1s+pK/P88y4JvTtir2Qc0RQwYd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9CEFEC;
	Mon,  2 Sep 2024 10:52:41 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51EC83F73B;
	Mon,  2 Sep 2024 10:52:14 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH v2 2/8] perf/arm-cmn: Fix CCLA register offset
Date: Mon,  2 Sep 2024 18:51:58 +0100
Message-Id: <6e7bb06fef6046f83e7647aad0e5be544139763f.1725296395.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725296395.git.robin.murphy@arm.com>
References: <cover.1725296395.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently pmu_event_sel is offset by 8 for all CCLA nodes, not just
the CCLA_RNI combination type.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Add CCLA-specific definition for clarity
---
 drivers/perf/arm-cmn.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b59ae8513dce..4e2338afe669 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -70,7 +70,8 @@
 /* Technically this is 4 bits wide on DNs, but we only use 2 there anyway */
 #define CMN__PMU_OCCUP1_ID		GENMASK_ULL(34, 32)
 
-/* HN-Ps are weird... */
+/* Some types are designed to coexist with another device in the same node */
+#define CMN_CCLA_PMU_EVENT_SEL		0x008
 #define CMN_HNP_PMU_EVENT_SEL		0x008
 
 /* DTMs live in the PMU space of XP registers */
@@ -2393,10 +2394,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_CXHA:
 			case CMN_TYPE_CCRA:
 			case CMN_TYPE_CCHA:
-			case CMN_TYPE_CCLA:
 			case CMN_TYPE_HNS:
 				dn++;
 				break;
+			case CMN_TYPE_CCLA:
+				dn->pmu_base += CMN_CCLA_PMU_EVENT_SEL;
+				dn++;
+				break;
 			/* Nothing to see here */
 			case CMN_TYPE_MPAM_S:
 			case CMN_TYPE_MPAM_NS:
@@ -2414,7 +2418,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_HNP:
 			case CMN_TYPE_CCLA_RNI:
 				dn[1] = dn[0];
-				dn[0].pmu_base += CMN_HNP_PMU_EVENT_SEL;
+				dn[0].pmu_base += CMN_CCLA_PMU_EVENT_SEL;
 				dn[1].type = arm_cmn_subtype(dn->type);
 				dn += 2;
 				break;
-- 
2.39.2.101.g768bb238c484.dirty



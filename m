Return-Path: <linux-kernel+bounces-387203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B041C9B4DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7532A2816DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91D1946BB;
	Tue, 29 Oct 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYi7QgVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BC1946A2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215468; cv=none; b=mhIxv97nmt+awVSOlde+36yotsCEYmQI98JNCYKLzNcTlBZ7ku7ifqkX5I2bJfYS/nt2XjsScF6mZFLpHDAZJ2tvmgOxsUr5Qm2t8Rudm3WwXmsIzYBvQO32Uout57SasLgC5/pLyJWbhQml9GJ4uXMS1daLSi4MoPGDy8gLmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215468; c=relaxed/simple;
	bh=spcximgZNTI7A3REOTjN2rTIRSPY/oytt/Et/v2KFhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnvOGBpBALC2cHZNhdCrJIvAUcJ7whK2oiOaO+I408pbfRYrMBpx8qEmXpD4XX9hkuZCFZYxUiHDiP0Obfe+tQ2YP8d3GjkR+mcCembCEqQP3oeXgpG7LyeySoyp3887UpkTYX/dWsWhhdKTkMU6dwlYPKBuDBhX+HlyRG0rZRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYi7QgVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB7AC4CECD;
	Tue, 29 Oct 2024 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730215466;
	bh=spcximgZNTI7A3REOTjN2rTIRSPY/oytt/Et/v2KFhk=;
	h=From:To:Cc:Subject:Date:From;
	b=KYi7QgVZ7iM9DT2mApS+ZpXXGvwTMMzs8Pyiqw83P3gVcYiJ2XpnSwvkOwF24qOcJ
	 kzs2iIMAG0i5EDM8bF6nKPTSb04FfUkJmSaFCtiuGq9vF6IyM25qVr5lx4HYgPwpps
	 LIxGILcAxquZC1zd5vW3xxJvia2Uv/iZOBDkmwCuYXXwIIt3wHq40JeWWnbxIg179k
	 yT1FLfIK+so0lHdNxhyRMP7QfF8rR2Rr0DI7YTxhfiq8wWfpLSA+dW5z7gf4PlNVEM
	 XOA0RxSK7uAATKO55j/wpWZlDWwpq7/NVU6uRDHAvTGWWFo5dJL169Y1fcPFm/UX11
	 3t3n6nlVwBu3Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/arm_pmuv3: fix building on 32-bit
Date: Tue, 29 Oct 2024 15:24:10 +0000
Message-Id: <20241029152420.3251097-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The write_pmuacr() function is only defined on arm64, so building the
driver on 32-bit arm now fails:

drivers/perf/arm_pmuv3.c: In function 'armv8pmu_enable_user_access':
drivers/perf/arm_pmuv3.c:784:17: error: implicit declaration of function 'write_pmuacr'; did you mean 'write_pmcr'? [-Wimplicit-function-declaration]

Add a compile-time check around the newly added code, as it is never
needed on arm32.

Fixes: 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/perf/arm_pmuv3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index b6315ce71f19..e67918e0bbda 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -775,6 +775,7 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 	int i;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 
+#ifdef CONFIG_ARM64
 	if (is_pmuv3p9(cpu_pmu->pmuver)) {
 		u64 mask = 0;
 		for_each_set_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS) {
@@ -782,7 +783,9 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 				mask |= BIT(i);
 		}
 		write_pmuacr(mask);
-	} else {
+	} else
+#endif
+	{
 		/* Clear any unused counters to avoid leaking their contents */
 		for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
 				    ARMPMU_MAX_HWEVENTS) {
-- 
2.39.5



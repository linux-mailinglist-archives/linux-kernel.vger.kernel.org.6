Return-Path: <linux-kernel+bounces-178169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BAC8C49F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6AD1C20E11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A485275;
	Mon, 13 May 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RSyDMMCD"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658A2B9D9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642057; cv=none; b=kWmft7udRKaiqfumHSwQXLM47QqOn9yAJD0TXeEiFv8od56obrY3sfXjdt1WUa9BrT02Mdt9lsnTfEn5FfQH7tAPqgFmeVay8oH7gMFT/FqTRo4XnMn2r1kn99UbN8KmLgBDJ3bBd858CM8rxE2YpVEVZcilFHd3zXdo9fXsonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642057; c=relaxed/simple;
	bh=tx7E2f0GxPxvBaGc/bmN1M48jZl3m4a2E1TZi9bi+48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEYfnMZHEN7x7adDGzyxnHnRqc6mvOX7Fhuv9L8yvp/1630ocivEvdnCSQ2KYB8w8zwMfG2VdWeTeH3A1BQYH//B9N+1itnZdPrlqtAuui1Xa49jGy5tCOYg+cMAs8Srh/v9qlEUEI+VkFV4SHytCxyOQOPXQegNUmzqPovpDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RSyDMMCD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed835f3c3cso43475405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715642054; x=1716246854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UTWRBSAvd0X00gI81fMU/F+YZQ/Mige07NOxJW4aqM=;
        b=RSyDMMCD5nJWAk1ycPhOdN252NggPYtW2tMN3j16n/mEn8sYJYeQGYo6Gi8KeJK6vI
         oXlsVqAqf3r8UMInz41gQF1jUpCUCd6oCjaFh7C+CdJhNM/E4NaD2TICFllySo0MZXx3
         8CtpH5/Uluv/nNPI8IwCkicH8LioC2/KPWJaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642054; x=1716246854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UTWRBSAvd0X00gI81fMU/F+YZQ/Mige07NOxJW4aqM=;
        b=ImF8o84KrJQ0KXsL9TtDXAxhMxEuAJIBEmvbNGsj3mYINzqFVQ0Qm6KCEbPcWBSg3L
         RjtNDSqPUdVt70QgboTmd6/jpGVHhA8+bNr4rYhw55y9KTPvKE2wvZVT5c/u1g9RNE3Y
         kZAC9KeZHQWddfc4NXflqernpBSRb8+igaltmOAihGh4l58hAeEuIAaLiUNemz79hQQ9
         vGGRZBMoTzjYadUPwG4wjFzfETP0SgxJh4PEnAUpi/EzlNgWic5pERMI0+7FBXLbF4Ke
         5ZdYibIrYejiR3/vbTUFKMGQ0Kt5FulK3Py5qnHdTkMVxcUHYaWp9/mR8jXHZXD0fBhb
         /0eA==
X-Forwarded-Encrypted: i=1; AJvYcCX6v3/U3xugcUgqZfAFnmYt4Y+xJhdhj1uHp694tG69hllYWhgWo277tqrx8faxBry256Td4S+wLeBV8nYU+EKW/tmy8k8og6l7DvAN
X-Gm-Message-State: AOJu0Yz5PHh8kW0gMX6/GlWixIubnmKEoIn9cDjyGQ3Uhuwg6Rr8ToES
	6iw/+owgJ1ZT9sqHmwm22ArSXWDic0zcneTwHIVW/UOjN+PBw0pl1xlZjJf9gQ==
X-Google-Smtp-Source: AGHT+IF8+sauERaqDzjL2bI/eirzDn0nfnNAe5M0xI+wO+jJKg/7dcYov0Rv8fpzNykL4ic967Yyvw==
X-Received: by 2002:a17:903:1207:b0:1e7:b6f4:2d75 with SMTP id d9443c01a7336-1ef43d16e9amr162929375ad.6.1715642054153;
        Mon, 13 May 2024 16:14:14 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1165:227d:25c3:aee6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c160c63sm84391945ad.282.2024.05.13.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:14:13 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Chen Lin <chen45464546@163.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on devices it works on
Date: Mon, 13 May 2024 16:13:47 -0700
Message-ID: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On sc7180 trogdor devices we get a scary warning at bootup:
  arm-smmu 15000000.iommu:
  Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK

We spent some time trying to figure out how we were going to fix these
errata and whether we needed to do a firmware update. Upon closer
inspection, however, we realized that the errata don't apply to us.
Specifically, the errata document says that for these errata:
* Found in: r0p0
* Fixed in: r2p2

..and trogdor devices appear to be running r2p4. That means that they
are unaffected despite the scary warning.

The issue is that the kernel unconditionally tries to disable the
prefetcher even on unaffected devices and then warns when it's unable
to.

Let's change the kernel to only disable the prefetcher on affected
devices, which will get rid of the scary warning on devices that are
unaffected. As per the comment the prefetcher is
"not-particularly-beneficial" but it shouldn't hurt to leave it on for
devices where it doesn't cause problems.

Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 9dc772f2cbb2..d9b38b0db0d4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -109,7 +109,7 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
 
 int arm_mmu500_reset(struct arm_smmu_device *smmu)
 {
-	u32 reg, major;
+	u32 reg, major, minor;
 	int i;
 	/*
 	 * On MMU-500 r2p0 onwards we need to clear ACR.CACHE_LOCK before
@@ -118,6 +118,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 	 */
 	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_ID7);
 	major = FIELD_GET(ARM_SMMU_ID7_MAJOR, reg);
+	minor = FIELD_GET(ARM_SMMU_ID7_MINOR, reg);
 	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sACR);
 	if (major >= 2)
 		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
@@ -131,14 +132,18 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 	/*
 	 * Disable MMU-500's not-particularly-beneficial next-page
 	 * prefetcher for the sake of errata #841119 and #826419.
+	 * These errata only affect r0p0 through r2p1 (fixed in r2p2).
 	 */
-	for (i = 0; i < smmu->num_context_banks; ++i) {
-		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
-		reg &= ~ARM_MMU500_ACTLR_CPRE;
-		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
-		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
-		if (reg & ARM_MMU500_ACTLR_CPRE)
-			dev_warn_once(smmu->dev, "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
+	if (major < 2 || (major == 2 && minor < 2)) {
+		for (i = 0; i < smmu->num_context_banks; ++i) {
+			reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+			reg &= ~ARM_MMU500_ACTLR_CPRE;
+			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
+			reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+			if (reg & ARM_MMU500_ACTLR_CPRE)
+				dev_warn_once(smmu->dev,
+					      "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
+		}
 	}
 
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog



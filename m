Return-Path: <linux-kernel+bounces-575040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A3A6ECC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380FB16FCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE725B690;
	Tue, 25 Mar 2025 09:36:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DE25B681;
	Tue, 25 Mar 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895408; cv=none; b=juPMsC3kfs0UAIrUBKad9E1XLWe9gLUXLnaELJQ/hAQeGjRTXhSSy9kFQPfqdqLva0aSHahj0jTNpzFBjKI5znxFo6Uwhje6HZe98/xkMd7udQq8WHdo7wOSdAS5xysP9S+EX+DUAq0NxJVhQzysxU/YvWYYHwQ2YE8rTe414H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895408; c=relaxed/simple;
	bh=1EjsuXTQfqF+sCmAZkUf4HSAiiysZCROH9jJou8ve5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUaCw96H1sGk+KD86Sk9I1vZ1AKbjEhR1KdRr+Tfo5qrWxbpaM/zWtfaayg5BfrCC/0mVe0Z8hvbuhltDSR8fJ3iZDcAgwk6yMNALpIKjJ2LKP4smJrvBWVL1BIByVO7JpP5uaydmZKF6fYLKnDnx5sXHiWU7wOte1Cj81iKR5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E3951C2B;
	Tue, 25 Mar 2025 02:36:52 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13FF73F63F;
	Tue, 25 Mar 2025 02:36:41 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	akpm@linux-foundation.org,
	ardb@kernel.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	baohua@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v5 2/3] iommu/arm: Add BBM Level 2 smmu feature
Date: Tue, 25 Mar 2025 09:36:24 +0000
Message-ID: <20250325093625.55184-3-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325093625.55184-1-miko.lenczewski@arm.com>
References: <20250325093625.55184-1-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For supporting BBM Level 2 for userspace mappings, we want to ensure
that the smmu also supports its own version of BBM Level 2. Luckily, the
smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
0487K.a D8.16.2), so already guarantees that no aborts are raised when
BBM level 2 is claimed.

Add the feature and testing for it under arm_smmu_sva_supported().

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9ba596430e7c..6ba182572788 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -222,6 +222,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 		feat_mask |= ARM_SMMU_FEAT_VAX;
 	}
 
+	if (system_supports_bbml2_noabort())
+		feat_mask |= ARM_SMMU_FEAT_BBML2;
+
 	if ((smmu->features & feat_mask) != feat_mask)
 		return false;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..dcee0bdec924 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4406,6 +4406,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (FIELD_GET(IDR3_RIL, reg))
 		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
 
+	if (FIELD_GET(IDR3_BBML, reg) == IDR3_BBML2)
+		smmu->features |= ARM_SMMU_FEAT_BBML2;
+
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..85eaf3ab88c2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -60,6 +60,9 @@ struct arm_smmu_device;
 #define ARM_SMMU_IDR3			0xc
 #define IDR3_FWB			(1 << 8)
 #define IDR3_RIL			(1 << 10)
+#define IDR3_BBML			GENMASK(12, 11)
+#define IDR3_BBML1			(1 << 11)
+#define IDR3_BBML2			(2 << 11)
 
 #define ARM_SMMU_IDR5			0x14
 #define IDR5_STALL_MAX			GENMASK(31, 16)
@@ -754,6 +757,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HA		(1 << 21)
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
+#define ARM_SMMU_FEAT_BBML2		(1 << 24)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.48.1



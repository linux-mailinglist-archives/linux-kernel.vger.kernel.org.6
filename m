Return-Path: <linux-kernel+bounces-443628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C609EFA61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E570C1894778
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98E223C7A;
	Thu, 12 Dec 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6IN6uDX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257E223E69
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026697; cv=none; b=IVKZDkmZEpHYQevJPz4qN54dB2QOaJo0p6U2HUu81p+Kv1vdGgYXVNTMtu9TEKoNDd9pSkJ1E1PpXZo9g3o4HVlpRSJIrKjB0iG7Jga3z11F2dWjnFqXdB6NaKmPY1SMN91YdyX305vo4JK2OVvtHDhNSikhfmjf/lx0533GfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026697; c=relaxed/simple;
	bh=p/qYAp+a0yQJRLOSye/K8aHYd6t+T9vmVjY6IoSMRKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TWBKpWtQ7vCRvjeXWHSkI+IiZkTtYCnoH2+jnVOB5l9pWmJZYxZiNo0YjIMlNtmuIIxRos4VoY/Hnnb0kp1VheqNgEp/FXFTeiSlzaNQ38qopy7uikzdkGRhaYJ6vfz1Y3C0dc6uOfG4UHneVMCqe/gEKO90mydGBvbpChwauj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6IN6uDX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434efe65e62so5715825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026694; x=1734631494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wR1p8S8LwPyQNTvUjkaWT5KmeMMzb+jLodOVwCBm1UI=;
        b=Q6IN6uDXUj3I9eeA1EH4UFVmtfKXl3aF1KbcVCaAGMlog8oSiebcIpUAtQiRcDWaDO
         iS5gBiHoOS0sEAb/06MZ5oZkhzgaw1OdFU2600QgNwwMclCzynchLXVCzxVt3t9LccKb
         NZjv//UZlNutU2uPhb/Tl1pJoOW5qVupa7xl2GcWnr1pue3RA0nspXhIl4QQWdQc3tWL
         /8ScLb/ljX61rOgubDK2dkkBCjbatPVEMCiWa06R6YY3nOR9FzDvw2PcPFgbkR5xcbWn
         O6mHA91LxdOi5jhlZooy4lVgCtjouWLn9JuP41bGaD6j/ZJQW5aqVm/7fwuLxeVzste5
         OOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026694; x=1734631494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR1p8S8LwPyQNTvUjkaWT5KmeMMzb+jLodOVwCBm1UI=;
        b=ZkUB4aYZFdbXThGur+SHWfprHt4ZA11gEn1H/heSQRWs+rXcKArrfuP8nw3k8nFhvg
         gl4sKBSp11i3o2+u4E9ML5lT9588En58byOd4NTMX+lHbFa47HTcrTyS6Q7iMGFAXhgU
         fv7w+SUvgBvnBnCrnKWhlwwNakcZQw6DnndIG4bB/L7BFyuQNDQ0/hUd0SLvSmNsqbz0
         0mADZ+l6WsDpWaAxyToPy/3QG4YxIj1tk0axExyvhLauv2d8gIRaS8tZhJr3RQZqgk+x
         098GAo8m3Rt0RylHkEJY3JNPSx1lARWLv17IJneUJsPiHFoyS+PpPAP88aExJp86w+/w
         IXsg==
X-Forwarded-Encrypted: i=1; AJvYcCXeF0mXvsd1V2OUk2cD3lcGNA69HgXi+BY1cO/pM1qpGThMrngjH3QE3xoYNpQQHFCN7f6BgekmZg71F6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27HIAgu9tUhvOJ8Zx8FJFUBl2BPp0n2iOru16J4/SJMvUMG6P
	CItQsrp1x2Tp7pBTqdOLnu5VqgU6OxnfjkuvsCORE183xuENh3Qg6PaQ8R/HXW6T5dpU6vf0OZ0
	2Sr5TffXhxA==
X-Google-Smtp-Source: AGHT+IGngLUe7hTwqwYMuDaVTAngV7BbFyaM98e5ARjhrfPTg7ZpE0c7NHe9zxYUAMAR9O6PlwiwJtr/rnZAWw==
X-Received: from wmbjl5.prod.google.com ([2002:a05:600c:6a85:b0:434:f119:f1a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b09:b0:436:1b7a:c0b4 with SMTP id 5b1f17b1804b1-4361c3454dbmr64162005e9.1.1734026694237;
 Thu, 12 Dec 2024 10:04:54 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:29 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-6-smostafa@google.com>
Subject: [RFC PATCH v2 05/58] iommu/arm-smmu-v3: Extract driver-specific bits
 from probe function
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

As we're about to share the arm_smmu_device_hw_probe() function with the
KVM driver, extract bits that are specific to the normal driver.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..702863c94f91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4167,7 +4167,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	if (reg & IDR0_MSI) {
 		smmu->features |= ARM_SMMU_FEAT_MSI;
-		if (coherent && !disable_msipolling)
+		if (coherent)
 			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
 	}
 
@@ -4316,11 +4316,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		smmu->oas = 48;
 	}
 
-	if (arm_smmu_ops.pgsize_bitmap == -1UL)
-		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
-	else
-		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
-
 	/* Set the DMA mask for our table walker */
 	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
 		dev_warn(smmu->dev,
@@ -4334,9 +4329,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	arm_smmu_device_iidr_probe(smmu);
 
-	if (arm_smmu_sva_supported(smmu))
-		smmu->features |= ARM_SMMU_FEAT_SVA;
-
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
 	return 0;
@@ -4606,6 +4598,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (arm_smmu_sva_supported(smmu))
+		smmu->features |= ARM_SMMU_FEAT_SVA;
+
+	if (disable_msipolling)
+		smmu->options &= ~ARM_SMMU_OPT_MSIPOLL;
+
+	if (arm_smmu_ops.pgsize_bitmap == -1UL)
+		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
+	else
+		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
+
 	/* Initialise in-memory data structures */
 	ret = arm_smmu_init_structures(smmu);
 	if (ret)
-- 
2.47.0.338.g60cca15819-goog



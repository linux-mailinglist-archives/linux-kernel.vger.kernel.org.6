Return-Path: <linux-kernel+bounces-443632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB49EFA65
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972E2173AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838622969A;
	Thu, 12 Dec 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnPAGyRy"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261F229123
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026706; cv=none; b=EmC69rcwYsM6s/8zV58AbUL6n7s/9JT0DKdzN6ZOJ01Qf58/LxEJzQJlQQ0Oqq8QlihRVoy9pApgsGvqXamsaPX0InLAPT2ouQQ1vPHyDvc3XBSsYW3GG9Sc1UIUiT3lXnKM3ksNbZS6tSrGUwrVYTzfGy7pBiHWDdyHNf8Loz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026706; c=relaxed/simple;
	bh=s41qDBeIfR+pyi6L0VZtpKA+UqenXrCMsBsTuT0BQaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B6mfGaFgKOVI0eaPMErFqr/u2j29Yblerjaslzn9ekXb9Ys9q0veqxniisHQmk+iyDgyOKGlEHpRaTGrXxQ7Ja6D0H3zELF9W5++gsXvq2Q/aDHKBBQs8SUIXSkR2G9gdTFBSPRGjx4CF2C9rI7PTF2cKBJXaQBAID5bXB3hLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnPAGyRy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso5504595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026702; x=1734631502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRlluNjB7B7yhqcQsTcc7WzSgCbMOzbSDkNF00y+zZQ=;
        b=PnPAGyRyyUAGOGJTR+VGajaw44Oc5apJNcCA5H4dICriWBR+gyZVxOvi/rap10cmQ2
         I2vIkHoq1EWufHNZ3dFEJ6ZFocznQKc1UUjBydY/Th0tot3rv3/hSovlhP7/uyu4Ixoj
         44xoPcy2RbXGkciZdSv/JskU8xrw082zHUhEdsz3+kYG8ceJ7gdhcjARrCy25FOISXMX
         NWgKv84lXavgEGIHZ+bKqVtn43YbI6Fy2uIhs4HKVHzkv2rfCyEnyfaD/m2cuFAAYJOE
         xhenYR44RSEoe5gPq74vlH3IDYxfKzJhvvVS8NZplW0+Gn/WvfoBOCJdx4aNYiKL/rBy
         hfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026702; x=1734631502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRlluNjB7B7yhqcQsTcc7WzSgCbMOzbSDkNF00y+zZQ=;
        b=QeKcTjOic51HlZJt7dSSR9y9J3L8mphdmtMwoFjs3PT5YyEhBOLekC5WPX7QT3bgnb
         UlWfYaUJH64OkLKkTTC1O6xH0A+nRD+qeftPp11DwEdGtFWA9UBuZJZ4dtzUjq+H9Jjt
         ki6jDyUYA2Zu6Dqz54BJwJjuUiMKYsW8UK+4o108gu8d8YG4N36GD/65Y1gJ0KfUfJyK
         ki7ITuD1R5ou46BdzwyCSkX1wz6HUPSbvuGNk8GEP85OyvGgTImSc1qS8atUUX5XQOt6
         dzKQfDLwrKvp3yK6ipc8BMdpbH7OjepCSzKfvE/pdGMbtZTpuunP7HpehZ3yD9iKyZwG
         awyg==
X-Forwarded-Encrypted: i=1; AJvYcCUy62OFFhWlu4JhtpJfXUfaownQV2yWtmjVv02YNjEs1rWZ7/iOTANiKZp0hPpXAKHfqmUBXPfnfETBTh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UGxShR+17d+k7NVKgeaFVXl4NTAz88whk0KF1DyE9K02GML1
	YbeQYtT31QmyowYcgeMMg1umkjLjjIZISf/VCADuj/d0dnEqWoeEp+t3M0EHeVHYbg3P+9ISK2W
	A/m/9MIPYiw==
X-Google-Smtp-Source: AGHT+IG8R7L09stXwqH3oYXhWOZy4o2kVZLVIfQiCvS7+nSVYxh7Lqp6AmiQAmgplzW2b5ucEblLkxA9Ex8Hjg==
X-Received: from wmik26.prod.google.com ([2002:a7b:c41a:0:b0:434:f801:bf67])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b94:b0:434:f2bf:1708 with SMTP id 5b1f17b1804b1-4361c34672amr67605075e9.7.1734026702619;
 Thu, 12 Dec 2024 10:05:02 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:33 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-10-smostafa@google.com>
Subject: [RFC PATCH v2 09/58] iommu/arm-smmu-v3: Move IOMMU registration to arm-smmu-v3-common.c
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

The KVM driver will need to implement a few IOMMU ops, so move the
helpers to arm-smmu-v3-common.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-common.c      | 27 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 17 ++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +++
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
index 04f1e2f1c458..b7bcac51cc7d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
@@ -645,3 +645,30 @@ void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 		       smmu->base + ARM_SMMU_STRTAB_BASE);
 	writel_relaxed(reg, smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 }
+
+int arm_smmu_register_iommu(struct arm_smmu_device *smmu,
+			    struct iommu_ops *ops, phys_addr_t ioaddr)
+{
+	int ret;
+	struct device *dev = smmu->dev;
+
+	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
+				     "smmu3.%pa", &ioaddr);
+	if (ret)
+		return ret;
+
+	ret = iommu_device_register(&smmu->iommu, ops, dev);
+	if (ret) {
+		dev_err(dev, "Failed to register iommu\n");
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ret;
+	}
+
+	return 0;
+}
+
+void arm_smmu_unregister_iommu(struct arm_smmu_device *smmu)
+{
+	iommu_device_unregister(&smmu->iommu);
+	iommu_device_sysfs_remove(&smmu->iommu);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 91f64416900b..bcefa361f3d3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3980,27 +3980,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 
 	/* And we're up. Go go go! */
-	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
-				     "smmu3.%pa", &ioaddr);
-	if (ret)
-		return ret;
-
-	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
-	if (ret) {
-		dev_err(dev, "Failed to register iommu\n");
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return ret;
-	}
-
-	return 0;
+	return arm_smmu_register_iommu(smmu, &arm_smmu_ops, ioaddr);
 }
 
 static void arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	iommu_device_unregister(&smmu->iommu);
-	iommu_device_sysfs_remove(&smmu->iommu);
+	arm_smmu_unregister_iommu(smmu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
 	ida_destroy(&smmu->vmid_map);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2d658f15973a..63545fdf55f9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -349,6 +349,10 @@ void arm_smmu_write_strtab_l1_desc(struct arm_smmu_strtab_l1 *dst,
 				   dma_addr_t l2ptr_dma);
 void arm_smmu_write_strtab(struct arm_smmu_device *smmu);
 
+int arm_smmu_register_iommu(struct arm_smmu_device *smmu,
+			    struct iommu_ops *ops, phys_addr_t ioaddr);
+void arm_smmu_unregister_iommu(struct arm_smmu_device *smmu);
+
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
-- 
2.47.0.338.g60cca15819-goog



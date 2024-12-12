Return-Path: <linux-kernel+bounces-443678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88D9EFAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442541884074
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41A242ABE;
	Thu, 12 Dec 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkDCjr8D"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF173242A8A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026799; cv=none; b=boVrrKYVmL3Bw06M+y1XWKI3logY8Y6bnVo9UvyNlEL2Vk/AKv42ogi7ZgXgjVf2R8t/bJnfhLqb7EjPBHnV4eKB61l9qRUbxQF52jtcUx4ezm4OqNHzT61QDv3sYtFh0ISKMLquMgaxJ9iboWZob5V26g5Ed0IdBIdB5GLwNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026799; c=relaxed/simple;
	bh=roqaVNS4k1507yPlF6ISRHLKuQfgC3toJn6r6QoUTyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggCzvomU/qu9kC6nou8JrC04xFfSuF6T61EAotQ2QedbY04QnAY2Sd5W/VBsbbveXzB7tluxSjBKnlxLxnNn0h6rLUXfPZHRBqMsNe6oCCxCKXIzABtw3Ekk5/yD/u/nWhpJkQmEW1JgYFB+PmzWljutOgFTSl69tCA02MEl6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YkDCjr8D; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43619b135bcso5529765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026796; x=1734631596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nir/8Fu9wro0KzAUocadSL8VHwLHRc3vCT5pzOEHxAw=;
        b=YkDCjr8DQHKQ0wwl/aeGvctP5NoiSiG0zLlP6t+C076Iv6wiJ4Y5o4YlXkJgZ2EU8M
         j1HkoeAuZTNw+2ry7eMcGzQ+kLSAJgO8C1mbVUvKfZlynaU7Ieu3dY4ksW239+Y9il/l
         B7cPahpKe9KT5BGum9VpedMGnGjT5SdDKM5Se4oULaSljO8i5X54c2NFqAC8S1Gh8L5B
         QFX8qOkZaTQz9zArQBW53JWv8W44D7lenhgVXNPXRXnzku3RtAkGraDLByzn4dk1fAT9
         7oP+AuJENfs4BLcr0xfLy9f8yJQyuk0R0+n7dWig4EJ1BC0lTgGJ1QBvamB4EHuwUQFl
         Ea4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026796; x=1734631596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nir/8Fu9wro0KzAUocadSL8VHwLHRc3vCT5pzOEHxAw=;
        b=XHAnwzkf7ZsON/zwtogicVvYb6KZkliA5A19uUhGqQTMlZpeoIEc0bVnElMAex/nLh
         26TDR+r1U3LgGdXJDRqzEWyUZnyeof0CsJnUg8ISyz3DzsM3yNgs1LqyMDDnAMxl5Ueb
         MYGffIZr6qCFxp0ZxkLz8pZ63JNDyhFhSldvDF4WQsGOxqQu9QhXiNPsGkSNxQIjXrEy
         bmj6J0HdFpCgKZRenqZR5Ax1iVNKp9CKy22ig/8cXCEOH0j8Nqusz8GcnLwVQYsiCKco
         UYlwp/ZX4C2P6aKQJJi68B9N7UUX/LLDPo0iG+42nBTtrWrAN0sNkXi8IL8m90CNYCZG
         I2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAUiRjenyyiJ5AhMrvV/mtDWY0y7W0W0NtMtLUVOtcPqKM3bE2J65SGIzjuXo3AgAT68wIbdUjlphNpHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFFv8TgcF0GSMpfktH1syF/v10tnc4K2Oeg8J9w05StGCzrCV
	M/dhUweng7EMvRUaO9nx1LUFbRLvQdWGaZKUy/tvSnXj5s8E8kHSj/aeU0rRLDefKd0+sh6795z
	TdSDImbrkXA==
X-Google-Smtp-Source: AGHT+IHRdZKXYWudkhhkQrQvejC9zCICHCvy3HiUQiQs1K09RQKbLBrbkNDh+wOO04CX03Sxp7dykFRKXpwfSw==
X-Received: from wmgg15.prod.google.com ([2002:a05:600d:f:b0:434:feb1:add1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d20:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-4361c36f5ccmr81464315e9.10.1734026796519;
 Thu, 12 Dec 2024 10:06:36 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:18 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-55-smostafa@google.com>
Subject: [RFC PATCH v2 54/58] iommu/arm-smmu-v3-kvm: Enable runtime PM
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

Enable runtime PM for the KVM SMMUv3 driver. The PM link to DMA masters
dictates when the SMMU should be powered on.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index deeed994a131..e987c273ff3c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <kvm/arm_smmu_v3.h>
 
@@ -127,6 +128,12 @@ static struct iommu_device *kvm_arm_smmu_probe_device(struct device *dev)
 	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
 	xa_init(&master->domains);
 	dev_iommu_priv_set(dev, master);
+	if (!device_link_add(dev, smmu->dev,
+			     DL_FLAG_PM_RUNTIME |
+			     DL_FLAG_AUTOREMOVE_SUPPLIER)) {
+		kfree(master);
+		return ERR_PTR(-ENOLINK);
+	}
 
 	return &smmu->iommu;
 }
@@ -818,6 +825,14 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	hyp_smmu->iommu.power_domain = host_smmu->power_domain;
 	kvm_arm_smmu_cur++;
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	/*
+	 * Take a reference to keep the SMMU powered on while the hypervisor
+	 * initializes it.
+	 */
+	pm_runtime_resume_and_get(dev);
+
 	return arm_smmu_register_iommu(smmu, &kvm_arm_smmu_ops, ioaddr);
 }
 
@@ -826,6 +841,8 @@ static void kvm_arm_smmu_remove(struct platform_device *pdev)
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 	struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
 
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	/*
 	 * There was an error during hypervisor setup. The hyp driver may
 	 * have already enabled the device, so disable it.
@@ -834,6 +851,30 @@ static void kvm_arm_smmu_remove(struct platform_device *pdev)
 	arm_smmu_update_gbpa(smmu, host_smmu->boot_gbpa, GBPA_ABORT);
 }
 
+static int kvm_arm_smmu_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
+
+	if (host_smmu->power_domain.type == KVM_POWER_DOMAIN_HOST_HVC)
+		return kvm_call_hyp_nvhe(__pkvm_host_hvc_pd, host_smmu->id, 0);
+	return 0;
+}
+
+static int kvm_arm_smmu_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
+
+	if (host_smmu->power_domain.type == KVM_POWER_DOMAIN_HOST_HVC)
+		return kvm_call_hyp_nvhe(__pkvm_host_hvc_pd, host_smmu->id, 1);
+	return 0;
+}
+
+static const struct dev_pm_ops kvm_arm_smmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(kvm_arm_smmu_suspend, kvm_arm_smmu_resume, NULL)
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
@@ -843,6 +884,7 @@ static struct platform_driver kvm_arm_smmu_driver = {
 	.driver = {
 		.name = "kvm-arm-smmu-v3",
 		.of_match_table = arm_smmu_of_match,
+		.pm = &kvm_arm_smmu_pm_ops,
 	},
 	.remove = kvm_arm_smmu_remove,
 };
@@ -877,6 +919,12 @@ static void kvm_arm_smmu_array_free(void)
 	free_pages((unsigned long)kvm_arm_smmu_array, order);
 }
 
+static int smmu_put_device(struct device *dev, void *data)
+{
+	pm_runtime_put(dev);
+	return 0;
+}
+
 static int kvm_arm_smmu_v3_init_drv(void)
 {
 	int ret;
@@ -905,6 +953,7 @@ static int kvm_arm_smmu_v3_init_drv(void)
 	 */
 	kvm_hyp_arm_smmu_v3_smmus = kvm_arm_smmu_array;
 	kvm_hyp_arm_smmu_v3_count = kvm_arm_smmu_count;
+
 	return 0;
 
 err_free:
@@ -931,4 +980,21 @@ static int kvm_arm_smmu_v3_register(void)
 					kern_hyp_va(lm_alias(&kvm_nvhe_sym(smmu_ops))));
 };
 
+/*
+ * KVM init hypervisor at device_sync init call,
+ * so we drop the PM references of the SMMU taken at probe
+ * at the late initcall where it's guaranteed the hypervisor
+ * has initialized the SMMUs.
+ */
+static int kvm_arm_smmu_v3_post_init(void)
+{
+	if (!kvm_arm_smmu_count)
+		return 0;
+
+	WARN_ON(driver_for_each_device(&kvm_arm_smmu_driver.driver, NULL,
+				       NULL, smmu_put_device));
+	return 0;
+}
+
 core_initcall(kvm_arm_smmu_v3_register);
+late_initcall(kvm_arm_smmu_v3_post_init);
-- 
2.47.0.338.g60cca15819-goog



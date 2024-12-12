Return-Path: <linux-kernel+bounces-443668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5B9EFA97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364661889450
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD123EA78;
	Thu, 12 Dec 2024 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asEUHOLZ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF423EC0A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026779; cv=none; b=tXLmuRXgJBQXhpW6HVgW7CbB8jVPNMCSJsJ8up06iB57N4apxc/WiW0KHiypFknsHmSyQk4irQR1X2LU3klLTGqMJc3l0UIWmwZsFfLlmXGG3l/TNooxkgAxjg4yVbF8BzoenCnXGCIVbuqDbPcQJY1C32jmRWxnazk4mSpBNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026779; c=relaxed/simple;
	bh=nldh58rc77hsjw5gSEOSIIELaTF6Cfi2Rvy9VG/QlTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J52gyF0sRJpF1ziXC6bZrHwfHOmlFJmaKUno+VUd1V6/RxEyrjp47sazhbw6Aw5LPBRAo9osn6VqYgAnEuRz1YXvHljcFDxIQd+VXqjvkGPKnzuOjWyfjLEpnSr0esnyiCZTFB9Wx/TBkD9oFpfQaqZpxCZORJaFlrfLF+vu0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asEUHOLZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43627bb20b5so4510965e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026776; x=1734631576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyTqVJhMppnYdv5NSdPsxpiQh63AvYUQ+byd2sEa6to=;
        b=asEUHOLZRD/veHsQr5lNN2UybR5UwEbq3nx/X2fWiHqL8eps7HJ0q0zEkSTuzhU3H3
         aiJYnlHJMA1pNDUL0RvqRxv4SV0sdSg4cTMj7s6ssLpl00s9saYfxItTn10fhmgE4IFK
         ES4A/8vgFlTw64g+x9Kr8+8eAsHHNkTkzc0YO4gY3bT6vk/TTIOpXcC0C7aXZtZrXvdx
         pspIrHcsdPqmKoSKFI4K0ge0pHUupuCJJGGUG6lX+OJ7scUH4Z3lDj1dLhtLmtjiSTGo
         hox81I5IIDi/au0rxg6vT//4LvPttcyzRX4moA89xy9e0TMNrxZG95KqzIX24911S83U
         UOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026776; x=1734631576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyTqVJhMppnYdv5NSdPsxpiQh63AvYUQ+byd2sEa6to=;
        b=EDEOtpbj0eF2kWSxriw5DExpHLY4osDLs0Ls+t2qkESChJc6C5JJTCGXq/rSA/JBn2
         GpWT2zYdWHfZP1DpoH5BJkWYhKnAtlbPbQQabvYuVX/oZIX51wpyWIklwlhPiWucMf5+
         MNaG/UPziextxBnBK+cidGkoxc/WRum3SyY68ltIHVvgfZx7Ta6DhRg96kxYt3KgK5/j
         4nty+iGuxjC6eEXeXgbERuGcOuiYHncp6fcYiLmrH6/Qo/qTZNhP9HK4y2g/cRrDofP8
         qCpWDJj4RwA2OFMDOqf2emwvjvpDrBEzx3OtVVUtKGHJ3NE8jSISY002TAd5jvnBhbCU
         MmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj9OvyF0mkw72sBSqZuvRR0MfmQF9D0XCjvStlm8qnRYEPh+sAipthvUWNFwrLvtqEnVftw8pAll61L40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJR2cyVpUP6PLnEtdDaRhCbXqhEhaGCZznDRWxaKpPR+RmwKpp
	mn0rm8FcFeh350YD8EhW4Ke/JGf1ynaHyH8LCOugr3v/0Rldezya5lC3hXq/klg0nBDDLnW+hnb
	FZVHdRfoALA==
X-Google-Smtp-Source: AGHT+IFG8WA1Z2ObHa4JSTh7ZOJd26fn3uY6Vzk1iSlEnJuugWr6UhUgo2xrrDlr60JHvwlglh6D+X+h9Bswrg==
X-Received: from wmgf12.prod.google.com ([2002:a05:600c:154c:b0:42c:bfc2:aa72])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64af:0:b0:385:f7ea:eb86 with SMTP id ffacd0b85a97d-38787685119mr4003192f8f.7.1734026775884;
 Thu, 12 Dec 2024 10:06:15 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:08 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-45-smostafa@google.com>
Subject: [RFC PATCH v2 44/58] iommu/arm-smmu-v3-kvm: Validate device features
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

The KVM hypervisor driver supports a small subset of features. Ensure
the implementation is compatible, and disable some unused features.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index e2d9bd97ddc5..4b0c9ff6e7f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -27,6 +27,45 @@ static size_t				kvm_arm_smmu_cur;
 static size_t				kvm_arm_smmu_count;
 static struct hyp_arm_smmu_v3_device	*kvm_arm_smmu_array;
 
+static bool kvm_arm_smmu_validate_features(struct arm_smmu_device *smmu)
+{
+	unsigned int required_features =
+		ARM_SMMU_FEAT_TT_LE;
+	unsigned int forbidden_features =
+		ARM_SMMU_FEAT_STALL_FORCE;
+	unsigned int keep_features =
+		ARM_SMMU_FEAT_2_LVL_STRTAB	|
+		ARM_SMMU_FEAT_2_LVL_CDTAB	|
+		ARM_SMMU_FEAT_TT_LE		|
+		ARM_SMMU_FEAT_SEV		|
+		ARM_SMMU_FEAT_COHERENCY		|
+		ARM_SMMU_FEAT_TRANS_S1		|
+		ARM_SMMU_FEAT_TRANS_S2		|
+		ARM_SMMU_FEAT_VAX		|
+		ARM_SMMU_FEAT_RANGE_INV;
+
+	if (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY) {
+		dev_err(smmu->dev, "unsupported layout\n");
+		return false;
+	}
+
+	if ((smmu->features & required_features) != required_features) {
+		dev_err(smmu->dev, "missing features 0x%x\n",
+			required_features & ~smmu->features);
+		return false;
+	}
+
+	if (smmu->features & forbidden_features) {
+		dev_err(smmu->dev, "features 0x%x forbidden\n",
+			smmu->features & forbidden_features);
+		return false;
+	}
+
+	smmu->features &= keep_features;
+
+	return true;
+}
+
 static int kvm_arm_smmu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -71,6 +110,9 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (!kvm_arm_smmu_validate_features(smmu))
+		return -ENODEV;
+
 	platform_set_drvdata(pdev, smmu);
 
 	/* Hypervisor parameters */
@@ -79,6 +121,7 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	hyp_smmu->ias = smmu->ias;
 	hyp_smmu->mmio_addr = ioaddr;
 	hyp_smmu->mmio_size = size;
+	hyp_smmu->features = smmu->features;
 	kvm_arm_smmu_cur++;
 
 	return arm_smmu_register_iommu(smmu, &kvm_arm_smmu_ops, ioaddr);
-- 
2.47.0.338.g60cca15819-goog



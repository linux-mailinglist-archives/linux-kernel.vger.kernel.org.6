Return-Path: <linux-kernel+bounces-443647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3E9EFA66
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4D328BF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58BC22541E;
	Thu, 12 Dec 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdaLYQLN"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB0235C33
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026735; cv=none; b=qpW1feH8wUC7+n5d5J+wqWsMfMb/03eRiSxwmMc2RFYaElv+5rszITiLzl2R7GYRWNLKrES/LRcN2wUh44slWHYc0F2ImDXJBmpFM/TPQf0qECfTgqFVa9GwlIqNgagnznwqGUFrtWfo8zvC2tBk/jt5hXPmRPD0jVIgUHFoUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026735; c=relaxed/simple;
	bh=LQ7osqA/9T45zp9pKA7tsvG8dh0AD4hAzw8bzt47krI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGuqmniSZa+M5Fyc5eBr6yEPVHG7VRa6P22skyrozDE+e780bkCALPqvdeg/Pb6IrlIf0+VJhyh4elv4NH+YUQZd1RqWhI0oATD8DfLX+srAtcv6RYxEdC26La66X2mlTEsLOLvLxPNBE/nThOq1JdfwfsyR2XIN2M79ID+cCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdaLYQLN; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385d735965bso542710f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026732; x=1734631532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNmbzxfQZlpDuPsHWgM61suzSUM5uzL/JDk4UedkmbE=;
        b=NdaLYQLN+1PSDeMJx+ET3ZuhU3Z9uU3nu4KGAMFIDr6e6oYN8YRSJ3dDXfLG7vA3ZU
         VFf9ROZKn26sELHu4bhIqpYQ5i1nzHYZXb5N5hNSek9XvXUUFci8THLw8emcMqjN3Zuy
         qluZVr03OoaSz4N1sVUmQ0M9Hx04GYXzfZJpkNBqf6KlHVSvGA8R9FyM/WLqv1SHP98j
         3MrCl3NFI7+G45kbbosBx2bxsLP6dOz2CsW7hGNwJc7cI2P8GaDwv2/3+gOqSNh1LJKN
         xIDisW8MkPIC97h/a4nv03qEARljMgEqjORRmO4B6ZY9aeIC7nTmXnJWQCCt+2195sGB
         Ie7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026732; x=1734631532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNmbzxfQZlpDuPsHWgM61suzSUM5uzL/JDk4UedkmbE=;
        b=psJefqR8E1BkDh7hmgYaUidDkGBANqvO/aulQjmsXwxHbucxiQzqDXXNiKz/nNwry1
         S5Tjg5MagXjwXK3/NKwPP7uUr8H6OgVOEO0pqa6qJA58JdYtNXl9vPK+OJmisa0RNu5n
         aReHOqCoeq4xnvrtOsjAkSIHYj4lZuys7bLY6wNL5l5fuW3YrDYPmMQYWOMVHad5ztOY
         0gcoZUBXZkrP+DvqZH1orxOc7Pmg9Xo7mWXrOjVmUMpZx4/zi6Mqpg+Sp6h6YYa3RvaC
         rxdy8v6DuuG58E4zBePeieaEbQaAcHDkLn7qJQxGVYMRGxDq6GQuMEwF8YP/t5L9v7xc
         kFbA==
X-Forwarded-Encrypted: i=1; AJvYcCWyZG0AS2F+eZhelweJcseovZtEi1CJRBDAawV36QbTDEzGXdxf/byUbY8W0Pd+gjWzBm8nzbnBQ1O+1IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKL6/bLYi7zPSoUgEpil7VBYBEmKme3aevC3AFpB3u/Tup7eMA
	4yHJJHvrig1qVyWrJ98S6ZzM0H+qDLaTmjiZoMxV1O8MFVSGyk4p1uLSvjVRfHUUrghRIYVDy8c
	cQdIMqS/I5w==
X-Google-Smtp-Source: AGHT+IG5u7MltLTltlnPqAoPYJ0zedPyLXzvE96q5dJmxhMlV9Kb2g6bQvckMYIYAkBMBY1CEWyusiJQB7JM4g==
X-Received: from wmnb15.prod.google.com ([2002:a05:600c:6cf:b0:436:1995:1888])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2802:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-3864ce9f30amr4398431f8f.25.1734026731871;
 Thu, 12 Dec 2024 10:05:31 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:47 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-24-smostafa@google.com>
Subject: [RFC PATCH v2 23/58] KVM: arm64: iommu: Support power management
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

Add power domain ops to the hypervisor IOMMU driver. We currently make
these assumptions:

* The register state is retained across power off.
* The TLBs are clean on power on.
* Another privileged software (EL3 or SCP FW) handles dependencies
  between SMMU and endpoints.

So we just need to make sure that the CPU does not touch the SMMU
registers while it is powered off.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c | 33 ++++++++++++++++++++++++++-
 include/kvm/iommu.h                   |  3 +++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index a6e0f3634756..fbab335d3490 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -375,10 +375,41 @@ phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova)
 	return phys;
 }
 
+static int iommu_power_on(struct kvm_power_domain *pd)
+{
+	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
+						   power_domain);
+
+	/*
+	 * We currently assume that the device retains its architectural state
+	 * across power off, hence no save/restore.
+	 */
+	kvm_iommu_lock(iommu);
+	iommu->power_is_off = false;
+	kvm_iommu_unlock(iommu);
+	return 0;
+}
+
+static int iommu_power_off(struct kvm_power_domain *pd)
+{
+	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
+						   power_domain);
+
+	kvm_iommu_lock(iommu);
+	iommu->power_is_off = true;
+	kvm_iommu_unlock(iommu);
+	return 0;
+}
+
+static const struct kvm_power_domain_ops iommu_power_ops = {
+	.power_on	= iommu_power_on,
+	.power_off	= iommu_power_off,
+};
+
 /* Must be called from the IOMMU driver per IOMMU */
 int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu)
 {
 	kvm_iommu_lock_init(iommu);
 
-	return 0;
+	return pkvm_init_power_domain(&iommu->power_domain, &iommu_power_ops);
 }
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 6ff78d766466..c524ba84a9cf 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -3,6 +3,7 @@
 #define __KVM_IOMMU_H
 
 #include <asm/kvm_host.h>
+#include <kvm/power_domain.h>
 #include <linux/io-pgtable.h>
 #ifdef __KVM_NVHE_HYPERVISOR__
 #include <nvhe/spinlock.h>
@@ -51,6 +52,8 @@ struct kvm_hyp_iommu {
 #else
 	u32				unused;
 #endif
+	struct kvm_power_domain		power_domain;
+	bool				power_is_off;
 };
 
 #endif /* __KVM_IOMMU_H */
-- 
2.47.0.338.g60cca15819-goog



Return-Path: <linux-kernel+bounces-443648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6E9EFA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A37C18809DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D9235C51;
	Thu, 12 Dec 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkR2KeaX"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941B235C4A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026737; cv=none; b=e3eGB/ksOb7UmqOXWYGFtJn++3QayoXGTYN4bUyQYzcl9TGF/8Wa1L2qxWXOzWqmCJds+jze/PODZidvJU9nCwsm9V/WalBUuvc/ECrZ+XlZxhb+ICS72CGeCvDPAR0bNQNX6wqXSQxLQZOuil0ytvh2Q0CeHG4YsRqdnBeJY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026737; c=relaxed/simple;
	bh=QIyUf9RC5tml3wUiGzlbTmMFJHl3q8rlahMnK3AQH94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hwhYUHb2J6UBSRLsUViS35aDjbDVuKvejgAlLWJLoyvxd24GFQH7wBuMxtYQ7nff5HKHDmc70ZlpPnnFxIWzKCrXeDSOkwAZ5Frhw3GKVyrb0u4Lk2RPKeOt5NExEA1qeZX8OBlHoVD0bWXRG0hs8VSxHzFFdqm1DWE9DjMW2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkR2KeaX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43628594d34so2694115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026734; x=1734631534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZNgwB6X8v5j4gzxppU/t/fZqzqcDrO7o9YkYVnh2wA=;
        b=ZkR2KeaX+Z+QId8bD4jYvQ0/1IjdG5Qcd07yl8GZXDVUwqYTIiCLqA/SVZgNIl5TG7
         T65oyFPS2H65kdCpIPE55uP9LzThGMZ4y/iGis01G1uwhvyNvpBRiuFmf1lbo2oQnW2A
         3ZmEglzeB/tFmauVtBPuvMPETrVz/uC997gRuQC9lYBALozy9GwsoC1T5MuQV09T4MPJ
         WbK4uhP4Thd/hM0ubgSpCPwzCRhpT6SLfs5+Of8bt1bgwPDDTg0d0Job8P3HaCqzV1wR
         odwAChUiw+04XTKqJWbzeGWi97rw3yS3QnnfE1Y7XigDNCiDByqRa3IB0orvL5+PdQiZ
         46/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026734; x=1734631534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZNgwB6X8v5j4gzxppU/t/fZqzqcDrO7o9YkYVnh2wA=;
        b=v89+GpAGxEYn9j1r2vuzuN/kjRKPPkNhtsduAFv3aqFuKw+56iFM3gl2KfOyCwvxP6
         H/JdADIL+NzYfji4q/bq6jYlmDY7qMBvMPBQtSG+JrLJKYRk7oBPAyeacFeRe7Xv8aXA
         ZWCgWfvHU6/IN5xV/mx1qRVYAcVKQNCaz2By/tXY1XNL5wBWigBBYf3kn8kDJ3zweipO
         0u5iOrd6RLuCskjxK/eBczX1hpwD9M1L7IJ2TlgP4hUCqwcrJjilrNYQzIxUbzdtENnM
         YFQGajEbvfExGaUH0bmh4TD5TJ853MwgX+3+5d7AN1Ig+n0TyiaR3N0TZjAbxLMEkkk7
         +nJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWixd9qilnN33hM9lilhCngW6JCJCq3APJ799gv93rBHw9mxMUvTJIgIm0SX5wnn8I7sR8/XcqwmQpmb3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90e6PhsYeOcxAE++OZvlAPVbU+GDwaIgqC9EieBIbAGEMuEnn
	Z6nVIpQm7JdmwXDNsTzK1SP8D9IlF2jjrFdOeuWOko5MD2XiDJi/yY7nRpvkzU7khIH9RZdlhHP
	2suBsl9g4zQ==
X-Google-Smtp-Source: AGHT+IFU5A2xYG/aIaT/yYE5/fNPeYIneyer4lpXo+usrcm3VGdKeb0NPMFh6orkypYDcbhz8IOsQoPR+yxjUA==
X-Received: from wmmu14.prod.google.com ([2002:a05:600c:ce:b0:434:f0a3:7876])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3593:b0:434:f297:8e85 with SMTP id 5b1f17b1804b1-4361c3aaeeemr77507485e9.10.1734026733780;
 Thu, 12 Dec 2024 10:05:33 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:48 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-25-smostafa@google.com>
Subject: [RFC PATCH v2 24/58] KVM: arm64: iommu: Support DABT for IOMMU
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

Soon, SMMUv3 driver would be added and it would need to emulate
access to some of its MMIO space.

Add a handler for DABTs for IOMMU drivers to be able to do so.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  2 ++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 17 +++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c   | 19 +++++++++++++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 06d12b35fa3e..cff75d67d807 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -21,6 +21,7 @@ size_t kvm_iommu_map_pages(pkvm_handle_t domain_id,
 size_t kvm_iommu_unmap_pages(pkvm_handle_t domain_id, unsigned long iova,
 			     size_t pgsize, size_t pgcount);
 phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova);
+bool kvm_iommu_host_dabt_handler(struct kvm_cpu_context *host_ctxt, u64 esr, u64 addr);
 
 /* Flags for memory allocation for IOMMU drivers */
 #define IOMMU_PAGE_NOCACHE				BIT(0)
@@ -49,6 +50,7 @@ struct kvm_iommu_ops {
 	phys_addr_t (*iova_to_phys)(struct kvm_hyp_iommu_domain *domain, unsigned long iova);
 	void (*iotlb_sync)(struct kvm_hyp_iommu_domain *domain,
 			   struct iommu_iotlb_gather *gather);
+	bool (*dabt_handler)(struct kvm_cpu_context *host_ctxt, u64 esr, u64 addr);
 };
 
 int kvm_iommu_init(void);
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index fbab335d3490..e45dadd0c4aa 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -4,6 +4,10 @@
  *
  * Copyright (C) 2022 Linaro Ltd.
  */
+#include <asm/kvm_hyp.h>
+
+#include <hyp/adjust_pc.h>
+
 #include <kvm/iommu.h>
 
 #include <nvhe/iommu.h>
@@ -375,6 +379,19 @@ phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova)
 	return phys;
 }
 
+bool kvm_iommu_host_dabt_handler(struct kvm_cpu_context *host_ctxt, u64 esr, u64 addr)
+{
+	bool ret = false;
+
+	if (kvm_iommu_ops && kvm_iommu_ops->dabt_handler)
+		ret = kvm_iommu_ops->dabt_handler(host_ctxt, esr, addr);
+
+	if (ret)
+		kvm_skip_host_instr();
+
+	return ret;
+}
+
 static int iommu_power_on(struct kvm_power_domain *pd)
 {
 	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index a428ad9ca871..0fae651107db 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -16,6 +16,7 @@
 #include <hyp/fault.h>
 
 #include <nvhe/gfp.h>
+#include <nvhe/iommu.h>
 #include <nvhe/memory.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
@@ -799,11 +800,16 @@ static int handle_host_perm_fault(struct kvm_cpu_context *host_ctxt, u64 esr, u6
 	return handled ? 0 : -EPERM;
 }
 
+static bool is_dabt(u64 esr)
+{
+	return ESR_ELx_EC(esr) == ESR_ELx_EC_DABT_LOW;
+}
+
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
 	u64 esr, addr;
-	int ret = 0;
+	int ret = -EPERM;
 
 	esr = read_sysreg_el2(SYS_ESR);
 	if (!__get_fault_info(esr, &fault)) {
@@ -817,7 +823,15 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 	}
 
 	addr = (fault.hpfar_el2 & HPFAR_MASK) << 8;
-	ret = host_stage2_idmap(addr);
+	addr |= fault.far_el2 & FAR_MASK;
+
+	if (is_dabt(esr) && !addr_is_memory(addr) &&
+	    kvm_iommu_host_dabt_handler(host_ctxt, esr, addr))
+		goto return_to_host;
+
+	/* If not handled, attempt to map the page. */
+	if (ret == -EPERM)
+		ret = host_stage2_idmap(addr);
 
 	if ((esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM)
 		ret = handle_host_perm_fault(host_ctxt, esr, addr);
@@ -827,6 +841,7 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 	else
 		BUG_ON(ret && ret != -EAGAIN);
 
+return_to_host:
 	trace_host_mem_abort(esr, addr);
 }
 
-- 
2.47.0.338.g60cca15819-goog



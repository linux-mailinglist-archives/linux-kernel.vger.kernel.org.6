Return-Path: <linux-kernel+bounces-443670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410EA9EFA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2915A188DF65
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F823FA19;
	Thu, 12 Dec 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysVoAjf3"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD723F9F1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026783; cv=none; b=ctM8AxIgYnP4IOMUbd1CNGaVR9HVtzE3EmJDrk7qJKoQ8hAORo0tPQQQuXSl8q+krB2UeBP8nLf1Kg9SIfh7bXkobP0FDSkR3jsiZYBuh+kO4XDtisC1CkcbWWW2p2NeuMb7JN0sW7xdycehpl0+l0AFahY1MnlWVY7bLbfuvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026783; c=relaxed/simple;
	bh=EjhIv/oYPDXLgKafBR10ANdAhLD+MmwuWT2lvorilf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dpGwdEJ1ieKSTRXyW9emFZpI5qv6SAIpEF3BiXKCf2vIVGG8atoi+7oWyIoApj5pRQ4wvXV/FreGTnaPlWF39RJjfgCaHHi9N7r8r65EAoRA0M93SxWPgKO89WZc2+V9uSaVkg9+yjKB7NdIoW1sDdqb43EdOJYtHRznmS0YV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysVoAjf3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso8322165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026780; x=1734631580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=031HktvOH2BGPB/61CKgeoO+FWayRh3FpkimFP0IrdM=;
        b=ysVoAjf3o5BipKFb/axG9S+2Ht7r8/w2v4lneRo6xuOlsPQZi1bS6dC9+47aebO3xp
         Ca5lR4XpOrOs3Z/EhTIu6lc4BIMp7AfUVMWx9mF9UNEno26DyeJomB57PsRNISAszAYD
         GLIRy+jCKqSTJ7XipjXQchIhbK4aD8fXWGgw4+gtYBkNwMA1LRrfjHJq+83uwnPe9PVF
         WFFf0OMDd9Txa41Sian9bqy2MN9nfuQXbJSuK30vB9OE8FIc+m5/FRM14v2l/JOkDMox
         bEORC67l9qsA1Sb+fdlrVl8tGukXXHT36ixo4F+Dd/ANRmA33NrlLeBPD/RMfacqJG3X
         J28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026780; x=1734631580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=031HktvOH2BGPB/61CKgeoO+FWayRh3FpkimFP0IrdM=;
        b=J9ftmfCZ+HsYVNVqPqiSxuJf55VEW6ewJOZHnrPlsosIeU+Kyy6r2I8Z7jS7gRYRaQ
         VRe8ee81silOt3xOrPm2klLm+/0IXqXXlyt2n9xD1itgUyoLHBf3CKmJsrc57H2iT191
         GJwb6YbDK5j0E7zymqSFKxmoV9ov1hi6yXa3hFojYA9lCNX1Xj2A94iPQefWESnVexON
         RVUquvgTxoqgbHXsFGDwXfc0ST47+LIvFljhDSM2+EkeQT4WUHQOD/TumWbPhXGFG4xb
         DHnJu078daqvC7mISk6wohNwxqm8ilGi2DhxQ/+iLQdi73ZdxPc63g3Gfe6/pFVITr7u
         ijmg==
X-Forwarded-Encrypted: i=1; AJvYcCX3umtmEcRqOPueO8iZRXv2ynED4HJPPvcz6AALhfz3x/22gXdE6dGwpw+HaMsg6tF1RgTUR/YP/kbDqEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFO+NLCJCijjbkxS+QBOCEY4TLEggTzto57TNB6jvf+8VlM8Ku
	ROWwI3R6UL+TkuzGmGptiQWbgtN2nJk41A9JNiJoZT0+TOdbbeva6M/u2GRkHJ+9BFthAIv84Qf
	XBoPKq+fTGA==
X-Google-Smtp-Source: AGHT+IHfy5GSFaMJOYpvz35FVWeSJ2xaUjg6ph5uDhYTSNl0fSLoTlqEzHaAu45qIKjF2hF1Km0UhuK02XOy2w==
X-Received: from wmmr4.prod.google.com ([2002:a05:600c:4244:b0:436:1796:9989])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83cf:b0:434:f7e3:bfa0 with SMTP id 5b1f17b1804b1-4361c3e351fmr61389525e9.21.1734026780064;
 Thu, 12 Dec 2024 10:06:20 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:10 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-47-smostafa@google.com>
Subject: [RFC PATCH v2 46/58] KVM: arm64: Add function to topup generic allocator
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

Soon, IOMMU driver might need to topup the IOMMU pool from map_pages
IOMMU operation, which has a gfp flag is it might be called from
atomic context, add a function to topup an allocator with an ID
that also accepts gfp flags.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  4 ++++
 arch/arm64/kvm/mmu.c              | 20 ++++++++++++++++++++
 arch/arm64/kvm/pkvm.c             | 20 ++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a3b5d8dd8995..59a23828bd0e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -155,6 +155,8 @@ static inline void __free_hyp_memcache(struct kvm_hyp_memcache *mc,
 
 void free_hyp_memcache(struct kvm_hyp_memcache *mc);
 int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages, unsigned long order);
+int topup_hyp_memcache_gfp(struct kvm_hyp_memcache *mc, unsigned long min_pages,
+			   unsigned long order, gfp_t gfp);
 
 static inline void init_hyp_memcache(struct kvm_hyp_memcache *mc)
 {
@@ -1628,6 +1630,8 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define HYP_ALLOC_MGT_IOMMU_ID		1
 
 unsigned long __pkvm_reclaim_hyp_alloc_mgt(unsigned long nr_pages);
+int __pkvm_topup_hyp_alloc_mgt_gfp(unsigned long id, unsigned long nr_pages,
+				   unsigned long sz_alloc, gfp_t gfp);
 
 struct kvm_iommu_driver {
 	int (*init_driver)(void);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ef7e8c156afb..229338877c59 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1225,6 +1225,11 @@ static void *hyp_mc_alloc_fn(void *flags, unsigned long order)
 	return addr;
 }
 
+static void *hyp_mc_alloc_gfp_fn(void *flags, unsigned long order)
+{
+	return (void *)__get_free_pages(*(gfp_t *)flags, order);
+}
+
 void free_hyp_memcache(struct kvm_hyp_memcache *mc)
 {
 	unsigned long flags = mc->flags;
@@ -1249,6 +1254,21 @@ int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages,
 				    kvm_host_pa, (void *)flags, order);
 }
 
+int topup_hyp_memcache_gfp(struct kvm_hyp_memcache *mc, unsigned long min_pages,
+			   unsigned long order, gfp_t gfp)
+{
+	void *flags = &gfp;
+
+	if (!is_protected_kvm_enabled())
+		return 0;
+
+	if (order > PAGE_SHIFT)
+		return -E2BIG;
+
+	return __topup_hyp_memcache(mc, min_pages, hyp_mc_alloc_gfp_fn,
+				    kvm_host_pa, flags, order);
+}
+
 /**
  * kvm_phys_addr_ioremap - map a device range to guest IPA
  *
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index e6df35aae840..0c45acbbff6e 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -1114,3 +1114,23 @@ unsigned long __pkvm_reclaim_hyp_alloc_mgt(unsigned long nr_pages)
 
 	return reclaimed;
 }
+
+int __pkvm_topup_hyp_alloc_mgt_gfp(unsigned long id, unsigned long nr_pages,
+				   unsigned long sz_alloc, gfp_t gfp)
+{
+	struct kvm_hyp_memcache mc;
+	int ret;
+
+	init_hyp_memcache(&mc);
+
+	ret = topup_hyp_memcache_gfp(&mc, nr_pages, get_order(sz_alloc), gfp);
+	if (ret)
+		return ret;
+
+	ret = kvm_call_hyp_nvhe(__pkvm_hyp_alloc_mgt_refill, id,
+				mc.head, mc.nr_pages);
+	if (ret)
+		free_hyp_memcache(&mc);
+
+	return ret;
+}
-- 
2.47.0.338.g60cca15819-goog



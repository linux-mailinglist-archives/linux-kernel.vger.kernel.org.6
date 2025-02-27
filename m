Return-Path: <linux-kernel+bounces-535218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B2A4703B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BEE1885A49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313F784E1C;
	Thu, 27 Feb 2025 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8ymix9c"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EA51C5A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616404; cv=none; b=CXAA4qXBt+ojj/c1t86XaJeE+X/o67Hy2b6lQIM2FV316jmNXXB9jhap6IWZ4LR/rEs6AeX1uBZj9fFCOfwGe5srOMJd6MB9aRPFa6cBRrMqDRlFRtLTE+z6QWLfWj8QiLvrSUytmbk+Tj9yYGv2ut4Z2yYG/2zgFOGWzietLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616404; c=relaxed/simple;
	bh=MOpMjw+yKamjIuBtGw2bZG0YkfXNv40u4X66Hipr9m8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3EGDwuV9AKinfxcrivpCHVLzvUpSm5ZxU5yN22L5Hr1hG16NHGHEgpjKzJlrzuCcKuaqk4fY7JTyPIHoPzrKAcjXjFgCr6KguXQRP0SZPCfST11b3flJzIQ6h03/U8NUIUh6ZWt9Q/mECreN/pnQ9DRt2OnLjgYbT/HVo/huyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8ymix9c; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abef9384a3bso26964366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616401; x=1741221201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4cLgcKO1PUW4FpDNffQ+Ql+VwqpG2i64q1nOyfOcxQ=;
        b=D8ymix9cm2Ll7m7L4MH7t7VK7Tv6vW2iCXRHThNjpM9JtNvxeaixJiT/OSh7O+eF1Y
         IE4E+TOM+vMa6VzCAMKY1pd3da1YwkWlF12amqrxk62oda7slpzImQWPEBxwx8VbJzlz
         IuJj1shFrMcxOM8ejoY8HFh8+GP9kdVLTzMyc49wY2xXVWo98zsZJwnCPOtj75cU40//
         6Q8VrnS9R7MrKbrYqMSiB1s2JN6THarNfGiwbuFz9VrxuRsGy12tbmq5jL8DYTiIXbs9
         diLJ0mIkOb03N8T4Ca+dio6LqEKBbNMq18kvJJotRqamGE0UzJukA3stmRBWsWDdN6hQ
         kQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616401; x=1741221201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4cLgcKO1PUW4FpDNffQ+Ql+VwqpG2i64q1nOyfOcxQ=;
        b=IEhpzXj291GR2HL/JxygRUVRALLnHbjSDmOkqvZukQMEVG0BtEzb8wp1bq2T7CktSY
         WBoaOw/TcUsxg+r5eO+L05FdVXwoME8TOqIJyxViOwzI/ndUS7CKsxUuazdk/NwIs9XK
         RQuQv/XSggZYBITLVrY1sfJ1TCIMZ+GU40Fru6uQdaXCvurkmNep2XtupI0Ipjz5f8Ux
         LKY5nuzg4WvM2X+zM/gIrPwhrli6dEcO1nuryNV2eHc15CwlmPmH0Y6bWYTZTaSyY3bI
         IxuTgvBYXnmgB6EszvL27gK8ce03it6Imb2XG2zd7elK/bd/B7QtA2LAXgFnL3GS2nOu
         nMHA==
X-Forwarded-Encrypted: i=1; AJvYcCXyr/y2W2sbaYzjp4fmKpG8EnAYcKwEemh5Db39pJPDn+/fowLHCbzqfb+fxdFGGStnXl1NLrkmaFm/ZQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUtaqv7K0ggsDVS/1PboDUScBfdn2vyhyTrtYReYxldvhfReG
	hF9kYrGWSBuIlPKlLNsDTZIAtBwAD1OS8UywSJEEfhX/u6c8isBltQ5tHAXdqI2mPIqwEt1u5cL
	ZW9m3GA==
X-Google-Smtp-Source: AGHT+IGWCpUoU+SAED/xQN8A5aBnRG3yloyg3hA6+NnceXAeQRYPTf0IxPy3Oss2RrNOg12kmMv5qagT6Wh9
X-Received: from ejcux9.prod.google.com ([2002:a17:907:cf89:b0:abb:7df3:8192])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:2ce4:b0:abb:bcef:837c
 with SMTP id a640c23a62f3a-abeeef81b48mr736438766b.56.1740616401210; Wed, 26
 Feb 2025 16:33:21 -0800 (PST)
Date: Thu, 27 Feb 2025 00:33:08 +0000
In-Reply-To: <20250227003310.367350-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003310.367350-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003310.367350-5-qperret@google.com>
Subject: [PATCH 4/6] KVM: arm64: Move hyp state to hyp_vmemmap
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tracking the hypervisor's ownership state into struct hyp_page has
several benefits, including allowing far more efficient lookups (no
page-table walk needed) and de-corelating the state from the presence
of a mapping. This will later allow to map pages into EL2 stage-1 less
proactively which is generally a good thing for security. And in the
future this will help with tracking the state of pages mapped into the
hypervisor's private range without requiring an alias into the 'linear
map' range.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 20 +++++++++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 51 ++++++++++++------------
 arch/arm64/kvm/hyp/nvhe/setup.c          |  6 ++-
 3 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 4a3c55d26ef3..cc4c01158368 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -22,6 +22,7 @@ enum pkvm_page_state {
 	/* Meta-states which aren't encoded directly in the PTE's SW bits */
 	PKVM_NOPAGE			= BIT(0) | BIT(1),
 };
+#define PKVM_PAGE_STATE_MASK		(BIT(0) | BIT(1))
 
 #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
 static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
@@ -42,7 +43,14 @@ struct hyp_page {
 	u8 order;
 
 	/* Host (non-meta) state. Guarded by the host stage-2 lock. */
-	unsigned __host_state : 8;
+	unsigned __host_state : 4;
+
+	/*
+	 * Complement of the hyp (non-meta) state. Guarded by the hyp stage-1 lock. We use the
+	 * complement so that the initial 0 in __hyp_state_comp (due to the entire vmemmap starting
+	 * off zeroed) encodes PKVM_NOPAGE.
+	 */
+	unsigned __hyp_state_comp : 4;
 
 	u32 host_share_guest_count;
 };
@@ -89,6 +97,16 @@ static inline void set_host_state(phys_addr_t phys, enum pkvm_page_state state)
 	hyp_phys_to_page(phys)->__host_state = state;
 }
 
+static inline enum pkvm_page_state get_hyp_state(phys_addr_t phys)
+{
+	return hyp_phys_to_page(phys)->__hyp_state_comp ^ PKVM_PAGE_STATE_MASK;
+}
+
+static inline void set_hyp_state(phys_addr_t phys, enum pkvm_page_state state)
+{
+	hyp_phys_to_page(phys)->__hyp_state_comp = state ^ PKVM_PAGE_STATE_MASK;
+}
+
 /*
  * Refcounting for 'struct hyp_page'.
  * hyp_pool::lock must be held if atomic access to the refcount is required.
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index a45ffdec7612..3ab8c81500c2 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -642,24 +642,24 @@ static int __host_set_page_state_range(u64 addr, u64 size,
 	return 0;
 }
 
-static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte, u64 addr)
+static void __hyp_set_page_state_range(phys_addr_t phys, u64 size, enum pkvm_page_state state)
 {
-	if (!kvm_pte_valid(pte))
-		return PKVM_NOPAGE;
+	phys_addr_t end = phys + size;
 
-	return pkvm_getstate(kvm_pgtable_hyp_pte_prot(pte));
+	for (; phys < end; phys += PAGE_SIZE)
+		set_hyp_state(phys, state);
 }
 
-static int __hyp_check_page_state_range(u64 addr, u64 size,
-					enum pkvm_page_state state)
+static int __hyp_check_page_state_range(phys_addr_t phys, u64 size, enum pkvm_page_state state)
 {
-	struct check_walk_data d = {
-		.desired	= state,
-		.get_page_state	= hyp_get_page_state,
-	};
+	phys_addr_t end = phys + size;
+
+	for (; phys < end; phys += PAGE_SIZE) {
+		if (get_hyp_state(phys) != state)
+			return -EPERM;
+	}
 
-	hyp_assert_lock_held(&pkvm_pgd_lock);
-	return check_page_state_range(&pkvm_pgtable, addr, size, &d);
+	return 0;
 }
 
 static enum pkvm_page_state guest_get_page_state(kvm_pte_t pte, u64 addr)
@@ -687,7 +687,6 @@ int __pkvm_host_share_hyp(u64 pfn)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
 	void *virt = __hyp_va(phys);
-	enum kvm_pgtable_prot prot;
 	u64 size = PAGE_SIZE;
 	int ret;
 
@@ -698,13 +697,13 @@ int __pkvm_host_share_hyp(u64 pfn)
 	if (ret)
 		goto unlock;
 	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
-		ret = __hyp_check_page_state_range((u64)virt, size, PKVM_NOPAGE);
+		ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
 		if (ret)
 			goto unlock;
 	}
 
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
-	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, prot));
+	__hyp_set_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
+	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
 	WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
 
 unlock:
@@ -727,7 +726,7 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
 	if (ret)
 		goto unlock;
-	ret = __hyp_check_page_state_range(virt, size, PKVM_PAGE_SHARED_BORROWED);
+	ret = __hyp_check_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
 	if (ret)
 		goto unlock;
 	if (hyp_page_count((void *)virt)) {
@@ -735,6 +734,7 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 		goto unlock;
 	}
 
+	__hyp_set_page_state_range(phys, size, PKVM_NOPAGE);
 	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
 	WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_OWNED));
 
@@ -750,7 +750,6 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	u64 phys = hyp_pfn_to_phys(pfn);
 	u64 size = PAGE_SIZE * nr_pages;
 	void *virt = __hyp_va(phys);
-	enum kvm_pgtable_prot prot;
 	int ret;
 
 	host_lock_component();
@@ -760,13 +759,13 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	if (ret)
 		goto unlock;
 	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
-		ret = __hyp_check_page_state_range((u64)virt, size, PKVM_NOPAGE);
+		ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
 		if (ret)
 			goto unlock;
 	}
 
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_OWNED);
-	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, prot));
+	__hyp_set_page_state_range(phys, size, PKVM_PAGE_OWNED);
+	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
 	WARN_ON(host_stage2_set_owner_locked(phys, size, PKVM_ID_HYP));
 
 unlock:
@@ -786,7 +785,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 	host_lock_component();
 	hyp_lock_component();
 
-	ret = __hyp_check_page_state_range(virt, size, PKVM_PAGE_OWNED);
+	ret = __hyp_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (ret)
 		goto unlock;
 	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
@@ -795,6 +794,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 			goto unlock;
 	}
 
+	__hyp_set_page_state_range(phys, size, PKVM_NOPAGE);
 	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
 	WARN_ON(host_stage2_set_owner_locked(phys, size, PKVM_ID_HOST));
 
@@ -809,19 +809,18 @@ int hyp_pin_shared_mem(void *from, void *to)
 {
 	u64 cur, start = ALIGN_DOWN((u64)from, PAGE_SIZE);
 	u64 end = PAGE_ALIGN((u64)to);
+	u64 phys = __hyp_pa(start);
 	u64 size = end - start;
 	int ret;
 
 	host_lock_component();
 	hyp_lock_component();
 
-	ret = __host_check_page_state_range(__hyp_pa(start), size,
-					    PKVM_PAGE_SHARED_OWNED);
+	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
 	if (ret)
 		goto unlock;
 
-	ret = __hyp_check_page_state_range(start, size,
-					   PKVM_PAGE_SHARED_BORROWED);
+	ret = __hyp_check_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
 	if (ret)
 		goto unlock;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 1a414288fe8c..955c431af5d0 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -194,16 +194,20 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 
 	/*
 	 * Adjust the host stage-2 mappings to match the ownership attributes
-	 * configured in the hypervisor stage-1.
+	 * configured in the hypervisor stage-1, and make sure to propagate them
+	 * to the hyp_vmemmap state.
 	 */
 	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
 	switch (state) {
 	case PKVM_PAGE_OWNED:
+		set_hyp_state(phys, PKVM_PAGE_OWNED);
 		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
 	case PKVM_PAGE_SHARED_OWNED:
+		set_hyp_state(phys, PKVM_PAGE_SHARED_OWNED);
 		set_host_state(phys, PKVM_PAGE_SHARED_BORROWED);
 		break;
 	case PKVM_PAGE_SHARED_BORROWED:
+		set_hyp_state(phys, PKVM_PAGE_SHARED_BORROWED);
 		set_host_state(phys, PKVM_PAGE_SHARED_OWNED);
 		break;
 	default:
-- 
2.48.1.658.g4767266eb4-goog



Return-Path: <linux-kernel+bounces-535217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ECCA4703A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455B416C456
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C75A79B;
	Thu, 27 Feb 2025 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bi8DtybN"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8327470
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616402; cv=none; b=hnxp+f+isinBdH6b290081wx+n8QDQ7bS8OeVR1fdkpdjhDGrK9a4282sWHQpL5CQAwrydByiCmJRgsoVw+urtJ26f4wjdAiBX3y1hjDBFWXgbiSWIw8tT4SmmYUsJ+KGUBcnI+uN7h5itg8CDciZIjnWQnrd7k8KTxGYSEHc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616402; c=relaxed/simple;
	bh=fXqWM3SBGVlqwHL/vGbkHIEcyvaqkjwWBeVvjy3yeOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bojZyJqqIqSAhsJEPanI2M9SXGad+AfOqwLNNRiT2XLDjnbY+APA3juAVl6LhZXA/xlZ6Zpi2Ypxb66oU1pArbIdgRweuhtTCDMWbJmRDL+J/z8e7ftqwSk2+4F0xJIdxoBsyOc8uVnZq2XMlWx3IE7F/0jWeJbN+nh9HEv9Tm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bi8DtybN; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abb86503062so38239566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616399; x=1741221199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARvzDFB7zgeRMzJfEJ/MY3yWuG0D2YavMEjMtd8skDU=;
        b=bi8DtybN2kvWt0ROcYCpVUKp8Is5XXmxPNf0gsCJD2bflLAjkYIV8J9V07T5Fyl4hf
         jebkxRPTKQlPN0vO7TWjIjV3cwHsZBijaHXMgAVzA9O3C3PbHg9Gnyt11CQtSVAKE+sl
         OIuAtmH1Nb/gawjLOeav76QGyUoEWzmmH2KSsl/q5sLc8GPnJnCZBm7SJ9TxHrI5bde1
         R8290OvhRxCz1JvoBjPr48YOrdz2TAPzQ/a8b8QFdU5rCNBFutlo/d3NU5rR7vbV+M4O
         Jbnly8dA8MFAk2fTsn+n/YALoi1Up0XJPdQnr2vxR3zBX+oVMsTDxgY0o9G5siRoUzh+
         Hqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616399; x=1741221199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARvzDFB7zgeRMzJfEJ/MY3yWuG0D2YavMEjMtd8skDU=;
        b=inO1xhGBi4FnSqUZeLk3WXZxKiZ4Uu/WWdGk2ca/hmKc3SbaqALbCibZU0CtAe+94z
         XIoG1XReA4gfik0HXqB1hwmfNAOlMb1wTITKuEupWnFz1nkEpZIk83eYo/OqGd33MrHH
         lKzIyZPPPHiSHDA31M7jQpAh9qJ4HaUMwnrR2kdlupObwwirlNcjvlekofJ5sdm51Awb
         uJ7zsH9WHx05pPwAXJf3+Gr+0EPq2gHRc4c+AeBIAYnVTXjK9jPS9DDobLMn2rjYBi3K
         EMOqGiQ+EcppkRbSnujo7MvnV6wiHLMNn4igcUeNtbBwsy05rg+XeYiYEUfZDt7r3Jzo
         gR+A==
X-Forwarded-Encrypted: i=1; AJvYcCUeJYotxvXAJlp0ukVJdyJvuvlC4RmL86011BecPPvZgogmK6GMO6SS4JLeM/7j5X1RjRYaFbFzWMrGiJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAJUhZbgZMLxjdCyD/Anc3iHIIDSjBPUzxeMpdPzMbSx1Ic7l
	ywhsLVijqFydQoKGBlDK2j6mHjqzoOabl+wp7M4UAEWR7vyc6n+SpSmST/FZmd0XwZlPX8954Jv
	UVXqkrQ==
X-Google-Smtp-Source: AGHT+IGb9U+m49213J1IZUi+y8W79DM6Us+fCqOcM3EVD4VeabxFV0pdhtYZr/kBDuUNuD4BTttJ023fUDlE
X-Received: from ejcli4.prod.google.com ([2002:a17:907:1984:b0:abe:e707:63bf])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:d8a:b0:abb:aef3:6052
 with SMTP id a640c23a62f3a-abeeef81b5emr630257266b.55.1740616399076; Wed, 26
 Feb 2025 16:33:19 -0800 (PST)
Date: Thu, 27 Feb 2025 00:33:07 +0000
In-Reply-To: <20250227003310.367350-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003310.367350-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003310.367350-4-qperret@google.com>
Subject: [PATCH 3/6] KVM: arm64: Introduce {get,set}_host_state() helpers
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Instead of directly accessing the host_state member in struct hyp_page,
introduce static inline accessors to do it. The future hyp_state member
will follow the same pattern as it will need some logic in the accessors.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 12 +++++++++++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 14 +++++++-------
 arch/arm64/kvm/hyp/nvhe/setup.c          |  4 ++--
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 642b5e05fe77..4a3c55d26ef3 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -42,7 +42,7 @@ struct hyp_page {
 	u8 order;
 
 	/* Host (non-meta) state. Guarded by the host stage-2 lock. */
-	enum pkvm_page_state host_state : 8;
+	unsigned __host_state : 8;
 
 	u32 host_share_guest_count;
 };
@@ -79,6 +79,16 @@ static inline struct hyp_page *hyp_phys_to_page(phys_addr_t phys)
 #define hyp_page_to_virt(page)	__hyp_va(hyp_page_to_phys(page))
 #define hyp_page_to_pool(page)	(((struct hyp_page *)page)->pool)
 
+static inline enum pkvm_page_state get_host_state(phys_addr_t phys)
+{
+	return (enum pkvm_page_state)hyp_phys_to_page(phys)->__host_state;
+}
+
+static inline void set_host_state(phys_addr_t phys, enum pkvm_page_state state)
+{
+	hyp_phys_to_page(phys)->__host_state = state;
+}
+
 /*
  * Refcounting for 'struct hyp_page'.
  * hyp_pool::lock must be held if atomic access to the refcount is required.
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 19c3c631708c..a45ffdec7612 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -467,7 +467,7 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
 		return -EAGAIN;
 
 	if (pte) {
-		WARN_ON(addr_is_memory(addr) && hyp_phys_to_page(addr)->host_state != PKVM_NOPAGE);
+		WARN_ON(addr_is_memory(addr) && get_host_state(addr) != PKVM_NOPAGE);
 		return -EPERM;
 	}
 
@@ -496,7 +496,7 @@ static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_
 	phys_addr_t end = addr + size;
 
 	for (; addr < end; addr += PAGE_SIZE)
-		hyp_phys_to_page(addr)->host_state = state;
+		set_host_state(addr, state);
 }
 
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
@@ -620,7 +620,7 @@ static int __host_check_page_state_range(u64 addr, u64 size,
 
 	hyp_assert_lock_held(&host_mmu.lock);
 	for (; addr < end; addr += PAGE_SIZE) {
-		if (hyp_phys_to_page(addr)->host_state != state)
+		if (get_host_state(addr) != state)
 			return -EPERM;
 	}
 
@@ -630,7 +630,7 @@ static int __host_check_page_state_range(u64 addr, u64 size,
 static int __host_set_page_state_range(u64 addr, u64 size,
 				       enum pkvm_page_state state)
 {
-	if (hyp_phys_to_page(addr)->host_state == PKVM_NOPAGE) {
+	if (get_host_state(addr) == PKVM_NOPAGE) {
 		int ret = host_stage2_idmap_locked(addr, size, PKVM_HOST_MEM_PROT);
 
 		if (ret)
@@ -904,7 +904,7 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
 		goto unlock;
 
 	page = hyp_phys_to_page(phys);
-	switch (page->host_state) {
+	switch (get_host_state(phys)) {
 	case PKVM_PAGE_OWNED:
 		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_OWNED));
 		break;
@@ -957,9 +957,9 @@ static int __check_host_shared_guest(struct pkvm_hyp_vm *vm, u64 *__phys, u64 ip
 	if (WARN_ON(ret))
 		return ret;
 
-	page = hyp_phys_to_page(phys);
-	if (page->host_state != PKVM_PAGE_SHARED_OWNED)
+	if (get_host_state(phys) != PKVM_PAGE_SHARED_OWNED)
 		return -EPERM;
+	page = hyp_phys_to_page(phys);
 	if (WARN_ON(!page->host_share_guest_count))
 		return -EINVAL;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index d62bcb5634a2..1a414288fe8c 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -201,10 +201,10 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	case PKVM_PAGE_OWNED:
 		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
 	case PKVM_PAGE_SHARED_OWNED:
-		hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_BORROWED;
+		set_host_state(phys, PKVM_PAGE_SHARED_BORROWED);
 		break;
 	case PKVM_PAGE_SHARED_BORROWED:
-		hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_OWNED;
+		set_host_state(phys, PKVM_PAGE_SHARED_OWNED);
 		break;
 	default:
 		return -EINVAL;
-- 
2.48.1.658.g4767266eb4-goog



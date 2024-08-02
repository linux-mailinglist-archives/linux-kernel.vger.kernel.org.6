Return-Path: <linux-kernel+bounces-273113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A479464AA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0AE1F2239E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062F613B2B2;
	Fri,  2 Aug 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nmr/ypcQ"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522F13A406
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631820; cv=none; b=Sk5+5kP7fQizbcD+nxL+BxKKNYG1tYeqreGxKA8ARNd+4CZWy0bYFcwyoeVkvIhQzcjBY1Uz0OPUuHCeHRFvPf5kvu6Uw2/nSlozs3p6vGB7kOcZDbQo3jwRzecqtTNN75Je9R1mLS6QhD5YXnn1enJprCBJnVPYNLvZX+N54uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631820; c=relaxed/simple;
	bh=KEGZdr470mbN39TUkKhvxHtOKwGWSbX3eH+Pxhz6IxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uweh/Sz6DxTr9ZM5wNWgrbRJRf2LMABGm+fzvNicRW7SF+sSfKY3Ezz/UGetMLeCnblCZLNChbjnFIVxaICjwM3Ou3tm5ouz6IbIbF+QyZ3MnG50A1cYkOiewLMx003B4mp/ulUKhAD00sp99vI+Z3IC19gYJk0+IuwbbwHxKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nmr/ypcQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso3535876a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722631817; x=1723236617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sjrf6LZp0RLJx3l68AWkRp+t7dxqDnRfk/l7MG9GSDc=;
        b=Nmr/ypcQRV8rLYJ2ynANvyYB3nrBPYJCMtYzatnQVi+njMFTluNJkFnxCsfI5fmkDs
         HHTwa10ArAfBE1qNBf2LfzuLYP8bJGqdzl1XtTi3cICZVk+C4cNkoASl7qZz+eVTaBCg
         /me7rE21Yay+LEepOPlqvPiQojNXvXtzU1dg2Og9p6O0vAOsfRJkfwWO8MlZFhQV6iC+
         uug3LdVIQdF8rtIOYR3d3DSZfcXBphBCuB4sUYVoSekou7RM1dfuzICCHsjv5UHco8nC
         hmLTRtjPHrxr77IYvK+T/DqFXC6OO27AljzI5QbhbQoQlpUq058DYiekEgrLdOCkv/mA
         e79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631817; x=1723236617;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjrf6LZp0RLJx3l68AWkRp+t7dxqDnRfk/l7MG9GSDc=;
        b=vQ0HBy68ag4tEVNWqW6O4KV5aD5tnq7WYV30c9eeci8aCLddadDvRhbyauSkpMqNJN
         07kBbm2IZV5CseKMt+Yp99MVbZVIUFZrrPYyfFnSWSkllezR+vXn8gsTjIl3E0qbi1ig
         vKe7oUJRyygafxs+5Zb/00dpl+hESRJ73auIXCd9uD8FwrCu/Q1MyHxOr3cSEtJkF/7+
         0Fkj3jUmIuaRh1daFrssd+wMQuOhQXNpqRtzu456uIfc7i30Gyv0w49niXVoYOK0D/aK
         wYM5sRl7hbFIYRzc5v+FGQQtb5K2z/3t/xw6zdTzxVJYfFIczP+abwYmda7sNojZ1Q6H
         4vOA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Ueo05hiE3g5zX0BJlPMUi/MRiKZOMsH/g64YA+/wy9pN2kY32wK7rSASAxEzDROnTAoeRNsGIRdGehVtZaFxy+KqmEWO/uCZPiPQ
X-Gm-Message-State: AOJu0Yz7yrQFfq97G2NX8xih7Rsif+kS7hmMPD0FijppG0NCMbiR4Ixm
	AcEJwaaaInCXUtCae2Gp/eTfzbf6iYdeqn3HYvPSy6u6WFsjV362zbm/YDHbLZVTmhKKqOEmTP3
	eUA==
X-Google-Smtp-Source: AGHT+IF6C7pZ4NUGocFOOu/UQeiI5UJqzb1YswLOQBQxbJtWu5WEPTvztRxCrWwXOvBTc4lrrFA0biwyW7Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6704:0:b0:7b8:b174:3200 with SMTP id
 41be03b00d2f7-7b8b1743d58mr2218a12.5.1722631817192; Fri, 02 Aug 2024 13:50:17
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:50:03 -0700
In-Reply-To: <20240802205003.353672-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802205003.353672-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802205003.353672-7-seanjc@google.com>
Subject: [PATCH 6/6] KVM: Move flags check for user memory regions to the
 ioctl() specific API
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the check on memory region flags to kvm_vm_ioctl_set_memory_region()
now that the internal API, kvm_set_internal_memslot(), disallows any and
all flags.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 54 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 84fcb20e3e1c..09cc261b080a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1566,34 +1566,6 @@ static void kvm_replace_memslot(struct kvm *kvm,
 #define KVM_SET_USER_MEMORY_REGION_V1_FLAGS \
 	(KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)
 
-static int check_memory_region_flags(struct kvm *kvm,
-				     const struct kvm_userspace_memory_region2 *mem)
-{
-	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
-
-	if (kvm_arch_has_private_mem(kvm))
-		valid_flags |= KVM_MEM_GUEST_MEMFD;
-
-	/* Dirty logging private memory is not currently supported. */
-	if (mem->flags & KVM_MEM_GUEST_MEMFD)
-		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
-
-#ifdef CONFIG_HAVE_KVM_READONLY_MEM
-	/*
-	 * GUEST_MEMFD is incompatible with read-only memslots, as writes to
-	 * read-only memslots have emulated MMIO, not page fault, semantics,
-	 * and KVM doesn't allow emulated MMIO for private memory.
-	 */
-	if (!(mem->flags & KVM_MEM_GUEST_MEMFD))
-		valid_flags |= KVM_MEM_READONLY;
-#endif
-
-	if (mem->flags & ~valid_flags)
-		return -EINVAL;
-
-	return 0;
-}
-
 static void kvm_swap_active_memslots(struct kvm *kvm, int as_id)
 {
 	struct kvm_memslots *slots = kvm_get_inactive_memslots(kvm, as_id);
@@ -1986,10 +1958,6 @@ static int kvm_set_memory_region(struct kvm *kvm,
 
 	lockdep_assert_held(&kvm->slots_lock);
 
-	r = check_memory_region_flags(kvm, mem);
-	if (r)
-		return r;
-
 	as_id = mem->slot >> 16;
 	id = (u16)mem->slot;
 
@@ -2114,6 +2082,28 @@ EXPORT_SYMBOL_GPL(kvm_set_internal_memslot);
 static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
 					  struct kvm_userspace_memory_region2 *mem)
 {
+	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
+
+	if (kvm_arch_has_private_mem(kvm))
+		valid_flags |= KVM_MEM_GUEST_MEMFD;
+
+	/* Dirty logging private memory is not currently supported. */
+	if (mem->flags & KVM_MEM_GUEST_MEMFD)
+		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
+
+#ifdef CONFIG_HAVE_KVM_READONLY_MEM
+	/*
+	 * GUEST_MEMFD is incompatible with read-only memslots, as writes to
+	 * read-only memslots have emulated MMIO, not page fault, semantics,
+	 * and KVM doesn't allow emulated MMIO for private memory.
+	 */
+	if (!(mem->flags & KVM_MEM_GUEST_MEMFD))
+		valid_flags |= KVM_MEM_READONLY;
+#endif
+
+	if (mem->flags & ~valid_flags)
+		return -EINVAL;
+
 	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog



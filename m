Return-Path: <linux-kernel+bounces-263871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A9593DBB3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2349288C09
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144DF17FAD9;
	Fri, 26 Jul 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3XBBL3p"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929CD17F4FF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038028; cv=none; b=hjWazB+HwFat7MxQCyN8oexzAcNixs9sItWmUeW1wrqjFhalVZoAUhFSMbmJTjtJHMj9cUyKN/TBsHsu1uzWQwde+idBZ5tBM9lLSihYq4sE3VgR8F1xJQ0vNhic9uBIrBQ2CqvAofJCIEQPjVMv2bu3o/AHTzRRtsONnQ7AxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038028; c=relaxed/simple;
	bh=8U41yEZkwmCC7j8hL2o/rtiKo/Y2IzaocSdWcXfAeko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=en9EF6CV9fVXwAM9qpgI2tUUwkKaqaMKRRIOJchIQxLavS/wIB40f7CDDCgAzwJRtgfJXFTXmAxAzdV/L9OonP0j/zaLNe9sgkssUKon+l2bzDNj3+HN7dM3hIxAIe8VCgUQkan5LYQ8HruF26tdjVx1YfpHcDfS7h425+EGJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3XBBL3p; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6688c44060fso6476507b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038026; x=1722642826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TLCx2qDCvkD9gyhhD5S2JLlOeuoeLAn7xH7FruJz3kQ=;
        b=k3XBBL3p5RIi4t28nXtu8zaiPCFU3PZQa4vgyQDDxjIbGTsSBEJJioZssEfc9cTE09
         CflcROJvU6p/6zBJBZAhGv6yapUTz+l5cKsqUAyIXmaL+PxgIvT339fXD4T4a+HZmGtC
         hI6PhsxWioqDCkX+FYOa7uUh8UYJSQPy+qSQrafnGOD3WIV836pmemAoBqFJwDAVRRo0
         gqrhlDJz9sP0uVburApfPqs8UUDetG+UmELfUSRbBbYk8Y+qSrs7pbBeqp5L5vAffdeH
         X2OkgUgGyVWCH93SUKwhS4EsWVZahwBfLCr+qciSwHMnhJmWdmnhNelO+QTstyenr/9q
         7zTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038026; x=1722642826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLCx2qDCvkD9gyhhD5S2JLlOeuoeLAn7xH7FruJz3kQ=;
        b=UXmYw4Vyy8Wsh4DNuNDgo6LwW4OrWUOvlbR3zMtpg/CMZSXbuveeAnB6oKIwBmrjid
         UdBDDQCtPiLbM2B43yt9jdbVPizCZWEClKMbKic6B88m4gizDYufY29lDDrrFAtF2nM/
         awm4+rKU4zGOKRaVo4rGi/vuFe9BPukV0Kj9LD0RdYh+1uBMyTYXxHNLbXWjBmSBnF7E
         fWb1Cqo8gQLlY1lDL0ctGiErNB+NbABwnQl8TsgN0Vzrthv7zIMRy+yXGzfgrQjKy0G6
         k03qtRfyKQ1DQwPGAliqR4RrB6pyZUvOWYjX6Y/yBcp/1RQXbY9/TVNDNZZ2ERNFx6bo
         GGrA==
X-Forwarded-Encrypted: i=1; AJvYcCXUFfYHCjmGCMkGY39SEUWNwd2GPw6F3Mp2DmeCGMmrp1zb+qqLJLXHK/Dg/KqodICKg2//vazTSsAAQlpamF6/HuGOoot4lkOSurvJ
X-Gm-Message-State: AOJu0YwmXY47nBPIbVGO/B9E6lS8/gWr1pIUjl3FSkTkWEnDYeCNnf3d
	JOCj6d7XAupNrjmC0hoZeB1+rfvFFpkWJaerL78aXkotBqT8ypHX5dwvYuBDBB/2AReIIBqLZYp
	9Jw==
X-Google-Smtp-Source: AGHT+IFuGqnDYAUSJ5FmVd85CGAsbS7YYsLTPQN/3Ul7QhkRMd8+dVyQHeeD8wiMpZyrbrthnX4Q+b9wtNM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1005:b0:e0b:f93:fe8c with SMTP id
 3f1490d57ef6-e0b5427fa67mr79832276.0.1722038025699; Fri, 26 Jul 2024 16:53:45
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:51:42 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-34-seanjc@google.com>
Subject: [PATCH v12 33/84] KVM: Disallow direct access (w/o mmu_notifier) to
 unpinned pfn by default
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Add an off-by-default module param to control whether or not KVM is allowed
to map memory that isn't pinned, i.e. that KVM can't guarantee won't be
freed while it is mapped into KVM and/or the guest.  Don't remove the
functionality entirely, as there are use cases where mapping unpinned
memory is safe (as defined by the platform owner), e.g. when memory is
hidden from the kernel and managed by userspace, in which case userspace
is already fully trusted to not muck with guest memory mappings.

But for more typical setups, mapping unpinned memory is wildly unsafe, and
unnecessary.  The APIs are used exclusively by x86's nested virtualization
support, and there is no known (or sane) use case for mapping PFN-mapped
memory a KVM guest _and_ letting the guest use it for virtualization
structures.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a28479629488..0b3c0bddaa07 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -94,6 +94,13 @@ unsigned int halt_poll_ns_shrink = 2;
 module_param(halt_poll_ns_shrink, uint, 0644);
 EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);
 
+/*
+ * Allow direct access (from KVM or the CPU) without MMU notifier protection
+ * to unpinned pages.
+ */
+static bool allow_unsafe_mappings;
+module_param(allow_unsafe_mappings, bool, 0444);
+
 /*
  * Ordering of locks:
  *
@@ -2821,6 +2828,9 @@ static kvm_pfn_t kvm_resolve_pfn(struct kvm_follow_pfn *kfp, struct page *page,
 	 * reference to such pages would cause KVM to prematurely free a page
 	 * it doesn't own (KVM gets and puts the one and only reference).
 	 * Don't allow those pages until the FIXME is resolved.
+	 *
+	 * Don't grab a reference for pins, callers that pin pages are required
+	 * to check refcounted_page, i.e. must not blindly release the pfn.
 	 */
 	if (pte) {
 		pfn = pte_pfn(*pte);
@@ -2942,6 +2952,14 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	bool write_fault = kfp->flags & FOLL_WRITE;
 	int r;
 
+	/*
+	 * Remapped memory cannot be pinned in any meaningful sense.  Bail if
+	 * the caller wants to pin the page, i.e. access the page outside of
+	 * MMU notifier protection, and unsafe umappings are disallowed.
+	 */
+	if (kfp->pin && !allow_unsafe_mappings)
+		return -EINVAL;
+
 	r = follow_pte(vma, kfp->hva, &ptep, &ptl);
 	if (r) {
 		/*
-- 
2.46.0.rc1.232.g9752f9e123-goog



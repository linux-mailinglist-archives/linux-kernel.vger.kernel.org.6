Return-Path: <linux-kernel+bounces-263913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F60A93DC44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8355D1C23403
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9A19006D;
	Fri, 26 Jul 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw3gWiwC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A518FDD7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038116; cv=none; b=P9zJkbUqD7ejcntuVDiaSmvVIDCFBga3WX0N3SHT5hWWEW6ZQJXhtMOV2HKEKB2N5vjc5RiseLRMaza83Y/LlSUnOkYtwPXujGj4MdRHyKhZpT9Cb582m8EeB6Mw9Ts1N+/rVOip5JD9OY8D1q/msnfE3RmPlqsWnKwvjpKCPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038116; c=relaxed/simple;
	bh=p0sbScV9KYWrdS1YnUq9iP3jaGBNbAWZ6v3m97jnfrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJQqxyn1jmT5TG/MrNg9IBPkf5YAOjMyiKuQayGsfZoTX5JR8+w3LErND58iInhHRzWpUC86i5RFWhlaCvvQua3Bzb9gM/ZoMSESuIBz/wQtzT9Cnov/VnTIH35Xq5/u4YX7ouQPx+O3Tp6REL+fU6K5I1rmMRs4RlPp2dGNVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rw3gWiwC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6506bfeaf64so6089787b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038114; x=1722642914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zSysp7FPh6wn+DolRHFxx8ZAZJRhLuISfWWp3RFo0OA=;
        b=Rw3gWiwCXZn+yAIRBBxOBVVq7qQjbcphCA3GjHPzQ7gO9dL5tKEufxJCJ7asjzpkeO
         llmmowxZpw8iLxtC9qk2EhjVJA5HdHCRrwcAKJNDfUkBN+0W7aZTXlghDJhmEALMY6dy
         Y16GaK06BKVbFand5e+W7GVUjUZTzGRooiB6ud42VYRUzGV3mryUyMK0NuCeS+ew0fj+
         aVpGrUi74V7BumvPCvcKuZ1Xj5UTlerHGlKd+3fP8PVeW1vFcP87gk7HkPUXh8fToweZ
         tMmxlpZOm0F3b2YTDVtm00YwJkxJ28usGqldB5dcqiIlfkE9faLLzCEALOZU2b0J/bbE
         06/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038114; x=1722642914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSysp7FPh6wn+DolRHFxx8ZAZJRhLuISfWWp3RFo0OA=;
        b=czsB8rsXR1mUzR8A79sVaNAsrPUxbBKx0VBBuUO6LIl9hfJX6zM7Svf86r7ju+ZXTe
         0jDWcxgR4Kh56ZZRwIXvCyfd6EnJVBa5k36irajW2rrx48udt6FO1Vwcbom2AUcCtReE
         Rd+ic/eVVMyiYjUHNYHk84j6ucPUrL1OQwMVmTPmblHVOKe5WC58vcoveQSwZg0FzR/f
         r6mbaAqY/kHTi6RzW9qdK/U+WmmyzVTzQmfGf2XqMFiRwkLgzy0Rc3+V64ECVDPip1lx
         hTy/6nor0kHPn9aWlpQLndGQoDWtdwIr2V0/6jYtNaldYHi6NMBLlUfJQ15irHDzA+sa
         tG+g==
X-Forwarded-Encrypted: i=1; AJvYcCVtb9M7EaW4Gd3qECIoEqTqD2rYe2oKY3b15syh0UlD38z6K9j/ejeGcB67ZAmfyOCx/kRDxn+aOdLr9nCBjIuETwr/PXIrDOKFbigi
X-Gm-Message-State: AOJu0Yw4LYe5iYvgTj2X1UbQx7qCgmDW4BzRntoUzK2UWjw3QEPSinQL
	9JjJiBXnYvJVvzKDMh0tcKG1XTIzAtyOaRj+fMNFJJzfsgWI2A89D//q74AngTLOIfslRDbKjHD
	nHg==
X-Google-Smtp-Source: AGHT+IHtdYLzf8VxCow9ze9t5PB7b90MwNFbCURT1XZzWgwcWEIftZd8Pqph9MK+hSFYPsX4JKQKNB1AEe8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1889:b0:dfb:1147:cbaa with SMTP id
 3f1490d57ef6-e0b5459b0b9mr34694276.10.1722038113838; Fri, 26 Jul 2024
 16:55:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:24 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-76-seanjc@google.com>
Subject: [PATCH v12 75/84] KVM: Add support for read-only usage of gfn_to_page()
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

Rework gfn_to_page() to support read-only accesses so that it can be used
by arm64 to get MTE tags out of guest memory.

Opportunistically rewrite the comment to be even more stern about using
gfn_to_page(), as there are very few scenarios where requiring a struct
page is actually the right thing to do (though there are such scenarios).
Add a FIXME to call out that KVM probably should be pinning pages, not
just getting pages.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  7 ++++++-
 virt/kvm/kvm_main.c      | 15 ++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 91341cdc6562..f2d3c3c436cc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1198,7 +1198,12 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
 		       struct page **pages, int nr_pages);
 
-struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn);
+struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write);
+static inline struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
+{
+	return __gfn_to_page(kvm, gfn, true);
+}
+
 unsigned long gfn_to_hva(struct kvm *kvm, gfn_t gfn);
 unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable);
 unsigned long gfn_to_hva_memslot(struct kvm_memory_slot *slot, gfn_t gfn);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d0f55a6ecb31..16bc3ac3ff84 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3174,25 +3174,26 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
 EXPORT_SYMBOL_GPL(kvm_prefetch_pages);
 
 /*
- * Do not use this helper unless you are absolutely certain the gfn _must_ be
- * backed by 'struct page'.  A valid example is if the backing memslot is
- * controlled by KVM.  Note, if the returned page is valid, it's refcount has
- * been elevated by gfn_to_pfn().
+ * Don't use this API unless you are absolutely, positively certain that KVM
+ * needs to get a struct page, e.g. to pin the page for firmware DMA.
+ *
+ * FIXME: Users of this API likely need to FOLL_PIN the page, not just elevate
+ *	  its refcount.
  */
-struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
+struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write)
 {
 	struct page *refcounted_page = NULL;
 	struct kvm_follow_pfn kfp = {
 		.slot = gfn_to_memslot(kvm, gfn),
 		.gfn = gfn,
-		.flags = FOLL_WRITE,
+		.flags = write ? FOLL_WRITE : 0,
 		.refcounted_page = &refcounted_page,
 	};
 
 	(void)kvm_follow_pfn(&kfp);
 	return refcounted_page;
 }
-EXPORT_SYMBOL_GPL(gfn_to_page);
+EXPORT_SYMBOL_GPL(__gfn_to_page);
 
 int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		   bool writable)
-- 
2.46.0.rc1.232.g9752f9e123-goog



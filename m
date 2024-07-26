Return-Path: <linux-kernel+bounces-263856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46393DB7E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03563B2358E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986F1741E9;
	Fri, 26 Jul 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCTSWtId"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D7172762
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722037998; cv=none; b=WlfyUMCwPu96O9vjspz1u6Z2F4gcGs3PJ5vGlcC1TszQHo+28boyq+QkNom4B/Czo6E9Z7FT0/UO4uf/IJgbX/guTGWaUfwJVMJbe9Qi7eEPrmDURy84F37X2iUSF7/jqHqjtDo5CCaQJHLcET8YxxSK9t1KD+f1wVjpC3Jvp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722037998; c=relaxed/simple;
	bh=RHZeaSr31fCCvyOcLLpe++oP0vx96AuhdExL9Q1bNo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkgME6qFaHoaNz7W4O2TpWb5/K6AWrtBHtJp1jjg1i1HLZ9DdTDKgy4qGfPseHx4NxrGPcsXThOWaORLbNqmimDnRm2hEjL7Lh+BL84/OF9jeCphrIOsYviSUwIaK7hpIMqQDNDbveuptg1NIrBO0SUdl+qC2F0rRpuod/z55Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCTSWtId; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a1188b3bc2so1412325a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722037996; x=1722642796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oqsp5dWmLf1ceGtEyEpwn2+TSiYr9kgkgYyCIEXijOU=;
        b=kCTSWtId1rHIZgmfsdqgQ5rr5qjwVYRpqhiAjlZgNwGPzSbamMwXx10J6U5t/+/VC6
         xZEuKeLSfx+5+fDzVhBtur6rMPAm4ZwpHOZIhaUJcS3yH42v8xWgXTFEtnX0ILpJQT0P
         WRz66MsDqfL5hxrAtaonU7xHvW/hOCj0GjaW/6i1CkVHtJGjNL7XX7frQerDXCuYGJFO
         ZXtZki55GpST/Q18pCz5z99EfGuaDiHvhR5GQvSC61w/SOmuk5tDNZiOinVaMdReWyuN
         nbqRwh9Z51ENrs1IC2+T9cC5dMduSkF0IN+G8xuXI/Sf/FcvoPH5ARg06pQMuzp9itM+
         bLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722037996; x=1722642796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqsp5dWmLf1ceGtEyEpwn2+TSiYr9kgkgYyCIEXijOU=;
        b=El4wPUo8hHbkR/jhSbiro2IZCSXUWd5jY/xjA/r2F1XhOoGC3M+iNLzmMvrWjXR5Ue
         wmIkU8DZRrpmLiE0oXwyw9zKPcumwlOxhWLs5tQIXU7HIcjAmfu6xpMbVJeclx9AVxCS
         lMMboj3aOVRW3kY8FQFNOewvR6ycVth7ep10iVhar6XRy9rqqz0kWH3NQO9EJ/jMxBjN
         BbPU9gyABao8PlrAczYg38jD68q5n0aIe752k1MzA95iIPirZteqDKbJbbKFJ22dZ1eZ
         CJxeXQvBlFpGUfG+U0N1Fn/kEA2CUdZ4vue2WatsOsMvX8mNvB9cMYyzolWgAVx5ER7F
         f4pg==
X-Forwarded-Encrypted: i=1; AJvYcCWtpWVpaQKPsLZOuYXZRNuV0sOnN4XIiMys+RMkn1uEu9EWkelq+BQO9mifvivSfC0TcvTyIG7wLwmSveM6qDHZUWnFU1D0Oth43pgf
X-Gm-Message-State: AOJu0YyA1JkwE9iA20LpWaoEiRhGtjOhijbdQpnZ7B9A7AFhRF3EDBve
	o2aLA6EPKFnNHWRQsrCb105n1deRB2nGbKBOyA8Ea/vaJV9zR22qYvNwq5jpaAASJ93wNmqIpm1
	yaA==
X-Google-Smtp-Source: AGHT+IGPnVvSSR8GC4je1DUQj4K0eIO0wDIdrfABFjI4ae5Nt/lU6oCOfX0avnzwArksU/NKeR8FWd7ZKxM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:5a9:b0:6be:8aa5:bffb with SMTP id
 41be03b00d2f7-7ac8e0bb8cdmr3560a12.4.1722037995764; Fri, 26 Jul 2024 16:53:15
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:51:28 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-20-seanjc@google.com>
Subject: [PATCH v12 19/84] KVM: Explicitly initialize all fields at the start
 of kvm_vcpu_map()
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

Explicitly initialize the entire kvm_host_map structure when mapping a
pfn, as some callers declare their struct on the stack, i.e. don't
zero-initialize the struct, which makes the map->hva in kvm_vcpu_unmap()
*very* suspect.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 21ff0f4fa02c..67a50b87bb87 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3088,32 +3088,24 @@ void kvm_release_pfn(kvm_pfn_t pfn, bool dirty)
 
 int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 {
-	kvm_pfn_t pfn;
-	void *hva = NULL;
-	struct page *page = KVM_UNMAPPED_PAGE;
-
-	pfn = gfn_to_pfn(vcpu->kvm, gfn);
-	if (is_error_noslot_pfn(pfn))
-		return -EINVAL;
-
-	if (pfn_valid(pfn)) {
-		page = pfn_to_page(pfn);
-		hva = kmap(page);
-#ifdef CONFIG_HAS_IOMEM
-	} else {
-		hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
-#endif
-	}
-
-	if (!hva)
-		return -EFAULT;
-
-	map->page = page;
-	map->hva = hva;
-	map->pfn = pfn;
+	map->page = KVM_UNMAPPED_PAGE;
+	map->hva = NULL;
 	map->gfn = gfn;
 
-	return 0;
+	map->pfn = gfn_to_pfn(vcpu->kvm, gfn);
+	if (is_error_noslot_pfn(map->pfn))
+		return -EINVAL;
+
+	if (pfn_valid(map->pfn)) {
+		map->page = pfn_to_page(map->pfn);
+		map->hva = kmap(map->page);
+#ifdef CONFIG_HAS_IOMEM
+	} else {
+		map->hva = memremap(pfn_to_hpa(map->pfn), PAGE_SIZE, MEMREMAP_WB);
+#endif
+	}
+
+	return map->hva ? 0 : -EFAULT;
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_map);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog



Return-Path: <linux-kernel+bounces-263897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAA93DC0E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB371F214C6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6EC188CBC;
	Fri, 26 Jul 2024 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVB0XwtW"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4307187860
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038083; cv=none; b=RgcUUid0U4Ika/7P+MoAPY09dHt2x2hxCXSfa6NVNJStv2mQpXbDmAqgOpSxfqSlZC2Jr/+pF5mZ8+RXAjwOdDFbmGTfI+I6+topIHVERLwGN/bvdPOLKs/rfA7L2rE4OA0MgKMBKYJVrVZR+0syKlvLn7ccxcEUkDsKt53Mtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038083; c=relaxed/simple;
	bh=WM0+vLgn5P7yqOKEb4OpGV1yF56+IgtBIdrStZDYJ+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsC0l6/UuLB3S+9OR8uOg5XvsrHACz1nBlquz6DX43HHJMJCY+/+0c2vsHCCTkwROdq7zkcKK9YluEBKYUpN6cr8B9hiz6uMvn/iH5HniH5RjZTi3PgueoL3ZnXj0gU3ABe3bBKX5m5+NRBm1hoUaB9FrQ/BH1OsSr93SxprXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVB0XwtW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc52d3c76eso12300885ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038081; x=1722642881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eM04pE2oItbps9DzmNWUdptdfO1yLAvOtXUsQdNxOmg=;
        b=kVB0XwtWlaIqWC2bciibmwyPY5lhm9EGl2h/NSBVjucKht2mKde+UXiItCBPkXUc2j
         ECsB5VQZYw83cZmPK0vSu2pOPS3g/noU5yo+0nZweKxVq60lznh2/zvobWhF1GwfrHt2
         xwM2nYg4a2jKEiLuizfvNjA00XGNgIzL3UA8bsWHa12FFxmS0fAfnWho9uL7JP5vj/HR
         ++tAatE2sGXWg1/+a2yrih5nfc+uvTlG20K8pikZhBu1sSjEYNKYj298i38cpySiEOQg
         0GPkh3qdAFU1U+J9epvzvrCjnNpIOo0bzg4AQO5tuvwyJZ8qvJ5Oz/NqEk3nV9QxIuBK
         WCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038081; x=1722642881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM04pE2oItbps9DzmNWUdptdfO1yLAvOtXUsQdNxOmg=;
        b=Bg9WWtLKZQoL3uW5xIhQ5Vr0meF1ChJw0qjWgS0WOKZCNN2jY/nvjH4o9ZjFxPmi9m
         YNrbBarTRf0WNNu+smgTzrrl0fzwCaezR7V2/klDnCvgUxbXgRCHaKAJ8DiusMoo2PI/
         ks2axJXhmls2clv2XxKiztajd1aR9sy0n0FM1zQf1x64p67Y/MCpowQ9wMV5dF0KFA9v
         3VwUin/M2+k/eWvR1Jo8dTujvFJV3wnlMJmETbr002TRNzNSi5K/yeu3R6ruMbdT+WGA
         E7+zhbQV+1QPAL5dECuc0xDbhHooEqLZhc9G4SiXKEgiIHhWnUuCWwIfEnXpwL17W/X+
         1kVA==
X-Forwarded-Encrypted: i=1; AJvYcCVaos2bpuwwNJIqBQKZ0pp6o9UHI8pNymdZm99rihg0/F1KG1p3RZqQC9vQx6CxOlhGFduSifAjp69ztI8aBvJI3rOWYND68IJWNpxT
X-Gm-Message-State: AOJu0Yyy1iql57zz0wE9miAG0Kc5tfXdHxoaElABQrAl+8yUEdfcYISQ
	MAMfG9byYNYRJBrP/1ZHsnup4gOhz8qu5ZQHC1GKlRyX1EESHxagEzDX251VWBX23hVjyctAscw
	aBg==
X-Google-Smtp-Source: AGHT+IHO8zzuGkjlMSTl8Rqd7iW1pR8+tgiNg2ojfeAF3X7ugPbzXNjRAQyOFKQ91J/aSe/NwOtEVPH7LtU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:db11:b0:1f8:44f4:efd9 with SMTP id
 d9443c01a7336-1ff047d0af0mr1044175ad.2.1722038080667; Fri, 26 Jul 2024
 16:54:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:08 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-60-seanjc@google.com>
Subject: [PATCH v12 59/84] KVM: PPC: Use __kvm_faultin_pfn() to handle page
 faults on Book3s HV
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

Replace Book3s HV's homebrewed fault-in logic with __kvm_faultin_pfn(),
which functionally does pretty much the exact same thing.

Note, when the code was written, KVM indeed didn't do fast GUP without
"!atomic && !async", but that has long since changed (KVM tries fast GUP
for all writable mappings).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2f1d58984b41..f305395cf26e 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -603,27 +603,10 @@ int kvmppc_book3s_hv_page_fault(struct kvm_vcpu *vcpu,
 	write_ok = writing;
 	hva = gfn_to_hva_memslot(memslot, gfn);
 
-	/*
-	 * Do a fast check first, since __gfn_to_pfn_memslot doesn't
-	 * do it with !atomic && !async, which is how we call it.
-	 * We always ask for write permission since the common case
-	 * is that the page is writable.
-	 */
-	if (get_user_page_fast_only(hva, FOLL_WRITE, &page)) {
-		write_ok = true;
-	} else {
-		/* Call KVM generic code to do the slow-path check */
-		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
-					   writing, &write_ok);
-		if (is_error_noslot_pfn(pfn))
-			return -EFAULT;
-		page = NULL;
-		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-			if (PageReserved(page))
-				page = NULL;
-		}
-	}
+	pfn = __kvm_faultin_pfn(memslot, gfn, writing ? FOLL_WRITE : 0,
+				&write_ok, &page);
+	if (is_error_noslot_pfn(pfn))
+		return -EFAULT;
 
 	/*
 	 * Read the PTE from the process' radix tree and use that
-- 
2.46.0.rc1.232.g9752f9e123-goog



Return-Path: <linux-kernel+bounces-263912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76B93DC3F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179561C2325C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E5518FDDB;
	Fri, 26 Jul 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWQsKdPE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58C18FC97
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038114; cv=none; b=euAdX8wWWLIgGsuJ0TnEoPcSztTlcBRXEm4C7BMn4KSztqD3yaH33NVc151RbdLjfZXcORh/2FD2J6+4+iXdFTbvk3RinuzEF6VkkzK+NtFtt6rU5c9CKfb/hOvS61f4MfdJMjARP8m0JG1si9NXJ9jRSFaRn+d3XljfVmjA+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038114; c=relaxed/simple;
	bh=O9N2pQ58zHOs8mA5SBdaAy+6THp9s1eg8+6wg1nEqWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hD3Nl065qO/gsz19B2IZOxD2tn4YUG7Se0QHj5I4JhviXLbaCsrtk95+Rj70NQ9w7UtssRwItm1yqYrefm15XmsAtxUhrF/OyCglHWgsN7KcUj7ssxHFuuH605+1MeoG+hq/KKIF+CeNGGsJCDnmrmGTeIixMWWCKDLiPLiY1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWQsKdPE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b2fb62a07so450210276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038112; x=1722642912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hy7goaarUlwaWZyx1m4yCokRE7UoQ8eGBMKWJ4Hgr8=;
        b=pWQsKdPEjJ3K/ABVXUrqwiiZJ1hcSXiB40UXceg5KoEDcuMTyptzOrer+1tQIs58ck
         ipsRDvluKdAzfDpAStUZSD7F0k5s08cH6S+pEPYTtHcZEl+E7x/xWiLnq/3AZJU+E8Aw
         trN02GZlgbYHbNOFdoDGUWmHGgNEfn1q8IxLcKPiW94LhYP3Pcz2QH70Ez4wA1FoaLpF
         exegkvYneXnbVTnhQZszx2+IvyTBbDL5R2N3wuO9xihRpGP8rxH3mETiGqsiKexGE+P9
         nq4toqsot/CIVJrPStMAl8w08nqaqazX/R0GCV2wl8OKzzIHr4ViOPWTEpYTP0ruQ54C
         kTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038112; x=1722642912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Hy7goaarUlwaWZyx1m4yCokRE7UoQ8eGBMKWJ4Hgr8=;
        b=sLotAUWoWZj69kBvHZ+K0uKPw+W+S/E1jh4L94DRQPXoTq6sHy4bvVURG/PAG8Kfyn
         RMCUlMYN8ZmboMkjOH5yITfd2EZCR/X7n42uuUCi6iyhQn+P9K4+76KxZKYKL30d+jMm
         WdWT8JINIMETX1VaUaWC2788H6xTWQiY8vCE9f8fDGwVnOGatX7VIb0lxphXsb5fVH8h
         pP21rvJpQigeFIZe8M1Xala5Ahnxyq9cPsa09Nj9b7PEf5o9WbK1p6QKvxIGF/1u/lEh
         96b3wrgnN4TRi1sP+767CamfmmeG3jG/r3BtQ6iHuCfrUrWHRx/pAQyna1OChkrWLzBQ
         h/qg==
X-Forwarded-Encrypted: i=1; AJvYcCUt7aH/6GaBGw8UdJVGlWdbhqI0tyha/tmSXnOOFzcE99UCIZ/XPNvQfGgUVARHsUfrbkpHo6TlrDDow+Y7djI44OMzDnxpSe8g3APZ
X-Gm-Message-State: AOJu0YwSjFaPFG0zv9MI8DZRg8Ckgd8k6obEgqhdJ7xvX55JMxBbTKYZ
	dP3upFShAFH8VzcNJY5k9Q/xboaw9x5I8VZcbmGyvPhV9m4wmtfLXDWWzfwkh/qMQSzz70XFohI
	cEQ==
X-Google-Smtp-Source: AGHT+IH925MpsiY9ahug77TjXa70fcvLwqDVLsDqA/3N0vd70sZBQGqqpgNL91Lx+sGl/PSva06bFRo6+6A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b8c:b0:e03:b0b4:9456 with SMTP id
 3f1490d57ef6-e0b5454ca99mr43273276.7.1722038111873; Fri, 26 Jul 2024 16:55:11
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:23 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-75-seanjc@google.com>
Subject: [PATCH v12 74/84] KVM: Convert gfn_to_page() to use kvm_follow_pfn()
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

Convert gfn_to_page() to the new kvm_follow_pfn() internal API, which will
eventually allow removing gfn_to_pfn() and kvm_pfn_to_refcounted_page().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6dc448602751..d0f55a6ecb31 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3181,14 +3181,16 @@ EXPORT_SYMBOL_GPL(kvm_prefetch_pages);
  */
 struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
-	kvm_pfn_t pfn;
+	struct page *refcounted_page = NULL;
+	struct kvm_follow_pfn kfp = {
+		.slot = gfn_to_memslot(kvm, gfn),
+		.gfn = gfn,
+		.flags = FOLL_WRITE,
+		.refcounted_page = &refcounted_page,
+	};
 
-	pfn = gfn_to_pfn(kvm, gfn);
-
-	if (is_error_noslot_pfn(pfn))
-		return NULL;
-
-	return kvm_pfn_to_refcounted_page(pfn);
+	(void)kvm_follow_pfn(&kfp);
+	return refcounted_page;
 }
 EXPORT_SYMBOL_GPL(gfn_to_page);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog



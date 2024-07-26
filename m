Return-Path: <linux-kernel+bounces-263914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5631193DC46
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A051EB2A481
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83DE190470;
	Fri, 26 Jul 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLtaDUrv"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A88190054
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038117; cv=none; b=LomoRdxXPp+gzXgV/fuRh0npGiAcgXK70SgN5IlEx8OU1oxJ3c0Dug3af2DEeTPXqBhoTFBm9GnbR8PM62XYS3ZifnptlH3PqHRWTZ+pnf4yjXdwQnrqa4eEB6PtHsDdZzrC8c61YymV6jo6D/TaO+TYcacbli0rBXM6Hx6HUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038117; c=relaxed/simple;
	bh=SUUzhrURtkDY8ACwtRZFtnUrMpf+i7jwgURG3Mw5oko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQsH0QfWBXK31u/Kn9AalxafxioagLUc3DYqEomQ8FYYdJeR2W5PcgETdrIBFdcxc9l9YbDsLh7+ekvbhUFByTB6fIZ++gyBOslo2YkZV/8sDJ7iUMCUV8n/JY+w+qZA+UB1hqggMNUviMOo4x5qE/lwj8FSxSp8gxopu6whq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLtaDUrv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc658a161bso8414745ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038116; x=1722642916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gSJgbeqW0EjFVjI/rvx0LQaQxVZn1dW4kzDKJHwZpGY=;
        b=GLtaDUrveUqDcyxp5RkAvPoK0LtbkQw20aUgB3YddyaMWtw5CRqTBTDQbzB+Hgd0qd
         9wCtJF9OJqoVJeDtBeKP9q/bGjA46yy2rrnG6FJTtAqAtoqtJK3RGlM7dwUF6FBE5nAt
         mNnBOsY/ostoBhYnsM1dr/Xbst5EV5Hhp6VQhuj6iFHtKQ98k1QJGAn2b9gW4SutYrln
         WXS9dyjlgwC56rEpQnLAMb+RDLUYbCGyoDvdxZ0DKRfvV5/YR92FzIDbzDqkrOy9QU1Z
         rE/B942bUAwWakpd7ehQ33JecYeJmGXz2qhglZR0Jfd3Z4tvAVHQYSmRm5FJ/RpyItSt
         ty/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038116; x=1722642916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSJgbeqW0EjFVjI/rvx0LQaQxVZn1dW4kzDKJHwZpGY=;
        b=Co+Sj8QSNW3ZrCo2QhpirYxV4PzkGslo9aC7cTVIRZjJ7ICXSQY6ry/JsTiqzfoPZy
         TDCXRRKJUzrGTbOp7mZe9svCzpwLso+LKoe0AtcrO+6aFWJT1o8VztDu+D7ukdl/EwuB
         kGniRFy+HXq3JWbQc2I+j/+3L/MfVpHTKkD2MyHUJtAOALTNP99JS6t9p5LyO6m8JHqi
         3LKGNM3OjFgu38qY04v4mw7daD2+0yoAJs0GfG2DWAYNF91gYCwiP+qzXrn1Ao4guh6f
         QmoVzb1O0RU02KCHXU+F7LcjFuZaFUrfJoz9W3k7DnHBFRxX9ijX0PnIJZBGqofWUHCZ
         GOHg==
X-Forwarded-Encrypted: i=1; AJvYcCXzqTQqVfQGdqqLb/xeow8kn7uIj8dJBavbGiGr09U9BDECupn0ojXZ4clzt73fc6evNvQTEqzechPj/LbCsHrMKNI2VrEGprxip+sY
X-Gm-Message-State: AOJu0YyYxQXt3YXdr5koP5v4HKOpX1KwoDLcWM5IMq6cX0iF1MiO9Gdv
	MPJ3piHwmzwXRxHNxb2/8JkTA7WfJq8vmTrZBk6yhlrLNd50ODqeZyxbiwAl6hQouIIkz3AZgKQ
	W8A==
X-Google-Smtp-Source: AGHT+IHxrkKUWCeUEpiaW8aWqxkJkE+eVd4nhH8cGKa9NS3y3LrlRDBQyz/B78NptpquvhhjWf0asoH4ivY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c945:b0:1fc:733d:8465 with SMTP id
 d9443c01a7336-1ff0488cadamr599925ad.8.1722038115596; Fri, 26 Jul 2024
 16:55:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:25 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-77-seanjc@google.com>
Subject: [PATCH v12 76/84] KVM: arm64: Use __gfn_to_page() when copying MTE
 tags to/from userspace
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

Use __gfn_to_page() instead when copying MTE tags between guest and
userspace.  This will eventually allow removing gfn_to_pfn_prot(),
gfn_to_pfn(), kvm_pfn_to_refcounted_page(), and related APIs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/guest.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 962f985977c2..4cd7ffa76794 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1051,20 +1051,18 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 	}
 
 	while (length > 0) {
-		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
+		struct page *page = __gfn_to_page(kvm, gfn, write);
 		void *maddr;
 		unsigned long num_tags;
-		struct page *page;
 
-		if (is_error_noslot_pfn(pfn)) {
-			ret = -EFAULT;
-			goto out;
-		}
-
-		page = pfn_to_online_page(pfn);
 		if (!page) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (!pfn_to_online_page(page_to_pfn(page))) {
 			/* Reject ZONE_DEVICE memory */
-			kvm_release_pfn_clean(pfn);
+			kvm_release_page_unused(page);
 			ret = -EFAULT;
 			goto out;
 		}
@@ -1078,7 +1076,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 				/* No tags in memory, so write zeros */
 				num_tags = MTE_GRANULES_PER_PAGE -
 					clear_user(tags, MTE_GRANULES_PER_PAGE);
-			kvm_release_pfn_clean(pfn);
+			kvm_release_page_clean(page);
 		} else {
 			/*
 			 * Only locking to serialise with a concurrent
@@ -1093,8 +1091,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			if (num_tags != MTE_GRANULES_PER_PAGE)
 				mte_clear_page_tags(maddr);
 			set_page_mte_tagged(page);
-
-			kvm_release_pfn_dirty(pfn);
+			kvm_release_page_dirty(page);
 		}
 
 		if (num_tags != MTE_GRANULES_PER_PAGE) {
-- 
2.46.0.rc1.232.g9752f9e123-goog



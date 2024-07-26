Return-Path: <linux-kernel+bounces-263890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7893DBF5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E81C1F22763
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B7185E5D;
	Fri, 26 Jul 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugzgw1RF"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6B185614
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038066; cv=none; b=ll2ZHnFIS8ODfb5NYGVabLHcnWWxQE2VxSEp1/eFsiJaIqfcClRn8VgPPuVo1MGaJ4uKCx2KLkWF5GOHiHTbR5/qg+jG8IsDOyKuOt1YSQyOyhmRjOVAcb1ET4j9RMgUljFaYbWg4MNGnwy3t7FZVMWLDsaO5bOt7pH4jcU2A8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038066; c=relaxed/simple;
	bh=bY53gDaonSlIhoyFNY0EzYkmvr6M3Y58/Tqc7IOcPjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aBsCO/nAZclyo4ZFEKWXxB+cY1f5+UF5jfSnvmU80G5Sh5XX59TusVBRMaf9T3WdSzGOkS38PRdeMwrTcA7FnWDnmwCRZYW4TBP1okHPQGD1D0edg0uaOyztPLm4+jzxsoMX142jbcJbPbB3HcxwbxZVJXh+KHNPDFpcwVa1fJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugzgw1RF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc54c57a92so10629115ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038065; x=1722642865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WWjK/C8AJGiWvc7o48+tH+q+w9m6pJN61mgGRKL0h6o=;
        b=ugzgw1RF782T/j6dLllGrcx+8tYLnUM0lW2mw7yYYEGaplx6WxvFixXYIN+oexYOlg
         geRXk3tx4xYG3XoeSrFj27OJ7d5JxSM9Y+DMTGgXmj/nsAHqoe1/f9ujRff59eqLJVED
         /AF6WJRQgIq0Hjn9lMr34ANPMZwUAP23fB52788Fb3UtCHoWw/7cYZXellKcR8Yx+Trj
         R+JCn/zeEs7YljzI8jGxs72IEg+EEFoeIEzcLHMfUNlEUeo4Q//67RXnDdv1TGS3aRZt
         dz0z6jmMZzIvt/okahrqWsc0wAWncyhVVC38ephyElSxfs22AMHNlmp3Wvcin10/gfa5
         jFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038065; x=1722642865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWjK/C8AJGiWvc7o48+tH+q+w9m6pJN61mgGRKL0h6o=;
        b=H3OPzJq0d9ilEnu3IwvB0QwKiV/+AkDwTjz4GKdS3ZPn4TwYKIurFg5FVsYJ97DC3e
         Tc7iYdkAXJzuNDDc2NF15bmsqyv24UHym/xZQ/YUQtZIMofPm2x7yonCPfV328qyF00N
         gtmQafFOwmAaC8/LzV159IebAU9E7qz+8zj47RH/5gVdD+sL52WMIiDWT/TVTnj7EVSo
         61gNJ9aLtS5cTtzcOMofEd9uh/4vP9/iBI4UHJn+GxvonmRMOJAvwO8iTkQbXNxdGVoz
         sTQZaeVVvo+RHMSIec7AEFk+yT9oj0HdsqsWVRjHYwp2iIqbdNArUsEyi8VAorG0UVFM
         2yKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+vOj0lPm6j3Wmt7mVbj+VMLWJzUtvtw8/1pV3AiwXH4pYtfPNYxaMHE9oFhBI0RGNCdqqgT2x+y7zzkmBnoHAzzdRc0l2fbaCUB4l
X-Gm-Message-State: AOJu0YxIG/VFUVk1BJHy5QFRPOocGer0yrUBTaEXenFzxDbAJWI+7tJM
	mF3xiAsjAn1yoMIn23XEeuA5scYF6fu0iGfykLmXicslrHa87xy6SytsHkOQFM11jYIT7Jb8RPr
	OVQ==
X-Google-Smtp-Source: AGHT+IHjueGi4XHTR80VLKYNSmezTNqicqTjy1hjWkoeqfVxP7xL/6dlCTgQugjOLvFflviFEVZzvXY7ZzM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41c6:b0:1fb:80c5:ce5d with SMTP id
 d9443c01a7336-1ff047b2dd6mr400915ad.4.1722038064523; Fri, 26 Jul 2024
 16:54:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:01 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-53-seanjc@google.com>
Subject: [PATCH v12 52/84] KVM: PPC: e500: Mark "struct page" pfn accessed
 before dropping mmu_lock
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

Mark pages accessed before dropping mmu_lock when faulting in guest memory
so that shadow_map() can convert to kvm_release_faultin_page() without
tripping its lockdep assertion on mmu_lock being held.  Marking pages
accessed outside of mmu_lock is ok (not great, but safe), but marking
pages _dirty_ outside of mmu_lock can make filesystems unhappy.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 5c2adfd19e12..334dd96f8081 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -498,11 +498,9 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	kvmppc_mmu_flush_icache(pfn);
 
 out:
-	spin_unlock(&kvm->mmu_lock);
-
 	/* Drop refcount on page, so that mmu notifiers can clear it */
 	kvm_release_pfn_clean(pfn);
-
+	spin_unlock(&kvm->mmu_lock);
 	return ret;
 }
 
-- 
2.46.0.rc1.232.g9752f9e123-goog



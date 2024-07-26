Return-Path: <linux-kernel+bounces-263900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A193DC18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E034F1C203DA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71C158A3C;
	Fri, 26 Jul 2024 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEYzPOHA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85501891DA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038089; cv=none; b=YiS8ANEyPWNvsjwGdTIoP/maNIV7vtx6QCsGNTRSBN2QBELQiUJ9hH4FnjgVUMtmt69PhXJNNMjfwyBWWj1MB+Bjy0jeb0WPwRerYXkLWphh5Au76OwF22ZxmpMJtD37+0T2bRyT+6aIwNi6Y7LvuIJIwCF4XhJcVq7PQan3bm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038089; c=relaxed/simple;
	bh=W0AdvWeEkFlf//sy1P86MoI9zdYmxDa3lMGHJD2jZgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SlS9h7p23HzV5yb+9R1vCuC+FEKQEgj5pxsXqrccRDvtGmqYGzSfhbQqK37pUCPRZ3Sfh31L0sRPpeYNbEziui5DmaJp26dpzD+E0wy47SOYerR4d7DcGwcU8QuMv2tqoE89cHSHvfdNr7JFB9shUCVX7vEGmb2GZwwStrFwTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEYzPOHA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb5594a9f3so1506358a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038087; x=1722642887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oFlnnuKhNT9l8QiAImtf2ecgGSNucZgQMIB0EjCSaJA=;
        b=zEYzPOHArLl3k+CylZiR+cNBd2rqifEt1+jBsakJJObbB87w5MPICJsdn3R6tY0lB5
         QPPqfGWu2/hZDGQiX2JSMuja9xB+WVQ2ejrSHhxFogsVlmu4X6Pc7o3hazyv9rYoR2z4
         8ns86kvJDYb8v4xsWZavX7NkqGWBPfU/j3bRb4QnuUhvvpIQpb2asEJyfI4qwdh1+9gw
         3Jc0C6ukDVvtpNfi8zT6YzOfXHZNUmTtXE+g9jxmmHQvsIt9ScLMJGoizKA7usyOVuxV
         HOUK+ubi+ddfJ9ClpW3rBMhKJj6u5bUWB5B4VFOjNQWCmareS8HU4Hp/H0gk6NoaWVSL
         +ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038087; x=1722642887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFlnnuKhNT9l8QiAImtf2ecgGSNucZgQMIB0EjCSaJA=;
        b=v/LVoZf50GwjXaLzlTg6JxLKVbTtpFe+M4QZHcPPNmO8RZY2Y92RYoHUoJ7t5bYwRJ
         1w7Vcqf+VY/91m6nb02vuf7KVDHVsYQwa71P4CoDqkoRMw3IoQndgifzfx2uWtK2U/d2
         EjeQyXxvP9fLlobxfUqG5779NPZokriQa/R+g/iTYCGRazbGNoS3y39uDrhXGgj/f6wq
         FchTf51T8Rry4OXTis8KZ2+dEWVpAkrp5yUQrCAd6I7xHErRvrMZEh8HJzVg8EAAPx1+
         pEs81SEPSOHGFdEokU21bzS39W9ABhQyXoy2mMCczaDnJSf2o3WY0YK5tzIeqJGM/UlT
         s5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVmZnuAWfiIc+ZAWlj9xVMx5ccyvSaGhtcJtPEdcUWFh5RdD+Yu/sz6smCHpMTB+1OO1U2XMaVvc2Ay5d5gh8DGT4jJLgbxDWm4aBM3
X-Gm-Message-State: AOJu0Yy65p49dtmtGaP3t+RcASxSzaEV/88KCsx1l6DrRNkL4WjJwRDg
	Ep4z6CdWEYDi2Zy+jimxO5Yn4OJp5ZRhr0Y12Dn53FCQDxThPEEGnFVc+mJR78J7s9tXbJGf07b
	2Nw==
X-Google-Smtp-Source: AGHT+IHpYPU/r0yyvqEOzDrNXs+L4GUiZCI45y4AH9hPwSk8nxMjnSbjsFMJ0nzRNCC8+VosuScTVNX7UfA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4f8e:b0:2c9:9a89:a2ae with SMTP id
 98e67ed59e1d1-2cf7d4317d2mr2552a91.0.1722038086790; Fri, 26 Jul 2024 16:54:46
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:11 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-63-seanjc@google.com>
Subject: [PATCH v12 62/84] KVM: PPC: Book3S: Mark "struct page" pfns
 dirty/accessed after installing PTE
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

Mark pages/folios dirty/accessed after installing a PTE, and more
specifically after acquiring mmu_lock and checking for an mmu_notifier
invalidation.  Marking a page/folio dirty after it has been written back
can make some filesystems unhappy (backing KVM guests will such filesystem
files is uncommon, and the race is minuscule, hence the lack of complaints).
See the link below for details.

This will also allow converting Book3S to kvm_release_faultin_page(),
which requires that mmu_lock be held (for the aforementioned reason).

Link: https://lore.kernel.org/all/cover.1683044162.git.lstoakes@gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index bc6a381b5346..d0e4f7bbdc3d 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -121,13 +121,10 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 
 	vpn = hpt_vpn(orig_pte->eaddr, map->host_vsid, MMU_SEGSIZE_256M);
 
-	kvm_set_pfn_accessed(pfn);
 	if (!orig_pte->may_write || !writable)
 		rflags |= PP_RXRX;
-	else {
+	else
 		mark_page_dirty(vcpu->kvm, gfn);
-		kvm_set_pfn_dirty(pfn);
-	}
 
 	if (!orig_pte->may_execute)
 		rflags |= HPTE_R_N;
@@ -202,8 +199,11 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 	}
 
 out_unlock:
+	if (!orig_pte->may_write || !writable)
+		kvm_release_pfn_clean(pfn);
+	else
+		kvm_release_pfn_dirty(pfn);
 	spin_unlock(&kvm->mmu_lock);
-	kvm_release_pfn_clean(pfn);
 	if (cpte)
 		kvmppc_mmu_hpte_cache_free(cpte);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog



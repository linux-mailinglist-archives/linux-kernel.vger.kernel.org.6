Return-Path: <linux-kernel+bounces-263902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B993DC1F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F20A1C210FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B718C349;
	Fri, 26 Jul 2024 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8fhxbzx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19518A948
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038094; cv=none; b=OoxdjiPiYZ+/5YNzvMGxnqXOXSGXQ0oU2j48Ji+CNTTqYDq+axtB3RycuJoy2abQVXjhZekTFEGyUq82TXa1i0J651dM+JmxIBaELlBB9stXJ2wxAQiVa8WmTYnaUJmQ945t/McmsL1PXQv9bxezugjQZ66l54eLTA2iY/TDbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038094; c=relaxed/simple;
	bh=+UZ8VYtUvtsljZmzMl/1tyQmxGJndr+FFAuTaMIEbgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V9W3EsLMkQtxqdOf2fjpj66r45mQgikAohIDHsUHg3rJDMZcOwWlej6+RVq/LtCtIVsajWgEWN3vZfBSb4W17wRO4XI4IAkGD+uNuaPkPzM1Ru2UYfOg4H5OMO69+G1aUAb0acp9jyI5NqCPdziDW5vpRewBryurowdofVrhcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8fhxbzx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0872023b7dso463250276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038090; x=1722642890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XEv6FisOGr6vpV2eziQMsIEoEavMf3RHPa1v90mbDdU=;
        b=g8fhxbzxMjYe6ZLQfrHAHsBWxC6cxXhzdGPG8Zp+ckGWyAB/sw/M7MffrH4Pa1fopZ
         TrbHGVSARxRdxADLvNR5mhX1CjXn6oXTefVOfs91mZ1irT9OumbXjM/bkPjd6y11yThi
         hrXzuznv3R7cnWfQ1Pztd7B8LdjgW8eQ+CCcaVfB5ZTm92CpYeabX+vVMZG/dd0vbhJO
         ctgWNqa431V4kPr/axMdrwRPVdmagd0FDNtcf9rBoghwcaGo71nI6n3WvvVkEcwWdPAP
         D4VnkHZYn/VVZSYAfDnplg6cRFRuUVbmH8lJ93S5k4ijI/Rdyf5IXKqUkzZXPnMfWssI
         Py1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038090; x=1722642890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEv6FisOGr6vpV2eziQMsIEoEavMf3RHPa1v90mbDdU=;
        b=JE8DGN7GnWLDtGs8BgbkG8XVyjvxrUj+eDgBGzWh/hjjx/IirbqUAx/xBhl4OaM+7R
         pNIhfWpVwQlnNUOmbfnJv/+0zpuOTHHRKuscCqNlNunK1KObS9poey0AilupI+GG1wBr
         Vyd0PfGw+ri5YTdOZsPp2e3Cs70mRMUscsPO/MyD3WOvPv4WIb/R4IrOTVcItsigvHRr
         b9QnovjtqkxluZailQqcZFxePjcwo9bZRqHZTEcqQTsY+n/3/fBgPGP0gbdTQgJi2SXD
         7DgaM3Sjfc7GXUmmOvzohoBV4j32GHDzzfEVAUHYbDabwjPsVRVLeTDmQ19XXi1azTLy
         ZFog==
X-Forwarded-Encrypted: i=1; AJvYcCUODiovrzIJgEZpBHCKsuFeqwAkU/E5MF72Stb7zfYSw3ecCREQX4whZc6KBxXVKJ/OWz+deh8VxF9pZmAfGuht14HRolWpg61kHrWb
X-Gm-Message-State: AOJu0YxRRECUHUx5pGtSwf7/uKSg1LBUnPOxu4ataDFKl5k9q/QMNH8x
	m45ftXlesjKbC5Ywwu0CfhW4zWO4tTVSGdyHKVk8yYaNCuDWBWRJcJymFysegoF806iZCoquv9g
	XaQ==
X-Google-Smtp-Source: AGHT+IEFsToK4Mtfkt/isyLtzSbxuiJaEYiedQjj5sFCo8o3/vbFtfyZ9L8therJfArRWUvkwGk/K/B8SPA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1002:b0:e05:6961:6db3 with SMTP id
 3f1490d57ef6-e0b54503b59mr2236276.9.1722038090539; Fri, 26 Jul 2024 16:54:50
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:13 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-65-seanjc@google.com>
Subject: [PATCH v12 64/84] KVM: LoongArch: Mark "struct page" pfns dirty only
 in "slow" page fault path
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

Mark pages/folios dirty only the slow page fault path, i.e. only when
mmu_lock is held and the operation is mmu_notifier-protected, as marking a
page/folio dirty after it has been written back can make some filesystems
unhappy (backing KVM guests will such filesystem files is uncommon, and
the race is minuscule, hence the lack of complaints).

See the link below for details.

Link: https://lore.kernel.org/all/cover.1683044162.git.lstoakes@gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/loongarch/kvm/mmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 2634a9e8d82c..364dd35e0557 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -608,13 +608,13 @@ static int kvm_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa, bool writ
 		if (kvm_pte_young(changed))
 			kvm_set_pfn_accessed(pfn);
 
-		if (kvm_pte_dirty(changed)) {
-			mark_page_dirty(kvm, gfn);
-			kvm_set_pfn_dirty(pfn);
-		}
 		if (page)
 			put_page(page);
 	}
+
+	if (kvm_pte_dirty(changed))
+		mark_page_dirty(kvm, gfn);
+
 	return ret;
 out:
 	spin_unlock(&kvm->mmu_lock);
@@ -915,12 +915,14 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsigned long gpa, bool write)
 	else
 		++kvm->stat.pages;
 	kvm_set_pte(ptep, new_pte);
-	spin_unlock(&kvm->mmu_lock);
 
-	if (prot_bits & _PAGE_DIRTY) {
-		mark_page_dirty_in_slot(kvm, memslot, gfn);
+	if (writeable)
 		kvm_set_pfn_dirty(pfn);
-	}
+
+	spin_unlock(&kvm->mmu_lock);
+
+	if (prot_bits & _PAGE_DIRTY)
+		mark_page_dirty_in_slot(kvm, memslot, gfn);
 
 	kvm_release_pfn_clean(pfn);
 out:
-- 
2.46.0.rc1.232.g9752f9e123-goog



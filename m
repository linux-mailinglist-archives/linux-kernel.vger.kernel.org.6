Return-Path: <linux-kernel+bounces-359784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA69990B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE818281E47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A9201117;
	Thu, 10 Oct 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3ZB9Hl9"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45142010E9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584771; cv=none; b=R8hzqpR6LGFBcoofXSDDV5F/FOw4KrQ2PzH0ayKFYAMX0rpi/X+VkRZzqmqRb9J8mW7YIhxqVkzu+fnY/SF4Ct+shVYw5xVltnMV4ad38jf9sRTKJtLYxmLLfGVgekDdGkNQq05NITw0zG/P5EzMZMlee1RO67vyJn8e36w/lGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584771; c=relaxed/simple;
	bh=FOrzmk+4dQuoAh6BJ51EHAqwvBR4fq2vz5+jTHFfYUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQhzcmCd0MH6CyXGKdAU//lNi0d9oXRmJfICnlS5fgoDcu4JxGeZupgfi7yf2V911Fg7/ZCKBifq915oROSbjDZKtBYI5U4RaP5mftz6O/CvHlG/BgdEyPh/NJXeIUWtf7/7UjGsDvqNscSczGoPncOOUWi8FVFvoz+WaSKV+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3ZB9Hl9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c8b0b0736so7708565ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584769; x=1729189569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=551DSOChXG5A+yDanUyc1gC1jxg9ryEf27npUXDW1CE=;
        b=n3ZB9Hl9GSMKmEx/lUk3TOxxvmnE72q9Nb6QJN/j4oQK/ZZl7fEE+aU1iTmEyHusGF
         MvskZF7JItYNQUwaksK1w6E2W6vRxUpqG/GQskA591YhhwipexkEwz3mVDnMI35S5jsv
         Y4WSCAtt0cfpUgxFf5UIV/1sPoj+lv6W94JgPBO2jl9ksD7m1Suxh1wAL4H+VTW+S7Pw
         k0Dmcxek3i15MXvGlTyKrDmdYFW9aHLcUrFd1RXD7zqVAp9dLiiN4ZKuzQ+JtjjDKIk+
         B6ODMMAUkUqPGWTVvDQlBjpM7hat/NMris04mBqZ5fLmXqjpagd/DFoKuVvenG/nokos
         h98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584769; x=1729189569;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=551DSOChXG5A+yDanUyc1gC1jxg9ryEf27npUXDW1CE=;
        b=ldPApwT8bBPtTUp28o03sDocGvaY0s3Op+Q839duj2kYdSz1Z5hzKtRzgKmDLc4ON4
         HfeXH7P39rcRLD70agaqWm8CraCt/19Wvc2Daq9fjf0l6U6XYcx9JgHGVY+rbFmmqv6i
         xhX3Y3vrvKPSt7N/U+KGUsY96UMiWepfS/rCc0vDWp+NtIOG0BAtlG9vTCxs13uat1ck
         exMhZMnviYmThl1LIMjpIh9rps3gTFVoomK1P6xYFR0HTppgBUh9+ELQkmyW1YuRZhhA
         TbrcLa52hyHSSFE5ulEafVs/DMTNQzJm/msDaqFqdoWeH4tLi1GSGeL80Vje7wJqqUOP
         EHwA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Q8iwlM/1/9rY6W+wHqVVDcBibJRNFF5cA9a4ppbaYyHi5/wpFalCtf38SxAPmd+jYNVTpaXMgR/xICk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCDLKq6Z14CeWxcqOFsytHekBKZpBhvamjV17yNTYWOi8DOVf
	09Ya3FdsHuaqZm44mb6Uq5F0C+iHSu8DXnqxOH9h9OKYqJIhfss8PT7RTk2LFy2ccon2YetlD1M
	o7w==
X-Google-Smtp-Source: AGHT+IGKm7yq47izgr1FmkV+xWCQVhrzT+Qt86SXT8qqzZ7digIfsw6vfVxyVo72E4861BiCHpsXRIV5BzI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80f:b0:1fa:2ae7:cc6a with SMTP id
 d9443c01a7336-20c63722d7fmr648865ad.4.1728584768900; Thu, 10 Oct 2024
 11:26:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:39 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-38-seanjc@google.com>
Subject: [PATCH v13 37/85] KVM: x86/mmu: Add "mmu" prefix fault-in helpers to
 free up generic names
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
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Prefix x86's faultin_pfn helpers with "mmu" so that the mmu-less names can
be used by common KVM for similar APIs.

No functional change intended.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 19 ++++++++++---------
 arch/x86/kvm/mmu/mmu_internal.h |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 28f2b842d6ca..e451e1b9a55a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4347,8 +4347,8 @@ static u8 kvm_max_private_mapping_level(struct kvm *k=
vm, kvm_pfn_t pfn,
 	return max_level;
 }
=20
-static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
-				   struct kvm_page_fault *fault)
+static int kvm_mmu_faultin_pfn_private(struct kvm_vcpu *vcpu,
+				       struct kvm_page_fault *fault)
 {
 	int max_order, r;
=20
@@ -4371,10 +4371,11 @@ static int kvm_faultin_pfn_private(struct kvm_vcpu =
*vcpu,
 	return RET_PF_CONTINUE;
 }
=20
-static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault =
*fault)
+static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
+				 struct kvm_page_fault *fault)
 {
 	if (fault->is_private)
-		return kvm_faultin_pfn_private(vcpu, fault);
+		return kvm_mmu_faultin_pfn_private(vcpu, fault);
=20
 	fault->pfn =3D __gfn_to_pfn_memslot(fault->slot, fault->gfn, false, true,
 					  fault->write, &fault->map_writable);
@@ -4409,8 +4410,8 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, s=
truct kvm_page_fault *fault
 	return RET_PF_CONTINUE;
 }
=20
-static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *f=
ault,
-			   unsigned int access)
+static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
+			       struct kvm_page_fault *fault, unsigned int access)
 {
 	struct kvm_memory_slot *slot =3D fault->slot;
 	int ret;
@@ -4493,7 +4494,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, str=
uct kvm_page_fault *fault,
 	if (mmu_invalidate_retry_gfn_unsafe(vcpu->kvm, fault->mmu_seq, fault->gfn=
))
 		return RET_PF_RETRY;
=20
-	ret =3D __kvm_faultin_pfn(vcpu, fault);
+	ret =3D __kvm_mmu_faultin_pfn(vcpu, fault);
 	if (ret !=3D RET_PF_CONTINUE)
 		return ret;
=20
@@ -4570,7 +4571,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, s=
truct kvm_page_fault *fault
 	if (r)
 		return r;
=20
-	r =3D kvm_faultin_pfn(vcpu, fault, ACC_ALL);
+	r =3D kvm_mmu_faultin_pfn(vcpu, fault, ACC_ALL);
 	if (r !=3D RET_PF_CONTINUE)
 		return r;
=20
@@ -4661,7 +4662,7 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vc=
pu,
 	if (r)
 		return r;
=20
-	r =3D kvm_faultin_pfn(vcpu, fault, ACC_ALL);
+	r =3D kvm_mmu_faultin_pfn(vcpu, fault, ACC_ALL);
 	if (r !=3D RET_PF_CONTINUE)
 		return r;
=20
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_interna=
l.h
index 633aedec3c2e..59e600f6ff9d 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -235,7 +235,7 @@ struct kvm_page_fault {
 	/* The memslot containing gfn. May be NULL. */
 	struct kvm_memory_slot *slot;
=20
-	/* Outputs of kvm_faultin_pfn.  */
+	/* Outputs of kvm_mmu_faultin_pfn().  */
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
 	bool map_writable;
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.=
h
index 143b7e9f26dc..9bd3d6f5db91 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -812,7 +812,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, str=
uct kvm_page_fault *fault
 	if (r)
 		return r;
=20
-	r =3D kvm_faultin_pfn(vcpu, fault, walker.pte_access);
+	r =3D kvm_mmu_faultin_pfn(vcpu, fault, walker.pte_access);
 	if (r !=3D RET_PF_CONTINUE)
 		return r;
=20
--=20
2.47.0.rc1.288.g06298d1525-goog



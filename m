Return-Path: <linux-kernel+bounces-359791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95029990CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FE8287F50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3607204948;
	Thu, 10 Oct 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQ8YWjsA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D42038B7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584786; cv=none; b=RGS5S0zRFrBO4bzMLZsguTGV7HzBrNE2RzwseyOjMWBfwUqHm8dD8O5kgFv0jC1hs2eMWBPLcDF5SbhUme4S/FtgRJhOAif4FL+2H733q/zTNykTiC68XpOhArfttgd0i0ObN6m2nWy/IpTVKnbPcb7UmlhxoFeeWYmx3MW53GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584786; c=relaxed/simple;
	bh=Hkx6OqV7mFxqog7S2nXIkbHpJQToxM9/kCtdODEngY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mU7mqpW7NJGu9cr6Cr+DwdRO/3bNH5PvUGucC2ofmc+2fpo2ovftisgIlahOAnW9adRYC4054oHBJUb5pz5gJb+JsDWCV8EfkahhsqsxsXvWDMFf7don78sRMM89dLTwTHhejKa3EF4SKdcDUnWbx/1I+nugSA83Kni2d+sdTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQ8YWjsA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6818fa37eecso1273911a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584784; x=1729189584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O48RmE1hmLPs0qNEdPIh+k/rpCPu+e8A6GC4+tMXVMw=;
        b=bQ8YWjsAmSCtND2aP1+tnixLSReqcEMO5NgW5XaAIrBbL2LakVMBpTYBr79a6Ie4it
         yNo7Kq1xSA5MpJ+3LWpNyQ8FebCsfQePx6QL7MRRwa7HUCZ4EAISOfHABrJmf07r19dm
         vC7F1QJ2GzmgWC7lF+MFU+KbFzyvgv1xoyoqQgeGA7foloGcAJt5EuXt6aPoIbgmFg8d
         S+O2XvahdLb6BSZR7nlHR5Hzv2cmwMq+KpUVit9qdBBsIoaQJtbbi96Ot04RWV1vcYCh
         XiFcWmxVFgOdE1nBSgaaQ0SHKFiqMCAzj5V7S3qW2P8xyztxxmcbI6IW8VfCE4tAXTJs
         qhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584784; x=1729189584;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O48RmE1hmLPs0qNEdPIh+k/rpCPu+e8A6GC4+tMXVMw=;
        b=ZMg9Hy4S/wSbGR6A2xpszDsKu7sVPg9YLB1DrOr9BeexyGRPkH6QIn1nn6CWkMvFIP
         ZZPFvlyi8+/d4uFrGWnAoKD1x5pqgK3TKn9aPUf+QhpwA2JCzvMAAOuw+yOo4scvyVUh
         zuQ+7bRykYIO0BoAc9O9Hw8Fa1Ya6HnZ6dq/coMCmCjSz81j2Z7DxMsN6HNWRA2+0Ytk
         lRHS5wdDEYaqa0745lKOZlHTAfnPE3/KdePVebt7/zSDyHtLxusK+OlDdJssG0ik2Cwj
         uS8/XlIPh8oEtZiYSxP81QeNfhwKN8Gjnu4R8Q0nGpG0Rku4UOSzJV5OaVfJwrNzQjwK
         A45w==
X-Forwarded-Encrypted: i=1; AJvYcCWoTWsyhvz/P1JlRIqToA+wVtA7VFlhXLjYRU/ynHhmmDBA5FIYv5XnbmRZqyp69+K4/C6Bza6GRKiee/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGSc6h0I/XH8VdNJEEjVmXGCNTWUY8EH9xF2HJliiVit11/xR
	poG/vsqz+ZaSJPYzbLxhiG6UZBJI70zKWt9xMROGcNwvmkwiJ2H1AaQnWjTMOC7sjlveOBcHoE8
	ryA==
X-Google-Smtp-Source: AGHT+IGY3J0AFIsOlJbVDrqn6majLeEUOkcp3LAakwsbgSwDXT3SnAGgA9L20idMLdLGQvBeoRsHZDJxo50=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:2445:0:b0:75d:16f9:c075 with SMTP id
 41be03b00d2f7-7ea5359cd2amr19a12.9.1728584783356; Thu, 10 Oct 2024 11:26:23
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:46 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-45-seanjc@google.com>
Subject: [PATCH v13 44/85] KVM: x86/mmu: Convert page fault paths to kvm_faultin_pfn()
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

Convert KVM x86 to use the recently introduced __kvm_faultin_pfn().
Opportunstically capture the refcounted_page grabbed by KVM for use in
future changes.

No functional change intended.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 14 ++++++++++----
 arch/x86/kvm/mmu/mmu_internal.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f730870887dd..2e2076287aaf 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4416,11 +4416,14 @@ static int kvm_mmu_faultin_pfn_private(struct kvm_v=
cpu *vcpu,
 static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				 struct kvm_page_fault *fault)
 {
+	unsigned int foll =3D fault->write ? FOLL_WRITE : 0;
+
 	if (fault->is_private)
 		return kvm_mmu_faultin_pfn_private(vcpu, fault);
=20
-	fault->pfn =3D __gfn_to_pfn_memslot(fault->slot, fault->gfn, false, true,
-					  fault->write, &fault->map_writable);
+	foll |=3D FOLL_NOWAIT;
+	fault->pfn =3D __kvm_faultin_pfn(fault->slot, fault->gfn, foll,
+				       &fault->map_writable, &fault->refcounted_page);
=20
 	/*
 	 * If resolving the page failed because I/O is needed to fault-in the
@@ -4447,8 +4450,11 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vc=
pu,
 	 * to wait for IO.  Note, gup always bails if it is unable to quickly
 	 * get a page and a fatal signal, i.e. SIGKILL, is pending.
 	 */
-	fault->pfn =3D __gfn_to_pfn_memslot(fault->slot, fault->gfn, true, true,
-					  fault->write, &fault->map_writable);
+	foll |=3D FOLL_INTERRUPTIBLE;
+	foll &=3D ~FOLL_NOWAIT;
+	fault->pfn =3D __kvm_faultin_pfn(fault->slot, fault->gfn, foll,
+				       &fault->map_writable, &fault->refcounted_page);
+
 	return RET_PF_CONTINUE;
 }
=20
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_interna=
l.h
index 59e600f6ff9d..fabbea504a69 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -238,6 +238,7 @@ struct kvm_page_fault {
 	/* Outputs of kvm_mmu_faultin_pfn().  */
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
+	struct page *refcounted_page;
 	bool map_writable;
=20
 	/*
--=20
2.47.0.rc1.288.g06298d1525-goog



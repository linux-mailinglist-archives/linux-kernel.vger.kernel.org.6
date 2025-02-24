Return-Path: <linux-kernel+bounces-530278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25862A43158
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C143A83DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112B20CCEB;
	Mon, 24 Feb 2025 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIP8ZGMm"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1631DDC00
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441348; cv=none; b=EEUdHF8S5vHCqYPmCKvsn2kN+5pQr5xAbUTQbneYtBMk85xoU6c/p4WwKcywm1GY3ibcsVmHAZx3GVGKJOfxKpum7kM7qo5Bzgh6P0K5bJq+llwZKB76oiyU93HeAPxZXBrRQvhrCowOy6gYXQiWr8e7e2N+HBk7LelMNtl7R5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441348; c=relaxed/simple;
	bh=fpVjeXd5rg+V58pvlPmJutDsFmmNiVg4yf0bC+o5Rnk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o+tpPKKm2Y7YZVFqSGjJYoOJHWoITPRmzjGmlbCNrCDSWxvqw+Q3QU5RDarhzcqi0J2jrf37kBzjFk8BrNDMK+SDsV+PRRI7sPaOuscgiCYHbfroej7bntQx9sOqpupjmMbgz66qLQ/Vf9Gt3s2VfxiXUWswrzVip02a5X7ob5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIP8ZGMm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so10741797a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740441345; x=1741046145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4yv5E3Df19Io1ieaPGo0Ai9BtJpUzyQSBdyF3aMs18=;
        b=RIP8ZGMmB61Rv3GOrTcYpyUFFyTOo/AuJ+dzjSlZDea/ejkc//73Det7qtKuesc3X4
         lQbYP2es8zxN/gYiSiGf3vi+NNy2FW+5v58z2IezRD1/r8xiy5MSGOP+ZSNwusxg7ou9
         bfrlJrrAyS4yKTHbJH7STB/IY9wcEfoXXZqfcoLCI/RdOlDuGy3JkwUWL7im5b/MDep3
         gjSy3jOqUA+1n+SNSfMk02Do8/jmC34JFYfi/aZ6KeWJwJ08nQY2aP4IKXbheBCi5d75
         1rAAMAy3ZH57gZ6PPDi67ur9AfZaeLCezTtas2ofLHLdhJDskEd6XasZ8Mpvky3vXspr
         g3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740441345; x=1741046145;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4yv5E3Df19Io1ieaPGo0Ai9BtJpUzyQSBdyF3aMs18=;
        b=cko/wZcTAznVI/zNLBQMsgY/fXXwh5qimhSfJ2vC5ro44MWsoHh649t73GLu0KArT2
         lmVjzuc6SYgiGLZy/I3D554j7ai9gqpe2tAvO6XNvgQrBnlcM0yR/0P1NYCpU/f5oIyQ
         Jhd92/sP9OHvWK1IhsDW55+rMSc/yE95XBZEJCHSqkRxyCb4M9bZ+YUuk8FkU9sZfOtb
         KxWZet/22a0fQVlOsSKeYPCCchmfOQSEiD0LRK/rT0l7ZXg1fmnkQxS7q6Ow7lVCT9M0
         B2PHVFbZyfVuE50smDC4Xj2ski6PP8vIFPvda872rsn5lXUju615PqMyejY5sTH0Yjpg
         P4jA==
X-Forwarded-Encrypted: i=1; AJvYcCU5JUd7/tm4XfVxT02eRJv6hcUlT4W5qETizOHFbDmAVoN9hvXIMxOlr3Oy2X29+QxKCWUUIWO4cOaDlGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsaQ4+oy76svRRxTGCSbzTw0vjwBmzlkEzw8AoX0t62WcuHez
	rwB92lzVfcGoWXIteRbfCyad+4atfNaNwOpfNH4mAnYEDWtlFEhCmFjhp2jGeN8rppXfkE/9v/y
	uxQ==
X-Google-Smtp-Source: AGHT+IF6C3DtzvfIloHEkiuLmfsYJNF5ywoI3G+Dg7xZ6ws28dsFaD6h16rXeHiPC/2N2WbxQdNYNz9BqGc=
X-Received: from pjbsd8.prod.google.com ([2002:a17:90b:5148:b0:2ea:5613:4d5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5292:b0:2ee:7c65:ae8e
 with SMTP id 98e67ed59e1d1-2fce77a638fmr26853663a91.11.1740441345356; Mon, 24
 Feb 2025 15:55:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 15:55:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224235542.2562848-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: x86: nVMX IRQ fix and VM teardown cleanups
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Aaron Lewis <aaronlewis@google.com>, Jim Mattson <jmattson@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"

This was _supposed_ to be a tiny one-off patch to fix a nVMX bug where KVM
fails to detect that, after nested VM-Exit, L1 has a pending IRQ (or NMI).
But because x86's nested teardown flows are garbage (KVM simply forces a
nested VM-Exit to put the vCPU back into L1), that simple fix snowballed.

The immediate issue is that checking for a pending interrupt accesses the
legacy PIC, and x86's kvm_arch_destroy_vm() currently frees the PIC before
destroying vCPUs, i.e. checking for IRQs during the forced nested VM-Exit
results in a NULL pointer deref (or use-after-free if KVM didn't nullify
the PIC pointer).  That's patch 1.

Patch 2 is the original nVMX fix.

The remaining patches attempt to bring a bit of sanity to x86's VM
teardown code, which has accumulated a lot of cruft over the years.  E.g.
KVM currently unloads each vCPU's MMUs in a separate operation from
destroying vCPUs, all because when guest SMP support was added, KVM had a
kludgy MMU teardown flow that broken when a VM had more than one 1 vCPU.
And that oddity lived on, for 18 years...

Sean Christopherson (7):
  KVM: x86: Free vCPUs before freeing VM state
  KVM: nVMX: Process events on nested VM-Exit if injectable IRQ or NMI
    is pending
  KVM: Assert that a destroyed/freed vCPU is no longer visible
  KVM: x86: Don't load/put vCPU when unloading its MMU during teardown
  KVM: x86: Unload MMUs during vCPU destruction, not before
  KVM: x86: Fold guts of kvm_arch_sync_events() into
    kvm_arch_pre_destroy_vm()
  KVM: Drop kvm_arch_sync_events() now that all implementations are nops

 arch/arm64/include/asm/kvm_host.h     |  2 --
 arch/loongarch/include/asm/kvm_host.h |  1 -
 arch/mips/include/asm/kvm_host.h      |  1 -
 arch/powerpc/include/asm/kvm_host.h   |  1 -
 arch/riscv/include/asm/kvm_host.h     |  2 --
 arch/s390/include/asm/kvm_host.h      |  1 -
 arch/x86/kvm/vmx/nested.c             | 11 +++++++
 arch/x86/kvm/x86.c                    | 42 ++++++++++-----------------
 include/linux/kvm_host.h              |  1 -
 virt/kvm/kvm_main.c                   |  9 +++++-
 10 files changed, 34 insertions(+), 37 deletions(-)


base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.658.g4767266eb4-goog



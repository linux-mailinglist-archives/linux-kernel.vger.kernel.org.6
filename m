Return-Path: <linux-kernel+bounces-530284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D2A4316E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855721888A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F7212D67;
	Mon, 24 Feb 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZ27Tmm+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1A20E71B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441359; cv=none; b=Dr3b9uzGXmJzbFBnUA0Wo2kZcyKLSFVucfRve4pkhjku3heX5e5mvilY7bCZ8UcxIH/32F1AgsbmHF/epY7cjF24Zj7Z2QN41uN8kbGLGt6O2y6nFvJZNSemDZN6Jhl/sXDIyF7yp3orugryAMpF26U0nOkPl2+2d/J4FOS6ihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441359; c=relaxed/simple;
	bh=RyQAx7Z5zYd41S/+BHB5zwIwQj3p0JUw5qeOKaGY3V4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rn3vaaBQ8FcT9GUNqNImT4I+/TYM6yAWFwNaAHiJJb3RZ0ogJGfqlDTBCJF8HHAabDDvdWPxhv7GD3Pnyjj6LXoMrL4QGn316+eso4z3R75k77ff1pcLccI7ctjN13DzpTgZR/ueAFvZBJeKmCtjD/Q5zEknVgvdof8aTU5JTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZ27Tmm+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220bf94cb40so74652455ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740441356; x=1741046156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TJTgZNhYY30nXxMYJRDXX1rx/rqsWdUW6nwlsEZr+Zo=;
        b=BZ27Tmm+0QH19zZj62ZGEh+dxD7t/20Btf+JCNALcqii6YqEJSTX0ElCdk9HTL/pHI
         Qme7R9yhgjGvb5Dkb+t0yEOMAXYbwC41zTcaKD+OBdts8dhV2/Gt0pCkD6/6Ye50cAmZ
         +ZoRLnoV0vDSYZe2xiWYCtX7ff8RrANGFRoWP/4CwFqZZjqgeg0tYKDaazJPH/J5NcKL
         VHPXZ/F1o+HyFqX2fzI2bhmhwlPVW18ya00Pv4pg2DXGL9t0CatOeP0u5Igc1bk4U1VB
         hjL40TUmBPsRlmjqymJP21V/lh9UJ3q5QOn43Jm8UJhiAdzS65GXPW12SrEqP00WyjlT
         lY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740441356; x=1741046156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJTgZNhYY30nXxMYJRDXX1rx/rqsWdUW6nwlsEZr+Zo=;
        b=raVr1+VYcHLdNyjDGGGnirOuM74K3MgOrOup2G8YnWEMMVZ3LwyqCWQBn56iZFBqp9
         CJDgJqI0IfVHlGXAgHQHqZk/j61RFelNhjeN5ETNI9QNy6f7sgFsmC+mqKepoi9Ftond
         O908vUzuNXAzMLTnbJXaXdSJ/gwOl7Vpn99PZVDYnVqYdSrEv21N/BhDPi/E7RlT0ux4
         KmX1AUqQOpuBJq4i9IJ+4hy1vWCDR5U55NWcLW7m//9fXdggm5fd0V6KJJMvk1OTjbMl
         LpBWMdW6usiAE4RkCr4x1ZKCCG04bBGFAZCoPy+KFglaCQ0HkEBrOzDouuuQpW3oKUcI
         WZrA==
X-Forwarded-Encrypted: i=1; AJvYcCV7KwNEJ0sOCA8nj3gtzHcxsHmk/5cpxawSBz+fyOF/NJ/s7htG82b/xcRP4sdjMrprbo9y9+n1/ZAaIFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOGXx7SY7CIIaMpHhlKCY/Kd3mW0I3o/T2HW7vejZgUMktSWN
	8Fjjg4z0y3Kk8m5KqvCf0L7TfCdpGa3kyeQi+P91T+SsA+RBGBDPum+jd19fdyylpslLggZuNiQ
	KXQ==
X-Google-Smtp-Source: AGHT+IHgthprmvsK7rAfh+PsqOM1pat7xQuGm72FmKpfdI+qTOt1cCxKN5aFSZszJT1EFJi9jy4pNoVXfJY=
X-Received: from pfbig2.prod.google.com ([2002:a05:6a00:8b82:b0:730:7c03:35e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1947:b0:732:623e:2bdc
 with SMTP id d2e1a72fcca58-73426c84885mr24369761b3a.2.1740441355733; Mon, 24
 Feb 2025 15:55:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 15:55:41 -0800
In-Reply-To: <20250224235542.2562848-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224235542.2562848-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224235542.2562848-7-seanjc@google.com>
Subject: [PATCH 6/7] KVM: x86: Fold guts of kvm_arch_sync_events() into kvm_arch_pre_destroy_vm()
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

Fold the guts of kvm_arch_sync_events() into kvm_arch_pre_destroy_vm(), as
the kvmclock and PIT background workers only need to be stopped before
destroying vCPUs (to avoid accessing vCPUs as they are being freed); it's
a-ok for them to be running while the VM is visible on the global vm_list.

Note, the PIT also needs to be stopped before IRQ routing is freed
(because KVM's IRQ routing is garbage and assumes there is always non-NULL
routing).

Opportunistically add comments to explain why KVM stops/frees certain
assets early.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a61dbd1f0d01..ea445e6579f1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12772,9 +12772,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 void kvm_arch_sync_events(struct kvm *kvm)
 {
-	cancel_delayed_work_sync(&kvm->arch.kvmclock_sync_work);
-	cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
-	kvm_free_pit(kvm);
+
 }
 
 /**
@@ -12855,6 +12853,17 @@ EXPORT_SYMBOL_GPL(__x86_set_memory_region);
 
 void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 {
+	/*
+	 * Stop all background workers and kthreads before destroying vCPUs, as
+	 * iterating over vCPUs in a different task while vCPUs are being freed
+	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
+	 * be stopped before IRQ routing is freed.
+	 */
+	cancel_delayed_work_sync(&kvm->arch.kvmclock_sync_work);
+	cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
+
+	kvm_free_pit(kvm);
+
 	kvm_mmu_pre_destroy_vm(kvm);
 }
 
-- 
2.48.1.658.g4767266eb4-goog



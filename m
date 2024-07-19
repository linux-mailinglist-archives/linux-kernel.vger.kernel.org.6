Return-Path: <linux-kernel+bounces-257466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F49937A78
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D736B1F22C09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C2B14901B;
	Fri, 19 Jul 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UpdvxLYW"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD414659B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405398; cv=none; b=tb2RtZtkE7kt+98wkUM0OgqvYH6hMM3phwoS0y9LCTiwBVG+qPOGHJnHIXFLkyYYpVQ4iCdoxJcoA3Ru5Kbyvv2zO/Nj2zwj59VyQ/fKpaw954b+0mDkWa3RZeGq1sqWCJXbeQuUSiu3oFV46x+fAWZZdphrPuYUVKVijmRjmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405398; c=relaxed/simple;
	bh=rpxtAxfEfA2mxlrGJvIVU35coRMUNLXwu/xMJgqejpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faxR9Oy/+ZwkHLDEfMEEBIOCmxnb1vRMw8Y3t72qlCi5vf8WwoI9QxzZljT19cFyzC5sfPLcv6dvrgCdJUlEqB2Q6IvBRmWVqjWYgm2JbGtSceg22Gx0yKG/fURypsq1Y36861VZ6p3kVgsadHEvPvMJ0CuO+dByBEDEggtfnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UpdvxLYW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so13758595ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721405396; x=1722010196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsurUNCBwKbasFP+LQ4AwV8kcPbxaWWGXZnVmJhCYpY=;
        b=UpdvxLYWDHMJcdkiif8aHxNRySHBEQPO5ygfwadk/Mz1+dQpwObQkaXNL/Bh0K/Vwz
         bplpZNJaQjheHEny9GklJsZ6YJRRak4obFGNVoroIzb6LSE6Km0clC6ixe5cwPjSfOVY
         +vT+KvnvSHsRG6KT1lcgZ4SvtSPsUea2rMOSsKVVR8RSvIH8QMoVzRfI/WbVC8VwRN94
         2FATJJFhoRujE1sc1mACEUhBRQFWWLQVLCFnXtP431ABgVLahHbDVeKaTO7ErOwoGTMc
         s8uAW1rdsDdlv9F8PxuxA7e1ldEVGU0vWdWrcvJ41KBR0/lBPKsSGCDjYlu1+MfU46KQ
         cR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405396; x=1722010196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsurUNCBwKbasFP+LQ4AwV8kcPbxaWWGXZnVmJhCYpY=;
        b=m6gtHlVAfYESYvSIaUzRwqC8zULyiHFkCAeoSJV1W9jxh1f4Jq3wmKrKsjyI8/ViCk
         sk3V3WM9cSBoWEMM6WsSjH+7QFZnI1YUwQ8DDsTAoHc/fRCVaXPi2h0e0NhGwC45Wybn
         BqCUhRG5Orw1T5UUINDes1p0diAxrKMdCjt86lOEZ2SpUdfNDzkWYJvVkAF+qbjN9DId
         isZgNWkroGRCfTJtpQPmPsoYtXavdhbhwYNKNPLxbTlKFQzXf+mqbEt5fFw/ty6g47Vq
         8+chxvzfjYOLWZIkHZeqSlS/oJyBvmTO2gD5ZzVDITuJuHs/J84mDck0CtyyQImVQ9gq
         hRjA==
X-Forwarded-Encrypted: i=1; AJvYcCW1YH1DsdAR9dtY2jF1b+YZu5zuE8XZAKm0FTc/dwXhy2yVdw5pNJSEHkA6Bv4IUE+ZTNmLFZl2r4XZmI3oivyX+HkbkJELrdeA0p18
X-Gm-Message-State: AOJu0YxKt85vAdjndMOEEhmnRhJ2zU3B6AkMJkpv2ZI+EC+sJe/7tsXA
	TIvhoLMcnfdrCoHkpXnQOuu1m2OeFA4MVmhKLJyQtonODmyQ/4s3i1ZyKdv6SzM=
X-Google-Smtp-Source: AGHT+IFt4vd1+c8reh4Ha+aYln2xe2c29bGKPEtqrRXGFbhD4f57xNlONljHLht5FR4B0fjb/WuV9g==
X-Received: by 2002:a17:903:182:b0:1fb:8924:df95 with SMTP id d9443c01a7336-1fd7466af15mr2373085ad.48.1721405396302;
        Fri, 19 Jul 2024 09:09:56 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([223.185.135.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f518sm6632615ad.69.2024.07.19.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:09:55 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 09/13] RISC-V: KVM: Use nacl_csr_xyz() for accessing H-extension CSRs
Date: Fri, 19 Jul 2024 21:39:09 +0530
Message-Id: <20240719160913.342027-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719160913.342027-1-apatel@ventanamicro.com>
References: <20240719160913.342027-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running under some other hypervisor, prefer nacl_csr_xyz()
for accessing H-extension CSRs in the run-loop. This makes CSR
access faster whenever SBI nested acceleration is available.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/mmu.c        |   4 +-
 arch/riscv/kvm/vcpu.c       | 103 +++++++++++++++++++++++++-----------
 arch/riscv/kvm/vcpu_timer.c |  28 +++++-----
 3 files changed, 87 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index b63650f9b966..45ace9138947 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -15,7 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/kvm_host.h>
 #include <linux/sched/signal.h>
-#include <asm/csr.h>
+#include <asm/kvm_nacl.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
@@ -732,7 +732,7 @@ void kvm_riscv_gstage_update_hgatp(struct kvm_vcpu *vcpu)
 	hgatp |= (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
 	hgatp |= (k->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
 
-	csr_write(CSR_HGATP, hgatp);
+	ncsr_write(CSR_HGATP, hgatp);
 
 	if (!kvm_riscv_gstage_vmid_bits())
 		kvm_riscv_local_hfence_gvma_all();
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 957e1a5e081b..00baaf1b0136 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -17,8 +17,8 @@
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/kvm_host.h>
-#include <asm/csr.h>
 #include <asm/cacheflush.h>
+#include <asm/kvm_nacl.h>
 #include <asm/kvm_vcpu_vector.h>
 
 #define CREATE_TRACE_POINTS
@@ -361,10 +361,10 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
 	/* Read current HVIP and VSIE CSRs */
-	csr->vsie = csr_read(CSR_VSIE);
+	csr->vsie = ncsr_read(CSR_VSIE);
 
 	/* Sync-up HVIP.VSSIP bit changes does by Guest */
-	hvip = csr_read(CSR_HVIP);
+	hvip = ncsr_read(CSR_HVIP);
 	if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
 		if (hvip & (1UL << IRQ_VS_SOFT)) {
 			if (!test_and_set_bit(IRQ_VS_SOFT,
@@ -561,26 +561,49 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	void *nsh;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
 
-	csr_write(CSR_VSSTATUS, csr->vsstatus);
-	csr_write(CSR_VSIE, csr->vsie);
-	csr_write(CSR_VSTVEC, csr->vstvec);
-	csr_write(CSR_VSSCRATCH, csr->vsscratch);
-	csr_write(CSR_VSEPC, csr->vsepc);
-	csr_write(CSR_VSCAUSE, csr->vscause);
-	csr_write(CSR_VSTVAL, csr->vstval);
-	csr_write(CSR_HEDELEG, cfg->hedeleg);
-	csr_write(CSR_HVIP, csr->hvip);
-	csr_write(CSR_VSATP, csr->vsatp);
-	csr_write(CSR_HENVCFG, cfg->henvcfg);
-	if (IS_ENABLED(CONFIG_32BIT))
-		csr_write(CSR_HENVCFGH, cfg->henvcfg >> 32);
-	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
-		csr_write(CSR_HSTATEEN0, cfg->hstateen0);
+	if (kvm_riscv_nacl_sync_csr_available()) {
+		nsh = nacl_shmem();
+		nacl_csr_write(nsh, CSR_VSSTATUS, csr->vsstatus);
+		nacl_csr_write(nsh, CSR_VSIE, csr->vsie);
+		nacl_csr_write(nsh, CSR_VSTVEC, csr->vstvec);
+		nacl_csr_write(nsh, CSR_VSSCRATCH, csr->vsscratch);
+		nacl_csr_write(nsh, CSR_VSEPC, csr->vsepc);
+		nacl_csr_write(nsh, CSR_VSCAUSE, csr->vscause);
+		nacl_csr_write(nsh, CSR_VSTVAL, csr->vstval);
+		nacl_csr_write(nsh, CSR_HEDELEG, cfg->hedeleg);
+		nacl_csr_write(nsh, CSR_HVIP, csr->hvip);
+		nacl_csr_write(nsh, CSR_VSATP, csr->vsatp);
+		nacl_csr_write(nsh, CSR_HENVCFG, cfg->henvcfg);
+		if (IS_ENABLED(CONFIG_32BIT))
+			nacl_csr_write(nsh, CSR_HENVCFGH, cfg->henvcfg >> 32);
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
+			nacl_csr_write(nsh, CSR_HSTATEEN0, cfg->hstateen0);
+			if (IS_ENABLED(CONFIG_32BIT))
+				nacl_csr_write(nsh, CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
+		}
+	} else {
+		csr_write(CSR_VSSTATUS, csr->vsstatus);
+		csr_write(CSR_VSIE, csr->vsie);
+		csr_write(CSR_VSTVEC, csr->vstvec);
+		csr_write(CSR_VSSCRATCH, csr->vsscratch);
+		csr_write(CSR_VSEPC, csr->vsepc);
+		csr_write(CSR_VSCAUSE, csr->vscause);
+		csr_write(CSR_VSTVAL, csr->vstval);
+		csr_write(CSR_HEDELEG, cfg->hedeleg);
+		csr_write(CSR_HVIP, csr->hvip);
+		csr_write(CSR_VSATP, csr->vsatp);
+		csr_write(CSR_HENVCFG, cfg->henvcfg);
 		if (IS_ENABLED(CONFIG_32BIT))
-			csr_write(CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
+			csr_write(CSR_HENVCFGH, cfg->henvcfg >> 32);
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
+			csr_write(CSR_HSTATEEN0, cfg->hstateen0);
+			if (IS_ENABLED(CONFIG_32BIT))
+				csr_write(CSR_HSTATEEN0H, cfg->hstateen0 >> 32);
+		}
 	}
 
 	kvm_riscv_gstage_update_hgatp(vcpu);
@@ -603,6 +626,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	void *nsh;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
 	vcpu->cpu = -1;
@@ -618,15 +642,28 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 					 vcpu->arch.isa);
 	kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context);
 
-	csr->vsstatus = csr_read(CSR_VSSTATUS);
-	csr->vsie = csr_read(CSR_VSIE);
-	csr->vstvec = csr_read(CSR_VSTVEC);
-	csr->vsscratch = csr_read(CSR_VSSCRATCH);
-	csr->vsepc = csr_read(CSR_VSEPC);
-	csr->vscause = csr_read(CSR_VSCAUSE);
-	csr->vstval = csr_read(CSR_VSTVAL);
-	csr->hvip = csr_read(CSR_HVIP);
-	csr->vsatp = csr_read(CSR_VSATP);
+	if (kvm_riscv_nacl_available()) {
+		nsh = nacl_shmem();
+		csr->vsstatus = nacl_csr_read(nsh, CSR_VSSTATUS);
+		csr->vsie = nacl_csr_read(nsh, CSR_VSIE);
+		csr->vstvec = nacl_csr_read(nsh, CSR_VSTVEC);
+		csr->vsscratch = nacl_csr_read(nsh, CSR_VSSCRATCH);
+		csr->vsepc = nacl_csr_read(nsh, CSR_VSEPC);
+		csr->vscause = nacl_csr_read(nsh, CSR_VSCAUSE);
+		csr->vstval = nacl_csr_read(nsh, CSR_VSTVAL);
+		csr->hvip = nacl_csr_read(nsh, CSR_HVIP);
+		csr->vsatp = nacl_csr_read(nsh, CSR_VSATP);
+	} else {
+		csr->vsstatus = csr_read(CSR_VSSTATUS);
+		csr->vsie = csr_read(CSR_VSIE);
+		csr->vstvec = csr_read(CSR_VSTVEC);
+		csr->vsscratch = csr_read(CSR_VSSCRATCH);
+		csr->vsepc = csr_read(CSR_VSEPC);
+		csr->vscause = csr_read(CSR_VSCAUSE);
+		csr->vstval = csr_read(CSR_VSTVAL);
+		csr->hvip = csr_read(CSR_HVIP);
+		csr->vsatp = csr_read(CSR_VSATP);
+	}
 }
 
 static void kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
@@ -681,7 +718,7 @@ static void kvm_riscv_update_hvip(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
-	csr_write(CSR_HVIP, csr->hvip);
+	ncsr_write(CSR_HVIP, csr->hvip);
 	kvm_riscv_vcpu_aia_update_hvip(vcpu);
 }
 
@@ -728,7 +765,9 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 	kvm_riscv_vcpu_swap_in_guest_state(vcpu);
 	guest_state_enter_irqoff();
 
-	hcntx->hstatus = csr_swap(CSR_HSTATUS, gcntx->hstatus);
+	hcntx->hstatus = ncsr_swap(CSR_HSTATUS, gcntx->hstatus);
+
+	nsync_csr(-1UL);
 
 	__kvm_riscv_switch_to(&vcpu->arch);
 
@@ -863,8 +902,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		trap.sepc = vcpu->arch.guest_context.sepc;
 		trap.scause = csr_read(CSR_SCAUSE);
 		trap.stval = csr_read(CSR_STVAL);
-		trap.htval = csr_read(CSR_HTVAL);
-		trap.htinst = csr_read(CSR_HTINST);
+		trap.htval = ncsr_read(CSR_HTVAL);
+		trap.htinst = ncsr_read(CSR_HTINST);
 
 		/* Syncup interrupts state with HW */
 		kvm_riscv_vcpu_sync_interrupts(vcpu);
diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 75486b25ac45..96e7a4e463f7 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -11,8 +11,8 @@
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
 #include <clocksource/timer-riscv.h>
-#include <asm/csr.h>
 #include <asm/delay.h>
+#include <asm/kvm_nacl.h>
 #include <asm/kvm_vcpu_timer.h>
 
 static u64 kvm_riscv_current_cycles(struct kvm_guest_timer *gt)
@@ -72,12 +72,12 @@ static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
 static int kvm_riscv_vcpu_update_vstimecmp(struct kvm_vcpu *vcpu, u64 ncycles)
 {
 #if defined(CONFIG_32BIT)
-		csr_write(CSR_VSTIMECMP, ncycles & 0xFFFFFFFF);
-		csr_write(CSR_VSTIMECMPH, ncycles >> 32);
+	ncsr_write(CSR_VSTIMECMP, ncycles & 0xFFFFFFFF);
+	ncsr_write(CSR_VSTIMECMPH, ncycles >> 32);
 #else
-		csr_write(CSR_VSTIMECMP, ncycles);
+	ncsr_write(CSR_VSTIMECMP, ncycles);
 #endif
-		return 0;
+	return 0;
 }
 
 static int kvm_riscv_vcpu_update_hrtimer(struct kvm_vcpu *vcpu, u64 ncycles)
@@ -289,10 +289,10 @@ static void kvm_riscv_vcpu_update_timedelta(struct kvm_vcpu *vcpu)
 	struct kvm_guest_timer *gt = &vcpu->kvm->arch.timer;
 
 #if defined(CONFIG_32BIT)
-	csr_write(CSR_HTIMEDELTA, (u32)(gt->time_delta));
-	csr_write(CSR_HTIMEDELTAH, (u32)(gt->time_delta >> 32));
+	ncsr_write(CSR_HTIMEDELTA, (u32)(gt->time_delta));
+	ncsr_write(CSR_HTIMEDELTAH, (u32)(gt->time_delta >> 32));
 #else
-	csr_write(CSR_HTIMEDELTA, gt->time_delta);
+	ncsr_write(CSR_HTIMEDELTA, gt->time_delta);
 #endif
 }
 
@@ -306,10 +306,10 @@ void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
 		return;
 
 #if defined(CONFIG_32BIT)
-	csr_write(CSR_VSTIMECMP, (u32)t->next_cycles);
-	csr_write(CSR_VSTIMECMPH, (u32)(t->next_cycles >> 32));
+	ncsr_write(CSR_VSTIMECMP, (u32)t->next_cycles);
+	ncsr_write(CSR_VSTIMECMPH, (u32)(t->next_cycles >> 32));
 #else
-	csr_write(CSR_VSTIMECMP, t->next_cycles);
+	ncsr_write(CSR_VSTIMECMP, t->next_cycles);
 #endif
 
 	/* timer should be enabled for the remaining operations */
@@ -327,10 +327,10 @@ void kvm_riscv_vcpu_timer_sync(struct kvm_vcpu *vcpu)
 		return;
 
 #if defined(CONFIG_32BIT)
-	t->next_cycles = csr_read(CSR_VSTIMECMP);
-	t->next_cycles |= (u64)csr_read(CSR_VSTIMECMPH) << 32;
+	t->next_cycles = ncsr_read(CSR_VSTIMECMP);
+	t->next_cycles |= (u64)ncsr_read(CSR_VSTIMECMPH) << 32;
 #else
-	t->next_cycles = csr_read(CSR_VSTIMECMP);
+	t->next_cycles = ncsr_read(CSR_VSTIMECMP);
 #endif
 }
 
-- 
2.34.1



Return-Path: <linux-kernel+bounces-373418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1016E9A5672
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78302812D9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3C1990B3;
	Sun, 20 Oct 2024 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kxIgxPms"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512B198841
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453670; cv=none; b=P7+eh0FAEAAlwVukQ4uHzKDK42YSyMTW3FzN//W5yzqdOARyDAO1KbogIDn1HaxHNr8HUcfZWdcxJJqj5RBvzXIroRq+Pwvfq7PLNpg6XFIFFPHi2n4gJJVT45iGFH3Wc/j7ZdZshzDQNzGw9MjzWHAzXNhF9d/6GRwyB31flI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453670; c=relaxed/simple;
	bh=QR25kCjRwR3j6EKmmDoaShaAl2XNdgvpAF+TH9VGHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcwWzwLA+lWMbztop8d/7WtqddmWhx6q3nPLCPWNB61FPojUV7TDwQhtvg2ms+wFHd2Cj4qsgSEVQAiYeZhLGr2R966hHIWGrfSXTjCkfpwPy+S1tmXciywhJWTkoVq9pa9qLUhHm1VlTkT4WanB6VwfM9HEcGDDtmE502hFhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kxIgxPms; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so3068084a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729453668; x=1730058468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FyA7P9FbrHeEPhaW0M7UvJndGkwOjlPhJv2AlIq1GM=;
        b=kxIgxPms01reo/62/cQvzEZAG43eqCiXKBN0zH+DRIrBt5bDPNr1GTx32pgcdvdzqN
         xt7zaMoRn/aQ5LsRQq1wP93HhzM6KfOeINOJFXQ0yWxdPRGHVT2uex2qXlhDEy3bX64f
         6UAt9b8nLpWCVyYa15fFkETo+zT8uZvfIXJIOKIL8yaUykg+PK/Fci6qMIdp/Qoqz6E9
         qCB+oK4L9qHs8KkaG2UukZcSK12Sf/Hds4dIqzFDhrJsvWTie8nTBflE062Nvr5NEiKU
         dfp93223p8cObPHiM0ZSBlQMNcnUiOE6Xk1T91nIWxAExleFjZMxwH79Nl2bv6q2bmpO
         BMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453668; x=1730058468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FyA7P9FbrHeEPhaW0M7UvJndGkwOjlPhJv2AlIq1GM=;
        b=xLooQb1H/DNK6nnEJA8MqeG8bbc8Q+Boi+TvB5f+Hf4f2X2sihBuuthtXk+7SsgfgT
         Di3HtYCoMjsPJNPx9NvRGFrFEsYvtA0Ar4vLZ6Wo5i0oenjuedjusfXLZvgETTTemfK3
         +J+lWrqQSKK44fma9XcfGcKnNZOTspq8VPVX8xEA1fewOxOvCX1wvUmWfquPEtXnSY1v
         QEokaM/W0gHWi0cU+P1gUjvZa6KtWL+bAEwvT4EwllRUC3oUnbMQWXodZ6Tb4J0YiU3m
         N8GwJaKncm2T8+z7OyzfuEPrrI8jFlr7dZhQ5YEFnH9rxPPNdcADS2ztER5FqY3YjoaL
         Wdxw==
X-Forwarded-Encrypted: i=1; AJvYcCX+6Ps4AKhBd5vP2ApUZfqFlcL1FLZh57Kubz3iy+EiBVZG4sf1rnKrVxqNg+GZD28sLRjc+4lFzCZ5SE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSCc8PSPlw9YLxYIOHlqP1VreLBFFA+H+616uVghZfo88PXOg
	m75pOh/MacRC4ZPJssB9+0dMP+jJHEe9qF7IUWZlYviilG2WMF6mN2nfocKBYYQ=
X-Google-Smtp-Source: AGHT+IF7lE3B8ClzR6qfjFpDCQHpNymbsHf8YVM1zw/aseb8Rk6lioGovC2ybZ0RbWASOBCIDdfN6A==
X-Received: by 2002:a17:90b:4b0d:b0:2e2:de95:34eb with SMTP id 98e67ed59e1d1-2e5616eba4emr12077551a91.10.1729453667879;
        Sun, 20 Oct 2024 12:47:47 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([50.238.223.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d4dsm1933188a91.14.2024.10.20.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:47:47 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 02/13] RISC-V: KVM: Save/restore HSTATUS in C source
Date: Mon, 21 Oct 2024 01:17:23 +0530
Message-ID: <20241020194734.58686-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020194734.58686-1-apatel@ventanamicro.com>
References: <20241020194734.58686-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will be optimizing HSTATUS CSR access via shared memory setup
using the SBI nested acceleration extension. To facilitate this,
we first move HSTATUS save/restore in kvm_riscv_vcpu_enter_exit().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu.c        |  9 +++++++++
 arch/riscv/kvm/vcpu_switch.S | 36 +++++++++++++-----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index dae12ca3c8b6..53ee29490c7f 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -731,9 +731,18 @@ static __always_inline void kvm_riscv_vcpu_swap_in_host_state(struct kvm_vcpu *v
  */
 static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 {
+	struct kvm_cpu_context *gcntx = &vcpu->arch.guest_context;
+	struct kvm_cpu_context *hcntx = &vcpu->arch.host_context;
+
 	kvm_riscv_vcpu_swap_in_guest_state(vcpu);
 	guest_state_enter_irqoff();
+
+	hcntx->hstatus = csr_swap(CSR_HSTATUS, gcntx->hstatus);
+
 	__kvm_riscv_switch_to(&vcpu->arch);
+
+	gcntx->hstatus = csr_swap(CSR_HSTATUS, hcntx->hstatus);
+
 	vcpu->arch.last_exit_cpu = vcpu->cpu;
 	guest_state_exit_irqoff();
 	kvm_riscv_vcpu_swap_in_host_state(vcpu);
diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
index 0c26189aa01c..f83643c4fdb9 100644
--- a/arch/riscv/kvm/vcpu_switch.S
+++ b/arch/riscv/kvm/vcpu_switch.S
@@ -43,35 +43,30 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 
 	/* Load Guest CSR values */
 	REG_L	t0, (KVM_ARCH_GUEST_SSTATUS)(a0)
-	REG_L	t1, (KVM_ARCH_GUEST_HSTATUS)(a0)
-	REG_L	t2, (KVM_ARCH_GUEST_SCOUNTEREN)(a0)
-	la	t4, .Lkvm_switch_return
-	REG_L	t5, (KVM_ARCH_GUEST_SEPC)(a0)
+	REG_L	t1, (KVM_ARCH_GUEST_SCOUNTEREN)(a0)
+	la	t3, .Lkvm_switch_return
+	REG_L	t4, (KVM_ARCH_GUEST_SEPC)(a0)
 
 	/* Save Host and Restore Guest SSTATUS */
 	csrrw	t0, CSR_SSTATUS, t0
 
-	/* Save Host and Restore Guest HSTATUS */
-	csrrw	t1, CSR_HSTATUS, t1
-
 	/* Save Host and Restore Guest SCOUNTEREN */
-	csrrw	t2, CSR_SCOUNTEREN, t2
+	csrrw	t1, CSR_SCOUNTEREN, t1
 
 	/* Save Host STVEC and change it to return path */
-	csrrw	t4, CSR_STVEC, t4
+	csrrw	t3, CSR_STVEC, t3
 
 	/* Save Host SSCRATCH and change it to struct kvm_vcpu_arch pointer */
-	csrrw	t3, CSR_SSCRATCH, a0
+	csrrw	t2, CSR_SSCRATCH, a0
 
 	/* Restore Guest SEPC */
-	csrw	CSR_SEPC, t5
+	csrw	CSR_SEPC, t4
 
 	/* Store Host CSR values */
 	REG_S	t0, (KVM_ARCH_HOST_SSTATUS)(a0)
-	REG_S	t1, (KVM_ARCH_HOST_HSTATUS)(a0)
-	REG_S	t2, (KVM_ARCH_HOST_SCOUNTEREN)(a0)
-	REG_S	t3, (KVM_ARCH_HOST_SSCRATCH)(a0)
-	REG_S	t4, (KVM_ARCH_HOST_STVEC)(a0)
+	REG_S	t1, (KVM_ARCH_HOST_SCOUNTEREN)(a0)
+	REG_S	t2, (KVM_ARCH_HOST_SSCRATCH)(a0)
+	REG_S	t3, (KVM_ARCH_HOST_STVEC)(a0)
 
 	/* Restore Guest GPRs (except A0) */
 	REG_L	ra, (KVM_ARCH_GUEST_RA)(a0)
@@ -153,8 +148,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_L	t1, (KVM_ARCH_HOST_STVEC)(a0)
 	REG_L	t2, (KVM_ARCH_HOST_SSCRATCH)(a0)
 	REG_L	t3, (KVM_ARCH_HOST_SCOUNTEREN)(a0)
-	REG_L	t4, (KVM_ARCH_HOST_HSTATUS)(a0)
-	REG_L	t5, (KVM_ARCH_HOST_SSTATUS)(a0)
+	REG_L	t4, (KVM_ARCH_HOST_SSTATUS)(a0)
 
 	/* Save Guest SEPC */
 	csrr	t0, CSR_SEPC
@@ -168,18 +162,14 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	/* Save Guest and Restore Host SCOUNTEREN */
 	csrrw	t3, CSR_SCOUNTEREN, t3
 
-	/* Save Guest and Restore Host HSTATUS */
-	csrrw	t4, CSR_HSTATUS, t4
-
 	/* Save Guest and Restore Host SSTATUS */
-	csrrw	t5, CSR_SSTATUS, t5
+	csrrw	t4, CSR_SSTATUS, t4
 
 	/* Store Guest CSR values */
 	REG_S	t0, (KVM_ARCH_GUEST_SEPC)(a0)
 	REG_S	t2, (KVM_ARCH_GUEST_A0)(a0)
 	REG_S	t3, (KVM_ARCH_GUEST_SCOUNTEREN)(a0)
-	REG_S	t4, (KVM_ARCH_GUEST_HSTATUS)(a0)
-	REG_S	t5, (KVM_ARCH_GUEST_SSTATUS)(a0)
+	REG_S	t4, (KVM_ARCH_GUEST_SSTATUS)(a0)
 
 	/* Restore Host GPRs (except A0 and T0-T6) */
 	REG_L	ra, (KVM_ARCH_HOST_RA)(a0)
-- 
2.43.0



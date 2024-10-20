Return-Path: <linux-kernel+bounces-373420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBE29A5677
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10832B2240D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890D1993AD;
	Sun, 20 Oct 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VxW2FnZW"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC321991AB
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453675; cv=none; b=Bp+FFf3eCzBXbKxsyoJIADE46BudAPzyQgFGs94Xn8SCqhufNaEyrYsbl1uSyw6t4pGoaGJmvpZ0Qf4RF8ylX4YwEZ6f13EG9jtev/VdUU3S89F++jq5pTuZ/KWJ2+DeohgDmvmchamAFJoY6K/edzV8JpGHBtFO9w1pMgRgPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453675; c=relaxed/simple;
	bh=aXnA9wY0kQ/Bx5uZ0gzKAYiZGftNnwWnnmMlj07L2Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyNXafV9pxOdk8QQHdmjONFW/4w302g0RfZ2fqFssZRU5nnhRSZCmePUQcIyqkSTUC3s48F4odM/EsovWJiWCeEX2p8/N6DQ2mfqbb4Cd05u3b5MHawzlcP4H0VcLvlxnQn2Y6J0eCR97XOEuFnbTfTjdKpZxU07zALDipj1Vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VxW2FnZW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so544743a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729453672; x=1730058472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfThf6WSDtXeJLGF9IIFos3c8UFbvclgKv7arl05kb4=;
        b=VxW2FnZWpASfxmDBWLd0vxi2XqPjT3xyigCPOdS4h3bMmBTEDLazAWccDPrjyB5MA9
         sLGmaCIRJY26wRTXCfbKWQ0ExnEyTk3JYo9gNPIBboVP98o8hS8MqP0I3BkcMoRwta/F
         FTQd5FCgE4/myCcy4cnjzGZqRi7yRU9VC5OeBpbq3cHSWhac7EslEDf39ie9YYyyeCtC
         IzF9hjvSNIWAPx1bHp8FJvWSNEq3CE0r9pku3+2+UEhs4OsIxM9KlViTRXAdWtyMi9VH
         4dBRCLtc5vpsi0OgB/fvVvchhyJEAK4RVQQ9u+Ek12M6gYlmJnDB/QU7rKhIjpyyCN5k
         VPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453672; x=1730058472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfThf6WSDtXeJLGF9IIFos3c8UFbvclgKv7arl05kb4=;
        b=sbprZ4QPkhjZidb7OlWh9mJVRjyfmVKEHiaH+0mLcwgOo5HiOv7+WP/Gnm9iJlEJoS
         7+qBavNYONJs/LDsETQwazdQtp5uQmPXbd8b7mZV9jQQ9DaweFIIVA1U1n9LChiw1C2q
         QR6JnIMjgplDq2T27KDCUmsRAZVkGA97cFqrFg0LJsKEXuEjrVPULLqZkbN36lOXj4pF
         a0KYy4m64y8pLWZfrHmS9gjKdCTMIThJX4dJZ+zFxDXRNH6a/l5OyqjYwh8NSNJQ7but
         G2pBQf1zE43VwnKFZSM4+B6t9snI80KZVjt41h0cmKIHajINAUpq3glUcJLeWyzEpz1q
         LDQA==
X-Forwarded-Encrypted: i=1; AJvYcCXLScE8r1RYeDvfF1OTI46V2INm2+VoQUkQ9qYr3c5FcUOA2Ev+dPBSnIox6jwo5w8a2B5twNHDEKvRg54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUGo0kv4LyfhAwNTaoPW8sMsOQS8LMdI1HPh+u9V/128fPZYkC
	frk2xQsRMRD7qZ6fxlpz32my8USB9dyGgafesuhdsLWTUbwDoceibOIyYum3N3E=
X-Google-Smtp-Source: AGHT+IHJeZE9HrX0oYl24Mbcflj7S1QWZQW1xGijDT99BYjkFVqjYvyBRxHehmfkCt5Hnq51re8yqA==
X-Received: by 2002:a17:90b:4a0c:b0:2e2:b3f8:b549 with SMTP id 98e67ed59e1d1-2e561650b59mr11476427a91.23.1729453671610;
        Sun, 20 Oct 2024 12:47:51 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([50.238.223.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d4dsm1933188a91.14.2024.10.20.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:47:51 -0700 (PDT)
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
Subject: [PATCH v2 04/13] RISC-V: KVM: Break down the __kvm_riscv_switch_to() into macros
Date: Mon, 21 Oct 2024 01:17:25 +0530
Message-ID: <20241020194734.58686-5-apatel@ventanamicro.com>
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

Break down the __kvm_riscv_switch_to() function into macros so that
these macros can be later re-used by SBI NACL extension based low-level
switch function.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_switch.S | 52 +++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
index 3f8cbc21a644..9f13e5ce6a18 100644
--- a/arch/riscv/kvm/vcpu_switch.S
+++ b/arch/riscv/kvm/vcpu_switch.S
@@ -11,11 +11,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/csr.h>
 
-	.text
-	.altmacro
-	.option norelax
-
-SYM_FUNC_START(__kvm_riscv_switch_to)
+.macro SAVE_HOST_GPRS
 	/* Save Host GPRs (except A0 and T0-T6) */
 	REG_S	ra, (KVM_ARCH_HOST_RA)(a0)
 	REG_S	sp, (KVM_ARCH_HOST_SP)(a0)
@@ -40,10 +36,12 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_S	s9, (KVM_ARCH_HOST_S9)(a0)
 	REG_S	s10, (KVM_ARCH_HOST_S10)(a0)
 	REG_S	s11, (KVM_ARCH_HOST_S11)(a0)
+.endm
 
+.macro SAVE_HOST_AND_RESTORE_GUEST_CSRS __resume_addr
 	/* Load Guest CSR values */
 	REG_L	t0, (KVM_ARCH_GUEST_SSTATUS)(a0)
-	la	t1, .Lkvm_switch_return
+	la	t1, \__resume_addr
 	REG_L	t2, (KVM_ARCH_GUEST_SEPC)(a0)
 
 	/* Save Host and Restore Guest SSTATUS */
@@ -62,7 +60,9 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_S	t0, (KVM_ARCH_HOST_SSTATUS)(a0)
 	REG_S	t1, (KVM_ARCH_HOST_STVEC)(a0)
 	REG_S	t3, (KVM_ARCH_HOST_SSCRATCH)(a0)
+.endm
 
+.macro RESTORE_GUEST_GPRS
 	/* Restore Guest GPRs (except A0) */
 	REG_L	ra, (KVM_ARCH_GUEST_RA)(a0)
 	REG_L	sp, (KVM_ARCH_GUEST_SP)(a0)
@@ -97,13 +97,9 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 
 	/* Restore Guest A0 */
 	REG_L	a0, (KVM_ARCH_GUEST_A0)(a0)
+.endm
 
-	/* Resume Guest */
-	sret
-
-	/* Back to Host */
-	.align 2
-.Lkvm_switch_return:
+.macro SAVE_GUEST_GPRS
 	/* Swap Guest A0 with SSCRATCH */
 	csrrw	a0, CSR_SSCRATCH, a0
 
@@ -138,7 +134,9 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_S	t4, (KVM_ARCH_GUEST_T4)(a0)
 	REG_S	t5, (KVM_ARCH_GUEST_T5)(a0)
 	REG_S	t6, (KVM_ARCH_GUEST_T6)(a0)
+.endm
 
+.macro SAVE_GUEST_AND_RESTORE_HOST_CSRS
 	/* Load Host CSR values */
 	REG_L	t0, (KVM_ARCH_HOST_STVEC)(a0)
 	REG_L	t1, (KVM_ARCH_HOST_SSCRATCH)(a0)
@@ -160,7 +158,9 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_S	t1, (KVM_ARCH_GUEST_A0)(a0)
 	REG_S	t2, (KVM_ARCH_GUEST_SSTATUS)(a0)
 	REG_S	t3, (KVM_ARCH_GUEST_SEPC)(a0)
+.endm
 
+.macro RESTORE_HOST_GPRS
 	/* Restore Host GPRs (except A0 and T0-T6) */
 	REG_L	ra, (KVM_ARCH_HOST_RA)(a0)
 	REG_L	sp, (KVM_ARCH_HOST_SP)(a0)
@@ -185,6 +185,34 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_L	s9, (KVM_ARCH_HOST_S9)(a0)
 	REG_L	s10, (KVM_ARCH_HOST_S10)(a0)
 	REG_L	s11, (KVM_ARCH_HOST_S11)(a0)
+.endm
+
+	.text
+	.altmacro
+	.option norelax
+
+	/*
+	 * Parameters:
+	 * A0 <= Pointer to struct kvm_vcpu_arch
+	 */
+SYM_FUNC_START(__kvm_riscv_switch_to)
+	SAVE_HOST_GPRS
+
+	SAVE_HOST_AND_RESTORE_GUEST_CSRS .Lkvm_switch_return
+
+	RESTORE_GUEST_GPRS
+
+	/* Resume Guest using SRET */
+	sret
+
+	/* Back to Host */
+	.align 2
+.Lkvm_switch_return:
+	SAVE_GUEST_GPRS
+
+	SAVE_GUEST_AND_RESTORE_HOST_CSRS
+
+	RESTORE_HOST_GPRS
 
 	/* Return to C code */
 	ret
-- 
2.43.0



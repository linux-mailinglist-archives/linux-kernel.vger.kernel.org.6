Return-Path: <linux-kernel+bounces-240345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D8926C70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88441F236BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E89194C6D;
	Wed,  3 Jul 2024 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aVXLFbz1"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE9194AC7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049319; cv=none; b=UPCMXKOX/usVEgIfiZAwhP8/TinBmOhT8HQVS0HBBKKmY5T/i4milqK3mWXkyAj8rVFcmMRAnBkeIRq4OE5Ek5Z62A3bxmyD4sfHj4HRUtOhg0WL43yvc0esjiEP7OtPD1NG+cSO1r25xXAdjJ8GA/6LCCiR38RGmo8eu9nBqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049319; c=relaxed/simple;
	bh=WGb7oFDD7nuqt1oiOLTOMOju7ZPI/CiES1QcbGF5YIM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wna2GVemfUzA3FqejAGRmtnvBeqeemBDCO+reAvI7XuEQRX+d1tbkg2WRLuugtcX7aCKkIYk5B6nIUhULGlBlbqT1aC83Wm1rDo2BeeLj/EFHvpG2dRgxqcfDU7rckKPoIPfOhiFjlMfSX1P4VGuNaAL/5+UmZyDKmfVcpn7wzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aVXLFbz1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7594c490b04so7906a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720049318; x=1720654118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIcQrgok9mX0Uon7NauPjlh5g5FgT6+ZQ8nLFfSKoDE=;
        b=aVXLFbz1i5gJNNzB0va7WQkqM2t4f09zyFQM1tgQ2X7bdDGfIBl+OHimpnVlkM9CTs
         gA/kilx7Dds3/xTPFSmJmc1g8PsaFrqDpAAMpKsdca0tL1pVwzTspMvEevi01m+sIJFS
         64q8EbwsC0rXd5Q96lkpwbCEr4Gz/W4Ul/e+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720049318; x=1720654118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIcQrgok9mX0Uon7NauPjlh5g5FgT6+ZQ8nLFfSKoDE=;
        b=UT8kdEayyLOpBoaHRgK/3TLSZsG/l2Jo235IAAwlOjydDCLKWVkbUFz4k+LA1pMKwY
         xgM56Dei2e82glf2H2ItqiU8uAtul5Ot2bnWouGL9QmVWwzDg4js2mj2h84fwKB3UlpQ
         P9Yj7BYecSZ2NrBWBMII+kD0aqIUCrfHBQ/mIzFF8mRoorxzZPwxzMSrRCozYLHVgG3D
         6Lw0EGVippFmBT2ZTVv5+kErNaKnUDcgRyKSn2UGrLnSFwFdOTr6ptOew3znkIQeuRuY
         rWSlTnAFLIrLBmEeKzvVIwfF/rm7XOBIoSsSHSJoVgR8ZjW/q89+Bl2wknVvflIKaGhE
         X2zg==
X-Forwarded-Encrypted: i=1; AJvYcCUJO40QDiw3C1etvboa3cvjki6wazjbnzYZsOmng9TOvYq5JzPELpcw8BBNtLhmsye/DlFYo8Hdtp353/weMR0ERv3r42PI3kjM5Ruu
X-Gm-Message-State: AOJu0YyHD+gwdIS5qYU7vmmmy96uAoFGIL53bynGdXdqR4QKVaIIX1vs
	b2dWmCJKqpZ5mFdD89i/dlh5KJTMlbgxAJyC3Iia0fMXTQxT/ucyyxRtH3D+gg==
X-Google-Smtp-Source: AGHT+IEoz+vHNVbO8cyfzy0xMc+L4OFVMp5ck+Nfmw1ZPLfpKVkYjPdAin6v88y+B5auU+iIk+XHzw==
X-Received: by 2002:a05:6a20:918f:b0:1bd:25d1:58eb with SMTP id adf61e73a8af0-1bef6126431mr19202450637.31.1720049317664;
        Wed, 03 Jul 2024 16:28:37 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a946fb2sm83793a91.3.2024.07.03.16.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 16:28:37 -0700 (PDT)
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>,
	Tim Merrifield <tim.merrifield@broadcom.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev,
	alex.james@broadcom.com,
	doug.covelli@broadcom.com,
	jeffrey.sheldon@broadcom.com
Subject: [PATCH 1/2] x86/tdx: Add prctl to allow userlevel TDX hypercalls
Date: Wed,  3 Jul 2024 23:36:00 +0000
Message-Id: <90bf00599189c34e77aa77986674be2d5fc19f9c.1720046911.git.tim.merrifield@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1720046911.git.tim.merrifield@broadcom.com>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new prctl option to enable/disable user-level hypercalls when
running in a confidential VM. Add support for checking this flag on
VMCALL #VE for TDX and transfer control to a hypervisor
vendor-specific handler.

Signed-off-by: Tim Merrifield <tim.merrifield@broadcom.com>
---
 arch/x86/coco/tdx/tdx.c            | 18 ++++++++++++++++++
 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/include/asm/x86_init.h    |  1 +
 arch/x86/include/uapi/asm/prctl.h  |  3 +++
 arch/x86/kernel/process.c          | 20 ++++++++++++++++++++
 5 files changed, 44 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ef8ec2425998..23111e4c1f91 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -239,6 +239,7 @@ static int ve_instr_len(struct ve_info *ve)
 	case EXIT_REASON_MSR_WRITE:
 	case EXIT_REASON_CPUID:
 	case EXIT_REASON_IO_INSTRUCTION:
+	case EXIT_REASON_VMCALL:
 		/* It is safe to use ve->instr_len for #VE due instructions */
 		return ve->instr_len;
 	case EXIT_REASON_EPT_VIOLATION:
@@ -635,6 +636,21 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(args.r10);
 }
 
+/*
+ * Handle user-initiated, hypervisor-specific VMCALLs.
+ */
+static int handle_user_vmcall(struct pt_regs *regs, struct ve_info *ve)
+{
+	if (x86_platform.hyper.tdx_hcall &&
+	    test_thread_flag(TIF_COCO_USER_HCALL)) {
+		if (!x86_platform.hyper.tdx_hcall(regs))
+			return -EIO;
+		return ve_instr_len(ve);
+	} else {
+		return -EOPNOTSUPP;
+	}
+}
+
 /*
  * Handle the user initiated #VE.
  *
@@ -646,6 +662,8 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs, ve);
+	case EXIT_REASON_VMCALL:
+		return handle_user_vmcall(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EIO;
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 12da7dfd5ef1..9f69a26a5e68 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -106,6 +106,7 @@ struct thread_info {
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_COCO_USER_HCALL     30      /* Userland hypercalls allowed in CoCo */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -128,6 +129,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_COCO_USER_HCALL    (1 << TIF_COCO_USER_HCALL)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 213cf5379a5a..52975bedd33e 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -282,6 +282,7 @@ struct x86_hyper_runtime {
 	void (*sev_es_hcall_prepare)(struct ghcb *ghcb, struct pt_regs *regs);
 	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
 	bool (*is_private_mmio)(u64 addr);
+	bool (*tdx_hcall)(struct pt_regs *regs);
 };
 
 /**
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 384e2cc6ac19..7fa289a1815b 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -16,6 +16,9 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_GET_COCO_USER_HCALL        0x1030
+#define ARCH_SET_COCO_USER_HCALL        0x1031
+
 #define ARCH_XCOMP_TILECFG		17
 #define ARCH_XCOMP_TILEDATA		18
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1b3d417cd6c4..16f8ab6cde2e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1039,6 +1039,21 @@ unsigned long __get_wchan(struct task_struct *p)
 	return addr;
 }
 
+static int get_coco_user_hcall_mode(void)
+{
+	return !test_thread_flag(TIF_COCO_USER_HCALL);
+}
+
+static int set_coco_user_hcall_mode(unsigned long enabled)
+{
+	if (enabled)
+		set_thread_flag(TIF_COCO_USER_HCALL);
+	else
+		clear_thread_flag(TIF_COCO_USER_HCALL);
+
+	return 0;
+}
+
 long do_arch_prctl_common(int option, unsigned long arg2)
 {
 	switch (option) {
@@ -1052,6 +1067,11 @@ long do_arch_prctl_common(int option, unsigned long arg2)
 	case ARCH_GET_XCOMP_GUEST_PERM:
 	case ARCH_REQ_XCOMP_GUEST_PERM:
 		return fpu_xstate_prctl(option, arg2);
+	case ARCH_GET_COCO_USER_HCALL:
+		return get_coco_user_hcall_mode();
+	case ARCH_SET_COCO_USER_HCALL:
+		return set_coco_user_hcall_mode(arg2);
+
 	}
 
 	return -EINVAL;
-- 
2.40.1



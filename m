Return-Path: <linux-kernel+bounces-263640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA193D88F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B81F24812
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A14D9FB;
	Fri, 26 Jul 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jinxmqzc"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29A33CC4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019763; cv=none; b=Vs7JhI0cq1qQgDbizt3kWsM4vcTUUtYYxCVQ/CVQFW7a7iD1yysnXPlKwc0rzZ1QpbVquGRGvfUiexTM5Soo2BidjoFWAfVAJgMQSaDgcp9w0dPGQ2DWhjUDZDRUqyEw4R9ddPiWP7IhWyW2AaNtVypmf3FDXrvWum90iWG92PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019763; c=relaxed/simple;
	bh=+jXBXwXFxiuC99QH+zysxgb6L+b3Y4nclJxTDtnzuw0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWMCYkTvBGnP5KO1I41NEX9pfa7AyfT6umogaYbn5PpRAgIWRieRPCvJJjP50O41Xxg3FsCWuJyn+Jsqsrdo38QMq1Sh1lz4NkBoDs9gyub3H0mr2OQm2eSODuAt4jF9YVUHXl8t6SIkmlBQb1ZWW67QvSO4CXcp5SFg6UNBXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jinxmqzc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4fccdd78so7965305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722019761; x=1722624561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBPU4xCiDMUET1E9lH81FLL0ftccfgyXUuc8LswKkX8=;
        b=Jinxmqzc4hWpg7m2YLobZ/K0vUeKovd98usK8oOLcCFnuKByBLbvl5GfJgf9iw/Va5
         Ngqhc1WchShYht3HshUEKnzQPw2LQuo0KeTR/RnQoV0ymytf12+TIxtgwB1EQpAXgk0s
         GXCLnx/Au37oinh7sV/BTHNAYoWTWxwhkJy7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019761; x=1722624561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBPU4xCiDMUET1E9lH81FLL0ftccfgyXUuc8LswKkX8=;
        b=EYiNnKLSh0VFRb2MLthQjrRYXnqiOLNlkr/y4CmfkbszTQaS6K2Yl5NBvSf7Zz6y4i
         42OcUzpmU5W+tZqG1wdSvMKm4iAu0Mq8mtN7n1Oxvj+IEu7H4S/Hh8lILapGDlOjHgv9
         M3Cy3sMP6NsYHPlJ4ud0E1fLNuPvvJ3PBV1tZLZcZ2tH/0+rSzLAU74cD/XYMYVQGR0C
         V3ecsf/nJbtnEV+ONb5uxJH1cprURoyvPd3Sht/UIME/jbi1DFoO59N/B5wr1Mg8mKaC
         EkOQqY13QziBJ4GfRYY33S0m2KLAjVAvR3W2tjSFq0BjnxvLSxnBD3wkqHrL85KeOpkl
         ml2A==
X-Forwarded-Encrypted: i=1; AJvYcCV8e/+3RsSDM4NTmmUczv7v/fxKsfozLDWYji1HO3qQXeKsSOf4kVLiYVm5v5eWvc47+el4iV4pbjyynhn6P9tojYtkfva7QTJjE1JE
X-Gm-Message-State: AOJu0Yy5tp9hRNYiiGRQRgS5OgKC7g3UubQbDQqLNb/8VhTeyEFW4q0I
	b0euzQf2oLiPL6WKfr2mVsBphdzGYLYJ01bCWr5bQNVzOAdxsSALVLNeFKDtiA==
X-Google-Smtp-Source: AGHT+IE9uV09xvmdLWuwpCgIzme9syDA93eFLaDIt4RDokMKMeMZxVrXf1S5Y4/8KFjApTy74m3UmQ==
X-Received: by 2002:a17:903:2445:b0:1fd:6a00:5837 with SMTP id d9443c01a7336-1ff048e5c16mr6628325ad.42.1722019760999;
        Fri, 26 Jul 2024 11:49:20 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8494sm36285245ad.159.2024.07.26.11.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:49:20 -0700 (PDT)
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
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev,
	alex.james@broadcom.com,
	doug.covelli@broadcom.com,
	jeffrey.sheldon@broadcom.com,
	kevin.christopher@broadcom.com,
	aravind-as.srinivasan@broadcom.com,
	ravindra.kumar@broadcom.com
Subject: [PATCH v2 1/2] Add prctl to allow userlevel TDX hypercalls
Date: Fri, 26 Jul 2024 18:58:00 +0000
Message-Id: <651ceb5a89721621d522419e8a5d901632a78a22.1722019360.git.tim.merrifield@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722019360.git.tim.merrifield@broadcom.com>
References: <cover.1722019360.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new process-level prctl option to enable/disable user-level
hypercalls when running in a confidential VM. Add support for
checking this flag on VMCALL #VE for TDX and transfer control to
a hypervisor vendor-specific handler.

Signed-off-by: Tim Merrifield <tim.merrifield@broadcom.com>
---
 arch/x86/coco/tdx/tdx.c           | 23 +++++++++++++++++++++++
 arch/x86/include/asm/mmu.h        |  2 ++
 arch/x86/include/asm/x86_init.h   |  1 +
 arch/x86/include/uapi/asm/prctl.h |  3 +++
 arch/x86/kernel/process.c         | 22 ++++++++++++++++++++++
 5 files changed, 51 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..02580fcf6157 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -238,6 +238,7 @@ static int ve_instr_len(struct ve_info *ve)
 	case EXIT_REASON_MSR_WRITE:
 	case EXIT_REASON_CPUID:
 	case EXIT_REASON_IO_INSTRUCTION:
+	case EXIT_REASON_VMCALL:
 		/* It is safe to use ve->instr_len for #VE due instructions */
 		return ve->instr_len;
 	case EXIT_REASON_EPT_VIOLATION:
@@ -634,6 +635,26 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(args.r10);
 }
 
+/*
+ * Handle user-initiated, hypervisor-specific VMCALLs.
+ */
+static int handle_user_vmcall(struct pt_regs *regs, struct ve_info *ve)
+{
+	int err;
+
+	if (!x86_platform.hyper.tdx_hcall)
+		return -EOPNOTSUPP;
+
+	if (!test_bit(MM_CONTEXT_COCO_USER_HCALL, &current->mm->context.flags))
+		return -EOPNOTSUPP;
+
+	err = x86_platform.hyper.tdx_hcall(regs);
+	if (err)
+		return err;
+
+	return ve_instr_len(ve);
+}
+
 /*
  * Handle the user initiated #VE.
  *
@@ -645,6 +666,8 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs, ve);
+	case EXIT_REASON_VMCALL:
+		return handle_user_vmcall(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EIO;
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index ce4677b8b735..626ab327e34c 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #define MM_CONTEXT_LOCK_LAM		2
 /* Allow LAM and SVA coexisting */
 #define MM_CONTEXT_FORCE_TAGGED_SVA	3
+/* Allow COCO user-level hypercalls. */
+#define MM_CONTEXT_COCO_USER_HCALL	4
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 213cf5379a5a..04d43b91d32a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -282,6 +282,7 @@ struct x86_hyper_runtime {
 	void (*sev_es_hcall_prepare)(struct ghcb *ghcb, struct pt_regs *regs);
 	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
 	bool (*is_private_mmio)(u64 addr);
+	int  (*tdx_hcall)(struct pt_regs *regs);
 };
 
 /**
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 384e2cc6ac19..37d154e503a3 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -16,6 +16,9 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_GET_COCO_USER_HCALL	0x1030
+#define ARCH_SET_COCO_USER_HCALL	0x1031
+
 #define ARCH_XCOMP_TILECFG		17
 #define ARCH_XCOMP_TILEDATA		18
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91..198431919fd2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1042,6 +1042,24 @@ unsigned long __get_wchan(struct task_struct *p)
 	return addr;
 }
 
+static int get_coco_user_hcall_mode(void)
+{
+	return !test_bit(MM_CONTEXT_COCO_USER_HCALL,
+			&current->mm->context.flags);
+}
+
+static int set_coco_user_hcall_mode(unsigned long enabled)
+{
+	if (enabled)
+		set_bit(MM_CONTEXT_COCO_USER_HCALL,
+			&current->mm->context.flags);
+	else
+		clear_bit(MM_CONTEXT_COCO_USER_HCALL,
+			  &current->mm->context.flags);
+
+	return 0;
+}
+
 long do_arch_prctl_common(int option, unsigned long arg2)
 {
 	switch (option) {
@@ -1055,6 +1073,10 @@ long do_arch_prctl_common(int option, unsigned long arg2)
 	case ARCH_GET_XCOMP_GUEST_PERM:
 	case ARCH_REQ_XCOMP_GUEST_PERM:
 		return fpu_xstate_prctl(option, arg2);
+	case ARCH_GET_COCO_USER_HCALL:
+		return get_coco_user_hcall_mode();
+	case ARCH_SET_COCO_USER_HCALL:
+		return set_coco_user_hcall_mode(arg2);
 	}
 
 	return -EINVAL;
-- 
2.40.1



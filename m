Return-Path: <linux-kernel+bounces-240346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C1926C73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8529528548F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1F194C8D;
	Wed,  3 Jul 2024 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S5WDqZ+2"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C2194C7E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049324; cv=none; b=snlQtZSoOIw2CVEn6pzUQOjVA7I1Sdx/Z/v8qYoDpGrLXVF6B2yfnltffSIGuNbsLLvqf4efgM/adDqARKeWXI7/F5017tUOmAEu4vqZJYSCAbgjhmPEwnFSa38Y9G1DZ0MLg4wGV7wuwjCH4T9C7V0dfVjgEp+xTUrNSItCooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049324; c=relaxed/simple;
	bh=2rX1eM7IcyL+aaZE748iVd0kPixuWYIPt9NTa74r4qY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RI7B33CTkrty+Md+4yzQtGbecrGiJoUdnM8XJHyt6KG+sC3DODp/CyLx5qEHxfBAHTTMZN0MItOT9zDNt5Tf0mwxxE0TeZ2VKYi+xAwxPQepn/z3YAu9fT/1nFTqOKe7I77VloC4cCS+pREvxb4Hglc8CFw0uNBNMUAJLmFeNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S5WDqZ+2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c961b5f215so77237a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720049322; x=1720654122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMqe2BG7Tl+EbczXsabTlZUrjUbcGGCiv8T53M9QugY=;
        b=S5WDqZ+2uAck8Hl9jdtHzSRXw5ejCh1kBGWKXJ56FN1G5nIUvwVXdoSJba4bPrZhZR
         rOzI3cnh2E+tgHgRsmKAex+vM8RhC82eeQkd5e8099yOq8MMCcK5dXZZzvFuE2IdOHZm
         xB455Ni0feB6QooXPe6x6nyRa7khUHG70Al7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720049322; x=1720654122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMqe2BG7Tl+EbczXsabTlZUrjUbcGGCiv8T53M9QugY=;
        b=m6AElUkNpMe0Mkz4gqyyPVykDS4l/WsYJzI48bOMp/HZSBxS/Z2KAzpuQw9jZejpT2
         6t0nb67Usa9Gets+AmAmMjlDXdHOftMs2nSoOPUbPNgD9KJFr8MhhGq5I/yjHO6MIve+
         o+5eZK7bdmgoORuBNOAEeTGSiDcNFys4tXqtiaxJSUi0Syr31VeCxgjkeEnRUuHJz49S
         oQ3Nq+GFIs2QFBofWhHxKK+tXFUwWx+zCQEack1GGsIuXcfQ8dSZZDSXGForm5FJbom/
         doxwG1g98jARJPEZf1AZGxRgOIYuDLnj1r63UwqOGoev+dlPQDOS5jftcIJQGAlAvs0I
         ZC+g==
X-Forwarded-Encrypted: i=1; AJvYcCUV8Dfi/oKZ9dsPB7gBKSFu6rAVHuGwUQcK9l74Gn1IfDI6SzefS3wIy/+prEfNqOy2YvFW6j1BXz2/1KFIka+WxI7Pgc+5ndcxZZ8D
X-Gm-Message-State: AOJu0YydehWbFoFfgM4Lm1UGkOcWFaTnnvVXjYJZO5Da3g/6VMmYk4Os
	fVy8ceeEYHk8mXFsfwVftuWV7scMT9Z41OWym+HMin8zR7ejmhQxXniJPMcbZg==
X-Google-Smtp-Source: AGHT+IGnGTNEJSPVIcneCMmD4X4a7gsV7nmqZFmM5q3Tdw7a+eMuok/DQQzMgjsieAlv0BO+nLBTFw==
X-Received: by 2002:a17:90a:ff18:b0:2c9:77d8:bb60 with SMTP id 98e67ed59e1d1-2c977d90022mr2511946a91.35.1720049322220;
        Wed, 03 Jul 2024 16:28:42 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a946fb2sm83793a91.3.2024.07.03.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 16:28:41 -0700 (PDT)
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
Subject: [PATCH 2/2] x86/vmware: VMware support for TDX userspace hypercalls
Date: Wed,  3 Jul 2024 23:36:01 +0000
Message-Id: <7f57b0fe002291e3f4b27dfe9f502ed3af296bc2.1720046911.git.tim.merrifield@broadcom.com>
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

This change adds a handler for tdx_hcall in the x86_hyper_runtime type for
VMware hypervisors which will ultimately invoke __tdx_hypercall. The
handler (vmware_tdx_user_hcall) does not reuse the existing
vmware_tdx_hypercall for a couple of reasons.

First, while the few hypercalls that are invoked from the kernel expect
uint32 outputs, this may not be the case for every backdoor userspace may
call. So the existing interface is not sufficient. Additionally, we don't
require the branches based on output arguments. Finally, the
VMWARE_CMD_MASK employed in vmware_tdx_hypercall is applicable to only
hypercalls expected from the kernel.

Signed-off-by: Tim Merrifield <tim.merrifield@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 51 ++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cdeb775..54759c5a9808 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -494,6 +494,24 @@ static bool __init vmware_legacy_x2apic_available(void)
  * TDCALL[TDG.VP.VMCALL] uses %rax (arg0) and %rcx (arg2). Therefore,
  * we remap those registers to %r12 and %r13, respectively.
  */
+static inline void vmware_init_tdx_args(struct tdx_module_args *args, bool is_user,
+					unsigned long cmd, unsigned long in1,
+					unsigned long in3, unsigned long in4,
+					unsigned long in5, unsigned long in6)
+{
+	args->rbx = in1;
+	args->rdx = in3;
+	args->rsi = in4;
+	args->rdi = in5;
+	args->r10 = VMWARE_TDX_VENDOR_LEAF;
+	args->r11 = VMWARE_TDX_HCALL_FUNC;
+	args->r12 = VMWARE_HYPERVISOR_MAGIC;
+	args->r13 = cmd;
+	args->r14 = in6;
+	/* CPL */
+	args->r15 = is_user ? 3 : 0;
+}
+
 unsigned long vmware_tdx_hypercall(unsigned long cmd,
 				   unsigned long in1, unsigned long in3,
 				   unsigned long in4, unsigned long in5,
@@ -512,17 +530,7 @@ unsigned long vmware_tdx_hypercall(unsigned long cmd,
 		return ULONG_MAX;
 	}
 
-	args.rbx = in1;
-	args.rdx = in3;
-	args.rsi = in4;
-	args.rdi = in5;
-	args.r10 = VMWARE_TDX_VENDOR_LEAF;
-	args.r11 = VMWARE_TDX_HCALL_FUNC;
-	args.r12 = VMWARE_HYPERVISOR_MAGIC;
-	args.r13 = cmd;
-	/* CPL */
-	args.r15 = 0;
-
+	vmware_init_tdx_args(&args, false, cmd, in1, in3, in4, in5, 0);
 	__tdx_hypercall(&args);
 
 	if (out1)
@@ -539,6 +547,24 @@ unsigned long vmware_tdx_hypercall(unsigned long cmd,
 	return args.r12;
 }
 EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
+
+static bool vmware_tdx_user_hcall(struct pt_regs *regs)
+{
+	struct tdx_module_args args;
+
+	vmware_init_tdx_args(&args, true, regs->cx, regs->bx,
+			     regs->dx, regs->si, regs->di, regs->bp);
+	__tdx_hypercall(&args);
+	regs->ax = args.r12;
+	regs->bx = args.rbx;
+	regs->cx = args.r13;
+	regs->dx = args.rdx;
+	regs->si = args.rsi;
+	regs->di = args.rdi;
+	regs->bp = args.r14;
+
+	return true;
+}
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -586,4 +612,7 @@ const __initconst struct hypervisor_x86 x86_hyper_vmware = {
 	.runtime.sev_es_hcall_prepare	= vmware_sev_es_hcall_prepare,
 	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
 #endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	.runtime.tdx_hcall              = vmware_tdx_user_hcall,
+#endif
 };
-- 
2.40.1



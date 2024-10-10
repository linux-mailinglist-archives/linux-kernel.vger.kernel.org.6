Return-Path: <linux-kernel+bounces-358904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F733998522
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD421F21BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A81C5787;
	Thu, 10 Oct 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDijuVN0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3EF1CC89F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560071; cv=none; b=HZHBGPMIMJvnu3xbp07VQj5gpsD3GzPRc2B5Nl7ESaROLr+qjd/mdto2/cNkBkvK9+PhB810m63bBq1379TFOw4Ng1TpCB5RLdfhR63suZj/VrRBA1bRFfIe2NA1iQ9c9bXDvizl2T+aS4qHLOKs8RfBSdcxbocuPQ2hXXCgDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560071; c=relaxed/simple;
	bh=LswCk2i9g8K5KyBn9gI4xldOhoqS7tQiTwGUwHGEJZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRCI8OMMUbDxQOsWbxTq5nNCbQkgJo1TCYE0G7cg4QfVFBoTkNridMTfPcnjyZ60sntDjbutgjV9Pwbj/tYEU6idmvSYktYAdzqgXqdj5YEYnvbZv/kLrM7htp+NdZ+Oqt0K6/1XOcJTeZ7a9aWz/K7UbarPSaxIEllDGF2+spw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kDijuVN0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a995ec65c35so137467366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560067; x=1729164867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aytaH1oLbxE7oXL5Lh1BICkPib3Ft7vQWy4tTKokWI=;
        b=kDijuVN05AoRJDlnxR80lc9daqXdgtuMnzldu6eFJaIkeQm6a9/2IN60AcqdCRJ0gs
         Ty+2ho0QjTFk97O7mcA6PosqMYFextqI/A83Emrwd54Mj1TOqhCTq2X7HVQxIlMl36tV
         O2UDpIIbZYP8ohf4xSSc+H4omr2l+nXgrP0j91EPtkAjqsHr0/eg19TRRo0urhlgVXAJ
         8qbsKQzxJA7N4B1jhkN4RihZZKRaRbh4MxI9+2m7SqkKGr7zCyQoRtW3B5RXzRh5NgEp
         t4OPZlZt0dgKu0n6r+SzZ1iViIOW0j+s5qlmaMyaCJSJE3tCNZCrPosjS6cmgy8IyXAx
         1D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560067; x=1729164867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aytaH1oLbxE7oXL5Lh1BICkPib3Ft7vQWy4tTKokWI=;
        b=AYe4DnUZJjRIJvgW7ni0soh6DDbcQpfQKZ2qWuLkDGtZ0XXpqIeJ4Zw/1a/z0l+k8n
         H8thkJbwXibNccsBn8wruKVPmtbTNUY34JzVDJYU4/YfQYdN0dZUU/97fEmhDBIWzEgX
         z4CRZsWWT1yfiQ8G1pJVOMXKLmEN4rAX4IcdV9o/khiOZn9pct2t4xguCoihAWSHO3BP
         9fm7iKsAuUTlE7Ls+QSAtveyxf5RxfPL/UYxS9/DW/jEPG7KD/rzPKVg5Af7eanntjqL
         x/ABkUiTRnz1aQUVrUNNaBwMqRcRZ+CK20qOuOX/jtF+fVWDRE6bjUOPCy1Nom49necm
         uSVg==
X-Forwarded-Encrypted: i=1; AJvYcCXx3uCr8/tlrCKgiqSm+PZYcfu9DYFR9kwk/QIMtX6d7zh7i+W0IaBbVjj6hoEklTN7yf9GFI6vSQc8VfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ35E39wm6Qu+Eg1U1x6iRnZbqN0WbYlFKCTS2+DC453gQYwxX
	G7xEJj2ucCFk7VGR+IUwnb2hZYhRpE2nJ9XT9N3sdyfsqBfI3jVUMVFC3PLubUw=
X-Google-Smtp-Source: AGHT+IHJCZC9ttmjEV4fugv9O8uxWYQ1Bo3ztMHrIb7V/zI60wobNn2BdMO/fiOPIzAK9oQNZ6UZoA==
X-Received: by 2002:a17:907:940a:b0:a99:55ca:3758 with SMTP id a640c23a62f3a-a99a10e840emr242802266b.8.1728560067473;
        Thu, 10 Oct 2024 04:34:27 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:26 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:34:05 +0200
Subject: [PATCH RFC 27/28] ARM: entry: Add FIQ/NMI C callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-27-b94f451d087b@linaro.org>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
In-Reply-To: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

These NMI (FIQ) callbacks are added to complete the calls expected
by the generic entry. They are perfectly fine to add code to
but are left empty for now.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   |  4 ++++
 arch/arm/kernel/entry-armv.S   | 14 +++++++++++---
 arch/arm/kernel/entry-header.S |  2 ++
 arch/arm/kernel/entry.c        | 16 ++++++++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index a78bc5054b09..2e7ccd87f0eb 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -14,5 +14,9 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 void irqentry_enter_from_kernel_mode(struct pt_regs *regs);
 void irqentry_exit_to_kernel_mode(struct pt_regs *regs);
+void irqentry_nmi_enter_from_user_mode(struct pt_regs *regs);
+void irqentry_nmi_exit_to_user_mode(struct pt_regs *regs);
+void irqentry_nmi_enter_from_kernel_mode(struct pt_regs *regs);
+void irqentry_nmi_exit_to_kernel_mode(struct pt_regs *regs);
 
 #endif /* __ASM_ENTRY_H__ */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 600375f6f5d8..839f3ebe7228 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -157,7 +157,7 @@ ENDPROC(__und_invalid)
 #define SPFIX(code...)
 #endif
 
-	.macro	svc_entry, stack_hole=0 uaccess=1, overflow_check=1
+	.macro	svc_entry, stack_hole=0 uaccess=1, overflow_check=1, nmi=0
  UNWIND(.fnstart		)
 	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole)
  THUMB(	add	sp, r1		)	@ get SP in a GPR without
@@ -205,7 +205,11 @@ ENDPROC(__und_invalid)
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
 	mov	r0, sp				@ 'regs'
+	.if \nmi
+	bl	irqentry_nmi_enter_from_kernel_mode
+	.else
 	bl	irqentry_enter_from_kernel_mode
+	.endif
 
 	.endm
 
@@ -297,7 +301,7 @@ ENDPROC(__pabt_svc)
 
 	.align	5
 __fiq_svc:
-	svc_entry
+	svc_entry nmi=1
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
 	svc_exit_via_fiq
@@ -315,7 +319,7 @@ ENDPROC(__fiq_svc)
 @
 	.align 5
 __fiq_abt:
-	svc_entry
+	svc_entry nmi=1
 
  ARM(	msr	cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
  THUMB( mov	r0, #ABT_MODE | PSR_I_BIT | PSR_F_BIT )
@@ -490,9 +494,13 @@ ENDPROC(ret_from_exception)
 	.align	5
 __fiq_usr:
 	usr_entry
+	mov	r0, sp
+	bl	irqentry_nmi_enter_from_user_mode
 	kuser_cmpxchg_check
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
+	mov	r0, sp
+	bl	irqentry_nmi_exit_to_user_mode
 	get_thread_info tsk
 	restore_user_regs
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index cfaf14d71378..ec8a6e193802 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -252,6 +252,8 @@
 	@
 	.macro  svc_exit_via_fiq
 	uaccess_exit tsk, r0, r1
+	mov	r0, sp
+	bl	irqentry_nmi_exit_to_kernel_mode
 #ifndef CONFIG_THUMB2_KERNEL
 	@ ARM mode restore
 	mov	r0, sp
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 1e1284cc4cae..09109215dfdf 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -69,3 +69,19 @@ noinstr void irqentry_exit_to_kernel_mode(struct pt_regs *regs)
 	else
 		trace_hardirqs_off();
 }
+
+noinstr void irqentry_nmi_enter_from_user_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_nmi_exit_to_user_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_nmi_enter_from_kernel_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_nmi_exit_to_kernel_mode(struct pt_regs *regs)
+{
+}

-- 
2.46.2



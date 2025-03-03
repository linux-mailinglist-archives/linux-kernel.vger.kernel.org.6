Return-Path: <linux-kernel+bounces-542548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2113A4CB01
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF417A6D80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5062C20F09D;
	Mon,  3 Mar 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWJRYdRI"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BF84A3E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026679; cv=none; b=oQy/8lYxM8sqmA61VgAXYE+qiSCnYeZtEE5AN3Nj1NBb3ZhMf7NtexKivbNJ9awa++tnOUqDBeLT6jA1nGtAEEUsCmjTEO9XAW3pu0Tmcypx5QmdFAGwpWrub7mLWIpszhf0r1CBJ3k4ey/FlfLa3IYBfd17nKden2Qfp08urks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026679; c=relaxed/simple;
	bh=7uNLxFL6w5/YNrn9ge2LMRASeHwiD/3XkjgXwW3RvtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRLW0QWGs7FW4RGq3lqmbJ7XifbSIMMct1JhKjrg8jgv0vlqDnr81+dNxA1QI3MkRKbi58E5YMdeNy9ZRyiM4e9ZeodCBPIScVM27C4PMHixjWj94jhPr/INzZGKkRb1Mttqw3n2LBsQKdACjep4iym6VrDDlk/6IoFYlsIYLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWJRYdRI; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd0d09215aso34778816d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741026675; x=1741631475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0TtrUaTGReCVwzubBCegsVKYdxXhwZ9ysrrxftmMD4=;
        b=nWJRYdRIiqyU4Lox8s7RG8i/f2zo99H+/jRYiTjMGpeqoRvZaHeAli6nS8lKdjL5VT
         v0YlM7RqBAi5FlZLxTare+/JvhUDOb2INGaOhTZuesBGdyXz4hkqv0D9HtHGKMwj5+9U
         AnpWzQjk8BCdcXvQ7K11ZtfQ5wgE1rwME2fviqr5+iL+Oz8uaqvWX/qKuk0jc1ptkgTc
         peys691UL8C5Q1ViVxuPlyJrggCrMGHs1zrtg9LaFvmwnXfYJmFMpQGV4calpOItdrMV
         LxpoXQkvQJ5eOcwgY+abW9VYnJ/ztU1OBhnZ9yJP9UKB7XUrlaL8dLr0d+2DbP7NRHyK
         WCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026675; x=1741631475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0TtrUaTGReCVwzubBCegsVKYdxXhwZ9ysrrxftmMD4=;
        b=mDz9JjZKamr0BltZmZS30h6yJ3EKu6YXLgvqufcpG4iPU7r7Ca2GMpXLVQlDNoQrx0
         2bG3yW5af40QhmseC8KLvkk55fY4ujke1p7n7diSpOOVvlFaTV3qirIpgZtuoVkrqPpO
         HzwL5HddHeZXhfRGRSJ4P407EzIPIFuMwixeQMD7KkaRfs4eduQOf+XOQBz/mYWINJfv
         3YB56OPtrG6ymrOoDMnsst0af7elEejNWOaenLCRq8cPwrjKs0sNR6qsuNmpHoJxVTMx
         bQwxtQljJ5nTOK9to6Ze7XuHViaCW2ETCQlgz5GFq5GVCkBfPR5w52zBb7SbI32Vfqol
         LtLw==
X-Gm-Message-State: AOJu0YxUUoSAqxsUB6M14l3+699yycgrgTjNio/+hlfXp4eiCKMK6OE4
	lD3mOWzS90PsVDMnpK85nW1gNMR+8tP7I+If6LPjjzqLoYOlA7VTKJQO
X-Gm-Gg: ASbGncvYuih0NPblLYQ3+/Er/m/5TfUJ72SF3cGNHGnefyDoi6naH6JnOgptLV8A2Cv
	vwoF5ycx2A5ELMZOlve0obDSUM+G/MD8o/+AbNJiwJOKQRJcMirxMht3+dj7CYWuOHIDwcAQa85
	l6oZtdZBdA89PCHVkSGZgXL7rA25zsH1KWWFt1FZQ6YbD4RKlo4L/bHHPhbcc933Wt8NVNv+P+G
	MWcdPjoN0abWFwbFUy7+9vlyYwRP6BcwnLL0QOK/zJt5DYza7qQauwPRrW7dUFPNYrgLeHsumGH
	nXo/StiKIykAjh37JMq4WF8KpQ==
X-Google-Smtp-Source: AGHT+IHlc+qc40GLqdItzChoG0LRdfDixK2KoWDja5LxQT5VT9iVaOVfpsvEW3BBK3ZKL04+mfM/7g==
X-Received: by 2002:a05:6214:2241:b0:6e6:65df:557a with SMTP id 6a1803df08f44-6e8a0d7bdcamr240447496d6.31.1741026674708;
        Mon, 03 Mar 2025 10:31:14 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976346fcsm55898616d6.14.2025.03.03.10.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:31:14 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/asm: Merge KSTK_ESP() implementations
Date: Mon,  3 Mar 2025 13:31:11 -0500
Message-ID: <20250303183111.2245129-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 263042e4630a ("Save user RSP in pt_regs->sp on SYSCALL64
fastpath") simplified the 64-bit implementation of KSTK_ESP() which is
now identical to 32-bit.  Merge them into a common definition.

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h | 5 +----
 arch/x86/kernel/process_64.c     | 5 -----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a969bea1ed07..55f0e48413b0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -652,8 +652,6 @@ static __always_inline void prefetchw(const void *x)
 	.sysenter_cs		= __KERNEL_CS,				  \
 }
 
-#define KSTK_ESP(task)		(task_pt_regs(task)->sp)
-
 #else
 extern unsigned long __top_init_kernel_stack[];
 
@@ -661,8 +659,6 @@ extern unsigned long __top_init_kernel_stack[];
 	.sp	= (unsigned long)&__top_init_kernel_stack,		\
 }
 
-extern unsigned long KSTK_ESP(struct task_struct *task);
-
 #endif /* CONFIG_X86_64 */
 
 extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
@@ -676,6 +672,7 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 #define TASK_UNMAPPED_BASE		__TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
 
 #define KSTK_EIP(task)		(task_pt_regs(task)->ip)
+#define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 /* Get/set a process' ability to use the timestamp counter instruction */
 #define GET_TSC_CTL(adr)	get_tsc_mode((adr))
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4ca73ddfb30b..f983d2a57ac3 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -979,8 +979,3 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 
 	return ret;
 }
-
-unsigned long KSTK_ESP(struct task_struct *task)
-{
-	return task_pt_regs(task)->sp;
-}

base-commit: 693c8502970a533363e9ece482c80bb6db0c12a5
-- 
2.48.1



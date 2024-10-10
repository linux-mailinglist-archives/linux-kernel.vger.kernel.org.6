Return-Path: <linux-kernel+bounces-358879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2D998507
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5427C1C234CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051001C3F2F;
	Thu, 10 Oct 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meuoJII3"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94B1C32EC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560029; cv=none; b=hsOasugBai2D5n+fS3nmfO3/hV12AY/OklAu78WuPdqX2kcwWgYASY/tnYjfYYJ8DDf7LivAI4cWuSpaXivgAgPtHgtJff5jR2yXgusJU2knEL4aUIWj++AuiEXt+95mYs+uuPiqWfFBGau91DZ6GOldo6FKP+IIA1jLht7+0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560029; c=relaxed/simple;
	bh=0u2mldWq4lrnYPUiJZwplGdYFoRn/IGd4Af409B6kLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6oAVDFEIL0Imo+HVLIoJ1B1CHWYXySLzbs4HHYuU/ePBUlc1IoHax4BFWO/kmz/ouclN5hRUsxnL0kNAWeBF0m52Sw3v3k8F3mgfBshZwnttYGJITgUNgltHboQZhAPJz3Zzqkv6NrINYliO+x4P+xC3hJti4+teMcrwCKubGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=meuoJII3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9952ea05c5so135409366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560026; x=1729164826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4LTFu04v+ewJrCMf1qStO/yKKemj/dlkSOHqQ2h8u0=;
        b=meuoJII3VbN6cv+9I18IbBSiTZrVSn/lExOstWwCNmU8aIYkQD22xGENCIIg74Nfw8
         5xI5XIOCcNCo5xQNjXmijAwF9ePU6VY0pG81DqoFCnAoB7RORzvBKiTshw9tcGFP180+
         ZsikS10OvRWpe7SY+tyHbtUNp7wJwhV6RXlp81Gv/RR/1C+eoSUXhPF316j4tmPJUpYv
         lTK+utYG7tzFMAAqOR7IFJJQiqXjVGhDBMAEp9h/alrQixOLS+BE/8bY3+B7LqBRM/JK
         47l6GP1Is/dDwWH7zOoo7GClrWjnRbNIruQCcoajyfcbVXrBfWAzCrLWNrP1ILS4zHsm
         kiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560026; x=1729164826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4LTFu04v+ewJrCMf1qStO/yKKemj/dlkSOHqQ2h8u0=;
        b=cAIwmrGawZ+jz1vn8kMbPNWBckcM11VEND1bWDkOnZLjen0ivVWCDagmCYM4ZlSL60
         7xCiDnUMTJVIZc+1jrAwrXaAUy5xJEKvhsHgmVGFRta5fZdNeu1x2DZ9RxFD3tSdjLzS
         4Y3SOKgENkrsaYpiwSk9nrAi4oqCgW/fUazqxz9Qiyi5n5s+0VrxKp6jbK5/XA7nM+ng
         1cSt0VRTeOBHawqurSgcK/WRxGVE5gPh/BYlQeaa9uYy7lvCa8zgz7Knb4a7u+QPVyYF
         oJwRwIgULFMfzWrM/PYxytblERNK4u8r5AZbl0llymMCv0Wc6k9bdyz5drWjGbQ+ttfF
         MaLA==
X-Forwarded-Encrypted: i=1; AJvYcCVHrVHwYJOojEgaUlSFk8X5ReC5CQmzHoh3C6e6MYlCuv3Tuf/93Oda77juVlj62xi4jpLe9D7FKRhRauU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2shHn8FumK41bg4IHX3hErs692/MFWKDc0fEZmnkzv4sfN7x
	UQakyRdm0WblyzjTwo+rl7nbe1QSCtpbTnJfTKMMSBOie7cTKgLrsetrmAOF9ZM=
X-Google-Smtp-Source: AGHT+IF/7BdKriGHfpakAch78gEDyPg7g4F5Squ3DH3oytxrvyGsFjm+zrnSb3mJBDsLPEmr+DbRWQ==
X-Received: by 2002:a17:907:7e84:b0:a99:62a4:3fc1 with SMTP id a640c23a62f3a-a998d315001mr502326466b.49.1728560026025;
        Thu, 10 Oct 2024 04:33:46 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:33:44 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:40 +0200
Subject: [PATCH RFC 02/28] ARM: ptrace: Split report_syscall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-2-b94f451d087b@linaro.org>
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

The generic entry code requires that report_syscall() be provided
in two parts: report_syscall_enter() and report_syscall_exit()
so split the combined function in two.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/ptrace.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84..07b0daf47441 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -827,31 +827,45 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
+static void report_syscall_enter(struct pt_regs *regs)
 {
 	unsigned long ip;
 
 	/*
 	 * IP is used to denote syscall entry/exit:
-	 * IP = 0 -> entry, =1 -> exit
+	 * IP = 0 -> entry
 	 */
 	ip = regs->ARM_ip;
-	regs->ARM_ip = dir;
+	regs->ARM_ip = PTRACE_SYSCALL_ENTER;
 
-	if (dir == PTRACE_SYSCALL_EXIT)
-		ptrace_report_syscall_exit(regs, 0);
-	else if (ptrace_report_syscall_entry(regs))
+	if (ptrace_report_syscall_entry(regs))
 		current_thread_info()->abi_syscall = -1;
 
 	regs->ARM_ip = ip;
 }
 
+static void report_syscall_exit(struct pt_regs *regs)
+{
+	unsigned long ip;
+
+	/*
+	 * IP is used to denote syscall entry/exit:
+	 * IP = 1 -> exit
+	 */
+	ip = regs->ARM_ip;
+	regs->ARM_ip = PTRACE_SYSCALL_EXIT;
+
+	ptrace_report_syscall_exit(regs, 0);
+
+	regs->ARM_ip = ip;
+}
+
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	int scno;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		report_syscall(regs, PTRACE_SYSCALL_ENTER);
+		report_syscall_enter(regs);
 
 	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
@@ -892,5 +906,5 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, regs_return_value(regs));
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		report_syscall(regs, PTRACE_SYSCALL_EXIT);
+		report_syscall_exit(regs);
 }

-- 
2.46.2



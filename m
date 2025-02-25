Return-Path: <linux-kernel+bounces-530943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8CA43A68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A128E164C94
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0823C263F4D;
	Tue, 25 Feb 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXpGzSwk"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80D2054FD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477305; cv=none; b=EZRoU31WvYz09bXTnipZ9CXO463jIEy1+T9SsBzCYmDOeqD8iosodwjEJjLi2UtHmMfvOqvXKieoQMoYwYu0fvRvU7JLJUEGqDtbX4fHQDX2KMYWhkwWadzPivCaS4ivYs6hBYtv7Iyjv4UT9ds4C0FVquFUySi55m6yi7XFrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477305; c=relaxed/simple;
	bh=9bf1s4H2SqLZ79zTukwsYu+F5BulFXGKPVAOZYJS8XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHJS2Se/KNNmccUgqIZ8nMTlJ4bZjTrGI4Q8qukXG3gVzWvI3+1aZm1BHmtGFxMKmPoQeZFMTWnwpgas9UclzGpmp3ZXDqXIf56zLhcki+9s8hOiEAeL2Ip6vpu6dblFMKGBskDCzb2/7OAV7WicM3q6aEyFgTEUToSAo2qJHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXpGzSwk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30795988ebeso56037181fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477302; x=1741082102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeNYI4Yc1OrceUVt/GJDCyO7YwVHZ9lpFFe5ekDh0x0=;
        b=zXpGzSwk4iypnzXV4ocwsaVte4oY8MB3x1s9coaKradt97+V1Oz1VyzHezXRd4KU6l
         BYi4IHmIpVIJb+3Csf+6OK8+19nGjEf1Op4nUsO4p9UzVjKHaRz2z/ycnhJrojv4/3n2
         9JbOOzE8sG1qf8iA8Me7SOMT2+QQqBAFJ3AIqIqjvztPcwQgmwy+Hs8NhROH81k38BD3
         ckCO4WnXXDgrUvTjj9Gnkq36xrNOMbqlqHc6uQThxehTTdRkRXckpyMJa3h88iwOISAi
         qeHtZP+MDT/oQ8RO/cn5+T/2uE71mMMpk4zyRFCI2le41EfC0Z9DQ99toaQeEiUgBrYj
         yPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477302; x=1741082102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeNYI4Yc1OrceUVt/GJDCyO7YwVHZ9lpFFe5ekDh0x0=;
        b=dzOdyKdrWZF3stkDwegrJnOkrSOykzJCmfo7HJFpvAjMZFr5T0NQm+hDjHjO6q9mfg
         I6hgPSKB1Iz7UMu5mie3tRan/frHXqJXGtLWmfBAHFGY2fk7TELWvogIxSLDABOIL/N8
         pZdwlxvYhFwOeR2GIUhrAxZDNFvpdzdKan8QMrGKIG4gCLEYTGsE/v54YeQN/27eeI5N
         H1ZGn+Wk2svdkLWSv4u9PK4xMo1zd++gcbm2UB+PbgUyEQEYG9EY40saEI5efgad0hGw
         PzbQiuejcDCaQBQuSVfyeGaVQA4R++S30NxG0nwk4LTYMYyAG6wuPOY2oFnD78U0RvRe
         5Bmg==
X-Forwarded-Encrypted: i=1; AJvYcCXlkN/PH2V19Y6kkmFQnMM/cXpVqsLO0iqjys4hE12CXpRo87eGRiMXIyZ1kX+DsVwQFdq7haz8v6JyawM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/wPR+ESIBvBfO9Y6p4bW1LQQiLoRovzg2M+U0rtwpsRl+8ze
	RkkZ6eVSKyh4FwgaHwGaEvnF3BxEL1fFANiYy2/0bRlFXuzojvv7dFMZMo98INI=
X-Gm-Gg: ASbGncvdh6xefV1eiPyYY+28wGtPp6ZLy+ayFmtU1Q4fU7qEO+Z0HLstv1e5N6WJWUk
	gRW4lQu28YfvWzWqqN2ofOehrBmoZe7oZ7JxKTsxGy4ZQTHTW/U9Y5dTPSjrD6zJgz9Gcl5QIr8
	cRFSx3owNecat4MhGC+CiGZ5cdGxfY3l++UmiE/ZlGOMTkiqb0ISv9gDznL9cg5M5ZBfp14afAK
	w3fATqR56to2UzW5j31KGJ3DcNw8q5yf/iGWdF7un6Gqqzic7Bes3jp4nfzqOtJt7ocNCsFdhU1
	W8g8LgjATrCRtzGG/6vYAu8zDShNbvUtyEPU
X-Google-Smtp-Source: AGHT+IGq0OxvT7/cZlFfZbbX0H/MkEPa6FnOUXsHEgn9uErHuYCGdCabGyfw1Gq2rovjVGQpSBjALQ==
X-Received: by 2002:a05:6512:130b:b0:545:3032:91fd with SMTP id 2adb3069b0e04-548510cf943mr985679e87.16.1740477301678;
        Tue, 25 Feb 2025 01:55:01 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:01 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:49 +0100
Subject: [PATCH v5 02/31] ARM: ptrace: Split report_syscall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-2-2f02313653e5@linaro.org>
References: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
In-Reply-To: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

The generic entry code requires that report_syscall() be provided
in two parts: report_syscall_enter() and report_syscall_exit()
so split the combined function in two.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/ptrace.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84c476a672cbfe1c8ece8355d8512d..07b0daf47441f1f76a8af416acc74fa5ed770403 100644
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
2.48.1



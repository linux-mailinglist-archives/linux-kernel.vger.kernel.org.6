Return-Path: <linux-kernel+bounces-511004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DECA324B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257123A1A80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245420AF82;
	Wed, 12 Feb 2025 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kt5PDTK+"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A12080F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359392; cv=none; b=KPPJj2yxh/AC3O2+yN6KpSAcMB3o1gNG2q7aaXddbBFXquSjVOXKzbBjNNsaDV04RqVPfsoE8Yd71p99qccJ8VFoXNaRD3Q4EEgHKbdUH9CvZCeprmVNAgQK8orF00SKWKsAT9TM5QSuxwFhEL2eZN0WZ9YLs9IOW2o5hXBY9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359392; c=relaxed/simple;
	bh=9bf1s4H2SqLZ79zTukwsYu+F5BulFXGKPVAOZYJS8XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/D8IEbCRYZg9L8VIrqKycvzFondo5NNaIDDYij0HAaPMSbk55IBntIQZvlzJOTN7K4NWJqTNBJYZVhAcDNc1RueYYKmHzIjrWVlatOgJsk2elJqr8K8d+ATctMYaGDQLgf7TjA+nbbnLbQLLiorYkuL6IdxkRN4pX6aWhWL/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kt5PDTK+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308edbc368cso32846901fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359388; x=1739964188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeNYI4Yc1OrceUVt/GJDCyO7YwVHZ9lpFFe5ekDh0x0=;
        b=Kt5PDTK+hyr0FaqzdFc/JACFjWCtTpu1NJZK/2F9piifbmA0bqgqbOAuhmScjOO4C5
         q1rlUEmVe0fy68t2flTaYaOoUiAJ6ubngubyi4Ae5hK5N+ABnuUwhEI3znBpDI6M6bh6
         AjdGmaGQY5aS07SLXbd/Tj+TrCmkuT0Js+1iNqRc1pY9165K9s7OLAJraLomOKXB8DKD
         HDJ7Js2myxd+kXedgpEYO7IEZQF2e7DQQYu+cgYR5S64NJcakL0YVvADhQchhZ2d1snx
         zOH4YLdVHrD9tnnrt5DE9Lq7QsGB4uY4gv1rRYozeQiJ1L4VZ8p5HhJvv3A2xNVSlqbb
         OlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359388; x=1739964188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeNYI4Yc1OrceUVt/GJDCyO7YwVHZ9lpFFe5ekDh0x0=;
        b=KtGNZPuawKSsYrN58xOFnSPjDZNlwXJL9skghwsgXDixPJxRjNTX+Cy+KVI1+o8VVn
         E3c6nu/vbLXp9GNcyyWAXLqCuR34NIaqmdgVeA0axulaaV5Hho2EuDFV04q2JVcK58uT
         MW6u5ArloPqoS4qCvU+1iRuIJ7I/qek7ixunSr28TO23k4mvtXNzWHo7mvPkZDyTVDTM
         olFKGa2gnLqdjXSFZyoJI1ZCfGrkPmLWp34sWesLb3lcE56xQwlMOuOL50Map1TOHrfq
         DBgV5Ggq/1qreeYACSy/+73cFDGbxJdmMESJKEXET4rGAofGCK9J56SYENcH25xImVwW
         MS+A==
X-Forwarded-Encrypted: i=1; AJvYcCWqkuMmFS+7VUSXkqmHNzD9qS3dQZP76hrzv0DsNuONpV0d8hnDwKYRwA+fNvbSIGuStKNhg6aJPH79h/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgzb6zuyplu/YvD49+R8h7T0Gniipq9XII+FdwvCffmWNPdPER
	HjRN3h6XgoSsXmo34GiD0YdK2/wQbE3IQbTKNxzD4ZiVqydsZr5wVurYouAVO78=
X-Gm-Gg: ASbGncsVDScwVVbubmzXcf+BhDv0RcGYwEbSSBOZ/ccBVuyXYRUJvwISp9E69zSFAYd
	R+q/C+1hPoflIoXAyyJ+FaTgNuPqRNgX2e3c2TVpon1lYxSHiiYOKkPxCq+gb03jdiP8FGDBuDx
	m+q4FaM2AtKo5UaBnpDsMsx761+y/4zX6QcosnVWqdYLehnrUO9AUvnAi6zL838g8onpUiY7SVV
	IVIAkG2nyCixFe2SYfd2kxHZV+r9wJ/9tvtHjoyeuMZ1s1JX8UXkR6YBrGVr8hEuMl7hoalLp8z
	52QBrAagF1IGcwTCYDI9ecJbAg==
X-Google-Smtp-Source: AGHT+IF0bN8IrtjGLfeKlbBP9UpoS79dKnT/CxxK+D4rlHCjY6PG5wH4SvZpBeywkQxHf+e/L4Kf6g==
X-Received: by 2002:a05:651c:50a:b0:308:eabd:2991 with SMTP id 38308e7fff4ca-30904fc99ccmr6630861fa.1.1739359387948;
        Wed, 12 Feb 2025 03:23:07 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:07 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:22:56 +0100
Subject: [PATCH v4 02/31] ARM: ptrace: Split report_syscall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-2-a457ff0a61d6@linaro.org>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
In-Reply-To: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
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



Return-Path: <linux-kernel+bounces-386742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF099B4795
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20013284575
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5720695A;
	Tue, 29 Oct 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvLuHkxq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282C205143
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199173; cv=none; b=DoHWbX/rnqRiYYCOjy/R66bnY1Iz1qlcn9coplURn/WqsFwE03RnTPApWxyaCfshW7w/PYTbPAUjtEL/Dbje7aUz20ofRizPE7tkU6LktjG0qrZnPYBPJpzAsuT7jd61jRyRyBZdzgTjZLjWoiXVU43CaEz/QG/0eJiqifBxotE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199173; c=relaxed/simple;
	bh=0u2mldWq4lrnYPUiJZwplGdYFoRn/IGd4Af409B6kLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXV0TK7/5lmwARy0TtzZU3cNE8+MjqRWKon5btEfbNmVzo0/pfjdXtdZgO1z2SsiHRrem6xTdL76BuuqU9PfZFrLFMw+WjbpRVSWsPp7eIK8YMtQefkPNHyeYS2Bz2L4/MxN3xogciVGjQH0siTz3uhwYDTLxP+4ObS90fMcqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LvLuHkxq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5632645e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199169; x=1730803969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4LTFu04v+ewJrCMf1qStO/yKKemj/dlkSOHqQ2h8u0=;
        b=LvLuHkxq/NGHQEupM6XJyVw41x5XJ+rR5TEvhV/guyI04Hu146R1ob7SFawYep2SKs
         NOnLSyzDV3KbLYZgxllFjne4E3ooGUPTbq9wZ6wyLwLnzRmUEWZ1RNU8gby2RVxk/5PJ
         VBOH3hx9rraMHeTB/EIiOhj/gQxf7TQtU5XkyhB8GeCYjKLD+aZFY21ItlljBQVSz0MA
         DRNXFdeaBWQKhAuQRrMhqB05RgTI/Iq/MJM5/fuzid2cs61JZiScf/lTLsQucubSYnAm
         ond/r8TmFTtvqyxz48wq24cufzCSXCleOhxc9gnZb1lhZDI05ZYONsKF1T5QaKDaY4eA
         6f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199169; x=1730803969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4LTFu04v+ewJrCMf1qStO/yKKemj/dlkSOHqQ2h8u0=;
        b=BhpLVeA6S/I0Qg0KbxI87kU86vEmlg+oNc8/ntPjg4B8A284VndEZahZOaXHLGdiTw
         WIyGKlWapnA8BXKwPk8KBOzH+CnBM9G9wYcpJXINYMD8WBiaEZsGRGEoLoUhZZSwoWd1
         My30ggWEmTgz3/nQlKMdSnbMg1qBVnnTZ21MwS5GT/tfzy3jLJSSkkaejWsXUsmNqk1n
         C5tGTN+Fn/+Ka0iT8yKP8l4NvNfUdzImzlvZ0EKwijBJ9CBFwg+daxjZMCA/4H3LD6ut
         uY//QoVG0yJmPfS5iC5nWZVczaylYOLFytJVzheE0Nre78pNLuaMa+C0mEyJlTYyl2M3
         rpYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZd5NxvfR1BztqDkpqf4278LY+dLMZ/cQu6T3nvIN76f2BG6Jn4OiY8HqiVQf2X9QT/7Q4FcSrNGGwM64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWg9brni5PnbTdbiv5kEluBH0mT4tPMeGM0XzwlwxmBai1L4XI
	qRbeCDfpnkDn5Xk0HVRoGYZHpX5/R7MaA1yIJ55LmB4FGBH+LuCCdG7/n9UgNUY=
X-Google-Smtp-Source: AGHT+IHzdoIpnm1raIIfmAFKx69MVi8OCs2VC2TJN21ljNCIN9pZ7ToE5AMSUbLLmWlJJIXJdiGYpg==
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-53b34a2e4d0mr4368775e87.49.1730199169220;
        Tue, 29 Oct 2024 03:52:49 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:47 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:42 +0100
Subject: [PATCH RFC v2 02/28] ARM: ptrace: Split report_syscall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-2-573519abef38@linaro.org>
References: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
In-Reply-To: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
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



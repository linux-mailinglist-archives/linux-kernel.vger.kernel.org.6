Return-Path: <linux-kernel+bounces-233822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173991BDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD15D1F23AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA9158D6C;
	Fri, 28 Jun 2024 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Krs2+7lv"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CF158A39
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575313; cv=none; b=W9J4RaO5RdMi1qJ1dkbEJBcHBFQEqVK+1KQRu+sUMURFMV355UnNBs2RIRHQt77nzUgETnDjoof++LtUTDnIqn8HjY77l26atJLNbOqJnEp5N2Ftffdq5Vz4kiU3uQrCFW2nNKrxCLGiypw2+HEcGXGOLsfCDmAMRQMsBWyVxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575313; c=relaxed/simple;
	bh=r2Z/LjuDaVIR0Nv6TzPPNFim2MqrgP18fiLXA6TsO1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/p+yczDOIKap4ZcFhbwkYSdEFdsaV5qvx7bRRy7M04a/bTS17kDcd8mY34PVINoTP3oSCXQHXZNfJEciOPJDUx6kxqQiZFLKw3SFWfO5kBC+nR1UddyJQkdI5XUdCVLItJiwYVoUX44sRO2XixD4ut3OxYiCeInHlZtViCxzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Krs2+7lv; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25cae7464f5so261510fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575310; x=1720180110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qB3HAqDltbljiMzJTGZiW2YiCbH7zPagQDm7C4z8cfY=;
        b=Krs2+7lvcIjFVcbsXmVKWiEPCFO/oJOFQCDzQ9Js/Ar1pxeRKnqet7du87PtyCygVx
         umMQhBu50e3P2vrbR9Qa/XRTFbAh9CCqgWMQs6usqrHjpBkIo0w3GTuwBuSuFNlZGInf
         LKts/TXZZ3xEasr4PaMeAlOTXCdZAYcmkSBj5G6W4SAGBi6nXKK/5N9HutVApp3tiAZ1
         dOYFqRJd0mFj8vwh6Dk/GreFVzywjiErdx7ACUGzLt+N6UjyJ6pf0EIrm9qWqIzw5WCL
         29lqVk9VmXz9lxv6FA5v8KHXnHOXP5Eej5vx6o5Z1hsMKPwlG3G0RdENxCJD+3gVSFye
         l21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575310; x=1720180110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB3HAqDltbljiMzJTGZiW2YiCbH7zPagQDm7C4z8cfY=;
        b=nodYP7VTPwyxDhRWMIqMzH7D6EBrKzFvfMlDIdExpihRjiFq7kaEv0oAdgIAsWxmnG
         Z2eoQ0ehZhKbCCtEbCqHJY+xCuBnU+LXRL1JyelOHmVi7sbYpdFqMKpR6XIMggjr81yt
         7On1cei9VI68/EMpXqDq3KfDQmUZAdQyKaJGrPagghqABX4DbiwuVez47FAUoAbEH3+d
         KRKAHn5RlZIQ/xB/iB8xwZ5OccTJv5AiThEx73LeZ2k2ZdJwmVqO+/6JGwUeSDTI1MN0
         K4Uxg3PFDCOIYf6UWsxxS/xPuitojIe6P+6XvSMIbTb9cr4T0WNnlmywRERCzeWHMHCN
         6QTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1/6Uby2ErCH8u2wvoRTuPeGelxF/ksyFpqTFujfnKgrJZ+LUbU0rWTvq6IBZdbtLn+FRA/4GQoyXUiN2sKRzwCc2rUZxCoY8xzhX8
X-Gm-Message-State: AOJu0Yy++tvDGr8q8wQN/KYLNLyg+byKF3bCxtIq7e78KIYPzMqVJJT/
	3I0yWfwOuszCdpD+gSaPoTF0zoIDWZ57O51YTwaXarBpJo0W6DGE/YnZBGsxldU=
X-Google-Smtp-Source: AGHT+IGkb+sc7AJyAjkV7J32sa3aBUKfOklckBlPnZN/quYaW53HpZw38PiUs6Fyq7Dt9/iYzdP+/g==
X-Received: by 2002:a05:6870:9110:b0:254:a57e:1aed with SMTP id 586e51a60fabf-25d06cd083dmr17067065fac.26.1719575310299;
        Fri, 28 Jun 2024 04:48:30 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb90sm1377775b3a.139.2024.06.28.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:48:30 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 28 Jun 2024 19:47:47 +0800
Subject: [PATCH v2 4/6] riscv: ftrace: do not use stop_machine to update
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dev-andyc-dyn-ftrace-v4-v2-4-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

Now it is safe to remove dependency from stop_machine() for us to patch
code in ftrace.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/kernel/ftrace.c | 53 ++++------------------------------------------
 1 file changed, 4 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 5ebe412280ef..57a6558e212e 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -13,23 +13,13 @@
 #include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-void ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
+void arch_ftrace_update_code(int command)
 {
 	mutex_lock(&text_mutex);
-
-	/*
-	 * The code sequences we use for ftrace can't be patched while the
-	 * kernel is running, so we need to use stop_machine() to modify them
-	 * for now.  This doesn't play nice with text_mutex, we use this flag
-	 * to elide the check.
-	 */
-	riscv_patch_in_stop_machine = true;
-}
-
-void ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
-{
-	riscv_patch_in_stop_machine = false;
+	command |= FTRACE_MAY_SLEEP;
+	ftrace_modify_all_code(command);
 	mutex_unlock(&text_mutex);
+	flush_icache_all();
 }
 
 static int ftrace_check_current_call(unsigned long hook_pos,
@@ -155,41 +145,6 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return __ftrace_modify_call_site(&ftrace_call_dest, func, true);
 }
 
-struct ftrace_modify_param {
-	int command;
-	atomic_t cpu_count;
-};
-
-static int __ftrace_modify_code(void *data)
-{
-	struct ftrace_modify_param *param = data;
-
-	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
-		ftrace_modify_all_code(param->command);
-		/*
-		 * Make sure the patching store is effective *before* we
-		 * increment the counter which releases all waiting CPUs
-		 * by using the release variant of atomic increment. The
-		 * release pairs with the call to local_flush_icache_all()
-		 * on the waiting CPU.
-		 */
-		atomic_inc_return_release(&param->cpu_count);
-	} else {
-		while (atomic_read(&param->cpu_count) <= num_online_cpus())
-			cpu_relax();
-
-		local_flush_icache_all();
-	}
-
-	return 0;
-}
-
-void arch_ftrace_update_code(int command)
-{
-	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
-
-	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
-}
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS

-- 
2.43.0



Return-Path: <linux-kernel+bounces-396732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285699BD15F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA271F23D59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD817BEBF;
	Tue,  5 Nov 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFQlFI8w"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BE153803
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822309; cv=none; b=Hid/m/ZJhKEEHHZHO0hMpc0lmL6G6R0l+CfYgQTWQPlPkiERmCdl7IwkgAICPB4vjz6MRdYT/FM/OSlMwFlGnPmJZ3RmAZxTxOlYFHTm40Uxr3l4RQ+Ul3Pzi/XxccRBMatTbVQLCh1uQJEQk8uWZy9JvCosolc+SGr6nO9mlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822309; c=relaxed/simple;
	bh=VKZxyxQuCeCAp7E1ZD/xgpVA5NwZJY41JC3Fi32MySo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrlCjPwzRpxBXrhnF8YK9+nVJPnqjl31dGqo3FDAjkWNhaJK/13rOUBazZhyN/yBlQ2hSdfzQF1La/YDMsmEfGdUUK6ZzopV0hSPTYikCF2kvqzZUKQVQm37Xruvm4lzT5z/3knBWJr0KH+5QAZdbMCfTeuZeQ8mzQpj4BkoLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFQlFI8w; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1507c42faso488391085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822306; x=1731427106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYtUu/3spTzBfsHpJwDAQi6vkZMUuhHEudbP0S8CJAI=;
        b=kFQlFI8wMajP2qN8EZWYnUrrDaVeuF3eS0NWGOyZx8NEQw+k0Unfcw/9adeOrywTVn
         G6NVrNSAjONM+luc+n+IFzAbZzSXRVkiSINtC0kdp4AiN5yJBsLpL2rajlHPO0JM6oI+
         NyNNDs6CVzdkrkW2nsAi26InLH/e+oWtoX+YRjuqNhJTM296O1AreNjE+oF8udoEfCXw
         WIko07guox8dp8uw9nGbcs7xUNzm4TKuHMiyN0fNVpMvwenwVrG7izS3DZ8O7QHTVXgm
         VFAucQ5VBSk+QEbEO+1BAWHNzWG1l/LjXNBYL129O71Vi/V/M2EC/mBWULQHLo8E26bM
         hlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822306; x=1731427106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYtUu/3spTzBfsHpJwDAQi6vkZMUuhHEudbP0S8CJAI=;
        b=X/IcK0nIvZtu+2wp902Xm/IvD1GqXJgN4XOyFzVpw6z+oyHuEQX+AKK3wOnrthPluU
         phMXBcO76OZ5S6AGgf6sORfiCAX7CBvue1Du7hYIjdu2plLGCjvKrqKNhOqPchi6timc
         406hJkmWcVon2pd3s6heU6SMflpQTqQorgyjklBjMXa3UsZc3aRr8yWGOPJMgyBnAEtX
         8y/x1e3uQKdKrdwWUfzoCQ46+RDv1WlBmYBMKCBWPVTqOZfGWZhXpj9bxVZLu2t23e52
         +AvQ5ukAfdwMlTJt1C0bemEAJtMRhRu82AeIP5VIbQB/xd05PE5djAB/NPY7CyjRN2Tn
         VJUA==
X-Gm-Message-State: AOJu0YzbNtwyLAPvS73jWdJjDlB+xx746mZr9s5gFZCXZLf0kFCZbgCg
	bqUWTij9CUSwoxuRUgSsUwls9Rxuox7mxqS3H6qksR7vLT6mAZkZK97h
X-Google-Smtp-Source: AGHT+IHJ0vJs6Nk1zwPgH5KUP/ZZRTfwjSoxm05Oh/3CWA4aU8hlkdRE/ebP8IGoApHWXFwDOT1uWA==
X-Received: by 2002:a05:6214:483:b0:6cb:644e:c9a8 with SMTP id 6a1803df08f44-6d35b8e6aefmr286579416d6.4.1730822305870;
        Tue, 05 Nov 2024 07:58:25 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:25 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 10/16] x86/percpu/64: Remove fixed_percpu_data
Date: Tue,  5 Nov 2024 10:57:55 -0500
Message-ID: <20241105155801.1779119-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the stack protector canary value is a normal percpu variable,
fixed_percpu_data is unused and can be removed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h | 8 --------
 arch/x86/kernel/cpu/common.c     | 4 ----
 arch/x86/kernel/vmlinux.lds.S    | 1 -
 arch/x86/tools/relocs.c          | 1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ae50d5d4fa26..e1b856e2f944 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -418,14 +418,6 @@ struct irq_stack {
 } __aligned(IRQ_STACK_SIZE);
 
 #ifdef CONFIG_X86_64
-struct fixed_percpu_data {
-	char		gs_base[40];
-	unsigned long	reserved;
-};
-
-DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
-DECLARE_INIT_PER_CPU(fixed_percpu_data);
-
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1f33d5feb050..d6102e772c7e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2020,10 +2020,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 42d1c05b0207..859ff7c0dc02 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -456,7 +456,6 @@ PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 8b5e2bc3d241..a661a6bab4cf 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -829,7 +829,6 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
-- 
2.47.0



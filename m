Return-Path: <linux-kernel+bounces-404744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E49C479D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66C31F211D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C819F1BD4F1;
	Mon, 11 Nov 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Oohz/73x"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EA1E25EE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358505; cv=none; b=j+SnTTDHqr81eJwnZVtJ8dQW85U7sbs+dEXFK9ECYnoXgcWMSLCY6/ShXYtb3++03qH3w74kO2f+SAvrU1BCtia2FpRMIAN8JQtpSqa2qIdI3zl2NYjUIH4EmT9hPsgDav4z9qCIA7pm5XVC1kCMjAahlPsQL9XV2PDeOXwAJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358505; c=relaxed/simple;
	bh=C2e0qcdc5PaNPYSlHWVjFzNo4JFQL2cVOGLaECCTRx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8ppggiJDu9XwC+0NvUstvUTn6AJMBozEBfKtSMLDcHkwFrBJanr5JCghDVKTBA7KJxwLoX2UY6Axk3IeK4NelXG5lfEnRt5RIfLUFQxwNKouSFR55Tp0xf7MVkWVFqpcbyPHeVdxKmhArNmt3B+pYZ1ZoOZnyGbXXwPRB/7woY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Oohz/73x; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so4003080a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358503; x=1731963303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v87E2FN7teOOU1wWTBhK9gVAN0VjVVh/KdbYNd+fh68=;
        b=Oohz/73xCwOTmNpPf7ljnGldlXieHokB+fNkE2Y6zPmlccW2ZAXgnPheUZVHlOvxio
         HWAD96OSPXwRlecdyfZUM3QhmOn5lMIm87Lg9yK4zyjEccVDKAl6+0nzremahRSGgcrm
         6s4xJPvwXJdM7d5wehDotwhF8pnPi+pbwixDn69rC9TFxO83FdT9C6DNUGcKn/wdWRjx
         7QZoaGhNssitAfRt/47ZlpBKjC0gUIal1C1Tzjq/gXk53sWNUXQe0H9MRxNI42/Bd9pt
         ctsa5BxYDQE34WXKQ44KhCElcT5xuzVwEuATKRLYJ4uQO0Yuq7646h2wi9LOwJwI+34/
         DpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358503; x=1731963303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v87E2FN7teOOU1wWTBhK9gVAN0VjVVh/KdbYNd+fh68=;
        b=bYdqkYatoDyYJkr89ze+V3PONt+oPjU4+U7Wq4WdYOHRv55bt9dadiNRuBLVcAmOUT
         buOGPl2AHG8j6zSNX0J7csuVN5N9EepxC1ETliJk3wRpM5QnCecKQ2VD1QSGBgVUziUz
         LVp87T8LqV6uPgrmpxfRNqnlxhHIzd68O+mrobwB5N0JARVoEDF+sxMWnbzoIRlJDYNz
         zH0h+YwwRInfA0tuVESRI6truhhLwQNmiNz263yFNy7DMSTOA17/99JE1U5tCzvp4EFa
         v01Ez+fDsFuy0nXOHjvPLk/G34n+DcoEQBDK0vb5fyYZXGWxqEnZbTw/NXXdjmEXUCu4
         9fWA==
X-Gm-Message-State: AOJu0YxW6Fjc0S2DRuP9QCiewQDQX8sQEAmg1W3WSIqRDDD49ThqArew
	9PNdD6sM85xk7hyVHYj0kZKmqakEakkDWYlFRA/WmVy0nUPwmoWzmnJ5OXuiedE=
X-Google-Smtp-Source: AGHT+IE6pHU7K0D6Kovlo0iT4mPH8p4N2kcP8nKM47bgfKvZsvt7nFC76OWezD1by9y3vt8KBs+5Mg==
X-Received: by 2002:a17:90b:1a92:b0:2e2:cd22:b092 with SMTP id 98e67ed59e1d1-2e9b171f93amr20303584a91.16.1731358503151;
        Mon, 11 Nov 2024 12:55:03 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:55:02 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:54:10 -0800
Subject: [PATCH v8 25/29] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-25-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This commit adds a kernel command line option using which user cfi can be
disabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/usercfi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 04b0305943b1..223dfa482deb 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+bool disable_riscv_usercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -393,6 +395,9 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_shadow_stack())
 		return -EINVAL;
 
@@ -472,6 +477,9 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_indirect_br_lp_instr())
 		return -EINVAL;
 
@@ -504,3 +512,15 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "true") == 0)
+		disable_riscv_usercfi = true;
+
+	pr_info("Setting riscv usercfi to be %s\n", (disable_riscv_usercfi ? "disabled" : "enabled"));
+
+	return 1;
+}
+
+__setup("disable_riscv_usercfi=", setup_global_riscv_enable);

-- 
2.45.0



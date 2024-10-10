Return-Path: <linux-kernel+bounces-358903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A00998521
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCFB1F2197D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683F1CC890;
	Thu, 10 Oct 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMKJjPOq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118091CC888
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560069; cv=none; b=qzJWTrUqqTTx89NFR1AuR5IfN7DNSxFmFQzfkedsfZU9nXXQjrCmjy3CPGW50WwKexHwDCalquU1jr2wCz/409Cm6Ra77syFhbsqShZBLw/roIjnzI4HCZetUm1mtn0y5b0R25yFF7ZUDnwg5KOTpAb11D3XAH7d+nnoo1rRh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560069; c=relaxed/simple;
	bh=1+xGn+I5zGJWUmASKFRl6SMQB/wIv78GqsCAwMsFqAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSXeaC+8mJvLqVZa4z0P5hs3aEk34fKHT93OMoPqdb8ZUdJTHhtka39DvVqFjOBDLk8zZ1/b00ik9SENEzMnCo2A8EYDRNddsXPCouuDGHRXkrwuExcNbFwumNTPL/j41HDobtLZPYyxqaHrxU29Ig1tz1vhQYbwGUmMqwhxE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MMKJjPOq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99422c796eso133967866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560064; x=1729164864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/3IXPLtEzkdPxakYsKtSl6x7P98QonT1kDDJ6tUink=;
        b=MMKJjPOqhQ8V4bLtNtkBSCmOJ2MbWwbR29lC4DTx33+UqiFlHG56NhVyDuTrFf+9QF
         sC3LC59VhvR7/EcN3brdDjyGBCXZkCmmILFP6IsnbIDY8zEa7iE076lZOzKDect3SFvX
         L3pyGOViMHhibZfw1pBn4JS46Ww48pU4lz5PmFQ+56osMHDvtLMkmATyB7+aie0oMjQW
         2S7fNErwPOvWvbQfn8rLzZsW1HCSgVzOtFFotSGLz2uirLmdB5kvCOXZs4lYlhdIcU53
         Zx1JKdma/Ga539wEGdtVP+eVL92s4/eD1yeBvutL0mXC+zzTMKrBfTzdjbpJqg10OPpd
         YS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560064; x=1729164864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/3IXPLtEzkdPxakYsKtSl6x7P98QonT1kDDJ6tUink=;
        b=GZeiz2CvBt0RTGrXMbzEp9jC9zOI3fTrRljVeoeH2L8c2RuQ6gDznjMLJ6DJO1zM/3
         G8OEoFoS3Y8a6sM/RbA4F/WrSKQK7LYojM1iI6/3dUwDM2gyuaQsI31IWb5Z5DVJ2Uqv
         iFbfJwl+2GutJ7NfN1nFSFz8hd5lnH3AT+CXdfGqllkPVqXBlFXZE8YSKonXIo1KfHfV
         kxJsY/3NKeK/NMMhZE3A96c+VLzUAf72YelZZAOj8lUF+HwXWVtjAz8eGBKM4jWdSXL7
         4Ytkva6EunTykcSchrUxFLkza05YNFcva5RU8GF9Hht0/UYMeK5ZmWK0f2O5C1MkPSWE
         7ECw==
X-Forwarded-Encrypted: i=1; AJvYcCW+n0RHVJ5E2Zu06+kVl9vN/ulZ8VyccTNS4pkmKhjVuF7/uR7XoBOPPiZX5AfnCFaoNEZzVRbPfz3OkZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLLlOmmdKj4fZd8v9S082Xi4622fkxguVCjEkVS2+rACrIqmg
	Fyw0nv40ETLG6Jmcl8s/TnNAnVLygaDUmk4D23bf/xboFJJ4xZuXU0zz0zgQZPk=
X-Google-Smtp-Source: AGHT+IGSkGuyhdw8AmjZaYSG3AbwkYxBJPVivMy155PvJBG22/KVJmiGE/T4Z0mI0+yJzLqzOiUsfg==
X-Received: by 2002:a17:906:c109:b0:a99:403e:2578 with SMTP id a640c23a62f3a-a999e628eb0mr313283366b.5.1728560064365;
        Thu, 10 Oct 2024 04:34:24 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:34:03 +0200
Subject: [PATCH RFC 25/28] ARM: entry: Create irqentry calls from kernel
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-25-b94f451d087b@linaro.org>
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

This adds a few calls to C when exceptions enter/exit from
the kernel itself, so these can be used for generic entry.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   | 2 ++
 arch/arm/kernel/entry-armv.S   | 3 +++
 arch/arm/kernel/entry-header.S | 5 +++++
 arch/arm/kernel/entry.c        | 8 ++++++++
 4 files changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index 8b8cc9a1eefb..a78bc5054b09 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -12,5 +12,7 @@ long syscall_enter_from_user_mode(struct pt_regs *regs, long);
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
+void irqentry_enter_from_kernel_mode(struct pt_regs *regs);
+void irqentry_exit_to_kernel_mode(struct pt_regs *regs);
 
 #endif /* __ASM_ENTRY_H__ */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bd468d58dc02..21b11fe199cb 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -204,6 +204,9 @@ ENDPROC(__und_invalid)
 	get_thread_info tsk
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
+	mov	r0, sp				@ 'regs'
+	bl	irqentry_enter_from_kernel_mode
+
 	.if \trace
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 51c7f93c1ded..49a9c5cf6fd5 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -210,6 +210,7 @@
 	.else
 	@ IRQs off again before pulling preserved data off the stack
 	disable_irq_notrace
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	tst	\rpsr, #PSR_I_BIT
 	bleq	trace_hardirqs_on
@@ -217,6 +218,10 @@
 	blne	trace_hardirqs_off
 #endif
 	.endif
+
+	mov	r0, sp				@ 'regs'
+	bl	irqentry_exit_to_kernel_mode
+
 	uaccess_exit tsk, r0, r1
 
 #ifndef CONFIG_THUMB2_KERNEL
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index d7fdb9df3331..674b5adcec00 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -56,3 +56,11 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	/* This context tracking call has inverse naming */
 	user_enter_callable();
 }
+
+noinstr void irqentry_enter_from_kernel_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_exit_to_kernel_mode(struct pt_regs *regs)
+{
+}

-- 
2.46.2



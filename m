Return-Path: <linux-kernel+bounces-358886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90499850E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77012865B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B91C7B78;
	Thu, 10 Oct 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkTvQUFF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA21C6F6E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560043; cv=none; b=ickKB90Bewv9pIjPLxOCB29OBNL9KUmGQLlnNFv6x5+Po244qW5mVe3U5oP4lanU35HKzt/DsyTVT2b3K1FzZAaxQedEhZxoVQzgw+N3hdispml/4TnepRdpcbhgzwyD3Fy77Vm+IRaY5OhqkUvAt+WG/PBCFmXW8rcBBxjR4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560043; c=relaxed/simple;
	bh=TeWXUuVvYN/LOwsrfz7FuUVO8Dn9W3GDV6NRqA6SalU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AigVKcYnwtstGEuo02VzMoF8fPQa/b6j/4/vVHzg+d5KxLcqFNz18m9V/BO80/6RcIWysrpx75CNLZvXoq0yspRi+VDKTZoqF5N67OLcBEh5tGQu++oH6N+qdUo13oqV/TfhwqdkQXXxwqLDakD/MET2U/V/QPtfnv2TfhAfDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FkTvQUFF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9943897c07so114208866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560040; x=1729164840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP1nC9llP2df/xsfs1zPIJ3oMrkiGOdpltxFcj+OFqQ=;
        b=FkTvQUFFMIeVnKksJ3t8DK5Fz0suq9GdbFPDmSb4evR0Wt2U4LU+k6z24jWsZQIBq/
         2Sz/mCao0qGhLFf9OhawE+mRfx7X4sTtRjDL/PtvrCi7mFe0p0OtVTF0UKsNoSHttVrS
         1HxbH8KsXuqC7D5l0+tBVA6Uc4BlY5Z7DDJIH7PHbu7RUimQSu2mFboxB9Ff8ga68RYz
         jGXtFbgRIsS0NgnC/fcsPzi1CzCp0qY3i93dzlRcnTmks3HAyp81GHAOMk+2Lprlc+hq
         dGAcDwIpo03xGy29DWzaTFVXKLqw8W6/Ertx44GvAxktYQcQ4kTBktnI2DUxYE5GqIHP
         GJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560040; x=1729164840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wP1nC9llP2df/xsfs1zPIJ3oMrkiGOdpltxFcj+OFqQ=;
        b=vFnpC0X2YxyBL6sktE2B8IqUkbhlTCoO5w2cRYXwV04igvdEXW9EX9dZqiTzZCfo9s
         t3fIrvjzSVSQTaIs86sqTWa/tVmRwekS4rZODdY35Si5IVaBrE3861yRH4n1AGX6jzng
         S7bRFISV2KZdlKfX7Ijb0t3etZiXGJc2osGY10ObI7ULncAp132rrzA74hpA+q7A1jBa
         uDLABAazuNBi3KRMaknuaFW3P90K5s4J/i5+dWPJ7LuDTsYLXevDPa6fPRSWlbJzI6Zc
         CCs5/yC6Y+vjFw+39pMac/vzgYnc3pFuUr+37/Mk+v+6VtwUuq+symi21cSrD8lEljh2
         Ri8g==
X-Forwarded-Encrypted: i=1; AJvYcCVuZ+VbHuh0jUyT6qs9rmijJBNruTSDPnyAuB5XnfL9B7W+pYriMmeHOV8nh86yaLWWhwgkUm/KBnCcaUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhps6iQxxgjU7TG427rR35OcKLvzuLGkNx7tBWCSYkjwlp+G/
	zaYSDSM9oPASHvH+OW/Qf1FBo+gxCN/6OviDb1NvPz+mnIicqI2TjvT9Z+GKOsY=
X-Google-Smtp-Source: AGHT+IFueHlgiHQRsmvP//M3I79F0TgX4HWc1hPrICoYFkYMHOkR70UMR7ValzDrWStV4N5tCJsulQ==
X-Received: by 2002:a17:907:1c82:b0:a99:379b:6b2c with SMTP id a640c23a62f3a-a998d31be20mr575777066b.42.1728560039732;
        Thu, 10 Oct 2024 04:33:59 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:33:58 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:47 +0200
Subject: [PATCH RFC 09/28] ARM: entry: save the syscall sp in thread_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-9-b94f451d087b@linaro.org>
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

We are going to rewrite the syscall handling in C, which
means that the stack used by the call code is no longer
predicatably 8 bytes (for syscall arguments r4 and r5)
but a varying number of bytes depending on how nested the
C code is.

However the current code is just assuming it can rewind
the stack by adding 8 to sp if a syscall is interrupted by
a sigreturn call.

Solve this by storing the entry sp in the per-task
struct thread_info and use that in the sigreturn wrapper
instead. We already have the thread info available in
the SWI entry and sigreturn is probably not so common
that retrieveing a pointer to thread_info should affect
anything very much.

Storing this per-task in thread_info makes the solution
SMP robust.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/thread_info.h | 1 +
 arch/arm/kernel/asm-offsets.c      | 1 +
 arch/arm/kernel/entry-common.S     | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d2..d8a45c5a1049 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -67,6 +67,7 @@ struct thread_info {
 	__u32			cpu_domain;	/* cpu domain */
 	struct cpu_context_save	cpu_context;	/* cpu context */
 	__u32			abi_syscall;	/* ABI type and syscall nr */
+	__u32			sp_syscall;	/* SP when entering syscall */
 	unsigned long		tp_value[2];	/* TLS registers */
 	union fp_state		fpstate __attribute__((aligned(8)));
 	union vfp_state		vfpstate;
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 4853875740d0..c9525cbb26b7 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -49,6 +49,7 @@ int main(void)
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
   DEFINE(TI_ABI_SYSCALL,	offsetof(struct thread_info, abi_syscall));
+  DEFINE(TI_SP_SYSCALL,		offsetof(struct thread_info, sp_syscall));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
 #ifdef CONFIG_VFP
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3cfc6d952ff9..8baab7f97f59 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -232,6 +232,8 @@ ENTRY(vector_swi)
 
 	uaccess_disable tbl
 	get_thread_info tsk
+	/* Save a per-task copy of SP for sigreturn */
+	str	sp, [tsk, #TI_SP_SYSCALL]
 
 	adr	tbl, sys_call_table		@ load syscall table pointer
 
@@ -377,13 +379,15 @@ sys_syscall:
 ENDPROC(sys_syscall)
 
 sys_sigreturn_wrapper:
-		add	r0, sp, #S_OFF
+		get_thread_info tsk
+		ldr	r0, [tsk, #TI_SP_SYSCALL]	@ read back SP
 		mov	why, #0		@ prevent syscall restart handling
 		b	sys_sigreturn
 ENDPROC(sys_sigreturn_wrapper)
 
 sys_rt_sigreturn_wrapper:
-		add	r0, sp, #S_OFF
+		get_thread_info tsk
+		ldr	r0, [tsk, #TI_SP_SYSCALL]	@ read back SP
 		mov	why, #0		@ prevent syscall restart handling
 		b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)

-- 
2.46.2



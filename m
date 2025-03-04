Return-Path: <linux-kernel+bounces-542934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B03A4CF92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A1D3A2DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B511CAF;
	Tue,  4 Mar 2025 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nd6yLpHJ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2E2111
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046487; cv=none; b=gbj6GVPipt1+VG9qgNdDUuza+RowbZfK4HYiXhpeE7ZeWxBUFS9/JwTAEbclnU2LysMNxu0vyGYGD/iyucFeE740xpSf0o0ymrjvbAJMeBOigIuO1RBpyu2jilE5hINuthYaCviwuocYO9N5JGYWIUcsx0/ZnNrwueW17XkEG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046487; c=relaxed/simple;
	bh=P5R/RgIqeP/KfKRnjVtKEA58e26ppdUp1KhNDaJxaDY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dKrLDL/DUsC9au2klDAdgTawUcb53ltgjxJk85c8BTsFbY9RHGLVRIiA0TJl2n02Cnqz3N2ZmaGtezyjCulkMCBGgwU4+TnaPdHQ/ZmR6tV02xp8cprIp7UkHA5Kya1vwcWqqu2O82HPtyVCUUxx+J62SgLmp5tNvnG13HRVUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nd6yLpHJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 524010NI1811612
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 16:01:01 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 524010NI1811612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741046461;
	bh=lJdD/YUi/+OsqJgKys0xBxpQPcp02FkByxHMRB72V3o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nd6yLpHJJET+Oqz+KefAH9K7U314x9HVXuylxERZw7z62DOEyfsk1kt+0AzFis0V5
	 5uf0QMn0kW27Oul/qCpzVJtnGkBnBfB5fqt0NTM057FyjJVjNJks3qu3F48vNcdgpj
	 tLxqbVN8Vh/3Qgg/K1Ur25gPCWPSUw369X0Bb+iU9HudQuVm4x35yiSC3Fcmqm3PBG
	 1jnsoKFrZz8DRUS3E0n8FtJSRUVFnhsUkHadfomZ1oiHBgaRw40CtFXX1YeGRboLaC
	 Ay43DiWkksXFJY3oB5f/3fYIj3EIctWBofacmmpstIhHSiK/2xine5CjPYvLDujlVn
	 qJ6ATe+lA7xuQ==
Date: Mon, 03 Mar 2025 16:01:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/asm: Merge KSTK_ESP() implementations
User-Agent: K-9 Mail for Android
In-Reply-To: <20250303183111.2245129-1-brgerst@gmail.com>
References: <20250303183111.2245129-1-brgerst@gmail.com>
Message-ID: <9FC474C9-284D-4EB5-BF8A-7B938247E577@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 10:31:11 AM PST, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>Commit 263042e4630a ("Save user RSP in pt_regs->sp on SYSCALL64
>fastpath") simplified the 64-bit implementation of KSTK_ESP() which is
>now identical to 32-bit=2E  Merge them into a common definition=2E
>
>No functional change=2E
>
>Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>---
> arch/x86/include/asm/processor=2Eh | 5 +----
> arch/x86/kernel/process_64=2Ec     | 5 -----
> 2 files changed, 1 insertion(+), 9 deletions(-)
>
>diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm/pr=
ocessor=2Eh
>index a969bea1ed07=2E=2E55f0e48413b0 100644
>--- a/arch/x86/include/asm/processor=2Eh
>+++ b/arch/x86/include/asm/processor=2Eh
>@@ -652,8 +652,6 @@ static __always_inline void prefetchw(const void *x)
> 	=2Esysenter_cs		=3D __KERNEL_CS,				  \
> }
>=20
>-#define KSTK_ESP(task)		(task_pt_regs(task)->sp)
>-
> #else
> extern unsigned long __top_init_kernel_stack[];
>=20
>@@ -661,8 +659,6 @@ extern unsigned long __top_init_kernel_stack[];
> 	=2Esp	=3D (unsigned long)&__top_init_kernel_stack,		\
> }
>=20
>-extern unsigned long KSTK_ESP(struct task_struct *task);
>-
> #endif /* CONFIG_X86_64 */
>=20
> extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
>@@ -676,6 +672,7 @@ extern void start_thread(struct pt_regs *regs, unsign=
ed long new_ip,
> #define TASK_UNMAPPED_BASE		__TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
>=20
> #define KSTK_EIP(task)		(task_pt_regs(task)->ip)
>+#define KSTK_ESP(task)		(task_pt_regs(task)->sp)
>=20
> /* Get/set a process' ability to use the timestamp counter instruction *=
/
> #define GET_TSC_CTL(adr)	get_tsc_mode((adr))
>diff --git a/arch/x86/kernel/process_64=2Ec b/arch/x86/kernel/process_64=
=2Ec
>index 4ca73ddfb30b=2E=2Ef983d2a57ac3 100644
>--- a/arch/x86/kernel/process_64=2Ec
>+++ b/arch/x86/kernel/process_64=2Ec
>@@ -979,8 +979,3 @@ long do_arch_prctl_64(struct task_struct *task, int o=
ption, unsigned long arg2)
>=20
> 	return ret;
> }
>-
>-unsigned long KSTK_ESP(struct task_struct *task)
>-{
>-	return task_pt_regs(task)->sp;
>-}
>
>base-commit: 693c8502970a533363e9ece482c80bb6db0c12a5

Why using the macro version?


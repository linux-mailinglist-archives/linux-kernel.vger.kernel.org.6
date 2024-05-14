Return-Path: <linux-kernel+bounces-178499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2898C4E94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91B41F2299E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656123763;
	Tue, 14 May 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SpIiA8mM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7oDLRceR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04A2F874
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678246; cv=none; b=AcgkdDzBg0bfvYBfkIFRyAKY1XsbhQQHjRXUgaKwLHug3sZHxPYLT7nDqD5VSAzCyRK9rx/eXNsXFo09mLi1V9C8fzak1e9+orb4hewaR/RKoQfJDeu9LCVD0o/qW2mgPwv1gpAVuYGCMlFJknB+ldEYI0la9vYq8sdo+4rGw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678246; c=relaxed/simple;
	bh=UWQzSiSNX3y764hb9eyjlKetHfQD4w8G//zFNzrnft0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eLLLeQ8x8IYSKd0kxJIh5gUg05FBHIDXsb9fD5y+bssqtTci6LdqpuI+iu3yO3pRJ3i0RQeBgjvCQrm64Ib8LJ38hshGqs/eaTRHyzUcRZppPs6n/cBS9jEgfYy3JQ27u6OdaBEGSZnZe4f9Z4zvcKPi02aGBv4jr5uR4oWbsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SpIiA8mM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7oDLRceR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715678244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kA5X0iCNf5JNDOSYIdoDW8OtH47IaeM4S6bNIFPr8zY=;
	b=SpIiA8mMqoHOvI/05Idu3McxJa4YW52QWSoF7UOb2DU833wDb8dJLnJl5+lWrMrEfr1mw/
	V1Ne4Bc4YrpxcN4zP6IOBE3MlVR8+MMzpPVmxFqJtbnoj5C52FEhG0asP1N8JLmQJyyzZP
	cndHyfJ0wYEla1y91d8YOoEYBqMfARPHw9eFBGmw/pwGqlmvNJNPRhnVQjWTjN0+HR0Z3E
	DTmTSEBPdH0nmdr45VRt0W55q30wnB/C8Kz32MWyw3rbtgxngQ7Wqzza5TmoH5WeWOGHLz
	pUmCCdMm1Ui1TtAbykBsVBVfDAjRnzh/WoYL+gVsftW02A1K+vWAr4f2SH8qiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715678244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kA5X0iCNf5JNDOSYIdoDW8OtH47IaeM4S6bNIFPr8zY=;
	b=7oDLRceREQzqN72Z2EteITBkj4PjqqTzKvb22n125Ytm/Cu8tYQPuf7yRaBASMGqJmXNc8
	LTKklI5VIbTTVbAg==
To: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Justin Stitt
 <justinstitt@google.com>
Subject: Re: [PATCH] ntp: safeguard against time_constant overflow case
In-Reply-To: <20240506-b4-sio-ntp-c-v1-1-a01281aa01ba@google.com>
References: <20240506-b4-sio-ntp-c-v1-1-a01281aa01ba@google.com>
Date: Tue, 14 May 2024 11:17:23 +0200
Message-ID: <87y18clplo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 06 2024 at 22:01, Justin Stitt wrote:

> Using syzkaller with the recently reintroduced signed integer overflow
> sanitizer produces this UBSAN report:
>
> [   46.809326] ------------[ cut here ]------------
> [   46.812882] UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:738:18
> [   46.817676] 9223372036854775806 + 4 cannot be represented in type 'long'
> [   46.822346] CPU: 1 PID: 685 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00036-g679ee73ec453 #2
> [   46.828270] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   46.834836] Call Trace:
> [   46.836625]  <TASK>
> [   46.838147]  dump_stack_lvl+0x93/0xd0
> [   46.840771]  handle_overflow+0x171/0x1b0
> [   46.843516]  __do_adjtimex+0x1236/0x1440
> [   46.846275]  do_adjtimex+0x2be/0x740
> [   46.848864]  __x64_sys_clock_adjtime+0x154/0x1d0
> [   46.852164]  do_syscall_64+0xd7/0x1b0
> [   46.854783]  ? arch_exit_to_user_mode_prepare+0x11/0x60
> [   46.858426]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> [   46.861914] RIP: 0033:0x7fde90aaf539
> [   46.864500] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 8
> [   46.877151] RSP: 002b:00007ffebfe63358 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
> [   46.882279] RAX: ffffffffffffffda RBX: 00007fde90be3f80 RCX: 00007fde90aaf539
> [   46.887270] RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000000
> [   46.892174] RBP: 00007fde90b0e496 R08: 0000000000000000 R09: 0000000000000000
> [   46.897061] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [   46.902020] R13: 0000000000000095 R14: 00007fde90be3f80 R15: 00007fde90be3f80
> [   46.906946]  </TASK>
> [   46.908537] ---[ end trace ]---

Please trim stack traces so they contain only useful information.

 UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:738:18
 9223372036854775806 + 4 cannot be represented in type 'long'
 Call Trace:
  <TASK>
  handle_overflow+0x171/0x1b0
  __do_adjtimex+0x1236/0x1440
  do_adjtimex+0x2be/0x740
  __x64_sys_clock_adjtime+0x154/0x1d0
  do_syscall_64+0xd7/0x1b0

Is completely sufficient, no?

> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang; It being re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").

How is that relevant to the problem?

> Nonetheless, let's slightly rework the logic surrounding time_constant

s/Nonetheless, let's slightly /Rework/

> and how it is incremented such that we avoid unintentional wrap-around
> (even though it is extremely unlikely to be hit in non-fuzzing
> scenarios).

We don't avoid anything. Please write change logs in imperative mood.

>  	if (txc->modes & ADJ_TIMECONST) {
>  		time_constant = txc->constant;
> -		if (!(time_status & STA_NANO))
> -			time_constant += 4;
> -		time_constant = min(time_constant, (long)MAXTC);
> -		time_constant = max(time_constant, 0l);
> +		if (!(time_status & STA_NANO) &&
> +		    unlikely(LONG_MAX - time_constant_inc >= time_constant))

What's unlikely about this? Correct operation of adjtimex() will
increment, no?

As this obviously will be clamped to MAXTC anyway, you can spare that whole
LONG_MAX - time_constant_inc dance and simply do:

		if (!(time_status & STA_NANO) && time_constant < MAXTC)
                	time_constant += 4;

No?

> +			time_constant += time_constant_inc;
> +		time_constant = clamp_t(long, time_constant, 0, MAXTC);

Thanks,

        tglx


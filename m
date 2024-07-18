Return-Path: <linux-kernel+bounces-256426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A76934E66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C031C22BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C2B13DDAB;
	Thu, 18 Jul 2024 13:38:42 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364413D89D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309922; cv=none; b=HW21xYT0ySE1bZGCM/V09V3QNxtWIhyjhq0PZCxo0opW/89NBoDHKbkKXftcXWovtBiyqIBQK3wg/AYb0NkfOTrmhpZcbqDz4ihyFHVq+cxWYNa6Ej3oUeKW0VQ+LI/tJLnceP4f6iDL0/Hvc/hCRE9Z1u2FHi+TkOrme1VBj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309922; c=relaxed/simple;
	bh=+MOBinJhyFH9jlNjpQWWV3Sh3JRD66MJunjrU//bXk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gShFhBhkpBH4sCY32cYSdaVCKM4i3+sVO3kTvL+GfFKuVkCra6wqMgqlP8TcUN8n0wjxxcCH8xTRobVSsjIo+qZTYSECUJBqD/b79S/ZDuLYwoq2NrFdnBZDV5qr0mkrZpUM0bWNhBniQIsPv7ZfJZ7hGIuohkdO6g1U+pCQinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sURKs-000000000Jg-3Siz;
	Thu, 18 Jul 2024 09:38:18 -0400
Message-ID: <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
From: Rik van Riel <riel@surriel.com>
To: John Ogness <john.ogness@linutronix.de>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, kernel-team <kernel-team@meta.com>
Date: Thu, 18 Jul 2024 09:38:18 -0400
In-Reply-To: <87r0brkvqd.fsf@jogness.linutronix.de>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
	 <87plrcqyii.fsf@jogness.linutronix.de>
	 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
	 <87r0brkvqd.fsf@jogness.linutronix.de>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-07-18 at 09:31 +0206, John Ogness wrote:
> On 2024-07-17, Rik van Riel <riel@surriel.com> wrote:
> > I think that would do the trick. The nmi_backtrace() printk is
> > already
> > deferred, because of the check for in_nmi() in vprintk(), and this
> > change would put all the other users of
> > printk_cpu_sync_get_irqsave()
> > on the exact same footing as nmi_backtrace().
> >=20
> > Combing through the code a little, it looks like that would remove
> > the potential for this deadlock to happen again.
>=20
> Let's see what Petr has to say. (He'll be back on Monday.) He might
> prefer a solution that does not result in deferring printing for all
> cases. i.e. allow the console_lock if it is available, but avoid the
> spinning if it is not. Below is a patch that would achieve this.
>=20
> John
>=20
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dddb15f48d59..36f40db0bf93 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1060,6 +1060,8 @@ static int __init log_buf_len_setup(char *str)
> =C2=A0early_param("log_buf_len", log_buf_len_setup);
> =C2=A0
> =C2=A0#ifdef CONFIG_SMP
> +static bool vprintk_emit_may_spin(void);
> +
> =C2=A0#define __LOG_CPU_MAX_BUF_LEN (1 << CONFIG_LOG_CPU_MAX_BUF_SHIFT)
> =C2=A0
> =C2=A0static void __init log_buf_add_cpu(void)
> @@ -1090,6 +1092,7 @@ static void __init log_buf_add_cpu(void)
> =C2=A0}
> =C2=A0#else /* !CONFIG_SMP */
> =C2=A0static inline void log_buf_add_cpu(void) {}
> +static inline bool vprintk_emit_may_spin(void) { return true };
> =C2=A0#endif /* CONFIG_SMP */
> =C2=A0
> =C2=A0static void __init set_percpu_data_ready(void)
> @@ -2330,6 +2333,8 @@ asmlinkage int vprintk_emit(int facility, int
> level,
> =C2=A0
> =C2=A0	/* If called from the scheduler, we can not call up(). */
> =C2=A0	if (!in_sched) {
> +		int ret;
> +
> =C2=A0		/*
> =C2=A0		 * The caller may be holding system-critical or
> =C2=A0		 * timing-sensitive locks. Disable preemption during
> @@ -2344,7 +2349,11 @@ asmlinkage int vprintk_emit(int facility, int
> level,
> =C2=A0		 * spinning variant, this context tries to take over
> the
> =C2=A0		 * printing from another printing context.
> =C2=A0		 */
> -		if (console_trylock_spinning())
> +		if (vprintk_emit_may_spin())
> +			ret =3D console_trylock_spinning();
> +		else
> +			ret =3D console_trylock();
> +		if (ret)
> =C2=A0			console_unlock();
> =C2=A0		preempt_enable();
> =C2=A0	}
> @@ -4321,6 +4330,15 @@ void console_replay_all(void)
> =C2=A0static atomic_t printk_cpu_sync_owner =3D ATOMIC_INIT(-1);
> =C2=A0static atomic_t printk_cpu_sync_nested =3D ATOMIC_INIT(0);
> =C2=A0
> +/*
> + * As documented in printk_cpu_sync_get_irqsave(), a context holding
> the
> + * printk_cpu_sync must not spin waiting for another CPU.
> + */
> +static bool vprintk_emit_may_spin(void)
> +{
> +	return (atomic_read(&printk_cpu_sync_owner) !=3D
> smp_processor_id());
> +}

I think the above would still deadlock, because the reported
deadlock is an ABBA deadlock between two different CPUs.

I think what the code would have to do is only trylock, and never
spin after taking the printk_cpu_sync_get_irqsave lock.

Were you thinking of moving the=C2=A0 this_cpu_read(printk_context)
check from vprintk() into  vprintk_emit() and use that to decide
whether to spin for the lock, or to give up if the trylock fails?

--=20
All Rights Reversed.


Return-Path: <linux-kernel+bounces-255246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E8F933DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB8A285227
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05072180A6A;
	Wed, 17 Jul 2024 13:48:27 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0341802A5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224106; cv=none; b=NWEQtgdTSfc29KFgsiUsCMXQjz54eU2z18HTYkrRDtDStyBYFBnf+pxtnGcSgnNPsxw/LVqF75fFvxC3XMtc42jmLQFbjwdoJIjHh1czVTaSb6IZ0TpJCr+CcTA+98hqqsd7nBQ1NgUWeDVLj2csYKAZqYCIs+ymd7XU0/Ya0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224106; c=relaxed/simple;
	bh=WNXsZ/OA49D2wMn7rHbOLQ0vu8l6tOxdGmDc0yYy8RM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gROtuJ1A/iseH4R/Z4wZKsLV/kSaP9cZ09ZX1owviBs2Gqfvoh+IXzjbZjhPOjAB32E79M47atplZkUd7b1fDhFzKMoR383QjuimamnK9NxvUWE7FYuf/1/AkJvuc7gdhv9cq8WYBpKQz4zMzGcdDneZ8XSBh3YLCQdWwPPaeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sU50W-000000008VQ-1VFX;
	Wed, 17 Jul 2024 09:47:48 -0400
Message-ID: <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
From: Rik van Riel <riel@surriel.com>
To: John Ogness <john.ogness@linutronix.de>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, kernel-team <kernel-team@meta.com>
Date: Wed, 17 Jul 2024 09:47:48 -0400
In-Reply-To: <87plrcqyii.fsf@jogness.linutronix.de>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
	 <87plrcqyii.fsf@jogness.linutronix.de>
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

On Wed, 2024-07-17 at 09:22 +0206, John Ogness wrote:
>=20
> The purpose of printk_cpu_sync_get_irqsave() is to avoid having the
> different backtraces being interleaved in the _ringbuffer_. It really
> isn't necessary that they are printed in that context. And indeed,
> there
> is no guarantee that they will be printed in that context anyway.
>=20
> Perhaps a simple solution would be for printk_cpu_sync_get_irqsave()
> to
> call printk_deferred_enter/_exit. Something like the below patch.
>=20

I think that would do the trick. The nmi_backtrace() printk is already
deferred, because of the check for in_nmi() in vprintk(), and this
change would put all the other users of printk_cpu_sync_get_irqsave()
on the exact same footing as nmi_backtrace().

Combing through the code a little, it looks like that would remove
the potential for this deadlock to happen again.
>=20
>=20
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 65c5184470f1..1a6f5aac28bf 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -315,8 +315,10 @@ extern void __printk_cpu_sync_put(void);
> =C2=A0#define printk_cpu_sync_get_irqsave(flags)		\
> =C2=A0	for (;;) {					\
> =C2=A0		local_irq_save(flags);			\
> +		printk_deferred_enter();		\
> =C2=A0		if (__printk_cpu_sync_try_get())	\
> =C2=A0			break;				\
> +		printk_deferred_exit();			\
> =C2=A0		local_irq_restore(flags);		\
> =C2=A0		__printk_cpu_sync_wait();		\
> =C2=A0	}
> @@ -329,6 +331,7 @@ extern void __printk_cpu_sync_put(void);
> =C2=A0#define printk_cpu_sync_put_irqrestore(flags)	\
> =C2=A0	do {					\
> =C2=A0		__printk_cpu_sync_put();	\
> +		printk_deferred_exit();		\
> =C2=A0		local_irq_restore(flags);	\
> =C2=A0	} while (0)
> =C2=A0
>=20

--=20
All Rights Reversed.


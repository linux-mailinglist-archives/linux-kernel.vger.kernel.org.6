Return-Path: <linux-kernel+bounces-532988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97386A4548C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30ABB189C254
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2582825B675;
	Wed, 26 Feb 2025 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBjxv5M2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQXnRaS8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADF15098A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740543958; cv=none; b=XaJvlshOqUWd7RfPIsAM8dqKf0Bfx+zYHLKp/vlwy/mfryhRcynaKMivWDqBzvtZSLPLt47KZpLZVdgmX+H0nFl6VdP0JGb5GGQCqNiHzBbt6hVUWl4Kwb+BbCgo7peT3hAVtBi1d2JQmyijO2CIq4emPAI1vghTXC1AARNcZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740543958; c=relaxed/simple;
	bh=zZP5+1eZJWuflqb2MTMj+/qM9inemghd3GToni9vRCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RI2PXJFiIAsMcqKi3NDiJJHYLeM3l5pmonRjADiD+PvmMZoIt5DuChwtOsBeMjdKr9IYrSI4U6uMQA0j32v8DYibJSUF389Qcpb9Jr7192C+VTnwQumAOssStS4MNETp0GTWQe4iIl2MRzY7RMqRKet++sfWS0HI4TsNuqjuugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IBjxv5M2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQXnRaS8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740543954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eStMvHC894Q2g/dFThMFyClASVgx74TaSqqWiNEOKMw=;
	b=IBjxv5M2aTYeEDnASxf/wd/jz8Yd2PYUSm2DHkFKVbsPmADa1CK3cT1f29Onp1CqoI/dXt
	PZtra+hsZpGy+ibRHKbcZShc8w9VyoxZFLUDRtlay1nv+CBUOcqUs9OXnqt2rXi0BPKd6g
	/ithagtTc92VRfXRwZCNjvp/pFzsjEF9cHri8i4TpoW83P+WsDzYhSqLUGRT/+ja6kcGsA
	/qB8q0mSKdDLLZr4Jx7+EmXimpOjixdYP2mTA98sWiA/xgrdXMXp6ffKJCi/YImbMzzXkM
	I/QgLSXl7iR7S6zJNKMJDIm6abW6XDv/N97iJvRD2OZr9OVV51ma3qyk03CDvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740543954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eStMvHC894Q2g/dFThMFyClASVgx74TaSqqWiNEOKMw=;
	b=iQXnRaS8/e9MpSwhUyGHURH7MtnSWRKvO+O4dsV9ev0/9uWpPsu+XPS0XnEz4oqeL4lODg
	JZxib8k8AwtJ/7DQ==
To: Donghyeok Choe <d7271.choe@samsung.com>, pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, takakura@valinux.co.jp,
 youngmin.nam@samsung.com, hajun.sung@samsung.com, seungh.jung@samsung.com,
 jh1012.choi@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
In-Reply-To: <20250226031628.GB592457@tiffany>
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
 <20250226031628.GB592457@tiffany>
Date: Wed, 26 Feb 2025 05:31:53 +0106
Message-ID: <84ikoxxrfy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Donghyeok,

On 2025-02-26, Donghyeok Choe <d7271.choe@samsung.com> wrote:
> I would like to print out the message of non panic cpu as it is.
> Can I use early_param to selectively disable that feature?

I have no issues about allowing this type of feature for debugging
purposes. I do not know if early_param is the best approach. I expect
Petr will offer good insight here.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fb242739aec8..3f420e8bdb2c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2368,6 +2368,17 @@ void printk_legacy_allow_panic_sync(void)
>         }
>  }
>
> +static bool __read_mostly keep_printk_all_cpu_in_panic;
> +
> +static int __init keep_printk_all_cpu_in_panic_setup(char *str)
> +{
> +       keep_printk_all_cpu_in_panic = true;
> +       pr_info("printk: keep printk all cpu in panic.\n");
> +
> +       return 0;
> +}
> +early_param("keep_printk_all_cpu_in_panic", keep_printk_all_cpu_in_panic_setup);

Quite a long argument. I am horrible at naming. I expect Petr would have
a good suggestion (if early_param is the way to go).

> +
>  asmlinkage int vprintk_emit(int facility, int level,
>                             const struct dev_printk_info *dev_info,
>                             const char *fmt, va_list args)
> @@ -2379,13 +2390,15 @@ asmlinkage int vprintk_emit(int facility, int level,
>         if (unlikely(suppress_printk))
>                 return 0;
>
> -       /*
> -        * The messages on the panic CPU are the most important. If
> -        * non-panic CPUs are generating any messages, they will be
> -        * silently dropped.
> -        */
> -       if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
> -               return 0;
> +       if (!keep_printk_all_cpu_in_panic) {
> +               /*
> +                * The messages on the panic CPU are the most important. If
> +                * non-panic CPUs are generating any messages, they will be
> +                * silently dropped.
> +                */
> +               if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
> +                       return 0;
> +       }

I would not nest it. Just something like:

	/*
	 * The messages on the panic CPU are the most important. If
	 * non-panic CPUs are generating any messages, they may be
	 * silently dropped.
	 */
	if (!keep_printk_all_cpu_in_panic &&
	    !panic_triggering_all_cpu_backtrace &&
	    other_cpu_in_panic()) {
		return 0;
	}

John


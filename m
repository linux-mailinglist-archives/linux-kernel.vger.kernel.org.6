Return-Path: <linux-kernel+bounces-290900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F8E955AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622CB1F216C8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C0B66E;
	Sun, 18 Aug 2024 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I7vpTf1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A2944F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723957938; cv=none; b=ODcjxIwjsa27bHCuMCxBX7K4koAYL0hLiKP4MlTXneNjkZhJxJE7mKskJJ3zvOL5Rj0HfAg7sJVX1iaUaY23zJ/OlUCZYCpXzeyFmYJPsDWlGx0QuQgvKJKIVwgfjed7mWcQQHzAiBFkyTu6w+Jr2/8cfCaW1l6ZfhX+FgL2vz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723957938; c=relaxed/simple;
	bh=5NsqGhMym8MZCzt7IdXN1LK/T8cJ9rfKvQRSDyqEEcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwJcH7UtmGRVzVZqHDJexp87pnFW78D3UQi0Xt9d0X2h6Eg39wH4DDffKNCUyfgsxczUE2KoeQLZGKKPUCkZYiEphAJgY8FnitXrl9kbZrKKDtkyZNQOEhTLFEmfNZGHerTz5aZSak+Du0KZFLF9qu+Cqc9EnTaWMFEQtlOPxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I7vpTf1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97939C32786;
	Sun, 18 Aug 2024 05:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723957938;
	bh=5NsqGhMym8MZCzt7IdXN1LK/T8cJ9rfKvQRSDyqEEcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7vpTf1DA039rlnpbtw3wV73wu8m5lPOMCxu55E/v+SWWyJo53IRD/jKgsLMbUWfy
	 e8b5X3RuaDE58qF2/Rajl1H3jKALlDuVkZF9FR5jQ9Ssr75w3LHs1jdic/TwwwxJR6
	 wYVd3QNPsBE5/fjUAwelwDLv33M3aDbQLJl+kAJQ=
Date: Sun, 18 Aug 2024 07:12:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
	linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <2024081824-leggings-omission-562a@gregkh>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <2669238.7s5MMGUR32@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2669238.7s5MMGUR32@nerdopolis2>

On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:
> Hi
> 
> I originally brought this up on linux-serial, but I think it makes more sense
> that it's part of how printk console device selection works. Without VTs, while
> most software is able to handle the situation, some userspace programs expect
> /dev/console to still be responsive. Namely systemd. It calls isatty() against
> /dev/console, and since /dev/console on VT-less systems currently defaults to
> /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> refuses to write log messages to it.
> 
> There doesn't seem to be a mailing list for printk, so I had to use
> get_maintainer.pl. Hopefully this is correct
> 
> 
> After some grepping and guessing and testing, and playing around Something like
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index a45d423ad10f..f94a4632aab0 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -384,9 +384,12 @@ config NULL_TTY
>  
>           In order to use this driver, you should redirect the console to this
>           TTY, or boot the kernel with console=ttynull.
> -
>           If unsure, say N.
>  
> +config NULL_TTY_CONSOLE
> +        bool "Supports /dev/ttynull as a console automatically"
> +        depends on NULL_TTY && !VT_CONSOLE
> +
>  config VCC
>         tristate "Sun Virtual Console Concentrator"
>         depends on SUN_LDOMS
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dddb15f48d59..c1554a789de8 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3712,6 +3712,11 @@ void __init console_init(void)
>         initcall_t call;
>         initcall_entry_t *ce;
>  
> +#ifdef CONFIG_NULL_TTY_CONSOLE
> +       if (!strstr(boot_command_line, "console="))
> +               add_preferred_console("ttynull", 0, NULL);
> +#endif
> +
>         /* Setup the default TTY line discipline. */
>         n_tty_init();
>  
> 
> 
> 
> seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> redundant, it is optional, so that it doesn't cause any changes to
> configurations, that historically had CONFIG_VT_CONSOLE turned off in the past,
> and for bootloader configs, it won't change any behavior if the kernel command
> line has a console device specified

What is wrong with just setting the kernel command line for this
instead?

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-215333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4942990913F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB23B1F23591
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036C19FA9A;
	Fri, 14 Jun 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Af/p5VQ4"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DF1A0AE5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385446; cv=none; b=s8IeYy2X140jFJoAEMl+hEaYjl8vYFN7P0cKKKEcQoDHd0cidNF4+mKPExuku98y5v1qVcGmM5E/vX8RQrHzIlGJ7P5U0pPUaFK/wsbB3iUHdPp9MMj3HF+6hQ4Xgxkbn6R9BR5QwH4tGs3tSXKQFMMnOYkbjUA4dOdER3jHhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385446; c=relaxed/simple;
	bh=HCYPoefMJuvnLICEcsjkvKE9RgjD/qUfnxq3sUrdD4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWswhZmSyu/hompzz1OY11Ig64XHwekrSob4+5u0NHTlUSkw5B5AoEPHl0vuip1Q/RQwU1pdS7NPQrEr6UkU40MlPMfl/0b26gSU60v4xJjmFV+eBidFwW9qopzalPxfCfSW65MZ1bmFRQaZB75WehcvA9DFEGebKxClDdyJ59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Af/p5VQ4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso317763966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718385442; x=1718990242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Redv4EIrxDLFGUnzlh3BgiGC6w3p9xU8N5sr8hyRmTw=;
        b=Af/p5VQ4HZNM6QUkbf4kl/Fg/qgCa1wXKX8L6FCL2G2WIP046T8hasDFfT2C8yLCr+
         dvhbez6G7NvARreziRWBfgCTl7fM3h+/PHkm93ec13sMUQj0gVno8mVaFX7xcopFFOJk
         NAOjGl4/yWsHInbNWEAOzPZq4R4m1I4Kw5HHsREGVq/HvkTlN2i9HbPY7w/8wlnOEq0A
         3ULUANLhyaWjrEdv9UGnUhbwwsJpX4Y94Ok4v/Njv1k8+5WK8AJ4bGOh+tst4vixmg5g
         IORewSB7Hcv0gaO+RyPnpJEhLVpGmqQoHYhXqzydqWvgdXSGYx3iIDHZrZFM3WMvOTEa
         GdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718385442; x=1718990242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Redv4EIrxDLFGUnzlh3BgiGC6w3p9xU8N5sr8hyRmTw=;
        b=EsrE4Hd2bgoR+6Mwh+esCmIyDHAp0M+4g2iM4z09z8SX2FlUHCLS+31FN+Sd+swlFi
         VDFVs7sZU7tM5G9ZkkmOcJo7agtx9UY9i3bA87gEwlkZcDkZ1N+r4Smqt4gi96Qd13CK
         pSworI5QYHSrfdMLnG5Jh71Ey/FiOa9rpCio180PGXEakZ/k+uxsVFrkP5nPUZaR5iCg
         6r8A7/eT8i1EzFEHAkoxGpX3WYjXso1VAKZLJyOH8+98UXqzxv6wzTM/t6po2S1ewSSC
         +mfGGZLgcSoNnFdwWmi6GmH/k35AzhdMtyR5jn4R4aP+cKgyPgtlNtkDHA1j9DxLuzgZ
         fUtA==
X-Forwarded-Encrypted: i=1; AJvYcCUtduJIlPdbfZMOYBKysK9DAo1ONAv98AYmyjoO4lY3Q1Wuxwz8DT/WRKQtXLNcgNO9MSzEgFEgbYn9XU6BsdlM5GxSNQPyBFyKAn5L
X-Gm-Message-State: AOJu0Ywm/f9FZy3VH6PdKUzyZuLndnhGnpN2IucPUVrEfvxdHXfY8DYT
	qQCQ4mQFXtlhB0Ra7XFGNX3Ps1DbXXwHBa5oarIGoxGqevfV/mg7vpbSONZkmPM=
X-Google-Smtp-Source: AGHT+IGbKvAzNhBrqGh9T8tnWby88aNyE8nSpywOnAj2Knqo/DlxbowgUdtx0FAOQoO9jPadTiyEuQ==
X-Received: by 2002:a17:906:c194:b0:a6f:1e97:b177 with SMTP id a640c23a62f3a-a6f60de1094mr241550266b.64.1718385442488;
        Fri, 14 Jun 2024 10:17:22 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3f41sm204791566b.33.2024.06.14.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:17:22 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:17:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] printk: Add update_preferred_console()
Message-ID: <Zmx7IPQX4FVdSe1J@pathway.suse.cz>
References: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
 <20240613125113.219700-3-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613125113.219700-3-tony.lindgren@linux.intel.com>

On Thu 2024-06-13 15:51:08, Tony Lindgren wrote:
> Let's add update_preferred_console() for driver subsystems to call during
> init when the console is ready, and it's character device name is known.
> For now, we use it only for the serial layer to allow console=DEVNAME:0.0
> style hardware based addressing for consoles.
> 
> The earlier attempt on doing this caused a regression with the kernel
> command line console order as it added calling __add_preferred_console()
> again later on during init. A better approach was suggested by Petr where
> we add the deferred console to the console_cmdline[] and update it later
> on when the console is ready.

The patch seems to work well. And I am surprised that it is so small ;-)
I have some rather cosmetic comments.

> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 5ebacb982f9e..a34f55ef6f37 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -210,7 +210,13 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
>  static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
>  				       int port_id)

I would suggest to rename also functions on the serial_base side.
The function is not adding prefcon. It is doing some match_and_update
job.

>  {
> -	return 0;
> +	int ret;
> +
> +	ret = update_preferred_console(match, dev_name, port_id);
> +	if (ret == -ENOENT)
> +		return 0;
> +
> +	return ret;
>  }
>  
>  #ifdef __sparc__
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2486,8 +2495,8 @@ __setup("console_msg_format=", console_msg_format_setup);
>   */
>  static int __init console_setup(char *str)
>  {
> -	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> -	char *s, *options, *brl_options = NULL;

I would add

	static_assert(sizeof(console_cmdline[0].devname) >= sizeof(console_cmdline[0].name));

> +	char buf[sizeof(console_cmdline[0].devname)]; /* name with "ttyS" prefix or devname */
> +	char *s, *options, *brl_options = NULL, *chardev = NULL, *devname = NULL;

The name "chardev" sounds as generic as "devname". I would use one of

   + "name" like the parameter in __add_preferred_console
   + "ttyname" as it is mostly used for "tty*" console names
   + "conname" like a name in struct console.

Also please split the variables per-line so that future diff's are
easier to follow. Something like:

	static_assert(sizeof(console_cmdline[0].devname) >= sizeof(console_cmdline[0].name));
	char buf[sizeof(console_cmdline[0].devname)];
	char *brl_options = NULL;
	char *ttyname = NULL;
	char *devname = NULL;
	char *options;
	char *s;
	int idx;

>  	int idx;
>  
>  	/*
> @@ -2496,17 +2505,23 @@ static int __init console_setup(char *str)
>  	 * for exactly this purpose.
>  	 */
>  	if (str[0] == 0 || strcmp(str, "null") == 0) {
> -		__add_preferred_console("ttynull", 0, NULL, NULL, true);
> +		__add_preferred_console("ttynull", 0, NULL, NULL, NULL, true);
>  		return 1;
>  	}
>  
>  	if (_braille_console_setup(&str, &brl_options))
>  		return 1;
>  
> +	/* For a DEVNAME:0.0 style console the character device is unknown early */
> +	if (strchr(str, ':'))
> +		devname = buf;
> +	else
> +		chardev = buf;
> +
>  	/*
>  	 * Decode str into name, index, options.
>  	 */
> -	if (isdigit(str[0]))
> +	if (chardev && isdigit(str[0]))
>  		scnprintf(buf, sizeof(buf), "ttyS%s", str);
>  	else
>  		strscpy(buf, str);
> @@ -2523,12 +2538,12 @@ static int __init console_setup(char *str)
>  #endif
>  
>  	for (s = buf; *s; s++)
> -		if (isdigit(*s) || *s == ',')
> +		if ((chardev && isdigit(*s)) || *s == ',')
>  			break;
>  	idx = simple_strtoul(s, NULL, 10);

The @idx value is not really important when @devname is used.
But it still would be more clear to set it to -1.

	/* @idx will get defined when devname matches. */
	if (devname)
		idx=-1;
	else
		idx = simple_strtoul(s, NULL, 10);

>  	*s = 0;
>  
> -	__add_preferred_console(buf, idx, options, brl_options, true);
> +	__add_preferred_console(chardev, idx, devname, options, brl_options, true);
>  	return 1;
>  }
>  __setup("console=", console_setup);
> @@ -2548,7 +2563,38 @@ __setup("console=", console_setup);
>   */
>  int add_preferred_console(const char *name, const short idx, char *options)
>  {
> -	return __add_preferred_console(name, idx, options, NULL, false);
> +	return __add_preferred_console(name, idx, NULL, options, NULL, false);
> +}
> +
> +/**
> + * update_preferred_console - Updates a preferred console if a match is found
> + * @devname: Expected console on kernel command line, such as console=DEVNAME:0.0
> + * @name: Name of the console character device to add such as ttyS
> + * @idx: Index for the console
> + *
> + * Allows driver subsystems to update a console after translating the command
> + * line name to the character device name used for the console.

I am not sure what the above sentence exactly means.
IMHO, the character device is too generic term.

> + *
> + * Return: 0 on success, negative error code on failure.
> + */

My proposal might be kind of naive. Some people might say that
it describes obvious things. But the API is for device driver
users which do not know much about how printk handles
the console command line and the registration.

<proposal>
/**
 * match_devname_and_update_preferred_console - Update a preferred console
 *	when matching devname is found.
 * @devname: DEVNAME:0.0 style device name
 * @name: Name of the corresponding console driver, e.g. "ttyS"
 * @idx: Console index, e.g. port number.
 *
 * The function checks whether a device with the given @devname is
 * preferred via the console=DEVNAME:0.0 command line option.
 * It fills the missing console driver name and console index
 * so that a later register_console() call could find (match)
 * and enable this device.
 *
 * It might be used when a driver subsystem initializes particular
 * devices with already known DEVNAME:0.0 style names. And it
 * could predict which console driver name and index this device
 * would later get associated with.
 *
 * Return: 0 on success, negative error code on failure.
 */
</proposal>

At least, this is my understanding of how this works.

I do not know the whole history. And maybe I get something wrong.
IMHO, the main problem is that the printk console code
historically uses TTY device names. But we want to register/enable
the consoles ASAP when the HW devices are ready for writing().
It happens before the TTY subsystem gets initialized so
that we could not use the sysfs kobjects for matching
the tty device driver names with HW device driver names.
And we need this kind of hacks.

But maybe I do not have the right picture about the initialization
and the names of the pieces.


> +int update_preferred_console(const char *devname, const char *name, const short idx)
> +{
> +	struct console_cmdline *c = console_cmdline;
> +	int i;
> +
> +	if (!devname || !strlen(devname) || !name || !strlen(name) || idx < 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < MAX_CMDLINECONSOLES && (c->name[0] || c->devname[0]);
> +	     i++, c++) {
> +		if (!strcmp(devname, c->devname)) {

I would add here:

			pr_info("associate the preferred console \"%s\" with \"%s%d\"\n",
				devname, name, idx);

> +			strscpy(c->name, name);
> +			c->index = idx;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
>  }
>  
>  bool console_suspend_enabled = true;

Best Regards,
Petr


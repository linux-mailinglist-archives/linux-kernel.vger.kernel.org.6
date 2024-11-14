Return-Path: <linux-kernel+bounces-408962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C99C85B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F45DB23163
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0701DE4EF;
	Thu, 14 Nov 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ak0msa9g"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329064C85
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575523; cv=none; b=DqvSNmgIqhkBlN7SrSyWtHqoFEs16qRGSipkMr1ExUXsi6uK9oJFYiiZuxgEBj3AJT/hM/Ti2RxDnFzMPP9dtRpVVwNZfZaXDIwZG6KAmO2zHKPXxClxIiESm2o8FnfencfZznmS805K2QeY1gxc1IXDC1kmv/nxMr7kXLlNkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575523; c=relaxed/simple;
	bh=E5qLWgGadC/4cmduClICekKgmWP5di9pvq3gpUXC+kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNNXfaPYICQq8uj8KTeOPo1kycNqvnBws1BiwFdeo/7jS0IiYXRwxgurnFIAdeEsh33WDCq3wON2AeatBwuhtZ2DN1rk62ClhEraIp3u6yH64/P9hSLMf+K7BsiHCMXZexDklPDnLt8M4lZLDlnCkDHPHGSxWrF8u1FqYKml91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ak0msa9g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431688d5127so3556435e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731575519; x=1732180319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23qaSgTinAWEPKVIwnVcokwLva3pZPBLI8dTYLfXjwI=;
        b=ak0msa9g4Q4gPJ10/Ni7omf/TpmWak70ifCfRu2XawsT/Ah9brhWrRk9BoffU88Ql9
         gTcaO6XkgtfibAEWELTkZum9CRPMK8ovhNjeKec8DITvnEwgvLUHR3NCmvXYhVxOLpnu
         9mxbDMZleL3Q1NnpgkPeOTHbBxRkne8Y1ZxJDn+iJBt19OC8/V2olB7+h+6xGT+/oxsa
         Mcl8RGK4usaGxHmUNqcLWr1TKGBYTlPyOdyKC2APKmcw571wQjey7ilcFAafMZVF2TMb
         lN/LeE/eUI83/rYs3GutFqZPSnKaSfMg0nmtJk8Oy6r05jiEF5u0PWvq3qf7rUTpl+Hr
         Zd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575519; x=1732180319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23qaSgTinAWEPKVIwnVcokwLva3pZPBLI8dTYLfXjwI=;
        b=Sw399Uy3vd1948tNYRP7t2+GXP87rLN6GZn6+vaN69jweRXFRAiErCPJS1DW+NZRfI
         +u1dq7eZ+f4sXKXfq7IwG9zqzKTI/Ex3tP4XiUtsG+BdNaEsyZ9Be/uAdw4SNZ6X+mXY
         bnK4ejUw4j08xkeOAtCua1FV6YPIhThgIc4snrLD1LxDvINhOtB/+FSjR+6sQ9wJJebh
         6KjUMtDU3PyMr4HoVKCWmbM28wP9NK2An55xy62TVRoXKJguXh0h12I551Mi0UlAiNHP
         3Be5TmLIxeCmw64T/mmuCJkJOqGjV9AoAqGsiox1IZENIkf4IQnZaAZfOlic7s/ljysb
         0Mag==
X-Gm-Message-State: AOJu0Ywv5vFy6D/hx8vNlq5GVh2ZNVi0DXB9xZ6jjcj1Bg6Ke4BVn2Sm
	UB4p28rR0YR1d9bN6m29S8V6GM2GADVFOh3kNblpEqYHDVLGAM7dfvu7je98YPM=
X-Google-Smtp-Source: AGHT+IFX/+2+Cm/zLwqCFEcrW2YrM8X63an8ZMikGr3PLV5GSKXIUKClMGibFRmHGNfufaVAlDFPnA==
X-Received: by 2002:a05:600c:35d5:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-432b7503749mr191158685e9.11.1731575519496;
        Thu, 14 Nov 2024 01:11:59 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298a41sm16604705e9.38.2024.11.14.01.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:11:59 -0800 (PST)
Date: Thu, 14 Nov 2024 10:11:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 08/11] printk: Support setting initial console
 loglevel via console= on cmdline
Message-ID: <ZzW-3LIF8pdnrLe-@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <fe2d066784a1b9e1c3fc3ba22cb7c113830caca2.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe2d066784a1b9e1c3fc3ba22cb7c113830caca2.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:52, Chris Down wrote:
> Extend the console= kernel command line parameter to support specifying
> per-console loglevels at boot time. This is achieved by introducing a
> new loglevel option that can be passed as a loglevel option within a
> console= stanza.
> 
> For example, this is an example of how one might configure netconsole
> devices to print messages with a higher priority than loglevel 3
> (KERN_ERR) at startup:
> 
>     console=netcon0,loglevel:3
> 
> --- a/Documentation/admin-guide/serial-console.rst
> +++ b/Documentation/admin-guide/serial-console.rst
> @@ -32,6 +32,33 @@ The format of this option is::
>  			and F is flow control ('r' for RTS). Default is
>  			9600n8. The maximum baudrate is 115200.
>  
> +			One can also specify the per-console loglevel for this
> +			console by providing a loglevel parameter, for example
> +			"loglevel:4" to set this console's loglevel to 4. The
> +			value provided can be from 0 (LOGLEVEL_EMERG) to 8

The real lower limit, enforced by clamp_loglevel(), is 1.

> +			(LOGLEVEL_DEBUG + 1), and messages below that will be
> +			emitted onto the console as they become available.
> +
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3903,8 +3982,10 @@ static int try_enable_preferred_console(struct console *newcon,
>  			if (newcon->index < 0)
>  				newcon->index = c->index;
>  
> -			// TODO: Will be configurable in a later patch
> -			newcon->level = -1;
> +			if (c->level > 0)
> +				newcon->level = c->level;
> +			else
> +				newcon->level = -1;

It seems that c->level is already set to -1 when it is not defined on
the command line. I think that that we could simply do:

			newcon->level = c->level;

Just for record. We need to explicitely set newcon->level to -1 in
try_enable_default_console().


>  			newcon->classdev = NULL;
>  

Otherwise, it looks good.

Best Regards,
Petr


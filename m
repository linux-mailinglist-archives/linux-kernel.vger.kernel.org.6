Return-Path: <linux-kernel+bounces-409729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBF9C90A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED0FB3BF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46718BC21;
	Thu, 14 Nov 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MYC83k+W"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA3B18B494
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604469; cv=none; b=fDzQmDFgLyWAdVFd5gZPBLnHl0ZxhQjntiiclJjrhUi/5ZSnsepBZAteqA6Cw/MFeI7Ia30H+8AuqlT5NMj9KvIOStz1rgt9vTG6hUADB7ggUf0Lq0XnUXBQ3qSox/wz/Gwg+L3CtF9rwVta89mM4klqlFKSWn4H5AkjFTcPv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604469; c=relaxed/simple;
	bh=eV4lV3UfGdignym5cYrcdBTZ1z+awg5a4qI7EyKwscQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDU5r3EyfIQUabBwSeR2XwtWTGTRwAKVTJW6DtA+tPcVX44jEj68SvLLg+h3epk1VrSoVnv2ThswMj4m6tMzIPGGsW4Qt4uD2P2+aFVog6lTJMz+7sgOYaRsvJxB+nsW/mqIZh42Wdje2UWh45ElMl6uq622No+Yz1aMDGq6ILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MYC83k+W; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382171e1a83so666841f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731604465; x=1732209265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpH/P8YXo4xaK4WAgOCM+7A+0jo+GMPALO0R6QywSNs=;
        b=MYC83k+WOmZEduxUnJqBewA6i+z+aNxN4+7JSfJRB3FnyfX4vCV7s4uK+KYrVT9w2B
         ak/Wy2zmOVTTv+ZxA0+PyRoRFdKfP6ynzpufsFto+kd4GJJheOEAYjs3vP47Vu7jp8C1
         oz9ZwDQ5GPb5LLJZzBzl+PwJa0jky8bmO0AJ8JweJAad30wFvx4SBiocsXqQgQquNy2Q
         GbeEGM7P0gas9aERwOmijqZFe/Uycey4OCNMsDo+NYuuZGD6iNYo4a1mwww+K1mIzGeR
         Wgv1G4DMXWJE4nzc3HUAb9bhI6xWswTj2hsLSxBEWT1nSYrhPHUAAFpbFBqM5S2bp9DZ
         /X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604465; x=1732209265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpH/P8YXo4xaK4WAgOCM+7A+0jo+GMPALO0R6QywSNs=;
        b=n7pAsooLHAb58mix0qNaeCpzC0b2cdjPjNVLpkJvwMEXx89y0Ggv7uAXGdhls1z/ZP
         VCb7K3eh0uf1zEFEz2e/VvxVEnEMyX9mDPGU8dP5iH1D9E5AaIOWBcj1Hl72O7lTZ+L9
         Yn0Ueb45X4cim0OKwEr6DGHbn2cT3qek6doRScSpNmXHD0PQ38JvXC//nMVaUK0GGyl9
         b7/FFc/m/g7b9hpp/A2b7xXCcED2LpQnA9A1MpE9IM0c1DXyQFqoWX0sZg/ZPxnOInKy
         SvGnmRmmDmnplvOMeJtDxNpxZLbH+gq21Wi98n7NeSDYW5QaVZweCgsyP7UCL9/sdot6
         hzTg==
X-Gm-Message-State: AOJu0YxazB/yjLfTztgMLu61i/pTwoLI+8IRFTv8DfWwR1hN5FUjo+nR
	oQM8tzGyeCXiTpBgFwkdFnSYe7S5Jks8s/DPxwkft91TST1ddm29/9cvs5bBH+4=
X-Google-Smtp-Source: AGHT+IEDfo0O46j2yyEjKodk2VCR8KT2kblJIlGFiIgc6rG8u+2p0QjdAC1UKx3ISAuWU/A/KgzWjg==
X-Received: by 2002:a5d:6d82:0:b0:37d:4660:c027 with SMTP id ffacd0b85a97d-38214075139mr4084176f8f.24.1731604464852;
        Thu, 14 Nov 2024 09:14:24 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada31b0sm2029407f8f.1.2024.11.14.09.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:14:24 -0800 (PST)
Date: Thu, 14 Nov 2024 18:14:21 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: syslog warning: was: Re: [PATCH v6 04/11] printk: Support toggling
 per-console loglevel via syslog() and cmdline
Message-ID: <ZzYv7SznkX34Wulr@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:40, Chris Down wrote:
> A new module parameter (ignore_per_console_loglevel) is added, which can
> be set via the kernel command line or at runtime through
> /sys/module/printk/parameters/ignore_per_console_loglevel. When set, the
> per-console loglevels are ignored, and the global console loglevel
> (console_loglevel) is used for all consoles.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1836,19 +1862,28 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		break;
>  	/* Disable logging to console */
>  	case SYSLOG_ACTION_CONSOLE_OFF:
> -		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
> +		if (saved_console_loglevel == LOGLEVEL_DEFAULT) {
>  			saved_console_loglevel = console_loglevel;
> +			saved_ignore_per_console_loglevel =
> +				ignore_per_console_loglevel;
> +		}
>  		console_loglevel = minimum_console_loglevel;
> +		ignore_per_console_loglevel = true;
>  		break;
>  	/* Enable logging to console */
>  	case SYSLOG_ACTION_CONSOLE_ON:
>  		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
>  			console_loglevel = saved_console_loglevel;
> +			ignore_per_console_loglevel =
> +				saved_ignore_per_console_loglevel;
>  			saved_console_loglevel = LOGLEVEL_DEFAULT;
>  		}
>  		break;
>  	/* Set level of messages printed to console */
>  	case SYSLOG_ACTION_CONSOLE_LEVEL:
> +		if (!ignore_per_console_loglevel)
> +			pr_warn_once(
> +				"SYSLOG_ACTION_CONSOLE_LEVEL is ignored by consoles with an explicitly set per-console loglevel, see Documentation/admin-guide/per-console-loglevel.rst\n");

I see this warning during every boot because rsyslogd() modifies the
global loglevel.

I am afraid that admins might not like it. I might live in dreams but
I guess that everyone would like to reach a clean boot without any
warning.

One the other hand, we should warn when it does not work as expected.

A compromise would be to warn only when there is a console with
the console specific loglevel set.

I am not sure if we have already discussed this in the past.
But I would prefer the compromise after all.

What do you think, please?

Best Regards,
Petr


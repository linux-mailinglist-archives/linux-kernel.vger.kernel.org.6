Return-Path: <linux-kernel+bounces-219513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50B90D39F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776FF1F25F60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE8119DFB0;
	Tue, 18 Jun 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XlTTkXR5"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60715A865
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718711; cv=none; b=M9LxeK37K/g0XOW6N0G1kALBv+yCkWFJYdEVFPP0E9ZOLzniy5U5S9ULiESHIgBzVqZrB410cZACIVKOVdjbouyqSYEhObHcExII7wbItnhD39vlEJ9RVcPa16sM+A+f/TW2M3/RpDx+TSn8+A6GgYAGnFjcexe942589w912l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718711; c=relaxed/simple;
	bh=+mnX+ZFjTZIEGJUHNnZ8ynjbHqtkfGgDSQpPSjh0EZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sroT+0i+t5fWAchmhWL74ZEKJK26IrLGitrQ1LnWLeOXwpv4EVYHMB20TRPigdsdIHjq9HX1z+c49eyaPe5K8OdTWHH3eWZ5efkutitpJYEUA8/UUE2N6q+F5L04ae1eyqz1PYJG0TeXroYk0gN1fOtv8Wo2XypweC4+K7aDJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XlTTkXR5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f04afcce1so702881266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718718707; x=1719323507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T24pOsqzjYl83UdbK651IK++6IZv8feRM6P25K+droU=;
        b=XlTTkXR5DWSRskwMs5X5PxxVg/Lhhfl3BF3zTwgtOMsOg4IeOMyC9hncNPIlhyWCz3
         t8wprt1yHj2n4Kqxep4Sr94fXZ2tUlArAGNs0V/qPe/TFXCwFV6KG4ozXypn5m4jD4g/
         4wzTxLr22b1ntGh5d3EbEB8jPKv4piA3Fhv8gG4YUBqNgy19usgVC6bePGy8hhxVJ3bA
         EhRH17uquK3hTL+fj4b7NqABPkfvWXiYEjgLsbp9XYDItiEELqUXulZOWjR64WUNhGe+
         ZAd7S1aJaY3R4dGfVMzsgSkHty6QTEe68ECI19AH+Zlr8c6QZeKbIz8p3uW1UQVBN1vT
         /71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718707; x=1719323507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T24pOsqzjYl83UdbK651IK++6IZv8feRM6P25K+droU=;
        b=Cp/xR0bWkduNgTeOlO4wsQeLhOlqOqIWw+pPh8YFSHfAIQLBED9RnObiaiQX4oZEZ1
         kxv30Pf2Yr8xGcSRNs7vkQDJ8DHraMWDtWlAKye6MfXen5kujWsjiea9k99LP6L3mVWB
         zYGSe5KR0Ov1vkYbBGG/Vbn2uZ4U6JvO6uK5WREgRefC4cGkyVZ/asY47xq7nnAB0dLk
         KMs/NrmYS7ytMsOwzXJjt3mXr/yDGFO34mh9cGy5yvwbBHNhmpUP+4IRWR1731xkmpYI
         S2hwcOY4Em/8pYRcJWt7JN7ca4VJFpp37xyd6FX8aKkEg6mzbYRXoZnWA1ExgJk+Xs3V
         OQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWdXVBlROIPLstpKxb1s7MERFi78eBGMCd/1wbZBXRYSgZEQqXhhTFQhbuTVkt1kBMXy/BbCPm3J16GyKN5aEocXRKoljzDrhVGl5ee
X-Gm-Message-State: AOJu0YyBDSlucgnWoYBS++8tCFLSlYoHFutgG9QVHqn+6N2qklYTGw09
	IhXb/GT24NFySaFYOZVz/5w7V2RHD18HuKzIYWz3y+D2Qq4S124bdjlA8YPCeOw=
X-Google-Smtp-Source: AGHT+IH1qH5JRw+foJLL7XOXWrcR22UFT6v7p5/00stwPoOBn9rD8IaPolls6u2mh/ef7fgIDoZYhw==
X-Received: by 2002:a17:906:680e:b0:a6f:7cb:6e76 with SMTP id a640c23a62f3a-a6f60dc4fa3mr951575666b.51.1718718706771;
        Tue, 18 Jun 2024 06:51:46 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecd666sm620723066b.135.2024.06.18.06.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:51:46 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:51:44 +0200
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
Subject: Re: [PATCH v3 3/3] serial: core: Rename preferred console handling
 for match and update
Message-ID: <ZnGQ8JAu2OQf0GX8@pathway.suse.cz>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-4-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618045458.14731-4-tony.lindgren@linux.intel.com>

On Tue 2024-06-18 07:54:50, Tony Lindgren wrote:
> We are now matching and updating the preferred console, not adding it.
> Let's update the naming accordingly to avoid confusion.
> 
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -304,7 +305,7 @@ int serial_base_add_preferred_console(struct uart_driver *drv,

I was curious whether this patch renamed everything. And it seems
that it did not rename serial_base_add_preferred_console().

>  	const char *port_match __free(kfree) = NULL;
>  	int ret;
>  
> -	ret = serial_base_add_prefcon(drv->dev_name, port->line);
> +	ret = serial_base_match_and_update_prefcon(drv->dev_name, port->line);
>  	if (ret)
>  		return ret;
>  

Honestly, I do not understand what are all these layers for.
Especially, serial_base_match_and_update_prefcon() looks suspicious:

static int serial_base_match_and_update_prefcon(const char *name, int idx)
{
	const char *char_match __free(kfree) = NULL;
	const char *nmbr_match __free(kfree) = NULL;
	int ret;

	/* Handle ttyS specific options */
	if (strstarts(name, "ttyS")) {
		/* No name, just a number */
		nmbr_match = kasprintf(GFP_KERNEL, "%i", idx);
		if (!nmbr_match)
			return -ENODEV;

		ret = serial_base_match_and_update_one_prefcon(nmbr_match, name, idx);
		if (ret)
			return ret;

		/* Sparc ttya and ttyb */
		ret = serial_base_add_sparc_console(name, idx);
		if (ret)
			return ret;
	}

	/* Handle the traditional character device name style console=ttyS0 */
	char_match = kasprintf(GFP_KERNEL, "%s%i", name, idx);
	if (!char_match)
		return -ENOMEM;

	return serial_base_match_and_update_one_prefcon(char_match, name, idx);
}

It seems to try whether c->devname matches a number "X", or "ttySX".
It even tries the sparc-specific transformations in
serial_base_add_sparc_console()

But this is the original format which does _not_ include ":".
It never will be stored in c->devname and will never match.

I think that it has been the case even before this patchset.

I think that we should remove these layers and check just
the "DEVNAME:X.Y" format, aka "%s:%d.%d" [*].


[*] It would be nice to use the same printf format "%s:%d.%d"
    in both serial_base_device_init() and also in the functions
    matching the devname to make it clear that these are
    the same names. Heh, I just guess that these are the same
    names.

Best Regards,
Petr


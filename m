Return-Path: <linux-kernel+bounces-558022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B9A5E090
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8113BA657
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27423254B1A;
	Wed, 12 Mar 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AnTL3qVA"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642286349
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793833; cv=none; b=NnzoaaCx/Oul5+RuoyjJwVVkb5wi5X/abphmm0SQRlT6kgFj5bq7jBFQ2ADJXEwcVFnqtrgEYt2cb+VbV8gCfD90jJg6FIl1i61Qy4EuCtKmKtJa30MHZVN5Ry4sGujxx6mgCUFr29k78TblYFPSkb4RSbUMqj1h9NOVpBULqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793833; c=relaxed/simple;
	bh=FzRC24K2rUcGQSVMB9HuxLcZEuqqamCVHt6GFEg/Fas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbRn1IwnQ+b23K5/9nbt3tL7QzmDVSMiW3dLrYcpAaRT+hKDV22xRoVk4mwuk6vm5sk1HxeeD9XMg+UYtde4cX82rpOHC5FCzWoL/3R3j0+QKEREb4kzCtlc/NdufRvNcmfYktfVVbCpO16DN3kAcBjV/LycA4C0IaF7m86UBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AnTL3qVA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913b539aabso2739004f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741793830; x=1742398630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox7PZwipDHpiBMNVxpGln9X1xKo/Hs1Sc5ewJoP05ZU=;
        b=AnTL3qVAMqR+02rhuuj7fqFLXsHW2gJYvcF3OkkwbEpn5QX8TOuQD+mcKFIuu+t0lo
         RkTqk+IBwm7c4hchcm95AGcPpwBH2dqq0K3XkWs1UkwAfgzjWqZoNGBZ9oL5lzmAdUq4
         jcM38exlT6mwQIpCicKNX5j59hTDa7KX39yfq7n1CJmp872GaLS7D5zOia0AAh45yBcM
         ewPogijBPuOaxiOsm073/qyB+yoftDWczA9aG5CCAKPOeRH6ZTFm1uO7t/2bFU53SP3/
         SJcHLb7Xe29IG1Mt16YSkOHNgLRWFxMNfCayap86uCBdd+uk7iaLcspni3I24lNTisS+
         2FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793830; x=1742398630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox7PZwipDHpiBMNVxpGln9X1xKo/Hs1Sc5ewJoP05ZU=;
        b=gvKsr1GXKEwYmJzxQ66kOKNd0PkgQfWCQzvj7ScY7r1wB2uUi7eS9c0q5g1UUDwBO1
         gb4KpKdCOpTtrVdFXzzZttC3Ga0Pf+avWyZSuG0Y5F8emHYHKst+8edTm3+LryIMP4+1
         XAk0csnmpWSDdfva8nDXNytS8WCyZ/FLfbecjscMgg58EvP8u0/EHNOW5WfgI07yKz+S
         PNZkpXbJns8ml8eadgJTvJ/w/37lLbOKiSVmsgwRYqOtUGL8NJw3invehHFihQ0dbIV3
         lSRjN9dFM8q6V+c8PpI7B4lZAfCm48OO94ioz/xTmTq8GCW8bpbXN3Kfvyb86CZtKa7v
         Ng6A==
X-Forwarded-Encrypted: i=1; AJvYcCW2/tzmYNaSUxTsFDX71rpFCwhu3xEYzQAF76jmPWwCQzSCIIWvfy/HQ/FsjnzN2CninSN1FeXVy3gJ6Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr17ukPjY64vFVBagQ4gMnRQvlSbayYSVIt1BiHB83uLH/1XwD
	4KA9S3zoLrTUOFiOYGY8zSIs4oM9BOUvox87/AZfn2rYbxKRbfGJtb3UWqD3tpE=
X-Gm-Gg: ASbGncvoPnhsUT3sEavob40+uxq33s81nDZ48zWge9fOW6Or0C9AwfFqp3RYBbh1Cy9
	W3xPLq8EvQJDMsc8WDi/9Jrr/J8scc/xqawypKwUl4ovS7vejjXqZ+h1USR4hxczpGEL85HFWio
	Y6ye0KmDhQIH8o5lKmqOtHGjcJT3ETehjZu9b8qBqUee0W6pJnxewusPuPpFjj3KsfyVMCxmeez
	XQpKWUfVzrwniO4vZFeTX68oF6zBmFMOnymTkzyNx8Edk5k5IoaEqUokVKIxwh3gY+w1rRvHzd6
	MouzsZJz9yrgTYGCaz0Wd+b7ETlYaKHssHNTEUv61qPoM/SUrMBiL8kkug==
X-Google-Smtp-Source: AGHT+IHHxEP/z6N40yXo2QEJRK/TH0iMryWM2SVWb2LisrcwtQwUj24Lm8paSZ0qaYEVKP/yIuIwfA==
X-Received: by 2002:a05:6000:1564:b0:390:f45e:c84a with SMTP id ffacd0b85a97d-39132db77acmr18766004f8f.48.1741793829718;
        Wed, 12 Mar 2025 08:37:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba686sm21815646f8f.19.2025.03.12.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:37:09 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:37:07 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v8 2/4] ttynull: Add an option to allow ttynull to be
 used as a console device
Message-ID: <Z9GqI2HvOJaAOr-r@pathway.suse.cz>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
 <20250311033133.1859963-3-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311033133.1859963-3-adamsimonelli@gmail.com>

On Mon 2025-03-10 23:31:31, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> The new config option, CONFIG_NULL_TTY_DEFAULT_CONSOLE will allow
> ttynull to be initialized by console_initcall() and selected as a
> possible console device.

It would be great to mention here the motivation. It is nicely
explained in the 3rd patch.

> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -383,7 +383,20 @@ config NULL_TTY
>  	  available or desired.
>  
>  	  In order to use this driver, you should redirect the console to this
> -	  TTY, or boot the kernel with console=ttynull.
> +	  TTY, boot the kernel with console=ttynull, or enable
> +	  NULL_TTY_DEFAULT_CONSOLE.
> +
> +	  If unsure, say N.
> +
> +config NULL_TTY_DEFAULT_CONSOLE
> +	bool "Support for console on ttynull"
> +	depends on NULL_TTY=y && !VT_CONSOLE
> +	help
> +	  Say Y here if you want the NULL TTY to be used as a /dev/console
> +	  device.

I would provide few more details, something like:

<proposal>
	  Say Y here if you want the NULL TTY to be used as a /dev/console
	  device by default.

	  For example, it might be useful to prevent a VT-less kernel from
	  writing the system log to a random device connected to
	  the serial port.

	  Another console driver still might get preferred via the command line,
	  SPCR, or the device tree.
</proposal>

> +	  This is similar to VT_CONSOLE, but without the dependency on VT.
> +	  It uses the ttynull driver as the system console.

Honestly, I do not find this paragraph much useful. I would omit it,

>  	  If unsure, say N.
>  
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index d8b51edde628..67aad3e6f538 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -96,6 +96,19 @@ static int __init ttynull_init(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> +static int __init ttynull_register(void)
> +{
> +	if (console_set_on_cmdline)
> +		return 0;
> +
> +	add_preferred_console("ttynull", 0, NULL);
> +
> +	return 0;
> +}
> +console_initcall(ttynull_register);
> +#endif

I have realized that this does not work without shuffling the linking
order (3rd patch).

I would prefer to avoid the linking order hack and rather call this
in console_init() directly, see
https://lore.kernel.org/r/Z9GPVVTnngGbmbuv@pathway.suse.cz
for more details.

Best Regards,
Petr


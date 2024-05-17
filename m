Return-Path: <linux-kernel+bounces-182236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ABE8C8872
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBCD28639B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B957490;
	Fri, 17 May 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bRTxpj/I"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E367A0D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957484; cv=none; b=mpCrbZpHKn08N0FbwhdIRkn58TIFQOpO9H3oPft5/GTjrp+q8el0V51Xg6PLQXFD69GYXbxLtnWkv8+gRlOYHo4g7pvijTMdrYXUq1UkIv/xo55s5vUWYe2I/qcu06OiVZMhLDjdOmPHQRDMsYb4J4A5N4l/uYTYEfW642gB+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957484; c=relaxed/simple;
	bh=1aOVgw6hSgat6smy0lHMoNOBWlOufPQjFo20G/kY2sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQXOaFbyokmg0rH4d2Q6ELJ8eZL9Rv2h5VC2rzNF/5QLRIrhIZUfSNj93oRraP0RiuuX0gZVwm5QthWKHqfcG9UDk8Fx/dOKwtplWyEFXS+3slQt3RIDg7+vvb9J3MF5RtgNs7/4veV1xEf74sazVvSapKZe6pIUN9UtIPcLNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bRTxpj/I; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41fd5dc04f0so1618875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715957481; x=1716562281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1U5jaDar7OfZ99raGWnoHg7cFZibmJ1aTqNn0ttXSs=;
        b=bRTxpj/IblmdTrVz9jPdjA02CBwgQhIQGFeNdKndT9KjyNTETRvDogbciVpdjB6tE5
         cWEsCIfStXkQVEgyo/B7JvHqrOM4QrbsAdqptilRiyTl8cEp0n7hZvbSEHXlNZ58PuHP
         C6r1y2juBKpD1dVKVu3V31Cy34N+FTTxeBk3SYZNwiEckTFrqBdNks5CE/IAsAUYJXkz
         aWOCMKCu44htiDocsNttkMi0RDRJnU2n2i40aY0G2WO4g6svcEJ6+KBIgODaO4e7OZYU
         hDBMGH14pphwJspN6n3JoyRScMIULwLGyGIZincb2QZTX88Ts/ZaHHmzguOjiu7eB8nd
         /Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957481; x=1716562281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1U5jaDar7OfZ99raGWnoHg7cFZibmJ1aTqNn0ttXSs=;
        b=AvB16kHX3xm4xAwvQjY9KeBNFHfg/SgkMaAVDN9IHULJT+7CEFuY3eUG8HwhboCOle
         GdV25Jhbf6m+HvFZlptozh0UX2veNUEgf+5OKdummoVHccQImzqWLqo8KUR2ivHXrE9u
         17A/zPbGxpSq4Gf95/TPGPEzKnq2zVFLhAsSWAjjJd2r0/IFb8tzKI6rIrg+gLFHobjL
         6LZWo9EXnMQcz5bmWINmGY8+A7cm9bMPf9emZDYeKgjbyKpFt9THlLoSdrdH2F/tcQ+k
         mgS0A6rFs37YqW9OLBJ4fTMgdWfmzq+ac0mc09UNQHBiR2QDkwFYTY++OwzK30RhBJSR
         W/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV1MCjFe+0aHv7f5UCTo0OLwUVOyPIKw/rlOJiHRl8OJ+hVX+Qg9Sm613mgsRmhNE52BzMhmq1gjQqXhhnABkN4ylcAk6xRuIBkdGQY
X-Gm-Message-State: AOJu0YxCTalU09E/ajE3oFbxmEJSuhtUxOoAF0hHHE9A5xaD1vgmN9Fb
	1MoHL4DVoUwSC7+yjnHuB6sChM/N/6PCxvw2AQpz5BljwsNBDTQkINULD2+TUsk=
X-Google-Smtp-Source: AGHT+IGSNgAtmWQfb0w8Kl65ihzrKqCApb6t06Ku0iJmdFWRb730Oyxyj8fQ3oS7uwaOTj9nQj/rrg==
X-Received: by 2002:a05:600c:19c8:b0:41f:d84b:1ade with SMTP id 5b1f17b1804b1-41feac5560amr234770785e9.27.1715957480894;
        Fri, 17 May 2024 07:51:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200e518984sm242602035e9.23.2024.05.17.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:51:20 -0700 (PDT)
Date: Fri, 17 May 2024 16:51:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v5 09/30] serial: core: Introduce wrapper to set
 @uart_port->cons
Message-ID: <Zkdu5v-ifyGNCV_n@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-10-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:18, John Ogness wrote:
> Introduce uart_port_set_cons() as a wrapper to set @cons of a
> uart_port. The wrapper sets @cons under the port lock in order
> to prevent @cons from disappearing while another context is
> holding the port lock. This is necessary for a follow-up
> commit relating to the port lock wrappers, which rely on @cons
> not changing between lock and unlock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


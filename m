Return-Path: <linux-kernel+bounces-406579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B86BC9C643A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD3BB3ED6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F821832F;
	Tue, 12 Nov 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jizc66wA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CC230994
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438185; cv=none; b=S6lBhaJH5FUh0F52gz8XBuOVKXhaXrPLu6VN+ikO0UZIqt2C0RhcuHS49nnUM+6k4+6MQZmwdsLhaYvqfaH0J1RtuCBJGm2PxHH06hN1fPYAQq7Z8bXSpmID2AgPICeqObsenf6R3YfNFGTFiVvylfFPVkAR8YV3yJiGoRvcRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438185; c=relaxed/simple;
	bh=O6vE6qB0NNkRkRyyRecEvVJhd/8SocXQJT0Sotolh6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y72V8uTr1lzjgxa1nzdviC0GkhVtOTUXcPVqR9c+WfGXs6/HD8TlECl3hSl1hWRuQRkySkMHhV9pJBZJD0rtuEWpnXzHAOAO2Yeu0510eZ4EQlpwK634Z6pXlhVF3u3pAeN0HlU3J1X6EexjJcH64Z6KJDKedCT0KO5XTmQsjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jizc66wA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f84907caso6831234e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731438180; x=1732042980; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xxLqrRJ6SY3aveV57FtrhBS5FEl34yCXiwMcZLGGmPI=;
        b=Jizc66wABtX4791jYrVWkF+v/bsQ0xPCZpcsArTJMdsCjzydAz/ZGan8RQZY8KUPal
         8yuyWSkWmQay3u4xVzhcJ0IWRWluq3nlGZtL7KcGnJO7RVp1fsurHbUJztW4RGQGZXeq
         sde8kprMvDM3BJHqPnAgoXi6t3yDTzp2QOl6Cyxby3H9zDySGaMqF2sHjfPZZcE/H3yp
         or8EDYJt0RJ8+0a3RLdO1jh4A8eaOYbGyI1Zb1tpilwl0dkvL5pvEU5ra/SjLI3tLc5T
         mQhqU0JgOJsk3MRAEJNPp4htnUjILg/9ecoU2E/hlREVip21N4PxT0MdkfOiv+TCthe5
         Voqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731438180; x=1732042980;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxLqrRJ6SY3aveV57FtrhBS5FEl34yCXiwMcZLGGmPI=;
        b=nmUA+nD3lqgMOcX+vYk6IV4tC3mKlxNzJh5+wZfW3hk5VwHsQPHO9nEGDtCEN1khBo
         gcEepxMWo8o0x+LXZUDWdUPVDDEXOVNnfr/hp6yyXzGl5hjtsS4qDfxi9vDqZWkMaIF7
         9wRhYK74ZOOwM8gXj6tSMV/K83OAWtfP50VLIuWGBjzfmFy2F1e2S2COKVrkfgLmAxKY
         dK22EdC9k17rTaQYDb34DhAEMFGiNNOq57XYBn7wIolwFkg+N8B8A5Y6n1idX/2yvKN7
         kQq2djT1jgCAPLfJ1f4bjgG6RaSfd41EWts8qrfSwlGJsTJqQBgLD2Ig3bfb6y5SvlEa
         6EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfY7WaBdXbyIcYLsHRIHCybpRM81ioccpXlFJtnM2MgTXDLFbnrXlaYcX2T6BirsbeyIPNjDuPDGezYPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXoKgS2PZNF6llRHf7DfnVJSFJgUYPKPZVu7h7ICbH4sqY/t6
	G2QFIejfiDqKqeDvgMA0RCqnZpNWvpHBx3tgT57uGb/4yDFf7gDO0Zl7MvmqJYM=
X-Google-Smtp-Source: AGHT+IGegCbSsynDkWm3rsYBD5mMnXwtIgZREvVK/xN59bUdeTXvfAxtgJBtIFx8BN4RzRbuk8jQ/Q==
X-Received: by 2002:a05:6512:128a:b0:539:f886:31d6 with SMTP id 2adb3069b0e04-53d862bd946mr8348813e87.2.1731438180306;
        Tue, 12 Nov 2024 11:03:00 -0800 (PST)
Received: from [192.168.3.33] (69.36.160.45.gramnet.com.br. [45.160.36.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5f82sm224106725e9.42.2024.11.12.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 11:02:59 -0800 (PST)
Message-ID: <57190fd1401fb6238e4e1efd078c3aaa0314ebac.camel@suse.com>
Subject: Re: [PATCH] [v2] printk: add dummy printk_force_console_enter/exit
 helpers
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Arnd Bergmann <arnd@kernel.org>, Petr Mladek <pmladek@suse.com>, John
 Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2024 16:02:53 -0300
In-Reply-To: <20241112142939.724093-1-arnd@kernel.org>
References: <20241112142748.673772-1-arnd@kernel.org>
	 <20241112142939.724093-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-12 at 15:29 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The newly added interface is broken when PRINTK is disabled:
>=20
> drivers/tty/sysrq.c: In function '__handle_sysrq':
> drivers/tty/sysrq.c:601:9: error: implicit declaration of function
> 'printk_force_console_enter' [-Wimplicit-function-declaration]
> =C2=A0 601 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk_force=
_console_enter();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/sysrq.c:611:25: error: implicit declaration of function
> 'printk_force_console_exit' [-Wimplicit-function-declaration]
> =C2=A0 611 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 printk_force_console_exit();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Add empty stub functions for both.

Ouch, indeed, my fault. After disabling prinkt I saw the build errors.
Thanks for fixing it!

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>

>=20
> Fixes: ed76c07c6885 ("printk: Introduce FORCE_CON flag")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: realized I sent the wrong version that was missing 'inline'.
> ---
> =C2=A0include/linux/printk.h | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 232e5fd06701..4217a9f412b2 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -232,6 +232,14 @@ static inline void printk_deferred_exit(void)
> =C2=A0{
> =C2=A0}
> =C2=A0
> +static inline void printk_force_console_enter(void)
> +{
> +}
> +
> +static inline void printk_force_console_exit(void)
> +{
> +}
> +
> =C2=A0static inline int printk_ratelimit(void)
> =C2=A0{
> =C2=A0	return 0;



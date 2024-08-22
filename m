Return-Path: <linux-kernel+bounces-296868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737895AFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8901F230D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713416A94F;
	Thu, 22 Aug 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZUyJ5kmX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012D167265
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314511; cv=none; b=d6XRBeG3saY/S5kGyZ3yzZel1S7iTBBhrxlEo35t+dAkcjEH8Qc88mK3K127vM5Y+RWAuDakGELJ8xERgm9668zcu7eG325XIgDODHUfwCe/9kaOGSqyxTwQ9hGS3aP0IlcQsW8FDpUhfsq8vMh17i4X9GeHtxV5TEg9XM4J2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314511; c=relaxed/simple;
	bh=4+plhM6XGll/dZyW65pbLdBOOFw1rlZMg+Vzo8FvuSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZe+i4eNubrvNkXV5mw9S3rGTrRZRif731Ms49bT7//3jJAasOFV/K4ca1xtlrIj2gNfmR70fl1FsM9FVru6wwXrQ5MmKJiDlZkltmj3GdhxH57zAhJrcEsgiGGaRrOo39vX8EdRTHCnpzVHLgnSB0HORhHs1QdilZ2GasqHGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZUyJ5kmX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334c018913so495546e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724314508; x=1724919308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vnkrFJMrCHnlG4osI+Y4ZSq/dT6LMuQxa7EvoixGIKE=;
        b=ZUyJ5kmX+xvVyD92BEh2e6+NoLfK/CYQgySfnLHrCKHMC7D0BCK8/H5K+Ie0lh52yz
         8/qCZTBuWwfbtYQp1AAWn/bWiKwS1EXlBT9PMBb65jnESS5GX+XRF7u4ri+pCedCcqw7
         6xrBZmFEF54t8e5JAtOeADJJ8oWzfhEqeR++jrNOJy6LlVaFoRcP3D0W07otQV8RtRnK
         0FzLqNTj70lmzbhUl1M5GPvhutkRIngoifdUfEwObuHXhXLi+2Ti37tmlM/4Y8XDRTS5
         sfHZVpXXNlH7GhtQ6AHvGqto3Bod7xJT3hUVP+eJaHJ4W1js33FhHDENH1n33Y2gZzr4
         +4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314508; x=1724919308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnkrFJMrCHnlG4osI+Y4ZSq/dT6LMuQxa7EvoixGIKE=;
        b=gSDf+7b0XC8OcsYjjtFXyebLtc+FqudvNgrUCE+TcwQ3u8bTSqBvg5f9JIhME/5s0N
         mxrKhMVxfWdWiomptPQ7RoA95HZW1aLvk9GSl+JFxJEq0vaf+AoxCmIcCH/4uc9pqa5q
         v5Q/HdQslxxRnFP8e0qgTjl3KmYnTvUEgtZjWq2U6n5GTZUC7ux3wqexNWPsD+qJcDbT
         tWcZmB78aY1v3i+X2qvSwz4b4bCxMSyj/x5T2WyqhaL6mtJ/vJ/t7on5HFfG79Nr7PKc
         OptAgtcc41OZGtz1jcE17sM2cA7qJR2Y8iEset3xuQs6oBCRMqgt3KE60olu8Z2pfaFF
         5ThQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcC/7S9s+MlxQrsDg/RGkWmi1HLkNGE9wQqXemm0+Pv2HgdCItBPoNVprt5mxY7JpzkRwkk32ia1fG/l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytVkH5sOrZZWDqpHWk10pLOvup+7ysGQvtSDFZsLGeN3Dyu+Kw
	B/EOK6WuVLKrpekakE2Thc/yvYydVAx1wE5uVqM497i5hsqKGAjJO4Qa5w+QrIs=
X-Google-Smtp-Source: AGHT+IHdlqsN18qq3sKoPlKTb93mTLKraltP6emnhjNI6tTTpM/pYcIGkKPgbIF/bg6sgBSxnlbVQg==
X-Received: by 2002:a05:6512:b1d:b0:52b:8ef7:bf1f with SMTP id 2adb3069b0e04-5334faeb0aemr507805e87.17.1724314507405;
        Thu, 22 Aug 2024 01:15:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c439asm593077a12.76.2024.08.22.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:15:07 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:15:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul Rangel <rrangel@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kramasub@chromium.org, Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Zhou jie <zhoujie@nfschina.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
Message-ID: <ZsbziXXdPwLrJR_t@pathway.suse.cz>
References: <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley>
 <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
 <ZLGVYg1FAZN7VFxB@alley>
 <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
 <ZLZgZvE35fYCkgOq@alley>
 <CAHQZ30DQw9n=uiuz3-nqnOKVbZdp-=DfeSn2feoPL08RjYzT=A@mail.gmail.com>
 <CAHQZ30AEuwUzJs0bjsZ4eisJhmG8zkrXx4eKnfGsJ1jBt=jTUA@mail.gmail.com>
 <ZsX79M3RcertYHQZ@pathway.suse.cz>
 <CAHQZ30BwXeZNS1BZCQa5Nyb6S7akXvAqnhXR8w2Cj6LnMG6kGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30BwXeZNS1BZCQa5Nyb6S7akXvAqnhXR8w2Cj6LnMG6kGg@mail.gmail.com>

On Wed 2024-08-21 09:30:17, Raul Rangel wrote:
> On Wed, Aug 21, 2024 at 8:38 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Thu 2024-08-08 11:30:53, Raul Rangel wrote:
> > > On Fri, Jul 28, 2023 at 11:57 AM Raul Rangel <rrangel@chromium.org> wrote:
> > > > > Your patch is good then. Well, would you mind to add a comment into
> > > > > the code and make the commit message more clear even for dummies like
> > > > > me?
> > > > >
> > > > > Something like the patch below. It would be better to split it into
> > > > > two:
> > > > >
> > > > >    + 1st shuffling the check and adding the first part of the comment
> > > > >    + 2nd fixing the case with empty console= options.
> > > > >
> > > > > I could prepare the patchset. I would keep your SOB for the 2nd patch
> > > > > if you agreed.
> > > >
> > > > Yes, feel free. Thanks!
> > > >
> > >
> > > Hey Petr,
> > > I was just following up on this. Were you going to prepare the two patches?
> >
> > I have been quite overloaded last two years. It would help me a lot if
> > you could prepare the two patches and send them for review.
> >
> > Thanks for re-opening this. It has already fallen through cracks on my
> > side /o\.
> >
> > Best Regards,
> > Petr
> 
> No worries, we were just going through our tech debt backlog and this
> patch came up.
> 
> Thinking about this a little bit more, I'm wondering if we can clean
> up the hack. Would something like the following patch work? My thought
> is we declare an early handler for `console=`, so we can handle the
> `console=uartXXXX` case, and leave the non-early handler in place to
> handle the `console=ttyXX` cases.

I am not completely sure but I guess that it should work.

> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a5f380584cdae7..7a48fe6fc0dffc 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -241,6 +241,21 @@ static int __init param_setup_earlycon(char *buf)
>  }
>  early_param("earlycon", param_setup_earlycon);
> 
> +static int __init param_setup_earlycon_console_alias(char *buf)
> +{
> +       /* We only want to handle `console=XXXX` in this handler. We leave
> +          `console` and `console=` to be handled later by the non-early printk
> +          handler.
> +       */

I would prefer to be more clear about why we do not want to handle
this case here. Something like:

<proposal>
	/* `console` and `console=` are used to disable console	completely. */
</proposal>

> +       if (!buf || !buf[0]) {
> +               return 0;
> +       }
> +
> +       /* `console=uartXXXX` is actually an alias for `earlycon=uartXXXX`. */
> +       /* `console=uartXXXX` is actually an alias for `earlycon=uartXXXX`. */
> +       return param_setup_earlycon(buf);
> +}
> +early_param("console=", param_setup_earlycon_console_alias);

I am not sure if '=' can be part of the param. All other early_param()
definitions are without '='. Also it seems that next_arg() in lib/cmdline.c
replaces '=' with '\0'.


> +
>  #ifdef CONFIG_OF_EARLY_FLATTREE
> 
>  int __init of_setup_earlycon(const struct earlycon_id *match,
> diff --git a/init/main.c b/init/main.c
> index 8e1f6127e172c3..b6f0cb424176da 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -740,9 +740,7 @@ static int __init do_early_param(char *param, char *val,
>         const struct obs_kernel_param *p;
> 
>         for (p = __setup_start; p < __setup_end; p++) {
> -               if ((p->early && parameq(param, p->str)) ||
> -                   (strcmp(param, "console") == 0 &&
> -                    strcmp(p->str, "earlycon") == 0 && val && val[0])) {
> +               if ((p->early && parameq(param, p->str))) {
>                         if (p->setup_func(val) != 0)
>                                 pr_warn("Malformed early option '%s'\n", param);
>                 }

I really like this change if it works ;-)

Best Regards,
Petr


Return-Path: <linux-kernel+bounces-414416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECBC9D279B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE561F23636
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712E1CDA0D;
	Tue, 19 Nov 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH7+5Nmu"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668601CC88A;
	Tue, 19 Nov 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025125; cv=none; b=SE2KS4TUhRv2h70ZQfiQyCOjM6iVFWIPf3eA504R3IhTQsNrdsgD8paUuYaU4XVYqhdotqfib9n3KymziaT62W7xK4plxdWoWEj6kjNw7eyB5OJmzpQrj3zUtvqavJnYXEkO8SNDiiZSkqislB+2/UDNlQi8yJp74rBMd9bL1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025125; c=relaxed/simple;
	bh=CJ8MaQ6Pc80WIqscYCu1eno+cbsbvM0V81tsiR9K60g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKCLMo5gAPX5zx3px8uRzla3r5LG3TbtWGFXQXCjMK9rOuY+uta/mV3zhzy/tk9IVfvzoqVZJ90mjhUD0MyElPowB+a9MW89r0SjssNBleoLsbwoQfL0uA8VdNKu/3bJ0ik5bIYXwg7vxnRs8tFCKDat5IKH5sHnQyhRqQraqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH7+5Nmu; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso3666156a12.1;
        Tue, 19 Nov 2024 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732025123; x=1732629923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBPalY9b5mWlkTSpEFxpCuN7/q0yodTJdlXJYJftjf4=;
        b=bH7+5NmuAhdqfuY19BxeggbCaoso1QtGcgmFDlNCoxLHlkXW9HaWOQLLEooYiHUCcY
         2B3o9Dv+64rNXiBhy9smkEiLFLQD70E+o4DcojE4/XSfzCMzLOFHXhNo8qNoWjHYQ62p
         gKNg18ewqoN8OXht1BXyYvy10M0ifCWAiMkK/BmwsOX3ES75fUIaylCRj8dhGKWDk2kz
         Sxav8JcFwOoMD6SG5SxzR1Eu1kggmyuCHXJIwijFmDX5rhIsPVmlkLQkszsB07dDh71v
         dTzFe5ZCPMZBzzvGZ3bSDOAyEMuwplqfwSRC/xxlLtB6D7Dy9qzZms63XLzn5O3OxJct
         QXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732025124; x=1732629924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBPalY9b5mWlkTSpEFxpCuN7/q0yodTJdlXJYJftjf4=;
        b=bI8ZH5S8yXZNSZWjtlKVK8ALXxjnFtgT33jgFuHZSD+3pl2V1q0rPgAFaZ1Y80NSUh
         YtiVDtUzZFGnTmlxT1KnRDAmt8tli5vSmgu0VxVw95OSh3DBqkmXl7BB9Pkbssrl7GRh
         rMaXkokQaNdQxI0/CO5WFLMYNfIm2K1X6bnHx6sF+60sIl0DWBFHZEwcFi+nKsH63cmL
         s3bDRjGgvwju0H6bUXZsBI9vQb8GmkBWD6sdftDSbmDU6Jlawh41oI6fHyc7KPayDljl
         VmI9pDXZFqyQjHasP6CWPE6+TVFjUAePDIbKRpdROn7fXSUJjlZqAtoLq+vZhOvpU5Zp
         99mg==
X-Forwarded-Encrypted: i=1; AJvYcCUR8wKZaAy2+Ghg02YKIeypJpHqgG/DrhxshJiF/+DfcVgSw++Myh8aAQIYAKl/rHbANgVEdLAHIBw=@vger.kernel.org, AJvYcCV4jzK7+L5Un7GnHVpcXAqzaJGfmWZPgrqVEEpafv3p1d8HmBSfPZZWCBB0wjHxXytXU4mD3kcagVKEU5yE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wcz9sbCZ/Q+1wL2DdqvITmD3/hMJL8o9c4uiTRISDn0n1+TV
	t+qqVAM9zzEF7dHPfPrIlyCRmnFJ7y2aHfXquApuvEuUE4VXXcE0mN5Pucr0dG+0BQFES34BxQi
	Y4XpVYnsrdYrP0PyciVMS++N/9KU=
X-Google-Smtp-Source: AGHT+IHky1OvgLHwzwgiLW/QNIajFXu1TBxWI4HEOm7TpfDRvYiij2GU3eyxjDv2GEFkYwJe1zG3oZP6GKeX5/y0ZtE=
X-Received: by 2002:a17:90b:1809:b0:2e0:7b03:1908 with SMTP id
 98e67ed59e1d1-2eaaa78b464mr5012734a91.10.1732025123370; Tue, 19 Nov 2024
 06:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007132555.GA53279@francesco-nb> <20241112075958.GA8092@francesco-nb>
 <20241112092054.GA18139@francesco-nb> <CAA+D8AO3a5WsZ4=V-9CDifDZYjJjwQmQQDDQM7ZKgZ6_-CNDPA@mail.gmail.com>
 <Zzde9xS0zGJhcoUb@gaggiata.pivistrello.it> <CAA+D8AMx14hp51aH7Y=Sgu+X+_KxQ8zdJdrQHFY84nKtQsKKrw@mail.gmail.com>
 <20241119112201.GA17768@francesco-nb>
In-Reply-To: <20241119112201.GA17768@francesco-nb>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 19 Nov 2024 08:05:12 -0600
Message-ID: <CAHCN7x+AU9-xiZo4-Lu2A_0M5XaEYgYtQbumFkmpvJ2AAbj0rg@mail.gmail.com>
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on v6.12
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Mark Brown <broonie@kernel.org>, 
	ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 5:22=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> Hello Shengjiu,
>
> On Tue, Nov 19, 2024 at 05:35:36PM +0800, Shengjiu Wang wrote:
> > On Fri, Nov 15, 2024 at 10:47=E2=80=AFPM Francesco Dolcini <francesco@d=
olcini.it> wrote:
> > >
> > > On Fri, Nov 15, 2024 at 11:13:58AM +0800, Shengjiu Wang wrote:
> > > > On Tue, Nov 12, 2024 at 5:20=E2=80=AFPM Francesco Dolcini <francesc=
o@dolcini.it> wrote:
> > > > >
> > > > > On Tue, Nov 12, 2024 at 08:59:58AM +0100, Francesco Dolcini wrote=
:
> > > > > > On Mon, Oct 07, 2024 at 03:25:55PM +0200, Francesco Dolcini wro=
te:
> > > > > > > it seems that an old regression is back on v6.12, reproduced =
on -rc2
> > > > > > > (not sure about rc1).
> > > > > > >
> > > > > > > The original report is from https://lore.kernel.org/all/20240=
424164725.GA18760@francesco-nb/
> > > > > > > and it was fixed with https://lore.kernel.org/all/1715396125-=
3724-1-git-send-email-shengjiu.wang@nxp.com/.
> > > > > > >
> > > > > > > Is it now back?
> > > > > >
> > > > > > I was able to reproduce this issue once more, this time with 6.=
11.7.
> > > > > > As I wrote in another email the issue is not systematic as it u=
sed to
> > > > > > be.
> > > > > >
> > > > > > Any idea?
> > > > >
> > > > > Frank, Shengjiu, could it be that the udelay(5) in imx_pgc_power_=
up() is
> > > > > too short and therefore we have such non-systematic failures?
> > > > >
> > > >
> > > > Francesco,  it seems hard to reproduce it on my i.MX8MP-EVK board.
> > > >
> > > > If it is easy to reproduce on your side, you can try to enlarge the=
 delay
> > > > time to see if there is any improvement.
> > >
> > > It's hard also for me to reproduce, we just have a relatively extensi=
ve
> > > test farm and 2 times it happened while doing unrelated tests. I was =
hoping we
> > > could have some idea on what's going on, I'll see if I can put togeth=
er some
> > > kind of stress test, being able to reproduce it more systematically w=
ould
> > > certainly help.
> > >
> >
> > With my test,  the issue reproduced with delay 5us/6us. but hard reprod=
uced
> > with 7us.
> > I think we may need to use a delay of 10us for safety.
>
> Great that you were able to narrow this down and confirm the issue.
> I wonder if you would have any information on what is the actual delay
> that the HW would need, instead of guessing numbers. If not, well, let's
> go with 15usec, or 10usec, your call in the end.
>
> Will you send a patch?

Peng (or anyone from NXP),

Do any of the clock speeds have an impact on the propagation time?
If the clocks are running at overdrive speeds vs nominal speeds vs
underclocked, could this time be adjusted accordingly somehow?

adam

>
> Francesco
>


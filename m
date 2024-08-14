Return-Path: <linux-kernel+bounces-286812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09152951F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362D41C22E09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4E01B86C1;
	Wed, 14 Aug 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WcngHzte"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590A1B5830
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651261; cv=none; b=krYsF+FRT2Opi9tI4P7Uj68IsRzz+Uu/45Rshu0RljEVWD90FkFmfLDR4+n/XE6E1niod6mVpvga0L9hB+bkBJgP3J5yKKDYAa9AsaYtpQu2WuHxmqoSEzmdiltjTB0dR49hk7jIFTgUaCl8BjJZNaSGmgC/wR8TveeBcMxMhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651261; c=relaxed/simple;
	bh=oLlx8kbXtgT1+h98Q08HClm2cRfuDS4Jxg7GijXyT84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp4MMNi+WByOBj62kueGxprijQH96fPXQ3ImUqz8k4LdWlkam044LIgpcz+1xkpeOVONxKWANEfts7HLzm2KId3loPcUb5Hl3Bjfnm8bg845jZX+QYokjpal/3TGGtczMY+BD52k7/tJSYDKfBjVMmGuGrD5n2i3Us2Y63v+qIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=WcngHzte; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bd1a9bdce4so101186a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723651258; x=1724256058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6hg5lhUPiTHteMjAtZ4DGZhyCZPAhbUKp0ZDVO35ys=;
        b=WcngHzte7z2+0R8yahuC+jagCozgcKZBz8zLuPzWiXPuLIWoK6gVjbWjADmeL578G/
         2402+EBakHEp2IEmwNwB4iyZYK50ImqQzKwFANBOBgBTLdRD8gRq1pj7gsGQ+aTqptFy
         7YbRfsxuiBYRyCf/oDVqgjX7VCmtq6vdXstyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651258; x=1724256058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6hg5lhUPiTHteMjAtZ4DGZhyCZPAhbUKp0ZDVO35ys=;
        b=CtuK2QAj8GGqlUFQsJt9RdrCNbfpGLQrIzvsa2PlOMUpC1PMZoBzbpAj1CSP88Ibbm
         mucStVQw9rh4HUR1Q0JL4AiJRpafhGWQvM1w85JPjZijeAULyu+1zfPQ+22kATZSVIak
         u1Uy5mraKzmZVlRAmax9baO7LeJd9Ql/irQd2kvwOSNtDNvGDXvG+aL5hePjaJDNWxl2
         Gxfp8MVfTQM1f5EfoO4zEEGlFqIPBMCegC0QIw+yNx+jnV7p0cP5PdOzW9WuaYYFWvN0
         gjevn/FlKE85SeHF516RPLwIU7c2iBoXXY+5lhjNTsLFhKV7QDyzliEZQby2FTJkFa9F
         YP4g==
X-Forwarded-Encrypted: i=1; AJvYcCXYcmlKgNQOwhLzApuKhIGsCbhC7jIkhDH3+4y2JtTq1xQ05Xiafwum01nKzgRJ3xXxqeqmzCpquParIul1DVHSDgdYCrnaS19LmvMb
X-Gm-Message-State: AOJu0YwXDhRommhZF/MFODeIR8p7GqizcTgOdyOcKhU3e2GB3HN3GtoI
	X9IYLxOc74NdWvSGN2UA033kEzN1PiJkMVLZcQJghY0jjLPz401zVVtAKEEhRUyrGV+zDMtK22L
	PF7AZzavq4ia/r3fuNQ9tP4hyA61uu+BXSJnMmA==
X-Google-Smtp-Source: AGHT+IENFPXzmHmrz8jSJ8HsNlXGesQUoIAVxwoQN1tYtA8UozxZmzLthTqj7kIZyclRgdiVGC4awwo51S3E9XX+6KU=
X-Received: by 2002:a17:907:e616:b0:a7a:8378:625c with SMTP id
 a640c23a62f3a-a8366d45bebmr216496766b.36.1723651258158; Wed, 14 Aug 2024
 09:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220605165703.1565234-1-michael@amarulasolutions.com>
 <20220605165703.1565234-3-michael@amarulasolutions.com> <5f34b6d6-c2dd-44f9-c1bc-fe1deb336334@gmail.com>
In-Reply-To: <5f34b6d6-c2dd-44f9-c1bc-fe1deb336334@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 14 Aug 2024 18:00:47 +0200
Message-ID: <CAOf5uwm3p5AJXL9w7hQtqz05hDpQ_-CQArm0z6kAehj7OxK1Mw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] clk: bd718x7: Enable the possibility to mark the
 clock as critical
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, linux-amarula@amarulasolutions.com, 
	Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen

On Mon, Jun 6, 2022 at 7:26=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
>
> Hi Michael,
>
> On 6/5/22 19:57, Michael Trimarchi wrote:
> > If the clock is used to generate the osc_32k, we need to mark
> > as critical. clock-critical has no binding description at the moment
> > but it's defined in linux kernel
> >
> > bd71847: pmic@4b {
> > ...
> >       rohm,reset-snvs-powered;
> >
> >       #clock-cells =3D <0>;
> >       clock-critical =3D <1>;
> >       clocks =3D <&osc_32k 0>;
> >       clock-output-names =3D "clk-32k-out";
> > ...
> > }
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >   drivers/clk/clk-bd718x7.c | 4 ++++
>
> //snip
>
> > @@ -100,6 +101,9 @@ static int bd71837_clk_probe(struct platform_device=
 *pdev)
> >
> >       parent_clk =3D of_clk_get_parent_name(parent->of_node, 0);
> >
> > +     of_clk_detect_critical(dev->of_node, 0, &flags);
>
> Purely judging the kerneldoc for of_clk_detect_critical - you may have
> hard time getting this accepted.
>
> I think you're working on a very valid problem though. Maybe you could
> see if you could align your effort with Marek?
>
> https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d=
6d0831bf43d5f293e35cb27f3021f278d0564
>

Old thread but same problem. Is there any way to make this acceptable?
any suggestion?

Michael

> Best Regards
>         -- Matti
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
> Discuss - Estimate - Plan - Report and finally accomplish this:
> void do_work(int time) __attribute__ ((const));



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com


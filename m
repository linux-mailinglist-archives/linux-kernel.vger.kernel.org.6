Return-Path: <linux-kernel+bounces-343993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E098A249
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06C51F248D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326FB18EFCB;
	Mon, 30 Sep 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="Y4Fm/HNT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C218BBB9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698929; cv=none; b=eY1kqAysxvj1P3Q8OAELxrLU1R/ScvTaF9oehekjqc48u+FJl7kXvOuHvN9McnJ3aYE5ONmxuC7x5qngEy7BxU9yjweArKW31BOSI+5fu6Rr2u351musunxQoKOfqnS+GCFRsT231Eb3sklr3qFYjF4sLE8W/n4t/ZApCVfd7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698929; c=relaxed/simple;
	bh=oVy0k0RRSey0HXyF2tOTq4T5kQb2eUiQ/yuwu9KTSQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGMxy7hE/vV84nTGgIYT4KGk2JCjgyxB9xLDgB1bCk4HBAHHKIwI1dmuBIa2STpFCxU3RFDnwjc3DFTixl7FuHHB6ImTSXW+zMjSYWdKCkaFcCr6qwUyt6zNOq89EHScgKLU61kIE0WC/+qBuL51+hHn85xRtKZVTO9I4ZuV04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=Y4Fm/HNT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c89bdb9019so1000501a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1727698925; x=1728303725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVy0k0RRSey0HXyF2tOTq4T5kQb2eUiQ/yuwu9KTSQ0=;
        b=Y4Fm/HNTCF7qDGLnOkFZwJpEfI5aA/NnPik/nhvhkfyVoJLawT1wUmFuSK/UAagTd2
         sGBkoU+7OgVKxjXwvplp+1a9/X3KjQA6TtyCOb5YfFMx/EBT+QQGUMhNzhr67LhqZUnJ
         c3pcoLjNyfJ49BaRheujq5WhyNmA60r32NRyOc/VnY8bm+9QIAmPnQWys577ZzsxZW+7
         L6FpQT498oyMcCOUVeldnNWs6xHJYTmMk7L2NEDBciBV7OMdj34/Z/7gLtrxPRTcmdOS
         M3QlOLPO/8odQG0YG2c67xGtteapHOjZX2PIdD3oaEBpPgY36KwWCyoluyNUwwGk0ybZ
         I0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727698925; x=1728303725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVy0k0RRSey0HXyF2tOTq4T5kQb2eUiQ/yuwu9KTSQ0=;
        b=qX5jd4F5JoIBwz/E9AcXKPpSi9P6qame9Imk0P9mLqD01PL+0tOG7HbDFSolKpJSX1
         hugwFzL5Kqeivo3iUuW74K9vNFIGgPtukRl43NXd5PMLwaVQ+YYEfDvD2RB97c84G/rf
         UZv9v0QCJUskZ49eSVKVStUx3ng4ojQRYXcORsfYfkEAfoeBEFZoANTp2bgoB/yUmQpB
         z4fewMZCLqdrln5K81CAuyw9zO21fUhgc6soCUtaeAxSvb80SjT/E2fvM/hJs/CZGpnM
         wne2AmFDUC+MUMUkfHoOIFumenG74O7Mftp6wSu7mrB7sYB+c3VklxBs6s8Nm+c5LTSI
         UIRA==
X-Forwarded-Encrypted: i=1; AJvYcCXVt6TgaC7PJryv1Gg4DtUoWJkUosliZScpimDI/H96p9nMHXuiTT6zXBRxFZN528mwn1pXKz1KEeTdhUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3hnTCyLC7diragyW9uZoTkMagujSCZZm0MB6U+TtK16Qe7eg
	kxzZrRGYsWfw2BOLr81wX1SOCZ8xTniTFDaEBGmMhDEwXDtyAKhdbZ/GLSbvL0/G8KeN0hbPh7G
	HENzyf0dSmEhYOqbKNnY/aIAP00qQsNbRB+luhA==
X-Google-Smtp-Source: AGHT+IFRR/TqePx6m+P0F9wbjhdBYthJDFoxfhNspbc/S91fiILEYhQubKca8iEPPBq2sCP6d+bbteglymX0AAL2fYc=
X-Received: by 2002:a17:907:7f22:b0:a91:561:e7d8 with SMTP id
 a640c23a62f3a-a93c4c269c9mr1388845366b.61.1727698924559; Mon, 30 Sep 2024
 05:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925072945.18757-1-dse@thaumatec.com> <4620941.LvFx2qVVIh@diego>
 <5f73e2cf-cb18-4b65-9e42-cf3192aee706@cherry.de> <2221314.irdbgypaU6@diego>
In-Reply-To: <2221314.irdbgypaU6@diego>
From: Daniel Semkowicz <dse@thaumatec.com>
Date: Mon, 30 Sep 2024 14:21:53 +0200
Message-ID: <CAHgnY3nmx=jpg-+OTmQ4ovgWOPCsX5LrYXJQqzpDeb67ZoVsMw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add power button for RK3399 Puma
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Dragan Simic <dsimic@manjaro.org>, Farouk Bouabid <farouk.bouabid@theobroma-systems.com>, 
	Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:21=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.d=
e> wrote:
>
> Am Montag, 30. September 2024, 11:11:56 CEST schrieb Quentin Schulz:
> > Hi Heiko,
> >
> > On 9/30/24 10:49 AM, Heiko St=C3=BCbner wrote:
> > > Hey Quentin, Daniel,
> > >

Hello Heiko, Hello Quentin,

> > > Am Donnerstag, 26. September 2024, 14:34:30 CEST schrieb Quentin Schu=
lz:
> > >> On 9/25/24 9:28 AM, Daniel Semkowicz wrote:
> > >>> There is a PWRBTN# input pin exposed on a Q7 connector. The pin
> > >>> is routed to a GPIO0_A1 through a diode. Q7 specification describes
> > >>> the PWRBTN# pin as a Power Button signal.
> > >>> Configure the pin as KEY_POWER, so it can function as power button =
and
> > >>> trigger device shutdown.
> > >>> Add the pin definition to RK3399 Puma dts, so it can be reused
> > >>> by derived platforms, but keep it disabled by default.
> > >>>
> > >>> Enable the power button input on Haikou development board.
> > >>>
> > >>> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
> > >>
> > >> This works, thanks.
> > >>
> > >> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >>
> > >> Now I have some questions I wasn't able to answer myself, maybe some=
one
> > >> can provide some feedback on those :)
> > >>
> > >> We already have a gpio-keys for buttons on Haikou, c.f.
> > >> https://elixir.bootlin.com/linux/v6.11/source/arch/arm64/boot/dts/ro=
ckchip/rk3399-puma-haikou.dts#L22.
> > >> Those signals are directly routed to the SoM and follow the Qseven s=
tandard.
> > >>
> > >> The same applies to PWRBTN# signal.
> > >>
> > >> However, here we have one gpio-keys for PWRBTN# in Puma DTSI and one
> > >> gpio-keys for the buttons and sliders on Haikou devkit in Haikou DTS=
.
> > >>
> > >> I'm a bit undecided on where this should go.
> > >>
> > >> Having all button/slider signals following the Qseven standard in Pu=
ma
> > >> DTSI and enable the gpio-keys only in the devkit would make sense to=
 me,
> > >> so that other baseboards could easily make use of it. However, thing=
s
> > >> get complicated if the baseboard manufacturer decides to only implem=
ent
> > >> **some** of the signals, for which we then need to remove some nodes
> > >> from gpio-keys (and pinctrl entries) since gpio-keys doesn't check t=
he
> > >> "status" property in its child nodes (though that could be fixed). A=
t
> > >> which point, it's not entirely clear if having it in Puma DTSI is
> > >> actually beneficial.
> > >>
> > >> Someone has an opinion/recommendation on that?
> > >
> > > I guess from a platform perspective nobody really cares, so as that i=
s
> > > "your" board, it comes down to a policy decision on your part ;-) .
> > >
> > > While pins follow the q7 standard, there may very well be some lax
> > > handling of that standard in some places, and I guess gpio lines coul=
d
> > > be re-used for something else if needed, as something like the lid-sw=
itch
> > > is probably non-essential.
> > >
> > > Also a gpio-key input does not create that much code-overhead if
> > > replicated, so personally I'd just stick the power-button with the ot=
her
> > > buttons in the haikou dts.
> > >
> > > Which is also a way better thing than having multiple gpio-keys insta=
nces
> > > that userspace then has to handle.
> > >
> >
> > Yes, but this also means "code" duplication for whoever needs this for
> > their baseboard, instead of just having to add a &gpio_keys { status =
=3D
> > "okay"; }.
>
> Yes :-) .
>
> gpio-keys is special in a way in that you could end up with a different s=
et
> of enabled keys per baseboard - dependent on how closely it follows the
> standard.
>
> So if someone repurposed the lid-switch only, you'd start changing the
> core node again. Hence for the gpio-keys it's probably easier to define
> the set of keys in the baseboard.
>
> It's of course different for regulator-infrastructure and such.
>
> > I don't think there's a good solution here, so I would suggest we go
> > with everything in Haikou's gpio-keys as Heiko suggested then, @Daniel
> > if you agree can you send a v2 for that?

I'm fine with that. I will prepare v2 with such change.

>
> I'll wait for v2 then.
>
> Heiko
>
>

Kind regards
Daniel


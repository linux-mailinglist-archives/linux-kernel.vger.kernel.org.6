Return-Path: <linux-kernel+bounces-343668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8511989DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1345E1C21F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6F18787B;
	Mon, 30 Sep 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1WGSQNrl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC017C8B;
	Mon, 30 Sep 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688111; cv=none; b=Nz7tL5wb1ZeCpZ46UK+erbejfdjYLLP7P9mocgQc9yW3yv7XqobX4hNsyvkTq0sYTmT+oy66rULBekL5IPONiPXyAJy2AyAq6BEY3Px4QR2AYbsTv2K6TsgrBOch4Vo5q/HNFan0j3oo7CUQncLo0hEGBtyB/xYpzqVjANCg1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688111; c=relaxed/simple;
	bh=dWLqrkPN5YAJbpjHClBIUqfBaHM5NfV7gkZ78U7b10Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0MIq88WuUsmyMWbIknOQ6Oh3vWUYVyWPNdOcs3YBEj1pt7zkr9szx676VlIAEKKzj6TrXGkNfNuK6sVSWPEUCalwTUAg9A5tfHrEU7yCt2mF2M6Pbr6YDJvxTJEzrs9irg+3gbbEbuuUvSrQG4QSH+uaGYibLqL4gybw6Fs2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1WGSQNrl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dWLqrkPN5YAJbpjHClBIUqfBaHM5NfV7gkZ78U7b10Q=; b=1WGSQNrlSi38frUwsI7zzj9YIZ
	3yYHX8zJCI0L+TI7ojJp4JfKgnayTgXtxc10NQLNgnBXuJxJRWZvmFPQwwH9Zkt0IlpKk/OJubjYu
	Nei9o/0J5Zut4Gti1jfXhJTJ6UVKAdddOWyBZpX8PYLd7punbcX2piveEKvWjWhQVKzXktXxAN2zT
	zcxLlNrUK9roySJEvlDBz4TDoaINpQCkHR75i3/SqcHuuu3XJXQ7trrkLXiZlSvI3v1zwPO8Rk55g
	c1lnyErwpbN6lzI3YAtDLRTQsz0geQiEuzYt9bEd+vgJaDBjcEindcvPM0lpm2hS+mdM/nLdpHgMy
	LToe0gOQ==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svCb9-00041j-Mz; Mon, 30 Sep 2024 11:21:43 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Daniel Semkowicz <dse@thaumatec.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add power button for RK3399 Puma
Date: Mon, 30 Sep 2024 11:21:42 +0200
Message-ID: <2221314.irdbgypaU6@diego>
In-Reply-To: <5f73e2cf-cb18-4b65-9e42-cf3192aee706@cherry.de>
References:
 <20240925072945.18757-1-dse@thaumatec.com> <4620941.LvFx2qVVIh@diego>
 <5f73e2cf-cb18-4b65-9e42-cf3192aee706@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 30. September 2024, 11:11:56 CEST schrieb Quentin Schulz:
> Hi Heiko,
>=20
> On 9/30/24 10:49 AM, Heiko St=FCbner wrote:
> > Hey Quentin, Daniel,
> >=20
> > Am Donnerstag, 26. September 2024, 14:34:30 CEST schrieb Quentin Schulz:
> >> On 9/25/24 9:28 AM, Daniel Semkowicz wrote:
> >>> There is a PWRBTN# input pin exposed on a Q7 connector. The pin
> >>> is routed to a GPIO0_A1 through a diode. Q7 specification describes
> >>> the PWRBTN# pin as a Power Button signal.
> >>> Configure the pin as KEY_POWER, so it can function as power button and
> >>> trigger device shutdown.
> >>> Add the pin definition to RK3399 Puma dts, so it can be reused
> >>> by derived platforms, but keep it disabled by default.
> >>>
> >>> Enable the power button input on Haikou development board.
> >>>
> >>> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
> >>
> >> This works, thanks.
> >>
> >> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> Now I have some questions I wasn't able to answer myself, maybe someone
> >> can provide some feedback on those :)
> >>
> >> We already have a gpio-keys for buttons on Haikou, c.f.
> >> https://elixir.bootlin.com/linux/v6.11/source/arch/arm64/boot/dts/rock=
chip/rk3399-puma-haikou.dts#L22.
> >> Those signals are directly routed to the SoM and follow the Qseven sta=
ndard.
> >>
> >> The same applies to PWRBTN# signal.
> >>
> >> However, here we have one gpio-keys for PWRBTN# in Puma DTSI and one
> >> gpio-keys for the buttons and sliders on Haikou devkit in Haikou DTS.
> >>
> >> I'm a bit undecided on where this should go.
> >>
> >> Having all button/slider signals following the Qseven standard in Puma
> >> DTSI and enable the gpio-keys only in the devkit would make sense to m=
e,
> >> so that other baseboards could easily make use of it. However, things
> >> get complicated if the baseboard manufacturer decides to only implement
> >> **some** of the signals, for which we then need to remove some nodes
> >> from gpio-keys (and pinctrl entries) since gpio-keys doesn't check the
> >> "status" property in its child nodes (though that could be fixed). At
> >> which point, it's not entirely clear if having it in Puma DTSI is
> >> actually beneficial.
> >>
> >> Someone has an opinion/recommendation on that?
> >=20
> > I guess from a platform perspective nobody really cares, so as that is
> > "your" board, it comes down to a policy decision on your part ;-) .
> >=20
> > While pins follow the q7 standard, there may very well be some lax
> > handling of that standard in some places, and I guess gpio lines could
> > be re-used for something else if needed, as something like the lid-swit=
ch
> > is probably non-essential.
> >=20
> > Also a gpio-key input does not create that much code-overhead if
> > replicated, so personally I'd just stick the power-button with the other
> > buttons in the haikou dts.
> >=20
> > Which is also a way better thing than having multiple gpio-keys instanc=
es
> > that userspace then has to handle.
> >=20
>=20
> Yes, but this also means "code" duplication for whoever needs this for=20
> their baseboard, instead of just having to add a &gpio_keys { status =3D=
=20
> "okay"; }.

Yes :-) .

gpio-keys is special in a way in that you could end up with a different set
of enabled keys per baseboard - dependent on how closely it follows the
standard.

So if someone repurposed the lid-switch only, you'd start changing the
core node again. Hence for the gpio-keys it's probably easier to define
the set of keys in the baseboard.

It's of course different for regulator-infrastructure and such.

> I don't think there's a good solution here, so I would suggest we go=20
> with everything in Haikou's gpio-keys as Heiko suggested then, @Daniel=20
> if you agree can you send a v2 for that?

I'll wait for v2 then.

Heiko




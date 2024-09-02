Return-Path: <linux-kernel+bounces-311418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B68C9688EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FBF286831
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190CF20FAB5;
	Mon,  2 Sep 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="qHQCAU+G"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0242139D7;
	Mon,  2 Sep 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283934; cv=none; b=rgjM8uhk0BZje+/CoZLPJfLZdAMHxwR0ob0ujAoSEb2HjaAAeIP6dKtPDnSrCIC+tMULwEUL60Wq2dT5I1d0AllWg39GLC1H1vc2ePIECxBmvEgF/tZxvj490ZoD6BmQid/Pi7XB00PGv6/b5aiwL9VRbqSy88T0MPBS2/wXctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283934; c=relaxed/simple;
	bh=RxBAlD4Bmy7Hb1bcAu9RLBPtaYpWhDz4yd1KvfnADhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N7GeS56dtasWhVyp2JTIHmv4FYHR+ZweEcL9tNOZ9dqkTn7hVPo3uFUlxhKozUKag6AhEbqaipR0qwf91sGwW5gVzP3opvOLk5ZDYGbYz0bsCm+xNFhn9qktIDZNDzwWjRIFHJtXLLUWAVltb1r0O17GZgU8uaorsmzJt0hGXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=qHQCAU+G; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 801FF614BA;
	Mon,  2 Sep 2024 16:32:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xVaJQFSb2Sw0-lrFnftlD;
	Mon, 02 Sep 2024 16:31:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1725283919; bh=RxBAlD4Bmy7Hb1bcAu9RLBPtaYpWhDz4yd1KvfnADhY=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=qHQCAU+GMDC2B5xoDTjogKJ5OtVR4HVOSqypeP5rbl65yW1S4r1y2lILiRlDuOf5X
	 H0DQ/9a4e2USKKzRMhnVgEVnpwGERYoJHNZJrkCv/nYV7E8RyNE7YY3qKEsjoBBcnn
	 Vpz+c7e+K24K/9AwneB37oi7AQUlCR2+REMk7N2Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <cf18eef44460da71db7e125d91da22f0a78c0375.camel@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date: Mon, 02 Sep 2024 16:31:59 +0300
In-Reply-To: <79cb209c6c5a14ae4d6a015f714c58d4.sboyd@kernel.org>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
	 <20240715-ep93xx-v11-3-4e924efda795@maquefel.me>
	 <020c15c9939c1c4cfac925942a582cee.sboyd@kernel.org>
	 <a87f99e02f3e9c40c8b9638a8a5a9c5b55aca68c.camel@maquefel.me>
	 <79cb209c6c5a14ae4d6a015f714c58d4.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 15:27 -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin (2024-08-30 02:23:12)
> > Hello Stephen!
> >=20
> > On Wed, 2024-08-28 at 13:44 -0700, Stephen Boyd wrote:
> > > Quoting Nikita Shubin via B4 Relay (2024-07-15 01:38:07)
> > > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > > index 3e9099504fad..234b0a8b7650 100644
> > > > --- a/drivers/clk/Kconfig
> > > > +++ b/drivers/clk/Kconfig
> > > > @@ -218,6 +218,14 @@ config COMMON_CLK_EN7523
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver =
provides the fixed clocks and gates
> > > > present
> > > > on Airoha
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM silicon.
> > > > =C2=A0
> > > > +config COMMON_CLK_EP93XX
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Clock driver for Cirrus=
 Logic ep93xx SoC"
> > >=20
> > > tristate?
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_EP93XX || COM=
PILE_TEST
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select MFD_SYSCON
> > >=20
> > > Why is this selecting syscon?
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select REGMAP
> > >=20
> > > Is this needed either?
> >=20
> > Indeed REGMAP is selected by COMMON_CLK, MFD_SYSCON not required,
> > but
> > it needs AUXILIARY_BUS.
>=20
> I don't see REGMAP selected by COMMON_CLK. Did I miss something?

Indeed REGMAP is selected by COMMON_CLK_MESON_REGMAP not COMMON_CLK on
make tinyconfig + COMPILE_TEST.

Then we require REGMAP because we are using regmap_read() in clk
driver.

>=20
> >=20
> > > > +#define
> > > > devm_ep93xx_clk_hw_register_fixed_rate_parent_data(dev,
> > > > name, parent_data, flags, fixed_rate)=C2=A0 \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __clk_hw_register_fixed_rate(=
(dev), NULL, (name), NULL,
> > > > NULL, \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (pare=
nt_data), (flags),
> > > > (fixed_rate), 0, 0, true)
> > >=20
> > > Is this to workaround a missing
> > > devm_clk_hw_register_fixed_rate_parent_data() macro?
> >=20
> > Yes, if it's okay - i'll fire next revision, all other comments are
> > acknowledged.
> >=20
>=20
> Can you add the macro so others can use it in another patch?

Sure.



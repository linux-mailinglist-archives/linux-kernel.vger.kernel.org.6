Return-Path: <linux-kernel+bounces-308430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE4965CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489BE1C23BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A9170A0B;
	Fri, 30 Aug 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="AWpCSttH"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E614EC4C;
	Fri, 30 Aug 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010126; cv=none; b=bBUDRlIi8xa1YYbaq9FgQxRM8yhKn81kEYuQLn7ybnEqGSX0xRLtlqMOFvTdEkQ8uWQeuxQgYa+idyXpwCJKdiHi6yIcBVVuC18qTXM6FtGYBhqkXOZ/ifnP9MIi3B+rGqzdjKShLZGJeNmx8CZigjaM51uNrVjWRgza8XLY2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010126; c=relaxed/simple;
	bh=WsV1b5ThaBZkj8j8y5rouTEePe04DGKldkObRJW1Wa4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4ZX/iVNDV7EJMxy5HV1jA7R5mCBPJeLZ9FUdpel7dXH5Q8Rl53ksBUZ8CVtwtQ/dG8OwPXCPB1glljGsNGcABDy1huKAF2bSI1tLCFiMYG1hnpqsPqSd5uhvWy65Jsq0Zy8l2LoHAQjo+AOoss/SDLRXj++CDXtY/w6WrOl6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=AWpCSttH; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:89:0:640:35fc:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 196BC60F3A;
	Fri, 30 Aug 2024 12:23:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BNTh1mHV00U0-WuR47Q81;
	Fri, 30 Aug 2024 12:23:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1725009791; bh=WsV1b5ThaBZkj8j8y5rouTEePe04DGKldkObRJW1Wa4=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=AWpCSttHEmUUzTncQdnxmDE3ufYnxNBk47779oin8ROB8PmuBMtcGMPdjlODV2/YQ
	 TQlx9ggf23muaaEx9NweyW8hpCAbsMTfaUh++4TuxfhysLGX9GXSmNWcm2kZcKiiVw
	 CD0ZBR3sue66LG3LcIVQubHvIld/fsqWl+4OlZvE=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <a87f99e02f3e9c40c8b9638a8a5a9c5b55aca68c.camel@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date: Fri, 30 Aug 2024 12:23:12 +0300
In-Reply-To: <020c15c9939c1c4cfac925942a582cee.sboyd@kernel.org>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
	 <20240715-ep93xx-v11-3-4e924efda795@maquefel.me>
	 <020c15c9939c1c4cfac925942a582cee.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Stephen!

On Wed, 2024-08-28 at 13:44 -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin via B4 Relay (2024-07-15 01:38:07)
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 3e9099504fad..234b0a8b7650 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -218,6 +218,14 @@ config COMMON_CLK_EN7523
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver prov=
ides the fixed clocks and gates present
> > on Airoha
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM silicon.
> > =C2=A0
> > +config COMMON_CLK_EP93XX
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Clock driver for Cirrus Log=
ic ep93xx SoC"
>=20
> tristate?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_EP93XX || COMPILE=
_TEST
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select MFD_SYSCON
>=20
> Why is this selecting syscon?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select REGMAP
>=20
> Is this needed either?

Indeed REGMAP is selected by COMMON_CLK, MFD_SYSCON not required, but
it needs AUXILIARY_BUS.

> > +#define devm_ep93xx_clk_hw_register_fixed_rate_parent_data(dev,
> > name, parent_data, flags, fixed_rate)=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __clk_hw_register_fixed_rate((dev=
), NULL, (name), NULL,
> > NULL, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (parent_=
data), (flags),
> > (fixed_rate), 0, 0, true)
>=20
> Is this to workaround a missing
> devm_clk_hw_register_fixed_rate_parent_data() macro?

Yes, if it's okay - i'll fire next revision, all other comments are
acknowledged.





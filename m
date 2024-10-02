Return-Path: <linux-kernel+bounces-347315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7354098D0E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4ADB224BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C911E6DD7;
	Wed,  2 Oct 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="X15MMLxH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6F1E6325;
	Wed,  2 Oct 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863939; cv=none; b=btupOAI2GNQxRW1Qtk3UJi5UGdRB+wiPBkQp3uccijjU35NQSLellZmeZw5iDzrp8EbqQw6v0Yo6Zcw41ILJSA9wHJ85EpQU2ehzAMKOot+WqpDjgTHYIHasDn9vC2dRAF7pN6rrVTWbP9BGAADyBhlM4FCikz6bMWgwhN7vg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863939; c=relaxed/simple;
	bh=JwhzVDZBNjGUfu++mGGFURZdzqhlb44Qh8znmFHlVD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgK74rm4nJi+zZWa00VLN115q3BoOJ7Wxz1QTtlXA8l9cttKvgWHJM6y5ghDKeoVc7nmND2y26l3F98OrCKQzGYbkcutNnHZkn+KcRT5RfontlJFTRWxm5h/wYahsC5p/XZGfuNtGL6Oy9guMga1N08JkhGxgZb63MhyEy/fQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=X15MMLxH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JwhzVDZBNjGUfu++mGGFURZdzqhlb44Qh8znmFHlVD4=; b=X15MMLxHC2hJRWot0HCHmSPS8U
	EZULsRX4yVnovppXgWmHJkK/fIwxZ/sjz6fnRas8Z6/e/Ls9NL0+8Hxib1mXWA/N5+/9Ho0a/si6b
	ssRC8gxYzz/eQaldK3zoF0xlXZ2/K0r7M4J4xfiijtBF2Rp4Zq1xE395SGAC/iuAbI/Ap9Gsoehku
	pv1sRprdMEYk+nypJeRWs8V8BKZCWy+tYDWxeAvLwWEGh9uDIfcoFtMy3uxxsQVnvF6kZhg3W6YZ5
	ETWO+pSOkGlKB4JPaGxUZ0Ozf/vDFNxchzo/Tlvx1rF0cev/zNxoPiSFzrpG70zD7al0EWti1hQiO
	aD3bJNWQ==;
Received: from i53875aa1.versanet.de ([83.135.90.161] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svwL6-0004tJ-Fk; Wed, 02 Oct 2024 12:12:12 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Yao Zi <ziyao@disroot.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 4/8] clk: rockchip: Add PLL flag ROCKCHIP_PLL_FIXED_MODE
Date: Wed, 02 Oct 2024 12:12:11 +0200
Message-ID: <3798659.MHq7AAxBmi@diego>
In-Reply-To: <Zv0blIPaF0Y2Pmn1@pineapple>
References:
 <20241001042401.31903-2-ziyao@disroot.org> <8495918.NyiUUSuA9g@diego>
 <Zv0blIPaF0Y2Pmn1@pineapple>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 2. Oktober 2024, 12:08:20 CEST schrieb Yao Zi:
> On Wed, Oct 02, 2024 at 10:16:49AM +0200, Heiko St=FCbner wrote:
> > Hi,
> >=20
> > Am Dienstag, 1. Oktober 2024, 06:23:58 CEST schrieb Yao Zi:
> > > RK3528 comes with a new PLL type, flagged by ROCKCHIP_PLL_FIXED_MODE,
> > > which should operate in normal mode only. Add corresponding definition
> > > and handle it in code.
> > >=20
> >=20
> > More commit message would be nice ;-) .
>=20
> Good idea.
>=20
> > It's the PPLL for the pcie controller that is specified in the manual to
> > only work in normal mode. This is helpful for people reading along :-) .
> >=20
> > Heiko
>=20
> btw, for the documentation, is there any technical reference manual
> of RK3528 available publicly? Please let me know if it's true, it will
> be quite helpful to understand clock tree better :)

Sadly not. So far there hasn't been a "leak" yet and Rockchip also seems
to have gotten more restrictive for whatever strange reason, so with my
NDA I also only got part1 of the manual.


Heiko




Return-Path: <linux-kernel+bounces-281094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E694D300
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595F4281D88
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C53F198A24;
	Fri,  9 Aug 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA916N8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD1198857;
	Fri,  9 Aug 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216281; cv=none; b=XSpRhOSNukvtEnK/Zg/1IE7cpifJPGl8rMeydl4gDk6SNhcg3VlCancjHmOAU4caQlAKeunr/xqRjIECzL9mpTX7vrqiTBaRyB0MWsUJYHJzt3DTZoYItDGSZtCFnw2DHIZaH1Z2dqhAK+xAAXN7qRk81FAmmlhH4esl8NmbY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216281; c=relaxed/simple;
	bh=9R2NKMWQqNjzvTm5mD4XvqzZMMa1bqVjqcONwMIe8jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzGVwDWO6qsqSqUEQThCycsyQYkwkadTNtu2RcOrViJNu6Ik77lTy84xGEmgcy0iDNQCFCCmcJPAiHNAsiKP7V31pSzKtplYlxHtpugwADHpxYyT5LQ2N6YU1HunWTO6e9qvSC7jwDxQDgh87wYNpGItyL6S0MAIPfd4mBvyUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA916N8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A1EC32782;
	Fri,  9 Aug 2024 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216281;
	bh=9R2NKMWQqNjzvTm5mD4XvqzZMMa1bqVjqcONwMIe8jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oA916N8+cz6JtAd2vkZQrKN8SOtpRD8xzIPTr5U6pnLuauUbaC9R/RoxRjtSS4hV8
	 iH6Wwprq8nIxom5cuoHT1SLJIHgbWD65BIXPp6HwEb7oNghQ8iOEK+Er+U6TxwoPfm
	 6bBMBEs7pLqJhyq6NUHNM1DAmUonza2nEU+M1i6pWx8+mFduBiXsRwIBbvzpzWdKir
	 zESSitKMvWzyaeyqZs5LIY9R6+ezaYv9W65q30aROIedzoLTVNdrM3NpLyZViJs86o
	 +6BWSdw86Hc1FKaGIlVF/ls4u7ZFP83eRce1A9kk6Zdlc8wB3z04c7M1ZQVZSVUuI9
	 a1ou+MexXVAww==
Date: Fri, 9 Aug 2024 16:11:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: Add rk3576 reset definitions
Message-ID: <20240809-retired-rug-517972cde092@spud>
References: <20240809125553.3889-1-detlev.casanova@collabora.com>
 <20240809125553.3889-2-detlev.casanova@collabora.com>
 <20240809-linoleum-ogle-ace67939d9a0@spud>
 <8409208.T7Z3S40VBb@trenzalore>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wCc8uvbAGo3F87mQ"
Content-Disposition: inline
In-Reply-To: <8409208.T7Z3S40VBb@trenzalore>


--wCc8uvbAGo3F87mQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 10:49:42AM -0400, Detlev Casanova wrote:
> On Friday, 9 August 2024 10:15:12 EDT Conor Dooley wrote:
> > On Fri, Aug 09, 2024 at 08:54:52AM -0400, Detlev Casanova wrote:
> > > Add reset ID defines for rk3576.
> > >=20
> > > Compared to the downstream bindings this uses continous gapless
> > > reset IDs starting at 1 instead of register offsets as IDs, as
> > > introduced in the RK3588 bindings.
> > > Thus all numbers are different between upstream and downstream,
> > > but names are kept exactly the same.
> > >=20
> > > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >=20
> > IMO squash this with the other binding patch.
>=20
> Yes, I wanted to but the issue is with the subject line: do I use "dt-
> bindings: reset+clock: [...]" in the squashed commit ?=20

Yeah, I guess you could do "dt-bindings: clock, reset:".

--wCc8uvbAGo3F87mQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYxkwAKCRB4tDGHoIJi
0u4bAQDbfTmaC6mGuyb1tOI8hRt4dtHfi1tdv+frSiGKKcg1PAD/SpuNV7bmfg5j
yQkal1bS7WmQ4ojLJiY1Fi2MYmCfAw8=
=0g09
-----END PGP SIGNATURE-----

--wCc8uvbAGo3F87mQ--


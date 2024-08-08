Return-Path: <linux-kernel+bounces-279685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B255294C073
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2C42885BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601A18FC6E;
	Thu,  8 Aug 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aEP+UHP3"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E018F2CA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129248; cv=none; b=m1MB/OVWWUi5VXjKOmc9xx2OPUogTzqjipN4Z9P3J8B+GpA3WtTJ7P64Zz21RwIs5ECmQWyqUizyRa7gLqJhNbYE9pKPLqhqNRn5yMzFbVo0LY5aDxt8/Ar4girKi8udKJQaSQA/H1Hd2BF4RddM3FUHOIaKnFy43GUS7PfXbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129248; c=relaxed/simple;
	bh=lcfbc8kqDOW5a9qjIc68nR/HZWnHBfFGHgWF4MQOB4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVDtpmaeQsqDePyybimfqXFxmxWM2kJhX/kWhLGszcpDXcmOcN7gdAvU6w/nFZQjGJ1fraKFFmNNMVNn9R/Ak7tSjw2/np0d6GpYN9LePqtZz0/F9jhIJb2EToJ6swCc+kGDb6kFijdlKreUCDjp6ztCyHCZTCVZfiuKB7q6ghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aEP+UHP3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lcfb
	c8kqDOW5a9qjIc68nR/HZWnHBfFGHgWF4MQOB4I=; b=aEP+UHP3Nw3R/DkswVWh
	kN9Gi2bacxwWnyQvjzdobGyrZOEPvMQCzAxtJAdxZrwW9kEz1NMYpZrfavaJqAGv
	dNkZvv9BCApGcEih1bWnj2Wl5DUuiKWKf+gDBsCHRtSvUH1vugkINBYKAKcifvGC
	Qf3hvi1jt6WxeRbYI5LdmYQ+GG2seQTc3P62czb14fyAMOERwHWSTGlLM0Xs1Gwp
	S7WTVrf5TghbgRKJFuDNys5tq0G2KdLMslZQgi1Ei/qC721m9L9UZpne6PYK6qlE
	s3s12m7cT5ddOtwEoL1TsatgBtRCUmErSxHPWsqyATxZEFADPJvorg43LnOPkn3O
	oA==
Received: (qmail 349538 invoked from network); 8 Aug 2024 17:00:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Aug 2024 17:00:43 +0200
X-UD-Smtp-Session: l3s3148p1@5kxsSi0fsCttKPBr
Date: Thu, 8 Aug 2024 17:00:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, p.zabel@pengutronix.de,
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 02/11] i2c: riic: Call pm_runtime_get_sync() when need
 to access registers
Message-ID: <ZrTdmqyzq_XLs5-z@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu <claudiu.beznea@tuxon.dev>, chris.brandt@renesas.com,
	andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240711115207.2843133-1-claudiu.beznea.uj@bp.renesas.com>
 <20240711115207.2843133-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zHX5K+jQW1p1NSJH"
Content-Disposition: inline
In-Reply-To: <20240711115207.2843133-3-claudiu.beznea.uj@bp.renesas.com>


--zHX5K+jQW1p1NSJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 02:51:58PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> There is no need to runtime resume the device as long as the IP registers
> are not accessed. Calling pm_runtime_get_sync() at the register access
> time leads to a simpler error path.
>=20
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Makes sense to me:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--zHX5K+jQW1p1NSJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAma03ZoACgkQFA3kzBSg
Kbb5pw//RIVxyNAUBcwrlJncjgwrkUYptK3TLARFEbJXKT1KwA0hcjPTIRi1f10O
PDmFPeMfm9hoFGWGCFkKm+5yhXIDpURMSei5lrqUcRTVl7U+ygQPtAYPsSJwayGS
nrDQDhAkMNyl9/NMtovm2I27bJ9u/OhzZY5XkKs5wP3Uw91/9J4G5SiZ8ovUOghR
9HuFHzaBgj8kf5XELQ8o2idwsZkduQ+MkOkFLZQ3nDpV94MBn934aaNZmeWFYkpt
UnYoZVZCR+tD/mzGw8xp8ahJC/niTPlFFM9/jOtLnnaznVlorASgFZvTvb0d+e1a
rbuR/Nj4gv+m+de9MmT3WzL+6cXvYj6zsC8eAnO5fsVvf1BOQokf1Htwv045b8Qh
4+cyzYNHk9J11dqNNfxp1NqkGxdayq34tbgcd/k30xUPl+QL6bLvrbPMBc1PpZKT
wWQiV9fu5vwMzKpc6rQRL+WPWwR1WwRAIFiPHcTsPiJnkjedVo6r4TAwst8DZI8q
ZErMsWLyWIdTBoVCdrdtvUkmtY6x1L9vuEYvWIuXx/Aiu0ZWIFdeH5R33B9SN51h
hv+LzhQrMK6K0TtdZu2h2uFBDZvy/Tg9rwDgN0h4jQP9n8k1azCQyLaPxP3dHirT
FmDdKRS9R2wXsPn7NDaLcBLjJ8HL0R8q6Sq2Es4ZmGdtQamb7+A=
=7jUQ
-----END PGP SIGNATURE-----

--zHX5K+jQW1p1NSJH--


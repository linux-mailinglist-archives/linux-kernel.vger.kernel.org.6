Return-Path: <linux-kernel+bounces-521268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE035A3BAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A02188783E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798CE1C4609;
	Wed, 19 Feb 2025 09:46:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427681B86E9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958384; cv=none; b=pxPIbh8w0A9Ei1nB8iuNhLdkeKXbvJ3s3pP1h5RZo2C899wRqaVMdu0XqCXhIrH3IlicNkLgbcx/VHH/jZSwQOmfxJLpHgdkP6GkCHtuxX1B6NC4e+YhapZ+R9DN1x6rotpEh8oUmqi0Zs1PV//OUVgyAv3krdHHJlN5jUbro7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958384; c=relaxed/simple;
	bh=6VQ4aEJy9a96AQdVkahptEXSrtt0nmZNJQD2h5YtIQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onb8pS38hAUa+yU1a5pMbAMUs8nnyRva5ghYJd9S+1GpWSN2h4Sm3mlM5MRS6e4oWTk3PhBCJjemaYE24Inw3CYlqH7pgSG3YQt+e2XLxTf3WreNeW1ZjZygNL+LDKVGhuuUMRqlEO3k37q/HnPonG81G6JMaDKku+uASjC9S6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkgen-00029E-De; Wed, 19 Feb 2025 10:46:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkgen-001jyo-0K;
	Wed, 19 Feb 2025 10:46:17 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BDD683C67B3;
	Wed, 19 Feb 2025 09:46:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:46:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Tong Zhang <ztong0001@gmail.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND v2 0/4] can: c_can: Simplify few things
Message-ID: <20250219-intelligent-fragrant-lionfish-a1e11b-mkl@pengutronix.de>
References: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="srd62ye3iaw732cc"
Content-Disposition: inline
In-Reply-To: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--srd62ye3iaw732cc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v2 0/4] can: c_can: Simplify few things
MIME-Version: 1.0

On 12.02.2025 21:23:11, Krzysztof Kozlowski wrote:
> Changes in v2:
> - None, just rebase and drop applied fix.
> - Link to v1: https://lore.kernel.org/r/20250112-syscon-phandle-args-can-=
v1-0-314d9549906f@linaro.org
>=20
> Not tested on hardware.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--srd62ye3iaw732cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme1qGUACgkQDHRl3/mQ
kZyhSgf8DyLEUYoXYmDa0PqcV0NWi7+V90cDHTAMBjtZJD/06rCwNVYZubsgqBMG
H7MxPwh0HhHHKdDZ/dEZR7caaXhGNinZOoKG7jtxUV8P4Xrb9V9Y8mRGn9+IlGoe
Nu4kqPBqE6htMpvmFCgnzu21KEhexyaDsYAQwQlN4uQgnblqtds5+/s90ABAOMTq
PHsWuKXTsOutNR0zdrqvhRuRQqadsy/NWOh8/TwhWe1t8dAyGhYDixzIqq4F6Kfx
RxIUMtEKw/LnnXHwubo5N04h9IpTumM2q9JVzplIZl2a0gStiTICEfeN7J5+6rnf
msGnFNSeeW+sak+MEXiWrOCzCcgDBw==
=33r+
-----END PGP SIGNATURE-----

--srd62ye3iaw732cc--


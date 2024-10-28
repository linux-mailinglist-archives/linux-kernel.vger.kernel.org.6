Return-Path: <linux-kernel+bounces-385101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A22CC9B326B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6381F22703
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E31DD553;
	Mon, 28 Oct 2024 14:03:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446EA1DB95F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124186; cv=none; b=qMFWt/TVJ2O2cZJnLB9fE2BAPaTotacx9n5HCSRJB2fOE0+Es03Tqqw/VBJDQtCVBL5GTI6EHufO9EcsAR/qWpNS2NwZLi1WF0EMQdSkSLLjyujVcwWwjHH3/McPFAAqhNjXzV59y4M2itHeO1s1A2S2/3ZkLbDb8mAAKH38ME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124186; c=relaxed/simple;
	bh=kJryATv559js9WGfKz+9Z7XSJF7osBWpwscqtGu0ehU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0gS+Fqvm8OpWsjoSxpDppe7jZL+mdlLE+AvmfOWyI4XM7+2+FzoU/dMM3QJyrAfsV0sGmx0ihVW2+Hg/cVODoJhPU5KowJUSquDZrfd4EdPq7cWp+3gs/IIBrWa1oLnMXLlfUpYGI8PxhYbCGq6d5/+wwqDzpmvxyotxQicLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QKP-0000po-Es; Mon, 28 Oct 2024 15:02:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QKP-000rbP-0W;
	Mon, 28 Oct 2024 15:02:41 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C79B7360938;
	Mon, 28 Oct 2024 14:02:40 +0000 (UTC)
Date: Mon, 28 Oct 2024 15:02:40 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 05/24] can: m_can: Switch to use hrtimer_setup()
Message-ID: <20241028-melodic-subtle-waxbill-a6f8ec-mkl@pengutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
 <16cb05a8163085445bd17b68ad54bb11d2b2c450.1729865232.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dg3wjxgastupw3b"
Content-Disposition: inline
In-Reply-To: <16cb05a8163085445bd17b68ad54bb11d2b2c450.1729865232.git.namcao@linutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6dg3wjxgastupw3b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/24] can: m_can: Switch to use hrtimer_setup()
MIME-Version: 1.0

On 28.10.2024 08:34:18, Nam Cao wrote:
> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that =
it
> also sanity-checks and initializes the timer's callback function.
>=20
> Switch to use this new function.
>=20
> Patch was created by using Coccinelle.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6dg3wjxgastupw3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcfmXwACgkQKDiiPnot
vG86Rgf/cyKVMSVHGYlNaprWA9pODJxJdFiDQY46vMooCuLf+hxT2akZ1h58ofI6
ohhdbJBvvXDICS5HIfZVB5r/waEafKgtO2LMoUm5SIHmzINChI2eWnMcGA8ScL22
Mg6yAaKd4Fzu/n/JufrwIUpIcRTlWFFmUqTQEIxUmIdN/rYus/Ew9xLbd3gVgZM0
1gPWOrfDz1ug2omw1QClSvSIOZVgJoJWg+8vnCDWFSRlQJ/C/SvYIsATm6cszgHv
XJQP4jrvYWY46ic2bHoIIJyxvPQbGC3rNl/WnWa1vpwDCMWUSZRGuCK270SfRlXu
9NNzUgnROTw6svXG25T2xtKHytnPhg==
=Z0Y2
-----END PGP SIGNATURE-----

--6dg3wjxgastupw3b--


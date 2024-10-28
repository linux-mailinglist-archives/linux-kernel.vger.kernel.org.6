Return-Path: <linux-kernel+bounces-385102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E09B326C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D721C216E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9511DD554;
	Mon, 28 Oct 2024 14:03:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447421DC734
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124186; cv=none; b=GhL+NXMKSbqMG/dSXHLjwqbkOxPvU5tDShsiy1jGBtsvlsmPfkhmMjXeeHsCyj9xGKTdcC/fZ3XixtG3fd254wxKh1C1czj8pk5KJtJOJ/yUbPfNfopefkwLaEQgJopmKMCGhC05RLz0eADZmthku/89SnQG9/5XSFuzMbiU/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124186; c=relaxed/simple;
	bh=58/6vNTnlKKYgIwXWFP7egqvOg63K++m5tLSuiCZIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9ZqU47VsvZXEiLXjyaSta2AQ0AqoNtOG2k2HVHZVXrKBHTI+FmoX2sV4Vi67FsC/+E24m9I5MqpFMN9tO1+aKlk6XP1QsL7cjq7htMo+YLuyUXh6LlaSw/7M4GJsrxARbL85EBL5sdnrh6X/miFJU8DKI8chxEraJJqqKY8ols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QKc-0000r0-Gr; Mon, 28 Oct 2024 15:02:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QKc-000rbV-0s;
	Mon, 28 Oct 2024 15:02:54 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 028DB360939;
	Mon, 28 Oct 2024 14:02:54 +0000 (UTC)
Date: Mon, 28 Oct 2024 15:02:53 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 06/24] can: mcp251xfd: Switch to use hrtimer_setup()
Message-ID: <20241028-wealthy-quizzical-aardwolf-31792b-mkl@pengutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
 <e84e3b89e4e023743b4e599959e5efb6937803f0.1729865232.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgxwlytlvmftgq3i"
Content-Disposition: inline
In-Reply-To: <e84e3b89e4e023743b4e599959e5efb6937803f0.1729865232.git.namcao@linutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--fgxwlytlvmftgq3i
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/24] can: mcp251xfd: Switch to use hrtimer_setup()
MIME-Version: 1.0

On 28.10.2024 08:34:19, Nam Cao wrote:
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

--fgxwlytlvmftgq3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcfmYoACgkQKDiiPnot
vG+LoQf/c84yaxg6vURk4jmGz5mKmiUZdDlpzD9QJvDDl7HDvNVkSemCkI0rFGXl
K+PD86j1Pct4iB3T13Bq2WvzNz4I9xqVJC/DMFCLfdUG8N7n4doczy4rvB5WVrnw
b6tsZuN6u3ZHupXsMxut+omYrwPAio6+ECgCVLe98tXf9XzbMG1pBBvO7HfDJqNb
0xrwcx9xhZlAJpn8LQ5IelhPPTPShGPeLfAN3DLd04Q6S9gpUNVWp5RqLDK2xBcu
/1aJ/xwWafd9igvyXJ++Ew4hNw+BOg+DNRRD8WD38PL4S8Trf3i/4xKlW3taHHnW
+K+9sP/U8iQGPO7B/PWqKiUJpTM/Lg==
=Mk+d
-----END PGP SIGNATURE-----

--fgxwlytlvmftgq3i--


Return-Path: <linux-kernel+bounces-235513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B017591D604
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633CB281A13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62805B674;
	Mon,  1 Jul 2024 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="surXrKuy"
Received: from relay0-i.mailbaby.net (relay0-i.mailbaby.net [64.20.38.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887D4A3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.20.38.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719800330; cv=none; b=NLDXAMJ6laazRrhaQzQOQcd5OtI4lTjf2KG/hZEPY7YQjHoUsoOXt4G6YXUJ2gK6K9gaXWynlqUoHFgQVTofWWL8X6D+xITXdSsYXkZmjvroqKRiXSRqQ7IuZYjqa5fxdr1lHDpDKd7jq+08bE3AYTdDRUFAyDoRWZ5yqQNVtYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719800330; c=relaxed/simple;
	bh=fw+mENDa7h/NI/nTk2YZCh09jf7787J59IhjUXjK10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1HSe4cYuU6bfPC4jIgrI8We/gjvGntT7OkPgLMIYzKr9j3DS88eJ1LEJARp1AYVZxFh/wZPeIuIXQ38GFKe0UNEX6OsytYSHKCzSXGjv1MnZrm0OhEu5cfvleyimI0jUEWhOSTHGQ5QPGkSuVY/QD5GeMWUosa0T3PDVqjHBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=pass smtp.mailfrom=agatha.dev; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=surXrKuy; arc=none smtp.client-ip=64.20.38.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agatha.dev
Received: from mia3000.dnsiaas.com ([192.155.110.18] mia3000.dnsiaas.com)
 (Authenticated sender: mb6724)
 by relay0-i.mailbaby.net (MailBabyMTA) with ESMTPSA id 1906c1194c100036bf.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 01 Jul 2024 02:13:29 +0000
X-Zone-Loop: 88596a21948071987ec1a8f1ed942a94471f6c9cdef8
X-Get-Message-Sender-Via: mb6724: authenticated_id: code@agatha.dev
X-SPF: pass
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zxB+i9V9h8SCnPinbwv5qYHOmkI+9M8SJLx3/o6qtns=; b=surXrKuyCpfK172Dxa3LGk1W6U
	FUV8uRiT7mVjgpqjAEijlMxYkWSWUJ88TQyu7wMKZku/+G+/i63eiilJ7ZE1xgNlY4rPzTrsvHi1+
	cUHJcPACHruVsLAB4PHDXjpXSsdCauzPl47S560hw5j2EzAUDfhSb4lXzGr1ojNOrHmQW7jDtMc6w
	cZu2MsVUpDuwKgYAvrHBO+da2oJo8dosr/bJN7IZvXQ1r7PCGaCx50eCepYVoY+XnLUl2+IFTEYQy
	vH9Wm5rylqYPdjUeJ4IknkYsXnzahPfLg1ZrFvjsJQ7Idp/Gv6oaP+thqAXPQq0pRLsOGd20iLlsE
	Y1RwFWCQ==;
Received: from [186.250.91.79] (port=20398 helo=kurupi-arch.blackcat)
	by mia3000.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <code@agatha.dev>)
	id 1sO6Xm-00000005Qxt-0nnh;
	Sun, 30 Jun 2024 22:13:26 -0400
Date: Sun, 30 Jun 2024 23:13:22 -0300
From: =?utf-8?Q?=C3=81gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tom Mounet <tommounet@gmail.com>, 
	Julia Lawall <julia.lawall@inria.fr>, Marc Dietrich <marvin24@gmx.de>, 
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC] staging: nvec: cannot configure to compile driver for
 testing
Message-ID: <yhpx2piocn5bkzaqec7mdyosb7x5zpws5l52lmx4xnejmr5xeh@6s3oe4cagcen>
References: <13cd3ec0-0f4f-4119-b2a5-f74e33e3c862@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aq4lkt3kg2zapcku"
Content-Disposition: inline
In-Reply-To: <13cd3ec0-0f4f-4119-b2a5-f74e33e3c862@gmail.com>
X-AuthUser: me@agatha.dev


--aq4lkt3kg2zapcku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Jun 30, 2024 at 12:37:53PM GMT, Philipp Hortmann wrote:
> When start make menuconfig
>=20
> and search with / for NVEC I can see:
>=20
> Symbol: MFD_NVEC [=3Dn]
> Type  : tristate
>=20
>                                        Defined at
> drivers/staging/nvec/Kconfig:2
> Prompt: NV Tegra Embedded Controller SMBus Interface
> Depends on: STAGING [=3Dy] && I2C [=3Dy] && GPIOLIB [=3Dy] && ARCH_TEGRA
> Location:
>=20
>  -> Device Drivers                                                      (=
2)
> -> Staging drivers (STAGING [=3Dy])
> 	 -> NV Tegra Embedded Controller SMBus Interface (MFD_NVEC [=3Dn])
> Selects: MFD_CORE [=3Dy]
>=20
>=20
> But I cannot jump or go into "NV Tegra Embedded Controller SMBus Interfac=
e"

Have you checked whether you have its dependencies enabled?

It seems like you have STAGING, I2C and GPIOLIB, but not ARCH_TEGRA.

Is your kernel configured for the right architecture? Are you using
ARCH=3Darm environment variable? You can do this by running the command:

$ ARCH=3Darm make menuconfig

> In my .config file there is no string "NVEC" at all.

If it's generated by `make menuconfig` and you don't have the
dependencies, as far as I can recall it's not supposed to have this
string at all.

> How to config this driver to be compiled?

I haven't worked much with kernel for ARM-based SoCs, but I think as
soon as you have your kernel properly configured for the correct
architecture and having all dependencies met  you'll see it there. I
just tested and it shows up for me


--aq4lkt3kg2zapcku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQMdxNgKl/8Z+5yuVT3jE4VBgsOTAUCZoIQvAAKCRD3jE4VBgsO
TOi7AQDKvbK/Q7drJcZeT/yoC1UeQrl+A4e1dKINoGUk8EqnKAD/SxVmRlFwc2vy
vsauqdwnZTLPPD61DhtfNZUOr918IgU=
=C2I5
-----END PGP SIGNATURE-----

--aq4lkt3kg2zapcku--


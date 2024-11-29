Return-Path: <linux-kernel+bounces-425170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB69DBE77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BF91648D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302231EA80;
	Fri, 29 Nov 2024 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="C9utPXhl"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110D14AA9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732845035; cv=none; b=ABWiYvskWQP9cKNJhLCbfUnTqwepX1DAvWPxENu9S/kP+DgpYbLOAAVkT76tPXa46fPxhQ4DUcOdKxOu67E4MunrNA89DT3/mmqpjLJFAcMjtB+gKZbPXpEoZrz9rs+/6XJl7JHhwb6TWNZUs9Rz2IcpWYuHR7qLl6R0C1StFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732845035; c=relaxed/simple;
	bh=nbZRbhMjyQB6udHZZfrf1jOXdrRQ7l4Wwz/t6Im/STo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYAjjZTcKDu+GUtbSUjkwJWlYoop1YOdiXk+SKIvk8GkRhXoXHpYNHAXwKFP+o0PLZKqUrVEZe5D6TaFa9Uf133zXzEUO40xDR6mvcmVaCgjSidX2701JHvMYSChAbQImwz3EE13VyR3D5cHoawq0w9vprQ7zhY8kZuStw/kVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=C9utPXhl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FmMK
	Y/Oj/jjqMrJUIcH3+phSKvYFmPty+voQ6MlloaY=; b=C9utPXhlHwXD/Q4eZV8T
	P2sbUZYQQgKbVEg5ymUS/amx6+P3b1z9Jc9x/zcbe3eZ4k8Ogluqql7z09qX4Jpc
	H1KpEbRX237MZvO1FXs4LYCfYiap73MPpssZkQcdf7zJ2NRwBPj+Wl5WsnLMD9MK
	UAdTbOpsVL4HhXyOxa9BsrtWAcEgmVacRxFQNV6xZYYTZgBR2c78ZiR9LXmfOKxx
	SyTgUZmQk6EldHnsT37lxZCMN61X7ZeMH0AmVNf1GUnxUCK4UIHGvFDd1X1Hvmh3
	4Ct7BXloQe/jiOF+VVyH5pqifm1UlBJPIgOefPaBunyjQPaK5memOnn38cxzWJte
	Iw==
Received: (qmail 1195180 invoked from network); 29 Nov 2024 02:50:23 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Nov 2024 02:50:23 +0100
X-UD-Smtp-Session: l3s3148p1@Q/oHbAMo5ptehhYU
Date: Fri, 29 Nov 2024 02:50:22 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] of: base: Document prefix argument for
 of_get_next_child_with_prefix()
Message-ID: <Z0kd3qyjdxvylAyT@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20241128042632.231308-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xUozA/03lxhy0E1l"
Content-Disposition: inline
In-Reply-To: <20241128042632.231308-1-wenst@chromium.org>


--xUozA/03lxhy0E1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 12:26:30PM +0800, Chen-Yu Tsai wrote:
> When of_get_next_child_with_prefix() was added, the prefix argument was
> left undocumented. This caused a new warning to be generated during the
> kerneldoc build process:
>=20
>  drivers/of/base.c:661: warning: Function parameter or struct member 'pre=
fix'
>  	not described in 'of_get_next_child_with_prefix'
>=20
> Properly document the argument to fix this.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411280010.KGSDBOUE-lkp@i=
ntel.com/
> Fixes: 1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied to for-mergewindow, thanks!


--xUozA/03lxhy0E1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmdJHdoACgkQFA3kzBSg
Kbb6Wg/+MP5w1tvWSlECiUKPN20ozPr6Ka8tXeaWCrYBKKDQE5oaAXdDq79CmPX8
gToQ36xFA8EUotajUJBmZwfJzl3riZtMmJ2PYHYzpyxNIYlO+DNOX3DPhMsBj2A5
kuFRKsXZjh9inawLQtRXSoPzwSuR6x6mjmSVFBnWXCDI18e5wlmnZkQwT+IzRo0p
ceA8nyfL0KdVX0tfsc7gUZgrHmquz9kYz4Nhl4Eq9yk7zyGTrf+INxsVBycGCo9K
IDjCJSvZw0uPnvwc5iPdPEdiPPED8b0dD6GJr9GvZiCPdmqSj94wD9MYaMNF9oWk
552MZwpFqT53ooD31HKlkpaOzaB7ABxeDXaOaRMyv1yzU9yorB/O+cg2nyAyuU5P
+I67b5tiUmtRRDzZYv1G3Iy8P2aI1CozXV6M4IIOs6andqQ5UsGIxL7RlYxi5ZQu
JB6CPQytjV4vGBTeMCAhBJw/3QFHx5OhYTCmHjjgFF0COdwTN47qhAc64GxXL+tc
sgxQM1laQk1vJEIbpvRceLq8uZF7do80/3ftz/gdQRT6ECzSLPsjKtX6H7jwvyao
uQJ7yzMiz3LTkHwNKLQYeETtq8fa1+lQY3AqXdwvelJ2c8O9X7c3MkwkCqsjlGpH
ZoVODiRTJfiyz7bzty9NnX3CwM6WfYIJmPBy8j1crl3M2ohtAtc=
=hSwP
-----END PGP SIGNATURE-----

--xUozA/03lxhy0E1l--


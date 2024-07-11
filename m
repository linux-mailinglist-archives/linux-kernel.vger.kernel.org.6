Return-Path: <linux-kernel+bounces-248485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85AE92DDD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F88DB21A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4403A9449;
	Thu, 11 Jul 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwcE3E/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE86FCB;
	Thu, 11 Jul 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660500; cv=none; b=o1PvO2KFUqZXHVxdd+V0TBcbP862XrvV5md3lClfKBN67PFqtodxI3KZN/FlcG6uKpo26bRfe3AJbtrSkZuqwaZ2ZMQABNvMSIasOdYA+7uh15pstyTP+r5XBqgqHJ+06iVzOcU4ftzsz0ZmUS7QJtQd29Pfjyz11laO8s9RcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660500; c=relaxed/simple;
	bh=QmVeqyAg4kx3FS1nqobMtRmk9z39HHVvttSW/nDR6FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU8cRH/BHDk9GnAeKoJ00OFpYCSKaoiQb5/GUZ7NMkbeMgnVVf3GFWYY1cc/Z8QyKa57kvis7bDNFYNEryzWPSqJTB8OIsQcQo/ffnWMolI5bUB35HGTxz3DpQw+adqfRQYhlUquMRPudA8kqEDNzvmUDoKumq7DE8M8GrjxWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwcE3E/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBB7C4AF09;
	Thu, 11 Jul 2024 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720660500;
	bh=QmVeqyAg4kx3FS1nqobMtRmk9z39HHVvttSW/nDR6FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwcE3E/FDMXP7ng6I1/jq/eDzyZTjUMRg+cZQn8UKGpZJMqvviz7fXm6QDKltom1N
	 vqMeKxtpC+ikvGjkBl6LLPliMLuoY6H8jOCt4MCcKCYPFOj7Q68E+htdG4/k8EHyqO
	 WD3P9UYlPCpreeHOT+fTDtfORFijPTdz4MlCNg/Suo1A5rUCaVcDctHuzeIhIMKxGZ
	 sAl9gfChwS1NjRJsya5Nl9OdgxdYDNjaZBPp0V2LGCTbNVlkpMTEKMcfPUgXncjoMt
	 L2OsNWL9JVGBGRxEDAqSGyfDbxesr5PlixVU9KImF5Zx4t0jCALj7x38wJ7O2f4R2x
	 WV0ApC+VNxUEQ==
Date: Thu, 11 Jul 2024 02:14:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] regmap: Implement regmap_multi_reg_read()
Message-ID: <Zo8yECqjvhw6dNGy@finisterre.sirena.org.uk>
References: <20240710015622.1960522-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLf9y0OX9e5TZU/2"
Content-Disposition: inline
In-Reply-To: <20240710015622.1960522-1-linux@roeck-us.net>
X-Cookie: Your love life will be... interesting.


--PLf9y0OX9e5TZU/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2024 at 06:56:19PM -0700, Guenter Roeck wrote:
> regmap_multi_reg_read() is similar to regmap_bilk_read() but reads from
> an array of non-sequential registers. It is helpful if multiple non-
> sequential registers need to be read in a single operation which would
> otherwise have to be mutex protected.

It would be nice to have KUnit coverage for the new function too.

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-multi-reg-write

for you to fetch changes up to 3c1ff93b4deea502cd8b0869839557cab2a28b71:

  regmap: Implement regmap_multi_reg_read() (2024-07-10 18:45:34 +0100)

----------------------------------------------------------------
regmap: Implement regmap_multi_reg_read()

A new API function from Guenter Roeck:

regmap_multi_reg_read() is similar to regmap_bulk_read() but reads from
an array of non-sequential registers. It is helpful if multiple non-
sequential registers need to be read in a single operation which would
otherwise have to be mutex protected.

The name of the new function was chosen to match the existing function
regmap_multi_reg_write().

----------------------------------------------------------------
Guenter Roeck (1):
      regmap: Implement regmap_multi_reg_read()

 drivers/base/regmap/regmap.c | 103 ++++++++++++++++++++++++++++---------------
 include/linux/regmap.h       |   2 +
 2 files changed, 70 insertions(+), 35 deletions(-)

--PLf9y0OX9e5TZU/2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaPMg8ACgkQJNaLcl1U
h9DFUAf/ZT+z/+QECPzqG+vbsK0T/UIkvKo+EJm2Mt3GwDfE9aaJSFE0qUAyureZ
W4SXt8Dw3RUkeU906rtuVF17g8SSb6RlmTTXo3pWfivSFh1eMxuCLaEyUHFBk921
arbpAt6j2oc2jhqIwEJCu5YR441Hu8ktfmKjJIyIHcqf9dunkmUICWQIUzoDEm0r
42uFy4xcuNlNHWtpeyrVGicXTX7zkwdLwLfived4sEar8oMIztQ9Ig9l3NCncez3
MMJR1vnv1xX05hwy+Kw6LzA46nN4xtz67WUAtZa6WM6As1UC5u/udgVUV0qB3Jlu
Ed4RhJno0mOpxtxSAJ8qjoe6JRHYAg==
=jntA
-----END PGP SIGNATURE-----

--PLf9y0OX9e5TZU/2--


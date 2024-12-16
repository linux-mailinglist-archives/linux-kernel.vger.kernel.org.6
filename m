Return-Path: <linux-kernel+bounces-447863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678CD9F381E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742C3169000
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6A2207A03;
	Mon, 16 Dec 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbQb5Yto"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FD206F2D;
	Mon, 16 Dec 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371824; cv=none; b=f/lCPVRCY3AOnsag0Sw1n8bXD2jJ2z/XhMys2qzGmLj5U8S/A3ZScMKl9HChMk8nxnFQsj0x0Mdg6RBRRXKyfz00FzM4nBWMovAz/zPEsxXsJx5cozV3j+0VkLEvpTPdthWugEY3k8Z4gQOrFXs3PVkbzSzTAptFeo7H4S8nNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371824; c=relaxed/simple;
	bh=Z4tZ8fVofiGwAb7FaAn7u4Dk8NVUizwERM8FmNMH8MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuJl7aLUG90tkr835jmNOLqQvhboWW2CB9SnJ3cA3w8KV0HnsuVKhVHGRoEkURVbdkxw7+Z/3qPAcQq+F5IG/qRaQDoc9epYiD7Hk3Cxf4SqU2cx4J4fe/PPQSFZkmAuM52hb8X5LLbOpe5Q4FntO8iU/B/1tnmFo3M33RYWBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbQb5Yto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8132BC4CED0;
	Mon, 16 Dec 2024 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734371823;
	bh=Z4tZ8fVofiGwAb7FaAn7u4Dk8NVUizwERM8FmNMH8MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbQb5YtoHWIG2i81bmyykeMAQvNegaoDJWzvE7DlBZex3RyAfwAroe5bQGbRHlJby
	 jjqQVAAkr8hl8Dvjtpke2QQz2r0Ad/7uEi+edK6j2lLcJoyLs70xjia11RD9bTH8Dq
	 E3Jvt/ICN4SJjUxPtoq8GeF2toKeWTLVW2uDsDNfsZvAuGESM82qsyDGNtplv5ieGs
	 s4kcPeGaKiDCeId0agBsQE/PlCv4C1v1aoXNADhWZn8A7+Oc8MBtKJJONGyClzTaba
	 uY4aJE9xAyCgjoz77qfQYB/Cm4kHef8xCurK7C8gXvfvdrpKaWczWGX7XtHfT1xIwg
	 YtZJ4kj/0G/Uw==
Date: Mon, 16 Dec 2024 17:56:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ASoC: SOF: imx: add driver for imx95
Message-ID: <03b0bcda-c351-4d76-accc-3d3e0ed9c335@sirena.org.uk>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
 <20241216145039.3074-5-laurentiumihalcea111@gmail.com>
 <Z2BZ+WUY6ecIwhEt@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1dCq6JFN4ecgzC7O"
Content-Disposition: inline
In-Reply-To: <Z2BZ+WUY6ecIwhEt@lizhi-Precision-Tower-5810>
X-Cookie: Be different: conform.


--1dCq6JFN4ecgzC7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2024 at 11:48:57AM -0500, Frank Li wrote:
> On Mon, Dec 16, 2024 at 09:50:38AM -0500, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> > Add SOF driver for imx95.
> >
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
> >  sound/soc/sof/imx/Kconfig  |   8 +
> >  sound/soc/sof/imx/Makefile |   2 +
> >  sound/soc/sof/imx/imx95.c  | 401 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 411 insertions(+)

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--1dCq6JFN4ecgzC7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgaekACgkQJNaLcl1U
h9Cl4Qf/Wqcio/gpAHtCYuQyA3wXb/0S4M/vlqazIEavGzTlUOYqnxsbU2AaeMEk
zwpZ2+eQ/bxaq1ShK4qLnNmzrurodvT1vfHAZPzfx58S0dtVN5Y37lau53+IRyQA
GIyaTH3CFhR1JJcXKXPfF6cl8VwHgniUTT+hlT40q8I/j7Jp5AJWqOcKfx9Zx8sd
Rnpg5dGVAg8blZMM8ste4YKqkx2DRgtc/yIe19c2V3+hyTjmBnw8+PztkfW3hqKS
g5i6JYX1BwjPexEl9apLPs8lhKaEn7p/sHIVz7uxUBwkKz7McqVAaXTTKGebi/KN
RXz4I6ljBH8xC5MQ9DH0/EEnOkZgcA==
=wqS7
-----END PGP SIGNATURE-----

--1dCq6JFN4ecgzC7O--


Return-Path: <linux-kernel+bounces-240165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254A9269D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04771F266D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E14191F69;
	Wed,  3 Jul 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGWRsB9H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08710A1F;
	Wed,  3 Jul 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040551; cv=none; b=kIPAOuHghWMwI+YrEw1DfRRb8Wq/AQfsZvOXWRFF2u6EcBydAicY9yU4+C08EOLOiUuY8MMFbMvImKKf4Eq7YgyCf5f3I1+MM6G8IhLW0oNRhHyudpAnm4liypK+dLyksvMgjg+s0j+6DPwTbZFZs84bEgRVKvcmdi3Zo3hPbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040551; c=relaxed/simple;
	bh=dmmPN7PbNyCuDzjw4nX616fO/kyvAhA6uaaJgw/vC5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixgEIa2kQbYVGFewE/mjh/DGC5QLVF8yjWsQKVF9v5ixQZkJ94Tyj5/IQUlUm7c5TVMhRxzjES6CyZirazNlF7eifYorawlPurW6QtHKz8uIZt9GK1XC85vBMJ8oRg+0mgaSqIPm0xquSpuT83S9FqUtsOqMryXLK6/L9dGg234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGWRsB9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B3BC2BD10;
	Wed,  3 Jul 2024 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720040550;
	bh=dmmPN7PbNyCuDzjw4nX616fO/kyvAhA6uaaJgw/vC5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGWRsB9H5MXgtDn7xBNW3x8qyw8sNfFGFcrNRO8O/yIwf4qqlSgoIJAMpNG+t7BZX
	 +AKaNMZnSTW4BhxsEDiixqYQXjKtfclgZgjhydQxZMm5TBdoAjiLfsPmtiPKpGEVBH
	 aA0+F2GTdsgouJCp7SjzpViThXocsy3WXNw/Y+KaMkXP+XplJoFUdxgaEfzWOQixUZ
	 bsQZkCrJg+4nGLJsbgVE8NmRAiwVdIjZxxi/tYhpzwa3F6oVqpx356zsR7lFetlzpJ
	 X49nafffoCvVToREvd67r+CMnyPu62/lizDqCqlBh2Z56O17YJk6yCzqZkFQ0dmnAM
	 o0nxREnHvwoVQ==
Date: Wed, 3 Jul 2024 22:02:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 07/10] soc: fsl: cpm1: qmc: Introduce functions to get
 a channel from a phandle list
Message-ID: <a8c44188-d5d8-445d-9d64-bbfce6b1b628@sirena.org.uk>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
 <20240701113038.55144-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IXiemNHl5uycVqbr"
Content-Disposition: inline
In-Reply-To: <20240701113038.55144-8-herve.codina@bootlin.com>
X-Cookie: There is a fly on your nose.


--IXiemNHl5uycVqbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 01:30:34PM +0200, Herve Codina wrote:
> qmc_chan_get_byphandle() and the resource managed version retrieve a
> channel from a simple phandle.
>=20
> Extend the API and introduce qmc_chan_get_byphandles_index() and the
> resource managed version in order to retrieve a channel from a phandle
> list using the provided index to identify the phandle in the list.

These two PowerPC patches seem trivial enough and have got no response,
unless someone objects I'll go ahead and apply them.

--IXiemNHl5uycVqbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaFvF4ACgkQJNaLcl1U
h9BZVQf/UimpDsgz78MuXcxLPQ7UIFnEeDuapV1kWGaWCmCLoHhTHXeG8B/9AQqI
ttiEWJdBKBzc1NRr0xmsh4BpKIVlCe3zZ3tndxE0umFnliWOKBeo7ZqroZb47asH
lcjxXenwNC733si1/zHRv3cxK8z0zprPshVonONBP4iaKppNz0Kmifj77IglG/h2
C6j9RiJ9CNkG7KTc5XU376/q5G4PXStk+KRrVL0F+x+c93QywoqXinxhXovc/j69
CNNc/7NjfF/7Rs+Y+F4QA+6VA9WjwjEO+WNaI3VtZad+beJ6ERyJBnh6G0tCrWl7
PYG5NWe9uOZQxqsuESvUUBEGB2nJzg==
=qAFL
-----END PGP SIGNATURE-----

--IXiemNHl5uycVqbr--


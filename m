Return-Path: <linux-kernel+bounces-545153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2449A4E980
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F227A2990
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FBB264600;
	Tue,  4 Mar 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAkkJIy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902023719E;
	Tue,  4 Mar 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108653; cv=none; b=bCm6CMcKjGCdOnrBqvyQT+1/wMgsRUDakW9AI3e616FSnQxJWVqANsruIZzCepayQOc4wH83sy2duJZK0gDyX+xh7lwnzdZNwelX/7YQA/a96AIGVE3if5efmav3BZtKZ9JgKEDQeAmQCkaPTWOukI7ywvwiQxSnP6dJGMfnhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108653; c=relaxed/simple;
	bh=4z7H9csckGqLSufOJUp9XXvgfTc9ZOxQQQ6azPlLWDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF/2G392pROUM8i+JJYPTyqY9oAMbS6W9AJgEVd9EE2YZDMshjkvAdEPMlks8ySRBnCFpxJfCd0KkcV3WW2/9NASMMuCnbSlTAfRta1HSKFzkTud0zlOjco1C2GnYrm1uTP1i1cOPhmnw5d5h2LEPW/rhj9Q9wv3A7/nEIYg6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAkkJIy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F3EC4CEE7;
	Tue,  4 Mar 2025 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108653;
	bh=4z7H9csckGqLSufOJUp9XXvgfTc9ZOxQQQ6azPlLWDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAkkJIy29QnQjVEgSpSYNLm2gsMIuLzqzehYykZ1wUQES+pa8gxoV87KPfcoe80bZ
	 tYx0igDYoUPO9aoc1Jt5H609W7iXn8yHMs+nELJ1AONXDfICRo8fqyFNhDPyZrE+RI
	 NJGYelL8lgORMnm8sNpYm/duk6MWrAbNx6fUlsGua+OMxh9wsNRnc+vT/NpQ4FXvKI
	 Y9hB+p0WfsklwIPoTG4EpkvhGUKhU069cY4d+aexHtKBbmzskFKuv7XFUIeeYOAipi
	 Ipgi51cn0ijIj1yTPtsOhVmLhslvT9XOrmdoMVRvB78f0mUqFQl2NgfB3KjfT8/DDM
	 vPtG4ydTU2oQA==
Date: Tue, 4 Mar 2025 17:17:27 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	kernel@collabora.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zoran Zhan <zoran.zhan@mediatek.com>
Subject: Re: [PATCH 3/3] ASoC: mediatek: mt8188-mt6359: Add headset jack
 detect support
Message-ID: <e544340c-af89-4ba5-b22c-a1fbe1bc18c9@sirena.org.uk>
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
 <20250214-mt8188-accdet-v1-3-6bbd5483855b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sQxBYpJeSEONvwho"
Content-Disposition: inline
In-Reply-To: <20250214-mt8188-accdet-v1-3-6bbd5483855b@collabora.com>
X-Cookie: No campfires allowed.


--sQxBYpJeSEONvwho
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:14:31PM -0300, N=EDcolas F. R. A. Prado wrote:
> Enable headset jack detection for MT8188 platforms using the MT6359
> ACCDET block for it.

This breaks an arm64 defconfig build:

ERROR: modpost: "mt6359_accdet_enable_jack_detect" [sound/soc/mediatek/mt81=
88/mt8188-mt6359.ko] undefined!

--sQxBYpJeSEONvwho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfHNaYACgkQJNaLcl1U
h9CVcwf/cEXGyYbJzY/LG/gtq4RQ3+3Nbsi7YBj19yJ+wFTX/nkro1+oCXhFm/My
qNPYIfWKzJzREoLN1uolpyWB3ffXgf8K6YMH5gJDSSwBngo3qycJ+Q14OfwoK5PX
MAHUIulHOADCpMQEtODRPXwtEklB5jlpXyf8trwGIJyIXBFCm1NGw8vNq7XWB0cn
12wjTmq0Nr2bA7E0LaU4j2pryPCXLkFv3dg6mbrS79GiwQRYUBaURz8saWqj56Oy
D2k78AJbhycmDKbDKI8pDV34O3VsC/J6/rgYZefvKtDVOia7C89hqSleSTt13fUC
HTW7JbCtS9/S1+wHTAPb02BP45QAnQ==
=lfm3
-----END PGP SIGNATURE-----

--sQxBYpJeSEONvwho--


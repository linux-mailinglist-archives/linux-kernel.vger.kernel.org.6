Return-Path: <linux-kernel+bounces-278629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6D94B2A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076DCB22583
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9F14EC5D;
	Wed,  7 Aug 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD8LeQVA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A813D882;
	Wed,  7 Aug 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068279; cv=none; b=Db3eUBmaMMM6uHvnviGhqvy2hS98HHxtazVuiGJ5CoAth0qYwR+rEM4Smk+Wz7BnvGOlpRqDA+m4ruVBoOlTdR4sW6wJd0PsYtmT0BdTWwep0EInHmaRs3ixUwyyKOgWUVxtNh3ArjmgYqB+nanXjExtOKX6nrIbWVeOLaTlg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068279; c=relaxed/simple;
	bh=Aun0C9qV6YJNK0y8IYWDwu6TzoJxNI1uGH6VUWDp41s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ9hiNn7SO02MxwNrfWMNATh/iSbHFBILnoBP2zEFEsyuzPAdxYOj3zH2dIRbBXcTOqsCYRL1wPxHX4i5oVrNC8TEWLW19vEBrHL+Xlx9mCDWx5Abqyxtangj4+rqcP8fz28fZNXu3hbzWGaQrGJqCECZLYKpmmDGLGGUcnT2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD8LeQVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499CCC32781;
	Wed,  7 Aug 2024 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723068279;
	bh=Aun0C9qV6YJNK0y8IYWDwu6TzoJxNI1uGH6VUWDp41s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WD8LeQVAow1IdNnHwQBI+fkkL63wGuHbzaEJ0nXnuhL+yy7RdNJjlGaTdYy4rDM1R
	 +dNgRJc4cW/QXP0gSUmvZYylu3Z6H/IVZalPLGCHMJ+tB/kTSKVtgquyvedXjsFyzx
	 mb8AHYz2gq/QMPpaGRQ1bix2fJhe4Sw/AyzgM2W6LLenZRRZLCBlweMY4e30RytCO0
	 JApEm+f7IHD2QrdD54FF6vi/2WxjNjofsfHBcfqDpDfmRYzHrAGutIFHXf4+sR3j8w
	 hRWKrpGPD+sq7dpcFG79TxV1R7StPrMVCrl4I7ZqlccwSJXcjEScMp/7ZBuAVYl8LE
	 fQHKhO0lJT+YA==
Date: Wed, 7 Aug 2024 23:04:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2] dt-bindings: regulator: mediatek,mt6397-regulator:
 convert to YAML
Message-ID: <ZrPvb_bT2ty-1V6-@finisterre.sirena.org.uk>
References: <20240807091738.18387-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lDZc6TitRszOoInN"
Content-Disposition: inline
In-Reply-To: <20240807091738.18387-1-macpaul.lin@mediatek.com>
X-Cookie: Your love life will be... interesting.


--lDZc6TitRszOoInN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2024 at 05:17:38PM +0800, Macpaul Lin wrote:
> Convert the MediaTek MT6397 regulator bindings to DT schema.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--lDZc6TitRszOoInN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaz728ACgkQJNaLcl1U
h9D9XQf/eyGOxW1JkZAZL8CPVJKE1FXgdauk+Ue+UfyKHYdK6d+eRgfwjidtCKbE
XDGKNI6EvMUzOR6n6VAYFSwJUOUcM5ErhW0JQbIWMlCWNbTxrMFvJAP8cx5LiNR2
Ioms1PcpbZb+UTBQR4iR+W3KVBGeSvmIyhfkO4u0NtVT3TNPaofupAQJDx9esf3Z
L5S5VLcR5P3hJ1bcugw1lhJNx4LF3a0bNunfJWRcKS0hQIkiSTjeRM7qcqMrIGfI
vxLuBoP0+dW7G2JWdVZhWkjzDzAAyMvYlODNeHJjyrwyqwn9S8cQrEI0R3YALYs1
r0GXGFxti79tGxYpqb3pwMJgZ6+lKA==
=AjE1
-----END PGP SIGNATURE-----

--lDZc6TitRszOoInN--


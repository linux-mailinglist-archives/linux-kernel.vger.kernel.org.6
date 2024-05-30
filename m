Return-Path: <linux-kernel+bounces-195608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45B8D4F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12ECDB26B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12614183079;
	Thu, 30 May 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTA3S5kn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCB182D2D;
	Thu, 30 May 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083530; cv=none; b=uZg4fLJlRYW1LNNaqK9jw2aWPdCE04VpKlZVF1+1imNVoosXDiWP156TLK9p1nRMHslsh2HIg5gzS1KkCIIqga0XC2rZWysYuBroKWlZc/41t5yChCFwF5M5y5UIZiFbmbJlHqC/JRnlhtG6Y3yewzkxSPvdcjAky+heUvYW7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083530; c=relaxed/simple;
	bh=euUKL3giV/ho/PPa2wLumzm+nzQsUuxb34Rbrl9xhq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvWpyT2mNFVvakDkSHSeMITG2hzs/LduGLPqFYoyBTXa2vtQkWXHXBl+e3UX7KAMkdLTuM44w8F9aZQh/7tvHTxZ16tYqXsNTLHsDB1ZG8Gq6x+17gEdHmFfSL333kFqYRdJZ1VHuYhf+lB+oYST+eJBTM14na1KcYLrHMs2OUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTA3S5kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDDCC2BBFC;
	Thu, 30 May 2024 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717083529;
	bh=euUKL3giV/ho/PPa2wLumzm+nzQsUuxb34Rbrl9xhq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTA3S5kn8ZlDjfTHAJ2im+bwNbQ1fjIQ6OiYCMdv8ybz9xvAoNcDz5vXlakFzfcZs
	 zHC/+M8zb/rCdvbDJh5gjPenw0N90iz3U3UxXH0BCllvkroQC9wY5Gs8KTgQwx0Ap2
	 JGwR4/e00D0nYeHNcyuSCmLP3rn43yFocmV308q+/RBjIWASDzyZLOMjbzcsVDeIkr
	 JMAgaPyGXD9tAOejZl8wwWRyXzD8qSV/qrqMxzr5rhOHaTTCTgsgwF07SKuJ6H+l79
	 6KTxARwkFXBaOSsDu3vQcpPBJv6LMWuqdMqNdjS4+UYmGvSOd9j+XascoQ4e7q6AcY
	 NHvo6eobGTuDA==
Date: Thu, 30 May 2024 16:38:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173
 GPU
Message-ID: <20240530-reptilian-revolver-a8cb1f2af8ba@spud>
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u4tlLkr2QYvGk/ip"
Content-Disposition: inline
In-Reply-To: <20240530083513.4135052-4-wenst@chromium.org>


--u4tlLkr2QYvGk/ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 04:35:02PM +0800, Chen-Yu Tsai wrote:
> The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is one
> of the Series6XT GPUs, another sub-family of the Rogue family.
>=20
> This was part of the very first few versions of the PowerVR submission,
> but was later dropped. The compatible string has been updated to follow
> the new naming scheme adopted for the AXE series.
>=20
> In a previous iteration of the PowerVR binding submission [1], the
> number of clocks required for the 6XT family was mentioned to be
> always 3. This is also reflected here.
>=20
> [1] https://lore.kernel.org/dri-devel/6eeccb26e09aad67fb30ffcd523c793a43c=
79c2a.camel@imgtec.com/
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--u4tlLkr2QYvGk/ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlidgwAKCRB4tDGHoIJi
0jEUAP9dytPUMftkwmUYeOy5IxYQ34BgC+UeoK8voSx1buveXgEA3if/Ue6idDKS
pCr8yS7NaLjlC7pujPpYExaUI9Mb/gk=
=y4xH
-----END PGP SIGNATURE-----

--u4tlLkr2QYvGk/ip--


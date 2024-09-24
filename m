Return-Path: <linux-kernel+bounces-336859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725B9841D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB9B2753B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8C153801;
	Tue, 24 Sep 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyjSfPYC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9DD80C13;
	Tue, 24 Sep 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169413; cv=none; b=KDR7PCy+gaF0dv7me9GKi6STf/NkQxu0OHLoixUWZ5aSy4bGzNK/TgfHjcj2UQDIYQBRgxNT3+uwdpfxVtaiDkQnQ5QG0YFSZ25WzEbQZJHB5E4Na7j721whb0VAV4tmVvYTePUuRGwbWuvxmDZ6sAxUy2/QYCLQQAVJlm1FGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169413; c=relaxed/simple;
	bh=7gdoqhXNNZucpSkE8hBwdCZmsMRtwnSTv00X6OJRbPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYgveI3aQBp9hGuV8mYlFDbZ/b+jHBzzEM29+OzGList7Det36xWvYc9cioO+ZxUl4UIYFjo45Gmbbw3QVTJjbYogjwNiVOcONoOpQyHxsQEA0RMtrXrml4MYvk0LW+BaIAE8GLVKzLkR1uwbOhpOl3pw6n+l+bdVmPjjdqYUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyjSfPYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBEEC4CEC4;
	Tue, 24 Sep 2024 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169412;
	bh=7gdoqhXNNZucpSkE8hBwdCZmsMRtwnSTv00X6OJRbPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyjSfPYC80yFtddcP80xN8xdKOpBOMSeeTwBzQNm6cDESN6lFDgELD1iAAJWi3vdq
	 cXqf0gcNEeoi1tJhJC5XaYbZq58QQJK4TBdqmTGA4iDYNTxxYnbufCcCozBere/r4d
	 uByVGXbRA3dVdtWZriBXZhueZAq5k/VcqTy4kNMCUz2vrqphaF9oxSG8G3pKX6U2ek
	 0cUPIBWmpXIVHvU0A1Z0PAu5JveTbOUD5tiSKGWPwzDIU324KorqrBgkMy4bx0z+A1
	 LTNPu0UElea6kvFui9Xi6cnZ+eufn6RmfQblT66qImVNspCKfiQqa1GepyqBdfTiBh
	 Buz7va0CAN+Pw==
Date: Tue, 24 Sep 2024 11:16:49 +0200
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.dev, yung-chuan.liao@linux.intel.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: SOF: amd: pass acp_rev as soundwire resource
 data
Message-ID: <ZvKDgcI0DN5Wd8S5@finisterre.sirena.org.uk>
References: <20240924081846.1834612-1-Vijendar.Mukunda@amd.com>
 <20240924081846.1834612-4-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e+4U//sj5bbFZSnH"
Content-Disposition: inline
In-Reply-To: <20240924081846.1834612-4-Vijendar.Mukunda@amd.com>
X-Cookie: Editing is a rewording activity.


--e+4U//sj5bbFZSnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2024 at 01:48:45PM +0530, Vijendar Mukunda wrote:
> Pass acp_rev(ACP pci revision id) as soundwire resource data
> for SoundWire controller probe function.

Acked-by: Mark Brown <broonie@kernel.org>

--e+4U//sj5bbFZSnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbyg4AACgkQJNaLcl1U
h9AH2Af/W7IK5j+QknLLuZwKGFmupJs/fsjSLXQT1LifiQmhxGUeMtVUB1PB6npu
xsqiCaKrTpB/cgEfo2XdvGVjE2zTU8dhYCxPBwgbR064wUvIWKFDL/CLb9s6Zl78
uWk0ssKWC9GMiTn3QBwWC3+E5krBFlWHrR7e9fo+nOm8eYxtTfRgMq2USLj0rQSv
RT1zD2b9WM+oRNMbcUtSnnv+mb3vw/X8ZXz94wiceARDg9LmCEVAHhstSMcV83dT
frPvBjgENka4YLBvJEqdddO9M6a6cVfaHJBe+Y3UiQ/cbqm3YNikbwcKxO6EKupD
HspJTY72/+wdYio1jYfxHFKRPCRx/g==
=QKWK
-----END PGP SIGNATURE-----

--e+4U//sj5bbFZSnH--


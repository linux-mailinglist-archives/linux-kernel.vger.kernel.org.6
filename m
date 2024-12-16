Return-Path: <linux-kernel+bounces-447947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7FB9F390E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9461F7A2A59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F8206F35;
	Mon, 16 Dec 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odN/eE6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B4204F92;
	Mon, 16 Dec 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374045; cv=none; b=ooFcHulODvSNoQFhsSrNCElroDtVKckydH9Rz0Q1XQYc/LDPdzxnl4S8Gc12rLLXsdtbACfXANIyct4qfeKxlKO0NVuUafK3mRcvbS/HYqQyjtDsDhM2sig2+IHz6t3qhGVQ2/XT7EFZowXZmqZHtCP7e4QvhMLyyFh5JIwPYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374045; c=relaxed/simple;
	bh=nw8UVxaMbWL48QkwsLr0oUgQdps5wyPksK5zCKSYkLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKeCSBiFLgjgNb9Ir8p0dCfSmF5Wlakxbd7W/LJVSlemMIIvDV9IOIy3kmuVKV6UVMZ1xlS18A/nSUO0vybt7Xbzdr98lp085EFbIdO455w/ZK3fzwmO7BGXx3Di1ZYx4Tpw4ZkXlNu5CFsuWNa1nyE38XfCGielslRcsn36EnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odN/eE6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E155C4CED0;
	Mon, 16 Dec 2024 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734374044;
	bh=nw8UVxaMbWL48QkwsLr0oUgQdps5wyPksK5zCKSYkLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odN/eE6LX2KpPfc0YITRoNGsqnYJWctCV8Ur+IosRPS1CM/UqFacRE3qLooqwPCpP
	 DIoL8S3WXwPuK9XzAdmo6EiqPjK3TwQ6MmIKdMD60lpYaSs/OdDqMKMLofoDeIDx+/
	 uHIVAdOsxHBphHhFUmdxv2Sh8IC0V53OzS8UhpfUkJevqgRp4Yu6Y6ktPmwuoIsj/+
	 cCzE1bAteLlSKtTvSGehVLRs3bILDPhTddZDIly0y7FrxJx+D+/U/eXb7CDAKIxjEW
	 TmQktcsN8cuab51JIfFajVCL3hoETzyS8fnwG1lnEKEllP4P8uPbm+fSyi+xmO0X/2
	 nVcNVzCVtTwkA==
Date: Mon, 16 Dec 2024 18:33:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add Tianma
 TM070JDHG34-00 panel
Message-ID: <20241216-keg-retaining-ea61c056a4d3@spud>
References: <20241216-tianma_tm070jdhg34-v2-0-0b319a0bac39@bootlin.com>
 <20241216-tianma_tm070jdhg34-v2-1-0b319a0bac39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GFVoHBN/mStFRhus"
Content-Disposition: inline
In-Reply-To: <20241216-tianma_tm070jdhg34-v2-1-0b319a0bac39@bootlin.com>


--GFVoHBN/mStFRhus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 05:21:34PM +0100, Luca Ceresoli wrote:
> Add the Tianma Micro-electronics TM070JDHG34-00 7.0" LVDS LCD TFT panel.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--GFVoHBN/mStFRhus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2BylgAKCRB4tDGHoIJi
0ipbAQCBhb4DomJO24VJv8xhyhUlmVBc4kF+R7hA6Coun2tA2AEA1BzTLldvymsr
18PFr2/GDimTXv2gy3Y0FukunfTPKws=
=sJ9X
-----END PGP SIGNATURE-----

--GFVoHBN/mStFRhus--


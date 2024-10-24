Return-Path: <linux-kernel+bounces-380200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82A9AEA1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D75B282CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921201EBA0F;
	Thu, 24 Oct 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBBqpvgn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9C1E7642;
	Thu, 24 Oct 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782878; cv=none; b=D5XTS1/0/apytSvHgQgsPOiwh7CTu7McENtBwnJoLJrG/y1/SA3MTndUXjzgG9u98x8sCA3eRNnjKLXw9/W+xtOXmZlbOUxoDB8oWTXUNSGDjPs/mY5CDcAVH7nN4oscCnoflwn77CrbAW1ee/7PPXeHPBUHJgm5n1nKrzeBt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782878; c=relaxed/simple;
	bh=N0wI9OFBged5/7iffZvOk9Mo2r1WR2+eTGn77TckzCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnXm7x5MkOe1h/tu6e0q94zjLt5LT1ZF38/shEl+f7QBEaxXFiCFy6aWBTGDvRBNL283Gx10yjtI7I+ZlnTZ+xnrvOyNhJLajx6osZAxUFmGfB79K79dyDAr9vpVPCMjTzgJ1IH7sRa9w2TYb2E3aqJbCHNLBzuefqcM4HQ0Ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBBqpvgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AEFC4CEC7;
	Thu, 24 Oct 2024 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782877;
	bh=N0wI9OFBged5/7iffZvOk9Mo2r1WR2+eTGn77TckzCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBBqpvgnq0/Gyxky+R05Qzs+OeZB6Z7fCii1KfwDU/Qbe8k7nIxnmR4nLOlK+oreC
	 zeDepQiNOWnNz+uegudFwedT27+SprAE9xf4OexxUgYv8Il8Ls+0qsgm5W7aPlazvq
	 XhTvCSFH2C9Dr8PVZkdu0K8LoZp6sJat6LKcDhxebk6JlQXK/78FcrvZSHRd6kVpdC
	 1wo7po8j75ovC+hPE0BxcNth2mcSAoRhAFEK4UU6kX6N85YE74GVAojAvEAyC65QPe
	 Cn5NRU78vVPdjfygVc6/MlyWdo4BkFciWJWEsNJFZpGzzIrw5Pm6j9sUtwMR2LO5gl
	 OFTNdxDiP23vQ==
Date: Thu, 24 Oct 2024 17:14:35 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 01/37] drm/vc4: Limit max_bpc to 8 on Pi0-3
Message-ID: <20241024-elastic-courageous-wolf-9b9692@houat>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <20241023-drm-vc4-2712-support-v1-1-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ilqx6g56qdz6ge6u"
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-1-1cc2d5594907@raspberrypi.com>


--ilqx6g56qdz6ge6u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/37] drm/vc4: Limit max_bpc to 8 on Pi0-3
MIME-Version: 1.0

On Wed, Oct 23, 2024 at 05:49:58PM +0100, Dave Stevenson wrote:
> Pi 0-3 have no deep colour support and only 24bpp output,
> so max_bpc should remain as 8, and no HDR metadata property
> should be registered.
>=20
> Fixes: ba8c0faebbb0 ("drm/vc4: hdmi: Enable 10/12 bpc output")
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index 62b82b1eeb36..6ebcc38be291 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -640,6 +640,11 @@ static int vc4_hdmi_connector_init(struct drm_device=
 *dev,
>  	if (ret)
>  		return ret;
> =20
> +	if (vc4_hdmi->variant->supports_hdr)
> +		drm_connector_attach_max_bpc_property(connector, 8, 12);
> +	else
> +		drm_connector_attach_max_bpc_property(connector, 8, 8);
> +

Are you sure that one is needed?

https://elixir.bootlin.com/linux/v6.11.5/source/drivers/gpu/drm/vc4/vc4_hdm=
i.c#L594
should take care about all that already.

Maxime

--ilqx6g56qdz6ge6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxpkVgAKCRAnX84Zoj2+
dpYuAX4gdROrmsHWAAzitdr3V3i9R9MKM1Yf94Dzb9HOdZshoaT6nkdTbK04N2GS
BRjpxg8Bf2T4PNnDmxK/oGIdaqzLKcFGfcrvNfmHtgm1+2GHasLnWOExN5va/678
E03+pOebBQ==
=KqRv
-----END PGP SIGNATURE-----

--ilqx6g56qdz6ge6u--


Return-Path: <linux-kernel+bounces-252794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64E93182E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE9C28100A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D051CD3C;
	Mon, 15 Jul 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHbuhEK9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301FF1CAB9;
	Mon, 15 Jul 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059771; cv=none; b=ADnSQvmahc7fUlVSM5f/HHIlXWfVP7dOLncQrYMm2esFkaepIkIliPUTZhY2MohcQG6Z+unxVrSQ/UtnzziLOlx4H4K5CycZhmCr0d46bdCxiSgDLVWPaP5DH6/DPIsIIALeeqqqyXl9+lHwrFJMP2BNM24wTcuta3OiWVTqZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059771; c=relaxed/simple;
	bh=mZvCojP8oJ4JhW6pFDzplfbDNtPCohsUZ4sNPPz9XVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPCZMR2zSxFxFxxtk1LQg9d4/QT2M4Bgted+9cbHvp0bBSxorF+NqLLjRfJPiENfQxtpKfDMAz4WsddM8PvULllhIaybTBAC4lohTy8UEY5WpvP/aOHVS/jMzofAfDQmTUnkXeXS1htdYBtPDpL4SvAvZwKTszeBZgyUp+BuaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHbuhEK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AF1C32782;
	Mon, 15 Jul 2024 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059770;
	bh=mZvCojP8oJ4JhW6pFDzplfbDNtPCohsUZ4sNPPz9XVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHbuhEK9hbzLOYDlRBVabugewcucVIukRV3QMube4oVXCn64OuALIlG8nvGxtrx2Q
	 pblrKcdTCqr268kAvy/t1e2dVI2SNgDuNY4exuMzRwtAbfzZSX7/i3NJqvBD+pwIm2
	 3N0qrHY8HDIIojdgzBWVju38dAMyalkOI05ngssn30R09ehQyEtDSqbcWjx5ihK1tq
	 dmjU0zincZh31591UkAa6fqWr+KQ9wUwiOT4D8GWHnvLzlXW79cWDXOo9Vr+tnG47k
	 BHuIHs/vA6VX94PCOGSuo8HaRy6iQ9c4lwX4Zwwr3IS7LfZLN8jTxBJzGdncMJ8KYo
	 U+RturPsBB6/g==
Date: Mon, 15 Jul 2024 17:09:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@armlinux.org.uk,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, arnd@arndb.de, Jason@zx2c4.com,
	rdunlap@infradead.org, akpm@linux-foundation.org,
	geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Hari.PrasathGE@microchip.com
Subject: Re: [PATCH v2 1/4] dt-bindings: display: bridge: add
 sam9x75-mipi-dsi binding
Message-ID: <20240715-washable-keenly-a76abaa59f60@spud>
References: <20240715095736.618246-1-manikandan.m@microchip.com>
 <20240715095736.618246-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rtMNhwSapse+vIdd"
Content-Disposition: inline
In-Reply-To: <20240715095736.618246-2-manikandan.m@microchip.com>


--rtMNhwSapse+vIdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2024 at 03:27:33PM +0530, Manikandan Muralidharan wrote:
> +  clocks:
> +    items:
> +      - description:
> +          Peripheral clock for the hardware block functionality
> +      - description:
> +          Generic clock to drive the D-PHY PLL block

What is "generic" about this clock?

> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: refclk

nit: clk is redundant here, they're all clocks :)

--rtMNhwSapse+vIdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpVJswAKCRB4tDGHoIJi
0q2RAQD8xX97GhfraF1NjbALVGWRMAFNTzFTnzurzE9Q3k80dAEA/np8raSeahoP
MDtmFTYmVvQEWF6ifUxJrGmaQHcEzAg=
=a1J+
-----END PGP SIGNATURE-----

--rtMNhwSapse+vIdd--


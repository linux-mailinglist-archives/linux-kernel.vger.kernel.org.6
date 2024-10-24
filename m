Return-Path: <linux-kernel+bounces-380305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E49AEC16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92AF1C21C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8416F910;
	Thu, 24 Oct 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFVTXZV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E11D89F8;
	Thu, 24 Oct 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787411; cv=none; b=g0gf5tIr3czv3MKgtkxHGhd1ZXre+fCOK5lRFrvhcxwugZuOmYgFlwoyensGDuL/x6yhmlMU+lhuqyrXPyiIrNnneIllnazk/3dHm4ixH5ltKHm4aVYKBzlccUrkjEHbrCWsH8ONVIzZbgGPYIDvHFtyMPggw570Gy5aLIvtokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787411; c=relaxed/simple;
	bh=baCRscFJcyoIeJGjDhH7YHeA+ksnEpgYG35/hHxCOto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxQAjsWY86kN+apmIHbRocKoWgARms7cObbwjR3ZVN9TKIwodXD6R3TkSZPW1xBah1LjSrn30faGbLdaRiqelGPLrn2xnvJ/V/R6UjY+8rqh7sgCDh+XJmt0GwipfgpX2Xaee//0i2t3XC0CVoyRAzOBLYeFOk+nkcPQ/9bKoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFVTXZV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5748CC4CEC7;
	Thu, 24 Oct 2024 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787411;
	bh=baCRscFJcyoIeJGjDhH7YHeA+ksnEpgYG35/hHxCOto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFVTXZV4yGAsaKqgM5OMp7eJbPpb/WUKmiQiyXJ/S7l43PIBrrz6NbJx8SUpmkKws
	 dMPjoNEEFiKTqyfRMKbhabw1+EUjGhCtWJnucDPpam0GwHPOk9l4B61NXkX7wrWT1T
	 OFr5gy2LRxshLdhW78CL/BMHSlbEfcsFqlnKhXDCrIesy2ycV90/axFKPXVSZkFbdj
	 GtDbfcmxGDVzmd871dZsyorgXUJLWR5POmBnKqXnzjiNcl9RlQV/KAzu8FiEe0EvCl
	 jKMRhIUpJBq1IB2LjSMdIuZ4xkngxXWMh0G0EvVRB4pqhP0/J7K2WZjnkvvOGanwNa
	 ReN0OU1DUu9gQ==
Date: Thu, 24 Oct 2024 17:30:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: sn65dsi83: Add
 interrupt
Message-ID: <20241024-cruelly-wool-f03401567c51@spud>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9GMWCsnkIho7utQ/"
Content-Disposition: inline
In-Reply-To: <20241024095539.1637280-2-herve.codina@bootlin.com>


--9GMWCsnkIho7utQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 11:55:37AM +0200, Herve Codina wrote:
> Both the TI SN65DSI83 and SN65DSI84 bridges have an IRQ pin to signal
> errors using interrupt.
>=20
> This interrupt is not documented in the binding.
>=20
> Add the missing interrupts property.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--9GMWCsnkIho7utQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp2CwAKCRB4tDGHoIJi
0nElAP4nxMS+d9i9cBJT2NS/4zKx3DyetfbIhEUQg4atuPvAtQD7B9O02PJmTQQv
HKR8oXpkoaC+W1Ia0J96LgL8Q/LG8As=
=pY8d
-----END PGP SIGNATURE-----

--9GMWCsnkIho7utQ/--


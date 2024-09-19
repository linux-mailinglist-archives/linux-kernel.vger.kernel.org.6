Return-Path: <linux-kernel+bounces-333183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472497C505
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AA91F2207A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90244194C73;
	Thu, 19 Sep 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi3QUfE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8722098;
	Thu, 19 Sep 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731784; cv=none; b=h7DCN8BZCimvfWZwW8+aROryarGuBQLFYMSbTzzr/QbKo8flDXKzTovT/Hx9TIfe6NZDKx4Bs+1T9Wu2kPtvGOkFJ4G7vNjO1bEiy9ARqWSrY+ayFNFjPouIi6qN8Ye/EpMDiJdjdIrgeELU/8I9UbPMuo0yqJM/SpeVjNmHBH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731784; c=relaxed/simple;
	bh=2FlpB400FYHilY4CRboRWeQa299N/BZffZFhKBHPz2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig0SrseCCJV3q5ilUm8A9eu27oXCK98TMUD8DDhG9uckQEwA4X8ep0hIukvrNNpPvBs71BCte/iNaI9TBa5LQBFV3TW7auJD8uKMu3w8BBupaHTOMftpFuLPZ0z6Gt9pgO8+T+MGGTyppYYYE3zC6x3eDwR4V9mX1U94S0gi8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi3QUfE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2D8C4CEC4;
	Thu, 19 Sep 2024 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726731783;
	bh=2FlpB400FYHilY4CRboRWeQa299N/BZffZFhKBHPz2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fi3QUfE4kY3F0uOwhIVxeTAGSmTF5x2wmIHr1IRHBxyZSiYv1cKDlLDjlngwV7vlT
	 NcopmbLDHK1sFgeFEC4nBIAvUUB88XVv0HH8pYE8LBbRyMa1CtZZsxeQKShFkpoT8i
	 0esdVkLuh1TmKZpMusJFNubHE+74jhHtxElb68F3RZxJmoG+1wcd3HuDuFXNuUJX/w
	 xqXp00i0YttNxS5xtt0RrmQOJRUz+r7+ISMO7pTJB67koVHqwucfPlr9fXmiQhall8
	 g3pGGBWTvr4mi4z8WWIcKcSs1S1ynvr/v5BD/bc7nLEckwqJTpMGzldDh9GVuhu1r4
	 6cznHVTKrPCJA==
Date: Thu, 19 Sep 2024 08:43:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@armlinux.org.uk,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dharma.b@microchip.com, arnd@arndb.de,
	hari.prasathge@microchip.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: display: bridge: add
 sam9x75-mipi-dsi binding
Message-ID: <20240919-economist-aqua-c22a1028e87c@squawk>
References: <20240918103119.385597-1-manikandan.m@microchip.com>
 <20240918103119.385597-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6wIDwJY7kKxRCN4O"
Content-Disposition: inline
In-Reply-To: <20240918103119.385597-2-manikandan.m@microchip.com>


--6wIDwJY7kKxRCN4O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 04:01:16PM +0530, Manikandan Muralidharan wrote:
> Add the 'sam9x75-mipi-dsi' compatible binding, which describes the
> Microchip's specific wrapper for the Synopsys DesignWare MIPI DSI HOST
> Controller for the sam9x75 series System-on-Chip (SoC) devices.
>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--6wIDwJY7kKxRCN4O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuvWBgAKCRB4tDGHoIJi
0oiwAP4u4WtSIv6pvtbS2rA34vpsQzjx+zSrniNVEUYAyvVCyAD/Re51iWR/25NJ
pZ8fzikS6TfOzSc+u3p5O5551zi3rwM=
=yxo/
-----END PGP SIGNATURE-----

--6wIDwJY7kKxRCN4O--


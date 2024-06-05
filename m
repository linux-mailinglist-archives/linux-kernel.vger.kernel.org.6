Return-Path: <linux-kernel+bounces-202935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33768FD33F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F59EB236C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A844188CD6;
	Wed,  5 Jun 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnIbfvXz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD81CD25;
	Wed,  5 Jun 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606565; cv=none; b=pnMMoWWStge6OF4wwzBy5uZUPIo1DsO+DHSC8qNmrwl3zIUIT4tf30YhSd2IK9fYIjrtSU/43wTiWHb2bMJqfzR6aongFnS2HViyeH4rlowu4vq0N9lZ4o5+tfd4Cn2urNzxBxLlFh2jHh2MiEYuXPgvxYnhFPciBsWssctP7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606565; c=relaxed/simple;
	bh=DY2nt+yBAcKyIj1DY6uk3CsThucW/03Qo/Lo9LSgM1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXb3Px24/rmhNO7Pr6P2DHUGbPP0IXdclru7y8d6RDcUNP9RvVMWfrOR0c4JvfY8t3nidNqM43nxkfh//shLYIsGr3V7M/a0f20ySWA6iEiaxbZxUILT0icfMyZRdnwhavaSRaemVt6wlXhJBH2l9noy3tjo+Nr+sxsfO7aRkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnIbfvXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFA2C2BD11;
	Wed,  5 Jun 2024 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717606565;
	bh=DY2nt+yBAcKyIj1DY6uk3CsThucW/03Qo/Lo9LSgM1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnIbfvXzPkP/kZ49+TPd7h9bSGyyF6qc+IZppDOt7SYp4aPPsN0fNiLA/uc0eg4m2
	 x2QanzgKHq4fl6UJsFobyTqveNEw1kP8IU+uQcEshNTgiUEGdho29tEIGm8azVqCBQ
	 TSsHlrov+912usOc4wDUIy0URbHcPgzvn79Ej9JHhPjGRSYUPaeDSS3SxhUMrPCg51
	 h0ilW7gVXLZq41jkxzF1tEE2aPBsQ07YgWfGhdhta6fIMKXb03kIS/pAYayzlQDrTl
	 n2ZbTVXrAkI4NU8pxyz85cy03/e+fVpgVcquTc7EDmBXwFRuawOmG5uonBNGh6L5c8
	 EKWm8ypMYQS7A==
Date: Wed, 5 Jun 2024 17:55:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wronek <david@mainlining.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: constrain 'reg' in DSI
 panels (part two)
Message-ID: <20240605-onyx-gloomily-835e383c7be7@spud>
References: <20240605105659.27433-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LcKx6aW3d2vGZ/ji"
Content-Disposition: inline
In-Reply-To: <20240605105659.27433-1-krzysztof.kozlowski@linaro.org>


--LcKx6aW3d2vGZ/ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 12:56:59PM +0200, Krzysztof Kozlowski wrote:
> DSI-attached devices could respond to more than one virtual channel
> number, thus their bindings are supposed to constrain the 'reg' property
> to match hardware.  Add missing 'reg' constrain for DSI-attached display
> panels, based on DTS sources in Linux kernel (assume all devices take
> only one channel number).
>=20
> Few bindings missed previous fixup: LG SW43408 and Raydium RM69380.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--LcKx6aW3d2vGZ/ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCYnwAKCRB4tDGHoIJi
0i4wAQDQf0XShqF8XmyalzFwEDtX/8sM8MP1yBrYStOZ0Cxs2AEA0uIX9W82pvO5
S2c0+9zOWtJ0bnh5sC8u7nNIqxhMVQI=
=zN4v
-----END PGP SIGNATURE-----

--LcKx6aW3d2vGZ/ji--


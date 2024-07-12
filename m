Return-Path: <linux-kernel+bounces-250712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D17092FBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159CB1F22F82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AB16F909;
	Fri, 12 Jul 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC5E/aW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF82BB15;
	Fri, 12 Jul 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791977; cv=none; b=NefwvQOjQh/mk/5GkBedNmqI9B6l8FmLVGGrLJls4qIfAyKJ1wx+oCkmnVul2XgkQWGYez9LjM2zfPV/3iqsTcHm+mcbimdoq6Gu2gxj8yY1lFbRrDrCKSvUkioiI3I9wVDQBXOiHvl9SIgXLiEkQX/0Eruhi23SMNEB9BdUq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791977; c=relaxed/simple;
	bh=u1Ze5I7DNb1Vy+REe2aJrWH406ajYpumnP0nla0bqYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFSUoK7DseNF/sA8SDsvPDMKjXNdouwkM/lohU2pwqF9SFC4FuvwOxG12ZBl9fAeWzS/ooD4eFBm6bkV80t5PLW8EWZvj+o3aJap2dsNnsyS8bm4y350/qQHEIejTVIBGC7OUnZ9Jeb9RisMMEXUz7bi6RVR1MpSrw5rCY2NNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC5E/aW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0576EC32782;
	Fri, 12 Jul 2024 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720791977;
	bh=u1Ze5I7DNb1Vy+REe2aJrWH406ajYpumnP0nla0bqYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FC5E/aW6GcyW9YN1lenwmb36WQJaucuizd5Uako/1/qalRDZz+1M1+Wn2DpsH//ke
	 gNkG0zlnmznRJcTGvM8D0I5tBOoXtyZX4OWTC4lsc/rgfUzFUOjxtW3aAv+oIBOnvk
	 XbeTJK5tmqP0aa1dM44GCcsYtD/4Ha25gCSSzZXxJIadrlrkdlPuGoIqg6XpHatmky
	 gKGfmc09ntKfVjFutXWKaKPWR0v3oznU/qNdQSOuNLWApDieYcCzTbsv3RwxFYDPq9
	 BaptYnt0SP6Z2QXhtoZlzGfoy+vlWd5JgCDv4wI947oD59wgFHVuYUqzZOW2o9OoVX
	 oxezNgTKPOYkA==
Date: Fri, 12 Jul 2024 14:46:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Document support for
 Innolux G070ACE-LH3
Message-ID: <20240712-prewashed-helmet-42fa3bb3a273@spud>
References: <20240712-b4-v6-10-topic-innolux-v1-0-bb0acf273d0d@pengutronix.de>
 <20240712-b4-v6-10-topic-innolux-v1-1-bb0acf273d0d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CvcruEIadur+7RjH"
Content-Disposition: inline
In-Reply-To: <20240712-b4-v6-10-topic-innolux-v1-1-bb0acf273d0d@pengutronix.de>


--CvcruEIadur+7RjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 01:05:55PM +0200, Steffen Trumtrar wrote:
> Add Innolux G070ACE-LH3 7" WVGA (800x480) TFT LCD panel compatible string.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--CvcruEIadur+7RjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpEzowAKCRB4tDGHoIJi
0mNGAP0fUUlEOXMsE1rO4gudxzQUpqN7bYljrncEDZ5iReEVFgEAmuB5hL6C0UOy
gX+xWGJIfms+nnhstNjfbvdqdAE6JQU=
=4o+I
-----END PGP SIGNATURE-----

--CvcruEIadur+7RjH--


Return-Path: <linux-kernel+bounces-204636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8F8FF18E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA061C213C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14950197A90;
	Thu,  6 Jun 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNGO0PbO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E87196C68;
	Thu,  6 Jun 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689940; cv=none; b=XuSb0u5vwTBrLhnzYxYnqAR7MwhprS4uwlFxocsoMNuGN4YYhNQzUQbaYmxNFpwgge6qbO6lBx2+CGhKwvplJwRYKFNnqP04fqGMIzdNZdCkUb6pwvGaT24cwXyLUJM+LJHJTLkuQ7xDBpQnExtoRqdOl5YYruch7muxYn2SfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689940; c=relaxed/simple;
	bh=Lu8jE+PpQrJ9rKiJgM4BtzKKEXwwzn1wiTlU2tSNTrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXMkq16sg4qJKE7Lr2ZTnC+NgRu1rcQU90SDl4FnnWH7vbDfs8IxPFzAX7+waIHO09Yc4sW8O6MjBe2jDDUwsIGWEFQj3OvjJlaMBTYZ8d/ClhJkT5mtQUJt5aqq75phG8I3+cLOGa7fnDtMCGmwMOr/59h3KzEYm9LASIIvD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNGO0PbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D407BC2BD10;
	Thu,  6 Jun 2024 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689939;
	bh=Lu8jE+PpQrJ9rKiJgM4BtzKKEXwwzn1wiTlU2tSNTrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNGO0PbOZdvXPRWlJYkCYaQHf3SEe5vPvKRl9if8VRl+HSAkJ1/IiBwZTgu9GovXe
	 4NZxaa3zBlTOP3SB1oxjixNj7P9F0TrxCQajREW/VdC2IFMn6+37aJPd2ONPvQhfhe
	 YR46CEmv9kLvAbGnF66f1btEx9O2eXmbxaMhEBB3PM0A/T6izR8tSEyi4dvFp9cAJv
	 CTpamye+1Nml5FGHJnD07st+YKW49u+T9saKeQBYKR0KkyVz3AnFFzcp9WY2vnjYX2
	 1Aj4ARKDdQ5Xj/zZtS+4IrHRS1HuNHV9REANUCamL1PdXjlWUi3pUZEjHuSb3YA/yV
	 rJMgXbR/g0dJA==
Date: Thu, 6 Jun 2024 17:05:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add PrimeView
Message-ID: <20240606-bony-uncork-639bf5f5a86e@spud>
References: <20240606080104.3663355-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OzGtGIXnx3xQBVvB"
Content-Disposition: inline
In-Reply-To: <20240606080104.3663355-1-primoz.fiser@norik.com>


--OzGtGIXnx3xQBVvB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 10:01:02AM +0200, Primoz Fiser wrote:
> The Prime View International (PVI) is a LCD panel manufacturer.
>=20
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OzGtGIXnx3xQBVvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHeTgAKCRB4tDGHoIJi
0vSIAP4vtTElMVNIt+IxTzTFIyac8JRQzjmTj5aL6WHxyN2PGgD+P5G4G7qcpysY
/d74lX1VtZI5Kw1/vctZb5vGR+tbegU=
=xb4P
-----END PGP SIGNATURE-----

--OzGtGIXnx3xQBVvB--


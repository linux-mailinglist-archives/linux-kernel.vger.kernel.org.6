Return-Path: <linux-kernel+bounces-204638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315C8FF1B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C88B2BC74
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0B197A9E;
	Thu,  6 Jun 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzsTIkIH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30E197A7B;
	Thu,  6 Jun 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689957; cv=none; b=IK1kT/aKU2/oxvLOm/IDk4WLNZvBBllkU8zPzyf+kfmVDNPZ9vKwiKJISZLXZ5Hj9tx7/akAOa5bZ0gcNzPetjaMbWP9cEVKjHyWzffp/HN9pT5pX3Ijc3Eioaz3msyOJlye7iYPQ7EJ9Nz8kSMEyKbNqwZZRDZA5j1rz3xaplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689957; c=relaxed/simple;
	bh=B8oFRLGBFf9oUJJabHP/G1kxoGfOaFOryqLjdH+SGSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiQ1k5N3bugv8MgKiaZhoa8rlvMMz3Tw/Ixd8W80uPVKr56lcV6+qbcduD4CnTOEKfHGIGNaw1WBKcEVAOKVHYPm8RT7KmToKcxXOJpHXMKe2TS4yqKzdvopeXVTLSh/QcRlzaSFdP+onYa6vwq+0zO0Na+xv9uI+oT/2AgoxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzsTIkIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B8DC32786;
	Thu,  6 Jun 2024 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689956;
	bh=B8oFRLGBFf9oUJJabHP/G1kxoGfOaFOryqLjdH+SGSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzsTIkIHDNCs2FiL9YqqvipwrMQRBtAazzckMC8ufaumBOyktcGli0kpYrEn3OWkH
	 M9NbkCj/S8PjYfNnEkjjaVXmP5sceIWntZ54jdkNCXXn+6HjWQKWERLcUSO82NsCfD
	 CKKZLMu/KcQ7rFxoPtFjb2JCknafyR23JkcyunF134Knz9DswZbsQ4f3Yhmcqr1o8m
	 mDeezxCkbMrnqRyFZTwy1EcIGR9q6KIj/1gPlm4XLvFGvAexzDztghIS5WNuxnmv+G
	 /NichS6snCrCEL2oJqeJ9k/f8k5R+UlNVz8eoMmR0ua8WSBnE0PB+8g1JqPRpWyrEV
	 waU9JgGUPRwVw==
Date: Thu, 6 Jun 2024 17:05:51 +0100
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
Subject: Re: [PATCH v2 2/3] dt-bindings: display: simple: Add PrimeView
 PM070WL4 panel
Message-ID: <20240606-widow-siberian-c68601929e3a@spud>
References: <20240606080104.3663355-1-primoz.fiser@norik.com>
 <20240606080104.3663355-2-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jmniVyf0f5Z3Hun/"
Content-Disposition: inline
In-Reply-To: <20240606080104.3663355-2-primoz.fiser@norik.com>


--jmniVyf0f5Z3Hun/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 10:01:03AM +0200, Primoz Fiser wrote:
> Add PrimeView PM070WL4 7.0" 800x480 TFT LCD panel compatible string.
>=20
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--jmniVyf0f5Z3Hun/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHeXwAKCRB4tDGHoIJi
0ncXAQDMt6euY2YYZi9oiMgKaMustD63H2w1UmQ/Mamircx+WwEAwURL0IUhLdyN
k59gGQ4kRoEuKe/3upiVykYeA9CnoA0=
=BFmt
-----END PGP SIGNATURE-----

--jmniVyf0f5Z3Hun/--


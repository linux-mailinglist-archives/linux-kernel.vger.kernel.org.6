Return-Path: <linux-kernel+bounces-296928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB695B0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0241C229C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25C16EBED;
	Thu, 22 Aug 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImlOSxZq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934819470;
	Thu, 22 Aug 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316078; cv=none; b=fqmCElwMwJUx5Ks7jDlNnP3pJxsU3kehpusM7O+MnGz+R7VWgTPUpQtwi8/s4UUiy8WSbaZfkmxpkgR1rqTyNYqYLwxwpEffsp9fYdKMkyBh3zPbpmuUmhxODYzdWQFCTyZGG1WkluswbVoQ22QbU509Fh6hhAJ6Kg7MG/+WhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316078; c=relaxed/simple;
	bh=qfCsE2TARh/0Jkqs1tOSCtPuFozHgbbnBIGeahfVo4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taNK2d5HpxQh46kqE/rBN9QzMs9YEJNDYC6KXhzAdwUvXJLrpn37MCEWe/Ns4D5ZvGWLkS1wyNXMzYb+9j+INfZ/3JMynQCUbMnDgwPyyLVkPPvfTcfOu+/t4XS+Zh0cObgAIkQbz8R2W2+D4WuXx9UXsKNGKYKZ/8B3KsY7Xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImlOSxZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA19C4AF09;
	Thu, 22 Aug 2024 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724316077;
	bh=qfCsE2TARh/0Jkqs1tOSCtPuFozHgbbnBIGeahfVo4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImlOSxZqPU2Q0pU6PiB1Lrd06gaA6GAh3l9ygooynVI9lp1GJn398Le0w3DFW2Dc4
	 beVWkktTt4Ktr+VfuPtaDtr0xhQJq7Q/ImOyeTHo+bWYI9R/TQhkaoDL+3Fm7C+qKP
	 QyaX1MbnL1XzNmNx5fXaQI2L5vdYywsXzOTQJ3hf0SCp4Xp9tJfercshJir8dD0SmA
	 Lc8RIj1kG3pg7b7crOFi8GCrlgGQ6Pp23KsGG1NqIk8BYibZ1ySXDAWTbRz3cKLwOj
	 saAUZAyKd4AlPGd42RImlnWsxCSX/t7IBSzfRlgRprdFs2UEfrKb2YWCVHrV27OVMU
	 dNIoNoGWLm/0Q==
Date: Thu, 22 Aug 2024 09:41:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Message-ID: <20240822-pushchair-premises-f4055779216a@spud>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <7E8109D4-A353-4FE3-9152-3C3C6CB7D634@sntech.de>
 <2085e998-a453-4893-9e80-3be68b0fb13d@collabora.com>
 <4167579.6PsWsQAL7t@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z+weBBqJ58Bi1CtB"
Content-Disposition: inline
In-Reply-To: <4167579.6PsWsQAL7t@diego>


--Z+weBBqJ58Bi1CtB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 09:01:34AM +0200, Heiko St=FCbner wrote:
> @Conor: just for me, did some shift happen in our understanding of dt-
> best-practices in terms of syscon via phandle vs. syscon via compatible?
>=20
> Because Rockchip boards are referencing their GRFs via phandes forever
> but similar to the soc vs non-soc node thing, I'd like to stay on top of
> best-practices ;-)

If IP blocks, and thus drivers, are going to be reused between devices,
using the phandles makes sense given that it is unlikely that syscon
nodes can make use of fallback compatibles due to bits within that "glue"
changing between devices. It also makes sense when there are multiple
instances of an IP on the device, which need to use different syscons.
My goal is to ask people why they are using these type of syscons
phandle properties, cos often they are not required at all - for example
with clocks where you effectively need a whole new driver for every
single soc and having a phandle property buys you nothing.

--Z+weBBqJ58Bi1CtB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsb5pgAKCRB4tDGHoIJi
0rLhAQDqY1gu1PD4V30d8emILN4UQA7IqbfNHPYXVGBNqADBXwEAj497+bHi0qU5
bnjxze+ZiZvdByZ4C9o+h+n3wfVJhQA=
=vu81
-----END PGP SIGNATURE-----

--Z+weBBqJ58Bi1CtB--


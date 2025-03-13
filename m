Return-Path: <linux-kernel+bounces-559596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202EA5F5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD52F7AD6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F269267B16;
	Thu, 13 Mar 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th+xPZde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B979266B73;
	Thu, 13 Mar 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872324; cv=none; b=H7yuwqI9GX7pzB9zhmonnp7Mvb8NnjgmQGP4cspnU7K1XfSzmDjoSVyelYbbGBric0mMip3iZqb9XixXsLXxVxH+8arsac0c9Nu3UaKhyYAbbLs89zUImL55I+Gh1OKfd+XDgHzBZSp3ctrEo/gv4mUxQ6V15XA8G7We+H/OrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872324; c=relaxed/simple;
	bh=al2zcQDmwtKUWbmclpq3ELoeYemHTEjlcFVNlGyz3yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHqnimLYgxAwN/yWc7QQSOIpYDO7fdTlSz343H7x+ilJl1KGIlfsEUZFP/VAoV1z7FFY5/FEAfEV/Zz11AB/Xq8s8jc/8cQbe0UOtIagJpUb08uaesADnoTuNaNhZj8uqG7G/c4eKv49ZBwg/l/s1G9Z7b75k8Aik9LAnZTZ10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th+xPZde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2959FC4CEEF;
	Thu, 13 Mar 2025 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741872324;
	bh=al2zcQDmwtKUWbmclpq3ELoeYemHTEjlcFVNlGyz3yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Th+xPZdeERxaC2wiFVmF/PRtyPEI02iC+2EV4o3jA2yQ4WPBlX2ftcOTommSecJxE
	 4sUieqZYIoyTRmbEzPvifAwo4RWsoVeVzBMxJoeX6OWGHcU7UspXJQoYNMxh10HQ1V
	 1cn5rTh+zW9Gle94nMlNbkh0i6iY+bw3/INw0TcOhNqKEoFDdlYkuTyApOptB/e3oW
	 LfE2vkPqTl2M/g57nyg2+UTn5aKH/Y0y1xbTZqW8rPzVxhoU/YbV1CM2kSArlu59bz
	 7OwyMk91/tK3vGf6peK82IV/0NZH8UbOaJqvWAy0TIuSE2SFVHNVOw/hQ1+YYOoeH5
	 kPrW1pyOhQMIQ==
Date: Thu, 13 Mar 2025 13:25:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Artur Weber <aweber.kernel@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 06/10] mfd: bcm590xx: Add PMU ID/revision parsing
 function
Message-ID: <ef190ba8-a5c7-4a1a-90e6-2610de00e4ed@sirena.org.uk>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-6-ae8302358443@gmail.com>
 <20250313132036.GB3616286@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zA5H0OQ8I+S+JApb"
Content-Disposition: inline
In-Reply-To: <20250313132036.GB3616286@google.com>
X-Cookie: A beer delayed is a beer denied.


--zA5H0OQ8I+S+JApb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 01:20:36PM +0000, Lee Jones wrote:
> On Tue, 04 Mar 2025, Artur Weber wrote:

> > +	if (id !=3D bcm590xx->pmu_id) {
> > +		dev_err(bcm590xx->dev,
> > +			"Incorrect ID for %s: expected %x, got %x. Check your DT compatible=
=2E\n",
>=20
> Isn't it more likely that the H/W this is being executed on is
> unsupported?  If so, say that instead.

Given that the compatibles are device specific the driver shouldn't be
binding if the device is unsupported.

--zA5H0OQ8I+S+JApb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfS3L0ACgkQJNaLcl1U
h9D2Jwf+LJ9CptsQQnbZJuRjlklwPrVqGyiDX99suQr9q9YFQWF4U2tTi8mAAQd4
c12oshx+70ZwrEMiSS80yLHI3hLqDw1fpVK1vCsV/57kNpnT+l+vNdSd4fV73UG2
0vjsnuhC6LDgJQZdBM6rnbUp2hruF/NUgHoFSyZzokDLgf8+DVNHGo5I1LS9kvOF
oygai/ITH7qOfgnRbyTfsMvdo9Afo69kwsakgJi1RJZQyr1hpMm9qTnhg9EBLpRZ
/4dCZK3tmBlT2J0nNIUzQey6ivAd10SfaFk8tPFNV6NW2BYNN0TfYtX2hWwvV+o7
UyoyLAM/HCEeeuvXHlvqY6dIxTr6uw==
=vJeh
-----END PGP SIGNATURE-----

--zA5H0OQ8I+S+JApb--


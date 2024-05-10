Return-Path: <linux-kernel+bounces-176241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B98C2BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894F82834BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027413BADA;
	Fri, 10 May 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpKIKi83"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38B101E3;
	Fri, 10 May 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376797; cv=none; b=T2Kj0AJtZYc4rIBrQxOeCoO0HtsVknbeSvyCMO0SC6EdGw/MKP1firQsoD9LYBd+mSAInb+ZZt/j9i8EtUfejElf9r4G/HY4MnIJDWzn+qOB/CL4tJyNcSX5uf2aYzsn4FtkI1Ek4tzrZ2rOdT2yAtKlX7UiurmCuCU/L2XjtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376797; c=relaxed/simple;
	bh=bE3l+ev8VCdNSIPk1AtTtQU/j7iutwHYqRX+Ki/6+z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POuwu6lpO3Ahz+QshP5kTMj8lKx6ELJxhwn46ydiCby0SeprEBLv16szucmAz3mV+uA+RwLqV9BXXQCakwK8Tu8E/jkOAYqs3duvj1xPYimTOskkZuEb163BiP0VRJ7cv6P0HRNsQViLAuIKWbwo3+d6PPlHcPJYtAQ1AcvchlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpKIKi83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD64EC113CC;
	Fri, 10 May 2024 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715376797;
	bh=bE3l+ev8VCdNSIPk1AtTtQU/j7iutwHYqRX+Ki/6+z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpKIKi83K33KKgIADCaM+HXqApDGt+rjsvZsCqPFGnySlRFtpyKpFyYk69YyNFXVD
	 lUPZ48F3qhgrHG1sqScGYcXFbzZ3VtJ/geTUPl9OpZKjCtsDNF6jqTzGVU7fOdFfZQ
	 St1oW7BRdWt/Fp3uAFYtnVNvK8+n6NHsySYgA8JAVHLJ+Bo7s7dhv+w3JOxn/1ry0+
	 lHJHoXl0qPjKAHwl+sHpNu9R+3KNjzEAwBYvCWl+kiB3PFNQ2yScIy9MHvV0DKWQfu
	 e+4IsXCqSETqeTEEPlb4j/sSzQhTwHen8GY1QyScjMifWCD6kAx57qieUpzokxjloB
	 mD06WRatX7YGg==
Date: Fri, 10 May 2024 22:33:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Message-ID: <20240510-overreact-snare-05566341fd37@spud>
References: <cover.1715332922.git.andrea.porta@suse.com>
 <e60ee068f06cb2325e3d09c27b27002ba6db8572.1715332922.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9NNELCBQicXb1IDn"
Content-Disposition: inline
In-Reply-To: <e60ee068f06cb2325e3d09c27b27002ba6db8572.1715332922.git.andrea.porta@suse.com>


--9NNELCBQicXb1IDn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:35:27PM +0200, Andrea della Porta wrote:
> The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
> acknowledge its new chipset.
>=20
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--9NNELCBQicXb1IDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6SlwAKCRB4tDGHoIJi
0ir4AP4y5rWoOar+b5VqUrLRqKg83y525THu9cNaei5eGlmReAD/bgLHKvey2sIN
C+9FmgTwDpu57r0w81LZFtdTdzrpCwo=
=C7UR
-----END PGP SIGNATURE-----

--9NNELCBQicXb1IDn--


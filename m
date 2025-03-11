Return-Path: <linux-kernel+bounces-556235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8CA5C2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A217173B23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413551CAA99;
	Tue, 11 Mar 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOy4EDUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C91C695;
	Tue, 11 Mar 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700825; cv=none; b=tlHBjElTujFuvPeY3gpwJ85Fzfw2Y7gtemHbUopFWV41YslOthb9JdwAMG14bNwxl/MOc3qsfehHEbDbY0yb88EUPmROwwke4dupcBjIunrHKl5nn3Fvj8WfgWsIgF/MkXrW07fMW7NNmDRxj7FM/i07eh7FQ/RHhdc+xn67XlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700825; c=relaxed/simple;
	bh=Ks79q3PdfPbgV7WZPHY/OZQq2hYaO4BUJ7g71vdsaZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g916BhYOC2ERn9vUqhSio/12EuVoVxTDKc5W3FX0htxkUwPbo9ImZ0W3tBQUzk8QvwupCr9gCQsDWrAypS6S82DN3amiPyTvcrf+m0gjE680YfThXwnZokDOBURvHgZ/WvsxfWCxqovM3CpS3m7RQGI5NouHyhrhaVPg/TKHc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOy4EDUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4932C4CEE9;
	Tue, 11 Mar 2025 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741700825;
	bh=Ks79q3PdfPbgV7WZPHY/OZQq2hYaO4BUJ7g71vdsaZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOy4EDUVZLAeSM6qVj5+8lwd3u7/GH6mAM73kNUP8q0wPhGTCqqfiaouc5YUYrg7c
	 Ua8EvDHKIGeausNVaZiUOK56ItuPdBXmbBpNwWVG0Hq0LJsfWTh3bvDYF6XbovkjJq
	 oU8sFDN7geTVynpW5AoFvLEgECL9xeW0jRqb2qL+bEWjQ4IfM94nbRNwVFv+OCEuci
	 P1LG+y2E6LwcG2QHPeW2ijdNCbweEC6RpWGHo29TcKiIUHIChszgVIk6MevEQwagYv
	 LhHM9xlvShdL51qRHylV7RMwmc+aKsCf3FsKJgCOrTC2sGzc5coQECOt/LXZzAFdkC
	 e2aVmrlAiaBfg==
Date: Tue, 11 Mar 2025 13:46:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <0898b492-71ed-4df3-bf81-c3965e4c7ec7@sirena.org.uk>
References: <20250307135244.100443-1-francesco@dolcini.it>
 <20250307135244.100443-4-francesco@dolcini.it>
 <20250311-solid-poetic-camel-77a29b@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xBNvsn2EDREhNIob"
Content-Disposition: inline
In-Reply-To: <20250311-solid-poetic-camel-77a29b@krzk-bin>
X-Cookie: Androphobia:


--xBNvsn2EDREhNIob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2025 at 09:42:45AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Mar 07, 2025 at 02:52:42PM +0100, Francesco Dolcini wrote:

> > +  wlf,in1l-as-dmicdat1:
> > +    type: boolean
> > +    description:
> > +      Use IN1L/DMICDAT1 as DMICDAT1, enabling the DMIC input path.

> > +  wlf,in1r-as-dmicdat2:
> > +    type: boolean
> > +    description:
> > +      Use IN1R/DMICDAT2 as DMICDAT2, enabling the DMIC input path.

> Are these two properties mutually exclusive?

No, it's one property each for the left and right channels.

> > +  wlf,drc-cfg-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array

> No constraints, so I assume you can have here any number of items?

Yes.

> > +    description:
> > +      List of strings for the available DRC modes.

> Why the actual names are not defined? Why do you need this property if
> they are not defined (thus driver does not request this by the name)?

The driver displays the list of names to the end user for them to choose
between.

--xBNvsn2EDREhNIob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfQPtIACgkQJNaLcl1U
h9DqrAf9FPeVNyhKwWp5Ve2KR5McTB+DsznkYu5t9CbX5pm93WSFXYRb+kx1UAOr
HMUAvftqWQheMNCZUD+cYjyKIKH2NntaAb+t2soOI/E79U1iEIOhk00TpfjXdVW7
pacQzolSR7RReIvNCxRV49BEaCKc3BaP+UcIGElkMfTZyFH9jFcG9oU/wkdPwIYH
xJ8j/XfgOJpIQFij+UB8ZEwJm3KVm2L/GmMygi3isIWMqYbZnBCrIxLr3T8zo2qN
RClpfcBGthSgh7tT/3rVV8/Y/zVFZyT1CZwyhKwCP/hsoLJDuQNyMNqI/FY98RAN
e49xJj7w5Qv4DA4qZUFMn4pwo3K0mQ==
=LwZL
-----END PGP SIGNATURE-----

--xBNvsn2EDREhNIob--


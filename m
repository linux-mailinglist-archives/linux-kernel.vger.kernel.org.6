Return-Path: <linux-kernel+bounces-315653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C196C569
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CA9B2403C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED31DEFCD;
	Wed,  4 Sep 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn0N2Gr6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19E4778C;
	Wed,  4 Sep 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470835; cv=none; b=TT9Y01CiCJHMzpHWIEzj2ZuXyG10dFP0wtW/zbJr3XL4/dXUCzgFS1lJJHaCkQ31N8RKXJtdjPOq3mLfrI7Cn9tqR26pA2XmKk3u/FEucjkUqodikP2ZpPTeoUC/Y1kJWluKAl0dhwYRBNXhsceq01dOClUoIl2FkpTHUZE4ZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470835; c=relaxed/simple;
	bh=0oB+h2PhvzTSs4fr1OfLknaixVNmBNFPA/pyFAhoqQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9BHaBUB1INMNCvCWeu+SZ0vLJojhIslG1kR73La8aCWxV0T/mXWENZKYHSilo5XPER0LNM5wBkuYKH6wF+zK19ZenfjFdpBHNXmKqRIV2ElbJai4T5qiYkkZukKrPbgKvoI/ThJkoV8cj7CvPpabw0O/QK+W7bbtPS+5CBeCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn0N2Gr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D865C4CEC2;
	Wed,  4 Sep 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725470835;
	bh=0oB+h2PhvzTSs4fr1OfLknaixVNmBNFPA/pyFAhoqQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jn0N2Gr6B2dzGEyrfKLldvYgYNsuotQy90NgjEKdtkadrXqOPntThkDe3kqxdkbwU
	 3pxa43PpV8zmEcJNrb2QB79/QaVQpW9iGQ8dP7QW4aAEr+Bi3HiS1SYpio/A5mFglj
	 D46GKnwSnyyCu9tTJMMqaqxdOA7dPPOy19nDyN8Siit8MKeJ9TOov6qRjKDwS56fw0
	 wgCDNOCGZ1c+8axxdmShT0IGgJbKvr7vXIloqwh+qQs8ZtXwgm5Dhj9KRQ0x6NBj8Q
	 n23dVIQDM5ze8ta7FlhjX+pUNgJ+Pxke5wt7hSxUl27HiCu6aGc2jm96GxxSN4ypPv
	 04Mzx279aVFnA==
Date: Wed, 4 Sep 2024 18:27:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC/HDA cs35l56: Remove redundant IRQ handling
Message-ID: <6eb95724-9ba3-410f-a42e-e1013c449458@sirena.org.uk>
References: <20240904120700.188644-1-simont@opensource.cirrus.com>
 <e1aeb66c-ecb3-4778-b306-f3a212caf879@sirena.org.uk>
 <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yS1URVebDMM4Ze5M"
Content-Disposition: inline
In-Reply-To: <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com>
X-Cookie: Linux is obsolete


--yS1URVebDMM4Ze5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2024 at 02:46:30PM +0100, Simon Trimmer wrote:
> On Wed, Sep 04, 2024 at 12:25:00PM +0000, Mark Brown wrote:
> > On Wed, Sep 04, 2024 at 12:07:00PM +0000, Simon Trimmer wrote:

> > > The IRQ handling in the cs35l56 driver was purely informational. It was
> > > not necessary to support the HDA or ASoC driver functionality and added
> > > unnecessary complexity to the drivers.

> > Given that the code is there now and has been since the driver was
> > introduced about 18 months ago what's the ongoing cost of having it?
> > The information it's providing is notification of hardware faults,
> > reporting those does seem useful.

> Originally we were expecting to use the IRQ mechanism for an event logging
> stream that would function in a similar manner to compressed streams to be
> able to get an information feed for debug and tuning tools, but those were
> never created and the logging infrastructure not implemented.

Right.  Though ideally we might actually do something about some of
the errors that are reported.

> It's quite a spread of code and a lot of complexity in the regular execution
> paths managing them / synchronizing the contexts, there is more going on in
> the SoundWire bus variant compared to the conventional i2c/spi that it is
> hard to justify maintaining it all for a couple of log messages - in the
> event that someone did encounter the two situations being reported the
> regmap dump would point us to the cause pretty quickly.

I'm not sure how many end users are going to get as far as talking to
you in the event that they have issues - people often won't get as far
as trying to contact their distros or upstreams.  Even errors in dmesg
are pretty obscure but they're more discoverable than interpreting the
regmap, people would need to identify that they need to look at the chip
first and actually be experiencing the problem when they figure that
out.  Ideally we'd hae better handling for this (I did note that the
latest Iron Devices driver will back off speaker volume during a thermal
warning which isn't a terrible idea, though there's potential issues).

It sounds like the only real concern is the Soundwire stuff (I2C and SPI
interrupt stuff should generally be trivial?) - if that's the case I'd
be more inclined to only pull out the Soundwire bits and leave the
support there for the simpler buses.

--yS1URVebDMM4Ze5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbYmG0ACgkQJNaLcl1U
h9CWaAf/SZYintLOxVkSO/wJvznvuXO8nkPUG7BDqNaMyap000lphqeP9Q7omZrg
wsmJm/om/i6qef2DCsrJxNKU0DRTMXx9DH1/rUnfPBn2mAjqWCFYLPXBtoBLVHwU
4YZ1IEDV5wYtrz/MPBz4PPTfjYv33IFlxKEzBaw5N2nTnfewjAk6zBws/x+CSrUG
dIR12Vzo7XrcLufw4uexjqTMsS05FKAQT5roUTpXIWnmjqG6hVToKL6pOSijWMeK
eN2rktIo40P3HzcF9WMCbY4Gnn8WY1RoPHCnNn5CI0WlxF2h/Kj0gYB3tbdx0419
JE8FZCb/CtMhGH1ilPHFRkh29lptwQ==
=Kn4O
-----END PGP SIGNATURE-----

--yS1URVebDMM4Ze5M--


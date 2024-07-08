Return-Path: <linux-kernel+bounces-244534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F34F92A5A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7098C1C215AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1B14372D;
	Mon,  8 Jul 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHv8q685"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4F76035;
	Mon,  8 Jul 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452534; cv=none; b=VlpBdmT+Tx4eF6b3bCMNTkXuLcR/yflrpzBf0vwsSj9Hdzz6Rh+rzm0hU0OrBmKYFB99uVI46LmZJ8OOgRKKmMrqzsl34QASkZjAB0hAR0G9ouGzxlQrabSQ1CxPzNXygyo+oQdrvzUAyZ7O+rNp+ufs55dtQC0iqUNezkWo6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452534; c=relaxed/simple;
	bh=fGNrG710KVQF9G4461uY3S5esz47alZUo9ZD7VmRx1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkJaJNHP/2B3xL+8TWbVbCOgEkUpw801e8yNfkVoP4pRLcH745gq3E/7Kwcq4KbNKCpb9SMA0rZqtKclwfMMuDL07sMYM3mLP8Y5guGeZhqfZfefTWxy8X7kqzpv+nEeVD3HuZicoS0kqbLlq5CNAlJlBqF+O0SRMSJuIFUnLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHv8q685; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F53C116B1;
	Mon,  8 Jul 2024 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452534;
	bh=fGNrG710KVQF9G4461uY3S5esz47alZUo9ZD7VmRx1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHv8q685WKRhC5W483Xt1LsJAVW37UKg5XgU+g+ePd2Bx2J1Te3H8iDDICzUZc1W7
	 +F1SWzeEJz2P476mWOb2gbe6Vz+cWIimerXuNIHLa4pruFSHrVerasWHCdpfroA6/H
	 CCWUhWHQs2ULCcLFeY/0GINwCuhv3LR2tYQDhGuso4TfQkC+4tr2GLDCGy3J/ow3Z9
	 wisn11YY63nAZJzG4mCVkcPMd4lLOxffTZeGRHN00ReLYTCCBXUIIoLtFdoUr4wOF7
	 b0rbrfL50qADd83cMXVeW5ByM4YvK6gIWGjbfiqU5rEwbAT99g1KFXDUT1st93Qc9l
	 /7d5EeBQoSagQ==
Date: Mon, 8 Jul 2024 16:28:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] firmware: cs_dsp: Use strnlen() on name fields in V1
 wmfw files
Message-ID: <cee81a44-f51c-4abf-81a1-36c40eff452d@sirena.org.uk>
References: <20240708144855.385332-1-rf@opensource.cirrus.com>
 <de44f274-4e02-4c66-b784-41031e99c33e@opensource.cirrus.com>
 <91fc7cb3-6a00-4b3b-abed-a3a41b191912@sirena.org.uk>
 <27d74268-53ff-4248-8d3d-71948ffcf68b@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/a5qg2alAm4FAP1y"
Content-Disposition: inline
In-Reply-To: <27d74268-53ff-4248-8d3d-71948ffcf68b@opensource.cirrus.com>
X-Cookie: Many are cold, but few are frozen.


--/a5qg2alAm4FAP1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 04:22:46PM +0100, Richard Fitzgerald wrote:
> On 08/07/2024 16:05, Mark Brown wrote:

> > git seemed to be able to figure out the context for 6.10 (I apply
> > everything with am -3).

> Oh, I read this just after I'd sent a V2. You can ignore my V2 if you've
> got it to apply (it's the same patch but with a couple of conflicting
> lines dropped from the context)

Yeah, no worries - git seemed to cope fine.

--/a5qg2alAm4FAP1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaMBbEACgkQJNaLcl1U
h9C0Fwf+I/ECA8qGlN2zBdk7W5C2CSGXpLEvJ/bHyB1CiL23NmykqK7pDqisuk/3
cbofSsQr66D2Zff8N4iJXtPawyHDuWPeDnY7PfuZp2Pz9pbYwJe3Y2N3s9qadS3V
tRSW2SpYUMCXkDplwj/YjGPtRnVE3EiI3xC2tQYvOrla94hDMLzFj7HmDZ9axU8R
Lqy6v9y1c7LTeKRuhKM/qU9VVBWq9PNTy/qYyxWFfgpg5syff1XZeLihnVn7knEc
xkS+oit7Ft+hPLx6i0hJzVrBmr8TnUUZRXwmbNyVySUt280vTcItEoNWAcr0pXP6
6iK7TB/5jqIx9vGmE3zlTp93equmag==
=VA25
-----END PGP SIGNATURE-----

--/a5qg2alAm4FAP1y--


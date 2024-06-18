Return-Path: <linux-kernel+bounces-219809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F090D7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3EC28319E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5147A76;
	Tue, 18 Jun 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKfKnfHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7EA374C2;
	Tue, 18 Jun 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726427; cv=none; b=CvPNEMYjpy23lN7PLIzcpdrEhpJznMgipvf0PBQ65cenKkYQFXc0laix1W30EtThTBqFp4v6E96tzRPMJ4EtYwz9cm8yiUs85qtXrsDpEfPa8MmTdInB2cH9Zo485LXlpTIANjbansv8Hr63HlvUZqfEvOphFSfkUVC1vqDZpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726427; c=relaxed/simple;
	bh=gGAzyIFzGGDKK8SXh3zCzIQoM2rl5XEz/31HIoG9EVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo4w6BUQo77wXGFTGqmCUz1lzbjd2kApyxVCv5rW6RLHsp6xjSKLrjTErszCTh+YyifAoFOf4fnV3MzCbIxQqOFLEJfwDSrjzhBnIUgJpVeIQkdA6PjSJuUy8T5QToFwg/yF+bEAvNI06F0pivX0c4VKSnF8sFQiqGZopvAPDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKfKnfHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDB8C4AF1C;
	Tue, 18 Jun 2024 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718726426;
	bh=gGAzyIFzGGDKK8SXh3zCzIQoM2rl5XEz/31HIoG9EVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKfKnfHYIzr74jn4RAxwFojT5SFTDksL1/d/wNaroGzQogdN5LNVWqUaO2ZMNe7+t
	 m5UmF0zimg/97dCATCe8BBFIeprEEx+3DVeJD2O9PDC2tr/VIBLiLNsQozt1dEOEdx
	 uwbhpoRI6AnGYEWNWPRntOJ+9rgxsw51fIYX2FmvEAO4eSKitxdJ6BYv/WzCb8K3Pa
	 zhORkJirpA98Lt84Pqa2evcuJT8Ut87XK5SOSIgFpXh9fvSLcDKU4lgKQ9sjzLsXcc
	 S/2ZB+Izd3SCxLCj/oDdSE0yj8iaisaUB1RWJuyeNE3O4m5z8EAzQp0lyqwni3fKi0
	 VspO/rkQ6ap2Q==
Date: Tue, 18 Jun 2024 17:00:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
Message-ID: <a2946d8a-1ead-4514-b1a4-9c04e37cd8a8@sirena.org.uk>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk>
 <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
 <007b01dac0c5$7807ac30$68170490$@opensource.cirrus.com>
 <f04958f0-b9e9-4f80-8a83-af9740fa83a0@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Atk4irYPm/lHjafU"
Content-Disposition: inline
In-Reply-To: <f04958f0-b9e9-4f80-8a83-af9740fa83a0@opensource.cirrus.com>
X-Cookie: If you can read this, you're too close.


--Atk4irYPm/lHjafU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 03:54:04PM +0100, Richard Fitzgerald wrote:

> So 0 is invalid. Question is: is it also valid to pass -ve errors, or is
> 0 the _only_ invalid value?

Negative values should be fine.

--Atk4irYPm/lHjafU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxrwcACgkQJNaLcl1U
h9CZCwf+MWegKStTJHnfpzHkwKbAeRVIQymvXLtQy3ewdm0Ii4UsrIG1892Nxa2g
2GD3D6wk6vtRahK9Ek6WTjg81a/B2v6CMwFeUWmb0CV6n1KXyicgFVyKtw4jJcL6
M/G0D6Z6KKfRsKcot4JstoeMaepv8pZ+znOn0vmDPRQrTk3gwDkPPyTTkbiVtYbc
PwJg4VtHZfyUgPzEhRSXz1LYp0npuxf17FBjAZFley2VwqmM6BLrYFrypqtXopM6
GS/InTSR7BsUYmcAfWc7WXdCy9BT+ibj5D8BY9/FRhHDv5nvyxrGavUEIv1SzIFc
dfx0dIe2RZMGDt4XBHsrpu2sr+Hu5w==
=a8if
-----END PGP SIGNATURE-----

--Atk4irYPm/lHjafU--


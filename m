Return-Path: <linux-kernel+bounces-407952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C969C794E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A767B39232
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB096165F1A;
	Wed, 13 Nov 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3TnfcT7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470B7C0BE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513116; cv=none; b=abR2PP+zjAgcKEe8nEn4YiEc+LZgj1CJfeMuEOgqVlLIcaoIPOKi608nVGqE+4m5jPL8yU/WLxml6SF0GeuSegDJyVPkJcnv/w4QYASrtYgQLTrPLpDl11tinZsWHVO6yZm5SxO51kDddLt8Pq/oqOJQzsRzxjvhi6L2WZggiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513116; c=relaxed/simple;
	bh=f6boPVQNKRLctRYv+g6GO4ox715cEjwUVoNwnAJB3SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWjM+POJ5jx9GqU3pqAbgy8EVUnvogdYS38l9LEsuBTUc5oeL2iBYM/7W+9H2sYzevbMKZRQ1tQm0rg2xqefhjEOfWyLosomoLGUYZaumKuMRtJMcXfApGnYhcJKSVHf/l1j8jqEKpGtDykG8u4pSj5tAbfwOtMAFm3KDGW8HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3TnfcT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED27C4CEC3;
	Wed, 13 Nov 2024 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731513115;
	bh=f6boPVQNKRLctRYv+g6GO4ox715cEjwUVoNwnAJB3SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3TnfcT7FdxqejKD+JvSrRwythvWJ67tRIIqXYX/p+LS6hBmH8rJ8HAipRaz3p0F4
	 A8NyYXSf4Wa2mNl1Uz3G9B9RyafXd/i6+1KS8y8MxeijrJ6tbOr9dsA/56IaWCVwDV
	 nj3vRULR1d2y/hHa7y6XYqmBdlO5CK61NNrnI/ZrfYAfpRPKTWLY0hktYxRVEWQ3jL
	 iZ8kPnDVljwXCAzf77dJgcBoaYZ96uK+FLCUK4WjUsRLoH9bZO5n7BgucppKU+llKK
	 OhvZR+tQ3q3+qk+xRFSgrUbWt9gnt8OAKhv3jslc1hS0C0wEaTgdMqCaFegVzq794p
	 DZAiMq/Me8/fg==
Date: Wed, 13 Nov 2024 15:51:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: will@kernel.org, tarang.raval@siliconsignals.io,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Refactor conditional logic
Message-ID: <ZzTLGC5bBlI73-1S@finisterre.sirena.org.uk>
References: <20241113051852.4806-1-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JU7scIxsFVzaC9uZ"
Content-Disposition: inline
In-Reply-To: <20241113051852.4806-1-hardevsinh.palaniya@siliconsignals.io>
X-Cookie: Editing is a rewording activity.


--JU7scIxsFVzaC9uZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2024 at 10:48:18AM +0530, Hardevsinh Palaniya wrote:
> Unnecessarily checks ftr_ovr == tmp in an extra else if, which is not
> needed because that condition would already be true by default if the
> previous conditions are not satisfied.

Specifically the first one, if you revise it'd be good to be specific
about the logic here.

> Additionally, all branches set the variable str, making the subsequent
> "if (str)" check redundant

Reviewed-by: Mark Brown <broonie@kernel.org>

--JU7scIxsFVzaC9uZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc0yxcACgkQJNaLcl1U
h9AQHgf9GDmwjoGryRvf8WhPPBIs4KOjwxushi0PvM0+lp9VqbVlnoPMNAPznE+z
DRJ9J5BusELvR0hKCGwVg+VMCqG/9Ng9wau6LHQyOVI0Ivoxl8iLPek0BkiH3MLl
6j2QBmw47Ok3KTDwW1ZwpsHaC3q1WnD+WsreeBu4qrbSBlJl9vq5KfdL9+GrqX/U
T76iQwGG67Fi0NbPjhwRXxDITcGSvhLe9O1q4cqgSDDODh9pxQi78HyPc5rzlC87
9JoJ2nKIShnj6azpHq9qbXKXQujCH/RyDVlZUjEBTJA7IYLJu/Bj2tMSOZtLgkFK
PtbjDGw7+GonbdtRjlzltdUvQKB0yw==
=MyOo
-----END PGP SIGNATURE-----

--JU7scIxsFVzaC9uZ--


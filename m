Return-Path: <linux-kernel+bounces-409740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5D9C90BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B544C285FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6E185B78;
	Thu, 14 Nov 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP8Wxq8h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E4262A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605057; cv=none; b=bLxlKsRRpTjOQrTGim5vNzlwnwf9NozHNVm/Xd+x4lBXp3NJ60RTvp5xt3IigVp+ExQ4zjnUDx5/iflZ6Lp98KkfX7X5TzVAoFOtbqgNSR4Gtf6GQolcLHVdHPzCfQE1oUtuuw4zFsdMqC9xf2GvASm3x7RM6f4AmOYudsB7FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605057; c=relaxed/simple;
	bh=Ssc4CdhlsdaFpFsVDmPMPR6ykGuH7QI0c+aZlFr9J3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjNN9mFVoUFfCjp2cZe5ZVMeBQrCmsnlIPf4isvBk9HgaG6DRMCF4zeTQNDVK8JPRGiYSSijCn84JGBP3VXF64UXOOIEwVzQZaWh7yom0ruZ8NrjjCEtp1wOZYayha5ySTx1knF9QgyCYFQpFEdGc1jiu0Q2DgsAhJ9bkAbGSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP8Wxq8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB4CC4CECD;
	Thu, 14 Nov 2024 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731605057;
	bh=Ssc4CdhlsdaFpFsVDmPMPR6ykGuH7QI0c+aZlFr9J3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iP8Wxq8hWVgAGmNVO1lEuq17V+LzOwyvTTdQRfCPAEgWvH2uoRbwCxy1sm8MflGHz
	 N3GCi1EC9Tnh8pTh0fzbfblZfGtQUeN7zTlAveTiPXMdzR5pgPwty2f0KtQFAMOTuG
	 LAOrTnC0LtzKOdz+vN1O8J9jQsfXUX53dOwVNIlFdB+o5PPe29QfDQYCuVyqmgmuii
	 2sjhA1mK2BohXj9hDf3HhIVF7/PQddAspVXjpwvK0wtM01+Idcd9tRkdYASaBAocbu
	 /856g5Nq6gaFbYBHCK4ZCS0RTZq0JYqvaoj5Yj/itdU4I4qUQLC8TjMRmxAUoAbS/v
	 9gzRGMY1mRJ6w==
Date: Thu, 14 Nov 2024 17:24:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: core: Fix resolve supply
Message-ID: <ZzYyPn7HKNWxbyls@finisterre.sirena.org.uk>
References: <20241113153614.1755825-1-kory.maincent@bootlin.com>
 <ZzTOWoTT2to6aW5g@finisterre.sirena.org.uk>
 <20241113173642.4d58645b@kmaincent-XPS-13-7390>
 <ZzX6210-5YwmIaba@finisterre.sirena.org.uk>
 <20241114153645.2bbeb89d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="38liSe7l8mmkaiVC"
Content-Disposition: inline
In-Reply-To: <20241114153645.2bbeb89d@kmaincent-XPS-13-7390>
X-Cookie: Editing is a rewording activity.


--38liSe7l8mmkaiVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2024 at 03:36:45PM +0100, Kory Maincent wrote:

> Maybe this change is safer: https://termbin.com/g0xi

Yes, I think so.

--38liSe7l8mmkaiVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc2MjkACgkQJNaLcl1U
h9AiMwf5Afp2Pq3CKRjbCeQhh3NgB9pN+QU6BsS7oAG7KDliM4OLoIxeaehzUU62
8zOhZLCkwrpFP0eiKCTD2K1BRq9jDpLN1OmYm5Ril3sqaAGF+A1iYJUnEWsQCr5i
H0IGnVTu87XQdP9ERgHTIdd3Fkz95ovwBc0i03IR91qNgpydcGw4JHCgsDNRwpkC
v4VdvNvbelypmzdC2HvHxHSnqAb2jgOWSlwPk4/E82ClAS0I1WuBReS0mG/Wci/a
0RL6Cp4abgzqbV3O1WOa/oX9KL0Z3SQJILjhsWvCLUBt4cpTa1MiC5JnrUEGJXh9
kuiFSCjMow9v5h1TxZazbeo+FMMY0A==
=USXn
-----END PGP SIGNATURE-----

--38liSe7l8mmkaiVC--


Return-Path: <linux-kernel+bounces-180947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79588C754C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143121C21DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CDF145A00;
	Thu, 16 May 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HogSNXw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395514535D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859222; cv=none; b=s+40Tfhyg4ieXF2sZ//ShO5J2XVUJbyOJNLLWmod/SYy7WyYWZxFzstTTQeR5Cs4Y411F2duksuiW1JEmbxC4IPuQkH2Pw12/AK2qr/Tz25CbNQaLm1rOPM3ixVUO8aO5Tr6At9/FIn8Qil8eXHuBUjOFqzEfLvbyTnD6uIk7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859222; c=relaxed/simple;
	bh=QEUD/xtZGdRVkFch1BgkcB+HEap2Xh9vN34MMoAtrqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3TE2sk5UL0GOOhKpFYVBSCHQoYDPunV6oJ58Xi51vqIJcL0LNAEgzsVUjgOdwXum9+QxsP3mBYh43OCMQ8wsAestVQVIAIhXMUJsFwhczb7wau/gnlma0fuqbxmn2Esw83XaGGgcV2DcdsrK3CIPiPuVbXdZQDlc8j6hIfWcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HogSNXw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A884AC113CC;
	Thu, 16 May 2024 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715859220;
	bh=QEUD/xtZGdRVkFch1BgkcB+HEap2Xh9vN34MMoAtrqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HogSNXw3W1r/mtLCVG82mUuaAF0RiatLrvcUHOANFuPBAxQdN/cqi79YE+z+pXOSy
	 hTakgzujeZBtt7C7qj7t0XVV/BKMoC81iSYdUuYT9ELRD50i5eNGd9QQs1UBa4b3oC
	 NYneYXYDlxM8gq+E6mLbyirSIpN+bd4bjJe54jLDTbnunmwsYhaHqJxZkUZKwSPRmf
	 eBV0JoG6EWhU1Ie7/Z3wH6aw4xPNtsHhvS9/hRai9hxirC+e4YbfTax9vhQkuAeB6x
	 3ywwNp5RpaFBaNf5hGqbuL9wApaqzV9gWZtWlWNmynt+DyV2CQui5/4MSETQ/90orV
	 xOr3/Re5IQWKw==
Date: Thu, 16 May 2024 12:33:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: don't cache vsel to ensure voltage setting
Message-ID: <f7cf4ac0-afa2-4f64-818b-1275b1e8a6ee@sirena.org.uk>
References: <cover.1715848512.git.mazziesaccount@gmail.com>
 <a8ee4ae5532b67a5aef0f6e482cb37f5efbd8952.1715848512.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XJhKCSwPgGL9pZtO"
Content-Disposition: inline
In-Reply-To: <a8ee4ae5532b67a5aef0f6e482cb37f5efbd8952.1715848512.git.mazziesaccount@gmail.com>
X-Cookie: May cause drowsiness.


--XJhKCSwPgGL9pZtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2024 at 11:53:46AM +0300, Matti Vaittinen wrote:

> +		/*
> +		 * Some PMICs treat the vsel_reg same as apply-bit. Force it
> +		 * to be written even if the old selector were same as the new
> +		 * (but range changed) by using regmap_write_bits() and not the
> +		 * regmap_update_bits().
> +		 */
> +		ret = regmap_write_bits(rdev->regmap, rdev->desc->vsel_reg,
> +					rdev->desc->vsel_mask, sel);

This feels like a special case for those devices, for devices that don't
have this behaviour it'd be a regression in that it'd increase I/O
traffic.  At least this should be specialised to only devices that have
ranges I think?

--XJhKCSwPgGL9pZtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZF7xAACgkQJNaLcl1U
h9DbNAf/VLLIo8HA9/ZDXifhrB3586UcRnANOPXHGEAN7ftgwLP39775DG1h3x2E
7DPQwJk3JLXuP9j0mH3B4YkoXAnyQBJr8Geaa2b6EJHSBC7aa/6MNPxc3IrB8m86
pCkzfAUcJVH0ES52rxTmIcyRJ948T09kvVf18+/yeFH+pJHXdHHY9kis5SfWRSBp
L3ATdZb+1mJIYtD88051r9a3RaaOGpKFb2VHxV888MxGduftSJRjGqm1Ynw2ACI7
UlAi33taOrja7mZOj1hZySLNFgbphc9nxgbnrm8kT4ptBgXJSK0SpFjwpGYJq3td
QDqMmgTYcY/rC0v7zH8Ydr3cuCLwZw==
=8ygg
-----END PGP SIGNATURE-----

--XJhKCSwPgGL9pZtO--


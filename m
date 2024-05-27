Return-Path: <linux-kernel+bounces-190653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B09558D00F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21B21C23C46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A5161325;
	Mon, 27 May 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPviPCJH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC40161310;
	Mon, 27 May 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814852; cv=none; b=eqaJVTxnCi7sV3lPETYCetCZUKIGZQRlBj+CFsEbQC1btIxJFCzpkM8/X0T33ZYj3qmBhTBdWkqK8QivR+we444qNI9jbnlZX0EdjVgox3TgnhB4gABT+SNYHGZdqSBLa7gGYRoV2D8tSxxC1TYYM8faj8W++UmK6TtaN0SbqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814852; c=relaxed/simple;
	bh=bxoNFGZl9B71P1f8yTzsrhw1cEfhGFUvd46K3+cBqjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ5zsiYH+Gc+Ea/4oNaooHWx2cITseLmkenF1OjuYVuALbtTe4LX63vtWQNKRmZMmnKP4LLYJkdP2uSJP0jTs232qXECoUPDD3g12U/MpzAQqOzMREBt/XIqboBi0E9F1puuc02iN5ebaZgTKtirDQkFQTvqkUqiW37IuW32YFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPviPCJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F93C2BBFC;
	Mon, 27 May 2024 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716814852;
	bh=bxoNFGZl9B71P1f8yTzsrhw1cEfhGFUvd46K3+cBqjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPviPCJHhzy4DuNZ/3eISq4MZ/Y5wjDv0AZT8+XXbHO+70gROgWe9bicZX+s7HAYB
	 epRENlzF5J7GRZP42GAdBfGaZEU/Nxn3r2+1YtxNscKgpLEGqrNzAeHMJFglJbhjQk
	 IXOLQCX7+VIbFHxQOhIjHl2sX3vCd9KzCBKiqrzIaIHb6shP5EPL1U65slH4/xr8Nw
	 MDuUSJSNwdpqKmDpalQB1opDxAL12bC3FmCFgrgotVNGoPnsexvHviToFwhdmf+WXd
	 Pbps1QjCBCiH2YJZgkssr1F2HYTRnmPyzrbHg0Lhx8K2k9ftDImdYL5I3i/FPBhNfD
	 KWGHNJWYB5JoA==
Date: Mon, 27 May 2024 14:00:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	cy_huang@richtek.com
Subject: Re: [PATCH 1/2] regulator: rtq2208: Add fixed LDO VOUT property and
 check that matches the constraints
Message-ID: <c0c7a63d-e435-4778-ad4c-3d93f0215116@sirena.org.uk>
References: <cover.1715846612.git.alina_yu@richtek.com>
 <7c28d2e61d2fc13066ba4814d1ecfab8f344aaad.1715846612.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QDby5NivKiXbMELT"
Content-Disposition: inline
In-Reply-To: <7c28d2e61d2fc13066ba4814d1ecfab8f344aaad.1715846612.git.alina_yu@richtek.com>
X-Cookie: I am two with nature.


--QDby5NivKiXbMELT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2024 at 05:20:33PM +0800, Alina Yu wrote:
> A fixed LDO VOUT property has been added to specify the fixed_uV of the regulator_desc.
> Additionally, a check has been included in this version
> to ensure that the fixed_uV matches the constraints.

This doesn't apply against current code, please check and resend.

--QDby5NivKiXbMELT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZUg/4ACgkQJNaLcl1U
h9APoQf9G99XUOOwSNV5b+597lA2qxJtEXECE0R6AbgfB+CKLJZ1Ejt1iIN06eti
Q1SfESM4i8jf+jiR4kHhHk2GHYsHkfpYE99oiGyCgzY0PSmaMtLQnOgzRgDy+FeF
4qEaBZ1pZZzm7UG6MxudzTQFW/9CSLGYkX3n8XsYuAydLOjpacTvE/xQW6HuYNLi
GGHj8yWaj8H+p5dSli8gZZDtB1LKGYHf0WRJaBYBCBx+Z1txGjjDdrIVV/yD5TjJ
pWIvEeJszjMZWb4MeobgRc1s+pmTt+sNuokDzE9GvY26UGsaVYcybG9zdHYySJdu
EP/s9sZruxeOhR8m+IdNELkJKUkKng==
=urjY
-----END PGP SIGNATURE-----

--QDby5NivKiXbMELT--


Return-Path: <linux-kernel+bounces-324842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3680D975172
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51481F21210
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812EB187355;
	Wed, 11 Sep 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/L3CCJW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80573477;
	Wed, 11 Sep 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056477; cv=none; b=Tc55HbAsH9XJWnTchCW7MysG8P60VmIcptgXpHZh75C7PcZ0/ZUJ3CGoV7X8Gz7mC7VKutG3zeNY3ajHcTAvWSXKmIsdIh6rrMuvWWWU5cF3AdcWYd3oolO9q5HgqF7DF93cmcUEsdku099gOvni8QyC7iCCOpEfLDo8+CsIeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056477; c=relaxed/simple;
	bh=LtSntcKQsfPx+S5sN1yyCdCKm9ZA925LdRwDJ2opgDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP8u7qy8z31TxRi+pEExbxZe/GJfqWSYrCMZScxJztos0whusg/UtixwU+tXmuMyrFOs+LRLn8ChsAHOsiN2OyoYyDi6NeO+tQ6GSBqaZK8j5EvAmaHMCNLNgzvbwRxeGSetGMjcNdDKQDF044dsACL/HQPA9ZYkACTZLxCEoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/L3CCJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B36C4CEC5;
	Wed, 11 Sep 2024 12:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726056476;
	bh=LtSntcKQsfPx+S5sN1yyCdCKm9ZA925LdRwDJ2opgDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/L3CCJWhxnYvKa0fZyz1vpuILqDQAOF6jH8Zxftt7eaxzwA9Sc8SQiBEyqDINzyy
	 hXPZ1wqRrGyoaE5a/fDyRzAe+cKsVc96BwGtGmOqodHPRAW93Cdrjd8txRP6fr8jhd
	 XCBM7wADLBoy1x2wJRjV5mHIgQDUQ5oeuPFKgYFOvTxv1kECSHIT8z9R7T9scrR1/f
	 HykP0/sGY1d7EkrtInq0vCyTusLTwPTBFk3KgVyZzJHoK9DRG5bT0S6XXIrcPfcpw2
	 hP3NszPduDeXmROUDPNPLNhuER10+K5f0tmXJ4PxHD+KkeHeMttzuD6ruNz+ihewpU
	 K3gGvBxUhfGeg==
Date: Wed, 11 Sep 2024 13:07:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: amergnat@baylibre.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mt8365: Fix using uninitialized value "i2s_data"
 issue
Message-ID: <8d921122-7271-451a-8bcb-83a1066b7b87@sirena.org.uk>
References: <20240911001516.47268-1-qianqiang.liu@163.com>
 <9ea8731a-7888-40a2-a183-4598884bbb27@sirena.org.uk>
 <ZuGAwQGPWdpO1-G9@iZbp1asjb3cy8ks0srf007Z>
 <eb21bcab-333d-4ab3-9222-058764ced720@sirena.org.uk>
 <ZuGG3jk6oqq7sUMw@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pDxhccTIA3Jgoyb3"
Content-Disposition: inline
In-Reply-To: <ZuGG3jk6oqq7sUMw@iZbp1asjb3cy8ks0srf007Z>
X-Cookie: No Canadian coins.


--pDxhccTIA3Jgoyb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 08:02:38PM +0800, Qianqiang Liu wrote:

> How about this new patch:

That looks good, thanks but an equivalent patch has already been sent
and is in my queue:

    https://lore.kernel.org/r/20240911111317.4072349-1-usama.anjum@collabora.com

--pDxhccTIA3Jgoyb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbhiBcACgkQJNaLcl1U
h9CP6Af8D9dqXjGlMuaHcvERZog4NrmsK6w85EjZUpKZ+rpKIiEj0psKY+7oTXjd
+1h1SuuRBNz2kzAGZ/gjSeg/r7ywekHnhYi5onqF+NsnQJUhmFhNmT6V4oZVtjhE
cVQ3InLJ4BHtzgmUi8XYTgSFSvIIluGl3e7WSThueE5ioHtcIUkxVgPpWsISPOCa
+h9Dax7DRS057Aq103ShsGxmgfm7K3fdspQO4f2PM06R5bwB5ER41ylYm74Ecstf
U6x2GGo4fxOdPegvz+PR8BMttoS89Dx0mZyoT+1E2tncOATnV5nDamLxUHWSyGjy
tmbJXBwmHVZkYIndWKacNSQe2Fi7ag==
=H6Fx
-----END PGP SIGNATURE-----

--pDxhccTIA3Jgoyb3--


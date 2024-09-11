Return-Path: <linux-kernel+bounces-324735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B8F975041
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFB029024D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9F186E54;
	Wed, 11 Sep 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRUJtG86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27941862BB;
	Wed, 11 Sep 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051983; cv=none; b=Ow8+RvOHmlrHyDOYOkaSSvt4E0MUsQgX8+106J49jzLBXD1f2U7msBuzgiqxYd/c49lrnG/0XyPLdS8nIDVHkOUT17F0YzRXTThuuY0TX6hpwYVMH/fDZM/7ItFqh9zUJiMteka6Wtm3Tz0xtpnBd6rdGipC4VKoEkTjhk3Z7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051983; c=relaxed/simple;
	bh=CWU1usM1Fc4L8jz0AwjuWs+azk55gYJ7fhnDIUQdpjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrOWdlAjNRQkfVHRX4nDFwfOMzUWpPNPizH62P7iLuvH13mBeVfrETdi3s2li+eH6PTPC4NYjC4jZRlz/sK7c8lVSTvzEL14Cp1LocJ7kZOeLLdGQllnR4o/rGgam1zLrYbXT11b9UYKc+kMs88t3fEXsAEcfX4Cg6fAi8M/Gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRUJtG86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5320C4CEC5;
	Wed, 11 Sep 2024 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726051983;
	bh=CWU1usM1Fc4L8jz0AwjuWs+azk55gYJ7fhnDIUQdpjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRUJtG8604pBhZnJqcL5I3TA4+qfLCb67YzWONKZvN+Ml2igh0jgaqfbRS0jr6Qv+
	 KCUUFzl/VewWqOzkwMipnALyBGGr3HwNdRRQLBD1w1hw+TfDCBTi0X0t7l9ZiocPEw
	 p7LI1K+smLgR5P1Y3pObnHu7eOUbiVXwlrTeCkDbWQCQlp6zO1qMR8O+zLN5SCv3vF
	 GIPDauuNC412nXH2FQpJwQBXdvx8ZZgTZBrrQcO7ly7bKVt57b2wtrMkXLnTqZkDzZ
	 mv08TesOeuQh/2yzmKwFu3TDWRmVA+uYMfyHcU97irFGBspfne12EcnAresvhMNl5w
	 N/PAognTiz20g==
Date: Wed, 11 Sep 2024 11:52:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: amergnat@baylibre.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mt8365: Fix using uninitialized value "i2s_data"
 issue
Message-ID: <9ea8731a-7888-40a2-a183-4598884bbb27@sirena.org.uk>
References: <20240911001516.47268-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkIdGi0B1wK94o1V"
Content-Disposition: inline
In-Reply-To: <20240911001516.47268-1-qianqiang.liu@163.com>
X-Cookie: No Canadian coins.


--xkIdGi0B1wK94o1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 08:15:17AM +0800, Qianqiang Liu wrote:

> =20
>  	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
> =20
> +	if (!i2s_data) {
> +		spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
> +		return;
> +	}
> +

Why would we look up i2s_data without the lock, take the lock, then
check if we actually found it?  That doesn't seem right.

--xkIdGi0B1wK94o1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbhdooACgkQJNaLcl1U
h9CIIAf+Meowos7+a1r47+yCHWWJrSYtF4np5O3KaZc0Y5hwBG9w69H1+o9kc8Qo
x8o9x2g7ba4KlKEBjP+MnbF/zQ3McjMUlRz+MiVJsDXw04INZXg9VKUMmr1j1InY
slcW/8YC4mn93rT4tWoDuzcw1SjSzVeh4fISJU6wPGW2waJMZ94HCHeSGF7ma8yJ
zDQ1yPCdDmpTTkWgritboCk2wBluOvoxbmXcYQ/mYEcIsB5peCZORP6PCZndDmh2
thMaYWTbK5g6UnnV2hC7D7eSI6+9RxdOWnrf1N6WSg6ggQteo3EWTHv2ViMXZCeH
y8rPm4hyU28upJIHhKJjDq0M+TIU2A==
=qOee
-----END PGP SIGNATURE-----

--xkIdGi0B1wK94o1V--


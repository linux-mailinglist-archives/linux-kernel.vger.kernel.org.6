Return-Path: <linux-kernel+bounces-182030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0B8C8552
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC7D1F22CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A73BBD2;
	Fri, 17 May 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrkcH1zG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75213A28E;
	Fri, 17 May 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944310; cv=none; b=nj+SQP/pyVQMjBfrbMnvhWLtKWPpiGY+yIkiYuyNGS99VTb8CndxSGKoh28coPziNIik2ys2fjpzE316QNvug07AydwWV2zDwlU2J/taJUDs60TowsnUhIsJ+Ll8ZZWNj7XyzWK81ikeuoXRutrXrLbaXp2UNLx6hJZYD0kY6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944310; c=relaxed/simple;
	bh=NGy4y9LkeLC6kMLGudcaqdBbS5CppWV4B0ewLsdwhpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRapSdUeU/yzIfiCQ04kfvhQtvGOOXUtajQ9QkiZDB0q4O9wZKV05d6mebol9KfE4UPWHZouSeRoQpF+b4U5kqPiLarxmAfnThTAduH1C1/GvjkBaaLvotyatYxuFunOJGAI36AadeDGSN4pu75y+b4g2o2VWzOS5AFiC+nwwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrkcH1zG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C68C2BD11;
	Fri, 17 May 2024 11:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715944310;
	bh=NGy4y9LkeLC6kMLGudcaqdBbS5CppWV4B0ewLsdwhpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrkcH1zGc5nsdF095rPasSd0smJVrBFPzVO1GfGnDndEAQRzzcEtOccP0Lq+THwc4
	 pAwXQ3f+M6XWsJrDZNt1FvPIfrTYhdCz2SnBp87g4iKe0IaqCqMHvc/yhtKzdgGaJv
	 dLAUdfS/gP7P/6XMwMIK5GZ43Hj833J7d0dOXLHcvLJKhNfKwWtUm/RnK70V89+VUu
	 AKcflMk2YxuK7b1Ya1coPH208ZfKUOWyTC39jgyRK1kZ/ASRPGRlTuL0lnElYvRFcD
	 VX4z/sJPHRJZ4c5hebs5Lf/i0NjNi4TSVrQuPXXHKTI5HQ+wADouLeFLthJoRCZaFs
	 N+LYX3g6JdEBg==
Date: Fri, 17 May 2024 12:11:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	shengjiu wang <shengjiu.wang@gmail.com>,
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	alsa-devel <alsa-devel@alsa-project.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCHv4 9/9] ASoC: dt-bindings: fsl-asoc-card: add compatible
 for generic codec
Message-ID: <500db9de-6113-4e73-ba92-6e52ea292b32@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-10-elinor.montmasson@savoirfairelinux.com>
 <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk>
 <599489232.349333.1715936741672.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3ZQHG5Itc4786pl"
Content-Disposition: inline
In-Reply-To: <599489232.349333.1715936741672.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Function reject.


--u3ZQHG5Itc4786pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2024 at 05:05:41AM -0400, Elinor Montmasson wrote:
> From: "Mark Brown" <broonie@kernel.org>

> > This description (and the code) don't feel like they're actually generic
> > - they're clearly specific to the bidrectional S/PDIF case.  I'd expect
> > something called -generic to cope with single CODECs as well as double,
> > and not to have any constraints on what those are.

> I proposed, in an reply of the v3 patch series to Krzysztof Kozlowski,
> the compatible "fsl,imx-audio-no-codec" instead of "generic".
> Krzysztof thought it was too generic, but it would convey more clearly
> that it is for cases without codec driver.
> Would this other compatible string be more appropriate ?

No.  There is very clearly a CODEC here, it physically exists, we can
point at it on the board and it has a software representation.  Your
code is also very specific to the two CODEC case.

--u3ZQHG5Itc4786pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZHO24ACgkQJNaLcl1U
h9AA9Af/dEW1/sXD0drucKnj3m5nf/uGf/YhJyyfJ/1JSqxnRA/VSoHYc1D6ZDLc
CYKJEQc19aWqb2hDm2/NebWPZ2nAgbG64R6Mn+Ue1pJ025SpxFd+SD2G9nzkzh2r
rhP5qrycZhKjkaMvsYxOQCgUZMDup6yEwckX93anIVYxBuz6o1Vx2H4tJkbXIU74
Q7wz5GIp6xMQNpX7RoCw/wE7IEe2TOmjGl5bPg9kM+V8uqYq/cZIZOnHMXicXoTa
jRDfO6DaG6nJ/23U8LJW9Ja6BJ+rHeeBtCDVZvcQUff+s/p7D+LzYeghTFOO1xQW
kN7EAVsua19NtkhnbL1ZsBqhr6EznA==
=AwEF
-----END PGP SIGNATURE-----

--u3ZQHG5Itc4786pl--


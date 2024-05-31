Return-Path: <linux-kernel+bounces-196842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5537B8D6270
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35901F223A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33879158D7D;
	Fri, 31 May 2024 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzfFWJED"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49215886A;
	Fri, 31 May 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161000; cv=none; b=boZB3WT3EiT1kqQUH8eHNj2bRcG8M3CcSZ5Ea+bfb3UxXB17e1Ih2hVE+qXWvHrlvSPWm91SIUNV3ucUMaq8A8p/ZQGdZnExg+nUbu3hB8aRx8H7LxELXVeULhPk2Y1zZgtaF1Z2MD5egnMbgjNoQn+5Z3zflF0IPbcgbF2BqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161000; c=relaxed/simple;
	bh=nn3ZIl3mTwy4jDOPZZMcgjHeEDzdP9fz+mt30ZhzMQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTHiQJXRufmhE+MD1xJG8hSQMi2Fq3b0PdQasHvhmVTKLdqK33NXZ+CGzXUOt36kB5xK0aQUZgWf0ALF1nSGkSdH2Rww5zW9fmOChsqbqmY7TJefbEk5g5UPqP72AwhF54kAQM8ij2oGQAWtZ/R/Ic2jXB29wJcykC+j/XAbfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzfFWJED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB9EC116B1;
	Fri, 31 May 2024 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161000;
	bh=nn3ZIl3mTwy4jDOPZZMcgjHeEDzdP9fz+mt30ZhzMQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzfFWJEDxUXGkknghVKqiGcy2480IcnsHTVRkYB0ohkhRD7cASEX3Tcv9GYdWYCiI
	 9bEsAgKevrJeIr/v8T789I9g5/XXPhV7lXMg1A39QZ60Hf4oEaOGy6aUEonrQKH9mc
	 qlGcvYt7kdlnY9JbOZrEz27B6GSoMnD30N21H6dnowFNC3mZRsrNEMWuE92OZ5qlMP
	 K9CdtW9TLbjlxtT1Kt3SGR5u/8i4ykECKJotxlymyi6qbZ+ne0rskSMTCY1KZmqlO6
	 hUSV1CGsNIAb3E5gswMGoZk6dPDVKg6vCfYR9B+5BN34K3JjsfuC3Fud4PBwhqC/KX
	 UJ/BUTYHkdJbg==
Date: Fri, 31 May 2024 14:09:53 +0100
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
Subject: Re: [PATCHv4 8/9] ASoC: fsl-asoc-card: add DT property
 "cpu-system-clock-direction-out"
Message-ID: <cbf66aed-2bc7-43f7-adbd-d39774c255ab@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com>
 <20d8eb96-6346-4341-95ee-74729001c01a@sirena.org.uk>
 <1607626951.349332.1715936738428.JavaMail.zimbra@savoirfairelinux.com>
 <aa212906-6579-4884-82b5-6d0eb8b0b7a0@sirena.org.uk>
 <477405270.701257.1717159642136.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NswN//hqd8Z1peYF"
Content-Disposition: inline
In-Reply-To: <477405270.701257.1717159642136.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Serving suggestion.


--NswN//hqd8Z1peYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 08:47:22AM -0400, Elinor Montmasson wrote:

> > When I said "this should use the clock bindings" I meant that we should
> > use the clock bindings for configuration here.

> As far I as know, it's not possible to set the direction with
> the clock bindings, but maybe there is and I missed something ?

If a given clock has an input configured then it can't function as an
output and vice versa.

--NswN//hqd8Z1peYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZzCEACgkQJNaLcl1U
h9CKqwf+LcvhKkLjySDBCo2AIl/+WWEqokt2mSyrKfa1HNgIC2P5ZIxpVrviALhb
AFpK4I2D1Kh+ltGruh1zwOo32CaHr2GpvJ46CLzz1NmH8Jd5pers680nusk7V2XK
j99GiZHitgxOITrP3z0+3f0DerpwZEzR3xXUjxuIDTyDQRdZKIYbvKzRKMkVOKB2
dN8PV6CpvHZdWD219ACPaLasi774vOA4/7CHonsfuaUWUel4Bqhd7nG2ofKhjFWF
f7WtxfSfqe2o8S2JcySsIR1XVRMplDYbz0PByFJYbE6U8XY0QpLZlEEDRLXhd7V+
bMtoDrc/OUMO9pGT7silCtwMMzIkYQ==
=C2Hr
-----END PGP SIGNATURE-----

--NswN//hqd8Z1peYF--


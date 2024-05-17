Return-Path: <linux-kernel+bounces-182021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347CB8C8539
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E591B20B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EF93BBD7;
	Fri, 17 May 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhCtg23U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81F3D0A3;
	Fri, 17 May 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943971; cv=none; b=MTCQS+1kOEMnderc5h7zKYin6ni5RyOwq8hhd/5+mPUMt3VXG9kiqqfAI4pc8how89mlJze5LNzrQgug+dY4mNw/A8bzLy5j0RkFWXLK6CpShNqyHx25sofHv5jVZopUWImnmZ41lieqnnCVcJdFEkAC0sWF7O7z0kMDVgFEuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943971; c=relaxed/simple;
	bh=cyel7fIdwl4HctMWrrdTp1YOPgFDo9/NgLEnSREBmac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzP+DodLerBDnjn2zLuX5bRqlQ2hlFqAgx17PCSxVO2cJFanplnSpEl/NfeYTyYUtHVmh6+mEAvNzQUL9oS13g3H6HPr82o7tBXaLCHyKwPhQdExu01v9wIsWFgKAvs4Ignjfq3zmR9SqVUxTfrYlCELO/eBDywIoy3BKu/e3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhCtg23U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CBAC2BD10;
	Fri, 17 May 2024 11:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715943970;
	bh=cyel7fIdwl4HctMWrrdTp1YOPgFDo9/NgLEnSREBmac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhCtg23UXxfH8GFvpV0bBhTuuNC/yOVcyf8r+/SBwHRDykFO8ucIH2zOi4Lsfxh4d
	 jgUm1njcrxzwkFc5ERNxH12t8OuT6FilvS5TVUDj2I26qEA62JOrg9ddHttNLHU92I
	 WwwqESVPuv7qE7Dt0G1BbgYEuXiM/bp8Kp5wUtlatKoOVFCm7wjeV73X76XhNJgovE
	 jrSu3So5EIc69ImofyM9j3891OZ3tYqgklB+lrMan8iv6hEsQ/mi44SN+vCPxdjeUx
	 FK4gKAgevr+QDU7R6Lgh1WAy9nUhkn4UvE+ABj0uOQr0qIz3E3Ic29+uUjVaNb4a7w
	 1mCgljVttOEiQ==
Date: Fri, 17 May 2024 12:06:03 +0100
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
Message-ID: <aa212906-6579-4884-82b5-6d0eb8b0b7a0@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com>
 <20d8eb96-6346-4341-95ee-74729001c01a@sirena.org.uk>
 <1607626951.349332.1715936738428.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cuAZOLW+M2wSeAZZ"
Content-Disposition: inline
In-Reply-To: <1607626951.349332.1715936738428.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Function reject.


--cuAZOLW+M2wSeAZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2024 at 05:05:38AM -0400, Elinor Montmasson wrote:

> This new compatible is intended to be used when there is no codec
> device/driver. There is technically no codec device/driver for which
> the clock input can be set.

This is obviously not true, there clearly is a driver.

> Is it a bad idea to allow setting the cpu sysclk direction only ?
> Should the compatible be limited to use-cases where the cpu sysclk
> direction cannot be set by the machine driver ?

When I said "this should use the clock bindings" I meant that we should
use the clock bindings for configuration here.

--cuAZOLW+M2wSeAZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZHOhoACgkQJNaLcl1U
h9B5+wf8DiGSZ5ltF8WMKf7h2wg97OfIIvLbAgLOdxagHZRUlW/dW/+Yb3DRoVUx
bWVR5k6wCU7A6Qwi1k/l7vnJ0gi+7ZqpHvuecyUqUZzymYsReuFY+p73Hm+4vZOq
hCopfIw0bE96SL2v3NQZKSoIiXX/yKxVU6NboIhgjeZuUWeabzwTkJczdvahes8z
Wqa5Jfd22U7vq//vQQIViaVycQujM1QOA2vIbGAP0sF2XGNUzo1UmmE5mtbDlbLE
Cn3ijtOv8bhzkca7J5XKbiWo6JmN/7ormEDq7cpF2fWvfJnxd2L/L8ciKH4ylk8z
MQjb0jAheAGAERAKoilEwWJkgcCJ/Q==
=Bx3M
-----END PGP SIGNATURE-----

--cuAZOLW+M2wSeAZZ--


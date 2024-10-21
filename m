Return-Path: <linux-kernel+bounces-374622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5594A9A6D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162852824F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A81E9072;
	Mon, 21 Oct 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzdVasuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF841E7C2B;
	Mon, 21 Oct 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523115; cv=none; b=KQp/6tSwPbFdjNtEz2v3zDy+R1LmBTWZX34q5mroZ+i4WFQpAF418YSmXHsBUG2pHvJJjtz5GiIs+bZ3SFa71JGgFA0M4DjJTuObp5xsNBMOJuYG3kL7p2MenmcujrPuytPbC2RZShCjjgYrNO2vaHeuqE522DVZXKMBG/A3mwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523115; c=relaxed/simple;
	bh=2dnOPhOm5HtLnvaoKY9Eone6Z86NHH8UuE4esfddKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyHK8pDVQGcMIy5xF3aDK+sDqSMC5neU6i+bMtBdwq37pIwljbzgGsoC8Fc0H1P+MB5of/mA22JHB2GqBA2b25wRnp5lHUIvWoJSYGxiVWOjfMAZ8AT+Y/n02tBNwfE72kis1riGoJkhY0J9A0mZeA0uDLWMZvu9LmvWqLJl3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzdVasuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8733EC4CEC3;
	Mon, 21 Oct 2024 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523114;
	bh=2dnOPhOm5HtLnvaoKY9Eone6Z86NHH8UuE4esfddKjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzdVasuTkzEWOQfWFiOr4WCyb/UN6aJL80VwB96oWOVLYd2rgCkjYw8N2YJOkvdW9
	 YTpro4p3tikrC9iX7ez8aQVLJJCD2RoXB7SI2w/ggiY3TR3IN6oPgw3TJgBX/qn0oX
	 RyLYgzWGpblUAahEVwQSdzUaBhuSLedEtyM5XaYYP4RWp2xLqniQQNOgZ7Mked+1ue
	 r5iM604kF00IY8R3R7gVnn5PGmfTmbUSuWpDRHdjqS3SzIN0ksNVNxxYQo7ATeD+p6
	 xrGqD6lux3SLPmVaXN7HQeYdwNrpbyMBaW8XBOVZmym4HPZxdq362vxZlSr0f+X0Bo
	 a0BGirOWm3+2g==
Date: Mon, 21 Oct 2024 16:05:07 +0100
From: Mark Brown <broonie@kernel.org>
To: anish kumar <yesanishhere@gmail.com>
Cc: wangweidong.a@awinic.com, lgirdwood@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, rf@opensource.cirrus.com, neil.armstrong@linaro.org,
	pierre-louis.bossart@linux.dev, luca.ceresoli@bootlin.com,
	arnd@arndb.de, quic_pkumpatl@quicinc.com, herve.codina@bootlin.com,
	masahiroy@kernel.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, yijiangtao@awinic.com
Subject: Re: [PATCH V1 2/2] ASoC: codecs: Add aw88081 amplifier driver
Message-ID: <ee9ac4b2-6723-494e-81e9-fdd91b24be3f@sirena.org.uk>
References: <20241018094320.113477-1-wangweidong.a@awinic.com>
 <20241018094320.113477-3-wangweidong.a@awinic.com>
 <CABCoZhAcsUQbaSvawUa3Px0BK4eUVXV0Kfp4Y8AtgPb2PPMfmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YOgdX4eAwI32bOwZ"
Content-Disposition: inline
In-Reply-To: <CABCoZhAcsUQbaSvawUa3Px0BK4eUVXV0Kfp4Y8AtgPb2PPMfmg@mail.gmail.com>
X-Cookie: Most people prefer certainty to truth.


--YOgdX4eAwI32bOwZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 09:18:59AM -0700, anish kumar wrote:
> On Fri, Oct 18, 2024 at 2:44=E2=80=AFAM <wangweidong.a@awinic.com> wrote:
> >
> > From: Weidong Wang <wangweidong.a@awinic.com>
> >
> > The driver is for amplifiers aw88081 of Awinic Technology Corporation.
> > The awinic AW88081 is an I2S/TDM input, high efficiency digital
> > Smart K audio amplifier

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--YOgdX4eAwI32bOwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcWbaMACgkQJNaLcl1U
h9As9Qf/duzbzlTaHwAi2yDabblWYnwkMJju3IuRFteltb+slTH4jrCPUzxO7HLt
MO8qp7onQkpKfsDJmkwplXjfNAiD8dveoFHfHT//naQTPGvelR2P+4lpZfZbRsKe
n+2SqJXB+xujmQ0kz/ciDy6vB2EwgnOVw5jexuAv3/8O2iL+LBN5s0V44fF+bGid
azCLzMFxykWmTRTx7LM656MTHj8e0YliOzUeksihOgdVFKI5q6q5mkY3UPjhGuDB
UhkKx9XS0HDN0leGx4a4/uWU7e3IsASrUjE0OmyVdXet/6JhUY9sW/HRp3eJZ16z
Fhbd/ErksvTKBWSjh6ozw1Ilkr1W4w==
=crzG
-----END PGP SIGNATURE-----

--YOgdX4eAwI32bOwZ--


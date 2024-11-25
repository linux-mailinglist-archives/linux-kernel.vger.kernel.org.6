Return-Path: <linux-kernel+bounces-421301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8D9D8957
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244E5284A26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829381B3952;
	Mon, 25 Nov 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da0pwaU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483B195390;
	Mon, 25 Nov 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548483; cv=none; b=A6mjKGn6SVOnFhJc5SC04rKOlRBUfG8eCiGb/ok037uC1j+ZOX/yzwLasArWlhTuvCYqKD5itZeMssPtXA9PubMkKl0wEkOHN6vfWrvUeUYmcxAfvTkvIo3nV+P3UTpy+OsT9HxurUQ8UNR6FUT/5+u58PSRvU0ETv+VdJHrYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548483; c=relaxed/simple;
	bh=3o//Lu3fWmlMgcsFVQWA/djmZOMPgOZzmS0G9hxrPVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ2ult9mu0q5Pjpt+udQx6CkFL6T67y5ci1jvKHq/ZXrjuLJt/EFo3SuyfNKgjEHtl81oprEhkVTD8IiojzZP/TZhpFXU9g1B2otThu65LekxnY99lk5ASknz//HQ6KnmT/72Ls4fwmNJXzeYUV/+PDu8O0+wjiOpnsEp2QwlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da0pwaU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D468AC4CECE;
	Mon, 25 Nov 2024 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548483;
	bh=3o//Lu3fWmlMgcsFVQWA/djmZOMPgOZzmS0G9hxrPVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da0pwaU1v/VXYIKR9vpfEmCRz+MZBboI4cZHvPssv6DeCpPNrfpNflLEh/TIP6XK8
	 dCVMdbnsRji6BpFiuTodqUZna90xkkPoSYDION5+ZSTaEpqWG9bCcbmYSppNH/jjQX
	 IU7taAut171vJ9zJyX6k0DNa3B+4kCDuI4/Ed5nOFLeHI4Tn1QOZi7/LbHpI8O69wW
	 6Mo4gm6o7vubm8WH2MzDMmSm7WOmiLhPspw+uXYQRdH3ZxADM/tYgonjq4uF+HjO6p
	 fHbfCEaTX9qFxOHsiXc6GNLdk/tbhyZslH17z4vRbw04w0XxcgwJE6bWNmI86S3Rz7
	 xaHW63CTTkyfw==
Date: Mon, 25 Nov 2024 16:28:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Hector Martin <marcan@marcan.st>
Cc: Sasha Finkelstein <fnkl.kernel@gmail.com>, neil.armstrong@linaro.org, 
	Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
Message-ID: <20241125-gabby-furry-rooster-cf28a9@houat>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
 <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org>
 <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
 <cc71021e-b53d-4eda-bad8-abb4df13575f@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3u5p24fwfin4nvod"
Content-Disposition: inline
In-Reply-To: <cc71021e-b53d-4eda-bad8-abb4df13575f@marcan.st>


--3u5p24fwfin4nvod
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
MIME-Version: 1.0

On Mon, Nov 25, 2024 at 11:24:25PM +0900, Hector Martin wrote:
>=20
>=20
> On 2024/11/25 20:24, Sasha Finkelstein wrote:
> > On Mon, 25 Nov 2024 at 09:50, Neil Armstrong <neil.armstrong@linaro.org=
> wrote:
> >>
> >> So this controller only supports a single mode ???????
> >>
> > Most likely. On all devices it is connected to a single built-in displa=
y.
>=20
> More specifically, the controller obviously supports multiple modes but
> it is pre-initialized by the bootloader for the single hardwired
> display's only mode. So as far as the driver is concerned, there is a
> single possible mode, and there's no point in trying to be more generic
> if there is no hardware that would use that.

It's not only about being generic, it's also about fitting nicely in the
usual abstractions. You could also always register a single panel, with
a single timing set, and the driver would never see anything else. And
still fall within the usual pattern.

> In general, it is not possible/practical to be generic for reverse
> engineered hardware with no specs documenting how to drive it
> generically. You just can't know how to implement the options that are
> never used in practice. I spent a lot of time on exceptions to this
> rule for the GPIO and SPI controllers, and that's not going to happen
> for more complex hardware like MIPI DSI.

How is GPIO or SPI even remotely related to that discussion? We are
different maintainers, with different concerns, and different things to
care about.

Also, "My way or the highway" is never a great discussion opener.

Maxime

--3u5p24fwfin4nvod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0SXegAKCRAnX84Zoj2+
dtRuAYDEMVFA/3C+t/k4bboWPpqx9fX0T++UXMqT1mD2/3yaz7RX4i1fL4wkiniM
1/z1cnsBgJZJteTKP8wCeZmNA0nGQU5iRaW1WQwbcQQZO2JZnHgV423VVrkt03Bq
ZMUX47opzA==
=EgqE
-----END PGP SIGNATURE-----

--3u5p24fwfin4nvod--


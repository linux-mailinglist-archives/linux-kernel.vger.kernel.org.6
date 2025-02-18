Return-Path: <linux-kernel+bounces-519706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5672A3A0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D71679E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD926B2DC;
	Tue, 18 Feb 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uijAGsxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F026B2BF;
	Tue, 18 Feb 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891603; cv=none; b=PGXHFx79vADoe6xMFnCHFKkz+RUFedVTl3ZKZ12jvuQsa7UlnAcPb6aCR5GYryk3h5N0vzDC1m3XDC9hZM6JdversnVorz8GQZyk/X2VMagZnoTe8/JURMIW0JQVPG03RfYvCOkgBqh1sLQ51H4KJidy26/a8mQSCRMQRoEalf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891603; c=relaxed/simple;
	bh=DX3TX+7yJwABho/ydv17BCgSzeruh7GiPooXHU5WanQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhCacMWZ02NHVM6h9D0V1LfDdiSZnggkNgSWIHbmgF0JFGg8HnrzFo8mRZmKKk+eC41QdByHwD9LXa1qLivNSLlD63M/LbEplQCRPLksHx4CMSBoot4VBpgYeQcY3/wXFB9MkrxLZ5T3WettVKA5TAZVJvRVa3RhDl+8qx3VA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uijAGsxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEB4C4CEE7;
	Tue, 18 Feb 2025 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891602;
	bh=DX3TX+7yJwABho/ydv17BCgSzeruh7GiPooXHU5WanQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uijAGsxggthweKXyPm/uxvm0uOSini4ZBCRBw7EG19jwesyfixSqWpCn+xEH0Zgx7
	 rOe1mORnbp5za5HsPstp/jYp+ahEZQJFB6q9Ow/wu4dYUNSqTfypD9/mttXEz40gTU
	 JXZNPt1aoJMyKJW6eDb7T4/HVromP+HqEE+HoYTZbFmCEPC3kup3p4alAcT/0poAUo
	 wWLatex/+CpTqhEH4oycuQ5YEhpJ0h55+C5YgwXgEY9ci2PMmM8F9b95jwh9gP39DX
	 RyPHNVWF9jATpPw6bzMvgYCzyyHmmcwBO0Zxeyl3DunOKkzQiVTcXJnRFFpj/CXFDn
	 TvUetn4i2iz0Q==
Date: Tue, 18 Feb 2025 15:13:17 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 02/29] ASoC: tas2770: Fix volume scale
Message-ID: <Z7SjjcaJNfFnQ2e4@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-2-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ZYleMwCcuejHCJU"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-2-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--2ZYleMwCcuejHCJU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:36PM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> The scale starts at -100dB, not -128dB.

As mentioned on your prior posting:

   https://patch.msgid.link/20250208-asoc-tas2770-v1-1-cf50ff1d59a3@kernel.=
org

--2ZYleMwCcuejHCJU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0o40ACgkQJNaLcl1U
h9CVjwf9Gbd2/n4+ovKr3KT3qVVMZdcuraD+qN1dgJ1bCMcQCSRk+JCVmiysFY6B
H8gAIoQVrZg5f5fHJ0YkysipvuupoW8yng6Ja/WQThPxtVLkUQ2iXkX/LVsZnqr9
XdJmvT5j7b89qzBTU2opj8pS/v2Y0KzvHMRhABFlsprr9wy2vHWOS7mttN16VviU
h7F9UYtdCNIEQVVhm7SjeiMMrQQqpSq1rCCElqpIA2ZzyWMdDR9/jDs38ZGmMLzm
PMFakD82X/xRK1AuMK8YM/mldl7P+pLpIQgHmkg26j0b0qcIwZSy5pTIoe+p20nr
8ULOrHg9L29ZtEMdD8jl1XzacCbxBA==
=XhYq
-----END PGP SIGNATURE-----

--2ZYleMwCcuejHCJU--


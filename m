Return-Path: <linux-kernel+bounces-380183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6589AE9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79851F21817
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1831EC011;
	Thu, 24 Oct 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB9FPtXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB911E1311;
	Thu, 24 Oct 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782576; cv=none; b=O6/i89NbLqz0pVo1ZZmydBHrfMlKYumJWoZRo2nVC9/am6rL3yuU9zhoFvGeQR7Rg3IfoumaU7VVKFoaKI33GirRmsDgvTjAUshLaLLUgmjoHwIAGUxGkl/KYRT1AsGz2Zh/YyIBkf7WUPjiqcx0rgdGNNdO09432H8PuUn62NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782576; c=relaxed/simple;
	bh=+pTvRCFC7sKMxB1evjqqpspFt4lrp0oc6b2SQ6jIKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcOblLUQxHK6zN3V1u0CZuTsVdddOyUJGtm4TnCRoQ97MqoG7yRM3S++skDG3ZJhnjGZs9A5mZ+RjWNdsVuEsFSe7PN5sf9wj/fsd0KvueutdA/2DjLPcwFF0BZFpEAQJ+xdcZPMJHfTrG/qJHCs1raB/Vp3kLcR6ZHBwMoAO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB9FPtXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D24BC4CEE3;
	Thu, 24 Oct 2024 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782576;
	bh=+pTvRCFC7sKMxB1evjqqpspFt4lrp0oc6b2SQ6jIKq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cB9FPtXRKCHiLdzgfzx3mCuju67rnlId7dqtDX00DZadKopD8K/03yo5UX+pK7s+Q
	 w894RCjNqBlHRhgoZEbs4AxBMWpJ8GYK4LTiKsurwztnCOZM+wLQeYB/jNlBcGHck9
	 sHfufMZ77l1K4h9kN3sfvtMjNYrVCZh6xMsJLGFHV7oKRgZsCW5hvMl8XKeTIH1AQz
	 tr26FhG0mRIxX4QarE42yY35hCL/3xqyf9tldShuICDUQ12DeavNxl+nH+gc1AAiVc
	 SduIpYbqp07LlMzjV9Akx4+nEZGC9S+ysAUkekx2LYwDJpLS8rO6v+9yF0QN4CBbqi
	 lJ32LZ3mAeo9Q==
Date: Thu, 24 Oct 2024 16:09:30 +0100
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: Add CS42L84 codec
Message-ID: <799e78bb-48d7-4c34-bb8d-d5841493afd3@sirena.org.uk>
References: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
 <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TCB089Kz0BPOnot4"
Content-Disposition: inline
In-Reply-To: <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>
X-Cookie: Real programs don't eat cache.


--TCB089Kz0BPOnot4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:47:31AM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
> computer models starting with 2021 Macbook Pros. It is not a publicly
> documented part. To a degree the part is similar to the public CS42L42.
> (The L84 superseded L83 seen in earlier Apple models, and the L83 was
> pretty much the same as L42.)

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--TCB089Kz0BPOnot4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcaYykACgkQJNaLcl1U
h9DQPwf9E9jSfhztP6+XVDmCVa7iy3DfHKlLWKTqhhxoKsMMOzq1kJoVRHPfYjgD
pflEB1G4pdrCa2Ee6SH9+Y/XdOqzBwUZlaNog0sJl0ZL7rErRQRWn5hRj7b/EqFy
i2HWG3pF+UPpy62FKsy184SOrfs/LRwJJnHe3Zk7jkgtUJ3LshdD9Go/mgt1QrJi
RTaDet9I7hQOfaBYNfn5k6gf7iHwduq0ADR40Jay5EB2vnsWBIUAEiHvm5vV/MKu
lb6sqCuegH4RsExhQW6e4lJFByGXKpuistwFRqGa6Txt1OQHhVl6tHHWsp84zO1s
Ho3bUFgZVoffghPxgcG/t+LjGiE64A==
=tOxj
-----END PGP SIGNATURE-----

--TCB089Kz0BPOnot4--


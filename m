Return-Path: <linux-kernel+bounces-281634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90E094D919
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58743B22A26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5DF16D4C4;
	Fri,  9 Aug 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txk8RPRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD226AE4;
	Fri,  9 Aug 2024 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246062; cv=none; b=T/6sGVBhzoLPo6jbrZEeiYCmIxQCG3mN96K4+ks9nzJXBYAZTppbL80wtyFToCZWPPB0KKXYiDswdqwB20EhwbUF8N8V5aHXlhwFAeeck6of659hl+tuYzSd+DfVE9dAAUhU5OZvOmu54wEjiDBUz2mHR5YrhwBk94EQawJJ6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246062; c=relaxed/simple;
	bh=xUsKLR4zWYnJT9y7G1ygwy0DPpPNyOurGAR0AtKb+BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3lM5DEGy53eIcL/HXL4B1yUsoQdriLiK+9mLm2WMQQFUrgKYc0A6xkVEGn6cggxYM7GjS7jqit19VzoobxuvkGa3dibjH+nhVjxQKHaM/l2QaFSkBGXv07AWyCS0DlZEiFw+P4G/sUU8HGyRnV6Q47sx87Z1WfPkeNk8+j2smU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txk8RPRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891C4C4AF0D;
	Fri,  9 Aug 2024 23:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723246062;
	bh=xUsKLR4zWYnJT9y7G1ygwy0DPpPNyOurGAR0AtKb+BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txk8RPRDqGhf+5ZiYnVn+HRXgou6FTRRvAj5/j4152rHhchNuvaaaafmVSKhJ4Pc+
	 6WDuHXU/d7tG2vmrygwjvTjsFrN1hOkZjq7RT+4nY953Hy/XeUgK+b844DAedyqS6A
	 Wl6FSXQ9fWLkDkJXx8XD3B2zUz+NmHcbAUSKLMKZ5c5eosLQe4H8fNE8CLQy5OuBk9
	 nH09X3mRU8zic7VCqJwtfzWLPotT1VbXwiu8GPiFYmSI6TFtNjbGjFKSmCl2Pv2otg
	 9aNrxdrZCzxt5nfPmsXfhxb/eujJ/9C9u6rWbiXpqOKjrSWX8NWLpcwDmDym+q4fl0
	 ACacER/Jvk1XA==
Date: Sat, 10 Aug 2024 00:27:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
Message-ID: <Zral597nrlHHj9-W@finisterre.sirena.org.uk>
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
 <20240628122429.2018059-2-jbrunet@baylibre.com>
 <326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
 <874j99434a.wl-tiwai@suse.de>
 <1j4j90hurv.fsf@starbuckisacylon.baylibre.com>
 <87ed84rnk7.wl-tiwai@suse.de>
 <1jcymixfou.fsf@starbuckisacylon.baylibre.com>
 <87seve6q9u.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j9aCuwDsgaYEuagC"
Content-Disposition: inline
In-Reply-To: <87seve6q9u.wl-tiwai@suse.de>
X-Cookie: Your love life will be... interesting.


--j9aCuwDsgaYEuagC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2024 at 10:42:37AM +0200, Takashi Iwai wrote:
> Jerome Brunet wrote:

> > Takashi, Mark, what is your preference ? Should I:
> >  * tweak the spdif codec to use RATE_KNOT ?
> >  * add just 128kHz, fixing the 3 file above ?
> >  * add 12 and 24kHz as well ?

> > I don't really mind one way or the other.

> If there are multiple instances, it's fine to extend the standards.
> Then we can clean up them as well.

I tend to agree, it seems like an obvious thing that people will be
wanting to use and there's already multiple users appearing.

--j9aCuwDsgaYEuagC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma2peYACgkQJNaLcl1U
h9D+2Af+LZNFlSJBrfEP3351HBCHpFs3TZZnxbfrjvVH0yUKD0hjTTetbbvhdGvg
osn/y10PkEQQ9dESuH+u9CshDO3rw8XPBUlb58L7N1WfRfgE6J54tM7RqaipHv2D
oRuNwSLn9Z2D3/QKywH4MgAcZo+JLKQMWaQnd7IiOItG64qdf4VPolKK4qZj6xlk
wdFrnMEXJn0ox/JRx4gJgZJh0a0YdkRIKaLZIDuOTEJFMK+cfbzlsNtcJPvefZqA
VYW7mPEUfqPqEkCenyVr54ikDvbaDVDxaXj1WumDRU9Ju4lSGWw9/OqDUX+ypmdJ
RQeMnBz4fUojzjlmKM1UkSlHS/o86g==
=/6uj
-----END PGP SIGNATURE-----

--j9aCuwDsgaYEuagC--


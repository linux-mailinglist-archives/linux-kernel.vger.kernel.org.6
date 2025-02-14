Return-Path: <linux-kernel+bounces-515352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CFA363A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5DA188DB80
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74526773C;
	Fri, 14 Feb 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kC9EnAEA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B0266EE6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551951; cv=none; b=NaRr0KAAjbfo2uru/dR2pextF6ardI+Vf18Ov46lGEGI0Dfl9Et2g1CXGYG6MvGNPKh5hauqvPg4uGDgNs8HwGjTeXmHmoaYS8NpDsFHAx+6zkx5tJNITN7cYd8JqSZsnKMgVovAOziaYNs617PpfsTgff6JvfVPfczhsG6oCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551951; c=relaxed/simple;
	bh=VbDQ0g74dQz0V/XJPOvsPF6QUb1grANjG52ukItI0yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X64qf5svsUn7hlFnlI5CEUGDFwJSbhKGWj406fsGPTqSzFNmbjei4pCY45e0WTaiKUNZ1KgRcM00REElt7SZSbrfP/zURyCQm/epiTy3M+gINAKW4tFyyOEO55vEkTx/9LGdsb3Xu/MOvBE7xMl5XoxXEOdhJHnR4WrclXYb008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kC9EnAEA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4396794c044so11185525e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739551947; x=1740156747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRPEzhgN5fblYnXVk5o/xaVvZgb7XEJP2riyaqwicb4=;
        b=kC9EnAEAQjpteBcI5f99mBndvtYpioJukzn/doODLiteWMrBptr7MfBokzXiwxTEJE
         0l8xftV88F+P2pSREl5I7SlyGq7ZcX+GaorLjPqCrt1cEbJL/txhnnAgsuXi9agprduR
         xUXgCQVpR/GOIjRKy1Zdl4OrRB5k6m4hxkmceEMShlzqct40juftssLYPU39JuoqxdmL
         809zcpmQPpJjqfrfjUgLHlCdhiBWQ/LKU1u3byhhV53U0dIwxPCq483xmIhvIWSx6qcy
         AtdSw/Q9fun1O7ImHt1txglJlKapOXOyEf3pi6UrUabP9UZX5RltHl2U8HnCAO3VyEY0
         rOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551947; x=1740156747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRPEzhgN5fblYnXVk5o/xaVvZgb7XEJP2riyaqwicb4=;
        b=Mn53csjVy3cppoo8UxTnOIxyuZwuGrUCGeaEV8msaiNqcN//D3+CdCroqYFo0CXUBw
         ONIa4AHNdBTAEvhIM0WIQI3oLe5jF1HDvBbw2Ss8NmQJHR7CggjPhYDeUA0p9OJ3+DWa
         AMV1TaKZAoNDH/1Rov7d01zRv/69bbOD+WNd/tBiOl2ejf1IKVryWb/MWFozktJLWGFG
         V+G3frRGAC3UsVCtkT+1zJnrmLknZwYCwrZrQ/NNaaZEn4TJBoi1q3cls8Nv+hoEFNtU
         1NKDhzQuQpFTnHAulBX9pg1aMMrfzSklfHZNAJtQvZZ95SI5O1K25e5Cpp3jX/yYLSFb
         9aqA==
X-Forwarded-Encrypted: i=1; AJvYcCWRGtIROSV4pbKNoC3BIPff1KVHFJzeo61r5T7oBMTAG5GAP9k1sNuAuUMrXnhxFkLTgZ7DDQFlFavB6co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWaQjVDtOsqyy9SbZjWU6zqCjeVp++ZPeuyv229rkM45+/bJEW
	g45tU9aR4DszFXebBh0zgdzlAh1ablIHExtxIJ4v3QrX2lS/+ynx0rUiuByGrBE=
X-Gm-Gg: ASbGncsjFakJy5UbUzCja6Q7X/Rfn/qFZWGrzfAha1TMe+5p3bF++HtPOuQHrgz09vA
	r+VojYCwmYk3Yb2ArOrAE+Rk0dvrwbMQqLl4z6Dpis+gqnzOiun3ITRLVLvnIvM8pg3Mh9ru5qR
	kV21rzMxCUUY1N7KIfY07vKmU3rllF6cAnBFN6j9NvDHd/kQOaPmLrzszEbzoYVMSDe4YKKDEBc
	2hTvjd4XPBb3vCVB9nOFrEnglsQePBcFhhV9VWJLhLLHtCO3o2ImQ+sLsQCel/yceVP183RJENq
	YDyKSFWUIOmHSIYqBVA0+Vwu2xM4W/brBCHW/f03n0FZyWk9sBce8sztkA==
X-Google-Smtp-Source: AGHT+IFlZ2HKkRaK0EiyTmZxzbqyF2rSBQprGvb5jO0yOIa4i2P7+/m344v7o5cegCF4JTNdYGdVXg==
X-Received: by 2002:a05:600c:4747:b0:439:55fc:81ad with SMTP id 5b1f17b1804b1-4396018a596mr128534855e9.7.1739551947491;
        Fri, 14 Feb 2025 08:52:27 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396180f231sm48709735e9.16.2025.02.14.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:52:26 -0800 (PST)
Date: Fri, 14 Feb 2025 17:52:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhfwkzmwoz5vwon7"
Content-Disposition: inline
In-Reply-To: <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>


--lhfwkzmwoz5vwon7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

Hello Amit,

On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> I'm thinking of the two combinations of interest: REMOTEPROC=m,
> VIRTIO_CONSOLE can be y or m.  Say virtcons_probe() happens when the
> remoteproc module isn't yet loaded.  Even after later loading
> remoteproc, virtio console won't do anything interesting with
> remoteproc.

Where does the interesting thing happen if remoteproc is already loaded
at that time? I'm not seeing anything interesting in that case either
...

Best regards
Uwe

--lhfwkzmwoz5vwon7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmevdMYACgkQj4D7WH0S
/k5yVAf+PF3RJJb1sSpvLml9FywSM8U8FkRyUD8w55iTwpy54G0CUm2SH0L/o42n
gqND5Dss7+vEz2Hm8SbqNXiK1bdTwX25d8eqQnprlROdLDJaho5pEMNd5EXLrmFb
grRpF2dYTmXA/gtsCnSsS8EknB/bQxfS9b9mZ1wH9daYlzoi1Ypdcke75+1q+GcG
XAt+n97SCjMXFd8xIvBmYPQwflHuLrWiClNu8lyR3CAv2G6E5iu/3ne0hhYZC6xj
BrW6pLSSCfNHqQacsa1yRaT03CGaI9oqT3Nw3oi9OFeaFoF4QPYGFfXta4jgPIUD
WVRZL/M56BGD7n17nBeu3IrSKqSzZQ==
=S2mE
-----END PGP SIGNATURE-----

--lhfwkzmwoz5vwon7--


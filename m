Return-Path: <linux-kernel+bounces-242124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031289283CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C9C288ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E0314533A;
	Fri,  5 Jul 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ymtPqo1+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFD145B29
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168753; cv=none; b=UEftyKjXGLPiI/UxL/6ouDjf7vmS/PqqfNVNOMxDiDWtNSI9vFpMKFcFP0bctyZX83DTpEDnWzk4DXBCiykXfn4u2m0YkaItQ+eP2re2FoR1GsLNoN2TR702Ib6lgEMxteR/mTpAmwiyeAcgqSTsMD9rKK0fJ4w5fU3JX3u6ilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168753; c=relaxed/simple;
	bh=NFxnUW6sIcABoselVxWhYUpLksB0JeuXkQ8S2qgSCXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzayHVHb9M1PO94vicyWA9eDqsciaYSm2THeCyeNZHgqImNUweQJaUKStvJgnvxm6JUprcNPcCnuHSTB/jO6suOxtjImKgARfSXWAZdYOw9kO/FhTqkTlmtEqkL5wpdLsorSwkdXWuJlUEcRmDF+gG7/QvMInZKIFGjf4ujMKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ymtPqo1+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7523f0870cso154510666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720168750; x=1720773550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFxnUW6sIcABoselVxWhYUpLksB0JeuXkQ8S2qgSCXI=;
        b=ymtPqo1+deU5gI19aQ1vEb8g1a2aIaREY6cJmWRwkfmkJK5LOw1jNCgC7fzdVT8kvW
         Xcltig9cMZG9jWEKA7ElTDNKcr+xJUCvVYZ43VjFBqUyoWSJBbX1RTwZiTFS3H55KMzK
         0kh4RNa5RtPfOLS7wwsM7BpZtQ2+17+MmhJde5kIZCDT8vWtiTvb4YmuVfe04vF8tx5E
         SKrBEywUsV7r+nko3x3Z6cOG0k4WpUuNBeZRM1/aCCM4sjjDY5v7yvNYv74OpwAlCWDU
         DdFdLOlcFr/SYn5OgmsXsjhRb42xN6qVQzYkQUzGsnfKBE5OM2+oCI4RGIM3xV3YR0h5
         gCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168750; x=1720773550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFxnUW6sIcABoselVxWhYUpLksB0JeuXkQ8S2qgSCXI=;
        b=w7RJToBXae9D/j4PfFzLMYVwyLuTKApYMFmrSINUxV+gD7tRbKHvd6nb5lOGd9Z2kR
         JU6pXuJxEf+EzMwZw981kzfnJbdGy0QrRwC9pefdaWszY/9IjuroUgQraCTbOXvnUuO4
         Q5HBE6nzZS+18jkhuhpY+7GadqaPwl05p+56jDfggsXVWrFCHcnFnHPS2o4p7nn7vLv3
         TlIJMQMjpMkq9lKY2KIUle9MNF7t91Ke03aJp904Hv79ClZOKR7FgOBOMEMqMqD0ZWWt
         FKA4Y2kBcxvZ44v024hWUj3OeAHMZg0o6tpyPibqZfbQAcbCXgNn06ZlvWRaK0H8VPAf
         n1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/E4gxiyVdb6Fi3wUIX98oHVz4vmzhspxPIS4yngPDrrn3XXZJWBU8c7VMShs8O6INJqme0GKI2/rjnD2OnM7Gc95yP0t3R0933aRX
X-Gm-Message-State: AOJu0YzJojofHOAcs8YYw2acWaifOxDyNj0dBLcLqRk2CsppN31xEWIN
	Bp58Ot8G6AnhVtjdtJtztrW/Dbx3iJ9AMFfnwwXYCHzdIj4rpG7rzXIppQblT20=
X-Google-Smtp-Source: AGHT+IG2SEwsAnIcVOwTkzLXnm7XZnpQc5aqV+x3//L+V802ZY+hTfZO37FMYH/9jcLN5q7vmy8Hjg==
X-Received: by 2002:a17:907:3d8f:b0:a77:da14:83fe with SMTP id a640c23a62f3a-a77da148597mr25734966b.64.1720168749699;
        Fri, 05 Jul 2024 01:39:09 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77d2d1ff2bsm22719166b.155.2024.07.05.01.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:39:09 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:39:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH 0/2 v3] pwm: add support for duty_offset
Message-ID: <7aomkg574sceoeu4eh47rbpsuz3msuysgw464mcfsal3bk6xwr@jmzbqa6phvxy>
References: <20240521194916.1897909-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syendkzu2ktxbvdu"
Content-Disposition: inline
In-Reply-To: <20240521194916.1897909-1-tgamblin@baylibre.com>


--syendkzu2ktxbvdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Tue, May 21, 2024 at 03:49:14PM -0400, Trevor Gamblin wrote:
> This series extends the PWM subsystem to support the duty_offset feature
> found on some PWM devices. It includes a patch to enable this feature
> for the axi-pwmgen driver, which can also serve as an example of how to
> implement it for other devices.
>=20
> The series was tested on actual hardware using a Zedboard. An
> oscilloscope was used to validate that the generated PWM signals matched
> the requested ones.=20
>=20
> Note that in addition to the other patches in this series, the changes
> to the axi-pwmgen driver rely on [1], which hasn't been picked up yet.
>=20
> [1] https://lore.kernel.org/linux-pwm/20240424125850.4189116-1-tgamblin@b=
aylibre.com/

I'm working on a more complete variant of that. It works in a prototype
stage, I hope to be able to send it out later today. I'll drop this
series from patchwork.

Best regards
Uwe

--syendkzu2ktxbvdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHsSkACgkQj4D7WH0S
/k4BjAgArY4jYh8XKLJdblcf1JauwvSI5VIrsUMlRylk0+WsBEgYbRE/8/CaDper
jlcLzXqLkPTy4VyG8NdILS/ZRMKxv2vp26qBvh3ScBizrbOkFVQyCpwOlyL5ohAk
W0X9ayq/R9lkLuNP+ZlcapQ8dy4vuCnkDf2RL+bdGWYK+G108kuIaZHAEUkjjyOw
jktYujyiGhVXfEk7O5yBA0r8+q1DL4QYFAtSY3yHFaLFDBL16pcRENO3jPGa01Il
4KUJFACU9AM1g+vk0Pq0ZFAHIs8VyAdQlvyTdnLtf7od6m0thLv6v0UJ84+vvHKU
ksPqVIDalGtNKy0DrvPKPuxnlH3inA==
=xyAP
-----END PGP SIGNATURE-----

--syendkzu2ktxbvdu--


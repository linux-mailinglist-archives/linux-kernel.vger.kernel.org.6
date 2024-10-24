Return-Path: <linux-kernel+bounces-380236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2449AEAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AE52828E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A51EC00F;
	Thu, 24 Oct 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h/15Vaty"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2121E3DF2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784462; cv=none; b=G2QPafcqZlAe6nzq34gPNDo3bW5xYBNGS8gnd0SxvhbbdAeYNEF77kFTN0+91O6brJWDQIz8yjNZSjuk+XiTqqmgSlPbhecFzHxfKBtXImx9RAz7s9J9+8S2tLgsRH541OcKmLueMXDRno3cKLRQCQEIciKmLK8GEyD+QOF5oic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784462; c=relaxed/simple;
	bh=xpmWqBMMZY+ldlsuyI71jzCpxTAScS3Agp69Pc+fSVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiswjFZb/VQln8gF2Nnv2LkcKd7hr9eQYNJGcsdnyfkO5n2swZWZIZ6QX1VK9ZfoBWWGsFFVXIDFYPS3pPYAfSDBLICS1K9UqQivlXKj8I6yUjLybOB2A3YGvSF46fwgQagrIBCgmgq4FCKDMdZuplUC7TN5ftytmoWy/J8r6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h/15Vaty; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so631385f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729784459; x=1730389259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bCYWtAOVAoz7K5tYQKyYohM0VdNcKN2It0cd1+edXw=;
        b=h/15VatyTE3kOoIkNvZiFQJnFvB/d8SgzXcLMJTbo1DgSiL/FcuwA+cztwU+NEaC9s
         qIxiiQxFbYDCtY47DBVJjIzw2BQDVFX/gZYJ83b+iL/RDsLGcwFDaiKq4oVEIFE50DnE
         xhmNPw5XOYBCDthAnv9ZNOKylH2o3k1nLOVSLqfkB/Sg1pOn/sRMT62jbNGUNvlW7HZj
         1m6QegbG71tmcuPeeB7mWfoU7H2GA8idHyA6zKK6OiS4shhmUzMi9T5kj+/sW5OTSaZy
         b17slhlt37WZ6uOkPvQbgqg/2L/yrtJDB46WeGr+zX+3z8KnEwDpjdpKgOGImpRxVodL
         grEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784459; x=1730389259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bCYWtAOVAoz7K5tYQKyYohM0VdNcKN2It0cd1+edXw=;
        b=ZoDSNZSSvKBBv3XdDjtDkZwhVuvgx+M+v+JkCpJX8lPRocbGfxzgAGGZZujbccYYTJ
         YglOIY1tam1HNG3nCzttpXhe77VtX8lPMx7EdOe1Yp+JaQUNWen/JBzegbfmuPYmlgRA
         PCJ614HzlBBYy235nkCAlRoGReQ+bG/58xAaqVfv268lVXQO57y175g3yvbYWe9djFL5
         vgLy4RQK2oyoCoLEflsFIx3Zo++fYkTuG8iCghIm2u/f4ENPcwAtBKt6Dm49Bz713KQS
         XOotjuuXQGGe3iTph9MKii5vzH63RfUE8peyJ9SVP6Sy2QD6b2oL6tzPN2MOQvn1Xvd4
         JCUg==
X-Forwarded-Encrypted: i=1; AJvYcCVx6d2zTLe/tJngiwDQOqlESnuLbjYINTUl2qn6l19uOEzpVL8upTbm2pozJ5ftZKowRd+AJoUk0lVeONM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywts+T5+yQHJ1e17ZPBqO/i3j3kx66fblBtoPMKXCMa+/0BXhzN
	5WZuD8pCw1yoenSznu4tZFJkoZdkseDzQwG2jFnxhCmtudElvd12F5L1vTEqwwY=
X-Google-Smtp-Source: AGHT+IERp2/eNZzsX4yv8fUUuhjp6KA5+OA5MDnyg6uPYvR/RwNU6G6ctkdJPcWzcvsaqhcAR5Qg3w==
X-Received: by 2002:adf:f7cb:0:b0:37d:461d:b1ea with SMTP id ffacd0b85a97d-37efcf898d0mr4107198f8f.48.1729784458868;
        Thu, 24 Oct 2024 08:40:58 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a64dc1sm11574470f8f.65.2024.10.24.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:40:58 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:40:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
Message-ID: <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a7vvl5mbgvv3nbps"
Content-Disposition: inline
In-Reply-To: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>


--a7vvl5mbgvv3nbps
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
MIME-Version: 1.0

Hello,

On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:
> Aspeed PWM controller has the WDT reload feature, which changes the duty
> cycle to a preprogrammed value after a WDT/EXTRST#.
>=20
> Billy Tsai (2):
>   hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
>   hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload

Huh, I'm not convinced that extending #pwm-cells for that feature is a
good idea. Unless I'm missing something none of the other supported PWM
chips can do that, so I hesitate to change a standard for it. I suggest
to make this a separate property instead.

Best regards
Uwe

--a7vvl5mbgvv3nbps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcaaoUACgkQj4D7WH0S
/k7IrAgArevIMEswllDmtB0TRJ5jEVNA4EsDQ9gZpjcVMdMbOCk91dxWPNaRWLqz
ZUO6YMK+BjGJDbYkAI1x0i73kN3YXUSAxcAAAiKeltHm3LgGqmJgNYFSGiGfyWfr
RZTNj7fkFkLBIJvsuuTV3JpVFuYpd0Sb9kWnsClMTwGoY8macjZEJU9E7syerxE4
soEUTZpYo8Rnj7qAIoBQJaj8R8wjlpzlT2Mge6xQ+DefHx4fCKuACjtmR+wzQVuq
4EE/51+wMfTDdzk2ZTjJwjYHQYTSGHoNSUhgBxtSqve5A8Onb4NRidJbXj2Hk51x
GC8JYGqYPWON7jZmu5rUFjw8yD+kLw==
=TvtQ
-----END PGP SIGNATURE-----

--a7vvl5mbgvv3nbps--


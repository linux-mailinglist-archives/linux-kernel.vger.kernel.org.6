Return-Path: <linux-kernel+bounces-371242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A039A3874
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A675D28604F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1D18E02B;
	Fri, 18 Oct 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aaGa3toz"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01617332C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239908; cv=none; b=P3oBHFcpGxCLktnoAnWh016aQu4PFB2IDl0x6APZ96Rb55nnk9gBGvDrp7vgOIVqlBqurgo35PSRI09mrv5GEg+uRdZp2qJohaNrkOMumbX5ui1iA03pM8mk8lO2MK7h6ZRBq7VPN4HLs5l/3hhKF1cdhX8Em0aPCZTvuOEgF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239908; c=relaxed/simple;
	bh=zHWvZeWAw1nXOZSuhULXmpmjc+rCAaz0RWexDlypXUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz06Fzyfuwxt1GQm6ebRhzR1Xhu1b1dlj1Q2OVdmwlfG78EI4w1T8aUG410VrXJf0MtHbXo19t1R04p/j9Lde31wfHMvvs8WTHxA6taykvaO88lRjFzORt47enal8Bi2Jb1Qlm3gMWjZXfKpVlKrS4kl6spMvjNy3Y1Q/a3qDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aaGa3toz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so334273f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729239904; x=1729844704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHWvZeWAw1nXOZSuhULXmpmjc+rCAaz0RWexDlypXUU=;
        b=aaGa3tozDZzwc2G8DgWDvcKyz4jXffvunwttv/sZVbdvnn1MNI2JeN3c3Ya/jmk2MP
         qeZDwQWeOxYp28VwA2qdG7iKDFEF0dG/ONz8cwLKXELPE64Lq7LAk1Gb5NSggL/aKnDE
         tTIMJvDgt040Pul0tQlyO8j/wtO236ftXnUHTk8u3oZIkxDGIRky5/K/koGo12OteU2M
         CfNSmtor8L12MpkzezHSxfVJit1oX7HLufaCQuTv+LqdES/B2HRHfe/Oa92ijfxQhiPU
         rHvdP4Bt8r4JW/UC1jPuuX74Z7/Zu0fRorFog8bnRUPqSHnk5kn4iNFcZJ7xdSj+tiaP
         fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239904; x=1729844704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHWvZeWAw1nXOZSuhULXmpmjc+rCAaz0RWexDlypXUU=;
        b=J55sbfdANuB5heXO9XAanf+ME0P2XpG+LcCeC8WsHOpyDKyvMZWIYQSxGftHH1dgli
         5Z9a1b+2XhLZrkvU0cqUq6zQgJ9RiQAt4hCkq/wI/yiIhoeIMqU2RE70NW+zN1/ciTvB
         JtTOUyY+HvWP+pseStNGokHu9Wk7ZWz0pJqOkCrQOJWbEknmkGARRFLbfc2Meo/bYbcn
         mv4IVCbq9AcxqBobfc7J5aa9h9yYzP45rOsmTUUZydOrNVAielTyv/6T5rDYII8IUwOq
         opRw3UrqbzX1UPZ8awqt7Xuch8JoVq53Z3uStBJjeiBbEDyQ+sw9uU4vMoQ1Yxq7Yye5
         vnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqeRsD9v0sAINHD5rV7+YuUT4oeWqR4jDsQbXqwrpvCxPNvQZ3CFHQocrypKsNzFmud0XgX8huPIsyU9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvVuzoryXD1qsahvs0j5JboBzhKByURbR0r5shHuOVjQWP3Hg
	HkweWQWbYOlPH8hFAnS7f3RygcNBBJe5O6hA9xInxULMspmQulIHuGUMT4KvhwM=
X-Google-Smtp-Source: AGHT+IGfGYoF1ues4V7q5yChqm3acmG0UxUp8HRtoojXSyzX8A69mfET9xFWRaEMAwwgylLokS3E1w==
X-Received: by 2002:a5d:5e10:0:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-37ed2b7afc9mr386203f8f.8.1729239901491;
        Fri, 18 Oct 2024 01:25:01 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027bebsm1284373f8f.7.2024.10.18.01.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:25:01 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:24:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, michael.hennerich@analog.com, 
	nuno.sa@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for AXI PWM GENERATOR
Message-ID: <rk7vlz4dgs6oisbhwhewq6yah367t272pr7bzns6fz3rwlpv5i@mcom6trat3tj>
References: <20241017174744.902454-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgwtgw3kyjry6xim"
Content-Disposition: inline
In-Reply-To: <20241017174744.902454-1-tgamblin@baylibre.com>


--wgwtgw3kyjry6xim
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for AXI PWM GENERATOR
MIME-Version: 1.0

On Thu, Oct 17, 2024 at 01:47:44PM -0400, Trevor Gamblin wrote:
> The initial author of the driver has moved on, so add the final
> submitter (myself) as reviewer for the AXI PWM driver.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Applied and pushed out with Nuno's Reviewed-by: tag.

Thanks
Uwe

--wgwtgw3kyjry6xim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcSG1kACgkQj4D7WH0S
/k5KPgf/RAAOaWwDMeXosltGXTcpEW4MQSHihXQoqed8LB8uGfbMtbC57Wt9A5nY
a8J2Q2xS3ztKFV9E3qedy8hBK0AayA2Z4WZLScRX5hAMNLhcMzMcXmgBf4SEjQgV
oZu3999XtH4VqfFocVWpQswZoCw9qwhi/MJ2n7G74ym2hYDW83nSPBaAe9MDjjjO
9oJ3tpBa3806fIrSnohg//tEiJc4bkgjz4t2VMc4J0P26g1R+sCuf6icyoIw1azi
cUwk0lBEMv7mfnEyLsRlV0CzUJzBkWRKHDckEmJPWYvwEEwQHiIrG98O5lhDzAM4
hHeYsmvDrNGLqDEsph8rLXzQJ+oBcw==
=ekwB
-----END PGP SIGNATURE-----

--wgwtgw3kyjry6xim--


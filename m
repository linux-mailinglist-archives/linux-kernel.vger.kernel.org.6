Return-Path: <linux-kernel+bounces-243939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47092929CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7863E1C214F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD601C69C;
	Mon,  8 Jul 2024 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3d4XvO6q"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480381BC39
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422326; cv=none; b=QwB9APh0uLTLvcMiAvZ+rytctpJ7GswaxsKS9doY5tYk22U9jBWYNSoC76J7AYVLNMAY8H0QidJyF7a+2vR2Z+sFwgBEdRgfzEBmpqTgtBKwML6rJiXteNYvk5HyBJghx74TL5U1qICyum5KRU8DC6w6oYzNMeY9vHi0oHXu/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422326; c=relaxed/simple;
	bh=JxboW2agm27PafaaQgl/MOC64uXKf1JImrEeXJQVaAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvmM3HzCxPJusVN1AmzVziLFRxMN7ymMOf6Pb+1XMs2FXHBPeNA0eFWcU6Jeqs+YcwnwIkw/BfrxJSVBTB35zrUWT/GAg0AWwYR43tfq5bsqxVfTBaJR9jeuADYhDStkhg6PRDPAZ1AJVA2SldTBO7NWxA6fIlfcN7uNDUHELoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3d4XvO6q; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so8137721fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720422321; x=1721027121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxboW2agm27PafaaQgl/MOC64uXKf1JImrEeXJQVaAQ=;
        b=3d4XvO6qHqdD0ZSQe8HZvsSTRWu/OkkMJTeTQnOlX8v/Cf5sphL4ciF4tmGm3quwBM
         T9JxWPAWjHI+nxw45aV5cPzLad5yCYFzgDLti9jIIMpLPFZWm/Bm1jpCjKOOsJnaNodR
         lk0TX/49Bu/+uw3dcxzKDKU3IG6Jx6lgQmRVqxwwLtARj6Y4/47tCk6wvpHQcMd6cW5z
         Vola3D2m2orhHi1Kd7Fntf24cY9EugYu31hwlFQqhVGFPv+xiLfRqeKeOkP6uUcTlntZ
         3Md35jKH+rEXzaOPBSsfqD6qs4UN5yEeECtVvaJOIbmYDYJi0OJlKGkaTGyKdcWAH9+i
         6wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422321; x=1721027121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxboW2agm27PafaaQgl/MOC64uXKf1JImrEeXJQVaAQ=;
        b=Hl+7K3pbtZdKrjAIr7mk/ZrtpwZhHCIJ8EEISabuKQJ1T7KDs4k0SXQEH8Dlq+7Uws
         HBwDQbBEewFlYg0oRgBlSpo7GhJkNtIXX2+rEh06JemjQv+5wlFix73gtORl6/hLIL3D
         8W/MOQgAJmT2AXw+KwBM+5n7ly2RzDksPV7pjZ7l5JknfqvbBAVVY5T9gKxaCmim01nH
         JAmpuIE38TCvbsNpQZY30W+sKsAUY17bvWJejgfo+qJB0lrL6pflVnb3513ynzGGY9wR
         OuiVRYNfMp8kcf9T3pu9cM03GF7chagkrnr3bLQpgNGh5eLoSUzSefdH5RIaVKQyLAwd
         fe4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnZc5tIbIkTt71XDVzPuBVDsuagItMntNi82SHohqp+v7D8J1EQ+yO8s4yUNTQ2JU4SgQd6oowiWXVEnyA6pMld+2EcIWpdD9nJO+T
X-Gm-Message-State: AOJu0YwLaUByrcNmHfQCtugYi4YPGhpGbPvipoLQ74R9aGFggvqu7ig7
	71J6vwxuQI1mlDWlakfb13dN24/tUqFiH3BDJZt+0ZiPPVIGkQRVRJbe6C06/yM=
X-Google-Smtp-Source: AGHT+IHY8aR7tq16N5Cp/SnkuPBsUo7fu5Zv05MtBmcKmmCRZr6aRkgl69esVzie3OuRW6GpmT787g==
X-Received: by 2002:a2e:9689:0:b0:2ee:44f7:cc74 with SMTP id 38308e7fff4ca-2ee8ed66d3cmr71825711fa.6.1720422321367;
        Mon, 08 Jul 2024 00:05:21 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a0522ea3sm9727630f8f.27.2024.07.08.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:05:20 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:05:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mul_u64_u64_div_u64: basic sanity test
Message-ID: <nkvmie4gedfeqw545wl27wwiw7gderp76tvjnehpd4bf5y7suu@sp7dclirn35b>
References: <20240707190648.1982714-1-nico@fluxnic.net>
 <20240707190648.1982714-3-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ywq7ce34uuzwsn5w"
Content-Disposition: inline
In-Reply-To: <20240707190648.1982714-3-nico@fluxnic.net>


--ywq7ce34uuzwsn5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Sun, Jul 07, 2024 at 03:05:20PM -0400, Nicolas Pitre wrote:
> +static void __exit test_exit(void)
> +{
> +}
> +
> +module_init(test_init);
> +module_exit(test_exit);

Can module_exit() and test_exit() just be dropped?

Best regards
Uwe

--ywq7ce34uuzwsn5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaLj60ACgkQj4D7WH0S
/k62lQf+JkfA3mgUyLgeMFxQthn9fwGEW/alud/tgsK4bVD3qpCCNkqWi3QO3JaU
RYW8peQij9ejat+ItQOJke4zKRMK2jolszRmnXXTEyCYyShptQ7UaPzaV6y6i7h5
QEI6Thw0hQ3ZWagmIG4IOJ9KJvvBhT6glSvx8FbaNj8UnUZ4jSZfRaKU5Wz8i4kh
Ums0Ss3IUoghClHz9i0i9CllqVKbuRrWmdnAGm3dnuugrxxv2d5zf2bJ2U3fad/a
HYw7i1SVc/nEY5/GFpHnXJIBBRdvCBvULyKklaWVfJn68eH/OZz0y58Ww1TuKC7w
LgnndsIN7+C5wDC0ORqcIleyIXA5FQ==
=j9o/
-----END PGP SIGNATURE-----

--ywq7ce34uuzwsn5w--


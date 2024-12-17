Return-Path: <linux-kernel+bounces-448870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FE9F469B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A524716BC85
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59661DE2AC;
	Tue, 17 Dec 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CildxNoP"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F21CF2A2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425730; cv=none; b=DuiNFoOmGkp43cItdm7/QsgCXf3KJ8INXP7gUlJ6/YIP2PuPzHFf+YxJQI3AUAUTh17FqSxmsOjeDp3tF6O0CKv2DLtFkRM3CW7pDlr43vTp72fI64lIPjZHHr9BZDAWl/5vrujGFORNa7hOkvUIiHoGKWhoYhshhrdKv0qJAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425730; c=relaxed/simple;
	bh=cuxyL8v4tnilELGzNvEWCHqBTaOLE7bmfmtakrW6FJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLwAiCrbcLwxTO0GLysx2vEJVCC5Pll9XyZVG781IXXLvkrwu8kmsex8+HXHDtVWqhr7IbgbIlHbhd6kAfl0EQqXPhVL/FbxFPHU87YrSzOFbr6cmasr1Q5msKH0eUw37qlhx6p75jXGqDd++L2DJJrQ3fjotNdDVBP7hwa0Huw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CildxNoP; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4361815b96cso33170705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734425725; x=1735030525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzMzEWYF4JXJMl5I2vPSjh/3wjpRKRmLIFv3W3v5fbE=;
        b=CildxNoPeXqhlvG0zCO4xtmZ5aWtEAeCsaGGWHXxHczsjC/41O+UCAaUjaUMkT0t+Y
         eb9oh2bj9sAftT6zTqI30wdvsoMs/E9hiKzeW1o+Mb8bvF3BY7lKpSEAUNRsSaKa1GUG
         Yz9jUlCiQ10AlxPbelwmhJ06H1hejGn0VbZONqg6qhwW3TBlede5AVEHIZSMyLnBIKR/
         Jya7YmzP2Ff5H2zpTYbp2zcBEQUGk4nOjnqv2RF11vvbGBXLYYwVlrPysABDIoO6IuQy
         o4I9px4ubM9RTJn1BFE7/T5dwQvrVAOd5BD0AXIZSKa4JoMKT2Ci6yYPJYblMHmC1ejp
         pPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425725; x=1735030525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzMzEWYF4JXJMl5I2vPSjh/3wjpRKRmLIFv3W3v5fbE=;
        b=VilbWEKbeXHP1wcq1fx36s3ZT6AS3kHiCIoTfwSisG/oaFjkIUcQ40/ol960IflGY6
         CmwSNPl6Mht3oCLU7tEYIJ3jClwfrSo3LPdO9W9+1TxCLenRSiNEIYbHggszfWtpoqV7
         qjul2IHdKYZeYB4E8cCwYR0ILD7hzKtzSI2modUAyLD7dR1kfgePvjjtA1AnPsAY5r6i
         2XWpdvdX+/GE5TgfyzF8Mv5iCPi09awiwL6xN77qLLBqn5WAK2jPKIsXS/X4azNcUnNY
         Ek6nAX9WY2185Sz2u4gHcK33cr2ni+h+uDU0A0s4GPRaY0skze03pnczBgg9ckmeyhJK
         ZIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRHiEhJ01xNzXdbN6UQHWiDtY2ud3p4hkSoofv5LlpN6BgyYhX+wOWQ5mlZeNb70OJAhtDostAO4uX1k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4QP5uv0mTqsIO8HrCbotnDuMMoCgeFcPbsTJRvBfD3pR7Pm/
	uL3VJO+CQ6F108WuGpkexF1AgieZ+xgft5vJvD3fUb7seyk+6DNzzXgpI9zLS5c=
X-Gm-Gg: ASbGncu8VZ1W5WhW64aDJJEfRwLp1OIDPY3YFLRig9x+nxY4+6zjd7wuq3CLF7PDDpu
	t0lQcTL+L/xEIs9YeIzZGNWP/+tw89JVXRPHAv/+0QRqls5cw5LNUIhyzfwI3mG6gyfqLPUxdsg
	JpKE2G7HdOkXMQBF/zhs0EymYjuPpuKDae68AwOD4YyAJxxql9YYHak1QWGAY0f1xcfi9qvdGc8
	dpgTC9ZHtxVzk5bxou23eTpUV/jxdmio+nW4kUn0F+xd27eBnfSawI/Lk7yRw==
X-Google-Smtp-Source: AGHT+IGaMszbOv+z9nYqkthli6tHZOo5qH0QuIqbPOPrEPbg0JKqfPxZffDETNuPMkD2e5/fgD26Cw==
X-Received: by 2002:a05:6000:795:b0:385:ee59:44f1 with SMTP id ffacd0b85a97d-38880ac8586mr13046511f8f.20.1734425725109;
        Tue, 17 Dec 2024 00:55:25 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80601desm10489661f8f.90.2024.12.17.00.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:55:24 -0800 (PST)
Date: Tue, 17 Dec 2024 09:55:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jakob Riepler <jakob+lkml@paranoidlabs.org>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: pwm-multicolor: Disable PWM when going to
 suspend
Message-ID: <bhymumlk7nesrcdovmp5shhelcqrs5i4eorqoerobtc5p6jifz@ychl36jc2h5q>
References: <20241216213754.18374-2-jakob+lkml@paranoidlabs.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vopurjdzekoi6e4"
Content-Disposition: inline
In-Reply-To: <20241216213754.18374-2-jakob+lkml@paranoidlabs.org>


--5vopurjdzekoi6e4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] leds: pwm-multicolor: Disable PWM when going to
 suspend
MIME-Version: 1.0

On Mon, Dec 16, 2024 at 10:37:55PM +0100, Jakob Riepler wrote:
> This fixes suspend on platforms like stm32mp1xx, where the PWM consumer
> has to be disabled for the PWM to enter suspend.
> Another positive side effect is that active-low LEDs now properly
> turn off instead of going back to full brightness when they are set to 0.
>=20
> Link: https://lore.kernel.org/all/20240417153846.271751-2-u.kleine-koenig=
@pengutronix.de/
> Signed-off-by: Jakob Riepler <jakob+lkml@paranoidlabs.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Now there are just nitpicks left:

 - Your S-o-b usually comes last.

 - The encoding of your mail is strange. It claims 8bit us-ascii which
   doesn't make sense. Depending on the mail reader and its locale my
   name might show as Uwe Kleine-K=EF=BF=BD=EF=BF=BDnig. See also
   https://lore.kernel.org/all/20241216213754.18374-2-jakob+lkml@paranoidla=
bs.org/
   which says "Warning: decoded text below may be mangled, UTF-8
   assumed".

Many maintainers don't care about the first item and if Lee has a sane
environment my name makes it correctly into the git history. So from my
side that's no reason for a v5, but for future patches it would be great
to improve here.

Best regards
Uwe

--5vopurjdzekoi6e4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdhPHgACgkQj4D7WH0S
/k5hQAf/X8241mnPnqFaI59nd1MRvjuJVWpZptupbIOLwJgEkFP7Bp4qwq4x640y
cidry2tPdrgPXcIRcVsdGoN2uw9eMmNK0jxfWf+yX13Dpx/sPj3SUzDiXNk5TnhE
ihSw0V6fZNBjqqiyJtfaQhV1YQg4rehEVW0yt5ySjjwBSgI5ga1qq+qjgcK+jLE0
brB5EQZc6gh99jmxSYcxx9b9x+HCHDh8Nh4ySyK7pIfom6+hcRsIIXbfNnodYTxz
E4zMLGHDj7NJcI0scfraMCzEqgEAVGoQpTaz1rT2p7s/JvbaI3K3mK92MFs6nDy9
dp7P8I8te30sofESlwHicjFgZyzp6A==
=G10+
-----END PGP SIGNATURE-----

--5vopurjdzekoi6e4--


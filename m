Return-Path: <linux-kernel+bounces-445686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2529F19B2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1BF165E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976B51C3BE1;
	Fri, 13 Dec 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jcL3M9Q6"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C571B21B7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131470; cv=none; b=HNsAU65/JA6fDLH6qZqksmDBkEMng6dSpI7kyuITbTfkzIy86tQUOPULE07ErfPbLuc2xQuDUTFBk1d46finrz1yy1j2SCCOT/KcUOMDwgkfx9Z8J2Rd5QYTd98VkYXOmrljjbiVYP0WkurCCiIkS2KPOaewT1D0L405BdOiORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131470; c=relaxed/simple;
	bh=OElGuocFBxJIIUrP083Z7WLSceoDIf+47W69Zfej10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXtlYRK96Lg27x0NgCCTXyG4NhQf1JYDEojjkYrR60tOQmA1Xhn9PFU/sCpr2qFxNfHZ5OTdITQOKFDetv/sar+ZfX3iUb31618rEQntscPcGLsxp5l1Kl1J2sH4otaYirv4oNRMOI/3Yzy6upZpO1BxDFRlguVHPlmx48hINuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jcL3M9Q6; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1518795f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131466; x=1734736266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RleFjP8P+hY5wroaEP2jlCc10s2ZwVlQ4JJ/qX8KAhc=;
        b=jcL3M9Q6E2FhZpVsqYKYpeGI4Led6kP5xIOOABVRoTor1z//amuCn29M+5sv8WUhck
         IRVs2PGzKhPwPF4VE2DelIBCERER0KjGr5BvuI3+BYVQhkOdDJYgqdR4EANdn9Kt7/ca
         FxvV8o1t6UKGV55gh3vucQxXwod9FDqMI4BJAOp3OocMdsNwetY+FpOWvv2gW4ToUgbG
         1dZWGtgHwfBS2YohhEocdxhEFtShv1BGtQTmjQIXrGRalO+SldJLqY597ktIq4pW225D
         v+BMeyCalwFbEcWBjqzZv9k1BaKU1R8GFKVqAHM+wbGkErFHOKwu0Fb213oWdj9CIuvj
         Wedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131466; x=1734736266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RleFjP8P+hY5wroaEP2jlCc10s2ZwVlQ4JJ/qX8KAhc=;
        b=k9F02xi24oGkUBEdWNKVZ7+J45WCxHf9lUcBDiGJRx0C0Zb6ZIqoN7vHhNZVvukc8F
         CxXFjasi2qqcqkhLt1OgNodKjxTW8MaG4z9KxGsE47kCYwz/OvgLzr/lZSezjDYbMtKW
         pfRccbHeEI8XuGBS+BZGBTY/gzcBV0MLr6ckzIlCc73CrDSEjYYmx9xd9uMFhksZOAKi
         rIV4Y7MWOLuML9ssYeA2D+LeWYanDQkGvY6ahAasEZ0tQzP3oG1hs+0WYGnPkRB4GiPt
         EWhJbIya4hpu/+TJqNCT+Qng2ioU2o2i9np944oiHpPUJmy03/Lgq9IezSO654QryM3/
         /GZg==
X-Forwarded-Encrypted: i=1; AJvYcCVGM/DQhSWTdk9f4k1yv6SVJUGnSec/GCzk7SHwT5ZesiH4cuCrA6vEVsFAU1oPDuGcm/e/gxuTqhGASBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkrHiiPebVBtrYHn+lt3NEgSRuJpm72/PAznHeFAWcJyPCv5B
	Z0KJUHFmj7Tg+TYGxWfCe3j/Y4BQNpbZ89FTdi3dgxjHh/T7uFyvq48xyOrbGVw=
X-Gm-Gg: ASbGncsmR+ZPWr4PPguUO2mwX4DnFXobbIv9MwhXec6tXjK2TCW5kuhgdcaJPudH94m
	qYTDlyoFeVrz+Ps0QnVGadjcNy3Ipoir35EPb6x+k8TXKTK6mImoNyPicVkGcOy0mVFdljkOe5r
	0Z/twQAjZ9JoJvn3CcOUwYRhPWT5VAJ0y/fNjF/TkYgeZdMv+6xZTOsYmkdvDGORGlQEViWMZwX
	rI1LksI1PSJwBtZbpo2JihByz6u26ymCcs6VufT+mL8tTyQskZdp1qfEvCDcw==
X-Google-Smtp-Source: AGHT+IGH+A2zSoGfdDUqRz/MypEtePhXHPxM5OeuowVDk/MmcBalDiqAbeCGLKjxq46/rfGJE7iVHg==
X-Received: by 2002:a05:6000:70e:b0:385:e8e7:d09a with SMTP id ffacd0b85a97d-388c3645ec2mr3607062f8f.2.1734131465615;
        Fri, 13 Dec 2024 15:11:05 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80162ddsm781752f8f.37.2024.12.13.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:11:05 -0800 (PST)
Date: Sat, 14 Dec 2024 00:11:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jakob Riepler <jakob+lkml@paranoidlabs.org>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jakob Riepler <jakob+lkml@chaosfield.at>
Subject: Re: [PATCH v3] leds: pwm-multicolor: Disable PWM when going to
 suspend
Message-ID: <2wirsrr37nwo54k3fqh4xejzjidjclc5jvw6fjl657ytmfquof@ygqsovx23h3p>
References: <d7d930bc-4c82-4272-b2c6-88f7cac5a3e1@chaosfield.at>
 <50bbd767-b0e0-4788-975b-f5d9598208e5@chaosfield.at>
 <20241212174356.GJ7139@google.com>
 <d021d011-d5d4-4692-973a-f5a45be8db94@chaosfield.at>
 <20241213163445.GA2418536@google.com>
 <20241213191039.181169-3-jakob+lkml@paranoidlabs.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yuj22ghi7qkyo5dk"
Content-Disposition: inline
In-Reply-To: <20241213191039.181169-3-jakob+lkml@paranoidlabs.org>


--yuj22ghi7qkyo5dk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] leds: pwm-multicolor: Disable PWM when going to
 suspend
MIME-Version: 1.0

Hello Jakob,

On Fri, Dec 13, 2024 at 08:10:41PM +0100, Jakob Riepler wrote:
> This fixes suspend on platforms like stm32mp1xx, where the PWM consumer
> has to be disabled for the PWM to enter suspend.
> Another positive side effect is that active-low LEDs now properly
> turn off instead of going back to full brightness when they are set to 0.
>=20
> Link: https://lore.kernel.org/all/20240417153846.271751-2-u.kleine-koenig=
@pengutronix.de/
> Signed-off-by: Jakob Riepler <jakob+lkml@chaosfield.at>
> ---
> Changes in v2:
>  - fix wrong line-breaks in patch
> Changes in v3:
>  - use git send-email

Applies fine for me now.

I already gave my Ack for v2, repeating it here to make it easy to pick
up:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Please add this to your v4 if you have to send a new version. I don't
know how picky Lee is, but the email address of the sender doesn't match
the S-o-b line ...

Best regards
Uwe

--yuj22ghi7qkyo5dk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdcvwQACgkQj4D7WH0S
/k6olAf8CcSJDZ5DZNy0nqcPbq6lK27YNAL+oWhoEKMriLGjePuHCy7XQzdXF0xF
Ja+bElF+5/J2zVkBpEjmZDEEQ8peGnUJ+r2RWAhpFLkeaZDLPQiwdKEAt11mLr4R
vwtF2X7L6zJ5DR1NS95DkVtkjXXQ7D95cfQM7c8Ix5bVx2dFncqZc+ZiROx1s44I
u4z00x3NGK7jlC6nBzmimKjxIXK4dSidFQZY9+UdCJqkodWgn7v3yQ7USsD3U7e0
5ryKQjy4uHUwl+k4Pz0kQpjfR1FZrKTaoapwGQaGp5E93AL+6HvIjRIFzIKQJ+rg
qbDgp+SbO6yfQzhaYbhO8oyCfnXR5g==
=zhX3
-----END PGP SIGNATURE-----

--yuj22ghi7qkyo5dk--


Return-Path: <linux-kernel+bounces-324381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B1974BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832461F25A88
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E113D539;
	Wed, 11 Sep 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGKYRqvC"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF713B5B7;
	Wed, 11 Sep 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041126; cv=none; b=OrzWyk5V649xTcn4u1+VUZe/GidGetVy1ddaB6cA846JaGUAYwGvDpxCiNpUnhWScQ/6eTwbIStjQRHuROktkYrH9kXZ9rVuTiPWlQdYy+t97q22ovT1+XaG6ogj888l2+qfM5L9qF6bPOXnZ/e9q6XGceRpG3Ttn2iXeLeffbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041126; c=relaxed/simple;
	bh=c6VlnkuDB7VPlVRoAL7PhSFawFbjpQIlhNJgWMHiP7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5HuaEQA5pN93+nQSNgGnNaZStYcorHwu0WAbEtOIwAHzVLG0f6AsK+l5NjT9omxVkE6cF7BOBd+iAIgtV3+ELdnue5tpEoDPxppy8igqjUn2b/nmsXFe8vJAsqYU+uW+bcBD0uIES2lUltOewqvy1RQFY/dRd9tRDTTcWctGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGKYRqvC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso10940310e87.2;
        Wed, 11 Sep 2024 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726041123; x=1726645923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5mGLOCnwkaWK/oS511bNCFB/e44jaVJMXFEk0X2Af6A=;
        b=GGKYRqvCmcwtGbALjWSzXZ91fQru8TaGjiHJvWIAZpf9x04aAEl8ysh/pYT7N8VA3z
         ueQtRGDP0v+dmZqUFoS8LOoPMfQ6eVNlZDv9nn5FW6vJk7UcYT2pBMt9EEmsUnNIsNw7
         /WQT0B0tVIbqVzFTELwpiUs7f1J1H99CCzRKeS23LKGi1LMMxhDP7oGAJgilORXJMshS
         s68rdBztURC1BiRt5+aajL5Rk2dKP6/uqMjMKZNtj2KYfsgI0oTuwPOIDQUNJiN7FdSX
         JcyWN9hgmAhYbBO6D9JQMOp/y2DsA3+BoMP5QYLnynT/0UbgbhhGxwg+nBEv9d45i+zK
         P6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041123; x=1726645923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mGLOCnwkaWK/oS511bNCFB/e44jaVJMXFEk0X2Af6A=;
        b=CyZkdgcB7LIpI1rl19kS0pDxk2h5WcDWRIAEnELEIzJ/6c9PRH3NOdPIoDsUENx9kr
         VcYxtvvH+gUnK94kBss2w2NlCt8lU0nJgU/NiBuB5qsT+N4BXe38P6mq5xcgwQynGbLp
         +9UdJBena0qA91OgmnKPNiXPVudyTkhTFS3Ytw7lclUFrJoPeNDYFKpVHEByRr1vVTBP
         v+Cm2RogHbZeXA51kZCgsugHPewnbdXQV7UfePgdwJ8Pgdj8M3lm1107ZrqgsZ22+UJE
         N2Ipx9+NVYuMt01ENEejIH4Je2aZrwmKRgJoBn9yTguYen4kMbagCG3SdN5gxLdjVUNw
         Ogqw==
X-Forwarded-Encrypted: i=1; AJvYcCVg6MsxDYcQEdSGR1i6gzmPJ+8GYyYiPNO9srits6EhxO9KyblYDTZmt6RhileSlq+CkLFxy7n23/RIhpuJDG4=@vger.kernel.org, AJvYcCVqQnLMmgOJ7A9a/n16smf72E8uOPtYJ9jgws5PX6u3zU/4pK1zcPdub9HgzsXBV0hM1g0MpnsFZ/JekCK5@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9HOXhu5gtCH4sV1OEu27e9XwGEgqQv5CqYioBski2IMeJ2UW
	dWVv88pEiCaUqtvi100Zs4SMcYdkwnNI42QwgpEFWNkhJRiAS3pQ
X-Google-Smtp-Source: AGHT+IHlK1x/288tPyCeksFi0y4Qjn1N90VOfZFThJn6fo3CV2Yp83nkq4I+hoJMCqadnX13pQosoA==
X-Received: by 2002:a05:6512:114f:b0:536:55cc:963e with SMTP id 2adb3069b0e04-536587f873bmr17003036e87.44.1726041122274;
        Wed, 11 Sep 2024 00:52:02 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ceaf4fsm579313866b.152.2024.09.11.00.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:52:01 -0700 (PDT)
Message-ID: <895c9d2f81023b8fa88209b244209202ce202af5.camel@gmail.com>
Subject: Re: [PATCH] ep93xx: clock: Fix off by one in
 ep93xx_div_recalc_rate()
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Nikita Shubin
	 <nikita.shubin@maquefel.me>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Russell King
	 <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Wed, 11 Sep 2024 09:52:28 +0200
In-Reply-To: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
References: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan!

On Wed, 2024-09-11 at 10:39 +0300, Dan Carpenter wrote:
> The psc->div[] array has psc->num_div elements.=C2=A0 These values come f=
rom
> when we call clk_hw_register_div().=C2=A0 It's adc_divisors and
> ARRAY_SIZE(adc_divisors)) and so on.=C2=A0 So this condition needs to be =
>=3D
> instead of > to prevent an out of bounds read.
>=20
> Fixes: 9645ccc7bd7a ("ep93xx: clock: convert in-place to COMMON_CLK")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0arch/arm/mach-ep93xx/clock.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 85a496ddc619..e9f72a529b50 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -359,7 +359,7 @@ static unsigned long ep93xx_div_recalc_rate(struct cl=
k_hw *hw,
> =C2=A0	u32 val =3D __raw_readl(psc->reg);
> =C2=A0	u8 index =3D (val & psc->mask) >> psc->shift;
> =C2=A0
> -	if (index > psc->num_div)
> +	if (index >=3D psc->num_div)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	return DIV_ROUND_UP_ULL(parent_rate, psc->div[index]);

--=20
Alexander Sverdlin.



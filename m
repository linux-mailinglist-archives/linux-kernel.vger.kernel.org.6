Return-Path: <linux-kernel+bounces-415953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D699D3F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3089B3402C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B31C3F30;
	Wed, 20 Nov 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HFLd6CM8"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7961714CD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114562; cv=none; b=tA7VCB+vKYqd0ZR5Z7uqdoEc+OUEuF2sHj2xzMN5n3yBrJu8/l7jSE1hvm0RKp21BLNV8/nqEZttNg4nLrSjMWNDbstQ9Z2TucX+vgWQvU72hgbPrLcuWLkBzkUgHsT8LF5trilRe0LSESiRB1Z+VtgOYDB5c6n1Y13Gv+wvwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114562; c=relaxed/simple;
	bh=uaSoBwstLKItb7l9YD4I2nlBw2m3+Pe65M7EiLJNE8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlL1c3TXYWi9j9ppplTONXWm/WvthJexOTVdYu9HMWDiHp67cJvOivK6aDaQAmOm1cSOucupXbdP6qJ9QIWIBNaPKbQUCuvVRgpNVMsDGcE6JgOPWoYLbjPUHwA7KoSLfZL+qiYm9nKhs9nX1rDPvPS469pFs/Mx/M09Y9JaNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HFLd6CM8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38232cebb0cso3433681f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732114558; x=1732719358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+kS20KIPkt+Rc15rygB2qFPtg7jDCqE3qlcarAeRx0=;
        b=HFLd6CM8m9ORLFb7ky6hNnN4rY4nrOPljYiOBxF/51fd4wNBi/IlsxowNiju3dAbZo
         a7Nqi6/oklXDSlBPyi9J1KxXp7MN68ee/ykdknfTkbPtYSIjZUGcgii3IGP+Uns75ma9
         pvrAUQR8q0Bv6RFNTnbb/wn2TMK6o2gtlAziMkXVFCRXIH8S7AOh3SM8nK7d3GqOOmV8
         JZWbMwSbP2FQMaQfQZVG/rGHtIqvZMeDLAXGHW7whPkLd06mOP6tJADoBrn814UkMZYR
         1NW1GcLfdtO3tnGvHPC6NMEZ0uU9Z26b8swYSm89Rfa9WbKa9W+LJgK/WV5aqHmhjL/i
         SsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114558; x=1732719358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+kS20KIPkt+Rc15rygB2qFPtg7jDCqE3qlcarAeRx0=;
        b=AkSatA+VFcmVY26jOoU5MnV5iwft+cZhllgzF12y0wJna7vM7wLn9Hz7yIn0wmkIG/
         +loZTz4IdbyXdytAKc0bFhzXijBQxOPUZrwPyrlZTQSvPKkUkWbPD0G6LJeF0J0x24wW
         93YxVDsuLbmAIF2MUYqhTtq2ZGlxJ5sArO4WRWgWmeb2YIPuZtQcblaBxy5UBC8Ou6+R
         3OeF9Fq+p2ey4dUeUCDRHGnmTLCah71l/bYrikh2bmjmIG2aUt+6/9LRHGUzZUHPScYG
         xITBHY3A/Dta8ugxNeaqa4TT0FbB3JtzKsvJBsnZ9VqhsFQp6Xth6z2uCTXfSiep13qS
         bNPw==
X-Forwarded-Encrypted: i=1; AJvYcCX0wmPKf/2c6hINDp4VrDi2SsG74Ef80diUbb20wLfxDy7yEK7sGLsbvocfm5cY4orBm1rfqZfmmxNqKQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6s5VIDnqdPVS6za2xJHq5Jz8Vp60OLfbUY/jJ/4D08GE4g73y
	F2uSC2fYTmy7uHc/lKGV5ZXGCXom9Afj5FCuv7zQgZgYeZkosuRBg089sijbQc0=
X-Google-Smtp-Source: AGHT+IGdTqQ7Tj+uSuxWqtrn8DTscGlxJyUpzYJJDSpLMF9nlb6B1DD47y8yT17rTCzQr1BPDEoQEQ==
X-Received: by 2002:a05:6000:2b09:b0:382:383e:84e2 with SMTP id ffacd0b85a97d-38254b1646cmr1736029f8f.46.1732114558629;
        Wed, 20 Nov 2024 06:55:58 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490bee8sm2280815f8f.23.2024.11.20.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:55:57 -0800 (PST)
Date: Wed, 20 Nov 2024 15:55:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: keith zhao <keith.zhao@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, hjc@rock-chips.com, 
	heiko@sntech.de, andy.yan@rock-chips.com, william.qiu@starfivetech.com, 
	xingyu.wu@starfivetech.com, kernel@esmil.dk, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, p.zabel@pengutronix.de, changhuang.liang@starfivetech.com, 
	jack.zhu@starfivetech.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
Message-ID: <oabm3ahd6vyeirjbbmp74w3tldqkcy3de7u6avio3ohfzfns2t@vfcvn3rl23xm>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-4-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="in6ao6wh7zqwbwgj"
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-4-keith.zhao@starfivetech.com>


--in6ao6wh7zqwbwgj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
MIME-Version: 1.0

Hello,

On Wed, Nov 20, 2024 at 02:18:42PM +0800, keith zhao wrote:
> +struct platform_driver inno_hdmi_driver = {
> +	.probe  = inno_hdmi_rockchip_probe,
> +	.remove_new = inno_hdmi_rockchip_remove,

Please use .remove instead of .remove_new.

Best regards
Uwe

--in6ao6wh7zqwbwgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc9+HoACgkQj4D7WH0S
/k7stAf7BxhOxsMRlloW6PgKRB566VsoPAEPfLvO4bZNctLX5jZZvbCQJpZjG4Ue
ecflnaMcpcXXGpWJA8Jf978PtWGOYJNaW0e1I8Jx+N3PMI7kY0imii3CrZ13N0ko
nD+ldlmC0eh7+uUhrr2mBrdoXc5QZqXuMQK/gttLb6eXQRDkEx7yTVjL6Z0/h0gm
5sPJQNLuMwiskC9KCypm7B08msgfhMtKPWGim91xMREj830dWkOTDXGqZBNLxice
DDstYVuYBN8emYzw1jByQQdcMrn3k5QQ68ArvaYCCqvgMncwWeCmN/I5qnZ8z4ZR
wKtuO/F9Xn+kth1UuxaCEh0LYnCthQ==
=DNtp
-----END PGP SIGNATURE-----

--in6ao6wh7zqwbwgj--


Return-Path: <linux-kernel+bounces-231829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD4919EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BD283E54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCBB200DE;
	Thu, 27 Jun 2024 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jb52/yUF"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60B1CA80
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467411; cv=none; b=plOiMzDJgLN7UxxlZdzVR+5DZdRBKXtkXFZEXXA2fhZ/i6Rj1aiDGsbzBBsrcZsJNBTzB6qlczyPsUp7EqGrxj54pD6fYbsoIHUKfliExSv3IlAywhvceSnFkklP4mn8nQByAXt6mlKOAQh8DXlTumoW8S3yz3coafyljj3lYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467411; c=relaxed/simple;
	bh=5cLIaOfl9qDGf8YuSFVMk0VlEeiMpoxE23Zx+DRPQ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6RtSCi1fRfuVElZDNd5N+H55f9+kpwJdzykzOwmJ7PMdPOP9ZOBSsqWT0tzhIuOqyIF/vZthE7lP3GEAgZ41d89fQ7wluGw+F2ZbMYUVWDe5Cyo1rvBrLylo1X/EAWXqjhwXPS+/6rSMXpxMEtmKMssehlnM5TTGNhUE3ARAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jb52/yUF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so1289591a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719467406; x=1720072206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvKgNFKOYO5t0cqQNQZcn4eu1S8+gS3tvS6/ghdOTQs=;
        b=jb52/yUFkqvlHb/mCyWqIZbxvwR3Pbbb4j87AzWj2RbWYYn3BPIuAj/r8tLYEdr/Fx
         lgAr7uTw+T+DnTLPIyot2WUDdVUFMEVq6CbuJ2v23+L1fD1yRwGaVrjrvXiMgmzTZ+uL
         3zkjVtLH5nDT3oUTvAzMyKgqkCPxnFVM4lW6jp2aWcJqudG2nDeThMZq4QYyXvpf1Qi9
         py4Bxf7werp4FKNnzltQRxsngcxp4EndBYbtIaMp84asuDsDneKQkIG6rV0sHm3UKMvu
         suVNiy5w8WFI8HzfYhUDiiWlQROZdxDphXW82Vt6RA36URgucF6D6p3N3AOo7Qd3Gnb5
         ytEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719467406; x=1720072206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvKgNFKOYO5t0cqQNQZcn4eu1S8+gS3tvS6/ghdOTQs=;
        b=nfPiuyKfeOmiuH2lYeMpyLQjgA3HQdYPzg7lDNzbSGBOB9f/u6buUXgXG0XYcAkn9n
         wl7sm5XMVkN5IM2URq1MGV8E4SDfms+RFbs3H5JYfkV7Aw34sNhGhr2qGtgZJWjwxTc3
         WkgWzOy+C0CPjmIMuDUJkuxRhc86knqdvJK93qa0JtRr/51MTJ+6QN3bPvnn342esi4G
         5pSC6H9cGYVYnHdWMtJkOyUA9RZEO2FZhO6Qq9RVdjBYhjTAccOrrWvvHX01ygKymuRG
         /ENKjfUxJLCDM4RIJxyXaMdH/b9w0yAySY/b17pzXRAiYeoBAq6HY5zXyB06PxgF3y7h
         0Gmg==
X-Forwarded-Encrypted: i=1; AJvYcCXAYWjXqMUJ8e6Sah8hJhWTIqsrm5xnf5/N31Xi5BWY2w8L6j8kQZwoJtrpJJtiqpXudkh13X+SQ1/5vpucb/SVgK+pvZTw4TZ55YJo
X-Gm-Message-State: AOJu0YxPImg9bE8gGlaC2WwAe3b5Fl7pQYAuwYHF6Bu5+fy42ibyJ1KX
	Hta/CLumLMAoiWL6zkrdM26V9Hv3+1U8wmClxWVb+IiAZg/vfRswo2Vcf0vogzw=
X-Google-Smtp-Source: AGHT+IFMSEsF4qzDE6K+kVs2+z+J0EYFtmK9uPOnYvzPhDJB52Fq0giOaVIUIMLWuhsIXvT9ZWwMpw==
X-Received: by 2002:a17:906:d001:b0:a6f:bd27:3f33 with SMTP id a640c23a62f3a-a7245bf675cmr866996866b.45.1719467405915;
        Wed, 26 Jun 2024 22:50:05 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d6fdd7esm25926066b.6.2024.06.26.22.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 22:50:05 -0700 (PDT)
Date: Thu, 27 Jun 2024 07:50:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc: kelvin.zhang@amlogic.com, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Junyi Zhao <junyi.zhao@amlogic.com>, 
	George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v8 2/2] arm64: dts: amlogic: Add Amlogic S4 PWM
Message-ID: <a5ucz5r4eb2z5uzi4zaunpqhym5b6l37qszozhv4igcuduatnp@lzzk4tvil3yd>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-2-b5bd0a768282@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l7tgoew2az5t2art"
Content-Disposition: inline
In-Reply-To: <20240613-s4-pwm-v8-2-b5bd0a768282@amlogic.com>


--l7tgoew2az5t2art
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 13, 2024 at 07:46:36PM +0800, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
>=20
> Add device nodes for PWM_AB, PWM_CD, PWM_EF, PWM_GH and PWM_IJ
> along with GPIO PIN configs of each channel.
>=20
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Reviewed-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 199 ++++++++++++++++++++++++=
++++++
>  1 file changed, 199 insertions(+)

What is the merge plan for this patch? Technically it's independent from
driver support (i.e. patch #1 in this series). The obvious options are:

 - I pick it up together with patch #1 via pwm
 - You pick it up via arm-soc

Can I please get an Ack iff you prefer the first option?

Best regards
Uwe

--l7tgoew2az5t2art
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ8/YgACgkQj4D7WH0S
/k5UDgf/QOPPBNuaLKBJUagn4uUEJPYgeJIRiaOj6rMdtmXP5tdK3Oyn+urWA4qr
um+zStcFoW4Kyvxkp1PUt5cvrIodzeDq+8gxBd/20sX5iL/S0+uBTqk4cv85XOuj
C8YjB5/WKc8v2f5UtRCrfqG0HwC5l+2YDB8i/vyuI17FMWm3RWhzM1mOt/wYzzC7
qW4WnovcWkL3v82ltEFHF4ZCnUVILjVTRKk1obmDPaA2C+0LbkxBqaI+RMDnLAjb
IVPOBIGHWtNJhKG0jiiF8g+UPpzs5HoHpgu6zQURpiN6EPlJ8uPe2MCMHpkxeNVk
JlHGFQvD1W1pejEQFomdPTbasA1qiA==
=DZ5d
-----END PGP SIGNATURE-----

--l7tgoew2az5t2art--


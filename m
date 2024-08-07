Return-Path: <linux-kernel+bounces-277343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A81949F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF325289885
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709A198A1B;
	Wed,  7 Aug 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MzUQsGJS"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC2191F83
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010232; cv=none; b=IARcLxZxpjod+Dzaf+ibwGMgf1/3jJoN+Zncv/g4zF72JmH9pqfxquYxSg06tidvqyKqnThHxw9xIw5t0nW6rgKXzRsknBMzoIbdvEWQXyMbB12/VvAq4+Hp0fLIZ5iwWKHBLuktBY9T9BaQIOyez9st8gt6jvQfRGLCePBsZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010232; c=relaxed/simple;
	bh=+CTqav3ECRQ6Qv/grCk9HiNJ88VCPuTutAqBVMqqfZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADuFNfhlql2922hmf8w/Km7uDxOniqYKhPyPAoicrW5xNqNRVeKPIRFVJ81wEuRFqB/VYKFRGs4pbFblt2jQyM8xbjukH4JWTQ6BVMsTdMwo4vVQSDFgKkaZNLo/KR8rv0xZaPXoMxxjwRrz9iTSi4hbzEHH02BauH3TN0mzrXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MzUQsGJS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so2053297a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723010228; x=1723615028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+CTqav3ECRQ6Qv/grCk9HiNJ88VCPuTutAqBVMqqfZ0=;
        b=MzUQsGJSWzx0+Pt1Bq+GA5kFHzZnePmY/1/qiZOuFQVXTx+iawOdnaeIp4jlEJ5Khh
         P+AFW7TOQO5LClHA+bFtRY5M60QwCS+83HOnBwM+RM8HBk16GkndBuGe62D2nOhGfjqs
         kTQRpmeUlwRkAy3vUaWQFq7HtsaoeaC7cf0m3u/DynisCjB03E9I/tiajAdmf00D+/Ac
         xurI3z12T5ADwJUC9hTmsX2lAAxNaYQzZ2iTysctBH/Hq/j93h7AQJjlij7074MfNQ+Q
         aTUyNCrmqbPEC9OrYiY4RymfvVaWC2XGXgjswJjyn0eGzmKliomBeOv3j2PGNRrQy/5M
         9RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723010228; x=1723615028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CTqav3ECRQ6Qv/grCk9HiNJ88VCPuTutAqBVMqqfZ0=;
        b=PxfnFY9eGYiybldnfHuuUatGqU4t+55DAnW8oPl9uVNXe7og2yw7PnXD8amu8T+JkU
         W9msTcv6A2KCdt3fmirTJlddcF8PvEhadkSEQbzQBzLM676YpUa/YVGtSHUoXip35xok
         NVFunmqR01HGespgaKA8W1FXVNts4SBtQXlMQKyq1o2Yjwktg36CxOt6FFT8kF+jEpyi
         WqSj9FfBU8YhpXaxx66gcc1EhErdMH+eJ9QuxsdFfCmOV0jD00Bje5KplOb1JUB2u2sn
         C9Yvh3DorwSPxFQ4ngS/dBuqR4bIXWiKbC/ZEyKA2FRftJtYumwQyuUgl6zsOK4lNQsR
         hDaA==
X-Gm-Message-State: AOJu0YxjpTZ7Wb0ZOC+/c/uE6UaJEHSNRyux0lZgqk3+uUjwFQETjVi9
	WzYFmwi2bmvaSCYTpkEhKlaUnfGDVWPNPtNY3pxHQ0X7ScCkg6/SMSRkZ0Cx9Bg=
X-Google-Smtp-Source: AGHT+IENOlZnhSKutLCeE/yjJQMqlFjP/HebjcaDoiZTVy7ryBceNiqe2zOAohUPDVm0Pqfi5m6oeA==
X-Received: by 2002:a05:6402:128e:b0:59e:b95d:e744 with SMTP id 4fb4d7f45d1cf-5b7f53147a6mr11667662a12.29.1723010227537;
        Tue, 06 Aug 2024 22:57:07 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba54c32f08sm4830993a12.34.2024.08.06.22.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 22:57:07 -0700 (PDT)
Date: Wed, 7 Aug 2024 07:57:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: William Qiu <william.qiu@starfivetech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v13] pwm: opencores: Add PWM driver support
Message-ID: <jptwjtzpoxzvzkcdicjrye46iy5uretz5oqxh6gu2zinv7ikae@3vpemq2ewywj>
References: <20240702083848.1947449-1-william.qiu@starfivetech.com>
 <hyzutti2cwarxqx32frw5ytui3xib5tus3hb2loekq6s4s3442@wit2usgcci6v>
 <ZQ0PR01MB12539F35A27177E1CCAC43D89FB82@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sob7s4dmxfc4vzd"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB12539F35A27177E1CCAC43D89FB82@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>


--6sob7s4dmxfc4vzd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Wed, Aug 07, 2024 at 03:41:15AM +0000, William Qiu wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > [...]
> > On Tue, Jul 02, 2024 at 04:38:48PM +0800, William Qiu wrote:
> > > + * - The hardware will have a conversion cycle when reconfiguring.
> >=20
> > I don't understand that.
> > .
> For example, after the PWM duty cycle is changed from 50% to 80%,
> it is not a direct change, but there is a conversion period. The waveform
> during the conversion period will vary depending on whether it is high or
> low when reconfigured.

Is it "just" that the new settings become active immediately and so if
you change the relative duty_cycle from 50% to 80% and the current
period is "done" between 50% and 80% you get three instead of one level
change during that period?

If it's that, I'd describe that as: When configuration changes are done,
they get active immediately without resetting the counter. This might
result in one period affected by both old and new settings.

Best regards
Uwe

--6sob7s4dmxfc4vzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmazDK8ACgkQj4D7WH0S
/k61agf9Fvi3wkxH8BC1VMRdOkXdoL2KlnCwTf38cLSt7V6HoJJUonrlZMzySIm4
ynwqcNmjoz2FEqpDe/nsshsRNyrPw8PD3tvpADVgLZ43YYOzotmFBHdDwbPdslpt
Bc3vppFtj/8hljhE/cHUv3IbY0St5TMMdOEPGEMAtmdKX8WE2G/h4lGROmc7oXY7
xG5RErvwOy2B7i/NRQ+XiIrRDPgR3sImmNPnhIy9p9wje1ln4X3L2jM4qtvqHfYA
BPspF94/m7+gLaIxT28nVNP/OC6dXfdOi7QASXp1SnJ8IXfCtU2feZ0foxQia3S7
cwFR8FVEhss+W7GjA/XIq7BjZ8LErg==
=7kCz
-----END PGP SIGNATURE-----

--6sob7s4dmxfc4vzd--


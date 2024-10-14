Return-Path: <linux-kernel+bounces-363440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D9E99C275
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D6B1F23B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351314B965;
	Mon, 14 Oct 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x9gGR+60"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7613AA53
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892963; cv=none; b=c2SCUIEb/dy4xGk8KiBKzzvODz6BnTYUjOM3aYjDd6tveOXgK64LzVPHIohri62IQEv2HIysUO9s1IOlsF9QOa6OQBxnhN3MhY0CIDuySwPO8QtcQY/64CdBeWRxZBkaOFwsbDNROmU0Y+d99WH2t0SnDglMdLMjQcCaUerPwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892963; c=relaxed/simple;
	bh=4RlZOlgSupAxgWagLLro/53S7NCRTENxGSsZn/UbRdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJptux8gGNegn9/bI+7jp4m+cBiL8yZN3v6d4KB/tfyK5E3DNkGNNY9FxXDKZ8sad6B0mNxDYot7568z67Kj2SudDTWckDadyehLPpVXT2S2CtsEbnOHIz8BT3YB9Vq3hcRci/7ki+TY8ufFAttMGfs0jERBJ8IRRFRPEZcpeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x9gGR+60; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d5689eea8so1608889f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728892960; x=1729497760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RlZOlgSupAxgWagLLro/53S7NCRTENxGSsZn/UbRdU=;
        b=x9gGR+60wvZ0qvORTFqLbGAuzN6S8gV1lxEAC4RKEBoMyxHIoOaj4QsmCkHzd55Rc8
         DWZlqJatAQKUfek39+uEEj/e7LSG6y2RImsjhSXE1PVGfU4tfAEUazfrPHXzXy2Zhtw/
         RWlog6JyJCqfmbwkyd8MdNhybTXTQXUylD6i0WYRYfakR/HU7/98LTvdLaEYT4+aemTo
         ft8+FtvlOaXsNEmRSUEBLUVPGNKzNa2Sl/zKfFCqp05ROgNeqDH17I6WZ+R4evuj32ry
         P4GhhgILIDg1e9G6tKLtCaHFl644ngITrGkLKslQ1puYXoGThT6hWh8XsAVkmZ1SulXX
         nqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892960; x=1729497760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RlZOlgSupAxgWagLLro/53S7NCRTENxGSsZn/UbRdU=;
        b=A1AUUIAGlwTvFMgTFs5JckyJ0YPR6KTIi1hmBfHetrn8pz/XRHD6/YpmAtcJHxtoMl
         Cfd0bjXbbz8xMdmrjPPjkybuslAh02MVpCfFwFisQ3IAYfNGC3hqn3nVls1AVoUnNhbQ
         84CH4P+hZbbUqzNaOgcRifIOjGuPGNut9zb8rEs88rSRvsOV1Kr2Qkl+UzbMwfEL6u8s
         3U8LNaQ4I15SsxA8M4cu09mcye64nhlFJf8PVJIwwg4tGn179X7UAe/SDOOw2NjUgw5J
         9ZNmaVX3Oxn3CDsBrxZp4qgzGkLcToDiXonEtBVmz8WV8WIlL6obob5jbCgOY/IxgfSZ
         FGhg==
X-Forwarded-Encrypted: i=1; AJvYcCUjXy7r83b8XjrOhkw8Sh4LrxSY9hQfzgvRblWXVuMgblkSzbRXQcYMUm2o9rCioyLk3cQtSBdRUG1+Y80=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4Ud/bMT4RDplO3s/JJBRPUYSIPzgGmW7ioKsDjdT8e/f9WYL
	pHxsvnlYrab4D9U9lbkaUbE1q/kX5q8gW9nOOyPKw+tIQMwjJbH3WvjbAEs8Y7Q=
X-Google-Smtp-Source: AGHT+IGHI1oWFXV9DcSfHKsT0K9KY6FX9DQ9bVpIzkaaGAOafugiZ3ojqGus5aCjg1CPitlaHNm9Qg==
X-Received: by 2002:a5d:688b:0:b0:37d:462a:9bc6 with SMTP id ffacd0b85a97d-37d552fd82dmr7764949f8f.36.1728892959854;
        Mon, 14 Oct 2024 01:02:39 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm10751841f8f.70.2024.10.14.01.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:02:39 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:02:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <zlgxam2ph67gbxaf64tznc6gaediik5vzfus3kgbanu6ke4vxs@6emuicykaike>
References: <20241008030341.329241-1-lanzano.alex@gmail.com>
 <20241008030341.329241-3-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nfdjdy6igf2fhtdw"
Content-Disposition: inline
In-Reply-To: <20241008030341.329241-3-lanzano.alex@gmail.com>


--nfdjdy6igf2fhtdw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 2/2] drm/tiny: Add driver for Sharp Memory LCD
MIME-Version: 1.0

Hello,

On Mon, Oct 07, 2024 at 11:03:11PM -0400, Alex Lanzano wrote:
> Add support for the monochrome Sharp Memory LCDs.
>=20
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The pwm bits look ok now.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--nfdjdy6igf2fhtdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcM0BsACgkQj4D7WH0S
/k5wWQf9FfmMItjVRgRZH9tOPUX8zANyqph7Rsnz7icv4muLFmBRJDz3p4s02Ifw
vnjzp3F3ONPAom9POqZn5akcxHl+98+LD9D/fX4eKwdQVxYZsPlFi72VcoQ1Bree
tIfmZxTDoP0HWpqDB4zDyVbvRlnYgtPHteFddN4vCa81Ua0K5zOqgl1lqTyen/FX
XfhKS3GGBml9wTgjQ31Us0EXkQaELjXwURwCRobwCRiEm5j5bJ5o7juVymoKwLSc
c07MB/X1DR7G0Z2CegTx88SCcpBq/wd68vzn5bn8fbf+JoMvJ3YGp1j9pdjyJpQK
RRVObhQN7P7/nIVqvo8XhmUk3Rf2Yg==
=IozP
-----END PGP SIGNATURE-----

--nfdjdy6igf2fhtdw--


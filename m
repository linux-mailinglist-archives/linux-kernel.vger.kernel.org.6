Return-Path: <linux-kernel+bounces-380406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9F9AEDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74931C230EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70A1FF60D;
	Thu, 24 Oct 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jl6zQTjb"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B01FF7AB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790794; cv=none; b=Ozqgo55ty7wuCXkXNurMpMv5fnv2T6nvzI6/I9mdUJHPXxotiQnObhFSWRIN+qDvosoUifGT47GeRkYIPXzwEtC+oqwCOdXok1CCdkelKbOMgw6YU4/c2j+lzj8nQxvwbc9F99EF5SP8twXJvT3XnJTLvVtF0FgU1EJHW64RJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790794; c=relaxed/simple;
	bh=RwEePPnICKDq/hGzPzFY9TDugPuK4+JiAhBYXPj1EVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBQhWj/XmZhRr0u84Jyew7S5/E2/gfQkIVogI868ZykIAXP0jxsMiwCLpMW++upB8/yKo72/IgBOqh+F2oRrdsMSPFmAtW7x4Za5gMXrLplAqX/mVUMbqe5UD8K1byJhWQ3ZUxhjn9AKpfRkbUgAjgZR1LgcEXdRQvfaGiKvXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jl6zQTjb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1023371f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729790789; x=1730395589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=df4TNSGzSNKm0QFOAhtHpnlWhy9nagHU1mwVeiJhueE=;
        b=Jl6zQTjbWhos+uZl0SNToDY2DbXryHaTbqEOb3AL7nrCFsjdOe59trDBeDKHI8Qdmr
         aPMzHyedJjgpwEzBuIjg8ECxivhTWMIOSwIq1eYJVH3AaT3+YvvfdZs4BihLfz96e+nN
         PSkZCCndK3vg//jNHnNpnotGwnJgCAOrIpnqnbw0Sw3/2Cngtn5bTnibHlMjvtXMLxcI
         sN7NQWXFA7/lwQ3bwAU8Wh5JcbBK/hifKlQfJrpqfv57NMYSJ4zXYErKqXo4jMXWQl/v
         kZafLVWk6++cwEMtv3mUlgaZL3dGoJ72jYkzFv5Vi61KeuecN7srE/fd0fFKQvmjZCPq
         ByxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790789; x=1730395589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df4TNSGzSNKm0QFOAhtHpnlWhy9nagHU1mwVeiJhueE=;
        b=C8MdqF3Uzz9/e7tLyI3+wKtyTKS7xBTuy3DCHKMUPuhT29mWSlQdJVnBc67IT/CGAU
         XBQiA7H3pxXYrl8TTHyXqOUX+XofqA2veTdbTRFNcYm+6g5/wnmswwWc0+AG2vXqIAHP
         2S2jbdlk/SEsIkhr9PCU3erR7TKJgsE2UPFmWAAR7ka7OS0gOvdyzR0OdkkrUg6tX4q8
         yO3b8hiZpP2yzeekYnj4v8qC+DOB/n+Zre/SV4qTassEoDDnE0pIIQYAidXrWq4iXb2o
         AmWVH5hEg49kcas9sYG2sgp6BTkQ58MdY+KmSgACMa+yPwxezz6ojm+JfPUiuZ6MzgoM
         /RVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAVxoZFjDdzudgd8+BEjUJbXEtbUhd5seCrMzgJwAL+HqSRZsIcLLRWvkAv3Soa57pvQ3n1hBfe0LZ7zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7y4G3DDz9UFaacB7ynWk0lkecZ/eailMfmBu4xHKXY/W9Y9A
	xImkkyCXMxj7zme71pH3K/G9SLv3UFX6Tsl8gntEscPItC2LYpP3eQQ1S7H8N1E=
X-Google-Smtp-Source: AGHT+IERuGJIotkBPQnG/sDjxSCMdboz8SG9EaUnlFwZt5gyjZXzk4XrIIAOtG10KxDOLzg+kXRQFQ==
X-Received: by 2002:a5d:4cc3:0:b0:37d:46fa:d1d7 with SMTP id ffacd0b85a97d-37efcf91b9emr6075835f8f.57.1729790789509;
        Thu, 24 Oct 2024 10:26:29 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb15sm11814624f8f.99.2024.10.24.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:26:29 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:26:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>, 
	Michael Trimarchi <michael@amarulasolutions.com>, linux-pm@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Sascha Hauer <s.hauer@pengutronix.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: gpcv2: replace dev_err() with
 dev_err_probe()
Message-ID: <4vws5lnu4efupunha74pdlgtd754w6n2loymgywrxhwm2rqic2@gz4efozdrpqm>
References: <20241024103540.3482216-1-dario.binacchi@amarulasolutions.com>
 <20241024110123.wix35njjbh3nx7kn@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ow3mz7ffba4wu6es"
Content-Disposition: inline
In-Reply-To: <20241024110123.wix35njjbh3nx7kn@pengutronix.de>


--ow3mz7ffba4wu6es
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pmdomain: imx: gpcv2: replace dev_err() with
 dev_err_probe()
MIME-Version: 1.0

Hallo Marco,

On Thu, Oct 24, 2024 at 01:01:23PM +0200, Marco Felsch wrote:
> On 24-10-24, Dario Binacchi wrote:
> > The patch standardizes the probe() code by replacing the two occurrences
> > of dev_err() with dev_err_probe(). Indeed, dev_err_probe() was used in =
all
> > other error paths of the probe() function.
>=20
> I assume that this paths aren't using dev_err_probe because these paths
> can't return EPROBE_DEFER and therefore dev_err_probe() would use
> dev_err() anyway.

Note that dev_err_probe() has advantages even if the error code isn't
EPROBE_DEFER. In this case it's mentioning the error code.

See also commits
	7065f92255bb ("driver core: Clarify that dev_err_probe() is OK even w/out =
-EPROBE_DEFER")
	532888a59505 ("driver core: Better advertise dev_err_probe()")

Best regards
Uwe


--ow3mz7ffba4wu6es
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcag0EACgkQj4D7WH0S
/k7z5wf8CJItP63PC6N/D5K9sQTx0ydliUNv7dA1lUSVuiADSLncCZVZu3zmSuiZ
6Ta9uxNeZuOyJSAtq5mXX70s8vNrRycm/rYxPoZNvvB62ZHQOyweWF0f0Ce1AwGn
keWSqZ3/B9mNSgtSqmyEi3HHcx61NbjjO230wOBvNKfUElyL4ozrgbzFv2qbLZYF
Nt5xFEoEQiw0riAk7lgyOazrA/6D5ZyJ60YZ5AdifNXgDLfU5OkRmpVh4/eOGKD0
x/Rn15dujV72q8n+ZyXqyifZUbnGVTXYWnNzNwqwcPT/y2ESWjPMC6uyeUwiEMuo
xHEVQMNz7SHRR8PmDEwbI/fmJdDOjg==
=kHdL
-----END PGP SIGNATURE-----

--ow3mz7ffba4wu6es--


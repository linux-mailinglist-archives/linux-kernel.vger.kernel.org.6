Return-Path: <linux-kernel+bounces-257037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388D937453
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4D51F22BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E653363;
	Fri, 19 Jul 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CKwA7xE7"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DA47A66
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373648; cv=none; b=YmNJAgGdafCja704w79rxKSK625/Hkv2us+UgTOB8+5JyX24ntpz+sAVoE8EhIgo/fXue+53RV/q1iOj4m6wYWeO0VJwegtAfpuzRiSrmQQM84htYe2ajVclBj/HnpPSaN9u9yhvW1YYbC8/0h+ZfZkaW5YNNB2lWNITmcmQT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373648; c=relaxed/simple;
	bh=snCOMfSAIZ7BN7SEbXap79VN++oHgdcE3AI+lBWfejI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At863lWLCrh7a1UqRd1n2cXI+BcGurMPTwYdwDecwzxtu0ORo5t27Iv31o61087EbXsRVwpm6qJHFO+LfzTOyL1ICUrjlOGMPAKutYLunemHsDU+c5734ZKY7boqcSa2B23MhpkzEDaMA5PoAyvAr7BGAhAGpWILxO6lC+GPaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CKwA7xE7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf989so228708a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721373644; x=1721978444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snCOMfSAIZ7BN7SEbXap79VN++oHgdcE3AI+lBWfejI=;
        b=CKwA7xE7/Ff/gcwjddW+QvFZ38IRkEJiatecI+IzqMYs0f3/b7sLIxH6TWvuEiX0mS
         Ytr5+0OM8CEW6WOBz/oUyU6nFm/i3cR/MtiFmj/TQQvmUPHgdusADDIzJKMbuDHd6Ute
         XRdNosgpmvYeVqyZM2g+67KjHukPvy6EU/wGlYoo8JNaXIEsZkBhAs7FVq7LYmx0akTx
         2e50+c/MMSIjeAm47Babd1Qzw3Sr94aBqfF0XZkipI/U1iGT8PIO6E+vbw1nTY1FN6j+
         723YvUPeyPseHkUQZ5SIdTki+czF5jkeLfg0CozCs3CcbTUgze78iSFN9mtWHAXRHso3
         90cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721373644; x=1721978444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snCOMfSAIZ7BN7SEbXap79VN++oHgdcE3AI+lBWfejI=;
        b=mxfXVGzXH2aYyzdqYu4ujF7dg9p3MAXkAQlrC0hVrDwtJGw/YLrX8bQ7HyOgixmZ0d
         DQRTbZWV25FgdtTnbKCQoQ57zJxKt/DFme9xIwPrguOLTCD17MQdQuh7J2FhRG+Hh0mM
         vLt0X+7ppTAz/h031skoFx08kbqlgnQw6/R7DgJbj9ToIB9fR6ZzIqeF6ohzpeEA994z
         fptE5scFyXEbR2lWirSumPvyJfMcv/tT1PKsxUNFL8ammHVwNzEyuwbnEjvYRX/X9lec
         2K3nJDdjm8o8UMvL+GdZTK5o/kY4PmOd/njaIchUVHsGUgvs/eMn6nOeX4MnP8jeyBrM
         KU7g==
X-Forwarded-Encrypted: i=1; AJvYcCUzFCyyDDmzUmkl7ghz4qUvZhAFZSZRK9B8Bk0uzlKcCsMzh68gSztxPHk6Lq5rlOigHfPyhCAPXT0/fDUeTU8hEpmZbAHYqfpi7BHU
X-Gm-Message-State: AOJu0YzPkSyV4iki9FrFWxubJHcODguKmXywG72PYNQ2Kopf53Jz08cn
	OsW792WqSjG5z36EKttguU+hDNZcQj7qiiGvLzPSUOxpkDOcb8fDEY614vCcaWU=
X-Google-Smtp-Source: AGHT+IHSnMJiPqKXQFc7TqXz25zzG8NVyoXNnDQ32Bkv6V9d4Cr9qVr7e/wI2y2FwvE11QdoZJJXTA==
X-Received: by 2002:a50:d682:0:b0:57d:46f4:7df5 with SMTP id 4fb4d7f45d1cf-5a05bfaa613mr3897320a12.23.1721373644032;
        Fri, 19 Jul 2024 00:20:44 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d30a0sm669323a12.83.2024.07.19.00.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:20:43 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:20:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	martin.blumenstingl@googlemail.com, jbrunet@baylibre.com, khilman@baylibre.com, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@salutedevices.com, hkallweit1@gmail.com
Subject: Re: [PATCH v4 0/3] pwm: meson: add pwm support for A1
Message-ID: <bp3hbxl6zs6lwomfdj6edhq35pde3gr5i2qizgdf2varke2eai@weeodo6gacd7>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <52e2e211-a0b7-47b1-a451-34c304028097@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a4mrqcrkf7uvtgvq"
Content-Disposition: inline
In-Reply-To: <52e2e211-a0b7-47b1-a451-34c304028097@salutedevices.com>


--a4mrqcrkf7uvtgvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello George,

On Thu, Jul 18, 2024 at 04:09:04PM +0300, George Stark wrote:
> Excuse me, should I fix/improve anything on this series?

The known issue with this series is just that it's one of several patch
series that I didn't come around to review yet. I tackle them one at a
time, usually in a FIFO order as listed on
https://patchwork.ozlabs.org/project/linux-pwm/list/ .

Best regards
Uwe

--a4mrqcrkf7uvtgvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaaE8cACgkQj4D7WH0S
/k6nDgf8D5F2Na4nH6HLwiqFon8plnLTpbHNktSH8KoKVdGii8LxI9VwSaFm625x
7TRIUvuD6Ss2nW8Wyy5XN+Jj7GjFT4l2A6YOTtbPYqpnAKryKUPmu5QPFLE/UrH6
HqoABIBLJsFFFFLHN8DSJm6EwHOLyfqmhtYt3ReQLYvu9flXIht4E+JCUnZSrxRM
dw1WSK1yJBMhDcnIMcFZ48C+ymj4t3bzImEt8mjoExdlFC/sUzsZr2853Dme9QJk
Gqi3tjsgTHFBMq1CpjXdJNBTnQaqRECKVvrEntWW66s8ocdF4Q5Ib3M8TeOY2WLg
EpCoY/o9x4O2xTSQ0Y0C7kRbNln1rw==
=tWvy
-----END PGP SIGNATURE-----

--a4mrqcrkf7uvtgvq--


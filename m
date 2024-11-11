Return-Path: <linux-kernel+bounces-404108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892689C3F28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400CD1F22FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81341A00C9;
	Mon, 11 Nov 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BtUA+HfU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7319EEC2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330215; cv=none; b=tUz7HD666T+hV+xTBinl7TyRot7/N1r6pHXCTdDTN19TLspT8KmxI89V7TA+2SVkaZp3e1lHv0ZfhN26yD49b6BiwR21chA+L+agsovSqN2f0C9agRLnbhwW1l+wbaRZO9jiuLDhEAJMdN1jSdmMPrAPkFnPoAS1AmpzvsCxFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330215; c=relaxed/simple;
	bh=QesLfw5yz3gwImLjGufNZrQ3Nl23sW1F8Hxkq+woFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dffegnKdDJxYQydTK6s2Srar4RxrP38f6YYYFKx9Jj5kEIDsM14PB/TTt24JbSNF0RNcG8rUWnjzsntcS2ameUPcKNcyWemTsGsPFdBQv6OpOIMyQc1tqqsy45xpmCyjn60ZwSwXIVu+jNA/KMJMOhA1NU9P6f4KTYR0XEVYlBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BtUA+HfU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c452180so30734135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731330210; x=1731935010; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZR+w9YgNzvkrcmO4U+KNr6q/SGylZDfUPhJ6mLTdPM=;
        b=BtUA+HfUzfF8QOIj1HVa9xjBigoWWwA0jeLD2otrX2AaUCFputIjopIWmN3b7Kqb83
         qOIloW10pvFQBvjQTR6plU5pxQw4Z2/LMScdmiGPxA2l6ppSHmQOfZul9dKiiJnuPI0b
         CLsoldKYLUs+GA7nnjrqaepOf+MB0JL9OSVHJQX+fXCfWWsczTaaWIg5ixeGWRAN9bWG
         JDRkfCweg6mO7yjrLMreGFdTjOw8Vugb9vtQEUrZbfgte9DqAI6dRhl65qlYdVFmou24
         v3+P99HpGw5r8uPIUzqSgD6ELVX5HD+ukVtgvJ3XTgm3d1w+cxEtjs7xortCe+LScgjv
         /h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731330210; x=1731935010;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZR+w9YgNzvkrcmO4U+KNr6q/SGylZDfUPhJ6mLTdPM=;
        b=bWvGCqwpt7VDJwVbjljEwkbLmAeDKP7k1u/eXHjngGQq7vbJRYZpSdeY3YM2Ht6WfB
         fnMtw2Ji26io1/s1qKww0SmKagl5CJyoP9cX2OzunWM7cSsJ0n8CqNDbG9ZLPGf82Fgd
         vCZbdgAke7e+KOaDGp0zq6h6hjlfG+5cdBJDNpQNAusIRBsK/KYk6F9QU0RO46rJ/uhR
         2mSe0nxeky2cK1Ah6+QJ2Z0pQzYbmU8ojwOdPKR8eHZBykTQXRfgc51LxSlWVzqSy6vl
         chmDJRhxUHkqMyQX+sZnKjMtnfBFYdCeS+GEsHB3H5tcuaa4MhuFcf/JBBo24z1XJO/C
         sf1g==
X-Gm-Message-State: AOJu0YzEKZmXG5Y0kXOPZ24aSgnGLoilW8Ps+vZnPwaPQLmdd/CV7+Wy
	uDM1sCmf2ihPcIq6ujV9cXS+WioSGZudi13Es8RR9tw58Ax1AMTcpliDjCD2h3s=
X-Google-Smtp-Source: AGHT+IGCx1a5F68PtuWR0SPfVh6zELjgKrdI16zXyZzd827uIMuH7qpnJlrB3kza0Jw+vCAtY2K63A==
X-Received: by 2002:a5d:6d83:0:b0:37e:eee5:80dc with SMTP id ffacd0b85a97d-381f1c8c7demr10738175f8f.28.1731330210522;
        Mon, 11 Nov 2024 05:03:30 -0800 (PST)
Received: from localhost (p200300f65f28bb0063ffae39110fa2df.dip0.t-ipconnect.de. [2003:f6:5f28:bb00:63ff:ae39:110f:a2df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04049sm12711924f8f.93.2024.11.11.05.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 05:03:30 -0800 (PST)
Date: Mon, 11 Nov 2024 14:03:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Subject: can/should a disabled irq become pending?
Message-ID: <io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ggajz4a66cwgiing"
Content-Disposition: inline


--ggajz4a66cwgiing
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: can/should a disabled irq become pending?
MIME-Version: 1.0

Hello Thomas,

[This mail is about an issue identified in a thread on the linux-iio
mailing list, but I guess you missed that because the Subject isn't
"interesting". See
https://lore.kernel.org/linux-iio/20241030204429.70cdcf35@jic23-huawei.
So here comes a dedicated mail about only this topic in the hope it
attracts your attention.]

The ad7124 ADC and a few cousins of it have the peculiarity to report
their interrupt on the SPI MISO line. So while the SPI clock is toggling
it behaves as MISO and after a transfer it's a falling edge irq signal.

So the driver masks the irq during SPI transfers (using irq_disable()).
It also uses irq_set_status_flags(sigma_delta->irq_line,
IRQ_DISABLE_UNLAZY);

Now on some irq controllers (e.g. the rpi GPIO controller) the detection
logic is off between calls to irq_disable() and irq_enable() and so on
that platform calling irq_enable() makes the irq handler called only on
a real irq, while for other irq controllers (e.g. the Altera GPIO
controller) the SPI transfers make the irq pending and irq_enable()
results in a call of the handler immediately (but very likely before the
device actually asserted the interrupt).

I think (but please correct me) that the latter behaviour has to be
expected and the former is even broken as it might miss irq events.

My conclusions from this are:

 - the ad7124 driver needs some additional logic to check the actual
   line state in the irq handler to differentiate between "real" irqs
   and spurious ones triggered by SPI transfers[1];

 - the rpi GPIO controller should be fixed not to honor
   IRQ_DISABLE_UNLAZY.

Can you confirm these?

Best regards
Uwe

[1] it can only check the level, not a passed edge, but that seems to
    work in practise

--ggajz4a66cwgiing
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcyAJ0ACgkQj4D7WH0S
/k7dKQf+MpGHieMRgXVMK6xzip6cZ26ZQfjq8O6G02O4/JNueKjUQHF/Eve5iXNE
xb9PrUJX1ihSNdwqz1HSQDNaUkzcwP7jeWBz62j8tBcBA1NTLbBECFP8W4tBqu0W
Jbe/bSB0nDHxq910ISUq3PrX7yz626jMmfzPdV9TQwRGttyjp5j7dIwW+UBHmhsV
CUfWapAZOc/6QdnOD8XzBs2SzRYjO3uLouYeEpzsVjc+WAxH8rwjl4fPagF6Arb2
psY4X0/EV+8zaHIvM+LboWrdFiLPaThYteZ7yNrj5zrGA5uOMgP66NGe6FDjZ8RH
3HEcxfwhgtFjZP1OPI4niyBZ/SKSHw==
=1TQH
-----END PGP SIGNATURE-----

--ggajz4a66cwgiing--


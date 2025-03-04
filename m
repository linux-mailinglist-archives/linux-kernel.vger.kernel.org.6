Return-Path: <linux-kernel+bounces-543718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F66A4D91A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C9B3B332E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E241FCCEF;
	Tue,  4 Mar 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FqvoAhVc"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E61FC0F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081275; cv=none; b=uTMOxmaD8BUDcTEEtQ/SrRd/Wg8dJ+9plzvBsfhrgVYbJdPJKEzTifxBWkCmWbHXpLbC0JVu0HFBUMDdBOO7a9Te67Ci3n7pPJ4GucMXLDjSey+nKCaF6t5SK8ar040HZOA9ZxDBwGOr/xd+X4T9ss1EMjmVvymSFvwMqqCmmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081275; c=relaxed/simple;
	bh=nwyCKQdMrLkk+hwFKBqOmfLMqKfPRDza4Y0hwo11iH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uCp0qoMfxhl5iTN5jOVbQtokqZcoBlmwevc3QYFIOXIJ8zXMwJuRl1ukX0nCEr4r0nKyn8kqHT2wsG/X/QERj6uKUVK2Z3Gus6AUy/C/kD50ebqwVeUqT4GAPWkjCs48BQWnsrhpiSuvJuvXQLnKv/sHsIzLGuyPs2MHQodQBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FqvoAhVc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3910f525165so1365987f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741081272; x=1741686072; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOeNuG/9V7OtIUbnDXNxWqbMiKr3cZjrOUL8hLBFxYI=;
        b=FqvoAhVcKMQLboEJNNqCPPOg2HBThMDQr05+l4CiWH/XAzEO1NOWsGJ3VjRbU62kvN
         HR4nN1NOQQtec+Qc9DPbj+6nHwi0LEvPibq5tkqe27U7fz2/MOLAkd4UGlvEfizUj/uf
         LIY91h1i5FDFA9vqpuP4k99X904Cam/ww6AnSsi5wjwfo8zADYMntY9DyS3YoDbAwmR6
         UvI1xiX5tVsXGCI933hRZwV4jEZ1q6RWoSdGAv+TePVan27D61eRVvznk7pmKNX3/sKS
         ZIuK6v48o30yLraarbI5eTcaqwNM38KO//3m177ITq42SlyPf9hZSnKmSbalBpDNm9sd
         fhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081272; x=1741686072;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOeNuG/9V7OtIUbnDXNxWqbMiKr3cZjrOUL8hLBFxYI=;
        b=FaQ6g64FvbYX9gZJDTA7Q3xjniV4dZkwAxbxV/ErxEhkUjNj5tQQP9HaxciWmQg7yv
         RIVVU+G7VDHH3lKeE7hAlgyuj8La1OTTGUWOs4BHDtWh/q5KFX976o4JKaun2sEKesLX
         r+1Ayuf85vlmDdRBm0Zl8QLKQQXF7N9ujDU8cDjXwd0S2IwZazfnaK4SrS35uoLTPkkD
         0p1wKLHmM4j4m4/PEBu/a0D9gD7TyKeE63aWB7pwRkxHagTejSPfUeomTYIjx/SaYiWA
         YU9NRxnB3PulGrIR3M6YG4S9Yodn+hw6i8CLDdwAn8P/V6XvEYvM/aCPLBrvE6bjerkd
         gohA==
X-Forwarded-Encrypted: i=1; AJvYcCW14WtQrunqXn0PMiIrU/euJtEyVXXiu/nGSry4kh9FWqZpV4EUAm++JAmUucTyHpX178X46gO/Episy1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytjv59fq7Le6E4x/3ACs7dG1Ffp8n04YtYJ8d81/TNBjoytlqe
	/AeFqOfMDSMooTy8nSRB3jI5cVwI7VTGH6/UnXKuro2awgdjmINiTIiP1V0ROGU=
X-Gm-Gg: ASbGncs8XZ00AbkAgSCCF6kWx/QSOfVx8fo3MLz5FgwsR5WpBSnL5qMkPEEclRNiuL5
	SNQoauAE5ihe4JojstFsY6vxk3xZGTVHnpQeNN2F7ITG7nll6iBTC8+zhjDMjHJuu7QfUXAyj9f
	qdXusHyocNxE3gnVz77KG1a4LuxJfHMb1gIIoZoKlJ29Q7W0Wz1GCXi3Cc8mCyCL2uuQSj9f4Pf
	WIRmWAufXLLvyys+Pw5WZthnKDns25KOWWgnl+xWmhIRs0yt0310vFMukMcVfwjQnjGoG0PKSzg
	PW3P0a19AH4LHLvbKCy+XZtiFRV9dp+bmA3TO0TEbjGr8IRIbTQccdHbXP5d0PncT+pLfvQ399w
	jeeAM+8isSun5CaJl/jj5ER+uVQ==
X-Google-Smtp-Source: AGHT+IGFnQX2sFmUtOYFM0io9hYT+oT5YhFWI6qoY1p/yE8VNp0PWzdCQWk407r6hkkRtcrJPB1fgA==
X-Received: by 2002:a5d:5f91:0:b0:38f:3c8a:4bf4 with SMTP id ffacd0b85a97d-390ec7cd27fmr12961232f8f.6.1741081271694;
        Tue, 04 Mar 2025 01:41:11 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc57529fasm52820145e9.31.2025.03.04.01.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:41:11 -0800 (PST)
Date: Tue, 4 Mar 2025 10:41:09 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/8] iio: adc: ad7124: Benefit of dev =
 indio_dev->dev.parent in ad7124_parse_channel_config()
Message-ID: <v7l2skqj65vbku3ebjsfndfj3atl6iqpodamios2do6q6kcagf@whmuir6fwede>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3f4tqhttaeccypl3"
Content-Disposition: inline


--3f4tqhttaeccypl3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH v4 9/8] iio: adc: ad7124: Benefit of dev =
 indio_dev->dev.parent in ad7124_parse_channel_config()
MIME-Version: 1.0

Since commit a6eaf02b8274 ("iio: adc: ad7124: Switch from of specific to
fwnode based property handling") the function
ad7124_parse_channel_config() has a parameter `dev` that holds
the value `indio_dev->dev.parent`. Make use of that to shorten two code
lines.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
---
Hello,

this is a patch opportunity I noticed while backporting my original
series to an older kernel to please my customer.
I chose to sneak it into the series in the hope to not offend maintainer
tools :-)

Best regards
Uwe

 drivers/iio/adc/ad7124.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5ab0d3e48c43..53b274ca42ac 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1061,12 +1061,12 @@ static int ad7124_parse_channel_config(struct iio_d=
ev *indio_dev,
 	/* Add one for temperature */
 	st->num_channels =3D min(num_channels + 1, AD7124_MAX_CHANNELS);
=20
-	chan =3D devm_kcalloc(indio_dev->dev.parent, st->num_channels,
+	chan =3D devm_kcalloc(dev, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
 	if (!chan)
 		return -ENOMEM;
=20
-	channels =3D devm_kcalloc(indio_dev->dev.parent, st->num_channels, sizeof=
(*channels),
+	channels =3D devm_kcalloc(dev, st->num_channels, sizeof(*channels),
 				GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
--=20
2.47.1


--3f4tqhttaeccypl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfGyrIACgkQj4D7WH0S
/k4Jogf/d6BMedMkf2/ylqy7gCSJDGttpV4tfEEUs2kgitDv4XRh0Dz/rZcB7Yz7
Rp6FlF36wqAfrfR2nMOpHANRwXc96dwZWOWnq8AIk8oIzyyvNQv7RPSoOeVOQZTW
xAmmVGxhW/DCJrEAafCL8JkKC4COWMQeXE+gv1o1DAendlvQo0Pz26m8jijN7HyL
hPBu4e0W4OmpWgyVCcTQP/qOL0KcthScu3Y3PtxG9nFUKagImu516nlqqxr5ilft
alS6lTDnMAx6ctB3fXTwi6BlYtMp5SZGbNUg6HXv8lDJuF9B8MjrwEPs+LVu9ni6
yNZJTIndb4YlJYVtEm3kaoJi2MCKyg==
=X19n
-----END PGP SIGNATURE-----

--3f4tqhttaeccypl3--


Return-Path: <linux-kernel+bounces-387010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829629B4AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C7B1C22631
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A720604E;
	Tue, 29 Oct 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt54a8Hs"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB72022D6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207824; cv=none; b=ZSsHS0twUktDSs+Cs5ye8fUzgW8vmICZrwk8cSEyQRym2zyit112cOlxOWet1FYD3QjZWTXzmtx2X8gQHWn4OP53DYcL00CYo6t0rKk18g90Hs3n+N10ruImHv49kJI3aJdRumR3fi9nRcBeZHAqsWozbfXwIGKvgiLkuahsjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207824; c=relaxed/simple;
	bh=Igr6Y9NoOozr7A6vfLAvLj7D+4JfMH8CbjC5cG7UCsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1RcAcSO0H3N9FgxwuS8TbP5kXkjraznWQx/tXvklRFXm+YmUltj5pgn9qvbKgvjFo8bOt5rkUULgFORtp0usq3Y7k+vEh+4vliMYCJt3rcK/xlK6uP+1ck/bMB0RFrpsadVvl3T6KcgGqbsbztKdTDy0ssyrcy5uFEf0Gnqy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt54a8Hs; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso42334541fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730207821; x=1730812621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSMoTBUH9ZAGTBta9ZISlFsh4dK5o/uVfCGKvcTrA3Q=;
        b=gt54a8HsmgmDs3v0SXaUMwJ8KZZ8zWLItY/Xnmp7BES0JcfrlD6wvLTzmmE5CQy5pH
         +f3Ylaz/8nYBbYI9Uuoa12uBawU7ZEmQ7uozKrUL91pAGQ9BwYsuVztQjXVjvg036i69
         M4MxwJ1R//triMyOLRSdUjuaYwfERe1Xl4/rj7rG64oyGK+/TYyvV41pOXOjYziOa22B
         NhYI3+eke+0/1ieP33RkDCfrjCTvrJLdfshMs7gXXEqVjSJUVA+KsUIcI8k/S/9xT1vb
         QNHMkN90qFrkr8z4aAQOijArcMcMnqKEnvZpZpQ4zACocvMw9Ob6xt/zNIsNp9H6Aw8E
         1vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207821; x=1730812621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSMoTBUH9ZAGTBta9ZISlFsh4dK5o/uVfCGKvcTrA3Q=;
        b=viwyo80ftBPbf4Hk7x0GW3JJlYTolBz2p7yjxBW3UPXBofm1fjH20H9PetOCaWxY0z
         wjUJWYmrADlLT9RdvWBYY7N0x5xWkrDb6xTvmWEqY56hZ5Z2C75AXhmcz+yg+FDz+Uq9
         PsRLl83nWd1KqDzUoWZ4ddGc7QRZBkOKaslRHmjFiKO44HRGlaB/aXG15jzl593mEFC5
         3kP30yJJEG8BhoHeiDFb2VcgGL3hMjuux1KxV1l57xOXnC96kqoMwF2h1HNrCn5MOtF1
         FlCcHShTDC9GA/xAR+dSvEBbRj2QkHsMxXs4gWNNCyqzF+3IT9KjilRzDcikPGiXFAtp
         /sfw==
X-Forwarded-Encrypted: i=1; AJvYcCVw7piyZiEEydMSFO1V53SCIxWLQWE3MtjvBe5QPo17p8IKUBo87XLOlt1eK8UKHbFzwr3Gg+g9P2cVDKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPXUA1ZMqkNOWcrSjpOnsk9+LnlekZM6S06MtsESuHp8ANA7I
	6mPp56O/35g3FL1yRS0xFRUPF55mufTXJivpCfnTM5po/pW60skf5vS2uuK5
X-Google-Smtp-Source: AGHT+IGm3KQnRwYWnHaidTV7KPwOh6PY38rvbEADfr6oUwvsh931+CHkLC87MoQSMag+prkfjiZaDw==
X-Received: by 2002:a05:651c:1508:b0:2fb:6465:3198 with SMTP id 38308e7fff4ca-2fcbdf60348mr55008411fa.5.1730207820291;
        Tue, 29 Oct 2024 06:17:00 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4519b3esm14729631fa.44.2024.10.29.06.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:16:59 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:16:57 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: atmel: add at25sf321 entry
Message-ID: <ZyDgSRcT79yksuG2@gmail.com>
References: <20241029-spi-nor-v2-1-e166c3900e19@gmail.com>
 <0bbd2514-ff51-4b0c-b3ad-547e4937d9f4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EXAiSf3CKL2XB0RX"
Content-Disposition: inline
In-Reply-To: <0bbd2514-ff51-4b0c-b3ad-547e4937d9f4@linaro.org>


--EXAiSf3CKL2XB0RX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

On Tue, Oct 29, 2024 at 11:36:17AM +0000, Tudor Ambarus wrote:
>=20
>=20
> On 10/29/24 11:23 AM, Marcus Folkesson wrote:
> > Add entry for the at25sf321 32Mbit SPI flash.
> >=20
> > This flash is populated on a custom board and was tested at
> > 10MHz frequency using the "ti,da830-spi" SPI controller.
> >=20
>=20
> no sfdp for this one?

No SFDP for this one!
>=20
> > Link:
> > https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=3D1608801
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---

[...]

> > diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> > index 45d1153a04a07b7c61f46b117311b24ab695038f..8285a16b253d54ae8c4a530=
2850244d2248aa755 100644
> > --- a/drivers/mtd/spi-nor/atmel.c
> > +++ b/drivers/mtd/spi-nor/atmel.c
> > @@ -238,6 +238,11 @@ static const struct flash_info atmel_nor_parts[] =
=3D {
> >  		.flags =3D SPI_NOR_HAS_LOCK,
> >  		.no_sfdp_flags =3D SECT_4K,
> >  		.fixups =3D &at25fs_nor_fixups
> > +	}, {
> > +		.id =3D SNOR_ID(0x1f, 0x87, 0x01),
> > +		.name =3D "at25sf321",
> > +		.size =3D SZ_4M,
> > +		.no_sfdp_flags =3D SECT_4K,
>=20
> it seems this flash supports dual and quad reads. Do you care to
> add/test these modes?
>=20
> you'll need mtd-utils

Sure, not sure how I test it though.
I've added mtd-utils but I do not see any good parameters to set mode?

>=20
> >  	},
> >  };
> > =20
> >=20
> > ---
> > base-commit: 200289db261f0c8131a5756133e9d30966289c3b
> > change-id: 20241018-spi-nor-dc29698dea0f
> >=20
> > Best regards,

Best regards,
Marcus Folkesson

--EXAiSf3CKL2XB0RX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmcg4EMACgkQiIBOb1ld
UjK7+xAAi3KDCD7dHqOtvAx0XfPRzW8vetxcvvhqy0rr9c53CgkPhge8+zhyPe1X
deoFKEjIzv3K1Rhn3uDD/5JMgr/MoE6ZxRPWBBFyFXkl98QF+mS9aSAUySRqrvLI
wXMa7Xt02jDF3hJGs9wqM8x9ShH1Eo1lEcIwe9nCOJNi/MmP/w07DFj976MrQB8D
7bTjM4bTUgdcNJG+LkyfjQJN0kH7Ehx0bEo6AS86vr2jmPtbcV7NqcWTVyxBX7gJ
2bjMFn+KNaHzQGxuKy2E1wgIdqQcCgLfaZV8+xzOKRaFfDwXZDw78zh4nk1F8Suf
JposidYMwbkeW3nQM4bmOgfYHOFxwRelc0LJEGTfPBYNi2kpRhmFn/cE/KCAhYRH
x9xATr8xvR2H6YcjD8hd7cdX2O5MFYAdJUKtfFJqKXS2Zj5fmNhwTOlfpnId62KO
UzyffU/LuHgQaGhZtBzsPGQUvpzfArK37BuwDvPBkKXbk5t/JWxySMSOFC+rPdmr
1QB9ovpCrl8He/quaLkJnizyoFWeQ9HeX9kOl7R5c77LtdvAnp6zWUJ0a6Qi8+c9
JOj2zqr23JJmEL4UVbs/BDjMj9soxUMta8n/tt+yRL8wYWAY7pofaW8Wm778joI6
2PdfBV8f0dbrRSoadg1QVbx39RZqFFIj1ZhHZ516N5nEpj2c6Z4=
=Jra2
-----END PGP SIGNATURE-----

--EXAiSf3CKL2XB0RX--


Return-Path: <linux-kernel+bounces-386451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7659B439E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A118F1F23422
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF588200BA5;
	Tue, 29 Oct 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVy4r70s"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E4198E90
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188870; cv=none; b=LGyo6eLDkEb//eEcOleNaE3nOzGQAe4E8/desorVresMmpGB6DBsPC/ny7NejlMSlTuD8K1a8OUu+BRPy12loP9lwH2mFThii78CiOCQGNqT0hEZHrMwbBwO8eds7DLXW8Q0WihaLBcENGmuvstvDLgf8JAuHdObTQBNmhE2HZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188870; c=relaxed/simple;
	bh=bzhZz2GbYuomV5MFzqF3P/eLv0fnWUj7r5Lpx812OSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCeCMvfgMHFux1F+Ky03tcKQglo1G2eJZcNeTQkwEQPZuQdEiSNTe/mAKIs/vA4Hmt1I7lNl0IblZU1ejlkPsjCuQ+m0pc5/1tZVbN95euV6Kgergy8s3evM6FIWoDFwL1+6RRJa0gmHOs13kR5RQBRyD+0wBXbTAvyQYITiBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVy4r70s; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316cce103dso67925695e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730188866; x=1730793666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzhZz2GbYuomV5MFzqF3P/eLv0fnWUj7r5Lpx812OSI=;
        b=BVy4r70s2ut3hLDrMBl0Z2UEc2oBuCPNWQPIiQ7KpnnSkNesLYo8l7ELZCty4Y8wNY
         YSob9W4kOYqyCvGBhuiWIV88KQ92f2IwohisW3opUTOg/v/amzo1UR7P0DxGIDMALeZj
         Rn4665R10xbZDxG0R+/XnQ+IokjVw6IRFZGkplMPx+57tWmzcLr/RALCkWfNwKfLtH2u
         EFhfV44/wv6aSiDu3DQmBc+ujGCzY/+Cd8+H0U6Et0C+y7wwV0HHt1zME2Ft++GbI/0l
         +4YaNNJBCwmRzmrEyIMcooaNYAfVE5MoupYgPut5KrHPmHt0FJJMv9YA+t6gYCVmmvCN
         zAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188866; x=1730793666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzhZz2GbYuomV5MFzqF3P/eLv0fnWUj7r5Lpx812OSI=;
        b=rhU0tvIj+rhKG6bH5ZnohpHSfNiz1K75jUbOTDbwKAZZI5Y/1EwjPw2twZlPLADZ8C
         uSGY1bZc6EVg7MxYP7mK9P03mCVBIPMlcaFxQPAO+awEhe7XHei2cnljTDo5tKS/Jfsb
         Q8CEd3xv2MU8MwdmQ6aUY3uTbEbJ9whypavwDs/mHVqgTDg+IX9Dig5dRzbMpPP1MJs9
         EIDrSxtgbpESbD+lJJ8kED8bCYVKd8MEOCb/LMawPKRVaZBWSAkfkn6E0cr7M3huAKDC
         ZR0AIiv0SH+9yMmTZ2ll3kLXFaNy81JWj4Abb80wBTpaXUGLyxx5GTRENakyVfrmAejW
         Bnjw==
X-Forwarded-Encrypted: i=1; AJvYcCVSUjMqBsP71r0+TJiDIum3mO+X0ZC9lHgGVKDNoCftU0gXQc8ipyEqDMQAEt2m5vTVlmXGg0m2ccuikDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QUvHv39vbJCY0yf3d/8vNs03GpTmgsvClFRoEDUSgc7nRZIZ
	/UoNSFCGgjSdhZadgGzo60eBU5Hcw5XE2MHE2r8ikx7fJoFYR79ldnax3wsg
X-Google-Smtp-Source: AGHT+IFr0REKzIVW7Tl7PWuzYb/YDn87kfUPNpGrBe1ZEl3WOV7PcWg4Lczgc6Zu7KIosbpcVpyrhA==
X-Received: by 2002:a05:6512:108c:b0:539:8f68:e036 with SMTP id 2adb3069b0e04-53b348e755fmr7646927e87.34.1730188854996;
        Tue, 29 Oct 2024 01:00:54 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c96ebsm1305019e87.223.2024.10.29.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:00:54 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:00:52 +0100
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
Subject: Re: [PATCH] mtd: spi-nor: atmel: add at25sf321b entry
Message-ID: <ZyCWNK_xMIsW4Ibq@gmail.com>
References: <20241018-spi-nor-v1-1-d725bfb701ec@gmail.com>
 <239d2425-52f6-4deb-964e-e22d1a1f6637@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KknHUEYmorMeUoPi"
Content-Disposition: inline
In-Reply-To: <239d2425-52f6-4deb-964e-e22d1a1f6637@linaro.org>


--KknHUEYmorMeUoPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

On Tue, Oct 29, 2024 at 07:16:08AM +0000, Tudor Ambarus wrote:
>=20
>=20
> On 10/18/24 10:51 AM, Marcus Folkesson wrote:
> > Add entry for the at25sf321b 32Mbit SPI flash which is able to provide
> > SFDP information.
>=20
> then we could initialize the flash based on SFDP. If you don't need
> locking then probably you won't need a flash entry at all. See
> https://docs.kernel.org/driver-api/mtd/spi-nor.html

Hrmf. It seems like I have been looking into the wrong datasheet.

The actual device is at25sf321, not at25s321b, where the former can not
be identified using the SFDP table.
At25sf321 and at25s321b uses the same JEDEC ID though, probably what got
me wrong in the first place.

Please see page 10 in
https://www.renesas.cn/zh/document/apn/an201-adesto-32mbit-products-overview
for further reading.

I will send a v2 with updated details.

Best regards,
Marcus Folkesson

--KknHUEYmorMeUoPi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmcgli8ACgkQiIBOb1ld
UjLqWBAAyi0k9ULJfnyCaEkxEVEnWiyzPbYA3Tb5WlQoY/FuzK9QF2YO5eAZcnX3
1MI2jYg6AXHK5Peep8m0if7Zeul+lhXxoIbQ5rSvpg8V9emyP5H4OBMyC/Ut2Xn8
dAmHWzZq/4x7tvioOuceQMyvom3f31ruLYj1UIQDxqkgPxph/Vs10uz6VDYD7+5m
a2fws0yI32dprIjt17WJiNVqti7t8OB7UTtb+cMrYssTtcMJgg+ZwDbSbqKgKKgt
jb53eSQM8o45g7W7FwZG5niwV+BDnv3+U2iBqez4Z+Az2fJxH0hUqYajlRGDtAMw
9+OQW2YfXVuAhYBPeq1tbVRgYZYUi2gCo5QHtbXJ5dgetdzhHl1j1ZrSDTTWbSvO
BkMoDBlW8tdik9S9WPu++i8yqq/2uvbhOFz+vlimTjJJELiu9GdGGNiuf7JG0S2g
KuJdxtn0Md+s2+hHDK5ZguT6OljNsx0DADS1XW/K2TGsBrvHeUSsB05RvDaaUiwO
BK47ytYmWued1tcflYvtj/9RL36rrHTJx1EQzedpzCHYqdGTPvXlfLPMqZVM7hvx
qJOctA11w5wkDje2DUuxYzeG8uytdXglmAsnYM5DTZnTHpOtSAZf1VjCKCm9YkLh
GeTIBZcjHffbAB4053mzvDA+Nxt88VTVteiUByfu6gKKVkcv3Jo=
=l+pl
-----END PGP SIGNATURE-----

--KknHUEYmorMeUoPi--


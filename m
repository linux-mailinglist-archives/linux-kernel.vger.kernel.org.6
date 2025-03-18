Return-Path: <linux-kernel+bounces-565940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF97A67154
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86706188A730
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6230B2080C8;
	Tue, 18 Mar 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toVeIjO2"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDE202997
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293956; cv=none; b=Pd8UboCEv2CxiNVkD2vT7UQ3CsYfavH1AkgOF+8Oy1Y1GJkd+A/f4Ob0vcE9ETyXvPV8nuZFHwKo2EdC9PMZClDPnpWqwmHF9gx35hbCD0klCkXutnuigWThOuiIrdgJ2bJB0LCEE9ftamFNH+A9jaAYes8YBuKaNAIO09rAaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293956; c=relaxed/simple;
	bh=D3LhLhbqPVRITeMp5L3e0L9ixREsZnDi/JKUCXWtP4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S35b9UvfRVhyg6yBGt5VJBZDvd1EjRqvaq2MfPme9StsbBhuKXOwKnUsilWtVQEQRfAB8hEHciqbIw+SpTFsO/0ooVpf0wcg1DBHxaVnq22QfAXornFklDbrWFxCauEI0fEJZyI3ZMSK7fpPVIAykkxJkJF7o9+rj3tSp3yEEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toVeIjO2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d450ac4910so138715ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742293954; x=1742898754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/0XDSB1vld5cUtxsFXUAzOtrX9mHriAbs+ANUXBrrQ=;
        b=toVeIjO2zyywGywxuHipBQdsJmVcZzib4lQJpPEu2GeSRb3YFDULxOY8AFBEhOx1qv
         Py8fBHYYYl8PZEBhWsjtx5Hs2kdsB3n1dLzZimzz4Kdxp2vLTclYIjmDnLzp0ssD9PEA
         BX99itoTYe7qMsNFn7Cuo11QEiYEiheszIS58pUQuk3cPGDd1scCG48e+Qso2/QZQprW
         B9QrRYy4eIt1ReOhtSPB4Kk+nyU/nvG8RNjYBA2UE/xCj87zZeVfM0KHlVxc5U6n+P5K
         66bnlosZ1y4VcpLz3GwIFtN0ZldzfMHxDIVkgGbo6h6AjGBpsNMcL1r0La7QS/5g5Im5
         mt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293954; x=1742898754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/0XDSB1vld5cUtxsFXUAzOtrX9mHriAbs+ANUXBrrQ=;
        b=muSBLHDCtJbnZAkKsA5VtpUGvTmndKVBGYKW80i6kgHpN1cu2QiwVov8M03DIJGZ6J
         1bpVfw1ZczruqBONMtPgebTplLBg+MqtqXWeTVi63ZWKleDyiiQ2hBnPftBqxrAgP6CZ
         7WNqD2+lXJ7fWi0PMv8+0aq223txoe9x7oP1DqrZ8PnTrzSChQm8vHtcSmsJFzXK7F9Y
         Wzj0iIsvrYZZ/ZPffNcLDCdEHL7TcPucs+DUzX2RgdKp5ighAewqA7CjbaGt8lLSqvkk
         Bt8o31oGJ8nWW7gUzn7crwbWqAq206BdHRTL5q2fY491vlW7N/0UjupRdkP2/ntC6r1d
         L54A==
X-Forwarded-Encrypted: i=1; AJvYcCVt+1u2tcHfMtcS8TnO178OEeRxOU3dXTmHMMVIbV5K8JsPqGM8LtpcAJZxAvRcanuTXRBRwRyQoZK14Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnaZBUbx1XAfU832KrM7B0cwThqff43Oa32OSlPxdHbVJ2Egm
	I6GbULWzALVk9sx2rhvVrsnJF7/SU8huQ8xuFFSdC4ZBZTWIuL6B0CxTQrbhg0MX9PBrKVeNTjF
	R9h0p58IYSM6yILtTEDTDFIcAOYuFdUlb10GL
X-Gm-Gg: ASbGnctnM3iy5vn4gb2YoMcoQ6HRrxRrtdltLSnWaCX+I62MoxgwlD8tFl0LRCxE++C
	3q5qL/hFul9UUAQNcAyhGGOkVf6IpEZXNj2zdizKV5DksRyxdspn9UqYMzSDuvFeefMD+YhXMA+
	tPsxlZwhnlJGtpzaSbDL08fCcctrhmsWGo1MryysmdnbWs53mnOK/NJC0=
X-Google-Smtp-Source: AGHT+IHP+a2pA9w8C/gg7jD1p61petdMjrcurDDNP2YU9EJK/gdyOq8j+Pl9PL8xSCm2IXOP61bNRt55YIBl/tb8zQY=
X-Received: by 2002:a05:6e02:a:b0:3d2:afa0:9ee9 with SMTP id
 e9e14a558f8ab-3d57f0b7dd6mr2003895ab.7.1742293954173; Tue, 18 Mar 2025
 03:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317182047.2060036-1-czapiga@google.com> <4be8afd5-65a9-4cfa-89b5-42caea3a9f93@linaro.org>
In-Reply-To: <4be8afd5-65a9-4cfa-89b5-42caea3a9f93@linaro.org>
From: "Jakub \"Kuba\" Czapiga" <czapiga@google.com>
Date: Tue, 18 Mar 2025 11:31:58 +0100
X-Gm-Features: AQ5f1JoRlAxWJkOjOQ9rqrZ1147ioWBczbnF4Th0_2s0QUnncrTMv7_k1ksyQ20
Message-ID: <CABkukdrc59rViGg9DmJU3AVZ537310xkNKhuTwjyRwpKAEuWbA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: add lock flags for GD25Q128/256
 and GD25LQ128D
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 8:09=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 17.03.2025 20:20, Jakub Czapiga wrote:
> > Set appropriate FLASH lock feature flags.
> > Set top-bottom protection configuration bit flags.
> >
> > Modified chips:
> > - GD25Q128 (+lock, +tb)
> > - GD25Q256 (+lock)
> > - GD25Q256D, GD25Q256E (+tb)
> > - GD25LQ128D (+lock, +tb)
> >
> > Signed-off-by: Jakub Czapiga <czapiga@google.com>
> > ---
> >  drivers/mtd/spi-nor/gigadevice.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gig=
adevice.c
> > index ef1edd0add70..8eec6557b036 100644
> > --- a/drivers/mtd/spi-nor/gigadevice.c
> > +++ b/drivers/mtd/spi-nor/gigadevice.c
> > @@ -16,6 +16,7 @@ gd25q256_post_bfpt(struct spi_nor *nor,
> >       /*
> >        * GD25Q256C supports the first version of JESD216 which does not=
 define
> >        * the Quad Enable methods. Overwrite the default Quad Enable met=
hod.
> > +      * Otherwise set TB to SR(6).
> >        *
> >        * GD25Q256 GENERATION | SFDP MAJOR VERSION | SFDP MINOR VERSION
> >        *      GD25Q256C      | SFDP_JESD216_MAJOR | SFDP_JESD216_MINOR
> > @@ -25,6 +26,8 @@ gd25q256_post_bfpt(struct spi_nor *nor,
> >       if (bfpt_header->major =3D=3D SFDP_JESD216_MAJOR &&
> >           bfpt_header->minor =3D=3D SFDP_JESD216_MINOR)
> >               nor->params->quad_enable =3D spi_nor_sr1_bit6_quad_enable=
;
> > +     else
> > +             nor->flags |=3D SNOR_F_HAS_SR_TB | SNOR_F_HAS_SR_TB_BIT6;
>
> why do you tie locking by SFDP absence?

GD25Q256C has a different Status Registers layout compared to GD25Q256D/E:
GD25Q256C has QE (Quad Enable) bit on SR1(6)/S6. GD25Q256D/E has it on
SR2(1)/S9.
GD25Q256C has TB (Top-Bottom) on SR2(3)/S11. GD25Q256D/E has it on SR1(6)/S=
6.
The default TB value is zero, so "top", which is also the default
route in the swp.c if TB is not present. Moreover current API and
implementation do not allow to configure TB in place other than
SR1(5)/S5 or SR1(6)/S6. I figured that it's better to leave TB unset
for the older chip variant and allow the driver to only access BP/Lock
bits in this case.


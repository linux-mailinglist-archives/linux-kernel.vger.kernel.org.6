Return-Path: <linux-kernel+bounces-321306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AD97188C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE74284A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9B1B5EB0;
	Mon,  9 Sep 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a7vUtRJA"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294E1B5EAA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882350; cv=none; b=JpcDBcBk4+TbrjQOFq+xd8WmnBTNrJK/EdcALfZ7miU+BMPfr2z0wbx9+7bxGa5aDzzV1KwLfkA9R+PTg4++dGPxhop55k8kTrBoYZHOXxrAG1Qg1p5m3QNMCQ/LcEFPNH3LHZPmF/UzNEQ0kyPtbQtcAbFqgtxZw44ntUkhfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882350; c=relaxed/simple;
	bh=XnU5oqdkva6JlXDEjEVyReSI87QguVXWZ6VnCHwOk0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqATWnepSWXqpYMzZHadLmVfqyERmaxlL1ZVLGiBaBpnaQ5D6LJimlMv5QupxBhYoUVEOzyiESoUWcAUMoiPBhZJ3acxiP7YIA045dazSS4d+WHCkqz8FASK2ONx1EmUMXvr/pEmzXC/rRJxXsBjEu1mfWZibAVqNMeOofwhB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a7vUtRJA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a81bd549eso391042066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725882347; x=1726487147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnU5oqdkva6JlXDEjEVyReSI87QguVXWZ6VnCHwOk0Q=;
        b=a7vUtRJABOcLuXDuFczWlJJcjLmLVPS5wFjCYwga/4zvBlABvn3KjIBBtL4Y5Vkh/J
         NrBdYosWg44zagIc9GMoyPYz7W//Sq0GF1ggUhywt5AV/LxAYS4jKFRkxYVBeNgI89xq
         7V0u4p5Y1XkECb3dIaKrpLOEnitigGlvf5IDnT8iIECl7SA20DEYJrVn4FQijRDuBmRW
         dCkMh8J5+/xfViMTg3Dhuvij9IU6VV5j1NhdT1F8Gvm/GlIm71hDvmYLcXTRnCeDuAq3
         JDlctf/ONViuRHkzK94vpx3kFti2wlzyV1pEYEeuPCxaqTOxtVIkcQ3vDw+LJS7q2zm4
         QS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882347; x=1726487147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnU5oqdkva6JlXDEjEVyReSI87QguVXWZ6VnCHwOk0Q=;
        b=eMsMPb65iX9ddcuIrj149ENv2bxZPgPYstKDTEkYzeVid69ea1K+4e0jG/q0WZCJml
         4FE7lVpEGpNYcFTZv1dDltBqWHdYZX2Rk/BtU4zXYTPWVwmDiynasM4kBA4Ro81g//g8
         wkD1fA+gCymRv+sE5Fk0gDwral9r+ZS4ByL9t3vX9/fuNlasHDWZvGv6flctomtIh7/a
         Lsl1schLw6yDanQ3uKeqoFIcSJPzrmjKg+CGpbqt/upAPHtfh+NYc3JdpPN+EcyIVK8l
         Gg3HqhItyDwzPHKs+QKn8y9wKmATHXbChbBtp9FbyWNr+tR5kqF+MXfSFWTP023wEiPP
         mxSw==
X-Forwarded-Encrypted: i=1; AJvYcCVQv0Sb9ir53ljD+6MCJOjMBV7jGiqVPZVCZE0j7oPkwSgkL9pRiHQzbDa6/ME/QsYXI1GfZD3/E3mSN68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaR9reHWLBS/9/E+NnrppcdGOs2f7jgCWIddxRHaEeEPDzJ32a
	AB49tfE5MI47CImO60BLwb3qkW8qZZpaGHx6zGl9vWAwo4zkX0Hi9zt2UDZzSq4=
X-Google-Smtp-Source: AGHT+IF9sTxIuBaRpoPL61TxnkmP8Dx/HI/SPewkxhF7tomJE/hxctaNQ5MCjtCSQzuNxgnZLZHgnA==
X-Received: by 2002:a17:907:6ea3:b0:a8d:29b7:ecfd with SMTP id a640c23a62f3a-a8d29b7ef71mr484389166b.54.1725882347134;
        Mon, 09 Sep 2024 04:45:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:d821:d81a:d0ad:70b8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d64880sm326216766b.219.2024.09.09.04.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:45:46 -0700 (PDT)
Date: Mon, 9 Sep 2024 13:45:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, Chen Wang <unicornxw@gmail.com>, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, inochiama@outlook.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <qcpqwvffln3cb5lxnhwarmeawiudurc4v35rqz7jo6xo2es5bi@2q4e4f4zn2vu>
References: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
 <202409080100.h6lX5Asm-lkp@intel.com>
 <MA0P287MB28225ECCF1D263A20917AD5DFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <CAMuHMdXOAmCsdcvdo41qD9f4L=K2uZa6nJN7D5YOTTuCnBHtWA@mail.gmail.com>
 <MA0P287MB2822B10767514B3E04E8E468FE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4hri66l74asgozqa"
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822B10767514B3E04E8E468FE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>


--4hri66l74asgozqa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Chen,

On Mon, Sep 09, 2024 at 05:08:41PM +0800, Chen Wang wrote:
> On 2024/9/9 16:45, Geert Uytterhoeven wrote:
> > On Mon, Sep 9, 2024 at 10:26=E2=80=AFAM Chen Wang <unicorn_wang@outlook=
=2Ecom> wrote:
> > > I wonder why CONFIG_PWM_SOPHGO_SG2042 is enabeld for m68k? Please rem=
ove
> > > this.
> > Because it depends on ARCH_SOPHGO || COMPILE_TEST.
> > So it can be enabled on all architectures when compile-testing.
> Thanks, it's really a potential defect when CONFIG_OF is not set, will fix
> this in next version.

BTW, the right approach to fix that is to not use of_match_ptr when
initializing pwm_sg2042_driver.driver.of_match_table.

Best regards
Uwe

--4hri66l74asgozqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbe3+YACgkQj4D7WH0S
/k5YAAf/ZNKh4xi7R1WSFPG/Wv0vzAzDccHjA9P4I1+bCKuQFR8gnOzEyDCfd6Mw
dz6nqq522U9d7SpAwlpdUfp3p/NTEoZHTz3jgSc99VVNSkNWdSVn3DJJ9vM9UnPn
RmAK5y9c9uvxy18E5icgMK8e5wQOgbnJwlilxiCnAavoLlgayhXbGemxdjXvLrjA
VDCXxjjE7AxENa3iGYOZ/PmeGohtXgnhEEaYGqqcS5m9WR0B4vgowVRofEl7THDi
PMv6kHAzGbZMAfZzdRxRwTZC5i3zXlPcS3asABsYaOtZOTYxiCShltzDqHmuGDP/
pVevymnhHrTE4Ec458orVY3Km/JA1Q==
=gCpB
-----END PGP SIGNATURE-----

--4hri66l74asgozqa--


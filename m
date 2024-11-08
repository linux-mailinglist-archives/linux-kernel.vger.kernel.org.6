Return-Path: <linux-kernel+bounces-401430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF19C1A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD191F23924
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844E1E2600;
	Fri,  8 Nov 2024 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahuu6m0P"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165C19259F;
	Fri,  8 Nov 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061492; cv=none; b=reiZZzluI0JsXtmnEys3qZqy8OIK9EhNHwQp35sOapMcoq8e2yJO1CvvuucJMJvvz8LUGfIAA4tqzyyPf/o86NGOPoxHKHGGiXhyiPU/auYyxNtqoNZ+xApmqvVjsJXP3uFqQRRHsCJDd//L+pipHXjE0adECuGagJbbywaVcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061492; c=relaxed/simple;
	bh=LMXpH5Z7TKp2QaLRCa69s7TXn/ETV9R/IgCBThdgOtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUnhpzIZ7YUeoqBdBZqpviHUZA0ee8bdhuJ0bDyGwATh0KdvjgEBiUdiU1jtK+USrh/aIpVvOn3lilpqrUQb1c5s0WF/9ccE8stCMJiUzI5d7y60Y4DwJVSX2mmGv1XEaqxCazyJR0nFTf/Qz4EqoXofEIUtJavbYE01UcvMuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahuu6m0P; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e6005781c0so1196712b6e.3;
        Fri, 08 Nov 2024 02:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731061490; x=1731666290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rLgU6rNBJeLkV3w0NfWYz8NMRiSmMvEm4NpmBIUz18=;
        b=ahuu6m0P4GeMdNWHMNhiW0NL/zJjEo+0c3FG+9QcgwoKrms3+Jjy88Hn6ZzjBPb0UZ
         a6LJPa+51NB458aB5hwjzXUEmmn9g9+to7LBOkVgDjGzDwtCrQPR4FxPiOLaN82OsEmK
         xFMf2BP6BAx7fcBgSdsGhY8JczkEtRC3rw/whhb0Qxi6y1NshsTpHnBo3Ds6sF0Wj01E
         upr52Ye/GAAD//EpTn7WZcoGx9e+gAFxARWBBVF179kKVPgglIZvGmoqPHqrF0I7rb+a
         1ZPRtQ0PfqzY7BOE/AGGlvPBx5XfOV3Oc91clmSKaDTAKuZzL4iUDnMTPbX5uag2XCj+
         isyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731061490; x=1731666290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rLgU6rNBJeLkV3w0NfWYz8NMRiSmMvEm4NpmBIUz18=;
        b=Wkxowbm8Hu4ml3zZWVDhcjts655xjUp2d0SSTmdT8K7jp8TMEhxBBFWyzwQ3cPwycB
         Nw7H8JF584zdHCveFr4+ESIHavZtThCWUg9zfHzAKQc73+pZ9vYib3fTVJ/2om3FCDIL
         uEbE4a/e/LyniRV0M/XSLrkPaHF0mdSyZMqYySQR5MVThrt2475HCQMNBbFC2xvg0Ivl
         suHKcQ8qQm4dSf2zpz2zdLkVNgF/e2Tal/dNBbOLJryrbEwErHpY4ptYi5L5gMWwZdtl
         Zm4esuSa2aU5jpwab2bCgug1FmxGZsSURPM3adKlGrVtu/sj6ZoDj5atoSjKnaySvIlD
         ve2g==
X-Forwarded-Encrypted: i=1; AJvYcCUqep04zC1BsJp24J3DSW/OgErU3ggPfd7+mk8Sdf43CptU5iEgmC05FJCqQHVq38EZttrMFTNLeoU=@vger.kernel.org, AJvYcCVxEwpDAvVLrbNe/Gohk9ajij/jUXrQa3Fvw3nGdCpfaHGMOoiKsaQ1QdKpSn1nSStoYCXvRCMHy/ISHnoS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7AY5BerPpecndDt+CCP+mkmtxeKjNEaAxEGp/x46pZkO4E1/
	AklZBk4GG2htbOSV1Gg2IT4U2Dfh/rnOECS/B7JaZyk8jPZBhX/Y
X-Google-Smtp-Source: AGHT+IEbImmFikWK6uKWuDU7+7VuM1/bsHT2tUEjNx7c5mvBVCf1pss2FnLdoAhimGqpHuyGLG9YwA==
X-Received: by 2002:a05:6808:15a8:b0:3e5:f534:ddc4 with SMTP id 5614622812f47-3e79458571fmr2618809b6e.13.1731061489886;
        Fri, 08 Nov 2024 02:24:49 -0800 (PST)
Received: from archie.me ([103.124.138.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643a60sm3054318a12.56.2024.11.08.02.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:24:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id F2ECA41AD6C8; Fri, 08 Nov 2024 17:24:46 +0700 (WIB)
Date: Fri, 8 Nov 2024 17:24:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Rodolfo Giometti <giometti@enneenne.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
	corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dong Eddie <eddie.dong@intel.com>, N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [V3 3/4] Documentation pps.rst: add PPS generators documentation
Message-ID: <Zy3m7qO81OP4DHAF@archie.me>
References: <20241108073115.759039-1-giometti@enneenne.com>
 <20241108073115.759039-4-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xojr/a/GWq5da8gW"
Content-Disposition: inline
In-Reply-To: <20241108073115.759039-4-giometti@enneenne.com>


--Xojr/a/GWq5da8gW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 08:31:14AM +0100, Rodolfo Giometti wrote:
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/=
pps.rst
> index 78dded03e5d8..71ad04c82d6c 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -202,6 +202,46 @@ Sometimes one needs to be able not only to catch PPS=
 signals but to produce
>  them also. For example, running a distributed simulation, which requires
>  computers' clock to be synchronized very tightly.
> =20
> +To do so the class pps-gen has been added. PPS generators can be
> +registered in the kernel by defining a struct pps_gen_source_info as
> +follows::
> +
> +    static struct pps_gen_source_info pps_gen_dummy_info =3D {
> +            .name                   =3D "dummy",
> +            .use_system_clock       =3D true,
> +            .get_time               =3D pps_gen_dummy_get_time,
> +            .enable                 =3D pps_gen_dummy_enable,
> +    };
> +
> +Where the use_system_clock states if the generator uses the system
> +clock to generate its pulses, or they are from a peripheral device
> +clock. Method get_time() is used to query the time stored into the
> +generator clock, while the method enable() is used to enable or
> +disable the PPS pulse generation.
> +
> +Then calling the function pps_gen_register_source() in your
> +initialization routine as follows creates a new generator in the
> +system::
> +
> +    pps_gen =3D pps_gen_register_source(&pps_gen_dummy_info);
> +
> +Generators SYSFS support
> +------------------------
> +
> +If the SYSFS filesystem is enabled in the kernel it provides a new class=
::
> +
> +    $ ls /sys/class/pps-gen/
> +    pps-gen0/  pps-gen1/  pps-gen2/
> +
> +Every directory is the ID of a PPS generator defined in the system and
> +inside of it you find several files::
> +
> +    $ ls -F /sys/class/pps-gen/pps-gen0/
> +    dev  enable  name  power/  subsystem@  system  time  uevent
> +
> +To enable the PPS signal generation you can use the command below::
> +
> +    $ echo 1 > /sys/class/pps-gen/pps-gen0/enable
> =20
>  Parallel port generator
>  ------------------------

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Xojr/a/GWq5da8gW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZy3m6QAKCRD2uYlJVVFO
o42FAQCW1M7kbLqla/5wXv9zm6wxsPB773y4MN9enemWiRCK2wD+MqMRDBhRRuoW
59dqwDUTxUcIJXHz2EfGuppAysUdFw0=
=tNUA
-----END PGP SIGNATURE-----

--Xojr/a/GWq5da8gW--


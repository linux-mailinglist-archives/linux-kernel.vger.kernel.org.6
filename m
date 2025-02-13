Return-Path: <linux-kernel+bounces-512899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E8A33EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704FE16A4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153E21D3F9;
	Thu, 13 Feb 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uaz9doD1"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67237227EB4;
	Thu, 13 Feb 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449303; cv=none; b=nQC5o2r/FrQ9E7ksDB2amCIt+rBYI8lFrxwD1RjjdZI3JdgBkN5HaOR7R0hLsUz4uaMICAlDmx9W55PwXHHBruOpWWguJHKuQNNqVUtLDUMxqSOssg2fr/3R3L7oIIpNA56/hJ4sfcCFDYdvtM2NnH/VJ6yhfjt0ERVErmqERv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449303; c=relaxed/simple;
	bh=sZT9y6vh/nem7EpRAeaTqeojK5JH1EE1vPaenyIwBHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOBWLV7ovXEsDJDn4K4uNUg0wlos29EFyxba6sygRd+go676P/QFZ//HebgbKz+4XkN9YP/RFKRbyFa79pOG7BKLQO/rvwxxkLGSdBFp4GOsPFKoVGFRXqGOFdIapf1txVGnjus+pNKtA7/qxI0g6dgjvxQkk+Rt11WtI4KXtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uaz9doD1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so12227705ad.0;
        Thu, 13 Feb 2025 04:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739449301; x=1740054101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih6mZAjRJz76xwxt0ZT6xMUzrYvU8FqRj/C5WSkXc1g=;
        b=Uaz9doD1oq2XdM788A1fVuzElvJax6+oZUdiT0O4rQCzEdziJ9BCBdUQhNYZbJORB2
         EcUjSK2nVYUOkyCCfigMK942IBRxblovIGKut+Zm7PqlDCCixgk+K5vGb/+yfvnMuwbS
         hUGvpuftnD++tR1w1A82bgSTEj9GOV5QyeXvltNE3kaUHvlKQyTZvC0JD49DrY1Wvh30
         /5nMn+ZgAQf3xz5GOKrh6Gn/N8CjmhyGVYpUCxdoGvquI0DycN5OwbVjY5xvKIn/k2xM
         ySRKxvBXK01koa/sO+q8HAj2uxtRbCewD+2q+exV6zn59mGbDuZCIoocrSevevbUDoAt
         OaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449301; x=1740054101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih6mZAjRJz76xwxt0ZT6xMUzrYvU8FqRj/C5WSkXc1g=;
        b=MJy57d+XJByHF9UAbJcbwKN9nfN6FayJkYDFb7j88SbKnopTjWtfG/9Jvq5ChGIlx0
         IvuU9EAJlCBpC+9Nrh9B/ffMl59wGiiXvHUkzhF/zliUSeYIoFyHm+G21szXWzxdMiO8
         mB+d77PTIHvEa8I7lC01nnZ9G2aEQY+BVIeGMIKcduLgi2Y87/Bgn0bsIPnt8yOovE3e
         RTzCim4NGBZTfiGtdIbWMFyh/qIrMFexUiGqBWOA2kQ70q9AorqxkFWz4qQx9i44sGJ+
         8JDZCkvUzhMLdDiORg2L1F2uCe35Z0XmrS/7UmZfbMrY+UMutxwxzaGBCAKoZ8ura3JV
         0UIw==
X-Forwarded-Encrypted: i=1; AJvYcCUqAfKLkE5MDE9rS129VhUYDZuvjC1lF+rDg7cpyoGkhOBmCnAYqkgXQbq0/++MLuKMjHOzbkd4fx3tBlDc@vger.kernel.org, AJvYcCVtyDtv2IdOLOlpg9bACgi8/JflepJAlXuBBBcZVPPMjSZJ3BGKOFOTm1zV6a6ztNIgeAmvVgcSqu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZjqoD0ujCrrBBjtmSr5aRvm8dKbAxL3QTVRafYXPXRKGPxEJ
	ikrA2to7zcY5RWGWjlFpEmqE/uf0YdShJhZ6S6E6jSmYMYlW1auq
X-Gm-Gg: ASbGnctIIqKYTH1JeMkiDIsjPIlZOcuq9ijkOcw+5jsM/1TCQ9WeuH/v1pvmB5hZ2Dl
	idkEFqCczluc643fDxORkzZ3PDdBni7/E4smAZvrW+8sUmilML46VrLoQxIWfhizvZ/gh+FVK22
	EMvE9TChrjqs2pD+G/zHl9YifD7/vRlsflYwRIADcDeap9MvKvxB1f48mCQ0602/5+Cquivi3j4
	qMdp94BaicU1IGK9CORAIJJKMMod5Njn97LZDzwyQrvEJvcAO9/NUbfVHhtdQxLCiEsdl//tsWi
	PM8MrEcRuSxxs14=
X-Google-Smtp-Source: AGHT+IFml2B2kVVPUcv5EICeISj5vverteoaMYGw1G4vFDkinN7nE3+hmOZi6Bm9DGhOPYzh5VeNCQ==
X-Received: by 2002:a17:902:e544:b0:212:fa3:f627 with SMTP id d9443c01a7336-220bbad7e71mr116005135ad.16.1739449301425;
        Thu, 13 Feb 2025 04:21:41 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349031sm11458905ad.30.2025.02.13.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:21:40 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1A9DC4208FB6; Thu, 13 Feb 2025 19:21:35 +0700 (WIB)
Date: Thu, 13 Feb 2025 19:21:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Nysal Jan K.A" <nysal@linux.ibm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Baoquan He <bhe@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	James Morse <james.morse@arm.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] docs: ABI: drop two duplicate symbols
Message-ID: <Z63jz7uEoMNeaIga@archie.me>
References: <c3dce809f577584cf9aedafc6c2a0d5a9ca909ac.1739394480.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V8GpvAGdAdv4I6Vt"
Content-Disposition: inline
In-Reply-To: <c3dce809f577584cf9aedafc6c2a0d5a9ca909ac.1739394480.git.mchehab+huawei@kernel.org>


--V8GpvAGdAdv4I6Vt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:08:01PM +0100, Mauro Carvalho Chehab wrote:
> As warned by get_abi.py, there are two symbols that are
> defined twice:
>=20
> WARNING: /sys/devices/system/cpu/cpuX/topology/physical_package_id is def=
ined 2 times: \
> 	/new_devel/v4l/docs/Documentation/ABI/stable/sysfs-devices-system-cpu:27=
; \
> 	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-devices-system-cpu:70
> WARNING: /sys/devices/system/cpu/cpuX/topology/ppin is defined 2 times: \
> 	/new_devel/v4l/docs/Documentation/ABI/stable/sysfs-devices-system-cpu:89=
; \
> 	/new_devel/v4l/docs/Documentation/ABI/testing/sysfs-devices-system-cpu:70
>=20
> As the documentation at testing/sysfs-devices-system-cpu, drop
> the duplicated one from stable.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/stable/sysfs-devices-system-cpu | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Document=
ation/ABI/stable/sysfs-devices-system-cpu
> index 902392d7eddf..cf78bd99f6c8 100644
> --- a/Documentation/ABI/stable/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
> @@ -24,12 +24,6 @@ Description:	Default value for the Data Stream Control=
 Register (DSCR) on
>  		If set by a process it will be inherited by child processes.
>  Values:		64 bit unsigned integer (bit field)
> =20
> -What:           /sys/devices/system/cpu/cpuX/topology/physical_package_id
> -Description:    physical package id of cpuX. Typically corresponds to a =
physical
> -                socket number, but the actual value is architecture and =
platform
> -                dependent.
> -Values:         integer
> -
>  What:           /sys/devices/system/cpu/cpuX/topology/die_id
>  Description:    the CPU die ID of cpuX. Typically it is the hardware pla=
tform's
>                  identifier (rather than the kernel's). The actual value =
is
> @@ -86,10 +80,6 @@ What:           /sys/devices/system/cpu/cpuX/topology/=
die_cpus
>  Description:    internal kernel map of CPUs within the same die.
>  Values:         hexadecimal bitmask.
> =20
> -What:           /sys/devices/system/cpu/cpuX/topology/ppin
> -Description:    per-socket protected processor inventory number
> -Values:         hexadecimal.
> -
>  What:           /sys/devices/system/cpu/cpuX/topology/die_cpus_list
>  Description:    human-readable list of CPUs within the same die.
>                  The format is like 0-3, 8-11, 14,17.

The warnings squashed away, thanks!

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--V8GpvAGdAdv4I6Vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ63jyQAKCRD2uYlJVVFO
o1mgAP9Cj8rDcfEMN8OPNDJ4L1JrRYF9z257CO2gYvYOodNjeQD+O/MeH2cK8WPW
QLhpk5lXXpNiSxdsO3FR3QlPFGmAwQ8=
=BeeW
-----END PGP SIGNATURE-----

--V8GpvAGdAdv4I6Vt--


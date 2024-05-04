Return-Path: <linux-kernel+bounces-168531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB418BB9B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215731F217F6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA16139;
	Sat,  4 May 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhB1eTvY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D228EA;
	Sat,  4 May 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807065; cv=none; b=QW4UJDeoEszVW/hXRWiGQq03JM/mrKEmaWn/DOtZku52cygUMOpPMlVIeaiSu8FDQMMC4gMruSY0kcYataWbGb5TAMmE6xaFmz2YnLlQjiD7vicFsaTzsrMBIko3gTuqmd693Qq1oCRSC7slftQit3fYf7RxyEMyf/mk9RmNl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807065; c=relaxed/simple;
	bh=ejWxIT2n8p8dZWoM545mizb9Me9EE2+yOLIi4nbVIhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NChiG2ynP0+ztIZ94IjWMAJmZiU+hPBBDwTm9keI6Y1Vh9ig22MDnTaXa/kI/duvIZbJpwLPm5/ZCYodKyDK9vsXDUFrwpVUSZ4RpGuajwO3P18yiF/+XtBamRRa8znc80I4rAZZaa9AUF7T6PbZ5xJDzVe/gov9a2vp+fzWs/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhB1eTvY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so1692195ad.1;
        Sat, 04 May 2024 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714807064; x=1715411864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XC8N3tk53B+3ELEb4uOpOgXhdDIpoi23VgMeUZkbc4=;
        b=HhB1eTvYPD+ktMHwXFp3GKlF1zSclijHiPwoZC23vftEygD4oayrFNXo7lM0auYl53
         vdT7JyQ8644W1wciuQdFUAGlvVvKRS/aK/7ZExYpb6ArRrW7fUzEZUaIupCms7pHwX1o
         GQSSFrXl9y1CPCI8d5Y7t03DrVQlgwsCy/976ZUSJtWS0uBzEEeIgsc7cV4Z5Jb+1uhw
         tupTKtmqPEIn2O++PukbHZ3KDTB5F5mg6P98IHvJW/2/YNA7TxqV9mJhv5ZXf5BSPkUx
         IoV96ZI8eOcksdj8wfBEPpFsrX+lM8kufeRs9HPpKzKeb7WUkuZpr7uCQeCap3OX1+X4
         0Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807064; x=1715411864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XC8N3tk53B+3ELEb4uOpOgXhdDIpoi23VgMeUZkbc4=;
        b=phNWQKp/VsBXyUL5I9Dss2Sp8t8dviee8a8ChIuGyelr+gtFJ7wWVeMWq7tncEjv/w
         8XvA774akYtuiwkSFweId9cl5Efpi//h1tQ/MTnXFcIlWzbTaBwpDD9B076q/o5o7Nxb
         jnTN7hsUwPChFZSCf/4P4SWyhXCpNcV2zHhT205aayLwcaBDx2KGI/mjZ+RKA1BbD2am
         BD3aV8MHNWEG30xdVQdsbe1/xLaPWf/uKQtiH7MsIMrBLCIOlzdxIwJUJY+AwEbuDmmN
         WhYADkFqYL7GgJg2nB2gkDT+k/b64H/XwqzVcddOIiJyrw84FZAsrrJ0JJOvpN896bm6
         4WXA==
X-Forwarded-Encrypted: i=1; AJvYcCUMtHnZR4ASGujl05UHJIWGDawLGNNe/LwtpTIdfeyS/9JrAmMDgLB8J2GP3wz2p0zC+/+7Qw+fHTScZrHSOkul4FQIMyyMRd1gl3iq
X-Gm-Message-State: AOJu0YzmTX265orsRCxXqDZ6d5A1v5EzSggBtWu/R7ahHEMz71MvPd6s
	ohYCaIeZZ1SwZhd35/KvSuzXQ4b09qlZYWm1hd25vHtHypQnQrGdepjPMg==
X-Google-Smtp-Source: AGHT+IEb8mu9yDKo6GTL0CkxNwJE2by96WT7UiE/qOzFSZ1sKGTGQowxWrGnYBUzMHUIvVAMWGvE8Q==
X-Received: by 2002:a17:902:f546:b0:1e6:34f9:f730 with SMTP id h6-20020a170902f54600b001e634f9f730mr4855974plf.52.1714807063714;
        Sat, 04 May 2024 00:17:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902bc4c00b001e4565a2596sm4420092plz.92.2024.05.04.00.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 00:17:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 915FB18494A25; Sat, 04 May 2024 14:17:39 +0700 (WIB)
Date: Sat, 4 May 2024 14:17:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Utkarsh Tripathi <utripathi2002@gmail.com>, corbet@lwn.net,
	akiyks@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v3] kernel-doc: Added "*" in $type_constants2 to fix
 'make htmldocs' warning.
Message-ID: <ZjXhExdIpDu23Y3K@archie.me>
References: <20240503182650.7761-1-utripathi2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MK4xn+smwcKRqZrj"
Content-Disposition: inline
In-Reply-To: <20240503182650.7761-1-utripathi2002@gmail.com>


--MK4xn+smwcKRqZrj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 11:56:50PM +0530, Utkarsh Tripathi wrote:
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index cb1be22afc65..58129b1cf3f4 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -62,7 +62,7 @@ my $anon_struct_union =3D 0;
> =20
>  # match expressions used to find embedded type information
>  my $type_constant =3D '\b``([^\`]+)``\b';
> -my $type_constant2 =3D '\%([-_\w]+)';
> +my $type_constant2 =3D '\%([-_*\w]+)';
>  my $type_func =3D '(\w+)\(\)';
>  my $type_param =3D '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>  my $type_param_ref =3D '([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>=20

The warning gone away, thanks!

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--MK4xn+smwcKRqZrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjXhDwAKCRD2uYlJVVFO
o751AP9fBDG7Usg1VtPWsrMMKjw89VtmkrfYeE9bjVJCLG5cSwD7Bo12xCxeaprJ
NJTShYCz1OIAf0ws8jun+m2Qu0buWQ0=
=zAKi
-----END PGP SIGNATURE-----

--MK4xn+smwcKRqZrj--


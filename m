Return-Path: <linux-kernel+bounces-188317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A6E8CE074
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60381C20E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5139FD4;
	Fri, 24 May 2024 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDNihhaB"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864A28E3;
	Fri, 24 May 2024 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526085; cv=none; b=ciuJ07T70s58Il8YzTCoHJFu6cMkTxKmSEBJvbthiFu8ZmaUvanPkq6m/a3igaOqeM9CmWn6yd12rF7RX0oDL0A3jRNYIFU738hj/9San/jzJr77yzCoiwFMzNia6vxaGkQYFfRIzrZ6qKbid8lZRiazZ9TGlfsUQUxcC1dyY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526085; c=relaxed/simple;
	bh=JHlAFuVHHupjqfSPzb0L0lQNXH+CrBtA7lb766b1aOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH2uq5QuVBSYW0nMuEBetbQFHGhJ8LCGBtZIGP0S9w40BWnJRUqjuoA39SbYFhfOa1CxHcfP2ibBRbw+MNLPjubCnAPOSC7k423rCJS05/CBzpKy7a9dQBqkJ+HeuvR5GmItP8KwWuHi24UPOFxGy7UMXFGod+6M5sfupgpnBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDNihhaB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2bf59b781d6so475862a91.0;
        Thu, 23 May 2024 21:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716526083; x=1717130883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpI8w7HA5s7CGzkYjIe1gFefxklkIAHGAMzGmPuhWSQ=;
        b=nDNihhaBfXSsd/3XQ4kMu/ssMy2w1TVVhu2c+NFDPI7Fxuun7zmHMpofQGZvdKx3yr
         KkXziKydPRYM2HL+CeH/cHFGMfVbLHM1fcWOCvebv8iaLcKmcjDhbBQcrm+2V+5c4IAQ
         H1iJvWKpGcmhG6mrQTY32gsoQe4gzbP+/SGsTZo3svpjsocjn7lL3cFGcznrt5hRr/SD
         BoLAldEMNgj7D2Pk+YtxheRVkkugpaSjXTwISY/9iwAx5OoJ2669lrytpXXsKtkydCLx
         JuyHUkfQu6PAqdGl+kt0KrNouvbqA6QHA1y32mCY7zqB0sWq2yG0TeyNzwLugTr5sZ9F
         VgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526083; x=1717130883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpI8w7HA5s7CGzkYjIe1gFefxklkIAHGAMzGmPuhWSQ=;
        b=QLJSyRWZaRnpwDp8nf1Wsrrt1+fN/5x43y3MnlnC8qUkKpNPyTDDXIerVdfglL67Y5
         LGKYvKQB5Nn6Oyz/Mrn0W0AnboacXxHK48x1h/Q0H+wmVEN/iEjx1S/iiYHvyjex/hnZ
         0SXBPTc1vQw2qMbXrNFVjdDM0nHzThyrnPSEUBRXorQvG3CfNXW/Y1mkf4GalWAAxQ6x
         MHzBMYC0qQ626e7oUys+sNBj1Jf592RWyI1f0y7F4SlenBCeZzhhbczZ87ovkH8r6oZO
         c5gWB0L4pC/kSRgNVnMIOnWytVshoOm3lawrsE4avSZz1c8T8vVD1LmTJV3szfjMV720
         IMIA==
X-Forwarded-Encrypted: i=1; AJvYcCWv6YSbk+OSD4QJ/VlFjibMXqpaYgf6cPABF1JlvOJ93LJh0c79WCZ83hYdMRnHN3dE1a/fWt0Zp9jysl42PwLxPD2yg0E+lVlRvZ6Lvx8JNSbzWfdG77G3+DDy//c5XdJuqBuC
X-Gm-Message-State: AOJu0YxDGfSLZOsuJqb4jBd8JIKKAFx75xrPPERIBJKy/1nDkbYIEfON
	X5DHwZIDDL18bDl0PlxhNpXs2wAv2qg2J32+DfDZdxlqJ5OcDW/m
X-Google-Smtp-Source: AGHT+IGSwipV0BTxyla45eLqcSZPIaUZuqB8z2DVVK3gxMIMe1PpJFyLm6brKsGJgAyHLJKH8QyjLw==
X-Received: by 2002:a17:90a:db90:b0:2b4:32ae:9932 with SMTP id 98e67ed59e1d1-2bf5e14a08bmr1125838a91.17.1716526082509;
        Thu, 23 May 2024 21:48:02 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f9b38fasm485622a91.47.2024.05.23.21.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:48:01 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9781E184799CC; Fri, 24 May 2024 11:47:58 +0700 (WIB)
Date: Fri, 24 May 2024 11:47:58 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
Message-ID: <ZlAb_rGP6sGS5K9H@archie.me>
References: <20240523130330.386580714@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gp24Hajt84rvAMGj"
Content-Disposition: inline
In-Reply-To: <20240523130330.386580714@linuxfoundation.org>


--gp24Hajt84rvAMGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 03:12:45PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--gp24Hajt84rvAMGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZlAb+AAKCRD2uYlJVVFO
o8v5AP0R37rL5TXxn2u6/rZn9N1nSDzdsutZTdwXbGHHt3S2ywEAn9DYrApyjahe
+b8kkaOoPdrFTHaSVM8vJR756o8aCQ8=
=q8Md
-----END PGP SIGNATURE-----

--gp24Hajt84rvAMGj--


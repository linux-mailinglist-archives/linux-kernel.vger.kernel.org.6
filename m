Return-Path: <linux-kernel+bounces-573404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C266A6D6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E6F1649D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E9C25D8E6;
	Mon, 24 Mar 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd1B2s98"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69221EDA31;
	Mon, 24 Mar 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806653; cv=none; b=XcVZtQ0lnV+HEW27bgK84YHbqVoiWPN/JSCWzDnI+cWxgXVISA0FI0sSbGOLFirKw3EISCQG3alhiwhTw9I7z7WJyvsIT9Uq0VFPD4wuythBzJjjSvq0OEbE3MIDKO6JI2HklN02hM5XX5dC1G+DwUI7+h9owmJBR/UnKK6INu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806653; c=relaxed/simple;
	bh=C6/yEfkndz2CDk4d0RsbI8V539Vra/O0GTJJEpG53VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO5bk+h8ed4lJaAJ5sjIC7BVrSXSeDVUyJXipSQqax24bneOIlul4C5hLUchQiovcIvoNCulfN4z2vkwuivgg2vmBc9jS3fHHdYv+wI819Oii2Fgzj3GbcS2jWdPpjtHf4WCy1dTEJ1MdgXofCRZnvbI3evjl6+aghE+olamjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd1B2s98; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30762598511so46257491fa.0;
        Mon, 24 Mar 2025 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806650; x=1743411450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/Zj1cZv30/oSi9OosycV5woj2gm12NInEWzTH6u8/Y=;
        b=Wd1B2s98Ps8tfM0uuPSwcfMHcEVZ2T1tJAsYsCqYU7RHwkaGjUk5eIXURA6WWpqbD6
         w//THjYF3vVdmDe5b1Qi5NsXXSa6UmGeLJYa5RR4f68GIyWwwuRIyUwyBLs9rnL5B7GH
         0+YsT0PgROUTyEw8T5ZIBLpaJUrD0aD0efkagigSrDyRkwEswdIRNjGfu6vYYyMREr74
         UVCGM86zNbfXI82vi7E96O4AM9V7nT2OLxB0hVFly3JKByCySpz05KkbN/SaQageymNz
         vx/UQB8torVIrBONzSjryVPkbFwSRb25aZ/7PXOp25VtooBgkb+/ne1AlnpqSJyUvqHk
         s7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806650; x=1743411450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Zj1cZv30/oSi9OosycV5woj2gm12NInEWzTH6u8/Y=;
        b=D9tyPcSuiLR8MZL3r5YoV6xEHFThQ240ZQgBkqfX3EjRALSYGXQ4xg8v6b3mKc2kUp
         gYe+Kt7+yOtTBvgxAKMt9F/TJi3TZDok2noi07Mv3fUHvbMac20pi25XCCzK3uOkRmnM
         dAtZONQSILWfk1lwhsfscFaLY7czzTJIWKuZ5bm1x9KrQXWzk7BhAF1kBRN2CMEkGSsZ
         m1cGnvsre3r//EgPpu6dPHAXREuteJVU8O8W4ZJv5Iit0aNA7mj2Xf65R67y1DE/UtGG
         uf2onq+SvEyBzGjibwxhyeeUAbR00p0BN6vBUr19kCAPgK4McFGVlKtk3yjksvufDr6A
         68IQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ytpIzWoaB5MFvsL9Ofgz7lcAcxTjP11/lt8hltS/P72m348JskSL7Z97gclEqx8K24KuF5hfx0cGEGg+@vger.kernel.org, AJvYcCXLo67hJRHM114oYu1zZKzL52SIXZBgPtbF+uGHm/R4aCrrdKJRW1s9HjQm8gvI0G2aEtEqPImXrrkJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvfwflso8aIdFqGeHd00sEkYXIwem6K+OipyPlwNHniraPZQUB
	E7VJu3N2Dt3L36pYmqgPkK5kIGf+wCGW+2vgcX862HrLIdiMRoTb
X-Gm-Gg: ASbGnctY/ud9Gn6DoQxQqMNYfLv3KXgyeIBjDnNAhqjYFYIQz05c4v/JbstojY3bEBL
	RcbjFtdIAMgTtxXzirOb/XJodPJlSrohYnB7GTq1WhPix02YG5Nn+omWVIdFZGp3MidgL7sLaBa
	9ca/NRKvYlB+ffRAWeUJQnZRndrY+6nHNEmix7GCbprUyvcL/iX1UfnFmPKeDEsEnlSDaR7fqaD
	gia7PS/+O23Npe5I0VIg9UcGA7e3+LHtaVwQn0U3i/aI0GTQCdv3BDqkNIaynlVgJTZ0YrYuXgd
	pVDIGyR/8vngTd9wFgOJD/N/7nqfwqJugkdn17r6eSENd/zYy2M=
X-Google-Smtp-Source: AGHT+IFLFySH7Kjf36zdX/FIfmbZ156GlGI6qRhDc3PYwWsnbEAeenjtV51Yxcnk+xavl2fLWhfAiA==
X-Received: by 2002:a05:651c:1a0c:b0:30b:ee81:9622 with SMTP id 38308e7fff4ca-30d7e31a497mr43409661fa.31.1742806649779;
        Mon, 24 Mar 2025 01:57:29 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d910f75sm13094801fa.107.2025.03.24.01.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:57:28 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:57:25 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] MAINTAINERS: Add BD96802 specific header
Message-ID: <6520fe8c59f87190e4186dabb07d9eda3437463e.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XlP6SlZRMuaedgB2"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--XlP6SlZRMuaedgB2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the include/linux/mfd/rohm-bd96802.h to the list of the ROHM PMIC
specific files maintained by the undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> :
 - No changes
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..973f0e06b2a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20599,6 +20599,7 @@ F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
 F:	include/linux/mfd/rohm-bd957x.h
 F:	include/linux/mfd/rohm-bd96801.h
+F:	include/linux/mfd/rohm-bd96802.h
 F:	include/linux/mfd/rohm-generic.h
 F:	include/linux/mfd/rohm-shared.h
=20
--=20
2.49.0


--XlP6SlZRMuaedgB2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHnUACgkQeFA3/03a
ocW+Dwf7BVU4gDnNDeb5FJjoC21nE0eq+jaxRk8hPtCno0IR1IWff2SsDL5/fpK4
ApVabZr0Zq7Y7H2A2iY15ILdWN0xvs0TKU8O9UTiiiocPhtcEyarWt0OmShkhI9y
NgVtEvMsoWt/5aowB86F5/JWv59tJKWIdQ+9oLrGdZlyydXlh4ISqV/nqGdjXzu2
xZ+loQnMCZ3IxH4MMhkxe8ig/hmSnvkyE16X2/etbCsDkBnkaRHfiucpy1ausgOM
AM/MZzoSW79Y/KfhX1c1VeKs7Vrkl2+OajQcGTQa6XFvqEm7jBnHa2hxC6At8wi+
13BFxuNnq0TlsmKpHpEw5uvtWjZ4gw==
=kzwu
-----END PGP SIGNATURE-----

--XlP6SlZRMuaedgB2--


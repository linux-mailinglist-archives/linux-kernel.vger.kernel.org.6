Return-Path: <linux-kernel+bounces-347117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6EE98CE15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1511F21BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEC41946C2;
	Wed,  2 Oct 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm3tu2fy"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A519412D;
	Wed,  2 Oct 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855393; cv=none; b=q0dmAbsc6eamkDmh+iMqk7oh0+nNd2cAiRQsZS/1JGQRxxKVRHetSo11PppLpxhGfPC1tTbfyTBvtkObpvZdlNI/w8EeCYxtT9WUI9t6NccTO6KZJnUjaBCPYoSwVYjD5u4z+T9UecYhVaoraWpBPyoumryjbfDRe6mxPDWJWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855393; c=relaxed/simple;
	bh=bHKherBZIJQ0rf9UpZjIheDMfktZ2mxDX0RcPv7bFjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0kw3iw7WGwlevPbLFzFfCZBTptESNQcjlWNL4ptZxf5AEIvIYzurmrT9iLFoA/Aj7aoM377+bxFona5dVdp2KLVh3zx07WYV5WZLs78pVjTEotkI5hWrR6HfiZBBs2DjGOy+jtUyfStDIK/zqOPww4+jWXXgUw58I+0O2joiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm3tu2fy; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so41787101fa.3;
        Wed, 02 Oct 2024 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727855389; x=1728460189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpWmhulI7Msld3hi9gp2HgczvTxG5GAZGwAH8UaHcsM=;
        b=Lm3tu2fy5moULI4RDklc4AKX6/pd13DAesRm2As200XxUWIZb8MFRWZN9NZMlnjg/u
         cKeoZ0uoqCtpyAIXWunXPWMb7+05bm36zeNACQzWgSpvDbb38ERdCYt1xsBtvYHv/n0K
         V9GGCN9DzU2BPvh7ah/81qae4/LHIxr/Pf24Por+My5BWIckmEv/I11Ww2PGIYxgFCnF
         ZUXJyumBNFmeGNGgGAruxZrPK3VOgZD+SQ4wmxabftiU7tPcLgqn3NEicNKViYSJdwiF
         h58skaOrzO1YAl2KlX1kAGg4Xw6Rwi+TuXgCMDre6cvAgePpiNWxfiwFEUnMi238oFW3
         8t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855389; x=1728460189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpWmhulI7Msld3hi9gp2HgczvTxG5GAZGwAH8UaHcsM=;
        b=ZE8RHr7nvokaCEPi659GC7phtKT4zEhlLpNME7f/Hb9Qf7HW8zZU8grdLh1jzoHp7n
         gQhSpbLvAh7wrk8fMXd92azSCAecCvJbYb91K5pL+QBD1kJogLZVVy3XF5S3j3sxN6l1
         ig+HL7u2RNqc8LdJR12gUtgSNoGUrAJ7crKpBnfFcO7Qhn/QkcB1xwzVXzhBJ0tN7BlH
         kisjVrsmFtpEgqhy7KhUg9pcQjkOXI3N59DRtnvryjzayrzvpo4Pi9DWmV5+xNcvjwhx
         geBLrkA2NeJFrT3l3TBro/jHqzPklbHBmYqZI48hBPyqgxZ98vWbQzoJ+30BQmvlb2hR
         H7jA==
X-Forwarded-Encrypted: i=1; AJvYcCX+hu54HMyGmztuzDIoVDbNLtCp0M2nLiv2EHCbPccybMAauMDgUl5Fv6l5LZXEY6o3CunSn0yWdgy3UqK/@vger.kernel.org, AJvYcCXILRbRuvkbYeMpPtCkGvWswpchRE83aFVSLyk0PetCV6XocDCtE/nIAzQbn9ouDEw/U6RewAfki9OE@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBN4/l24nrx6ILZXzJkVfBp/uesKUqiXaYcfpf7htJGPimz3o
	4SxbyY+JWDNP85/sB4BmT+VLb8n922TAB1S19VlTyYLcmwPuVC8I
X-Google-Smtp-Source: AGHT+IHhov8RkI1UXkOeqc8PEFKDi1iQhiClpEJgsMXzPz5POtDD26bfPFGLmFLSN7vjMrEA3cn9xQ==
X-Received: by 2002:a05:6512:3d0c:b0:52c:8abe:51fb with SMTP id 2adb3069b0e04-539a065ec3dmr1190028e87.10.1727855389127;
        Wed, 02 Oct 2024 00:49:49 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04321d3sm1860966e87.161.2024.10.02.00.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 00:49:47 -0700 (PDT)
Date: Wed, 2 Oct 2024 09:49:44 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mtd: davinci: add support for on-die
 ECC engine type
Message-ID: <Zvz7GDA278Vam4nQ@gmail.com>
References: <20241001-ondie-v1-0-a3daae15c89d@gmail.com>
 <20241001-ondie-v1-2-a3daae15c89d@gmail.com>
 <20241001221032.525be1e4@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lk0Il1dqjQ3kDTVE"
Content-Disposition: inline
In-Reply-To: <20241001221032.525be1e4@xps-13>


--Lk0Il1dqjQ3kDTVE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Tue, Oct 01, 2024 at 10:10:32PM +0200, Miquel Raynal wrote:
> Hi Marcus,
>=20
> marcus.folkesson@gmail.com wrote on Tue, 01 Oct 2024 12:42:27 +0200:
>=20
> > Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
> > Add "on-die" as ECC engine type in order to be compatible with those.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mtd/davinci-nand.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/D=
ocumentation/devicetree/bindings/mtd/davinci-nand.txt
> > index eb8e2ff4dbd2901b3c396f2e66c1f590a32dcf67..9afda5cd956494c6b3171bd=
baecaeb289acd64ea 100644
> > --- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
> > +++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
> > @@ -44,6 +44,7 @@ Recommended properties :
> >  				- "none"
> >  				- "soft"
> >  				- "hw"
> > +				- "on-die"
>=20
> This file is very legacy and this addition would be totally unneeded if
> that file had been converted to yaml earlier. Just referencing
> nand-controller.yaml will authorize nand-ecc-mode =3D "on-die" (while
> still marking it legacy). Would you mind converting this file please?

Sure, I will give it a try.
I will send out a v2 later today.

>=20
> Thanks,
> Miqu=E8l


Best regards,
Marcus Folkesson

--Lk0Il1dqjQ3kDTVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmb8+xMACgkQiIBOb1ld
UjJLTxAAhwmz/MNJlzpTjWl4SPKqPklm4sjeubkDZ73otz7FQlpIIr1Gont3sP/q
jAEWpXLaNaaD64advLi5zJJawCf26etULk1zMb5IjU4xgxKz+to6umsPdebMGMwY
64l4cD6qeTUGtflYzQLQt68RXen/XDP8XV9Zf/S6o8WbZLqyxjtzMFb7s/NJu5yA
kziZknr6F0Jr0ucYqjJyJwtql+lZescz4MY4iR4i2VjtZL8SNYWGPHHZphKQJU0n
byht+9dr60UNPjXVfdtMT+hA+3bRmfXP+xRXArh2cekjnybw2c7kecjxX39nvVtt
72KsVWuHDqGLSWpfnEDIOf+tPDpLD78+e70ZLmZmSEKaR0E2LnhlyHmAVYGyIBkF
mPNFRONHQFicbebsDIQ4Je/yZAkv3HhDGNzZELpy65TxOI/oWgU9I8wz4iTBuSiX
1v4IChntLAEhlATWaRIJ3xM/KgadXBUcmPv1cA9fzPwmxZxpU0DXYdys5QfPBMvE
xTEVYarg11Nflza/A+iDjhYRrlgED7TBfrMGkLaT2j08hXlvjFHmuJ06fffKGe2W
L7wdI7c/eEjbYhfF1WKRZydl60N/YIG0pSuEOaUAcvm25uLcC10iFoHK8HYPs4TC
AYcmpmE2ruja2beiblQRpsgBC1+/Ox5Cymt4SostqV2LJ7/eoVw=
=Xrsg
-----END PGP SIGNATURE-----

--Lk0Il1dqjQ3kDTVE--


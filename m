Return-Path: <linux-kernel+bounces-373224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D17F9A53F7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90CB1F21AE7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D81922FA;
	Sun, 20 Oct 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6AqO5tl"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B9D26D;
	Sun, 20 Oct 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729425721; cv=none; b=Yz4PFgpWCW7Iq+gGaHwjI10dXzc3V90xNI6ueQ0CYHnVpccFRYnzqeMC4ShSfkJn2yWn3mUEDjWgt441LCcelTeeVWewPvk5KpKNFaabCidf3laR23pMcbGgzRmtihvHwc8OyL0DIPfegcl7RjMtTLvgNmQ8KsS3p4PpY3Zt2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729425721; c=relaxed/simple;
	bh=CJwg28XECu74Fs/hhDUm0RW/18pyg8k+3Dg7YRaFqLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ9wKGcPjkabTOlXYmDe79pjY4nodeRsGiFuisle24OGlbZju1xWJQvRwCr9IAlIeS8VnwXy3p0CRDYEM8BBXvW8XdmmgUFntqZbU7pWFTNNB+h1RaaP1smPRKAVRgWKzO363yB47MV67vxtOOEL/e6VODntcoxF8bA/4hkGx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6AqO5tl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c6f492d2dso41271575ad.0;
        Sun, 20 Oct 2024 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729425718; x=1730030518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94ZUlf2trmZvWGJ5nEmxqvLhmynpV8ZWyfpPSRyUfu0=;
        b=Q6AqO5tl7Fe6rHidec7OYYhulmBn4Pp5sAXygit0HkXlxI78fYCycg4SuJp2J3TE5G
         cmhL4fNuz7eQJTbMXKlGNLY4J8YetskJML20xr21JjCjY6aI2bDpGRfkY+n6MhrxJrx9
         QGHIaXlINe3+tGNL80lKmS8XNLe2TxKzDgOrokrQmqzVOw1sifqaQqwt7SXAeyyhojPH
         CIcfQzYRp2s8KfZzugiiyk29Bo4kLAvPsY9CnXsFRBhmPmN4X0vRRjW+stJ6NJqTfIjh
         RVjFan6vbLBSLPgYI4XYRhL7laHpN7ALLHIs8m8hKKTtB2Dly1GhqrbIOM1t1FFvWHKs
         nQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729425718; x=1730030518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94ZUlf2trmZvWGJ5nEmxqvLhmynpV8ZWyfpPSRyUfu0=;
        b=inXJ1u8W0GfAT1z8dj7Unf6yabxi5bFXTA198LVIKSl8qyQwFj8NYy1SyBFFB2ImJs
         /+Eagada6dT2RIsyqdUHKzP/aVQu9kTmOL4fLdDeO7mEQx4vK8UIFbotJ7ZMtOGNEdSk
         ehy9EfGR3ac464EIL5IW/Cw4WKYoEH+hGxL2IwO3MmgBji6uL1Jgi8ptk1mDT7j+3eiU
         qlYcoaSLO55CB3lTvABZt18qYmEvnAYappQ47jzjsmwI2NMMFMLYCUY31521aVTgQylB
         kSmnan3Azt0kaJ0va0YicsYrZYdadQc5vt7Pd54YWIR+zZ2/vL0hg06Ds6e5A3QEpIsR
         GrGw==
X-Forwarded-Encrypted: i=1; AJvYcCUTtTvc04qb5x/obUweHS79FMnCDhPcPq4pmq0QJC2Q/LprqqOgWMWwiDz6Gb/kNZHyZkgMNXinxqE=@vger.kernel.org, AJvYcCXGp99wpn3P7d6jpe9s1qdh7Sv+i+txez/vdaPv8dLwOuAx0gIIDA4cKHhE2RpceWMNS6UG2tSt1n8ukAoq@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxlWLDRZnLvUvDLgMlBQECHEfd/viWTRgjJGovR69tKlMvyca
	pYwcRpLn8EeHwZzg+/redcRv8cILB2/2EY93aBau4P+1JpijOTg/
X-Google-Smtp-Source: AGHT+IFsCuFrvaDcglpGAIfS5mVRQFwXu2rR1PxUm6tN5nLA9B0skCajeWASa3BuN08c5M6r5myZrQ==
X-Received: by 2002:a17:902:c40c:b0:20c:79bf:6793 with SMTP id d9443c01a7336-20e5a70d626mr82789635ad.3.1729425718190;
        Sun, 20 Oct 2024 05:01:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd4bbsm9260645ad.155.2024.10.20.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 05:01:56 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 62BF1437667A; Sun, 20 Oct 2024 19:01:54 +0700 (WIB)
Date: Sun, 20 Oct 2024 19:01:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, perex@perex.cz, tiwai@suse.com,
	corbet@lwn.net
Cc: linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/sound: Update codec-to-codec documentation
Message-ID: <ZxTxMuAhfpX3jecc@archie.me>
References: <20241017073331.70069-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Nrqge3N7uqCWrzy"
Content-Disposition: inline
In-Reply-To: <20241017073331.70069-1-yesanishhere@gmail.com>


--4Nrqge3N7uqCWrzy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:33:31AM -0700, anish kumar wrote:
> Updated documentation to provide more details
> for codec-to-codec connection.

What are these?

> +Audio Data Flow Paths
> +----------------------
> +
> +In a typical configuration, audio flow can be visualized as follows:
> =20
>     ---------          ---------
>    |         |  dai   |         |
> @@ -12,104 +33,163 @@ will look as below:
>    |         |        |         |
>     ---------          ---------
> =20
> -In case your system looks as below:
> -::
> +In more intricate setups, the system may not involve the CPU but
> +instead utilizes multiple codecs as shown below. For instance,
> +Codec-2 acts as a cellular modem, while Codec-3 connects to a
> +speaker. Audio data can be received by Codec-2 and transmitted to
> +Codec-3 without CPU intervention, demonstrating the ideal conditions
> +for establishing a codec-to-codec DAI connection.
> =20
>                         ---------
>                        |         |
> -                        codec-2
> +                        codec-1 <---cellular modem
>                        |         |
>                        ---------
>                             |
> -                         dai-2
> -                           |
> +                         dai-1
> +                           =E2=86=93
>     ----------          ---------
> -  |          |  dai-1 |         |
> -      CPU     ------->  codec-1
> +  |          |cpu_dai |         |
> +   dummy CPU  ------->  codec-2
>    |          |        |         |
>     ----------          ---------
>                             |
>                           dai-3
> -                           |
> +                           =E2=86=93
>                         ---------
>                        |         |
> -                        codec-3
> +                        codec-3 ---->speaker
>                        |         |
>                         ---------
> =20

Sphinx reports htmldocs build errors:

Documentation/sound/soc/codec-to-codec.rst:31: WARNING: Block quote ends wi=
thout a blank line; unexpected unindent.
Documentation/sound/soc/codec-to-codec.rst:43: CRITICAL: Unexpected section=
 title or transition.

---------

reST markup error:
Documentation/sound/soc/codec-to-codec.rst:43: (SEVERE/4) Unexpected sectio=
n title or transition.

---------

I have to wrap audio data flow diagrams as literal code blocks:

---- >8 ----
diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sou=
nd/soc/codec-to-codec.rst
index d77de03cace6b8..23b7df0c89cf18 100644
--- a/Documentation/sound/soc/codec-to-codec.rst
+++ b/Documentation/sound/soc/codec-to-codec.rst
@@ -25,7 +25,7 @@ functionalities.
 Audio Data Flow Paths
 ----------------------
=20
-In a typical configuration, audio flow can be visualized as follows:
+In a typical configuration, audio flow can be visualized as follows::
=20
    ---------          ---------
   |         |  dai   |         |
@@ -38,7 +38,7 @@ instead utilizes multiple codecs as shown below. For inst=
ance,
 Codec-2 acts as a cellular modem, while Codec-3 connects to a
 speaker. Audio data can be received by Codec-2 and transmitted to
 Codec-3 without CPU intervention, demonstrating the ideal conditions
-for establishing a codec-to-codec DAI connection.
+for establishing a codec-to-codec DAI connection::
=20
                        ---------
                       |         |

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--4Nrqge3N7uqCWrzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxTxLgAKCRD2uYlJVVFO
owZwAQDOHxbGqENbW2IvJ41h1dNeB4q/BZzSGM9wEfpQmaeW2wD9H6Vgpdcb5lCR
k5tpwJFUZWx6ceDRzEDi28fOhgjSMg4=
=gT9P
-----END PGP SIGNATURE-----

--4Nrqge3N7uqCWrzy--


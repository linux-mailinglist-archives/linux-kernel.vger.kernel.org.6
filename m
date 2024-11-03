Return-Path: <linux-kernel+bounces-393676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362409BA3EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82EDEB20E80
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA03012B169;
	Sun,  3 Nov 2024 04:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4Z6x0wM"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008428EA;
	Sun,  3 Nov 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730608218; cv=none; b=tnR+VWDUONkWiOlppAM7eUAIHQnblEL7Ua7yUYvwT9fxA+VnY0MoM9HQLwT7E2UxM4C1YQKsvHfcB9mnZj2tVn/VmDvvzwXGij2QmBpkjJJltWzt8bzwqA6t8v0kgeP4GjA4DybWCbAUbVNmcMZ03fRZCG/RRzLvQLI6RgA02/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730608218; c=relaxed/simple;
	bh=UOkJubWVbjUckxAsC3BZst4ninDeJFWztDq1rrPPH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlu0saXOLWTkxsr1Fttv0nl9Vb2XMrDrhRbF2P5MZzypG3yvYGl7GwYyuvGiKeB8RaXFcHvRwStuhYD+Xi12IkuE0QUdBJhHLf/a/fWAkA6ioINIi7JfvTbjxX+RquiOTqc1TWr+wZoBKYmtbEKmtdBqF1JgO34BgOWhr+dMlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4Z6x0wM; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so2354481a91.1;
        Sat, 02 Nov 2024 21:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730608216; x=1731213016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TU1iPo1XNRxyguAsVZx6k45psWdUF0btX9WLPzjyImY=;
        b=W4Z6x0wMfdnfMljMHjP7B3qX5qmN80GSP5pL1hcB5f4kCIQghzLSeBxCFP5BAC4avw
         3lytz9X02nZGCrVVO8uquuRU0q1/3adNpqga5o9vSe0qDcsGpW+q4tGKMUkyrzN3ctlx
         hh4kLs+QCXuhK1s44DNKGshqw2SyH+DTTAqUS5aHn4Lpm2CzGUT8mrSvb0EENGvXY+WJ
         izs2diQFI/yoHB8LktwSi7LOVX0YRXukkhjWQDXlwtIpzgp1BhETjwWIiQWBkhbjaKDk
         Rg+aSCu8RfMNBQDXjdcBLqe9al89TTKJerA2eJMGnTnEgw4C26fwoaZOTczlohaUpfrE
         u6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730608216; x=1731213016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU1iPo1XNRxyguAsVZx6k45psWdUF0btX9WLPzjyImY=;
        b=OdanOEQY8+XzIwECnU7nUplW3w33ybmRwouYIMfnIWi9Q+fyqG8YQT6+N2yoN+Vvis
         0RXQ0mVaGhjlv/Yk9FdFY3sAWId/89/ydyZvXncAssmG+44i8PeiJwF3RvDYXWZCirH8
         hgYVYy+xmWmDUXWP/apKKxViiveRZXCxgDHzIA8gCGkNPje0hbf0yoWpPSzqjTUdIL/N
         FSJIpTFafZA7RWVoB9Y0wahb7JvQpZAzdbnRyWvlrx8FW805SVSd0fagGQsY4T+wlvIh
         HVrAhjHM6LdTBOIfnzEzGrff32f3BW9gSAf/WGdU1RZ9g21woqj9aXEfcli+w4HwILfN
         RR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqCL1a9mkFkwFzYtpb6CCgLFKUjd4JkGWrHtKwhZWXrdokOdo08qHT1+GPmsdE0Qkza/qKHxPFhydR8Os=@vger.kernel.org, AJvYcCX3yPKE3Tm2PzKY2Fv7Iy2mqOU9jIky1cMPglt3QRaCRYO0zPH1L6atRiIl2pli3bMEfMDh9LYYtm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuw3oEQfkUaRQB0Kl57hvJqcbEZ7oC7w2eTP1ykE1WpFiBqVt5
	vq84lzqrJ1diR+VucL9ZU0nB4eYMoD+CW3cHTh28GYJe5hJspAikcqRUdw==
X-Google-Smtp-Source: AGHT+IFauDCpZ+k6jElDMzszDx6vfx9ldpd6UtiB9LWLMm+npN+Fq8uUQnNMD0MippzkzGRD8w9dSA==
X-Received: by 2002:a17:90b:1c10:b0:2e9:449e:d57f with SMTP id 98e67ed59e1d1-2e9449ed944mr11239234a91.34.1730608216078;
        Sat, 02 Nov 2024 21:30:16 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93dac037bsm5827012a91.31.2024.11.02.21.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 21:30:15 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B97A34207D11; Sun, 03 Nov 2024 11:30:11 +0700 (WIB)
Date: Sun, 3 Nov 2024 11:30:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] ALSA: machine: update documentation
Message-ID: <Zyb8U3lSvYP0UeuN@archie.me>
References: <20241102073718.64040-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rt7spwSO33Y0VSmV"
Content-Disposition: inline
In-Reply-To: <20241102073718.64040-1-yesanishhere@gmail.com>


--rt7spwSO33Y0VSmV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 12:37:18AM -0700, anish kumar wrote:
> +Additionaly below example macro can be used to register cpu, codec and
> +platform dai.
> +
> +SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
> +	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
> +	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
> +

Make the macro usage a literal code block:

---- >8 ----
diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/soc/=
machine.rst
index af7bad7ba13455..8788953cd160f5 100644
--- a/Documentation/sound/soc/machine.rst
+++ b/Documentation/sound/soc/machine.rst
@@ -76,9 +76,9 @@ either dai name or device tree node but not both. Also, n=
ames used here
 for cpu/codec/platform dais should be globally unique.
=20
 Additionaly below example macro can be used to register cpu, codec and
-platform dai.
+platform dai::
=20
-SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
+  SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
 	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
 	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
 	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));

>  Machine Power Map
> ------------------
> +---------------------------

Keep the section underline length as-is.

>  Machine Controls
> -----------------
> +-----------------------

Likewise.

> +Clocking Controls:
> +=E2=80=94-----------------
> +

Fix the underline to render the section name as a heading:

---- >8 ----
diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/soc/=
machine.rst
index 8788953cd160f5..bdb9dfc5d88e45 100644
--- a/Documentation/sound/soc/machine.rst
+++ b/Documentation/sound/soc/machine.rst
@@ -113,8 +113,8 @@ Machine Controls
 Machine specific audio mixer controls can be added in the DAI init functio=
n.
=20
=20
-Clocking Controls:
-=E2=80=94-----------------
+Clocking Controls
+-----------------
=20
 As previously noted, clock configuration is handled within the machine dri=
ver.
 For details on the clock APIs that the machine driver can utilize for

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rt7spwSO33Y0VSmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZyb8TQAKCRD2uYlJVVFO
o1hOAP9R9VsgeiB4iKTuCnYoM6G0YPc8VyRxU3OPqb9NEcxGLwD/bQOiGdO8WGsY
rH0ofGPjc0f9lG+v2jNZ9JtN/Bq28AE=
=uLdD
-----END PGP SIGNATURE-----

--rt7spwSO33Y0VSmV--


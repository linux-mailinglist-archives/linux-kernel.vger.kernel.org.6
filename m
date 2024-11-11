Return-Path: <linux-kernel+bounces-403905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C29C3C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B851F21F00
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263C17A58C;
	Mon, 11 Nov 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLDSqv/m"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556F15B554;
	Mon, 11 Nov 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322585; cv=none; b=JTBczxgyLbL8GMQ9vJP2isJ7j/v1RcJgB4dslk/Kpr1MiA53PfRijdb40sfvpbaVpNWuPkaowvycLG+nGLumNYyM9pPLaIrnl+7E53sFTZWgZnz185Fl9ClfqCEpjLjwKSHi1mqw5XhJC64yPlkLe1QsZrTCERgkmLrG0Y5xZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322585; c=relaxed/simple;
	bh=BwQ9j2GDl/1hCk5TWbxqiCBINu0rl8yOHNuJrRUeed8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alPST/3fLvxfai7UKoowMlA/63PAd2eHWxoeorYgapC7DK0/3XdCgGpqtN8asQIS0hl24kuHlnokKcss/6Cjw/jmbLYkcOGFJmy38eI7x6+PS5iTjGrfJjf1zN++LI/uNw0/V1kg2B8j7fX01oiyOoArqusNHQGr1g842LdKvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLDSqv/m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c803787abso35290155ad.0;
        Mon, 11 Nov 2024 02:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731322583; x=1731927383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sd9tR5Govy2G9ckfvVxyx3zB2jsN18XRDCx2eel1ir8=;
        b=OLDSqv/mqVPXEgeUwvi6HoLVVHrPUtbIj/2GWgW9p9XbbDs9rgHt5hWUBt2nsuHSO4
         DZlGf7v6A5vIU4rXWTvu85E9p2W+hPX6za5IOZ2KCqnfVhMjbHJ/S8biNUfl8QGCL2M7
         cnx53+ssTSFwNIusVrTCbTdtCQj89pFtWI9/RdZKCJ63UGjrrAVKlONtou686YhdJBfF
         TCZRDRLGTiVIFl/47r96mlXAKVBTerK39hAOC5YuHvYEDFcJXmurDjtp6BQbytSiwf8O
         MRepjJE735lpq/KtANdtuWagvojLWaQuY+oRBnI7BpsJNfmEQ1X1ssmuVU4XBNZRggde
         Dyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322583; x=1731927383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd9tR5Govy2G9ckfvVxyx3zB2jsN18XRDCx2eel1ir8=;
        b=a7YN9VM6jXVhM3cZoy/3oDE5ENjwIPK+9g+laszpH5Pdc1RkLfDDvOgCjs0cLI01un
         UypKAgKg5Mp6qIZ520mjA/RepK2z9j+qIBYvZ3K3CCPolSTbCY+yYhB2quOj5h52k8O3
         8YUNOvfgLWNwqOF2FxjNWCNYFjeF8RmDCsksOEuxZofdSdiP+4X13DCHZRhJr+wLYF5n
         4P0UYrpNw7UG/uk1RriTjnLwQrHaffG8gIIAckfkAPM5lJDVGOo6Pv//ugIvMpTn8fAn
         nFIG1O3OcHdr3XMW2zc4QHMLfqVlC9IytWNZeM97i3KpLyt2C1nU6tTfwnDkNNL9Uz+N
         ymSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0GPR6ZZj4oGEn44bpByb28LOAasWLVwZ8XU3Qk8t25F86BL6td69OcSL0SmbJ0WksD/4HolnaIX4QkGg=@vger.kernel.org, AJvYcCXmZiO+bpPqXU4mFslNP4gzmcBC5khuJv12uBKRngKkwNx3VdTzgJ5xZX6e+G42Eh9LFGLkxzNwl4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL52JmX3NOTZBVTw69UR4DbqASYKjkROlMzBovrXO9iBQK5LRJ
	8i4ysLjY1XyjBFg/Pjmwa2nwwdI2lsbNXsWqKHekaHSBRiGHej03
X-Google-Smtp-Source: AGHT+IGBeF2/30b+ICRW7AMbuJJyB2s6thTc7CDi93f23isHluxZwIzPAZiF08YXCRIYoC1mB2c2oQ==
X-Received: by 2002:a17:903:1c2:b0:205:7007:84fa with SMTP id d9443c01a7336-211837c3ddemr204820355ad.28.1731322582419;
        Mon, 11 Nov 2024 02:56:22 -0800 (PST)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c12csm74206375ad.251.2024.11.11.02.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:56:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 7376D4231EB7; Mon, 11 Nov 2024 17:56:16 +0700 (WIB)
Date: Mon, 11 Nov 2024 17:56:16 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH V3] ALSA: machine: update documentation
Message-ID: <ZzHi0BaxIEStMsY2@archie.me>
References: <20241109192231.11623-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DOSrT3liDLmmX29u"
Content-Disposition: inline
In-Reply-To: <20241109192231.11623-1-yesanishhere@gmail.com>


--DOSrT3liDLmmX29u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 11:22:31AM -0800, anish kumar wrote:
> diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/so=
c/machine.rst
> index 515c9444deaf..9db132bc0070 100644
> --- a/Documentation/sound/soc/machine.rst
> +++ b/Documentation/sound/soc/machine.rst
> @@ -71,6 +71,18 @@ struct snd_soc_dai_link is used to set up each DAI in =
your machine. e.g.
>  	.ops =3D &corgi_ops,
>    };
> =20
> +In the above struct, dai=E2=80=99s are registered using names but you ca=
n pass
> +either dai name or device tree node but not both. Also, names used here
> +for cpu/codec/platform dais should be globally unique.
> +
> +Additionaly below example macro can be used to register cpu, codec and
> +platform dai::
> +
> +  SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
> +	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
> +	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
> +	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
> +
>  struct snd_soc_card then sets up the machine with its DAIs. e.g.
>  ::
> =20
> @@ -81,6 +93,10 @@ struct snd_soc_card then sets up the machine with its =
DAIs. e.g.
>  	.num_links =3D 1,
>    };
> =20
> +Following this, ``devm_snd_soc_register_card`` can be used to register
> +the sound card. During the registration, the individual components
> +such as the codec, CPU, and platform are probed. If all these components
> +are successfully probed, the sound card gets registered.
> =20
>  Machine Power Map
>  -----------------
> @@ -95,3 +111,13 @@ Machine Controls
>  ----------------
> =20
>  Machine specific audio mixer controls can be added in the DAI init funct=
ion.
> +
> +
> +Clocking Controls
> +-----------------
> +
> +As previously noted, clock configuration is handled within the machine d=
river.
> +For details on the clock APIs that the machine driver can utilize for
> +setup, please refer to Documentation/sound/soc/clocking.rst. However, the
> +callback needs to be registered by the CPU/Codec/Platform drivers to con=
figure
> +the clocks that is needed for the corresponding device operation.

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--DOSrT3liDLmmX29u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZzHiywAKCRD2uYlJVVFO
owsdAP96V6UP1EBcRZGyLlEKuYOhwUs2JOWKbveshD8rM2nxzwEA6D4/9xF27TC1
PUIGCApEI003/4kuCecnkqov6/T8rAI=
=6FkS
-----END PGP SIGNATURE-----

--DOSrT3liDLmmX29u--


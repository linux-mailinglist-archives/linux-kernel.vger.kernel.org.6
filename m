Return-Path: <linux-kernel+bounces-388039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8949B59A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8361F2459E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C96176ADE;
	Wed, 30 Oct 2024 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMNSmnLI"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B221BC3F;
	Wed, 30 Oct 2024 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253076; cv=none; b=DVqmaaQFHj+3MyTf5B4exZnQjUsDhuFLU13vxYOzrPlejFuzus4/4hDC8qEvHTY2RsFDJPuiOiWoVRrv7Jikx2RVsyJ93riVKptvRDA2p3FSLp8AHwL0Tp8KVHv5oWSs4TvsHKr4dX2EHeWBdd/yH93naHbOtX9pPPA7rH62bHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253076; c=relaxed/simple;
	bh=+KCkMqSZb5fd1/1x6f5IdpKcdISEJyKqGpJfjJSrHWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHZv8P12Ny90vquo1p2i4MHyYk177aW6uutGMoQGC/JwTcuFNd3w1d1IMMoeTF+9kat2EEcbDm/PAQoNneo+8bZPAo3de/xTq7rO2t274b3qbRC2tvn8WJ51/ouvizcrTd1Er/ApVN29E3cWnLBMJrO09AQtaJkvRBvCmVTKUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMNSmnLI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so345890b3a.1;
        Tue, 29 Oct 2024 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730253073; x=1730857873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxesgX+wYAB3U6IBjXpcjn6GfiXXTlT14obVwgnZEuI=;
        b=TMNSmnLIlXt/OI6CK7mNZqXvXCWqT6kTUnD5LwEojlm0SaOo7D9waZpckd6oiSXDIC
         qdd/YOLHeI5I+uSWT8otQ5VoVTT/3MfKTgxeLeh2LW5JPmT6TQ/lUsZiKqsFNQrx1KQY
         y4wj4m4PVrQ6l13DY2BibUH4pN5BoXAY1wzrBIhfkaj8xG7sjmmZzt1OVoPhCRG7r/x0
         s9wtMp2Hf9xTznSzhoIGw65lRhPHyG2x4/9PgXn9sjlhv00imBY7YXh0mSCtoSnDBvCN
         Yj6TUAkVRtazF5aeuRWDeOwQbTHAXje6hquNshklMeYG212qxAnfS0mVaKPm/PhShxOK
         FqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730253073; x=1730857873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxesgX+wYAB3U6IBjXpcjn6GfiXXTlT14obVwgnZEuI=;
        b=IWIgSm8bbGC0cYn0g2nBL7dHxgYTvEu6jlkq8EEPZFrU1IqHIoo7dDAYWIyZifcvkE
         KF0ok8O6aqZcKhJfJ7/u9dWO+iAWoZLWKxZTCDYW3d7UR3+/t02GHgcme6b78kwIvwWC
         d1K118n1XD4kaKXNTrVwvF/PSMzDoeBa54yQ0/ie8CqcY0+L5KMyF5J9tim5uE71/0dZ
         oFjIh/9EBxbxZ5s5UHb3x+tiBjJNPQX4B1T20hkPwiLC89e7A7z/C2FNDH3yzdtz1X9p
         UI4JXkuMEzO0PPM2jfvxOOKRRfLI/1qAjv0E0X5mn6FzHhMN06kYlQz6xTk8Qk+eX0CX
         Ae9g==
X-Forwarded-Encrypted: i=1; AJvYcCVe1/hSrOsUJ/UE6aDKDdcDBg+ErXbEQ5qYK8aua4fPijD/nJ/fbibA0WGVsfFPhmz2pNkgjciiL8M=@vger.kernel.org, AJvYcCW4QiIRQN6fUPDmpV/Oye8B7enFYIequwfjgxJqoNnHWOn3Yl6mI/D6acaFQmZrPXNKznU5v8ro0gAKUCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4JnfGFXQiNyuMrHi3n4OXxI7ExqhKz9qCrlAMgXE0VxLqF9Q
	x7TpdHBJF/dFT92lI+S/USCY/DKWfKl/zCfQxV6AVhopa/C4VlSD
X-Google-Smtp-Source: AGHT+IEcnK7flpNhcFMoJZLbFyC+0Hy0DXWmwxPM54b9urzh0h6DaRqWG0yhmDJROiiS2u8ljE76qw==
X-Received: by 2002:a05:6a20:d808:b0:1d9:d5e:8297 with SMTP id adf61e73a8af0-1d9e1f09500mr6619496637.6.1730253072977;
        Tue, 29 Oct 2024 18:51:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720579321dbsm8207574b3a.72.2024.10.29.18.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:51:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F1142492709D; Wed, 30 Oct 2024 08:51:08 +0700 (WIB)
Date: Wed, 30 Oct 2024 08:51:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] ASoC: doc: update clocking
Message-ID: <ZyGRDMFRedPDSaIA@archie.me>
References: <20241029235623.46990-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TxLrZQ7R2wAVhHe0"
Content-Disposition: inline
In-Reply-To: <20241029235623.46990-1-yesanishhere@gmail.com>


--TxLrZQ7R2wAVhHe0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 04:56:23PM -0700, anish kumar wrote:
> Add ASoC clock api details to this document.

Patch title should be "ASOC: doc: Document DAI clock APIs". The patch
description (i.e. commit message) should reflect from the title.

>=20
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
> v2: fixed the compilation errors
>=20
>  Documentation/sound/soc/clocking.rst | 59 +++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/sound/soc/clocking.rst b/Documentation/sound/s=
oc/clocking.rst
> index 32122d6877a3..8ba16c7ae75f 100644
> --- a/Documentation/sound/soc/clocking.rst
> +++ b/Documentation/sound/soc/clocking.rst
> @@ -18,7 +18,6 @@ Some master clocks (e.g. PLLs and CPU based clocks) are=
 configurable in that
>  their speed can be altered by software (depending on the system use and =
to save
>  power). Other master clocks are fixed at a set frequency (i.e. crystals).
> =20
> -
>  DAI Clocks
>  ----------
>  The Digital Audio Interface is usually driven by a Bit Clock (often refe=
rred to
> @@ -42,5 +41,63 @@ rate, number of channels and word size) to save on pow=
er.
>  It is also desirable to use the codec (if possible) to drive (or master)=
 the
>  audio clocks as it usually gives more accurate sample rates than the CPU.
> =20
> +ASoC provided clock APIs
> +------------------------
> +
> +.. function:: int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai,
> +                                          int clk_id, unsigned int freq,
> +                                          int dir)
> +
> +   This function is generally called in the machine driver to set the
> +   sysclk or MCLK. This function in turn calls the codec or platform
> +   callbacks to set the sysclk/MCLK. If the call ends up in the codec
> +   driver and MCLK is provided by the codec, the direction should be
> +   :c:macro:`SND_SOC_CLOCK_IN`. If the processor is providing the clock,
> +   it should be set to :c:macro:`SND_SOC_CLOCK_OUT`. If the callback
> +   ends up in the platform/cpu driver, it can set up any clocks that are
> +   required for platform hardware.
> +
> +   :param dai: Digital audio interface corresponding to the component.
> +   :param clk_id: DAI specific clock ID.
> +   :param freq: New clock frequency in Hz.
> +   :param dir: New clock direction (:c:macro:`SND_SOC_CLOCK_IN` or
> +                :c:macro:`SND_SOC_CLOCK_OUT`).
> +
> +.. function:: int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
> +                                          int div_id, int div)
> +
> +   This function is used to set the clock divider for the corresponding
> +   DAI. It is called in the machine driver. In the case of codec DAI
> +   connected through I2S for data transfer, bit clock dividers are set
> +   based on this call to either a multiple of the bit clock frequency
> +   required to support the requested sample rate or equal to the bit
> +   clock frequency.
> +
> +   :param dai: Digital audio interface corresponding to the component.
> +   :param div_id: DAI specific clock divider ID.
> +   :param div: New clock divisor.
> +
> +.. function:: int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
> +                                       int pll_id, int source,
> +                                       unsigned int freq_in,
> +                                       unsigned int freq_out)
> +
> +   This interface function provides a way for the DAI component drivers
> +   to configure PLL based on the input clock. This is called in the mach=
ine
> +   driver. This PLL can be used to generate output clock such as the
> +   bit clock for the codec.
> +
> +   :param dai: Digital audio interface corresponding to the component.
> +   :param pll_id: DAI specific PLL ID.
> +   :param source: DAI specific source for the PLL.
> +   :param freq_in: PLL input clock frequency in Hz.
> +   :param freq_out: Requested PLL output clock frequency in Hz.
> +
> +.. function:: int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai,
> +                                              unsigned int ratio)
> =20
> +   This function configures the DAI for a preset BCLK to sample rate
> +   ratio. It is called in the machine driver.
> =20
> +   :param dai: Digital audio interface corresponding to the component.
> +   :param ratio: Ratio of BCLK to sample rate.

Sphinx reports htmldocs warnings due to function prototypes split into
multiple lines:

Documentation/sound/soc/clocking.rst:47: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expected identifier in nested name. [error at 51]
  int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai,
  ---------------------------------------------------^
Documentation/sound/soc/clocking.rst:47: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expecting "(" in parameters. [error at 10]
  int clk_id, unsigned int freq,
  ----------^
Documentation/sound/soc/clocking.rst:47: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expecting "(" in parameters. [error at 7]
  int dir)
  -------^
Documentation/sound/soc/clocking.rst:66: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expected identifier in nested name. [error at 51]
  int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
  ---------------------------------------------------^
Documentation/sound/soc/clocking.rst:66: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expecting "(" in parameters. [error at 10]
  int div_id, int div)
  ----------^
Documentation/sound/soc/clocking.rst:80: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expected identifier in nested name. [error at 48]
  int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
  ------------------------------------------------^
Documentation/sound/soc/clocking.rst:80: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expecting "(" in parameters. [error at 10]
  int pll_id, int source,
  ----------^
Documentation/sound/soc/clocking.rst:80: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expecting "(" in parameters. [error at 20]
  unsigned int freq_in,
  --------------------^
Documentation/sound/soc/clocking.rst:80: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expecting "(" in parameters. [error at 21]
  unsigned int freq_out)
  ---------------------^
Documentation/sound/soc/clocking.rst:96: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expected identifier in nested name. [error at 55]
  int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai,
  -------------------------------------------------------^
Documentation/sound/soc/clocking.rst:96: WARNING: Error in declarator or pa=
rameters
Invalid C declaration: Expecting "(" in parameters. [error at 18]
  unsigned int ratio)
  ------------------^

I have to merge these lines so that the prototypes are formatted correctly
in the output with syntax-highlighted data types:

---- >8 ----
diff --git a/Documentation/sound/soc/clocking.rst b/Documentation/sound/soc=
/clocking.rst
index 8ba16c7ae75f44..a1f4b8cb4d247f 100644
--- a/Documentation/sound/soc/clocking.rst
+++ b/Documentation/sound/soc/clocking.rst
@@ -44,9 +44,7 @@ audio clocks as it usually gives more accurate sample rat=
es than the CPU.
 ASoC provided clock APIs
 ------------------------
=20
-.. function:: int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai,
-                                          int clk_id, unsigned int freq,
-                                          int dir)
+.. function:: int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_=
id, unsigned int freq, int dir)
=20
    This function is generally called in the machine driver to set the
    sysclk or MCLK. This function in turn calls the codec or platform
@@ -63,8 +61,7 @@ ASoC provided clock APIs
    :param dir: New clock direction (:c:macro:`SND_SOC_CLOCK_IN` or
                 :c:macro:`SND_SOC_CLOCK_OUT`).
=20
-.. function:: int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
-                                          int div_id, int div)
+.. function:: int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai, int div_=
id, int div)
=20
    This function is used to set the clock divider for the corresponding
    DAI. It is called in the machine driver. In the case of codec DAI
@@ -77,10 +74,7 @@ ASoC provided clock APIs
    :param div_id: DAI specific clock divider ID.
    :param div: New clock divisor.
=20
-.. function:: int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
-                                       int pll_id, int source,
-                                       unsigned int freq_in,
-                                       unsigned int freq_out)
+.. function:: int snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id,=
 int source, unsigned int freq_in, unsigned int freq_out)
=20
    This interface function provides a way for the DAI component drivers
    to configure PLL based on the input clock. This is called in the machine
@@ -93,8 +87,7 @@ ASoC provided clock APIs
    :param freq_in: PLL input clock frequency in Hz.
    :param freq_out: Requested PLL output clock frequency in Hz.
=20
-.. function:: int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai,
-                                              unsigned int ratio)
+.. function:: int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai, unsi=
gned int ratio)
=20
    This function configures the DAI for a preset BCLK to sample rate
    ratio. It is called in the machine driver.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--TxLrZQ7R2wAVhHe0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZyGRCAAKCRD2uYlJVVFO
o9SjAQDmG7RJjJ/Ha26R1ZpiW85CViXDUCqyYx18GQXgmAobwwD+LU81wSkFDMPe
VI9e4paLRJVf+7WATzFQCddlt0UaDQg=
=sA6j
-----END PGP SIGNATURE-----

--TxLrZQ7R2wAVhHe0--


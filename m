Return-Path: <linux-kernel+bounces-356441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF599611E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5154428233A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4098183CAA;
	Wed,  9 Oct 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lUN8gD02"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC017E01C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459675; cv=none; b=oOMViWwobMNn47qiBfFg/rtozEiCyuvTO1wzi1zRh5ufqLDMv2fCe8t98YgXzQ1owQV7jAPTomQsQJ27tFY6/4mw5Uc+jEwByKrQ0eAqaxclZx6NQyX9sI8upPFXU1KGsgLl9jtFRGQfINTkd1j/YrMH2ap6IIOVrTGPzyJrrns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459675; c=relaxed/simple;
	bh=8Om95y4F6es/Wxnlpk2uQdvoXMVAL2YO3FbbfSfgtM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqEluKPDeMkAC+M0OmuAB0v7zk25dKrEMPC0fn9GOCluROUnzdl8Imh2Tid1hA3XKLZ2NvYm1n+GIFsvqjFGr/9c2LaiaxZyi8o/WcV9IRZoVDj57CjrCWzG5RgOKQOsJxMSnAdOp7/eBhNn0mdkx2uHz8Haxf+1VQxTuEvRWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lUN8gD02; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d3ecad390so150273f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728459671; x=1729064471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2viIowtWPbXMalgfD8+O9ZrcVwo57XCKNmEpCFwYjQ=;
        b=lUN8gD02yxE0qRJ8Feslg8hK0KALM8ZjRnAs9aYwMBdFKtrlNDc0b2U5M7u3x5KP7d
         uQgCI5vbIj/4AYO6IVSzUJKNSRZuFzndNmIaEfJClGynP7Nlc07/v1LOvH8/HY+8qbrz
         mARjtAHkX4tpjvd1ewOAPZWIh0gN1vPYGYaMwl6Aply2tTCA24gn85GQwtLDhVehLcJx
         06g+TQrgPfUHzJG6sIDEpZLIIEMKPvMopJrzlF+JG/MHEmjPogf44fn8MRdGtpiC5wF0
         cEII5VQ+5za6iJYE6emU2WzL+usYTkSP7H4Ek1kL9ZotQBMb0jTcSaZ+9+rKsOds2tFn
         4K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459671; x=1729064471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2viIowtWPbXMalgfD8+O9ZrcVwo57XCKNmEpCFwYjQ=;
        b=DtddqnxGMmy9L17Bje9CXYKoJzIAeqMCOcvkADYAngp4k9Sdcxd9OTrFq6K3eVAHIf
         f0Fc21R3qIDAqRRB9t6QF4SXPRKRUQ4NKVL/VV9rjq3FedsFfMp3caad7TMKeO/YwpT+
         lakPuyA2+91UXz379B1AyjnLdVFeu9z25KpsYMy067Zyi487cfFCHq3mLidOl0ByoF4p
         03dOVQ7752biX5WoWmhHNJww9A6ihyJjiiVRryXR5tzvAsPJs+Vx35p8reiMPVgyD9hh
         GQIUJz/5IFrwdVYGOVk29YIPmwaKbvoNJxorFPORA3tXxCIy/J1THN1JmJdmdt5or55U
         SSmg==
X-Forwarded-Encrypted: i=1; AJvYcCVHPbRgtGLr+ZSMbBUgdDVQ4vNj9K+OTVpWcKgXNR1pJtIq7cidl8NazBN66GS6V6IhIDg/QVwCDeMgWLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRdCqqM5Rdf4ZRUK4qr4LOPbe043GXtHUZd/qaNXHNHb6SjBg
	m7gsEFo+awd/MvcFjzhjYVLeN5e54jzdaHFAbt3MFt1xobvU4Ch5oDegml0NfG4=
X-Google-Smtp-Source: AGHT+IEyd05ui1VmLA1rJ5jgdYGapO6L5DJBjVw/NMVD99NroiPJMW7cLe8u+UN9UqCyNM8dGfTC/g==
X-Received: by 2002:a05:6000:23c6:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-37d321ef108mr2946699f8f.11.1728459670763;
        Wed, 09 Oct 2024 00:41:10 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d2e65d618sm3025569f8f.23.2024.10.09.00.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:41:10 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:41:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: kelvin.zhang@amlogic.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/2] Add support for Amlogic C3 PWM
Message-ID: <nrrw2vvhyw2gsbqpne5pgw43yyp4uzkjq2ioskvjjwgfk4ahuo@rryumcqojbhm>
References: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3g32dk24m6nlnxrf"
Content-Disposition: inline
In-Reply-To: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>


--3g32dk24m6nlnxrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 01:48:57PM +0800, Kelvin Zhang via B4 Relay wrote:
> Add support for Amlogic C3 PWM, including the DT binding document and DTS.
>=20
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
> Changes in v2:
> - Rebase this patchset due to recent upstream changes.
> - Link to v1: https://lore.kernel.org/r/20240906-c3-pwm-v1-0-acaf17fad247=
@amlogic.com
>=20
> ---
> Kelvin Zhang (2):
>       dt-bindings: pwm: amlogic: Document C3 PWM
>       arm64: dts: amlogic: Add Amlogic C3 PWM
>=20
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml       |   1 +
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 364 +++++++++++++++=
++++++
>  2 files changed, 365 insertions(+)
> ---
> base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
> change-id: 20240906-c3-pwm-d17072517826

Applied patch #1 to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E I guess patch #2 will go in via arm-soc?

Thanks
Uwe

--3g32dk24m6nlnxrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcGM5EACgkQj4D7WH0S
/k422Af/WeAeMG12qlVL9TxVyfgCoOaW67cCbyllbKGrSYC7OkgI+ujL4WpeqBw7
S0buIREm1V5mtmzXBboD2scB1+QGKalmVSObFXMtgSfJnGszpUViETfwBI9c8az9
oXC9IJSfmF7aqlfugMWcAhrlIZFXEn5I6RMQi8e4fM+F/i83G9aoXVJ6qqQKscr8
uvcpfGZ+hXCdcjPLX2nryNaqNqmlHBk7RYncDYYLPsAnM1gVITTHf0rc/cjKotVj
jcFV+dSSWr8bz6bR8ANt/Tv4reR+NVl3fzmEeQhkWT9gOZEy1YFsnjA+v7L+ect3
+CVMHadCSQx0G3uAK1jTKvVf8PyFRw==
=Njq5
-----END PGP SIGNATURE-----

--3g32dk24m6nlnxrf--


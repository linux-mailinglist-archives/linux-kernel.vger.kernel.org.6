Return-Path: <linux-kernel+bounces-360849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD6A99A077
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE8AB23808
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EFE2101BE;
	Fri, 11 Oct 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N2oTai2h"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD059210C06
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640427; cv=none; b=jJpwkY7+dM0XAuJB9M0z+o3T+yYdiiSSBbrDxBSMlV2TP7sBCL3UwHUdqyuF4AB6eN2l2AwNrO+IcalfkzCaPUA30g/RK+G7h0PBSa60FCDoUvE3mc6dUL1hZNWBzp6wy2MlQg8iXuAf/4Fcbma7aVMyLxcU03B5jhPjbi5Xoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640427; c=relaxed/simple;
	bh=GfsgcdASrrVVCAOWKLvNIl485MePEbKBCmu48vwAws4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVEQpFp8q1A/3Kv9Vv/PEPTcYbFDKzBF8supP9zkOOIxZNIza4hT85QB1iKHD4GKTQInsK7qdHcox8fxigLcjbYYo38nZvh05AdOkI13fiZkqmZRBT2+d7ps0tCPK5Bdmhk+VFaYr7aaU7dRQD3sG+StKY9LkMrpxErLemLnAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N2oTai2h; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso2192804a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728640423; x=1729245223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfsgcdASrrVVCAOWKLvNIl485MePEbKBCmu48vwAws4=;
        b=N2oTai2hKD2WgXpaxrDcEDri+BhKbnuuJUnknEiF5KSRReOE7b2QK6Q5E3LbcMbSfx
         /9kLjwuCyiKIDume40GsiByQ+OlniUM+ruZB1WwfSEuMu6V0E55pBjfK9uprOnnilrGP
         1B/2J+Rq+F04EjfN5bKiOS/s5HN5H43eHDQFx/Xk3PqrzeTMTWoleliDOt4Ug4eptZgF
         l0pD+HiQ5/X2ZIc3/u09WBjM2NKaXccC9iIHASvmWly0HuMLTDE+ZUavzhjTdbf1P5BZ
         hzc6k0DcjZi+WXeyJ0J1eX61uFI3MT9TFAmDDWkDV1Xn/pZ98nzXkuLQLFIix8OJYub/
         HyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640423; x=1729245223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfsgcdASrrVVCAOWKLvNIl485MePEbKBCmu48vwAws4=;
        b=XS2mFpcMGBXiuLP5Hhb1FAhM20ArPRVZSmHZPHFkUk7lWOXKBmEvD0vYH40dONt0JV
         0T91yimbzTOn0YAGVrvHp/JQup71RpUFm+Vyp39ZPXoNHy6CtGvfkkS1o3PMDlwrcSuD
         CJY0XsTAwclQ0pa4noVOIChdfS1vovMfWq8CmB1zNpby56nShhOD7YF5MvntpcLQbphS
         5TmCSFEhMLIiMUpAgMtvhmqAor45hi710AgEaLKe0txYRld8+3+1kdE/ogFQ9FwwAUkc
         8V77lYGwN0t+btFswYKNaV9infPS20/KeNeCo/O9xPTbobCiZS3K/ItwsHsZJnj0xHWG
         uILQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuofJt/rsy2c5dIk/uCxwzeoZ36VF54ULVpUILew+Q1VdAcmJ20F381CYd6z8o15iAelAnuxCEp3JJhho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jDsNRUN6hQeegmaZkfefRCm8AYeFprOk/mzt5tnFtlP/goWB
	WRNTnfqDegTYuAdK3oAcd6KIjktpbQOCXB/MB/LqX5pWJThccaV6TCytJkxoybo=
X-Google-Smtp-Source: AGHT+IGKOAyhqXLqXMmjftfXKaxPCwZKGUYU7lZMROQhqXEgQCUurvbpOhJvbAdcAzF6BgebpAF5HA==
X-Received: by 2002:a05:6402:520a:b0:5c8:df99:a6ec with SMTP id 4fb4d7f45d1cf-5c94754c37bmr1714205a12.14.1728640423064;
        Fri, 11 Oct 2024 02:53:43 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93711ab21sm1737096a12.35.2024.10.11.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:53:42 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:53:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] pwm: axi-pwmgen: always enable FORCE_ALIGN
Message-ID: <4f5hkbgx4rk7je4jhkady6jd7275zkx3jxqi4k6d4evrwk4x24@s6vw7s72zzbw>
References: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xpdkayp5rjupmcew"
Content-Disposition: inline
In-Reply-To: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>


--xpdkayp5rjupmcew
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] pwm: axi-pwmgen: always enable FORCE_ALIGN
MIME-Version: 1.0

Hello David,

On Wed, Oct 09, 2024 at 04:11:48PM -0500, David Lechner wrote:
> When using the axi-pwmgen as a trigger for ADCs, we've found that the
> default behavior of the PWMGEN IP block is not ideal. The default
> behavior is to wait for the period of all PWM outputs to run out before
> applying any new settings. But there isn't a way to block until this
> happens (and even if there was, it could take a long time). So the
> pwm apply function returns before the new settings are actually applied.
>=20
> This makes certain use cases impossible. For example, to use the PWM
> like a GPIO to create a single pulse on and off to trigger a single ADC
> conversion.
>=20
> The AXI PWMGEN has a FORCE_ALIGN configuration option that changes the
> behavior so that any new output settings (period, duty cycle, etc.) are
> applied immediately. This can cause glitches in the output, but makes
> the PWM actually useable for most applications.
>=20
> Also, there was a naming conflict with register names, so there is a
> preliminary cleanup patch to sort that out.

Applied with Nuno's review-tag.

Thanks
Uwe

--xpdkayp5rjupmcew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcI9aIACgkQj4D7WH0S
/k5hvAf44d+bQVvWwc+ecDV5AvC4V992qzBOo/7CXeqQJ6xoXDHuNwdrcZ3jGgfW
rT7/kCjK9YTRg5pvkp1up2W+ia4rfTKI5Zy7LRl/kSq6JWR7jIU1M0kj6OOy8sLg
zp52au1VH8P4IkyxWQ049d8hGyhBOa8J6t9tnfEBASXPCdlUhd0+3iuraBXuwC/P
LGZVTzE3ba33RQoyjaYIsgFHRen2PfR2fjhamPHI9a9tOEurLNlOyqpv7o3VcBta
HuYrLKCzOars2Nay5YWoIuWjdaFh2LQEqDftWP1gxh4ZnZ30h4Ts/PGtq6kfLjJg
s/wLoGWHaynmc3j6igjOTqJsVP7s
=Zwp2
-----END PGP SIGNATURE-----

--xpdkayp5rjupmcew--


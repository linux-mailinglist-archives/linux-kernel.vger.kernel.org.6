Return-Path: <linux-kernel+bounces-351580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6A991341
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E18284B25
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52C14D2A2;
	Fri,  4 Oct 2024 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O33HY5vj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98F14A4C6;
	Fri,  4 Oct 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085485; cv=none; b=OqUF81ojvO3tD8PKpHzL5HUqsx1IZw9efL8y7QWY0af+UvNkE+ALZAkvFLpz5HLFfm0elbnR1cZD2D8W4UhhKlMJJzhVLvfwmgiFzJ27mWTG2Y9kycupYqCySL8dzTem/iTSKii3AU6t8Y/ssj5CrrNkOCyuaKJcTZf4d/u1vwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085485; c=relaxed/simple;
	bh=SpO/zZwBSjf3Q5q55AHmxIk5M1/0FtKYET1fT+0cAb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CENYcQjImgdPpyYHFaz/oHm6vi3yEWJ/zc7Yhvqqr+MQD1BJUWyGCROmzVQTUb+SqlhUokEMp/nJDhiAQsgor0TlAs2MW23E+mS4Wf/c83RC8gT4xlQhQJ4sTKArVjCZm7jxA6tnDOXf9vr81Yk4knWRV3xpXhnjrn0BaSkG5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O33HY5vj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b78ee6298so17284245ad.2;
        Fri, 04 Oct 2024 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728085483; x=1728690283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpO/zZwBSjf3Q5q55AHmxIk5M1/0FtKYET1fT+0cAb0=;
        b=O33HY5vjaUO3Hq3YLPLTaad+Bg9Ob7o0p7NFzSnSLcQ/dw6ezFoJWIsGWhbiq3Hml4
         c14z1rN6psa1GSYQfk1l7DXoav5/ag0x51JNM//Jn1aH7PxoXM+YnhKzTsz9OkCYbHgL
         fQlSBcgo6S0K/spFtmGKfNNZOynf+gpsIvQJebPHuWQsyzyhW63Udc/OUm3+ZAhdfnvj
         W8lPZumJPCzlYunVbJweNkKPimjX/J1LD9iys6iuEdd6iqPoLSSReSizY8I548gOCNjO
         22rult1pMlJrH10eTd4quS3QPWMAmCxs13RuCFWZY2HjxLgGS4I9QH4Chp0L4/uQln4r
         09Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085483; x=1728690283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpO/zZwBSjf3Q5q55AHmxIk5M1/0FtKYET1fT+0cAb0=;
        b=bQmEa8zJuNP5sbXCyMZeHIkcbC4P12W5GGhMDOnLzSHwinq3gsV5zF9kQmviGWBAWH
         ft+SRpm6ZE5FzuQ7I0i7zDhPg9I2A3qKv9D+3mCi0XelfUFZiXvpPthjwxV4jYcc17Vq
         BMo4kBzia4fHYgpEe7Jxh/87xLI4jGyqRArUKoeCJ5Y9f0+NbK6kmTHrY6Tz8CgoqGTM
         v8PZ3Z1w/LKHaCld+XlOXDNauHdrQXlzO9ASHqTygWdtvsLsCmP0nydjKx7pvoGuA+W/
         2QV819r5v3ml96VcbM8FMbuRnRjXTsmAuaLc05TSQPO65PxGrPYXsWyak8sqfUW8dKmr
         rP7g==
X-Forwarded-Encrypted: i=1; AJvYcCUsmJeD5oS+3x/Yp6MBAo78MnROAL36c0N32fQ02G6Dq3pmg0Uo6T9TkY3OCnRAnxfn0yRLPMqsgkfDr3xb@vger.kernel.org, AJvYcCUvTZXvOGfwVv5Rvmi8vco+tZVlKgx66cDs1wC9oKBC6ZbZcYCFq+MnhqChILFxSsHA6sUz8XYghnA=@vger.kernel.org, AJvYcCWJhDZiYSGT6kw3TEe2LNuR1QglevfmsOxQXTBQMNN95nrcS+WSY/hMu1aibDosfYrV9Me0gEm7f2K/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sjP99AHeDMbGEjw4+iNMjAqen/PVPteSxco07W0rOdUGBYtA
	tpyHA4gUGDb6uN12VsywY3L17Zxm5McLUcw6Dfvwzi2bdolweaq0
X-Google-Smtp-Source: AGHT+IFM15MphvgGrAhx7X2A+C1nlm/ncINA+fx+b2vwyY8aSwIN+yvAHcvyDhUHMl6Pw78hK0ed7Q==
X-Received: by 2002:a17:903:208b:b0:20b:8ef2:c84a with SMTP id d9443c01a7336-20bff0663bdmr50277645ad.53.1728085482962;
        Fri, 04 Oct 2024 16:44:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b1ab5sm3851645ad.48.2024.10.04.16.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:44:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 298C341406D9; Sat, 05 Oct 2024 06:44:37 +0700 (WIB)
Date: Sat, 5 Oct 2024 06:44:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	soc@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Will Deacon <will@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor@kernel.org>,
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] Documentation/process: maintainer-soc: clarify
 submitting patches
Message-ID: <ZwB95FxdgqAtuc7z@archie.me>
References: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1a1trQhGb4xvmPcH"
Content-Disposition: inline
In-Reply-To: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>


--1a1trQhGb4xvmPcH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:56:35AM +0200, Krzysztof Kozlowski wrote:
> Patches for SoCs are expected to be picked up by SoC submaintainers.
> The main SoC maintainers should be addressed only in few cases.
>=20
> Rewrite the section about maintainer handling to document above
> expectation.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--1a1trQhGb4xvmPcH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZwB92wAKCRD2uYlJVVFO
owDjAQCAqBT6xfOfmpsFrV0KReTF4lm++5Z5wjWziDPTEBNcNwEAuYNYhah94RXs
xTDgYUpDlGAy2q1t24sck949Q6PTFQU=
=UuTB
-----END PGP SIGNATURE-----

--1a1trQhGb4xvmPcH--


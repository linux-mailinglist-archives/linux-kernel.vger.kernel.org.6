Return-Path: <linux-kernel+bounces-386463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E59B43C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C251C2148F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855BC20370A;
	Tue, 29 Oct 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o31f09ah"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDC202F97
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189267; cv=none; b=GBq9XxjS10xwaqcGUWVYSOWdAJAMdDnVljMClA/rjqBhNUJqVbNnDpVvf21RQI1GFQNs0DG2c5m6Nn40ayXXNmgJK6FZQFQI5d6jrA/KGTzDFRfJf7/0jS4/wQOsoQ+C+5n++VK3N1X5qreOb2fVEUDEYyRkFFlftr9cmn0f//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189267; c=relaxed/simple;
	bh=fz7RRww98aR7+TFIOi8xsXZBrEV8mkiqw5q+W3z+x50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwPo9sOiz481xgoslTH/XHt3oymyogCR+rustZGJhZE3BGR7e9IFPINbGdIDwkMeWyjhRGT4zw4I+dqwqh12rgzmV4ZBP9iKpL4S9rhxwYw1ypyY1TyQVy7k7GadxhdU1r3jUqMXXoP37cXTmNgnzSXCi5BTqjMxJqRnUDvQCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o31f09ah; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431481433bdso51069625e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730189264; x=1730794064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz7RRww98aR7+TFIOi8xsXZBrEV8mkiqw5q+W3z+x50=;
        b=o31f09ahPL7oxI9IqfM4TUH9Cfr7UOYTJD08MuVtiLA3JXRfEzDh5hy3FHJLbBpA60
         vf86cbt7KG9RVBfqrqoZRQzZ4QR9YzP6n8fAVRlA96ZIKOowsZr2GEfWR4pA0t97K72Z
         fFelNXsiXURzAp4+56pvnvSETaAGKhc2xaQED3YoAHpBJINQ6eDnXf0O/nvuTbH/0u+T
         Je7J8WPgLDLm/CEf1z3LFT4PK19UNojxCU7RMv0+qgMpCs09xK4f8tti6jueHvgXfcKT
         1M9N6gElthnzx7eVBF6/zo9wL02tFjI5JzWohS2xh+oCi0M/qLRp03AVvQiJa/WcvFa2
         23MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189264; x=1730794064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz7RRww98aR7+TFIOi8xsXZBrEV8mkiqw5q+W3z+x50=;
        b=cwbn41E8cATWTarL3UOaN+an2W86B48UVlk8sgz5Om6DtA/oA/z2ttrJOSwDSVAS38
         lEdBvpixXavNDAGZaHrm3+G0rX0s782c53VRU825mY9IugSHf3cYD/B2VANtemLE+aFn
         cyYSv4cXgG4H9biVRCzLwcSZ6QSK0aZMonCP+E4e7acfg8AZJj54WAng2OSiCfTbMGEt
         QbmS5fR0UIjHFfWisy3m9K2kOTz9mVuiJZQEpVir7v53Aie0swuoKVYI1BwHI/y1tsuN
         3EeOiQfUsgbzwq9uBtYDMNNG2rfC/8WIWA7XYVVLevx3EvyntsJguI5/3n/4OQzTPH1B
         TH+w==
X-Forwarded-Encrypted: i=1; AJvYcCVu2UgsdsqoPtqdZ0qqbSAV/I6L4iE7cqqlO1s39o4P/HbQ1o6qMhzlhEaa+Bj0xtJKBlLYh7Pvq9YA6hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMefq32k4n3QFPZ6pQNlr2PinvVGasLH8G7a9BkKJZAXn+mxK+
	WGgTad63UGcKBq3A51Vd5W7nPuOVoY9ISQuQ5ZsN7gZI0A0kOhw6WJElSF3mZsE=
X-Google-Smtp-Source: AGHT+IHdtLAytGreUBiJVRVj0CzK2hX+LtTYIjY1HGXyXgeH85JAHHDcJqmfe2WqX6/D5uWSIjYTxg==
X-Received: by 2002:a05:600c:4f51:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-4319ad2d6aamr98759075e9.29.1730189264124;
        Tue, 29 Oct 2024 01:07:44 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9294dsm11699741f8f.105.2024.10.29.01.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:07:43 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:07:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com, francesco@dolcini.it
Subject: Re: [PATCH v3 2/3] pwm: imx27: Use clk_bulk_*() API to simplify
 clock handling
Message-ID: <zbtjpemahkpoabonf2td2i62qrlbb2xv7wlw3te752h6hgnsjm@ba7sdyqgbvms>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-2-fbb047896618@nxp.com>
 <7kplk52i7e2nha5ym4loza5oc3lwghifjfk3aut24w3hjagfk3@zusb2naeaevw>
 <ZxfMZobFdBA7ffhU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bgnhgnnffifnsrec"
Content-Disposition: inline
In-Reply-To: <ZxfMZobFdBA7ffhU@lizhi-Precision-Tower-5810>


--bgnhgnnffifnsrec
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] pwm: imx27: Use clk_bulk_*() API to simplify
 clock handling
MIME-Version: 1.0

Hello,

On Tue, Oct 22, 2024 at 12:01:42PM -0400, Frank Li wrote:
> On Tue, Oct 22, 2024 at 08:53:40AM +0200, Uwe Kleine-K=F6nig wrote:
> > I applied just this patch to
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
for-next
> > . The others are still under discussion, right?
>=20
> Yes, thanks. I think 32k is not necessary and need more research.

OK, thanks for confirming, I discard these from patchwork.

Best regards
Uwe

--bgnhgnnffifnsrec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcgl8wACgkQj4D7WH0S
/k6ehwf/fyJogWx9JiTzSrjVr39U4buCC6TCylJbTGIiYDJGRW71DmfsuQ1S8OP7
nsN41Lb2xbF4Gn0s1IgZph5+a47bIwqzDINtl7YJ6Zj4HuHMC3dDE6GNjCi7uHr7
JvWfImw8m0R9jvEPL25ukoSgqFNeBYJHYVssLk86hZWC4ffVePMXpTzGQNVgMxey
LsUqNa65gIVzdxzBETe7bE0qZeidDFssFVBBBT0AduDDbB3NGpD9lb0Qa7Du3V0T
4ci550yhekpPrtartCbPKvFb6cfcOvT/mOdNqhAM12F3g3WOnx8au/XT1TMgu6o8
A880c+BSCnfEAgpF9xctUfVlLQL8Ow==
=EBhu
-----END PGP SIGNATURE-----

--bgnhgnnffifnsrec--


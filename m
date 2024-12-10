Return-Path: <linux-kernel+bounces-439493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D647B9EAFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103CA1620F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B72080DD;
	Tue, 10 Dec 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NDtbtCyE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70D2080C5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830573; cv=none; b=lG0L2XdfPguN32W2MhLkEXDJOYNJzeOaV08CJq+4cwPqh1YA/bwDVFN1YwCtvsx+d59jsl26/zaacZjTP1ZNXFLv9axeROYs/4E9ZJRF7/NrnV8QIXBUQbnh2MKrX0upYR+S0uqOaEJHqUNAKLtONFFJKXasJ42hQya3q1LnAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830573; c=relaxed/simple;
	bh=oaPGkXtDmGIa1Utt4YEVi0gnj9eQn5kXOq7ajCUrVo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWlTStSSnNDROcLXpWF7FRs6TSKgP5bDf/ktiSm9hP8Bcu2cat2HYWhAEvzsdheicnegzd08rUX3LcLVnL1e0LKX6lBPWeDXUPiM1Ep/BODYqFnSgI8crStgYFncgWsbPQqlKqngXYCyFv8Uvn+uzNVzIaS+lWARw1opIaBixnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NDtbtCyE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a2033562so49442095e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733830569; x=1734435369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqKUzXwjX0F7r+Pi0kkbJdiIPF6Jc1OuE2o60vzqu8c=;
        b=NDtbtCyEr6r6lpzHOg/KXedr7lxmsHJMUrSu/Uxt9KuFqj3rrCOPGJVOcwmlzkRY6o
         UABuh+tKfwgTcdVR80nZ2eLpjgUKr/0IE4XWcatrv9M1bJsQEgevVRAHtwv2x3wEBi12
         qYvpUkwQVqPdNVp8XD717kPdTN0xpjzlndOi0TfOEywAfHL2HexIj/6OP0zxXruC7hr4
         0qOA1Mkx/f8iLF5uZFaONGh/TAixHut0krx4XhxWrt/MEnjFMheW0EzSejoH0gbzYpLi
         QrW+I2QLzm8swEqDqno8L788TGjG7G4bYYBj2UjcqniVUO92hZKtCSsJSS9/KXA09Wn+
         AA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830569; x=1734435369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqKUzXwjX0F7r+Pi0kkbJdiIPF6Jc1OuE2o60vzqu8c=;
        b=vEle7uuNPgeA6XICSajVXop9WWKpjWGdw1hOOLaTcY1AY1QHV5bY4rj1fgZ+brVuWN
         VnY0pHq3uMkRuGEu1Kglo0uitqIJ7VESTPXvB2T02HFLgRD7rKORSYdRwLqLcxElXiSr
         S5AwpYQHBea+szOygS8Y/tcDJwg1n3C1yq+1inrtO5Ag2uaW8eb9wEnmop+LYBv+/SKF
         4kAE6CJgpmc7CLNtUhOaQuSGmzegCVujQfb7I1MOJ/K/ToexnRXUS2gC/QO7lDAguTCV
         q1r1d/mBWWqlAJjTIXXr8Rmo65t6XW6b91mMT1f7+NJY0J5XCNaQHJm/IjcLKrZ5LtMS
         ICSw==
X-Forwarded-Encrypted: i=1; AJvYcCVyFJFHCFCb0bFjv43aEEeEZjdu5c5UxK7FLqecMqSsXYxEjQWVYHXI7cxJTlXDOw8Y9T7tvd5u3yky45s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2U9uaFMFmUJMcU++37hAZTuoJX4IA4kbkA2SWxBgqX2EIAXkq
	XqegAh7iSz2vO6UxJZD7Yu0HgxNR5Z2KKA3/f7xJdv25q2Ah8E8i3/bEKzVBC7c=
X-Gm-Gg: ASbGncsy5f2z7k38ReQ+b/fgwwEVg/T0PWhmKMqG3mOdQ2Z0lqHFzhSnld8EIeyNsw8
	YLbgtxF3m5Hc9NmLkp8N2Fq/wqVhWei6Gsri972pEGSskCqQ90js6FO7fmjJ9pSN8JjF8pWjn6u
	/2MG8RsrdHww4lcnDKH4njJ7kqmmA8kowZ5RRZ9vOhgxunKx30RhT2bVEvjg3DfsKRmKC65YiqB
	G4axPYYzranrboE5+gDW+EezlY7OOvo228Wn9/yfiLseoukC/5as3O2eNj4t1Rf+7BwafYn94Kp
	smryWe0+
X-Google-Smtp-Source: AGHT+IGh7g2pVXebpfQV4PmKNUur7y2GP5+AqT7SSiHWrmQPOSvjOJ9wNL9tjTeTIPE0PA3lkSPX8g==
X-Received: by 2002:a7b:cd15:0:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-4360aaf8122mr11447515e9.20.1733830569176;
        Tue, 10 Dec 2024 03:36:09 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434eba653a0sm113983275e9.22.2024.12.10.03.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 03:36:08 -0800 (PST)
Date: Tue, 10 Dec 2024 12:36:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Andy Shevchenko <andy@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH] extcon: Switch back to struct platform_driver::remove()
Message-ID: <2rfj7ohbduvtnjga4bnmjfb7m2bn7j7nnjhvakr63mqf2htzvf@n7wrknk5yfyi>
References: <20241127091036.444330-2-u.kleine-koenig@baylibre.com>
 <CAGTfZH3Lv1Cn7dNgA7GL6f4OW=ENXS9mG+p03NAUbbNMg05DtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tulza6hxfbxjqqub"
Content-Disposition: inline
In-Reply-To: <CAGTfZH3Lv1Cn7dNgA7GL6f4OW=ENXS9mG+p03NAUbbNMg05DtQ@mail.gmail.com>


--tulza6hxfbxjqqub
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] extcon: Switch back to struct platform_driver::remove()
MIME-Version: 1.0

Hello,

On Sun, Dec 08, 2024 at 09:49:16PM +0900, Chanwoo Choi wrote:
> On Wed, Nov 27, 2024 at 6:30=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extc=
on-usbc-cros-ec.c
> > index 805a47230689..529ac5898e38 100644
> > --- a/drivers/extcon/extcon-usbc-cros-ec.c
> > +++ b/drivers/extcon/extcon-usbc-cros-ec.c
> > @@ -525,12 +525,12 @@ MODULE_DEVICE_TABLE(of, extcon_cros_ec_of_match);
> >
> >  static struct platform_driver extcon_cros_ec_driver =3D {
> >         .driver =3D {
> > -               .name  =3D "extcon-usbc-cros-ec",
> > +               .name =3D "extcon-usbc-cros-ec",
>=20
> If there is  no change, this line is changed.
> Please don't touch this line.

I'm not 100% sure I understand what you say here. I guess you oppose to
fix the coding style as a side product of my patch.

Note that it's probably easiest to just not apply my patch as Linus
Torvalds fixed all .remove_new in his tree generating conflicts if
subsystems take similar patches.

Best regards
Uwe

--tulza6hxfbxjqqub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdYJ6QACgkQj4D7WH0S
/k7MeggAndfpB9zUQxBfBWgzl0ledQrTVIXFgRRuBtLVgRKnIgoINvwEkDoXYGzN
K5K2+PBUpPAsJYou7fuYCLbwDzgZZSqM1VWqrTerFkewCisXRkRL7myI4a7lSrX+
4TeYdGeRc9Cw4JDKnatMWGhLWKd5jI8YIQFhGwlAulaXs2jFa2I3ms8D3efs/w35
6wobhFbFA9ejcwBNs92teAYD0iuKqYiU6DHmguGnBLRYbPsFzcOg8egRmHoBfho1
UHmFRUdFmFoHIilSSgtNXER/hNrtCE2T5HRuAwv87+tPi04mBXCGFoemIkB+ojmp
YLqZkPtoX2Hb7PdpZG4X+loX/0u5OA==
=VQHZ
-----END PGP SIGNATURE-----

--tulza6hxfbxjqqub--


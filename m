Return-Path: <linux-kernel+bounces-225896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BCD91370B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 02:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8EE1C212F1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD8E2F46;
	Sun, 23 Jun 2024 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DF08ZR3l"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724E81F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719102020; cv=none; b=Gx7/bE5wZ3s540T8aD2YsyPyYSOBRSr9A6GyysQFLXmWElXz8IfE6YRaE3BUA5xxK6j/NIiAjsGwVrdqcSrBFqNSFxQxKbxberHnbkBaYmg6AtSJblRvNBkmlsH3Xt7m2xiaGhgBBXqc+XY5cyPVIUyvgdMIovz/RfpmuRBwYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719102020; c=relaxed/simple;
	bh=46BSqqvy7Y6F7xIkfaws++IANCV/SaTAN+h9yATNqCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPRaQ7xeaFJAlKy5ns1TaG0risdPhAtVi+8ksnMRNgsEKpHFjjZHvhAnsHinEr272rSoEV2aBZ9dPOU1aT5axRbLAJ1c+waRsjfq7tPFiywHkbGiHpsa/GZ+am+i1M0VLXFVpE2K+JARTeRJ5a1G261dlIcwCMqgbPq0/msRkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DF08ZR3l; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a724b9b34b0so3707866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719102016; x=1719706816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ONa3iSOONrUQZrCElWDntgf1TBX/gIFjmLuMwiVxBc=;
        b=DF08ZR3lblp7FfWQRNa7T7PYA9tquywswatGc5RTLCRAAJsivoZpjNE/EwQAvLSYv7
         mew54nQTLlWgFX8TSUsCtiYdiTeeB+mcDrIEroFdKzhiHdyYcYdq0pIr4zI9DeLp7tZi
         rhdBlVf1KqqnMejzV4XWvOlcQawfVKAajFFwTw8REAuVIJ86MaDzeYiWXJhy4i7wVXx4
         COihuZWCI74may8UtmJx/NYBQmYlbpivpdll3LimiC2ajEQxlhFouV0ud2/0SQqcjdbq
         kNNZ9oBqNcEspj3ATCuq42c31Bm5FrtnbienM5hW0YvdgIiwLHl+Nh2bWCNEj78lVraC
         4Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719102016; x=1719706816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ONa3iSOONrUQZrCElWDntgf1TBX/gIFjmLuMwiVxBc=;
        b=BBgFuGjJBtv7KRW+eC/08RDwwurRf4ZZMyqw/Kah1qLpkdr8AQoxyN1+7og/v/R7Ov
         pq1H+kANWxfBNoGXkFfrFZ5SSTMCMw/L5Y8x5WaNSlTYFb9DdeQKGMdCUoiqQYAGIfbg
         589DWYTM1YYOM4wkDvJMUYOoOZncSRnoKEYv6mgi+m1KTTLEV3A2uu2CM/Q0BoBgzCYM
         iXaS1bSYAR8BvnNk8m3UCwR/bw6xIllqYmtatUGPk+YZhMJgQ6L0Wj6FfwpGNM59elna
         o1GaO4GsgEWaHOl9DMUx8LB9PmqTGI5t335hryjzsJ6Mvf1/aNBaCeSuEUymzUlYWZRS
         vmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNcmrpkNfZye8ovEOOtXnsuE9n5p1sGsptB8AWg4F61melrNTphqqSiGV/Tgw1eagepMVcOIm4qimESSPmd4lLTqt7zoWqNxE5wKG7
X-Gm-Message-State: AOJu0YyxI6zd20RgpyUEhR8k+4UPjfde4EIObJ/m8DGxz6XuBPkiyqZm
	G5FQi4ypuxkqWqCGdBsWPLLmrylDfKfowyuYxmnyZ/IgLDQ/6wiRvffKYfAfRCo=
X-Google-Smtp-Source: AGHT+IFkQnTmyYgj3ga+Jr84O+VsTZAb6uFS3rOryfDJPiSyoNjG8TnrDmOAhk+I37PmyQzqrzBbWw==
X-Received: by 2002:a17:906:1d42:b0:a6f:1f40:600a with SMTP id a640c23a62f3a-a7245b938c3mr45943466b.30.1719102016036;
        Sat, 22 Jun 2024 17:20:16 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf435941sm252779866b.18.2024.06.22.17.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 17:20:15 -0700 (PDT)
Date: Sun, 23 Jun 2024 02:20:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Daniel Golle <daniel@makrotopia.org>, 
	Aurelien Jarno <aurelien@aurel32.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Anand Moon <linux.amoon@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Martin Kaiser <martin@kaiser.cx>, Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hwrng: add Rockchip SoC hwrng driver
Message-ID: <6u4bgwemukkpjvregtvrhdarelvy4rf76n5dv5oiclbyh4q7gd@b776tut4a6ki>
References: <cover.1718921174.git.daniel@makrotopia.org>
 <ead26406-dd3b-491c-b6ab-11002a2db11a@kernel.org>
 <07fba45d99e9eabf9bcca71b86651074@manjaro.org>
 <3660160.WbyNdk4fJJ@diego>
 <b0164e0d05d9e445a844ffdfca7a82d5@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dd3zswqm4oau246l"
Content-Disposition: inline
In-Reply-To: <b0164e0d05d9e445a844ffdfca7a82d5@manjaro.org>


--dd3zswqm4oau246l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dragan,

On Sat, Jun 22, 2024 at 10:45:22PM +0200, Dragan Simic wrote:
> On 2024-06-22 22:26, Heiko St=FCbner wrote:
> > Am Samstag, 22. Juni 2024, 12:29:33 CEST schrieb Dragan Simic:
> > > On 2024-06-22 00:16, Uwe Kleine-K=F6nig wrote:
> > > > On 6/21/24 20:13, Dragan Simic wrote:
> > > >> On 2024-06-21 11:57, Krzysztof Kozlowski wrote:
> > > >>> On 21/06/2024 03:25, Daniel Golle wrote:
> > > >>>> +    dev_info(&pdev->dev, "Registered Rockchip hwrng\n");
> > > >>>
> > > >>> Drop, driver should be silent on success.
> > > >>
> > [...]
> > So really this message should be dropped or at least as Uwe suggests
> > made a dev_dbg.
>=20
> As a note, "dmesg --level=3Derr,warn", for example, is rather useful
> when it comes to filtering the kernel messages to see only those that
> are signs of a trouble.

IMHO it's a bit sad, that there is such a long thread about something so
trivial, but I want to make a few points:

 - not all dmesg implementations support this:

	root@machine:~ dmesg --level=3Derr,warn
	dmesg: unrecognized option '--level=3Derr,warn'
	BusyBox v1.36.1 () multi-call binary.

	Usage: dmesg [-cr] [-n LEVEL] [-s SIZE]

	Print or control the kernel ring buffer

		-c              Clear ring buffer after printing
		-n LEVEL        Set console logging level
		-s SIZE         Buffer size
		-r              Print raw message buffer

 - Your argument that the output of this dev_info can easily be ignored
   is a very weak reason to keep it.

 - I personally consider it hard sometimes to accept feedback if I think
   it's wrong and there is a good reason to do it the way I want it.
   But there are now three people opposing your position, who brought
   forward (IMHO) good reasons and even a constructive alternative was
   presented. Please stay open minded while weighting the options.
   The questions to ask here include:

    - How many people care for this message? During every boot? Is it
      maybe enough for these people to check in /sys if the device
      probed successfully? Or maybe even the absence of an error message
      is enough?
    - How many people get this message and don't care about the
      presented information? How many people are even annoyed by it?
    - Is the delay and memory usage introduced by this message justified
      then, even if it's small?

Best regards
Uwe

--dd3zswqm4oau246l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ3ajoACgkQj4D7WH0S
/k5WAAf+ITFdGqdN406tmIfhUkT/VVsswv7UZYQ19nee0y/e08Hckgmx/mEmS4ft
tJsOL0GAgMDpyvbgz6smWIgOAzsdln+m73wuSjSe62fHLUgd68YA4ehtQ3EghbY4
Ey7cYUhVnjJFpahWN+b4QS774FfeFRTtRUzdU9ENsV5pRenbmERcKnGOSQ15fwfE
mpqgcAnKvcz43qhHjJpgaJ8p41IQQRWh3jAK3edrnLGjcAAIhynSWzwRdSOYR9QU
aLL2hb1i8mFNkAr1q71hM+pqGrJZ6gQ0gAI/t1wP6/S0OG4WkYs4TpG0xjJq0TN+
N8+bGnosWqTuh5Wt3I1924btUX+e4Q==
=KN/a
-----END PGP SIGNATURE-----

--dd3zswqm4oau246l--


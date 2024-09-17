Return-Path: <linux-kernel+bounces-331851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3397B1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E871F25734
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD21C9EB5;
	Tue, 17 Sep 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dzNROLnS"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C31C9EA1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586166; cv=none; b=pV1hMNGQ9cn4NoQAoCO/la86/gFwF10oA3pg9C9LJ+3hcCbrh4F4ZEYmZHJ2+nB8sJPQADzwm9plQCLqVONo7aERaH0uWzn4Nk0Mmf8zmZhehulfTVY6eLOHuTeN2vM0MCsLuY6idmJGzNgm34aCRUb1sUO/T6onNm17NojoE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586166; c=relaxed/simple;
	bh=BHulxewA/TznO0Vd1SKpkcERt7nE9S/q+tUe13aDxgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkfXOLCsndcTRdM+VLk7W9nxPuW12ditxnYlNRvvFwpV/TtBw9XYGKY5aJj3fhe/UxkVp55KhfEHgDQ1SYdQToV7RJsXKkCocUZLXmU2WrJKuB0gLSm/82TnRqNG6Gq61lfkBnnFTVA2uCWXuiJC/WdP7JfxJY9R/Xkw/Oouc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dzNROLnS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so683955466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726586161; x=1727190961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHulxewA/TznO0Vd1SKpkcERt7nE9S/q+tUe13aDxgM=;
        b=dzNROLnSc8xG6JZXuCXmlnvrXRuoGMzudMpWHui8f6ASxlUXBllRMz1JYrOxamY8uD
         NOnZ6kwTHlY8BFNVJfyqVdSDOmwK0eKaxbHSmMN//9krEvwBE7o6tUdlr5rHcUCVyM5r
         IHZp11lYaeEx05iCzqXsuapNnkGr5TvJYpo87ZFoXVv8PLsseINouvpVOpF1khYz13ui
         uw6B9MidW2bK64I7cx2hZ7o018VLmDUhDV/oVUpnuCzPDzsvZor3xViUaOG8p07BQHGe
         WGsyYSJU5BgbXqTr8uQiH8EhN4A3xj6QUl1dA4GqFgTZMk2ip3Zv3QKrDYwJy4BZx2G1
         O8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726586161; x=1727190961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHulxewA/TznO0Vd1SKpkcERt7nE9S/q+tUe13aDxgM=;
        b=JUlhT0OgBl2Ct/EPfw0//Uj/25f0NCmF/i2tW0SgBe6Fo7NdThZhE9eCmkmT8w7PiB
         9yTtlv7Ai1+l2rQ2Gbftmpxpar1UG8Cz3+WJnDWEirNSY3yWtxn628P+RhgQmbo4EWZ8
         O5VK0fqA1VTL9tb9eN9i6+y/J0HFLx08qGNweysvnGZnTG29Mx+DrK0ozt83mg65Hlnf
         1ACDVZRp4Oplhc+vApPFyYW+KVYfSuNnl1/1M/ZsdfkZEVOCf5h4pEO1FogcLHds5GkC
         bRKHCjyLF//mUOIrFPvh77+onySdMgWiTVY05CKSCqqlu4LfXwqelZddznhfBW7ULT9C
         ppAw==
X-Forwarded-Encrypted: i=1; AJvYcCWSm69Klo9TQ8oXyk4QBUBE33Nt18YTZEegxN4MGdP8SVtPzHGkv6XWSbsGBEZji/xRCSJov4qdjTbsqpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mXzu2NFG1MKe8UeMXN5Ni7NtdBozSyUDkwpFOQLxjcNiLkcq
	HS2m3Ek5CrRiydB5HIUebkOCe7V32+3MTMuaOMjhjAPZxr752b7seZDh4c5HCZM=
X-Google-Smtp-Source: AGHT+IHPEVRV5SnmeE41rHg/+adxtF9yuzVAFT0b91fKlCbyw2kCVFjjFxtULs4ctjtIniGFRmiG0w==
X-Received: by 2002:a17:907:3fa7:b0:a8d:5472:b56c with SMTP id a640c23a62f3a-a9047ca91a1mr1827350066b.22.1726586160558;
        Tue, 17 Sep 2024 08:16:00 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f440bsm459801366b.86.2024.09.17.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:16:00 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:15:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] pwm: atmel-tcb: Use min() macro
Message-ID: <ctq63nbymavhh5ikg4zycoq56h3wmp6zhucqsjrbkspmf2b7qc@asldgk2z7jku>
References: <20240827075749.67583-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozx5bdkryl6kxbsb"
Content-Disposition: inline
In-Reply-To: <20240827075749.67583-1-shenlichuan@vivo.com>


--ozx5bdkryl6kxbsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Tue, Aug 27, 2024 at 03:57:49PM +0800, Shen Lichuan wrote:
> Use the min() macro to simplify the atmel_tcb_pwm_apply() function
> and improve its readability.

applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-nexxt
. As the merge window is currently open this will not go into next yet,
but I'll schedule it for 6.13-rc1.

Best regards and thanks for your contribution,
Uwe

--ozx5bdkryl6kxbsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbpnSsACgkQj4D7WH0S
/k6q/Af+NQHGFrL/T3ofm5LBinf8ILU9v516yAEw72V+Ifa4JjX2yz8yLo7fjp4i
gBT1dUg6uXVS5ArJByFXCk6dzcl9AuJYPRnr0EpOnQb6lr6S44bb6xVQ0O8UPUHg
uYt18ISsBIsCaOIgNVmphiMq7Uf66LMqSvKqkiUWrZ3pyc/17R6gmdqKQchlDNne
86yv7rNx714M++6LVDS6zSs0AJW7pjv8ha0tqYxh5WMTRtzHmGy+hoGJ01tCt33F
h2uUrhlRW17DPQ3riCTIN2wz13esfOXaBhRoKcC0QAB0Rjym25Nl/GTJgsfApwKV
sxBtYCQBKSIk6kWrD0H12DqvwaKvkA==
=HSkK
-----END PGP SIGNATURE-----

--ozx5bdkryl6kxbsb--


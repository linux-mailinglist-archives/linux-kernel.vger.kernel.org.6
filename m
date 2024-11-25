Return-Path: <linux-kernel+bounces-420640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CC69D7F60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5443B282791
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15A18FC84;
	Mon, 25 Nov 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o/a4d4DR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796BB18F2DD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525172; cv=none; b=KUMjTkOtRtgp304BZfMF83Hu+a8EnS67JyxG9lIN/je85eglacj22NETpV0MQIGDGQVuEBBW7+RZaBAH9B6lvaZHI2vGz8s5STInZPJ3I5+Lss1ubgVSCJZqwotbWRYLJjUo1VjmRbYEX1NN1UqW5uns9pHOYXj6E/rpTNnOmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525172; c=relaxed/simple;
	bh=i7/5FuBcHoE9SvUqJxL6Oe5GghPtkmFolATzHwzINu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u118r3wreWkpPJUoMZ/A+9mPw5ESnY64wxmRooQQSasd+INkOz4EjZnaRZtzKEIy26+ctohgYZbqFIfMec4bRhb6ZcXaks9JFLHEwemiahNdCJrG8MuiszxtIZ5tKm7ymgbyiOch1RDexPIUusMLlSMZRWNF/tGYy67/bal+tdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o/a4d4DR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a099ba95so3655835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732525169; x=1733129969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7/5FuBcHoE9SvUqJxL6Oe5GghPtkmFolATzHwzINu0=;
        b=o/a4d4DRGE/ils80dyfhfT+oeGqmkQCaHualmAD6z6P0WSjwcjSLNEIrEUyebgO+O4
         vKHUe1ucjik7cykuQgtGyGFzBmRvE0BPueGBXSuO1OBtvzzoRwLWfhrfT9/0zLtm7f5I
         02e7UK+dtt0v+mFgZEmAIDDXMpObKRn1DqvRAiuvbW4OIKtkB9bC/DJjBCKEmfSMzpPO
         3W4kuPYk6H///XGvOa9X5GaAi2rSl6pgKp8vl3lXY8Uvue4BQGvb2eDOdXTIpZN9V3iw
         dXzHrVoWav0iB0MahdV2Mq/cKDiBWeUaTltmVqiDNFjskfjJJvZS9eohEsGaYgsO5cGO
         cMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525169; x=1733129969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7/5FuBcHoE9SvUqJxL6Oe5GghPtkmFolATzHwzINu0=;
        b=mvmpOfV/Rl1Y1m+oAacQlhQg0m8gykduw4lufXT5AAn1+O4GJbFuC1z3YvGWelEVIr
         FScwQOginmrpxN74LDqWyxesEvOS/arOf7/sOd6cnZSxv6wr677aGLk9hoQ8qoZy2r6p
         QcyanvRS/4MI5HPWx9C9TYIhdA8XYdggymINoPWoWL2MyCzTJMYrgH84Gygys7P3tNUj
         2kru3U05yV1tNPB9AhtaT0JwQevfE8x8gJk+0SJzclcC96eS0DFFAIz3689xaHW35hD/
         WUu5bGF8cG1e/9xFSphBG6YKZuFINDwwhnSq+H9ncbAHjRsG5142iXGXAMqqS83mvvQi
         RP6A==
X-Forwarded-Encrypted: i=1; AJvYcCU1FDjNNbsx3YpQ3R6QUBvpkfyDKnRB6NKUK4KCV7DnRVqSZn/QQi83ISsAtnbC1FjcxApFL/h1bJO/Cgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dGng/W1k0DdHPZZb3LzsUJm/I6QhNSpknXeVfqSuPvLlDMUd
	bHkQIjdYLi0ZEtspel5kiYMlRmONGc1PGeX+NNBTg2sprdxbwADcSRnNOgl+4gI=
X-Gm-Gg: ASbGncv00B6+r7miMcZdnj/idQlRcN6mrrM4s0atArdD+QXo4tBb4msrsmySIehyVWx
	R46su3tTru0LuJaRWnDTI3k0qJ2c5sqdG+Ie0Jzi9Zvl55SgZaMEmHtYrj+vdf4/ftlkvkEDbCA
	FZrLo4JMpatDfsplCUXwq+dvbsiDapuHz0OY/VxcKMSccSWqmG6deWGxMY/sBx++S1RaiXbuWe1
	GbSD1yxPI/z0z0EpGglDoTrXq+X0db3Q0GkSXjXw+i6NgXwDt47nwfrLSKSlwhyMmc1FKbZqCZ3
	8H9W
X-Google-Smtp-Source: AGHT+IGFzg1yjRJP4Ypk0s7Ng9m9o8l3VLH6bdDDuUjXCCntAcghu11wMzAwi/ewLXzqRxTzEwiSEQ==
X-Received: by 2002:a05:600c:5105:b0:432:7c30:abe6 with SMTP id 5b1f17b1804b1-433ce494f69mr97115785e9.21.1732525168584;
        Mon, 25 Nov 2024 00:59:28 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bdb61sm183884645e9.16.2024.11.25.00.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:59:27 -0800 (PST)
Date: Mon, 25 Nov 2024 09:59:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guillaume Ranquet <granquet@baylibre.com>
Subject: Re: [PATCH 1/2] iio: adc: ad7313: fix irq number stored in static
 info struct
Message-ID: <76myaxinjuupszvwof355gxwqqs75yxupsy623nwrcms2g7ttu@q3vqdwmsp2ua>
References: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com>
 <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-1-d05c02324b73@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gfxeuckeycnj6tg"
Content-Disposition: inline
In-Reply-To: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-1-d05c02324b73@baylibre.com>


--6gfxeuckeycnj6tg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] iio: adc: ad7313: fix irq number stored in static
 info struct
MIME-Version: 1.0

Hello,

first of all thanks for picking up my report.

$Subject ~= s/ad7313/ad7173/

I wonder if it would make sense to update the ad7173 binding to also
allow specifying the irq as the other ADCs do it and just
unconditionally fall back to rdy-interrupt (or the other way round)?
There is no good reason for ad7173 being special, is there?

Best regards
Uwe

--6gfxeuckeycnj6tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdEPGsACgkQj4D7WH0S
/k44pwf9Fws7f9ZbQjVBVRgv/FViyN2nZKsuVRleLmQ9df4mGl/UTGvcTgtibNSu
RnViMuYmuvzwxfS/r9co+WR7NkuELI5scrBCdqwp5O2HUuoa3+LDfPkjJQWCISuk
Z3jcBua8Jd+b7XKRoQii9f0bJVRTK7+x47IJPDJA9NQ4subJQ4+HW9BD+quJ4vXL
EDDfHhZRjpelxRIXE/b7AyoO6QXCzKBUU7C1WKs1LxgSh6/BprVIdjy07tUCtXAV
JepJ0CRARtld2UGonRxUxv8lQSD3XeXhw84Xz4fEwT0zsR8CiKreXeV2SKhmrba4
aVcYPorirBFHYIn8fzTxbyfUonfH7Q==
=zvzK
-----END PGP SIGNATURE-----

--6gfxeuckeycnj6tg--


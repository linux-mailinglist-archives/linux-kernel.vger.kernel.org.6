Return-Path: <linux-kernel+bounces-407359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF839C6C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F280C28B305
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA791FB898;
	Wed, 13 Nov 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2c7RvkJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA51FAC48
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492390; cv=none; b=ClPCBV8hfQLl2fOye9jgw4lfl3No+EToahdbffwmjb3a16sEOGH7yUSU9WSDnASlGLUBDy5iHhEX1X55LqQaogDZ36umBiR8g3h07o3lHy67+QeG8hjwY8dyWdWuJXf1fMdb0uI1ikISRCncYkDGjaBKTwg7l+hj6e7NrY/5vC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492390; c=relaxed/simple;
	bh=xgef7oBfeDTGTKeZLWgpvN3wmKB5KjDdGGTI4IyvG00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHWG2+j2GbjfuDXK0ODuHmtblqrrwlHHME2/sD1EKu1kWdGrJqNSvDi9DUd3sE/O9vVFHIfavWtxPrdEX7QVG3iPFBuDzBGc228riwvK8oGBUdyrVfPC89X3dpleLmZEnJVDoq22Ocgc2hG4e7z5diC5eVc5JaRlZghowKW5WUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m2c7RvkJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ff51b6389bso1542421fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731492386; x=1732097186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgef7oBfeDTGTKeZLWgpvN3wmKB5KjDdGGTI4IyvG00=;
        b=m2c7RvkJuVY3gAXHSg9Zi7Fe/BQGhCfNogGPZv+wByen6/lEj8eHyGoWHRfuMGLEu/
         xGgbSxcOM7i/e/MAatKXPzg7Ilo9ZIpON2hoCZ1ewGBUj+6Q1s3SNiHVcsVB92RC04A+
         gUXdvf8i8CiiGg25tE370W9fHwaa1TLCyYpGH0gzKT4Om0mC+HSLmjtwqyi4tCZatwmv
         4gkyi5Ob8LZ87BpJRdFmwRce5ggqJerszX0m1IBlFzvfdtqjKySxC/Tt9QLuRIN7ogDN
         yB1pM4ztA97TfKrAcBoRUok8s+iFLcP8XA4zowKJmB9WRl6mBrgnG7yk413q7XtBXyXn
         LARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492386; x=1732097186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgef7oBfeDTGTKeZLWgpvN3wmKB5KjDdGGTI4IyvG00=;
        b=VxhkfkK3nPrQgnM7FhTzJitwibO3S3CiWMliOtCKOkHBJhVHn/hXD0SMz9iIdZtXRe
         5XMKbi/jD/wWVu9xX94lFljpYZku74RN1eiqz1TdpAzGAFjCsJM5yKbPvEpf1C372lWM
         jkDmrQWOE2yL7+809zWElof5hmAcVSGDk3S2KehY5Y+GH3Vb4SmfRrXMBZXqPJHRpmjz
         iE34r6FiT2DdrtzaejnFr3lSYtcMomoRpEKy9z4j12ayMDVFkXVmp1fdh+1Ai0+1VaMq
         g2PvCggk/RlpPx1ZlZpOl1k6cuZmWetVbS6sJkXjZTqHck+hJ+JkMLd5g8g+QWnhmRX1
         zdZg==
X-Forwarded-Encrypted: i=1; AJvYcCV3cdWvHGg3oHnXnr50v+q7kDnvkO66rYUYvNfoxk3meT2t9x4oYEvGpPHVy/He3r+9pKwx6ihZM6Yfync=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEJeirzm9Umm6Ya/AZnatW2m0F3A0a3ltz+FJ8jxM6/nkZf9l
	z1n2OL0IQRMPTCO7vA/TsU11sPGPySoOUd9HQtbcmwjnytzHLnRJA+v2pfeKA83wM1USuEuNdP3
	HoGA+hcwo4JJdrsyfu7qE4wA2+8io3lB6A83KgA==
X-Google-Smtp-Source: AGHT+IGoJc8OMYBqsZ+GfZM/vW3RDRxKJPA/vHAMUaHglZtpD3Q52srAbi+H15LRDy9o9ztoSf0lCixShpHMFgjJCsE=
X-Received: by 2002:a05:651c:b2a:b0:2f3:b71a:1e91 with SMTP id
 38308e7fff4ca-2ff426ba42bmr28366151fa.17.1731492385903; Wed, 13 Nov 2024
 02:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113092629.60226-1-kkartik@nvidia.com>
In-Reply-To: <20241113092629.60226-1-kkartik@nvidia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 11:06:14 +0100
Message-ID: <CACRpkdbhy7onqWwW90qU3UE_+nMrqvmX_Kjvdw+jqn=TjX2FkA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: amba-pl011: Fix RX stall when DMA is used
To: Kartik Rajput <kkartik@nvidia.com>
Cc: linux@armlinux.org.uk, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	theo.lebrun@bootlin.com, ilpo.jarvinen@linux.intel.com, 
	l.sanfilippo@kunbus.com, konradybcio@kernel.org, 
	christophe.jaillet@wanadoo.fr, bigeasy@linutronix.de, arnd@arndb.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:26=E2=80=AFAM Kartik Rajput <kkartik@nvidia.com>=
 wrote:

> Function pl011_throttle_rx() calls pl011_stop_rx() to disable RX, which
> also disables the RX DMA by clearing the RXDMAE bit of the DMACR
> register. However, to properly unthrottle RX when DMA is used, the
> function pl011_unthrottle_rx() is expected to set the RXDMAE bit of
> the DMACR register, which it currently lacks. This causes RX to stall
> after the throttle API is called.
>
> Set RXDMAE bit in the DMACR register while unthrottling RX if RX DMA is
> used.
>
> Fixes: 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/un=
throttle")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>

Looks right to me, thanks Kartik!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


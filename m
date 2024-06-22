Return-Path: <linux-kernel+bounces-225705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE795913417
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D11C203A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5016EC18;
	Sat, 22 Jun 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NStbkK5y"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73D14D6F9;
	Sat, 22 Jun 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719061565; cv=none; b=AY0dNqwBIn3iXW5uEpcacCMXBnOFOQmWBGvHiBOEyjmV4Cf2ocnMyOPEpAkYFXu6B7Li/Ov+MwCVr92895rT0vUUBStgryqwbJMJigPHJnCtoljOQFu+2gSXIvxojP5mR51bpyoPsXRt4gJ9pDYXPDI5+7pkFs61vKCfrH4oRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719061565; c=relaxed/simple;
	bh=fZzXD+VBy/TnjHfeespdwqsqQcRvbT0wXeFDsY6VBSE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TmWX0HZF+tUQyEzOGxCLBAMZMkIjs+fzyTlqgrkx88JZcLzN12G9Z6VrZ9MXGSCa9seLDkYMwF/AdYpWeeJ+3HVTjK9Bd40fZXIQb9Ekj48rrY4nFqvEh6htHLil/Qffxfqk0B+b9MAeq6hIybEKsEksnTts8XBU2LFx3Tn/k7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NStbkK5y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-362bc731810so2549067f8f.1;
        Sat, 22 Jun 2024 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719061562; x=1719666362; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrytYasAxCaCe6tWDwhrVic7gXvGWpWw0egqVhOW2rc=;
        b=NStbkK5ytGeESek+B8s2HdJ+5ucrCND7HS65W/UogtM0r5f8IzdeDlyPq4fXExcza/
         GMN5uass+RuhCTpmUmvO82L2GJuhOU054F7h9RXSWOUaAeFwS8FX1Kg4mrnAw+5T9QP3
         lBTHQvNdXd54RRNQ9tylBtcUjr+FXNpYDy1grS3XmV7oz4eOZydu//2GpVO68U3WDjQO
         dv+v+DCQZUM8NJgewJQLHmCwt2+VmXEizFvoJjIMxFwoxhm7VsVn49l7QbebmB2UR4No
         Ol83hhttypMcuT0+QTIURIpEdb89WbMxmhO4JlRvl+yll4Of2zDy7imTgaKdZGVUI2b0
         glkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719061562; x=1719666362;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrytYasAxCaCe6tWDwhrVic7gXvGWpWw0egqVhOW2rc=;
        b=fCPRPZDdXBrxx/yHIbEBG+KaIUfoKqMwfEZamSVTowaNr5xNZOMKMB3NQy+9nmc9Q3
         8egqsnT9QAZvGy4dGooWjITruZQxHNS5hHFPsNpBmxeqozTs+F9wStlqmrLFG6SiCQjy
         KaBiXwzFgtBs1IDspItqrd6TEvr6DBTWVMiqcRmJvPwfB/m5QWZ1Cpm80KKvoNxFZgJ6
         ZkekYFdWtzmb/CCqGV5zrg+Bp+kqolioJhFAMGgw5KtgPA+M0otYNXersg5Lys1EhdWv
         W+Jms2ncBV2oOIzHLGM9CLgSzH1EYEmrakeSbWwg3mJpOfjAscGCUNoP9+7uddJXMbqR
         Rycw==
X-Forwarded-Encrypted: i=1; AJvYcCXC0A/67qOO+U/9oagNcVKKSeGqFhLkR0dhEWIyBTsYzYWbfvq7XzTO+uKYDLNV1fWO5B3zpDJn+GW4uQfJ6vV5alVXKcMhqoxZSihAbMzaUP5J8zARi9okDfvgjigh58ulsyrETMeREaZ8DjWw45Fxkyjk/YpexwJ9i0WM45OCGZ9kq6J2
X-Gm-Message-State: AOJu0YxfjK/tmS1eAd1TzEe2MMVpseZLhv2r2L+ovDvQLWadlD846KHU
	7z2iJWBptKd3oDqq5xbm5WHiPoD3q6MAyf9duRlXS+ecfSvNVDWJ
X-Google-Smtp-Source: AGHT+IGexro+lYSB8P9rFaqT/pj2wNDLwJM8cIt6lN/oXLdliRgMk3yRPZse8PG+bDDqHUZ0S41s6g==
X-Received: by 2002:adf:e6d2:0:b0:362:8dad:c6a4 with SMTP id ffacd0b85a97d-36319990496mr9020616f8f.57.1719061562130;
        Sat, 22 Jun 2024 06:06:02 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6722sm4494637f8f.24.2024.06.22.06.05.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2024 06:06:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 2/2] ASoC: Add support for ti,pcm5242 to the pcm512x
 driver
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <57f0036c-4412-48fa-a6f9-3fa721717be9@sirena.org.uk>
Date: Sat, 22 Jun 2024 17:05:47 +0400
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Shenghao Ding <shenghao-ding@ti.com>,
 Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE6B5FD2-790B-431F-BC69-4429CE26802A@gmail.com>
References: <20240622124603.2606770-1-christianshewitt@gmail.com>
 <20240622124603.2606770-3-christianshewitt@gmail.com>
 <57f0036c-4412-48fa-a6f9-3fa721717be9@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

> On 22 Jun 2024, at 5:03=E2=80=AFPM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Sat, Jun 22, 2024 at 12:46:03PM +0000, Christian Hewitt wrote:
>> Add a compatible string to enable support for the ti,pcm5242 DAC chip
>> in the pcm512x driver.
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> sound/soc/codecs/pcm512x-i2c.c | 2 ++
>> 1 file changed, 2 insertions(+)
>=20
> The device appears to have SPI support too like the other devices in =
the
> family, why not add the ID for SPI as well:
>=20
>   https://www.ti.com/product/PCM5242

Okay, will do. I need to send v2 anyway as I fat-fingered the chip
number in the bindings patch subject/description :(

Christian=


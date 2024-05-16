Return-Path: <linux-kernel+bounces-181332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E18C7A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4892284228
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF61DFF3;
	Thu, 16 May 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z8YZXgUQ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0E4C94
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877812; cv=none; b=QTA8ZKF8dhT42Bze9ICoyMKmW21rqiYGAuV0OgegIjZ7qt86VgnLOzkU46PP5GB1x8lnCefDvlY/Z08UEssk0FuARGoe2aLULXhyXrCsTpY0N21OuNDTtLMj0OfQxGT5gMOutTxCsc7hCciAvMoGnr9qG5YCNfbe10/yvxf/LKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877812; c=relaxed/simple;
	bh=V+xNFFnANtUhU5jsfhfbAvrlBuDPU5hdXCy13zJAH6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiKEfIN5D/P7XpuP74J9kvOl4IykoFMNU4IXDL/FN1QD6MjReC8AReoyw4MESauvOhwCfBBA6NSDm5ZD/OhQ0h4ciRxsILm4moJYg/RGEPVS5YEyEP7skFHYj05mNuOMFLpd5aInlkyzQh2zNzT8jnEoWTFCTGYV01/cTM/bYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z8YZXgUQ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so12048551fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715877808; x=1716482608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+xNFFnANtUhU5jsfhfbAvrlBuDPU5hdXCy13zJAH6c=;
        b=z8YZXgUQhE7bf0xHlKhmZVzncO5Taz8qk/jxie2nTBtbOfwHLYiaoJoflVQQf3Qi6K
         hOsKgER7bjojBvsmF0qUecdvPne5nTk4LUkJ+gk62IT1fnl5Y2Yftd1MhfWTlhUOV9G1
         kDnqVhUrqbqng0KmOERqzqQLzm0OcQ5wA0pL3ItYHUxYDqb9FJGrHy1qK9mtzm2s7gPk
         5mEOLYs2xqCpJD1sAIqgPQxDVZWhJWAkzGI3xLrQMX6WVv3V99XyW9fJnhptj1guEoUK
         xF/f7h8zDCEaxxcMdKabS/TemEV6NQnv7RuA/KLl2t3pz9G4d+i+zH3eyPeUbUOJAI2+
         Wq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715877808; x=1716482608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+xNFFnANtUhU5jsfhfbAvrlBuDPU5hdXCy13zJAH6c=;
        b=iqc3qg9BzE49Njxe68d2DSkl7hbtjgY8+Tg5L9nQ0/GFf4ULKQxZsLp7QYM0d3nYfv
         2GXzTBDYajvY687BzMZ96k5wuEd3ZIAJaxkJcQPGYUu1WvJywWgegSdhTewHZP29zC9T
         lK8uI3OjEPbKxzyknJ5IWupVMQrHL9DH0Q6ux0lZJKC+Y3YKNFsb25BD3SyFP9ddCKVg
         9xyc8sWw8ptMywHU+Lenh9KjcBEirn6TILyiE9AEBJNGCvRJNvseicKhLqtAonniTLNX
         +FTs/5E+O7StZlJabI8MDw12Y+Sm6a9SCxWxctHRR8/KkE4kkYqAu3n9Zm8nEhKUZ+Re
         1iOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq0eX0tbpan8ZgC59hFLyueHmFfBi7amJNzN6CcQjvivgDwMh4htXT2ODqhWqfSTleGDyjcRhuIBmbvBPKaO8CtX4fWym1Y3vu0q2U
X-Gm-Message-State: AOJu0YxcsBtj52RfPeX9yOcfHqstH1NFRbSjKwntSFiqN2Ah1J0M9WS4
	+cixiRUGiuPLmmKa3PGKy0hbeJHqrmZV57yxq849oNBpzKbQ+Tar79AHiMtPF8yAtnpF3KWw2on
	EI4BJCxg656xITytgYSzMPCNd+odW4bkq6sFZbw==
X-Google-Smtp-Source: AGHT+IHGaVneos/R4eScRtYA47Mnik++EhKlRJLGsL79bpCk6oNHbmbT356vHf8dhAzygmD08rORGPQ7fAOEWajOT8Q=
X-Received: by 2002:a2e:81d7:0:b0:2de:1457:9d27 with SMTP id
 38308e7fff4ca-2e56ea3af94mr116091191fa.0.1715877808519; Thu, 16 May 2024
 09:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com> <20240514-ad4111-v2-6-29be6a55efb5@analog.com>
 <CAMknhBGrn+dSF=QJngUWaQ04tAwQf-9wmq0V2OgYS7sFKHroUA@mail.gmail.com> <167516cf-303b-48a5-ab84-173cea8e82f2@gmail.com>
In-Reply-To: <167516cf-303b-48a5-ab84-173cea8e82f2@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 16 May 2024 11:43:17 -0500
Message-ID: <CAMknhBGGYztOsP74YEExG0OhAhMFtjh9Q=x3yAvSK=NQeL5e0w@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] iio: adc: ad7173: Add ad7173_device_info names
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:09=E2=80=AFAM Ceclan, Dumitru
<mitrutzceclan@gmail.com> wrote:
>
> On 16/05/2024 02:32, David Lechner wrote:
> > On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Add missing names from the device info struct for 3 models to ensure
> >> consistency with the rest of the models.
> >>
> >
> > This affects userspace, right? So probably needs a Fixes: to make sure
> > this gets into the 6.10 release?
> >
> I don't think that it breaks userspace, just creates an additional file.
>
> This creates the file "name" in the iio:deviceX directory that reads the
> string. I do not consider the Fixes: tag a necessity. I consider that it
> resolves inconsistencies in the _device_info struct.

Ah, OK. For some reason, I was thinking that it would default to the
driver name if this was left out.


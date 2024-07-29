Return-Path: <linux-kernel+bounces-266055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A879A93F9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3FC1C21E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832A15B97B;
	Mon, 29 Jul 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTpYxSdu"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E315A84D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268630; cv=none; b=hDMz63VVWu6NZMzmgZVpK7RifLntyNRh4kjmNKRHOAP21vfQ/AwN3b+eOVeOVFgFFNxXJbKJF27/UbnDL1022mDU/uMU9FwTCeOpLtKQ66fWhQoEbY5ThPapmf63pAQQFyLezr00b+Iju+6H/wxtapD8NLiulkhZ7XMT/XCdlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268630; c=relaxed/simple;
	bh=CbhyjmepvZ2GQWlE4o/bGvvFhBwaNQx9b3bICGSN68M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MaOiSTwwWsZkOY5NK+WI10n8QnHASs5jcvvjQ4OrgfGLYv7OGEChCHIY+bzvhyR7MOGTCYeSMctTYenAMsit/KBkNFa5CL5L6cu222ZAVHRXLWMVLbccTq7jWZZ+l+0eXtC3MQC/4hv6YQocnYzybOm1liZdajgqhqOi0ZRbyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTpYxSdu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428101fa30aso18202535e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722268627; x=1722873427; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQJQXLHnlv/DKOapoxTHZwq5P+QBGMyJlUyNZAowiSs=;
        b=dTpYxSdubzoZvg2P+skIUyp5G1F2bo6NhforT4WEwSmJnAriHq5flK7pjkGFf/P+cZ
         1TcOQRFK0gh7UV42EsLC/+G66kVOVAdHysLz/AiyqFu7YOGBmroX/ThNWx056zAGpqkv
         LCl1nPlvfLnb8UcN5oS/5kHyxlCOw/ViKXOtxsprK9VJjhWYJIG1oX6MXdSuyUt676w3
         jAeRSB79yNUpxKGaWYL6xCYgD33sM12T2N4KhNyUTtlpF6YYKVCHM2TChcoHxq/kZoHK
         gx/xlthh7A2VbBgnNPjFhZIIPgAum3mob8AvzZmAZ/RQydNuvODCUCYUlwfno0+XaosW
         zhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268627; x=1722873427;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQJQXLHnlv/DKOapoxTHZwq5P+QBGMyJlUyNZAowiSs=;
        b=IvkwRUeEaNR7I1v5Aga9IX+Gs+RwnxW2bgXW5d2nLkr6XjsOHNlxRvTICumj1ZC2Uu
         u5J17Xd0fuZXBShauYMPMy+fkoxYGJ+zH/OsNvJmRu3+Rcu00Y8KCRIthN53AFUY5aMw
         cRkfkVQSvkAsWrwZGdPgLfUUHaJHKWdK/INyDMokbBWJb1GbMKhlh9RRPPtCROBomkZR
         0yPxiGudD6eGxCDCqIykc5UEizJg1+d09JIMUQRfY6T/GOEbZwbBtir5wMX92XL3ImeF
         PatuO+5SagWHD/9ZxJUDDH6Voa9deiTETHD/bc+ySrSWaU+OEOkxXf2qKAEdqwv7k3t1
         dEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqHL2yy2oWnSVccadpV86yOWjpJo2T8septJ8lCa47QxyGxtCk8cnSXEx+c5O/Sw4cT11GVoUU/s3+IWTbSPBCSoTVj516lkyZPU0Q
X-Gm-Message-State: AOJu0YyxVrW5GtzxRiFNPsAqHyLJXMg7rA7oaCTtWifmImNvPjpbrELk
	AKrx+dmPqCQrj7qwtF8uXeiDWjVH0XTnnYVFwuLIA/rY0GYjb7eiNj4BgawYiqs=
X-Google-Smtp-Source: AGHT+IEBBx5LsAEMyoM6oe7rtQrWY0rnpjUL/ghKQBCG5QRwkixQ4Ro9RCrukrZIHEiRAWSLTz45yw==
X-Received: by 2002:a5d:6347:0:b0:35f:10ac:ea50 with SMTP id ffacd0b85a97d-36b5cefc0afmr5637864f8f.37.1722268626835;
        Mon, 29 Jul 2024 08:57:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:abd3:cdc8:2363:54ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3687003dsm12532306f8f.115.2024.07.29.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:57:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>, linux-rt-users@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,  Liam Girdwood
 <lgirdwood@gmail.com>,  Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai
 <tiwai@suse.com>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel@sberdevices.ru,  oxffffaa@gmail.com
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
In-Reply-To: <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk> (Mark
	Brown's message of "Mon, 29 Jul 2024 16:28:56 +0100")
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
	<1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
	<2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
	<1j5xsow839.fsf@starbuckisacylon.baylibre.com>
	<7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
Date: Mon, 29 Jul 2024 17:57:05 +0200
Message-ID: <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 29 Jul 2024 at 16:28, Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jul 29, 2024 at 05:06:50PM +0200, Jerome Brunet wrote:
>> On Mon 29 Jul 2024 at 15:44, Mark Brown <broonie@kernel.org> wrote:
>
>> > I don't recall this coming up much TBH.  It may be that people just set
>> > raw spinlocks when they need it, or that there's not many people using
>> > relevant devices with RT kernels.
>
>> I have not been playing much with RT TBH, but AFAIK, with RT irq
>> handlers are threaded unless IRQF_NO_THREAD is set. In this case,
>> something preemptible in the handler should not be a problem.
>
>> The axg-fifo drivers do not have IRQF_NO_THREAD so something is a bit
>> unclear here.
>
> Yeah, it's definitely likely to happen all the time for people using RT
> with relevant devices.  I'm not sure I have a good sense of if it's
> likely to be a nasty surprise to switch raw spinlocks on by default when
> it's currently controllable, I'd expect it'll generally be fine but it's
> possibly a bit rude to any users that don't use interrupts...

Indeed it is bit radical.

My concern with this patch is that, IIUC, the handler should be
threaded under RT and there should be no problem with the spinlock API.

Adding the RT folks to try to get a better understanding, they should
have been CCed anyway.

-- 
Jerome


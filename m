Return-Path: <linux-kernel+bounces-266004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C1793F914
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAEA28351F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C4157E6C;
	Mon, 29 Jul 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="beeS/0AH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1443156250
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265616; cv=none; b=tDuDU+MsHnOg2UuN9avBcofq/tp4UzrJ1BSJCA30IYifEe9hWLVJi86fXTRBn6hxEMAK4kIVz2moxAfaCQ3W9IK5HRSUHrXk7uGGAQYvD4kVTv3G5rdJX7WAOUxrze4Sxa9s9ysDwZR/0SuD8KUiKst/5rumpSxB8/EPUiMFM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265616; c=relaxed/simple;
	bh=v+fA2sL8PT2aaem3wZ1F4FcLGMckWT4YxfNzqDv1uMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UT1q7Cdifa5HnxNBKn7zkrazsg7PI+Iq3RYLoeYQ5y1bgAWeMcq/pJXr21y+Cjl8Nfm8+hHMspquFLiOa6y9fCfMOULog71YBT0YRA02SmmOd9Twko1X1BUVU8nHhzSedgzWB3pav1wZA7+LhnccpnTqrfdViWiSwjP60BlW1fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=beeS/0AH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281abc65daso11049465e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722265612; x=1722870412; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=orECJ2OhLH097DTMjvI6rJNFg6vz3nlf5Yl6sqJTBIE=;
        b=beeS/0AHgHWiuF54U2Rgz2lh8sjYO1folj+E8zHeDu0pSEwrLEh1dV2briXJ3Jve9h
         zU+cDmJQzsTyaUJ28JKGde29vJ10WYuazMyuzCQbpaCNHCB/RH2w9fbjNEXgckj2atYI
         zSjzNCrsTUahtB3ykUG9NezbMOUysodnoaWU6ISwCL58As50aiekRBteY0Ai1lZ9+FGv
         hGA6JkofM9r/ChKva2+LjzylQfeto4DsWgdZj1Ek5fes6LWr6MNIoV6zzEXen3dquQOI
         HiMA0NMS/nZJJLdtgcc/Tu+kw1qwBymg8pUpIRJan0qtnrVws5xebQ0YBLTxVy8YIV6D
         5klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265612; x=1722870412;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orECJ2OhLH097DTMjvI6rJNFg6vz3nlf5Yl6sqJTBIE=;
        b=xVboA9Ctr45pRSqRBBSygpMsWY9fkD1ByALTOTzqZjik8DOR2L7n809ObHpQhJnYN+
         n8X65ZNMmRXbUjKxdbj7fOjrd8rIYJc2yy/ColTPnp8IXV86zRoSTqowrc9v9wd/QMfM
         Es27CPa0029owGrYPChTK1SHaDg6mXkZQ8hHCL9bQQSxFRw+Fh/CehQXQwo0//fhNOlt
         7miWIzMCSPdJog6HtYIUm90CL1mBhSmMuuPnnHQkPfF3fEkq7S2QbQLTenvICB2qhtlF
         Svp/Ruh/RHaXmCO0GI64/SBvUKF1mrdfQddEccGkcj1DJ6aLHeleELt44v8sELbMSrlG
         p16A==
X-Forwarded-Encrypted: i=1; AJvYcCWMOgSk6I0msLoEaAREfep2QjvlTIqJ/K9ixJU9K6i3LqVA2oEqKk4ouN1l2X/2ImZo8eOGw1G0PQNIbWzg/Rcr9MoBrKgLSHCeCByk
X-Gm-Message-State: AOJu0Yy7yxBWGZozgUa4Ovfy2ww8PtkURLtCueHEYnKHXO5S/rAXct47
	QXl9WDXmMfMVOZKPcM589ht/xQg3MprC3296R7TQ1Nm/19uPH6WirSmfKjOjmFA=
X-Google-Smtp-Source: AGHT+IFOpQKJrPEBTB7GUU+M3eQUukpjNflQqjbfqksXjQSALpbGkhpQ80Fn1dUw9m4ErxOkFf+giQ==
X-Received: by 2002:a05:600c:4706:b0:427:d8f7:b718 with SMTP id 5b1f17b1804b1-42811dd19f0mr51394475e9.24.1722265611970;
        Mon, 29 Jul 2024 08:06:51 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:abd3:cdc8:2363:54ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c067esm12408017f8f.20.2024.07.29.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:06:51 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,  Liam Girdwood
 <lgirdwood@gmail.com>,  Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai
 <tiwai@suse.com>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel@sberdevices.ru,  oxffffaa@gmail.com
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
In-Reply-To: <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk> (Mark
	Brown's message of "Mon, 29 Jul 2024 15:44:38 +0100")
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
	<1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
	<2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
Date: Mon, 29 Jul 2024 17:06:50 +0200
Message-ID: <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 29 Jul 2024 at 15:44, Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jul 29, 2024 at 04:15:31PM +0200, Jerome Brunet wrote:
>
>> Maybe mmio regmap should '.use_raw_spinlock = true' by default when
>> '.fast_io' is set ?
>
>> Mark, what is your opinion on this ? I guess it is not the first time
>> this occurs ?
>
> I don't recall this coming up much TBH.  It may be that people just set
> raw spinlocks when they need it, or that there's not many people using
> relevant devices with RT kernels.

I have not been playing much with RT TBH, but AFAIK, with RT irq
handlers are threaded unless IRQF_NO_THREAD is set. In this case,
something preemptible in the handler should not be a problem.

The axg-fifo drivers do not have IRQF_NO_THREAD so something is a bit
unclear here.

-- 
Jerome


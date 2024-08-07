Return-Path: <linux-kernel+bounces-278423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF094B019
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CC4B232A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656C1422C5;
	Wed,  7 Aug 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K4ybcO5w"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF513AD3F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056936; cv=none; b=EO/ttsMBt053LbLOIIy2gRyBTUfI5wH1NJcsJ/WgMfIMC71alvWW0vDIeUMi27khsN6ZUMyG/N0BhjJ3Jle0t1+uzouZ56fXvbQHNO46Wv2/59ZTymx500hUmQzvCmKgGrZc6bWZVs7laGwFIXZVYMD4LYTmq5FG7vTLemDVCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056936; c=relaxed/simple;
	bh=QzhlHFhB1FlhGEk8gZPrNnM4az2SdvOjtcQi634hGIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZAadvCTfKMbOhLReDmOU4mSZtGmAi8Wv6qW7kBFbm1C0EiUHw3j8Me1mJ+AFscC/+NoeKhZsLPiMOuyizql6Ff3RVh6g69n59JNkdfZsfBcY681vlsbRitTv1cM0Wetpjw6RJdlCV5Fpb+ZyQjR3f0Lj9L3M3yWMuQg1u8Eu4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K4ybcO5w; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-710afd56c99so140684b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723056934; x=1723661734; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFMK304Cg4PQj4mJQ9LEOTK8TkHQhLXzoojwOreQ/Ok=;
        b=K4ybcO5wEPjvJSXg2hs3VvuZiX6MvQowzIXetYqdlb1poo3K6RH9nAsVOajDuQwHgX
         epKi1wdjKD0DG5vpiaxzQ06eqUfJfeSgyC1quEbnSWe6zweSR8z+tdO5KPPe+y9QYbpi
         0adWKjOaNgagHUivC7i+ujbZ7r0A/c0TFzxAbARARwkj9t9G04DVC94+fPrAdI6GPt7J
         8gqramJqlZ6R4scpq+rk9+8WWFptzm3fDDF3vGpQzsQ7VB8CVZgQqiuMu7H1nsQvR7gY
         DJu/1zZwCU+xCN2Rc5eYtyJuUZFAPBWYXb7+kMTWl9LAb+hPVSLBFNpR/wobcZXLYJ3b
         89zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056934; x=1723661734;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFMK304Cg4PQj4mJQ9LEOTK8TkHQhLXzoojwOreQ/Ok=;
        b=d4673CFynI6q17cUpVeU06oAOEPGrqQ8MzrcDU5kHIHH5XQQ+rMZc4B0HeF2MQ4Yg6
         LG84UT6kzZMqfV6r4tujxiCF9rLDlba45OXZZJl7Vle2e5AeIi/YbQI7BVRIAIIoFaOV
         RDcU0GOfapDmF/73mQSWvqc4m0VPN+ebm99AndWLMG2FzRlo1CW/ZD2NyAE5Mv1KYln6
         edvH/j2ZxmAG/eUHr1tGwe66GZtC9/aFKWOifZX5OY1FzizHl4DeHKr/bmttBhaNTBuG
         6P5oOG4NbLGVXQLNcdcFHGVbGbcskmyFFYgfRjlH3Mwonjpqi2gHsLLNfqVZ73iSm3pr
         8Esw==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZncY+G78G4ucaLUz5qTrxu93/3BOaTmRPzie0+dIrwKqj1hVuI6ZSbbgVV6Poo4JYe+nJMCQTf5fy3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3z+XxcliNKTxJ8oY/vUw+RzSMY951+5UVVAumiQ5zMCNy5OoR
	Iu6BpSMhx8sPmPSaq7Yw3cvga8Mb1y8y2d+FT6hmsjOjuK01aZMGsVBAZ3jVpdU=
X-Google-Smtp-Source: AGHT+IEYK846WIyyA851lwFO0Thrl84W8t0gbyPKmjyyprzOtO6+L8KKdMUAaabzXjldmTOqaK+sQQ==
X-Received: by 2002:a05:6a00:6f5b:b0:704:2516:8d17 with SMTP id d2e1a72fcca58-710bc85f5e3mr5133969b3a.8.1723056934390;
        Wed, 07 Aug 2024 11:55:34 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece4967sm8678435b3a.138.2024.08.07.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:55:33 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Markus Schneider-Pargmann
 <msp@baylibre.com>, Tony Lindgren <tony@atomide.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ronald Wahl <ronald.wahl@raritan.com>, Uwe =?utf-8?Q?K?=
 =?utf-8?Q?leine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Thomas Richard
 <thomas.richard@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, Udit
 Kumar <u-kumar1@ti.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/5] serial: 8250: omap: Add am62 wakeup support
In-Reply-To: <20240807141227.1093006-1-msp@baylibre.com>
References: <20240807141227.1093006-1-msp@baylibre.com>
Date: Wed, 07 Aug 2024 11:55:33 -0700
Message-ID: <7hed70kvru.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> v2
> --
>
> In Version 2 I removed the Partial-IO specific patches as these can't be
> tested due to power issues in Partial-IO on am62-lp-sk and similar
> boards.
>
> I added a patch to add DT 'wakeup-source' support.
>
> Series
> ------
>
> To support wakeup from several low power modes on am62, don't always
> enable device wakeup. Instead only set it to wakeup capable. A
> devicetree property 'wakeup-source' can be used to enable wakeup. The
> user is also able to control if wakeup is enabled through sysfs.

For my low-power constraints series[1], it's also important to not have
the UART wakeups unconditionally enabled, so I like the defaults
proposed in this series.  Thanks!

I tested on k3-am62a7-sk along with my constraints changes and all is well.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

[1] https://lore.kernel.org/all/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com/


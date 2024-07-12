Return-Path: <linux-kernel+bounces-250792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E992FCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748F61F2413A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3ED172791;
	Fri, 12 Jul 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdbeuJn7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7DF16F83D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795871; cv=none; b=aW7IVTXTZzwxQLuHtznm/vUN8SaKjhh1cN36tnaVAq5PCeeYC9SqmRkTrp7Vh8RGnCOMEfEdGXcQH/w/uw7GqwDsKHDkxwbLJRqE1miFcyWqv9jIx9rqkOWAJcSdGkY9xwRu5SraIzRgDfyVWowLnHhWoLDcCn9dSz3krJ/F0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795871; c=relaxed/simple;
	bh=5NiK20J7I8uqS12mizskriBLifMOD+BV8PSFC7DJnes=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Y4I+HOZc9a8Dae0o7qqWrk/UbB35BIrp6tTNGSEclFYN6FQV0l5Tw3TTm6LpezAHWjB5lIfidcKUQp9S6q/geHAEdpJjj4qMWcQz169dKtiYl7ZSJ15CHDM8/wac1rnMnwv9TDrWy629M/urIX4qnlQ7SLtq9pXZobdYtXf/wX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MdbeuJn7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so2432851e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720795868; x=1721400668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25HtwWk42kqkS4TR2mXlafiP+k83HA8zqjAwuDPofEA=;
        b=MdbeuJn7lMbI5xiM5RA0aNEhdmGuD5ZdWgGb8yIkeNj0g/1zGjUeu2rH54X9LNnwUd
         MFaO+9y0HLwDgFyyebr8UUxSVrkFXvigllCREer5xKoQ7HMxitzlOAEtmK+bVrB922rG
         OqveNk4py54tsJ6rHukwhwsC5Lh+wxSOTXTdPIi+VwmzqPP8Hdk6ctFMcTOCw+gPCKxK
         95YYad7v6SFPndCu45STNoBo4K9CPxml34mK559iypLx6ah/t3Yfxvoc/bQpMdbipKj+
         pLQQI5QMEtM0hfg04CfagkNToTQlA+3poeiRI42bbaaEBfPwPUDGPFw+7rSFjpp/RixN
         nk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795868; x=1721400668;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25HtwWk42kqkS4TR2mXlafiP+k83HA8zqjAwuDPofEA=;
        b=Nk2nXhmWiOzxSP8I2DvRyFrD+fuayvdEXzGshtnks5jwLa0VfvpcFGXFaApzxjCEmn
         MhXLVEx2VB8RjpikfUrbBkbWh6qYUT9jOg3bToymVOdEBfQ3iKCV/HifNu9LZ1cUnz0B
         FrI5gF5JoWxttK6qKmdm3p8DVAnhgmuntVV8rZ4wB0TyeMC9jJOfOrALdaoXGbTM5cxo
         QWmCKzWwuAVoZRubCEldTIOlmGLfYUDNMJFHj2k4/U+N+8dUGED9Nj21IZb8aFD1H04B
         hm97mHrquzsK77vCdXVaD/54bW04fxpRDnrI0CP3wiIQPyMRSH0Spamlq9BvASRsvAu3
         xfrg==
X-Gm-Message-State: AOJu0YxZSQSA/a9EIc5OQyoFp4h1travhQ8aUxba89CgOAMFpQj/s1ob
	WS/1Fd5TQXNSrL99NwzN0GWHXJrJym3e0wSFde17GUsXmowY2pKKfvHzAislMxI=
X-Google-Smtp-Source: AGHT+IExAI372ZjrINFBVM13cZ9IuDW4WAiLLz05CtjBkrQloPpho2sSpSKceRzFEDPAUSXLT0+EyA==
X-Received: by 2002:a05:6512:3ba8:b0:52c:db75:9640 with SMTP id 2adb3069b0e04-52eb99d20cemr9424739e87.48.1720795867572;
        Fri, 12 Jul 2024 07:51:07 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4ac5:b5bb:35db:3edf? ([2a05:6e02:1041:c10:4ac5:b5bb:35db:3edf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4279f27846bsm25838455e9.25.2024.07.12.07.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 07:51:07 -0700 (PDT)
Message-ID: <91cd05de-4c5d-4242-a381-3b8a4fe6a2a2@linaro.org>
Date: Fri, 12 Jul 2024 16:51:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL][resend] timer drivers for v6.11-rc1
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Li kunyu <kunyu@nfschina.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

please consider pulling the following changes since commit 
256abd8e550ce977b728be79a74e1729438b4948:

   Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

which are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.11-rc1

for you to fetch changes up to 4bdc3eaa102b6bedb0800f76f53eca516d5cf20c:

   clocksource/drivers/realtek: Add timer driver for rtl-otto platforms 
(2024-07-12 16:07:06 +0200)


Thanks

   -- Daniel

----------------------------------------------------------------
- Remove unnecessary local variables initialization as they will be
   initialized in the code path anyway right after on the ARM arch
   timer and the ARM global timer (Li kunyu)

- Fix a race condition in the interrupt leading to a deadlock on the
   SH CMT driver. Note that this fix was not tested on the platform
   using this timer but the fix seems reasonable enough to be picked
   confidently (Niklas Söderlund)

- Increase the rating of the gic-timer and use the configured width
   clocksource register on the MIPS architecture (Jiaxun Yang)

- Add the DT bindings for the TMU on the Renesas platforms (Geert
   Uytterhoeven)

- Add the DT bindings for the SOPHGO SG2002 clint on RiscV (Thomas
   Bonnefille)

- Add the rtl-otto timer driver along with the DT bindings for the
   Realtek platform (Chris Packham)

----------------------------------------------------------------
Chris Packham (2):
       dt-bindings: timer: Add schema for realtek,otto-timer
       clocksource/drivers/realtek: Add timer driver for rtl-otto platforms

Geert Uytterhoeven (3):
       dt-bindings: timer: renesas,tmu: Add R-Mobile APE6 support
       dt-bindings: timer: renesas,tmu: Add RZ/G1 support
       dt-bindings: timer: renesas,tmu: Add R-Car Gen2 support

Jiaxun Yang (2):
       clocksource/drivers/mips-gic-timer: Refine rating computation
       clocksource/drivers/mips-gic-timer: Correct sched_clock width

Li kunyu (2):
       clocksource/drivers/arm_arch_timer: Remove unnecessary ‘0’ values 
from irq
       clocksource/driver/arm_global_timer: Remove unnecessary ‘0’ 
values from err

Niklas Söderlund (1):
       clocksource/drivers/sh_cmt: Address race condition for clock events

Thomas Bonnefille (1):
       dt-bindings: timer: Add SOPHGO SG2002 clint

  .../bindings/timer/realtek,otto-timer.yaml         |  63 +++++
  .../devicetree/bindings/timer/renesas,tmu.yaml     |  12 +
  .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
  drivers/clocksource/Kconfig                        |  10 +
  drivers/clocksource/Makefile                       |   1 +
  drivers/clocksource/arm_arch_timer.c               |   2 +-
  drivers/clocksource/arm_global_timer.c             |   2 +-
  drivers/clocksource/mips-gic-timer.c               |  20 +-
  drivers/clocksource/sh_cmt.c                       |  13 +-
  drivers/clocksource/timer-rtl-otto.c               | 291 
+++++++++++++++++++++
  include/linux/cpuhotplug.h                         |   1 +
  11 files changed, 405 insertions(+), 11 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml
  create mode 100644 drivers/clocksource/timer-rtl-otto.c





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-kernel+bounces-249686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D9A92EE85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1AD285C49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227816DEC8;
	Thu, 11 Jul 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnRwqLGo"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909228FF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721520; cv=none; b=BzhvGtpsQkFMyciyquZSNBnv9g6z7JIWBeeLvmeYcRYTMuuPRNOSMdlOCF9+2OkhfXd05HXkd5iAyNPOzEFdTM4M4qnGvIRBSQwQXkVGiLnxIB2k2BRtX3udfIwS79bmEc/j5mLj2jEpEWnFVVBY7qT1kU9f+cSjuxBOAT3dqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721520; c=relaxed/simple;
	bh=yiNlWxQFIuLiXCiNDpxh5pHm79njqFKOXJHZpDPyfrA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=POOaPi5WcnDpnmkMOA5FByG4X/TsE0L5hFbVCJpVLLFxiiBgh4cncVrCx8hYrI6XniN+RTfjIu3Q1737g5jNgdroyntVgzOgZFQIWK0AJkNlh5bN8L+H/UaTFAso1RDOQ9V+6OHeBSe++h8YmkYCVOqvASpdRKB9l7ZofT7jb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SnRwqLGo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42797289c8bso8533015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720721517; x=1721326317; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOTuIDCHHw4nroDu5tmJN8OsvPxrrZZ1giv5r6s8f+4=;
        b=SnRwqLGo3aZeSc8kot9O1nbi9G3ZsJX55Iy9d2lqrWR/6xzzapysUhrsa2HpCO9lEt
         iQmJ1We9w1/Mo6dB0NZdTXjvvLvVEoncS66qdLzzSIr7pv78RGFPsikCYXMjFW8SGmJw
         KEoCSKhBw1pZVH5n62PXPQIQDZMpwqOEWqhHzAYj4KsZVrEmOrqMzQLKcSaGruutPaxx
         hQlq/nGMwa9yGKh0aOO5FSFo0YXCDicYNHZmVOqkHN+WQFI7S5mlXwk8AC02tzvXCsnH
         KUl7W89GOp46f9JnKTEXiNa3jRMIgWUpzSomQJ5rTq81jzln+E6/2DBPHybiiJ3sQEGM
         h4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720721517; x=1721326317;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AOTuIDCHHw4nroDu5tmJN8OsvPxrrZZ1giv5r6s8f+4=;
        b=Qcpe1QBCGJuhb2yYZZO4sYsyUxtGSv3RZ3gULn+82wmtaxpxCTkrx3W7DfCMU51DL1
         UPoHqCeEIksJQSP1B9qCOwkuIvZvCIgtJvxMVrkNujCTPg0OB3T1+8dXel16BUQfYSAe
         L8p/xzX7dyb34WReKwQpSgG1P2CMg+cdYJLrLBbSgsemza5HXs1MmQ5gosJKHXGGn8Jy
         r5Q7tbxA9L23GcEfB4O8B52YXvY8YMllCJMjHLNOWAylKvB3Mwvw4ZB4RgORiKpuHj9f
         h/KietCKCASLkbOWInqdPF4Ggbdy2mZS9et/7TCE6QYmWX+WmYFY4RF6WIMh28ylsEz4
         GGfA==
X-Gm-Message-State: AOJu0Yw0MFPmBTzpKaUIL1h0ZiksRFS24sQn0dgfZOqs9ZnZcFin9S1T
	4utFW9lqJQTkdppdLf/wmrXWdI37USLscrFVmDhI5v0LQjIFpoBQvbDMEPMAImc=
X-Google-Smtp-Source: AGHT+IF1eQ/H2vUY/f8Y42sES0su+RPX3cSYOuyo7qd9TYVB2AS3ugNpLDgulyPkoyT2lolTwb3Hyg==
X-Received: by 2002:a7b:c3d8:0:b0:426:5ee5:3130 with SMTP id 5b1f17b1804b1-426705ce998mr53078015e9.3.1720721516769;
        Thu, 11 Jul 2024 11:11:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4ac5:b5bb:35db:3edf? ([2a05:6e02:1041:c10:4ac5:b5bb:35db:3edf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0b6bsm125864275e9.3.2024.07.11.11.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 11:11:56 -0700 (PDT)
Message-ID: <e646d66e-5fb6-46cb-9e65-44bdf67d5d8a@linaro.org>
Date: Thu, 11 Jul 2024 20:11:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Li kunyu <kunyu@nfschina.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.11-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

please consider pulling the following changes since commit 
746770499be55cf375a108a321a818b238182446:

   timers/migration: Fix grammar in comment (2024-07-04 20:24:57 +0200)

which are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.11-rc1

for you to fetch changes up to 8b77f4b8dc81aeb73107b169cb9c6e06c15d297e:

   clocksource/drivers/realtek: Add timer driver for rtl-otto platforms 
(2024-07-10 09:41:20 +0200)

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


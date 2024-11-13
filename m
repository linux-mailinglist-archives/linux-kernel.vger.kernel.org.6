Return-Path: <linux-kernel+bounces-407865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4219C75FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5EB1F2552A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FF2201035;
	Wed, 13 Nov 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3A/86IC"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB713B298
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510787; cv=none; b=RnAEfT+t//T2PxUem8tJKJLqWi/aIF5uP1xBSQ6yrgcKVjCnJKKZuzkYBrHdzrSdW22+7DBMzuwZKQC3HSJclhinzSVOsLo8wl/WXAN11QadDXhqpM7pIcuyu37xnRXDMDD331jw19IdrFlhOi4U01LNrAtzVurwnSR7lirPtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510787; c=relaxed/simple;
	bh=V4YACJS2Dc3zD0sWQXDW9+3sWcjZk+qx+4OePzj/Cvo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=JV3JnBBSxUa42eXnD8C47Iy1mfMciAqWjwv12SPqX3wot5IumyHLa+zvbiY0ldmOmAVTRRkXPVBMjJOaS/xpuSyigljB6mTGeC02uq/uNmzDAdYRnRm2Jo6KqbYF/FQp6nSee2y3OMF+s+QRp/tE8UZQVzDUAStKFfNg68gJU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w3A/86IC; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53da3b911b9so312573e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731510784; x=1732115584; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgWlEHsRqvYKdWEUO9aMtqCzC5tc6Uc42eoyLnzyk5k=;
        b=w3A/86ICBMalrzXwuZDc0h1HQaemKCjL3QtyH0OYLHKTBPGP62rdQwUPLYArv1L+x2
         7L7lgyAmdTT2xRF9TmtNkNlJbqFsW6lh6CbhA/B8pFCfZgQhzO/jJIXlqGi76SJQBIi2
         tz1Y/0rZOAsKltDhVepZY6XxFbRNfmVBwukEWHKb3U0JdwrFsyMAsjhvfgNAi0r9rg2N
         Niwdpy7ZYZIE6vgrRS4rRj0qs39vK/fmbuO9/8O2bXyUIqf40vh8CgLxnKvFkHpGTbWW
         sGLnbgSTkevxYcqTvBI8WqM1x6VWyiMIJQ06fdDxPqxBV65edAvSsKuNP9c+eBuEwYd2
         zMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510784; x=1732115584;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wgWlEHsRqvYKdWEUO9aMtqCzC5tc6Uc42eoyLnzyk5k=;
        b=nRDqwufGXKGaOMNqRBMFNpsHsxbcLN04DjhhEErEWZ+tr/tJqiVaNYv//P+1+mrU1F
         Rw3NY8xUIXzIwNF2/c1qAc4m1tgRfq1TBSTZXk7WgbyiqsKp7P3UpjC0LhBhudVV7For
         slQPOsHO0mZwnR35WDn/7IIKgztvXrGvevHORxukM8wZv6FyblJfzgsyWBzIeWmjWM+o
         X56D4AwKK1bGg51HMQX+y7myAUD56LMHLIRwsE9JCQ18n/B7r8j9WwS8jcoFKtyPm5I1
         H3SbP1uFrzmGwU+ULD6mLVy4EBHB1FtUoa9bD1Ja7tSsUFbVEnBvgpNchAXoB43K/lDt
         6WCQ==
X-Gm-Message-State: AOJu0Yz+ey4W+PVA5zXhehM6h+00KZK+GayXTVi5P9rHSenhFSqQMzcN
	iTleBJ0LybnE0GAMbO5Q8BEBsty0Y5aAdOB8BxD4NGAQvbq2UrpvQT+WzTg+Y6g=
X-Google-Smtp-Source: AGHT+IH2hh7GM0nVAPIboFfI4uTPxsW7W9NsoV0QtlseUER5FQjeGWtM/rwZytxw1MAo30XlCvUS5w==
X-Received: by 2002:a05:6512:1193:b0:535:6a4d:ed74 with SMTP id 2adb3069b0e04-53d9fee21afmr1840642e87.51.1731510783603;
        Wed, 13 Nov 2024 07:13:03 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed9ea647sm18348450f8f.68.2024.11.13.07.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:13:02 -0800 (PST)
Message-ID: <8d402321-96f1-47f7-9347-a850350d60de@linaro.org>
Date: Wed, 13 Nov 2024 16:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux@treblig.org, Judith Mendez <jm@ti.com>, Mark Brown
 <broonie@kernel.org>, Paul Burton <paulburton@kernel.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [GIt PULL] timer drivers for v6.13-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

please consider the following changes for the timer drivers v6.13-rc1

The following changes since commit 3c2fb0152175f9f596b40763cdc1378297da60af:

   hrtimers: Delete hrtimer_init_on_stack() (2024-11-07 02:47:07 +0100)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.13-rc1

for you to fetch changes up to 08b97fbd13de79744b31d2b3c8a0ab1a409b94fa:

   clocksource/drivers/arm_arch_timer: Use of_property_present() for 
non-boolean properties (2024-11-13 13:49:33 +0100)

----------------------------------------------------------------
- Remove unused dw_apb_clockevent_[pause|resume|stop] functions as
   they are unused since 2021 (David Alan Gilbert)

- Make the sp804 driver user selectable as they may be unused on some
   platforms (Mark Brown)

- Don't fail if the ti-dm does not describe an interrupt in the DT as
   this could be a normal situation if the PWM is used (Judith Mendez)

- Always use cluster 0 counter as a clocksource on a multi-cluster
   system to prevent problems related to the time shifting between
   clusters if multiple per cluster clocksource is used (Paul Burton)

- Move the RaLink system tick counter from the arch directory to the
   clocksource directory (Sergio Paracuellos)

- Convert the owl-timer bindings into yaml schema (Ivaylo Ivanov)

- Fix child node refcount handling on the TI DM by relying on the
   __free annotation to automatically release the refcount on the node
   (Javier Carrasco)

- Remove pointless cast in the GPX driver as PTR_ERR already does that
   (Tang Bin)

- Use of_property_present() for non-boolean properties where it is
   possible in the different drivers (Rob Herring)

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
       clocksource/drivers/dw_apb: Remove unused dw_apb_clockevent functions

Ivaylo Ivanov (1):
       dt-bindings: timer: actions,owl-timer: convert to YAML

Javier Carrasco (1):
       clocksource/drivers/timer-ti-dm: Fix child node refcount handling

Judith Mendez (1):
       clocksource/drivers/timer-ti-dm: Don't fail probe if int not found

Mark Brown (1):
       clocksource/drivers:sp804: Make user selectable

Paul Burton (1):
       clocksource/drivers/mips-gic-timer: Always use cluster 0 counter 
as clocksource

Rob Herring (Arm) (1):
       clocksource/drivers/arm_arch_timer: Use of_property_present() for 
non-boolean properties

Sergio Paracuellos (1):
       clocksource/drivers/ralink: Add Ralink System Tick Counter driver

Tang Bin (1):
       clocksource/drivers/gpx: Remove redundant casts

  .../bindings/timer/actions,owl-timer.txt           |  21 ----
  .../bindings/timer/actions,owl-timer.yaml          | 107 
+++++++++++++++++++++
  MAINTAINERS                                        |   2 +-
  arch/mips/ralink/Kconfig                           |   7 --
  arch/mips/ralink/Makefile                          |   2 -
  drivers/clocksource/Kconfig                        |  12 ++-
  drivers/clocksource/Makefile                       |   1 +
  drivers/clocksource/arm_arch_timer.c               |   2 +-
  drivers/clocksource/dw_apb_timer.c                 |  39 --------
  drivers/clocksource/mips-gic-timer.c               |  39 +++++++-
  drivers/clocksource/timer-gxp.c                    |   2 +-
  .../clocksource/timer-ralink.c                     |  11 +--
  drivers/clocksource/timer-ti-dm-systimer.c         |   8 +-
  drivers/clocksource/timer-ti-dm.c                  |   8 +-
  include/linux/dw_apb_timer.h                       |   3 -
  15 files changed, 174 insertions(+), 90 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/timer/actions,owl-timer.txt
  create mode 100644 
Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
  rename arch/mips/ralink/cevt-rt3352.c => 
drivers/clocksource/timer-ralink.c (91%)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



Return-Path: <linux-kernel+bounces-265894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A293F762
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC31C21953
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4B14EC60;
	Mon, 29 Jul 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zjoTEaaq"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3F20E3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262538; cv=none; b=BVq6qjtQUR+ugY5XG96WV3K1GWXRE24pqihp+sqxZmN1IR9UWnxlEN3ZY97F4DoRe7Uhl6X2EcbPtMgjKLnf0RLQ3ZZDtxrv4vkseuYuMwkvcq8GsKqmt7Ts2SWHS0rGSWYeL3vO1b4X2RKdces4G7k5PcKBmv4Ga0WhClnJK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262538; c=relaxed/simple;
	bh=D1ZYFHP/38LgdR0JBD7XaxbjYHhm3ApdP7ZKB5nxgew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCjzAV02lzc9DHrFHKbbX+gUk8d8laT1UYHpWs6ryQxhURB6Sl7/hbsN4jXNlpNG0lZlyF3af9aMVXLJvCRRB71KxKo6il/TFffApDyytZ7OahuZACiYWFa56Q/6Ep6Ikklzcxk5dIkn+cZFJU38eHS06gxm0XUlW7IhhJUp/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zjoTEaaq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-369f68f63b1so1325779f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722262533; x=1722867333; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEE5YCygicDy/XBXKqh7m+z9CwXQT4fXt6CN+8nkicI=;
        b=zjoTEaaqG+7tw4I2DOhoKPqvRb12zzNlEUKq0sirs/2YZlUuL4h+skY94MCmA902lU
         cET8bJ6hGFw5e8xVQYmqK1WUo0tdY3FmYC3y7uRC8GAdmdV12z5eNAzVybUiEz7PY/8j
         Fw7WnaOTLGsSF+RLeeBJfL4I6v2bdvw/IP61Db74HTGlegNwBncxTvDPJbwdt6yDqc8W
         VbAf+V/5I0ImMl3AiPNZ9o/8w+08uKooM3eDKlcyOklSVOrFhNsJr9mEk1a3OZlJ/lvF
         MES99aRN20rUQhXFqiAVlLG75X4HMMk7A9qLTk7VRRq58aaYEdlaoWS7s/IdxHbL/cbb
         M1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262533; x=1722867333;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEE5YCygicDy/XBXKqh7m+z9CwXQT4fXt6CN+8nkicI=;
        b=fxtAWedWhc060p+60z4Xhic64Tn5socTynU3D7dWluNLrThAI7Vrx9tZoHAeOi1+Ps
         fJKIg/YTRHGHzXpIfSvLXwfHf0vDVPn4dqhemDSsx/4OlqYn80RFIt4sD1K3eojouQdY
         N0UvElsJfN/Oba7eDlOO42K0EVk3ExYBkg2oLY9Fb8UpIHzg236fexDVhEooeCU1crWS
         kYEb84EGo13LKgj8wOdUKhkYhfrk/qBtNkZl1mjFOVrlgeiu6ftgIUVOT01SiX7C+J7R
         k/RfZAdteIldgCMJMMqAO4VZts0qaazw/Cid+wN23FYf3rZwy2T3XSOvwJusjGxG7WWz
         Gpkg==
X-Forwarded-Encrypted: i=1; AJvYcCUKqqfcbRHdSqGxLnAE6sMLebPYAO1GgLBfyEV4SZbOSA9GXiDugMt4xcYGy3wrgifaMEDjU6sXbDpI6Fo0du1F/lLL4eUYsGaGQQRw
X-Gm-Message-State: AOJu0YxckXjIvCW+VjZVhbDmCEBd4ffUcF8qXlpwhHwdY0160mnHNcX0
	jLX8M9YNR7GbckEpqrb8wlfII6p8xyQdkgcXSUCEhjUWP2BTYo06QIshGNjgBz9bAunyoc74no7
	SlDI=
X-Google-Smtp-Source: AGHT+IGvhW6W5lhj8wCPR9kGfAvnftNlZn/nJWbDUFlhvd5DqspfoHe3v4BYeRLrWpFDIhKz3FbMyw==
X-Received: by 2002:a5d:5184:0:b0:368:6596:c60c with SMTP id ffacd0b85a97d-36b5cefdef5mr5201083f8f.30.1722262532993;
        Mon, 29 Jul 2024 07:15:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:abd3:cdc8:2363:54ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12284340f8f.59.2024.07.29.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:15:32 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>, Mark Brown
 <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  <alsa-devel@alsa-project.org>,  <linux-sound@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,
  <linux-amlogic@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <kernel@sberdevices.ru>,  <oxffffaa@gmail.com>
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
In-Reply-To: <20240729131652.3012327-1-avkrasnov@salutedevices.com> (Arseniy
	Krasnov's message of "Mon, 29 Jul 2024 16:16:52 +0300")
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
Date: Mon, 29 Jul 2024 16:15:31 +0200
Message-ID: <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 29 Jul 2024 at 16:16, Arseniy Krasnov <avkrasnov@salutedevices.com> wrote:

> Raw spinlock is needed here, because with enabled PREEMPT_RT,
> spinlock_t become preemptible, but this regmap lock could be
> acquired in IRQ handler. Found by lockdep:

Assuming I understand the problem correctly, any driver with an IRQ and
using mmio regmaps would be subject to this problem, isn't it ?

That does not seems particularily specific to this driver, so changing
just this one like that does not make a lot of sense to me.

Maybe mmio regmap should '.use_raw_spinlock = true' by default when
'.fast_io' is set ?

Mark, what is your opinion on this ? I guess it is not the first time
this occurs ?

>
> [ ] =============================
> [ ] [ BUG: Invalid wait context ]
> [ ] 6.9.9-sdkernel #1 Tainted: G O
> [ ] -----------------------------
> [ ] aplay/413 is trying to lock:
> [ ] ffff000003930018 (axg_fifo:356:(&axg_fifo_regmap_cfg)->lock){....}-{3:3},c
> [ ] other info that might help us debug this:
> [ ] context-{2:2}
> [ ] no locks held by aplay/413.
> [ ] stack backtrace:
> [ ] CPU: 0 PID: 413 Comm: aplay Tainted: G           O       6.9.9-kernel #1
> [ ] Hardware name: SberDevices SberBoom Mini (DT)
> [ ] Call trace:
> [ ]  dump_backtrace+0x98/0xf0
> [ ]  show_stack+0x18/0x24
> [ ]  dump_stack_lvl+0x90/0xd0
> [ ]  dump_stack+0x18/0x24
> [ ]  __lock_acquire+0x9dc/0x1f10
> [ ]  lock_acquire.part.0+0xe8/0x228
> [ ]  lock_acquire+0x68/0x84
> [ ]  _raw_spin_lock_irqsave+0x60/0x88
> [ ]  regmap_lock_spinlock+0x18/0x2c
> [ ]  regmap_read+0x3c/0x78
> [ ]  axg_fifo_pcm_irq_block+0x4c/0xc8
> [ ]  __handle_irq_event_percpu+0xa4/0x2f8
> [ ]  handle_irq_event+0x4c/0xbc
> [ ]  handle_fasteoi_irq+0xa4/0x23c
> [ ]  generic_handle_domain_irq+0x2c/0x44
> [ ]  gic_handle_irq+0x40/0xc4
> [ ]  call_on_irq_stack+0x24/0x4c
> [ ]  do_interrupt_handler+0x80/0x84
> [ ]  el0_interrupt+0x5c/0x124
> [ ]  __el0_irq_handler_common+0x18/0x24
> [ ]  el0t_32_irq_handler+0x10/0x1c
> [ ]  el0t_32_irq+0x194/0x198
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  sound/soc/meson/axg-fifo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index ecb3eb7a9723d..a22298f74b35a 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -328,6 +328,7 @@ static const struct regmap_config axg_fifo_regmap_cfg = {
>  	.val_bits	= 32,
>  	.reg_stride	= 4,
>  	.max_register	= FIFO_CTRL2,
> +	.use_raw_spinlock = true,
>  };
>  
>  int axg_fifo_probe(struct platform_device *pdev)

-- 
Jerome


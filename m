Return-Path: <linux-kernel+bounces-344009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0126498A28A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D85B210B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369918A6CA;
	Mon, 30 Sep 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="leSmQSfx"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FB1367
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699593; cv=none; b=fS3XJmsgbwA6NFnTa0AF43gun7xlmnWZxKVs3waG3/gGyotp2xMTPdBjfW7QmnGUGD57p4onGq8TTPLC6b16VdEmbypg7iczmnRTSzd90h+3J+vA/Z4HwNp/8U1/qB/nrWEFidV7SkvUNO1Bj/RGmY8cwYaeO4YNsxf+QZv8HQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699593; c=relaxed/simple;
	bh=LyzJmmS8LJTwx8gYpxEgleRy+bmQX7rq30u7XI/LQ8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsI/icJjmHQ2GTgvkaD/gFrNlvRSFZy2d4WRPiDom7lnqLBHhFJQIaRx9XnP/wvcLSx5krg4YdMEwCtvPyyt7a6ZZBkgG0lv0WFIg8kEVe5AW9ZWkyWKo1gWaW7M9LFrr9NqQowAtdYPWwgTuIgM8MUI7d5bbBxn7XtZNvPHdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=leSmQSfx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso1948943f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727699589; x=1728304389; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcTFAf/39stw2L9rW+QSJlImzmwdaZ5jPtnTMrK6EJE=;
        b=leSmQSfxWbg3yBwX/2SxBjSUG7U0uzsUy8P2gfgjT4cslVU9OA+u36hUaYB+G7QHTh
         0gXkqIW3d8llJaKvHMhSVc+nTN32vrsTvQ97guoQSPLc2xt3NR9aFMhjkKTt6e3s226J
         QuZZNUz98xv0fTcrPd5JCnHbBUhKhZ8pZZE23Ph4QrfmcYtWdL8aexS1nCMNAWov0KG+
         3I6q8aLqn/QwGIJfb76Ll+mGcgyABnYX3ILOE/g/x8k1kjA9fvf6gqhLkaOeQXeXkEzo
         vJo+CxT4POlymwaSar2RMoghk0S134eXJ6ETRfBzTz/Gs01lEjTGADqtQ9gWpabXeE68
         rH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699589; x=1728304389;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcTFAf/39stw2L9rW+QSJlImzmwdaZ5jPtnTMrK6EJE=;
        b=u2kG6ut3RF92wD7hP5w2jOkhfQ2+adLYDqrLSb1X3tdyALZii5s84fAxO14HOYfrAR
         9LcnDd9vqIWaIm6CkPijquypAmhm3fzxHpEQIrKZ+7slwlw/XIIGBa9QrB2r85PPymkE
         JkkOJHruiRGHfMMfB2sIIzxGg5fBwx2YlYNKpwOoiM2xWLWyNsPtPoSSwpQ9lihlWAy8
         EB42ZmhhuGcSHSX84c9MNdNfuJAd/vHNvKYTFz+LPE/JV5MQkSxqD8udnoS+UdDJ3kg0
         y6fYJnRVP0MUQSeqmaAcCgSQoJ6BAA+sNmOghUZD3211DD5nyy756jNZz6evu7vTEtw1
         r/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvH3a/nJxUTi7B3KBiSvnDiMahDXvZRs7aaI9ZghKHCMjQQL0kEFe4XIhqfW4E1YzvtfU66QBX6rk8/mA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8Keo47kKzHUVsASCdgOH4adf6U4gZxEEQg78/UQ4vt/ZRtRX
	d/qy26dabPOTgs9TVShxTFLEgZDEk7LpMxQ4JR+maGXkJW1bKqrfoGkmaDgTsQc=
X-Google-Smtp-Source: AGHT+IHTY8puEfxRrHvmLqweSOnoM31uzsPdJHEBi2OMm0NwVB3ar3t6Omd21i9AD5kxBgtkSBpjTw==
X-Received: by 2002:adf:f1d1:0:b0:374:c621:62a6 with SMTP id ffacd0b85a97d-37cd5aed352mr5657657f8f.47.1727699589487;
        Mon, 30 Sep 2024 05:33:09 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b6ba:bab:ced3:2667])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fd9asm8996599f8f.75.2024.09.30.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:33:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] clk: Fix issues related to CLK_IGNORE_UNUSED
 failures and amlogic glitch free mux
In-Reply-To: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com> (Chuan
	Liu via's message of "Sun, 29 Sep 2024 14:10:04 +0800")
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
Date: Mon, 30 Sep 2024 14:33:07 +0200
Message-ID: <1jcykltj7g.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun 29 Sep 2024 at 14:10, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> If CLK_OPS_PARENT_ENABLE is configured for clock,
> clk_core_disable_unprepare() is called in clk_disable_unused_subtree().
> Even clocks that are configured with CLK_IGNORE_UNUSED are disabled,
> resulting in the failure of CLK_IGNORE_UNUSED.
>
> To ensure that amlogic glitch free mux can switch clock channels
> properly, add flag CLK_OPS_PARENT_ENABLE to glitch free mux. The issue
> that CLK_OPS_PARENT_ENABLE in CCF causes CLK_IGNORE_UNUSED to fail is
> also exposed.

The problem is that you are mixing problems together and it makes things
rather difficult to follow. There are 2 distinct problem, there should
have been to distinct patchset, even if you reference the CCF one in the
Amlogic change.

CLK_IGNORE_UNUSED is no guarantee that a clock will stay on, no matter
what happens in the clock tree. I explained that to you several times,
and it is the very reason why you are being asked to justify each usage
of the flag. Most of the time, using it is wrong.

That being said, there seems to be problems with CLK_OPS_PARENT_ENABLE
in clk_disable_unused_subtree(). As it is, I think
* a clock with CLK_IGNORE_UNUSED and CLK_OPS_PARENT_ENABLE, would 'leak'
  an enable, essentially making the parent subtree critical.
* All parents of a CLK_OPS_PARENT_ENABLE clock would have its
  CLK_IGNORE_UNUSED ignored as a result of the enable/disable sequence
  (note that in any other circumstance, enable/disable should indeed
  disable an CLK_IGNORE_UNUSED clock).
* Parent of ignored clocks may still get disabled.

I'll be sending a proposal to address these problems soon.

>
> glitch free mux channel switchover failure issue(Test vpu_clk on S4):
> step 1:
> $ cat /sys/kernel/debug/clk/vpu/clk_parent 
> vpu_0
> $ cat /sys/kernel/debug/clk/vpu_0/clk_rate 
> 399999994
> $ cat /sys/kernel/debug/clk/vpu_1/clk_rate 
> 666666656
> $ echo 1 > /sys/kernel/debug/clk/vpu/clk_prepare_enable 
> $ cat /sys/kernel/debug/meson-clk-msr/clks/cts_vpu_clk
> 399987500       +/-12500Hz
>
> step 2:
> $ echo 0 > /sys/kernel/debug/clk/vpu/clk_prepare_enable 
> $ echo 1 > /sys/kernel/debug/clk/vpu/clk_parent 
> $ cat /sys/kernel/debug/clk/vpu/clk_parent 
> vpu_1
> $ cat /sys/kernel/debug/clk/vpu/clk_rate 
> 666666656
> $ echo 1 > /sys/kernel/debug/clk/vpu/clk_prepare_enable 
> $ cat /sys/kernel/debug/meson-clk-msr/clks/cts_vpu_clk
> 0       +/-3125Hz
>
> In step2, vpu_0 is disabled, and the vpu is not switched to vpu_1. At
> this time, the vpu is still connected to vpu_0 and vpu_0 is disabled at
> this time, resulting in the clk-measure not measuring the clock.
>

If keep the display on and managed at all time is critical, then may you
should consider having the module managing it as built-in.

You would not need CLK_IGNORE_USED at all because device would be
present before clk_disable_unused() is executed.

Past the late init, if no device actively use the clock, disabling it is
the sane thing to do because nothing says it will ever be used.

> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Chuan Liu (2):
>       clk: Fix the CLK_IGNORE_UNUSED failure issue
>       clk: meson: Fix glitch free mux related issues
>
>  drivers/clk/clk.c                  | 67 ++++++++++++++++++++++++++++++++++++--
>  drivers/clk/meson/a1-peripherals.c | 12 +++----
>  drivers/clk/meson/axg.c            | 16 +++++----
>  drivers/clk/meson/c3-peripherals.c |  6 ++--
>  drivers/clk/meson/g12a.c           | 18 ++++++----
>  drivers/clk/meson/gxbb.c           | 18 ++++++----
>  drivers/clk/meson/s4-peripherals.c | 32 +++++++++---------
>  7 files changed, 122 insertions(+), 47 deletions(-)
> ---
> base-commit: e736da1956cf0880a02ec5023f3487eea7611b5f
> change-id: 20240929-fix_glitch_free-290c88923c31
>
> Best regards,

-- 
Jerome


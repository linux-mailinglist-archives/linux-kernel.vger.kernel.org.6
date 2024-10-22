Return-Path: <linux-kernel+bounces-376045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B39A9F34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDC91F22EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E3199229;
	Tue, 22 Oct 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fJbPglXI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2D187330
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590689; cv=none; b=tDm5DjOspT/iR9Rz3K3vS7dFybMn/ZtnS6o2SX0vPUraTWsw1CqzHkXSGcTdZ3fi5yvHKmMEEYP9XVEIl7Qc6JpothFr0gbCLkHrURMEScQKh/du79hgyMV4ZuLnaunMckxO6ExlcuNsKW/BiAqSGZ5sM6JBuy6pgxun0eBn92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590689; c=relaxed/simple;
	bh=JsWWmLr80OvZZgtqzSLI+3NO59wkVjAXXzhBndm6rPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YdHo+S7Vm2WvSH8mBQfVN5je8OCTH5QFeBWATsprFoGwLdYhbD/0xg3yVY7kiikXcQzkBAcSowhFVemdXj9XkQI8x1iqxmOcfx1RT2p0N4Ka079St0gUAmDSz/3a7MBT4H1Y2GThgxjPZ7yxffmZ/KAl4/gEBPhsOBya+aF/+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fJbPglXI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so60189515e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729590685; x=1730195485; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9uhSsPjuLDUWqYOIT4n8318oMtxdXxpij17XIrTsXE=;
        b=fJbPglXIIS2dknfgtbeunLcmjIXpFQlBmw2BrAwiOAVZu/rdZj3Y1BtqdRg7g9kyZ2
         KhbNffz+hPm0J7WJIASZ6gyLBudGKgRGmBEHYcw0DaMlPYhGucp/SLET0JPqenbhLtQX
         qmU0f5Hh6tMoJFEY12pF2sTMa5ybFiiffOmCsMzR12mB6dvVSQVym8q8QjYFK6HjiB9R
         ZIi+pjGd6feUpyy9J15oOzryXiIffbLE+d+3Hh96C8UbUtykTGCBM3nw9gyOqW4BLk8l
         nm9zZzkdAus6FSw6wJHglp9sjPmrGF46cd2GugZ+7niwhSsjuFuc2Ya4Z6JMxorbjwnm
         +vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590685; x=1730195485;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9uhSsPjuLDUWqYOIT4n8318oMtxdXxpij17XIrTsXE=;
        b=khrpvuDihACkRrZxV3PZppsaxIhP0z8iaVig7dK2g2ZBv9JTPcG+XRQpDhOS8tZSh3
         IurzCzOkU/ZAhkKOFmoEbfR4+vRg7b5CRjWbGr/PRpzh7gYM6Om9BUYQdbxkumZOUsMX
         tf4FkyUxaZwrQzJo4cXzOzOgovCEuJ8mMymeXjHDJ6AoHRpfA8sClDpRcYJdnYeOMPHR
         bXImwBAPaAnYvV0Bk76Fd3CDCXQU3S/CmuSsIx4pd6KEnJRWpspyLGWBxa6cdwSpr48m
         TXU1AsO/MqX0fJdfBPX/xocw0wPifS54/F/luEL3JgV2of195M/OVw5DSJXFjvcs1aP/
         /UUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXozjyuwG41Mlc9Vk6WEMCElrm8w1YpeiWmgqQswciFPkGvQ6nri5l+neWHPpAGo5EA1elWUWti2aP9+UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxygX4ouwuG0rRC+QSnduOy9BexUQoITWtLaG7uUGE8MxPOyAjO
	V3sRKj9e9NkVK7mQWwo6owvl6OkR5VlehT4awOP3HN9B+k8AmN80HaErJ5UqGiw=
X-Google-Smtp-Source: AGHT+IG4BjZjQ2Z2dqGHg8e13po3OOXPlOkZEZh2gmQz0kEl9ezHR/+UkwbK17+DbKxR73ieabZKcw==
X-Received: by 2002:a05:600c:6747:b0:430:5356:ac92 with SMTP id 5b1f17b1804b1-4316161fb1dmr109088635e9.7.1729590685185;
        Tue, 22 Oct 2024 02:51:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ef1c:ae40:1300:20c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570de0sm83095085e9.6.2024.10.22.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:51:24 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>,  <devicetree@vger.kernel.org>,
  Kevin Hilman <khilman@baylibre.com>,  "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>,  <linux-amlogic@lists.infradead.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Philipp Zabel <p.zabel@pengutronix.de>,  Rob Herring <robh@kernel.org>,
  Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v4 0/5] Add A1 Soc audio clock controller driver
In-Reply-To: <20240913121152.817575-1-jan.dakinevich@salutedevices.com> (Jan
	Dakinevich's message of "Fri, 13 Sep 2024 15:11:47 +0300")
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
Date: Tue, 22 Oct 2024 11:51:24 +0200
Message-ID: <1jplnsjwir.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 13 Sep 2024 at 15:11, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> This series adds support for audio clock and reset controllers on A1 SoC family.
>

Split the reset part out of the series (I'd suggest adding VAD reset
support while at it). Also remove the DT patch, since it will depends on
both patchset.

Drop the RFC tag, at v4 I think that phase is over.

> Dependency: [4]
>
> Changes v3 [3] -> v4
>  - Use auxiliary reset device implemented in [4]
>  - Split the driver into files
>  - Use common with axg-audio yaml schema
>  - Unify clock-names with axg-audio
>
> Changes v2 [2] -> v3
>  - reset:
>    * added auxiliary device
>  - yaml:
>    * added declaration of optional clocks
>    * fixed names in example and another cosmetics
>  - clocks:
>    * reworked naming
>    * stop using of "core" clock name
>    * fixed wrong parenting
>
> Changes v1 [1] -> v2:
>  - Detached from v1's series (patch 2, 3, 4, 25).
>  - Reuse some of defines from axg-audio;
>  - Split the controller into two memory regions.
>
> Links:
>  [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
>  [2] https://lore.kernel.org/lkml/20240328010831.884487-1-jan.dakinevich@salutedevices.com/
>  [3] https://lore.kernel.org/lkml/20240419125812.983409-1-jan.dakinevich@salutedevices.com/
>  [4] https://lore.kernel.org/lkml/9a4377fe27d8eb940399e452b68fb5a6d678929f.camel@pengutronix.de/
>
> Jan Dakinevich (5):
>   reset: amlogic: add support for A1 SoC in auxiliary reset driver
>   clk: meson: axg: share the set of audio helper macro
>   dt-bindings: clock: axg-audio: document A1 SoC audio clock controller
>     driver
>   clk: meson: a1: add the audio clock controller driver
>   arm64: dts: meson: a1: add the audio clock controller
>
>  .../clock/amlogic,axg-audio-clkc.yaml         |   3 +
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  48 +++
>  drivers/clk/meson/Kconfig                     |  14 +
>  drivers/clk/meson/Makefile                    |   3 +
>  drivers/clk/meson/a1-audio-clkc.c             | 359 ++++++++++++++++++
>  drivers/clk/meson/a1-audio-drv.c              | 104 +++++
>  drivers/clk/meson/a1-audio-vad-clkc.c         |  85 +++++
>  drivers/clk/meson/a1-audio.h                  | 131 +++++++
>  drivers/clk/meson/axg-audio.c                 | 138 +------
>  drivers/clk/meson/meson-audio.h               | 143 +++++++
>  drivers/reset/amlogic/reset-meson-aux.c       |   9 +
>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++++
>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 ++
>  13 files changed, 1051 insertions(+), 137 deletions(-)
>  create mode 100644 drivers/clk/meson/a1-audio-clkc.c
>  create mode 100644 drivers/clk/meson/a1-audio-drv.c
>  create mode 100644 drivers/clk/meson/a1-audio-vad-clkc.c
>  create mode 100644 drivers/clk/meson/a1-audio.h
>  create mode 100644 drivers/clk/meson/meson-audio.h
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h

-- 
Jerome


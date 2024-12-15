Return-Path: <linux-kernel+bounces-446320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2021E9F2296
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 09:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C6C165888
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0552074421;
	Sun, 15 Dec 2024 08:15:21 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC20199BC;
	Sun, 15 Dec 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734250520; cv=none; b=glm00PHJQArRRq8I74ZdsK8hvNOCcMmHt7IMnukfzx2frunHGhyxE8zYewiQU4fALcdwRZAdqj7ZwRVuKbfZkzQvcYURKAMEm84zcfgcxPEn6qEHtdmTgSgURK9M7ngcjWsDZ6jm7OL1C5ih3n2AhEqbk2SfsPCh6A2EFAOAAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734250520; c=relaxed/simple;
	bh=MfzlMTD2QL4BZMnKQKMZj1xTmWxcCa0w/vAtL5LJle4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uq8T0zrZogXmTqcUxtdCnfQSvh74NCeZPGaYkJIvFkQ88rt/pwMo4240V9413dqREXZbBmtCRSZhuPsihB7jz778oNmApyodLeMZNhLPhPxFdEfiy8VeA96qz2FdGm0CcJzyYB4Ful5Y7Quokl1Fvi/C8nDLoQVJKz59OTIbyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so4538436e87.1;
        Sun, 15 Dec 2024 00:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734250513; x=1734855313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbW+PaUOzCwCbF61CRYPi7XMG3ao6Wxw90lcjAtKDFs=;
        b=t7o1ejUNV5jz1vIxIItcMZwpgS9EtHtq8zbeNI9EnxOGa+2uPtNnzvpedb4azJOSTj
         X9YtoRNBqGx7xbiJfsqbKeiXJtq3TeeVi5qmAWEHrjRgkWHfRTEx36zhknsEN27yVnz6
         WFFoeR0c3T7pnd17iElkVPlB1BZ8RqBt1JxpT4E0BVgO3umBa9+7dmrZ+mZnHF2VFs/1
         ZA0riSYuMTkVeESxZc3t2TigZjzUPium+VNMFfnbZElSHLU/IsiuK4dE7wc67zKBU4UJ
         vU9TsJF1272g1OLrfM814RhgP6AJ0LVYuzx8ihD/sZSl2+LoyRo3VicBivUQhEjU4dZe
         0OoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa29rfftaH8UqSW5jzmxq2SrFJtKFTvpRHEgFJoRyZ8ll4/9YFACSE/VnodK7JFlRtQ1OEMOAqSY3p@vger.kernel.org, AJvYcCWPFQDuMn+LQDwiVW2RRcTBtJNUV+Xd0LQBTfl75FTHM+Z1gNc9VbKURGVJ4CzDqcfm+YBWtRKE6Rk2Malz@vger.kernel.org, AJvYcCWdTZORS8bpcWQdzjFTilCLiBZ2RPOsRBzZMiUrpYoyrfa+RYjl77jrCeM0ADLQluWZBuWDJhe8c7px@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzpitU4ZKXF2+gsHuw/ypvSqXPBkTWzH4sdEZoOiiEeDkmtQy
	KceKjOkeKPIPQhJ/xSH9XH5jjQRlXGEAs6wAbje3O0HpLlInkbOPVEj+BJtc
X-Gm-Gg: ASbGncvi3lpu4T1l22GsFu90gzQTiZPOWgPdzrmizpl/204F+SX3HXT49MWYCtGEQfR
	bdJgh3a5D4Vpwjjq0Tm6K+0RkLupUExiocvd0SqH0fO4GiInLIlG01DwdDeh1HijRGVHXTRpgdn
	xIgIkHYmYTzwRg6XVQhdCMjI2Y2WIB5MvgWl4BbAOiuZNdNxwfCpMO0g9kqlm87H/NNKxdGzuvY
	+lkknvwZpiWp54yv6c4Q/8dXe3oQfzvRY2wWVy8rO7kFooQGh6+mnRgQ4gfHXM118ibcO+95fJk
	BDg/mZhYY4jLgA==
X-Google-Smtp-Source: AGHT+IE4kdx9KP+GTdphcLf5oLKpCZsV/Ub3q3kJzPn7HwT+5BDvQB+re7v2vmCROMO3PGEN9V8Ivw==
X-Received: by 2002:a05:6512:104c:b0:53e:3a9d:e4a with SMTP id 2adb3069b0e04-54090268d57mr2530532e87.10.1734250512671;
        Sun, 15 Dec 2024 00:15:12 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c00166sm442510e87.159.2024.12.15.00.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 00:15:12 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso38006401fa.0;
        Sun, 15 Dec 2024 00:15:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4ZviGXOVWSHQMt4bRBWyQ1kVGeUrykmm/ZuFnbI+N97zKBoOBTc37apqlf3WfsPIcXaupz9PpRxgH@vger.kernel.org, AJvYcCXCkwy+pgnmW2nRima0AQh2aesCeYtww9uZE8Iz0/5++1FEG5L4nNhLTbN3jGneCVn2whuP8x/6Xod6@vger.kernel.org, AJvYcCXoyb8ZneaKqnjRdVH88lWSH32ZOJpGjjv7m71LH6+8U7GENlngcyMtKACggGHEhpxz3wpHGW0fKd6PjUjo@vger.kernel.org
X-Received: by 2002:a05:651c:198b:b0:300:3de4:ff7f with SMTP id
 38308e7fff4ca-3025456691dmr30121161fa.6.1734250511023; Sun, 15 Dec 2024
 00:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215053639.738890-1-anarsoul@gmail.com>
In-Reply-To: <20241215053639.738890-1-anarsoul@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 15 Dec 2024 16:14:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v65odTCjkC493e=q57ikeKHWrKYS26N7-0Hjc=S_d6ELyQ@mail.gmail.com>
Message-ID: <CAGb2v65odTCjkC493e=q57ikeKHWrKYS26N7-0Hjc=S_d6ELyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: allwinner: a64: fix video output on Pinebook
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, Roman Beranek <me@crly.cz>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 1:36=E2=80=AFPM Vasily Khoruzhick <anarsoul@gmail.c=
om> wrote:
>
> Since commit ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in =
TCON0 mux"),
> TCON0 clock parent is always set to PLL_MIPI, but unfortunately it breaks
> video output on Pinebook.
>
> I did an experiment: I manually configured PLL_MIPI and PLL_VIDEO0_2X
> to the same clock rate and flipped the switch with devmem. Experiment cle=
arly
> showed that whenever PLL_MIPI is selected as TCON0 clock parent, the vide=
o
> output stops working.
>
> To fix the issue, I partially reverted mentioned commit and added explici=
t
> TCON0 clock parent assignment to device tree. By default, it will be
> PLL_MIPI, and the only users with RGB output - Pinebook and Teres-I will
> override it in their dts.
>
> Vasily Khoruzhick (3):
>   dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and PLL_MIPI
>   arm64: dts: allwinner: a64: explicitly assign clock parent for TCON0
>   clk: sunxi-ng: a64: stop force-selecting PLL-MIPI as TCON0 parent

Looks good to me.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

I'll wait for a bit for Andre to comment.

>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts |  2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  |  2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         |  2 ++
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c                 | 11 -----------
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h                 |  2 --
>  include/dt-bindings/clock/sun50i-a64-ccu.h            |  2 ++
>  6 files changed, 8 insertions(+), 13 deletions(-)
>
> --
> 2.47.1
>


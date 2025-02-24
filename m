Return-Path: <linux-kernel+bounces-529548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F45A427C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7994F3B6324
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61E262803;
	Mon, 24 Feb 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QhQA4IUr"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410972627F8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414013; cv=none; b=DM/raMCrLfLxavM2rP4HrFXarDRLVfkH6PwhJNAYL6KywAxk0APiOCzzofNTlbW4J1iHmhYeMTkJhwbvLvEn2dFJLgjFF/eXIQrnVlY3Ees6qVgigzzIcWR5KHlBTS/D/9A6zydsbGrotrAYdOQ1KmLG8XNjuevV1oKhVgXSD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414013; c=relaxed/simple;
	bh=FheqO8KzYo1Xtd5I7TGsNuaxE22xi/JqG2iXSfyifPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFDNygfrC8EBb1ShzV1ljhFX0VF+5i9/xRZxTZm0YKfq9jVl0bWCbHgHZ8frJ1/IFW/622bYZDcELmfLAgMgfODZPajh80QjOYDBwN+7u8aqKmm0ygSoT4ydppVqTdAtMJOB14lmeZwnswrRVk1gP/lWh4MErsnVn0P2I43Id3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QhQA4IUr; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72722d2717aso1238761a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1740414010; x=1741018810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ggNVg1i8dPseY+YzGhRPP522mFrqRdnWvnVFy7OGPU=;
        b=QhQA4IUrtC7dCYDUz49vFIPClkv5bmEOX24NUS44hpxNTTJcezZjEntbQx0lsptC9y
         FXZ23k2RhVYTrcoG3LOnNnwCp3zpyTHbU96QXIv1yonncD+sK4TJh5YGngrHV81E0HhS
         ii3H++lXKGR4RloNovFVdrmO+1isGu3sRLpl6qBqEc+9HSaA7wVxaGXqBcAon156k9l7
         YD5XLVAv5zN7gVIotZPupPTgbG3ITLZfhtIzhoz/P1d+aakZ9+zEFJr3FaLNsxM+Yc2h
         EfmXszLgJuoAQtd2vWmPGggm/VxsfH770GmoXy/q45Ussz+dOMBmswptCVowdQBPFmnx
         ki3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414010; x=1741018810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ggNVg1i8dPseY+YzGhRPP522mFrqRdnWvnVFy7OGPU=;
        b=Kq1zXRD+0E0iOS2bfwF7qgmf2iSjWaW1Oyvcv6QUpLJngOalkhusITlhSIbBHDDiX5
         /TD6kpDAISC4F3kf5V80I7vsF95o0uyQF9rRfpUKN2TWF/B6yhDVrNowEujOLIN5EKwx
         6EwmSG0Y0jQ2ryovh6vkDs5FJB2ISJdnKNtEu8gCtznRP4Jf2vOHJRWPnAYrCLJfceg6
         lWFVxEcXa3nb9dcj9+A/Yre8bzOMVsJ1A/tfOXde8HeF1SM0nD/YDfLNRcs8ellImoBm
         EPt0dTU3g2aa810psMp2vM9jNuocnm2U5Dzjciva+Kpdc2tlcgLja+mNJEER+pE97kKF
         4fhA==
X-Forwarded-Encrypted: i=1; AJvYcCW1tES70QQJLsy6VvchL7tySQNXggcIjW+2pZDnVCGkdcCTuu6jYzAyCCPfMyvxdko75aHt+hlkWvkqCHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5ITjFaI0Z1iTL8nCHSQvjv8qhDhEvT0haHSwnYS88ebGe6g/
	mkUgj8s0o2LmxHDDA56ZsZDxS6gEOQnw6gk0FPbF9OrRAjBEvETp/HEQZNvxmjs=
X-Gm-Gg: ASbGncvv9nP51v8jPbgO7SFFuKp5Qmbc7bt7MvqmHyjfq0roYxvAzCEg0FM7eTRWp5N
	nhgQxNHbfIRT/yOOrR+5sXzbCZxsIQo1Db0+o69L2jYmORtZSFTbJ8uPLfu0MDd5PIEeKXNpLHB
	n8jwdyIivMps5HxHhiQEvR1ELJHdlU/r1nRFoVQ8856W7Qyao4Y8HenyWrZEyjyq7tg8lSD4Z4s
	LZFG8YXYTiBukmSXPHzunSZ+91rV7zU9RQoWEytsZHYuLCH/tOb7RbestCyENyY2r5APc8XwjmN
	cfsnmo48RyU1GruIOn/m3JPCQCYSki0iE9IP7P9ZKyMB4nd/QDDKaBVEB7VUwm6Erw==
X-Google-Smtp-Source: AGHT+IFCWs+0CCuJamgGPiQVcYx+xUj/OyX9/a5EIgOce/keywE1eBKMEV5gEit7BDGyEshCJIcKAw==
X-Received: by 2002:a05:6830:700a:b0:727:3a2e:2132 with SMTP id 46e09a7af769-7274c24724bmr15027042a34.21.1740414010164;
        Mon, 24 Feb 2025 08:20:10 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727378237e4sm2656892a34.47.2025.02.24.08.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:20:09 -0800 (PST)
Message-ID: <96a72cc3-5c89-48ca-b535-8a9a5cfb52c4@riscstar.com>
Date: Mon, 24 Feb 2025 10:20:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] clk: bcm: kona: Add bus clock support and
 prerequisite clocks
To: Artur Weber <aweber.kernel@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, Stanislav Jakubek
 <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/25 10:12 AM, Artur Weber wrote:
> This patchset does the following:
> 
> - Introduce support for bus clocks. These are fairly similar to
>    peripheral clocks, but only implement policy, gate and hyst.
> 
> - Introduce support for prerequisite clocks; this way we can
>    make peripheral clocks automatically enable their corresponding
>    bus clocks.
> 
> - Add matching bus clocks for BCM21664 peripheral clocks and update
>    device tree bindings to match.
> 
> The prerequisite clock portion of this patchset is adapted from an
> older attempt to add bus clocks[1], submitted by Alex Elder. I've
> retained his authorship on that commit.

That was a long time ago!

> Notably, Alex's patchset moved clock initialization to the prepare
> function. This seems to be incorrect; the prepare function gets called
> before the enable function, but not before "set rate"/"set parent"
> functions; thus, while clocks enabled fine, any configuration done
> before they were first enabled was broken. I ignored that part of
> the patchset and only kept the prerequisite clocks.

I think you're right.

> I would appreciate feedback on the prerequisite clock patch, hence
> why this patchset is marked as RFC.
> 
> I wasn't able to find any other driver that does something like this,
> so I'm not sure if it's correct (especially since I had to switch from
> non-locking __clk_prepare and __clk_enable to the regular locking
> versions, as the non-locking versions are no longer public - they
> appear to have been replaced by clk_core counterparts, but those
> functions are not exported anywhere AFAICT).
> 
> An alternative way to do this dependency would be to wrap every
> component with a relevant bus clock in a "simple-pm-bus" node
> with the bus clock in DT, but this seems rather unwieldy.

Yes I had the same thought, and ask about this on patch 3.  I
can't comment on whether this notion of a prerequisite (that
is not its parent) makes sense though.

I didn't look at patch 1 or patch 5.

					-Alex

> 
> [1] https://lore.kernel.org/lkml/1402926007-4436-1-git-send-email-elder@linaro.org/
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Alex Elder (1):
>        clk: bcm281xx: implement prerequisite clocks
> 
> Artur Weber (4):
>        dt-bindings: clock: brcm,kona-ccu: Add BCM21664 bus clocks
>        clk: bcm: kona: Add support for bus clocks
>        clk: bcm21664: Add matching bus clocks for peripheral clocks
>        ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks
> 
>   .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  18 ++-
>   arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 +++--
>   drivers/clk/bcm/clk-bcm21664.c                     | 107 ++++++++++++++++--
>   drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++++
>   drivers/clk/bcm/clk-kona.c                         | 124 ++++++++++++++++++++-
>   drivers/clk/bcm/clk-kona.h                         |  30 ++++-
>   include/dt-bindings/clock/bcm21664.h               |  19 +++-
>   7 files changed, 411 insertions(+), 31 deletions(-)
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250212-kona-bus-clock-4297eefae940
> 
> Best regards,



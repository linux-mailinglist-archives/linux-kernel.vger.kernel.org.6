Return-Path: <linux-kernel+bounces-292163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E53956BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861CA1C216B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140D216D4C7;
	Mon, 19 Aug 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPVEgfII"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC016C68E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073702; cv=none; b=CGWQZuwyZ9D6lFK3dtQk9XKhCI3X0mD4n6qaDlI1mMOFRz2uGhGM4lyAPIxX507b02oEJzpPkaHgXIP3ndWMaCijAauzMS9BAbrgjiumCQsZP7bbZZ4jrHFVbn/Rm7FSsXMFjPMZHzUQJxzkyPl8MW1FfCgO+GyWOg+UE2U3U5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073702; c=relaxed/simple;
	bh=j0Iwlg5j4dadwelZ87XP4p9m3m2RHVP7vOYFCf9iK3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pERTlX0gGbVkjo4UeGegiwjx2VjQuSvURGQ21gGCbAdCbQQBzEPKV9ZwginLUCg+NRzbj1jwwlBjRgi2pIfUGgCWQc3MrHeEisGCsq5w2c31b1g69si43HWGIG9DkxCYyx7jGNZgoNvIdY2ud+BL09eTpEP85pl8kf4RriCfRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPVEgfII; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42816ca782dso36215495e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724073698; x=1724678498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8W0rWQ9WRd8jkw4uMXP1Owfz1hG5dsk4pMOhNyblTc=;
        b=pPVEgfIIGI692/x7WWwQoCH0NMy3i2N1dUv+z92zYdsjSZcwpWqBxmB6AtdK4qY2VF
         SBNEoYUFFMyB5KGQhZufyWZhFVAZpANqs2iYJgHLb9d+DCyNZbaub3s/DHxFpVsSj2Wl
         +7FK32WzOOHqWl/qfwPlKtziQOUPAsY2OeguIYWG/oLvUvzj6Hkx8W356ncCOZdHS8A8
         DfL+8riv2FRXor5Bk0t+2rmrdtfXI/n7THFXLBRjvCeFPZV4pMTr9cx/NRUl0B7rWjn7
         Md9DTCdmAie4TNKzOhMV5JuAMpfhricdVvJiYNhbIWjczenLsN0o+NGtgnjTj7S7jDlA
         dcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073698; x=1724678498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8W0rWQ9WRd8jkw4uMXP1Owfz1hG5dsk4pMOhNyblTc=;
        b=IVR4pH/3I8np5zcAMz0adZibruqwLIbk4qudFeiDTKcNxZ/Fv80kF9B3A87IK/CZ7F
         0ztCFBPRL6RonvpnbKhWgRLzxfToTxIZNSb9EBYjf5ViZ6sfUZHom6/J4ookemiyU08Y
         zn9Gp++ovHuIe//5vDZUjn24u97bRZv8pLR+4mSYATKPScr8GJT0Nxnqw7v6zqQfAqmo
         R0LmpGq9TDqGXIqVBgp8+kGyXC1/g9udWVy5/wOZkkgAtOmvrEIRKkit674MfpowC460
         AbT5BLtVdRWYo6AdSfGkKvG7CI1jbZCtHvTXV8Vprc5zex6CQE7rRC4Djdhrppei58sk
         oRrw==
X-Forwarded-Encrypted: i=1; AJvYcCXTIALLd/M8XDSomdTeBwLrL8yngRB8qr7UzbSxp5Wjm05H5rUcbxEaUgLmATGOrzom3S7SpywxD4YPMZcRdy34XKw1kM5jmoPay5y8
X-Gm-Message-State: AOJu0YyiydDGkygzDoO/VNy8J0ZFFesYWCbU3gxQMZptt2ugwQCDZ+Md
	hLG9aV4ZJPflfdGeFz8O6YEywReC+ONNKpMqIW9H0MWu/+AmOy9zQbbKqzIe5BM=
X-Google-Smtp-Source: AGHT+IG1Ebty4eoa3hakMU7RnYW00yXWrugH5vrGNipfdhauCeQQwc6vY+Y5/aPSe/glQvDuDFNt8g==
X-Received: by 2002:a05:600c:4707:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-42aa82492b1mr58241405e9.20.1724073697922;
        Mon, 19 Aug 2024 06:21:37 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37189839f9dsm10601679f8f.20.2024.08.19.06.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:21:37 -0700 (PDT)
Message-ID: <b88b6200-b92a-4cf3-946a-3c38cff886ec@linaro.org>
Date: Mon, 19 Aug 2024 15:21:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clocksource: imx-tpm: fix return -ETIME when delta
 exceeds INT_MAX
To: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>,
 "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <20240725193355.1436005-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240725193355.1436005-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/07/2024 21:33, Frank Li wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> In tpm_set_next_event(delta), return -ETIME by wrong cast to int when delta
> is larger than INT_MAX.

Is it something you observed or from your understanding of the code ?

> For example:
> 
> tpm_set_next_event(delta = 0xffff_fffe)
> {
>          ...
>          next = tpm_read_counter(); // assume next is 0x10
>          next += delta; // next will 0xffff_fffe + 0x10 = 0x1_0000_000e
>          now = tpm_read_counter();  // now is 0x10
>          ...
> 
>          return (int)(next - now) <= 0 ? -ETIME : 0;
>                       ^^^^^^^^^^
>                       0x1_0000_000e - 0x10 = 0xffff_fffe, which is -2 when
>                       cast to int. So return -ETIME.
> }
> 
> To fix this, introduce a 'prev' variable and check if 'now - prev' is
> larger than delta.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/clocksource/timer-imx-tpm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
> index bd64a8a8427f3..cd23caf1e5999 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -83,10 +83,10 @@ static u64 notrace tpm_read_sched_clock(void)
>   static int tpm_set_next_event(unsigned long delta,
>   				struct clock_event_device *evt)
>   {
> -	unsigned long next, now;
> +	unsigned long next, prev, now;
>   
> -	next = tpm_read_counter();
> -	next += delta;
> +	prev = tpm_read_counter();
> +	next = prev + delta;
>   	writel(next, timer_base + TPM_C0V);
>   	now = tpm_read_counter();
>   
> @@ -96,7 +96,7 @@ static int tpm_set_next_event(unsigned long delta,
>   	 * of writing CNT registers which may cause the min_delta event got
>   	 * missed, so we need add a ETIME check here in case it happened.
>   	 */
> -	return (int)(next - now) <= 0 ? -ETIME : 0;
> +	return (now - prev) >= delta ? -ETIME : 0;
>   }
>   
>   static int tpm_set_state_oneshot(struct clock_event_device *evt)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


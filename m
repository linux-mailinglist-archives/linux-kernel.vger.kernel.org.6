Return-Path: <linux-kernel+bounces-300097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F7D95DEC9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E42B218B8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB4F1547C0;
	Sat, 24 Aug 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UeP8VMU1"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C26A947
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514816; cv=none; b=ZAiYDAmIhhP1rcF78VRvJbczsxK6lkY92mK6NteYye6JIidh1X2ipS1epoxBsjcS9MogdNpYV/epB90u2zUUcANLqnCjJscWTkF8Z1YNK0T7N1jKrauRgp3yLcQ249waYRQ1e60uWpi4bFbyuNLCIzstiREO8fGSlxZuK9U7SYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514816; c=relaxed/simple;
	bh=Hgk4/oHKtU0z6EdJ+JUgoxdStaDrEfvcEdgsgJBagY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLTmitxIMT9muQ8E+n9ygTaTg3WYB0CAb/bURsl7uMC9wNAMY+QbOgoJTMMPFS8UmyIPJBQ1oCyG98l/uvYSbJTtDY995U6e123pUroEc9Doq8lA4MTNXBnxRBedP8v7SIuw87H/PZQcgbdbKMMeJVXWOqGv3PjL6WP2PJQw0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UeP8VMU1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so3665202a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724514813; x=1725119613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLkI2aUTuni9NFuB5OOLVo8J+M0TP1LBFtceUNfr7a8=;
        b=UeP8VMU1/0BQq5PEzXhc8wMAC87ToMUt8jumiGryvdFLVyKENJHJW4WyOwxV0dpdAK
         fdCLXmyktgxmkg9gdxRMBgFpcnWYCDnXDvo0hZqMpBqrNe/V2Z3wYtPRVI08BKSnrfwH
         QsEfA/2LEMLWpQB1e6QKuM928K2WARv6ybONfIVzI8MqHZ68OybRUxAiTQXbTZoQJc2W
         5SoJiqFNkpfN8y7jtBcj+Adw/ZtZLKobLfSCW7Rk1jCcjy9kkxGdAKD+PrfLs144q7+t
         ResursGQHSC5TZoD7fsfMTIjuX62DCdql3cqgEw2Pzwtna1oCCpkv54iBzFFZsjmYocc
         TOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724514813; x=1725119613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLkI2aUTuni9NFuB5OOLVo8J+M0TP1LBFtceUNfr7a8=;
        b=FVXayN1AV+U1bcXBlh91PsXIbK1irNxio9Rw5uooCOoIaJiRFlNeEYn3LQJkM40USK
         jRpmKiFjGqA5yyBPeDDPp5rQ41R4OM9uFsRaLLjJNM3LOI5zHC+9j51vkRCKUz5TZkhr
         0TeFiPTE0A22ljU+dAsRwTh8CC/pWXowiCKaYTVQwc8AicxEZ1jeLuzfH4Cq02IkQkXU
         M7rJSjcBaVBCZxCDtA6jTjQVFM9ET55sYHyj/yXbW9DCNA4gdDvcx4tZo5G+YnMH4Qw6
         3LLzefHN5aqipRBYv0JUfvsYxkI2DuXSiLx93Tv0GOMLD0VCY0i2VTJ6TEC6NqUiyhSB
         svqA==
X-Forwarded-Encrypted: i=1; AJvYcCVaeFn5SCooPNxZdSMgA86Ex0jviW5n3np7/CiXebvAbtNjGaKIxwEhnUZY/Nv0m9fDsmTVqGoG4F3pTbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8L5QvkoY+uYgvCtz1S6101OOrmgHpxg/itLYzCo2tMgWRsuh
	796krH2xAZXwJ4tOxO89OuV2jdLNSAu8rOoO43QoadNpp7YVLytYHhEKWT6AIp8=
X-Google-Smtp-Source: AGHT+IGDaXHidgJHARyBVubzO2NqL+q6YUKRQZn6433SWaj5ajYCUpE1q0Y1qN+NTxESjaN4CpGx2g==
X-Received: by 2002:a05:6402:90b:b0:5be:bcdf:4110 with SMTP id 4fb4d7f45d1cf-5c08910fb32mr4066408a12.0.1724514812785;
        Sat, 24 Aug 2024 08:53:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca4d2sm3434336a12.36.2024.08.24.08.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:53:32 -0700 (PDT)
Message-ID: <25dcd6bb-5586-4b32-9a12-7e82126cc876@tuxon.dev>
Date: Sat, 24 Aug 2024 18:53:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/12] nvmem: microchip-otpc: Enable main RC oscillator
 clock
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-12-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-12-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.08.2024 13:59, Alexander Dahl wrote:
> Without enabling that clock, initializing the packet list leads to a
> read timeout on the first packet.
> 
> According to SAM9X60 datasheet (DS60001579G) section "23.4 Product
> Dependencies" the clock must be enabled for reading and writing.
> 
> Tested on sam9x60-curiosity board.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/nvmem/microchip-otpc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index a80535c3d162..047ca5ac6407 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/clk.h>
>  #include <linux/dev_printk.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> @@ -54,6 +55,7 @@
>  struct mchp_otpc {
>  	void __iomem *base;
>  	struct device *dev;
> +	struct clk *clk;
>  	struct list_head packets;
>  	u32 npackets;
>  };
> @@ -272,6 +274,15 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  	if (IS_ERR(otpc->base))
>  		return PTR_ERR(otpc->base);
>  
> +	// NOTE: Maybe make this optional, especially if sama7g5 testing

Looking though DS, on SAMA7G5 the clock here should be MCK0. I think it
should be added for SAMA7G5, too, with a fixes tag.

> +	// shows the clock is not required there?

Use C style comments /* comment */

> +	otpc->clk = devm_clk_get_enabled(&pdev->dev, "main_rc_osc");

Maybe name it "bus-clk", "bus" or something otpc specific.

> +	if (IS_ERR(otpc->clk)) {
> +		dev_err(&pdev->dev, "Error (%ld) getting clock!\n",
> +			PTR_ERR(otpc->clk));
> +		return PTR_ERR(otpc->clk);

return dev_err_probe().

> +	}
> +
>  	reg = readl_relaxed(otpc->base + MCHP_OTPC_WPSR);
>  	if (reg)
>  		dev_warn(&pdev->dev,


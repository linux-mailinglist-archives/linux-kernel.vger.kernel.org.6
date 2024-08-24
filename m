Return-Path: <linux-kernel+bounces-300095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DB95DEC7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493E7B21AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F94558B7;
	Sat, 24 Aug 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Hd4BuRHa"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CC1EA80
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514723; cv=none; b=pU4Ok9HxAnZqGWfEBjvVd/XfCIqSm9Tb9kPywPhy0k7usyD0DhrR4K/zJSm24dg7kHk/JiLYSOjN3ctVCD5s9ZMLkVrjpGizsXenFCxLmlwDpQHbXZim8zDKODroXyaAbnJnuARi5MH6S7pSV3chRTZJ9vOIM0jFcy4lo602mKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514723; c=relaxed/simple;
	bh=rW2sxUVSBvBI5YFMPcWWhp/nJGn4eDQgjt8ZjyHvwGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho34bIk20aHumOq24XDeavJ4TlLzcJ5TDwIn8zjr1vTYsbE9yGG6BFE3Y86Y7WKr5++yTal2fXpYUZbjvQ/gnMCgXaNWH/k0FzDLSJVrb3uQYiqtBmJclXEqI0NdbUZhhHIwc5lPGR/o0YUxDx7HtnCTjju6PDevKyLiaDQNyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Hd4BuRHa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3259514a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724514720; x=1725119520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCg5OorKlBAHROrYO2ZfTtcwqgG7V3PagN8azZBb/l8=;
        b=Hd4BuRHaQrWFER3JRTsLudvlG238GuItz6ZRGu5Rl57ndr3PyOhDO7ZOUvx+MGaL2K
         HuSVkv31l0mSlEjS6LQoOvK8ESfKkYfu/0fhtCrq8o9frI9Mrc48Yzg9nVMPWcpfIc+H
         h0CAa0pn4I5XoIX5Qn0Udzv2BYb58qqKtBwwc1NoO2C9MgsB0D7qOklvAWWtkOAHrrwZ
         a8MLBQAU6oyf+fsDfxOo0Kpq1X49KzuLJ8A6i5YKrFNc39fEgjqMqy4PRN2U7LwG32zm
         Otkr5kRWdTaf/knvH4Q+q8BO8Ohqkdj5IUAszlkdCaSbd4Y+KjQm6TGK5NSejdVi95iL
         9OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724514720; x=1725119520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCg5OorKlBAHROrYO2ZfTtcwqgG7V3PagN8azZBb/l8=;
        b=gmi7kkijw/5Wt6ffHmDH+Wq1rsB5v0u/8jik9hd9xvmlLLKnHCbikep0beVymW5mUc
         hg0iDvqK81jnHtmnVBBNmQH1NpftEgj4N7UlpoNtlmEF073axpaUDPRxfy96POErEnmE
         cvvoNM4CEe/FV9Q+VN+7C2ca12NE11vKRo7h0G23WPoP214NhnHZcQSJcy9MhYhm6LA/
         dmS2zM3Rhr7lUAxT8WDpC3YW8GyHsWXhK53SdeFD1HsjCOHK6mJxZpcabIlbijSfyfx2
         MAPNAVjP5IRk7I04YS0AGvysK0tKwZNqvjwFAyr+XM2q3v+qguUuGRLxZuwbqqlfNwA+
         A+1w==
X-Forwarded-Encrypted: i=1; AJvYcCUZS5wxTho6dqpBs95v5brFdRh9nKfp9keXxpsBc4NHljt7L6zKfDIxeMbe/0NVGtxVO1xeGo7/bTWy3EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Ma+0t/NetvKtLr2UUyH6+IIgDP7EGy596v24LVClEpjxUfMt
	cz3kRAjDBp8Mj1z8hXT5Rb9Yxa5DhMnXibYSpc4WhmCbq2+e4tlYowEs4fWibNLEPMnOnY9/nQ1
	f
X-Google-Smtp-Source: AGHT+IGnvRBB5iGZS5/47q/ZS2oxbBkiapkk3Yc+2ESx8jIhguHHbIais5ImAUOFMgYiDWGTcFwQyg==
X-Received: by 2002:a05:6402:280d:b0:5bf:38:f648 with SMTP id 4fb4d7f45d1cf-5c08915d123mr2731396a12.2.1724514720369;
        Sat, 24 Aug 2024 08:52:00 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca4d2sm3434336a12.36.2024.08.24.08.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:51:59 -0700 (PDT)
Message-ID: <f514b2af-e2bc-4ea3-8630-937c6c05dc31@tuxon.dev>
Date: Sat, 24 Aug 2024 18:51:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/12] nvmem: microchip-otpc: Avoid writing a
 write-only register
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-2-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-2-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, ALexander,

On 21.08.2024 13:59, Alexander Dahl wrote:
> The OTPC Control Register (OTPC_CR) has just write-only members.
> Reading from that register leads to a warning in OTPC Write Protection
> Status Register (OTPC_WPSR) in field Software Error Type (SWETYP) of
> type READ_WO (A write-only register has been read (warning).)
> 
> Just create the register write content from scratch is sufficient here.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Maybe worth a Fixes tag here.

> ---
>  drivers/nvmem/microchip-otpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index 7cf81738a3e0..03e60b99f2c9 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -82,7 +82,7 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>  	writel_relaxed(tmp, otpc->base + MCHP_OTPC_MR);
>  
>  	/* Set read. */
> -	tmp = readl_relaxed(otpc->base + MCHP_OTPC_CR);
> +	tmp = 0;
>  	tmp |= MCHP_OTPC_CR_READ;
>  	writel_relaxed(tmp, otpc->base + MCHP_OTPC_CR);

	writel_relaxed(MCHP_OTPC_CR_READ, otpc->base + MCHP_OTPC_CR);

should be enough here.

Thank you,
Claudiu Beznea

>  


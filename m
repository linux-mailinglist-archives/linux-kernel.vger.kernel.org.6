Return-Path: <linux-kernel+bounces-398284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0499BEEF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DC2286C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D801DF747;
	Wed,  6 Nov 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="V+xM+729"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867A13AD11
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899403; cv=none; b=htDOaUvHCAWi3OC/ER0LiKjMBcHkYddxyDITOoCpUuCfvCR0lGF5qMPKSMHb71G6Ne3WBQkCv/xE1MHfxZ+EI4F8St+Uu3gKWecki+1XbrrYWN3k3WHe6S93q2+JARIoh8i+QTs7MWOnXe3gfsOD/VAF74LcIuRod7SRZO8C+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899403; c=relaxed/simple;
	bh=MYzngtFP/0VquOc39xPDda1muKV2r7FBWa/dVjhLMB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHAPYt5rxuGENYLhrMMugnlJ8yEBmsAw4BrJ2ndkpQ7XmgBIwOs3fX4K7IzK2+bO/CCxhF4mWwv73zxh39YXdEC/e5nIimE/PNNGaIa5gMecHixzah9vbSUkKlID3JHE0XeDYtzr3XvxMp0IX32Ema3hEIq88/Ghd8LQogfgmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=V+xM+729; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83aa3ced341so249848239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1730899398; x=1731504198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvbC08yvW1+eqm0ij3BDRpcWHRsnk8Vwjo+EayjDVtU=;
        b=V+xM+729HIF0StaGL6lXwvfkB5MPXdOxXM/q2iH2fb1yla5g7EIqDr9Pc1FH5BT+4g
         aKQvYi7nmaj4If2DgJB9BzvzSOa2J/2lDrvJPvOiYhYRnOS/NIspNwkHY2AuuIRuwwug
         X1fiIRvCuvxf+7kK6SLHbI3BGsgE1dzRttdO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730899398; x=1731504198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvbC08yvW1+eqm0ij3BDRpcWHRsnk8Vwjo+EayjDVtU=;
        b=I1mNgND4YjzML9FULccbI0hDYwKbeyC6SUS5IWNBorZ3/Uo9kQhL9fN5RAPth0kHHJ
         5rZIMvt1blDLB7prU3GjhuXmW1NJ0aHjOFKBJkLiqgsvUDsIQFja6jTxTZnwGuOfxHBG
         lYmkIGN+bKXARXhrst5btFJs2O2OaqpVEQ/VQW8kSpfk8LT8id+/XzM9ybwtazp300VE
         OIcOePaDTpYbM0bOOmlm4jMdqzWt3t8lbc5G6sb/GEXi/d21VaUbK787FoyhQVy4ICvk
         zlDH9Mn8oj/hWHYobbyP097fM+lEMpZ4p0gtix9To3UiBRzvqIPBn4ua69wNxSYDbLes
         Lg+w==
X-Forwarded-Encrypted: i=1; AJvYcCXwiuTrNdvbpohn1iLi4SJh+evFvHtDAsyOS/fk0/LN4YSR2PW2cS0trafwMfgLx2VW8MTaw+w7d0MLCK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxTd5QdFdTb+Q4xiPGOe6lzSdJbLpvmhJAq+5Dkn67FIVwpoH
	skstVQkoEB+GGWq8n2RDpJRAV6GDavMnt3Ov9w0fejrNLYAHa8hWW3hKzstITw==
X-Google-Smtp-Source: AGHT+IHbqwR7B3eVmE9F/lWy/V/XK5+ENJpr7w8o5TU778A+kAokEQDMU/5iZGUsEydWO8j+npXxNA==
X-Received: by 2002:a05:6602:1695:b0:83b:2167:650f with SMTP id ca18e2360f4ac-83b6503964emr2926999139f.10.1730899398332;
        Wed, 06 Nov 2024 05:23:18 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-83b67b23aafsm313767039f.13.2024.11.06.05.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 05:23:16 -0800 (PST)
Message-ID: <6c36f9d8-b6ee-476c-9daf-feb2fd7ef15c@ieee.org>
Date: Wed, 6 Nov 2024 07:23:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] greybus/uart: Fix atomicity violation in
 get_serial_info()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, dtwlin@gmail.com, johan@kernel.org,
 elder@kernel.org, gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
References: <20241106095819.15194-1-chenqiuji666@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20241106095819.15194-1-chenqiuji666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 3:58 AM, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but
> get_serial_info() does not. Fortunately, the impact of this is relatively
> minor. It doesn't cause a crash or any other serious issues. However, if a
> race condition occurs between set_serial_info() and get_serial_info(),
> there is a chance that the data returned by get_serial_info() will be
> meaningless.
> 
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>

PS  I was going to suggest computing the close delay and closing wait
     outside the mutex, as get_serial_info() above it does.  But it's
     minor and there's no reason to hold up your patch for that.

> ---
> V2:
> Modified the patch description to make it more concise and easier to understand.
> Changed the fix code to ensure the logic is correct.
> Thanks to Johan Hovold and Dan Carpenter for helpful suggestion.
> ---
>   drivers/staging/greybus/uart.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index cdf4ebb93b10..8eab94cb06fa 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -596,11 +596,13 @@ static int get_serial_info(struct tty_struct *tty,
>   	struct gb_tty *gb_tty = tty->driver_data;
>   
>   	ss->line = gb_tty->minor;
> +	mutex_lock(&gb_tty->port.mutex);
>   	ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
>   	ss->closing_wait =
>   		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
>   		ASYNC_CLOSING_WAIT_NONE :
>   		jiffies_to_msecs(gb_tty->port.closing_wait) / 10;
> +	mutex_unlock(&gb_tty->port.mutex);
>   
>   	return 0;
>   }



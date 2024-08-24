Return-Path: <linux-kernel+bounces-300096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5795DEC8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BB3B2143B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B9153820;
	Sat, 24 Aug 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lFyzQ8Wy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297A17BEAE
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514747; cv=none; b=HOZbgf5JV2Bd3MPQ7o2Kt6f3owUMSjs2gPIzkwjwZ/HV8plwqdCdBytOjeYI+HASPkSpOfRKu1P76ZhM5E7X7LmQTyy9iMBOts99t/dQ4rHYhWbFCKc+OS595Kn+UOLyTc+CQNU8TdXtdFuK6BubUpBBu/zf7zdKRh/Jw1LOf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514747; c=relaxed/simple;
	bh=UscsqRBakg4HeW245uPTb+UM3EIvB0GtPhvXql4Y2/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bd/xZvFM69Nh42445QSWIjyE7XWn6ADj40qccPJX49KgX5YXiy7lgxafAr8UYlhDnF68yEmGDhh6Rbkr4khNV2TvJP6/Y4XScUDokmoiPI0T3dQ6s/eiW4bVzjPHeP9fuEHYlV0po+NuhM6X5mQg0DQaW0bt3qJGC/Yua5FT5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lFyzQ8Wy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so3664696a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724514743; x=1725119543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ts73yed3JhHDo+YK42L9Fku1808x980k6/11d2gW9QU=;
        b=lFyzQ8WykHvGmR12OLU6VYj5vC8aZ6hBos9mxJtYw+LszkfYwufatoFKIMeKbgL3Gl
         VFvX49ar6OYrbQXdW/bV96zAf2fIyxU402DVMPvOFWkwJ3p2QlHni8+51a80y7Uy+10J
         EWkJCai85qUf8/d5W920hyN8QnEno+/NwGwdALTkZ4bZfsjCA+qkS//if02pzhde6xTo
         HgmaI6NrT7dA2BIhfJ01YyLokQrJAUL9NfL4N9JXpIEvWhvggq8dlV5FRA6Tb8yUqwTI
         cXLnXuoDYXB2zE3v6RWTCnRUNEf3Ur2GjrlmtXP9keUpC3kks5OeBkP8Ru467FVc3xSb
         QlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724514743; x=1725119543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ts73yed3JhHDo+YK42L9Fku1808x980k6/11d2gW9QU=;
        b=J5lCKPiARPuJHYat0FwdFjzgRoqgKGiaRkqru0sRs6N2Y/eL4zKHWz0bSNzuqAk1dY
         feYU9bAzKcjYQOQQsXwsoCGfQ5Jx5qu28urDXXaNrWxoiHlOj1OvGFGpeG1dbbXjryZu
         Pxx174y5xPXHPGJQDDMkKc9QrJ/aBywxyptrtDkYFabZoTb+eajugJR1Z37f6sTvLl/x
         4WufoViTaJ9cvIz6jz2uRGfqlVHim3+Nvaj9Cinlss7wngW85Ok9u/I5DVX4A5j33MaK
         e0Bso4HNw1x2jYO8+IGyJaK73xTkTSxGpQAM75aylZKf2FRPwmafcn10o3cFW/RA10sG
         eRdg==
X-Forwarded-Encrypted: i=1; AJvYcCUcXQEdO4lZNRB+RnWM3a8aJZrFk/OEGve46PXx/T/vKuhO9CVgVZBV07J89TuPTb/Nyt5MEzBwq3tI6mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIoD6jxxXNJX+iVZH7Iznyg5KS37uI7wHwZcIpSKs877uVs72
	B0eTNA5TJmJEI1ZT0sRtx6qP+u6WiS5MxvyOI2zlzjXZkAFlSrRNQTyO7D8RzFU=
X-Google-Smtp-Source: AGHT+IEnJZtV4Ze0E6JNWBH6viCIKhoMr/dfysrAhp34zkuHnlBsykCKThEEITNVtsIYdMlwRWMDdA==
X-Received: by 2002:a05:6402:84a:b0:5bf:c8:774 with SMTP id 4fb4d7f45d1cf-5c08916a0c6mr4087470a12.15.1724514743513;
        Sat, 24 Aug 2024 08:52:23 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca4d2sm3434336a12.36.2024.08.24.08.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:52:23 -0700 (PDT)
Message-ID: <7c06dbdf-e76c-483f-9561-9aebf8811547@tuxon.dev>
Date: Sat, 24 Aug 2024 18:52:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/12] nvmem: microchip-otpc: Fix swapped 'sleep' and
 'timeout' parameters
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-3-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-3-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.08.2024 13:59, Alexander Dahl wrote:
> Makes no sense to have a timeout shorter than the sleep time, it would
> run into timeout right after the first sleep already.
> While at it, use a more specific macro instead of the generic one, which
> does exactly the same, but needs less parameters.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Please add a Fixes tag.

> ---
>  drivers/nvmem/microchip-otpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index 03e60b99f2c9..bd3383eabdf6 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -87,8 +87,8 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>  	writel_relaxed(tmp, otpc->base + MCHP_OTPC_CR);
>  
>  	/* Wait for packet to be transferred into temporary buffers. */
> -	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),
> -				 10000, 2000, false, otpc->base + MCHP_OTPC_SR);
> +	return readl_relaxed_poll_timeout(otpc->base + MCHP_OTPC_SR, tmp,
> +					  !(tmp & MCHP_OTPC_SR_READ), 2000, 10000);
>  }
>  
>  /*


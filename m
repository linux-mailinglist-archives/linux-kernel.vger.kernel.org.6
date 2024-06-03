Return-Path: <linux-kernel+bounces-199116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E718D8258
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB8E1C218EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C47812C473;
	Mon,  3 Jun 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AF4aKxB+"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149E64F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418095; cv=none; b=bg0fQGRFztMT0KMFOGb//+6jwovheh9wtMVhkPXdeeiyMkZjtzFgUCIxsVtNsIclG/cVs+VGgPRMmJtvea8jvprzVgWHswRB0ih1da987zySqefBKjCu4GisbPtlgNH3wyr6AaQaLw28RDKT+Zs76zDRVIPrLThKtc3Smuhb5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418095; c=relaxed/simple;
	bh=yI5u5wUiXcIr1CXdNjn8aKUwswP4fbQVdrpLyFYQ0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1ujMFrQlhrW3x71t53Y9nyG50v9UeSOsxhxPKgHZHHIqBLm0R61GVCa7dKHiWXoD2sSyONduOgfcWUY0t3Wk4tXQrg5bw5+y1sfqj+ekzfl2m8/TRUeYeS6y67Syb0lZ0Pq3GzXcNnCpCTusWsG/c8GL7FprGgyrQqj01ivXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AF4aKxB+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3550134ef25so4011598f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717418092; x=1718022892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYnk7Jhk5XQEe5qdju2BLibwhg+AiDV6NTuQ4IZI3jM=;
        b=AF4aKxB+qBDDBZP28KIXT4cDRTepRl3Poa+5owQ3QlqZsh121k87/c8uy+5/4HWcb4
         hXkVY6pE5JAYRFk6Sm2XeRO8jLx1lGYW9B/eR/bLUiwpIJhvhNj2xh3PYxeanV3P8cSD
         /EtI1skUw3Dac7iu+R7gnOxetcWKjhxSSY5K7za/RbH9MczHWY/NEfd2QztlQTj4Neeq
         V/zq+hYF/2STIRpQa69G5z088RB3Fi/7PNs/m/r8ndVCeU3GEGpUxRpjj7deK1XKTU2G
         0ExZr2vgUNNPEe8h0m2HH41vpxHZnPpoAFbHBrBd3h0G7uYSJM5Zd9LWlrOasqmU6ce8
         SJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717418092; x=1718022892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYnk7Jhk5XQEe5qdju2BLibwhg+AiDV6NTuQ4IZI3jM=;
        b=O/L6ekrlNeLXC6T586jsmDxXnwGfrtBP9R8yAjjuDczrhSCV3OjgSmUypB1JM87S4E
         MGCu7UOcnivIxtrwFgxVwO5eSAb3FYIpn2NO2xFt2/g2OnP/WfkDoV+72/ZALKt4GHy9
         /xzw9i1qY1dHwWw8BufosV0tcFveY76qnPmn4Sr0AIwvOsI5fyWOSB93we9iLbTtCuuA
         j7vC0x+0dKN9FiJb870BSIQm8PcF+iuMfmGHN1rXp1abLKrvjgKdQKrai3d6KU4cylWD
         B7Sth1EsYMLOsr1pp2hNdOqWV0f9CnocHLexQZrQqbhnWXGFLLglWt9McZ9vJj5APklN
         Hflg==
X-Forwarded-Encrypted: i=1; AJvYcCW/1i6i9s0BBIM1cxbQlObtTOuhpuTW7nt6z5KiQgv4656LLH5+iFUVA5L+48icExCPUJuyHPcVxkwI8WpviwZ0g5ZVkzBuohGbdySe
X-Gm-Message-State: AOJu0YyuqFuNeqjz0zwA9m6SXCWKecXWsUqmrBbgff5znIbaGd8PjwXz
	Y8+MuxZ0BK8T0pPXu7UDNt8x2D/MmNAiW9RkGpotg+wuJLo0scgIqn+7nBVRp5c=
X-Google-Smtp-Source: AGHT+IEwm+dY0qO4BpWxOUL58zZV+cnU+QzHw3FR6bdQ3WmbzIoTUPKI6tqs4tXJauEY94kgkadNCQ==
X-Received: by 2002:a5d:4210:0:b0:354:fbc2:5cf6 with SMTP id ffacd0b85a97d-35e0f28854dmr5869925f8f.30.1717418092035;
        Mon, 03 Jun 2024 05:34:52 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c090esm8938768f8f.6.2024.06.03.05.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 05:34:51 -0700 (PDT)
Message-ID: <39405408-97d3-49b5-b797-e9363471adf6@linaro.org>
Date: Mon, 3 Jun 2024 13:34:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: codecs: lpass-rx-macro: remove unused struct
 'rx_macro_reg_mask_val'
To: linux@treblig.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240601225446.183505-1-linux@treblig.org>
 <20240601225446.183505-2-linux@treblig.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240601225446.183505-2-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/06/2024 23:54, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'rx_macro_reg_mask_val' is unused since the original
> commit af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for
> lpass rx macro").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

thanks for the patch,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
>   sound/soc/codecs/lpass-rx-macro.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index f35187d69cac..dfb7e4c69683 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -463,12 +463,6 @@ static const struct comp_coeff_val comp_coeff_table[HPH_MODE_MAX][COMP_MAX_COEFF
>   	},
>   };
>   
> -struct rx_macro_reg_mask_val {
> -	u16 reg;
> -	u8 mask;
> -	u8 val;
> -};
> -
>   enum {
>   	INTERP_HPHL,
>   	INTERP_HPHR,


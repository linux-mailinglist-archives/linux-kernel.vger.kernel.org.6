Return-Path: <linux-kernel+bounces-321396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD09719F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F371DB23DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D91B81DB;
	Mon,  9 Sep 2024 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hZtIdZcI"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03521B81CD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886298; cv=none; b=m8VlyTONxV5eqZCdtpmeQ/hSsf5r9avJlPxC3hG1cN3uNrAkvv7TQnoQRh/OJnLKhZWqcpTX38zmMZ6uHW3Xx6vo9raZ+OzdTHOIGcFXNOVb5d7QrOh63Pc7aof8K5Tm+bZucjzwjwqE1ssulq1ylgsxVe4IOg00kQUCX/gKUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886298; c=relaxed/simple;
	bh=rR4IPF0tQmZD15xEnTLuLzb30JEZtyDpPK6dQ65FD8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izQ7VQWzLowR1u9TNPx1RgWn9OcTCcKjJ9qAEouWgbBWifPb22n7HAVglU6b6Cc/VI2Kiq641Z1TmGHhlEZmSU4/28C/ezqC6UbGpwceuNFjslSOBr7xFf/9HICx6YI43rZ5f0aBJebNA7wuKt/rJgmptDUDNoOcm6W3LLgEuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hZtIdZcI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c5bab490so3283265f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725886295; x=1726491095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJ2Ks2SzIHWrbePz+44veAyPxFRsiZ4mtPWykrfa3RY=;
        b=hZtIdZcIGacwrqss1b/iPrFVJb26tFvQjGgm5vCiwQZoaEbo8pQXoqEonu4NsfoWL2
         u8y7gWXUSpvcFmSuwhJjCVXzNUE+/8I6ot95LTsx7Wt2NL9ajnWJrOEHT47S+79DjEy0
         RsZyjGtOfo7QRQ0omURElefOqjY9Lk2tMNm1VhkUtCTyfvgGNOeXY0nPpMNBx6qnW1Q5
         lyjkQu1ChbcPC8wsD708QuWczzs5w8fmVKYdp34smg8lvEweWBXAx6aSf+yN/06CqQ9N
         zVXhmc48WSY3C4/tq0wn2GKvrto/Utueyq0N9hQxL8TEAtWequQ/7j/27oDPThamvPoG
         UPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886295; x=1726491095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ2Ks2SzIHWrbePz+44veAyPxFRsiZ4mtPWykrfa3RY=;
        b=L1GXzwVpdtsiyQ3gkn2DbRVpwHkBS2R4KEAxsZw+DaLV1VpYCuWg7UDdTUJbpB7T1O
         8MFdNMLQ273PX8BHgaSkh9ErkyREB9Ew1t5+asBYoRim3hi2PUM0MatFrHUG8nqhpCWW
         IwydBQf8B7oBW3SaUw8dBBW5Ik+ww2KL56q30s6DU9svMe8DW9brJ6xJteAbxcxFFkt8
         NqmyoFBGTfp0WOsYLEjJySOGL7PwPJU7uaYXyhoM/SmmTv5NpEK1u9X0Ncm+eGa/CmVR
         dLxjVYwCD1RPFWqPM86X0G1qaobDOvUXxEkBBUavGAApfNR2+3n4ZGKT7f81bVlsW6GV
         wWvg==
X-Forwarded-Encrypted: i=1; AJvYcCUFF16EJb6lnHPuTYAOWjac5OtRhvjCU0ATlVcBIFYspv+hhVh8QXlWdS+Ygu4rN0LekIrqQ8psKtls4Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTe+8LIVUohHBo/WUfBo7X2gPh8KbqjTz5ko7zaYKmATrmpt7
	Yck7pkA9A8gdngwLAMmHhwhMY3Ir/wEhmkcx376t6u0BsqyVPyrUhu2C1tMuxeU=
X-Google-Smtp-Source: AGHT+IEdh2bujjJqWi9VgZ9tGPxOdGbD4BeCjn/5is4c/ki/hcUfGEw1iNBzWOGI2bFRam0XXHp2jQ==
X-Received: by 2002:adf:f78b:0:b0:374:ca0c:51b0 with SMTP id ffacd0b85a97d-378885d0348mr5147113f8f.12.1725886295003;
        Mon, 09 Sep 2024 05:51:35 -0700 (PDT)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3941sm5970616f8f.84.2024.09.09.05.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 05:51:34 -0700 (PDT)
Message-ID: <16decde3-f9ee-4962-8015-239c53fe9b2e@baylibre.com>
Date: Mon, 9 Sep 2024 14:51:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] ASoC: mt8365: Remove unused prototype for
 mt8365_afe_clk_group_48k()
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-3-7ad0bac20161@kernel.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-3-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 07/09/2024 02:53, Mark Brown wrote:
> The function is not used outside of the file it is defined and the
> equivalent function for 44.1kHz is not prototyped so remove the prototype
> for this function.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   sound/soc/mediatek/mt8365/mt8365-afe-common.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-common.h b/sound/soc/mediatek/mt8365/mt8365-afe-common.h
> index 1fa87e54a57f..731406e15ac7 100644
> --- a/sound/soc/mediatek/mt8365/mt8365-afe-common.h
> +++ b/sound/soc/mediatek/mt8365/mt8365-afe-common.h
> @@ -421,7 +421,6 @@ static inline u32 AutoRstThLo(unsigned int fs)
>   	}
>   }
>   
> -bool mt8365_afe_clk_group_48k(int sample_rate);
>   bool mt8365_afe_rate_supported(unsigned int rate, unsigned int id);
>   bool mt8365_afe_channel_supported(unsigned int channel, unsigned int id);
>   
> 

-- 
Regards,
Alexandre


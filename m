Return-Path: <linux-kernel+bounces-183901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24B8C9F96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC201F2166A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3EC136E1A;
	Mon, 20 May 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0oWg1e3I"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DC45026
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218597; cv=none; b=YgYyHB8QVZrbCBQiOZVec/EXSjShfu5k1pbvsyAj01fKAETy2xAJCPcTcgz0YMR1l1ky+nStWxcUI9YDh0P/RDGs3MyimKD5CaxroWHEcytAme7soQuUniYBl66Hicv9kBL4BD0c1TIyLreDFPArOHi1Yxulhz5IcGv9bxJPeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218597; c=relaxed/simple;
	bh=/MqlQoolb7hzFTZdR5tx+GNDxGNoERix/Mm8NugIaCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=trMCrTxVPb+U+nbEFEakTsrw2SRluuSww0HXSNm0gO0M7thcdMYO/rVSvn7XUzcQjz+px9mbzjIkW5VmfdX0/HhgkDY9iFwWphJG0v8O54r+RKn73HmaARbcFbxPY18UjXMv+j9d5SS++VXssVybaEJ5tycFr+5g0Z9TUwBr76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0oWg1e3I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so29678425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716218593; x=1716823393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BvrEYs9DYAbC5MlxDXuq2vHAc+BawiypTJLqHR9+P4I=;
        b=0oWg1e3In4NZcvhOGsf9X/ULcjQCiFro1XqJK6lOUm5R7yqln/lvKrXXQ8+TVM68VN
         MmVGQWpVWhmP5UyIuubPfMYICOHTpjk+MCR3m9Fb0HJMZ5SAAkvYWp753Q9mj4hD/6sZ
         TNezEgKhS8tt1CmuLkT0cGyRQK7zT8r1C2/JkwB1uA0qQH9+0GwQk9BGVaLk9mwOK6fX
         PAIogM4NK73K20GEKzA+2UgwevyrjdAnQCxEOMnrrpS5nEq9K4F2lcWOtx3XjE90F13j
         ZtahiSW11VMMShlnNiAabbrFl21q0Ox3KytXC7XzvHq/oWZOFBQDcHaJG39IZx6I6txp
         jucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716218593; x=1716823393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvrEYs9DYAbC5MlxDXuq2vHAc+BawiypTJLqHR9+P4I=;
        b=L2iP44IiJmXCqgitdtMph88XvdrDb6ytYt6yRAJS+kcVrDnJyE8G5erYUNAoTYoLk1
         7tqhyakBxzNFwBn5pyzPLjQi5V2KuMVQ3ZO1qgIAG3t3mv8goeAK6oSVgwovRky+ycGd
         ZhSU8Mef8KL0aVIU1IC5tiySho8fmbcWSKWFd84qq6+yxKHV97f5AqhdSSLtiEbgtnGi
         TDCe0CPZRoEbaWIcjtz15n1nvfaQWTbRT+86FyrRyqVGNPaLs5hgWKUGSvAMcV5XyprT
         B/MReQDaCEoOvmTDjuN8Qm0tz1lHoMuEGT5QZedghBz9Vb75KNI36tsuPApVMA2BBzWR
         W1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3fihL7MaCfgXA9ab19ivUh5IBkt0uT1o9nGm48TS8tynXFuDbrsYsKbrVFhsjylzab9ZPKoxsgEK0eXsdkJb7WyxhIfURyahWUB6V
X-Gm-Message-State: AOJu0YyyeHlO0k5zfziUp1iaJ/bgGaoUBUf1iqMNqtKWjH1qj7WRg32l
	LXrfsrQsX0/7BdEfjpKmcXd2lsd3HEtTlFvCiONw5WcMNFIBONtc92oNhH9N8UE=
X-Google-Smtp-Source: AGHT+IEfQLzDF+6DeA5WUKvuzwObOI9YQj9ggS89zR1Mmor4R3KYRZxxcVlburs7BeHxESEegxmkMA==
X-Received: by 2002:a05:600c:3ca3:b0:41c:23f3:65fa with SMTP id 5b1f17b1804b1-41feac55e3cmr276704235e9.28.1716218593164;
        Mon, 20 May 2024 08:23:13 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88111033sm461769625e9.34.2024.05.20.08.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 08:23:12 -0700 (PDT)
Message-ID: <51a47736-ffe8-49e2-b798-d409ca587501@baylibre.com>
Date: Mon, 20 May 2024 17:23:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8365: use a specific SCPSYS
 compatible
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-2-krzysztof.kozlowski@linaro.org>
 <f42ef151-6eee-418f-91e1-5ac08d161119@collabora.com>
 <2cc638ca-0add-4c8c-b844-606e22dbd253@linaro.org>
 <cf8c87fe-7a4f-423f-9c97-3759eeee4894@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <cf8c87fe-7a4f-423f-9c97-3759eeee4894@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Krzysztof,

On 20/05/2024 12:12, AngeloGioacchino Del Regno wrote:
> Il 20/05/24 12:03, Krzysztof Kozlowski ha scritto:
>> On 20/05/2024 11:55, AngeloGioacchino Del Regno wrote:
>>> Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
>>>> SoCs should use dedicated compatibles for each of their syscon nodes to
>>>> precisely describe the block.  Using an incorrect compatible does not
>>>> allow to properly match/validate children of the syscon device.  Replace
>>>> SYSCFG compatible, which does not have children, with a new dedicated
>>>> one for SCPSYS block.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Technically, that's not a SCPSYS block, but called SYSCFG in MT8365, but the
>>> meaning and the functioning is the same, so it's fine for me.
>>
>> So there are two syscfg blocks? With exactly the same set of registers
>> or different?
>>
> 
> I'm not sure about that, I don't have the MT8365 datasheet...
> 
> Adding Alexandre to the loop - I think he can clarify as he should have the
> required documentation.

Unfortunately, The SCPSYS (@10006000) isn't documented, but according to the functionnal 
specification, it seems to have only one block.

I don't have the history why SYSCFG instead of SCPSYS.

I've tested your serie and have a regression at the kernel boot time:
[    7.738117] mtk-power-controller 10006000.syscon:power-controller: Failed to create device link 
(0x180) with 14000000.syscon

It's related to your patch 3/4.

-- 
Regards,
Alexandre


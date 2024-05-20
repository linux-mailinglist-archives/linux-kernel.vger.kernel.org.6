Return-Path: <linux-kernel+bounces-183912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B5C8C9FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E32FB21180
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B8D13774B;
	Mon, 20 May 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AfONF6W4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AA55782
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219304; cv=none; b=dqWDzUMg+k633ZqpJGUfD6ghnb15rEmodcItUKjiVxDvdBbbZpZmW1Vq9E+kJGGY6healBPmNX+ryriUuiM/w2TgkN8JQUXvaDUvz3J9CdcV2ncanXcPj6FU8DJHyEQv6yhkkDBM0y2VKDypbDljb+o2eSPmPjZyujTO5BmNcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219304; c=relaxed/simple;
	bh=IoQWvodDnTJBxtwFCJd5WwPsGpjWytY+jWjP7MfHmvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbR1pVi+AiNaBQ3eSzIlH7+4OOnEH8AKFAjxFvV/jBT03EfGJgaTyu5OBooHocMyaMLWuEca0cTnAsUzY+tN6jwqOdVmDCJI0Vip8LsKw3WoFYE9aGxTEu5VGmZw8RPX5XOZsYqJJZMWcfA7xyM2iEA9alsJ2dajQ9bQJD5SqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AfONF6W4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-351da5838fcso2543383f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716219301; x=1716824101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAGBZ1PEBcf/fJDsVPro0tPE1WsZuaRgTUZ3iHIhxSQ=;
        b=AfONF6W4e56KMqsJ9kp89m/lymI6yZeaWhNVkIOZKA2hrnCDdvEJatZtOH92lLIbEy
         O3YxE5uuWTUzxENS43uO7S+6v6o9HYaFqW+AbYkLnBn2Aqp8IaDt+CNkuvithoStBhPP
         tJdhq1jQpZav54QVvPplsi1VFOfwkjw4AAw1eHApEbW7uxn2kSYJyvZzlDDFbiT0krCr
         GaMAVveJjnmhz7ulFxU+ADZ9uo585eJHxVCaedfe0hHDnm5RxA47/RZdPUciMAaTTBl1
         jIrvcOf4pfeEs4ZqwgunXPfmLxUC8rSxkFpyXWDo7BN+cQevu+C6j2PGIq+d9q8LbbxX
         ecMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219301; x=1716824101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAGBZ1PEBcf/fJDsVPro0tPE1WsZuaRgTUZ3iHIhxSQ=;
        b=gxKboeSemh2sHMilRfrDuP6Yode+hhM6BfWSR/APvSl7bv+s4wK3w1UfEdjExCzlj+
         cD/OMCf/nNLnLzZ8lgPh5eaMkEg/fC6BYionK7b3hNodEkfE8A0KT8CV0HM9WA7yOZil
         T3wj6MO+TjPK86O3mLrqLIdzfS9JCEJLNUi8DqMKGRcUEHmHSqu5XqER+72ZoBB6MGUZ
         zlBWreLf06987JLYCBV4IDjUzbYYjMJnoMAJ0BFkZR4P+R1RMPtqMWbbuw7Na1F6nzeC
         46/Jpzra+Bdy4NKIpsYfQBS5N/H9kG4bon6RiQTn3aLcdCyOOuWsA4i3WqDmFU3bOFM1
         RJNg==
X-Forwarded-Encrypted: i=1; AJvYcCVIfbFuFlt9I3AUDu12FLLOhnT/dBx4bbrHcP+kwdrsuoCtQyQ5ARlybM8kTCFHLUxdv0IJzpkC9CCivseswLHmGbD/IEFyGSAXlgdU
X-Gm-Message-State: AOJu0YyEQK7pcCCNTnac0oTZg4WkCraK+EA2mx63mOAiM8QdZN8gcgCC
	dZbuYV3aYQySli+MzV5jQibUmogH3ABVi/1RB7ZHG1tLE2NFtkb/pmZhur551OM=
X-Google-Smtp-Source: AGHT+IFNk692k3RqaMXye+c2Qq79nAeUMEO50j29S1MXyLQIcYzL4B0x4R28xGbxScdBA6EWOGa/VA==
X-Received: by 2002:adf:e586:0:b0:34c:b2df:6f01 with SMTP id ffacd0b85a97d-3504a737f13mr21144851f8f.21.1716219300694;
        Mon, 20 May 2024 08:35:00 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bcedsm29225112f8f.19.2024.05.20.08.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 08:35:00 -0700 (PDT)
Message-ID: <1de9d53c-bfc3-4d10-bf9a-b89ce756836b@baylibre.com>
Date: Mon, 20 May 2024 17:34:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/mediatek: Implement OF graphs support for
 display paths
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240516081104.83458-1-angelogioacchino.delregno@collabora.com>
 <20240516081104.83458-4-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240516081104.83458-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>

On 16/05/2024 10:11, AngeloGioacchino Del Regno wrote:
> It is impossible to add each and every possible DDP path combination
> for each and every possible combination of SoC and board: right now,
> this driver hardcodes configuration for 10 SoCs and this is going to
> grow larger and larger, and with new hacks like the introduction of
> mtk_drm_route which is anyway not enough for all final routes as the
> DSI cannot be connected to MERGE if it's not a dual-DSI, or enabling
> DSC preventively doesn't work if the display doesn't support it, or
> others.
> 
> Since practically all display IPs in MediaTek SoCs support being
> interconnected with different instances of other, or the same, IPs
> or with different IPs and in different combinations, the final DDP
> pipeline is effectively a board specific configuration.
> 
> Implement OF graphs support to the mediatek-drm drivers, allowing to
> stop hardcoding the paths, and preventing this driver to get a huge
> amount of arrays for each board and SoC combination, also paving the
> way to share the same mtk_mmsys_driver_data between multiple SoCs,
> making it more straightforward to add support for new chips.

-- 
Regards,
Alexandre


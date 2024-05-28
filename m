Return-Path: <linux-kernel+bounces-192374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D228D1C42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E7C1C222C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3316DED8;
	Tue, 28 May 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f6/Unv9K"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06016415
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902030; cv=none; b=ki+Im9WDJBhDGzJeF3g4yRaVfj0Zga6hd33VnkxyKEQHkkhMgTEPjYoyeqD13ImD/ezp8ZMv3H+fX/ZGE9nCFYsiuqQSKgXUCMEFTDaYnA/1LlQojOIEDoHV0bNgUUex57bSSPDfS4+EQrtiP2byo4EQAwqPkiCwrvVu3ZdFPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902030; c=relaxed/simple;
	bh=VMcndx1MyOn/tzGp7W1bciJqyD0f9IArD3yPKz887Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfvBLYBAOWhbT/CnOTp8JtA1MzGHACC/4Kv21Om50ia860RxODPnreWfMRp88XK0ZC5RsjmBGHTQinlg2kVY4Xug9w1X46l6o9VKd+vOkHHjqI2bicDGX+HJMrHwfJUg6gH0oFU9PrEUz/rVEOH9rtqUhNVXkBqTRQceouGP8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f6/Unv9K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354ba5663c9so635397f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716902026; x=1717506826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMcndx1MyOn/tzGp7W1bciJqyD0f9IArD3yPKz887Vo=;
        b=f6/Unv9KSppWLD+eLp3eZolgWr89/fGuBvcmovpV1JEsk1WN/Fqu4sDyaOXqvXU5Q/
         zIMLBxdaUqYYHTR/Bpgx1bJUunaMepxEHSvO3irN7dFy6xn0SOJ9UZhI/j8A3KUOo0bl
         pQZoWLQvFQFxMYhGulijP/K0VLl8tnP9U00b8HlmzX6FyOp2ayb3QUJODJubgjvzpnN4
         jU0PXcilXj6NkqlXcEjS5ZFL0Lz5+i+HkCGZbvXKqhMp9ur9pZO41xnZBnAsaLClfl6R
         XLrofjrYr41FYlMnaII71OuwHaRF6pliGaKXOyK6LWU22+9vBJI1BTBJUcEhfB8wpMHW
         mAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902026; x=1717506826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMcndx1MyOn/tzGp7W1bciJqyD0f9IArD3yPKz887Vo=;
        b=hUuZr+mnHz0MYlk3+QwSbhQTrL7Ek/NGXsVBrK6GTI8gl5F5dL+XnLNe4sMt+kCFDK
         itSjGc6yDGNm9zD/jWckBsfK4Kxcmlu83gMAyiQw5bbKqET3+LK8i9Rvg6+ZSNqp2Sb/
         dxc8LrHEURKCdKUYmKyotptFKyZ+4KurKiikRjuwSTFAxubHAZyR1hvxeijHzBflckER
         Pce000PgCS2MSSmIoEr3qT6AXY4vSaAnQFODiOnjMpMOsZrtFe23jAvGP3DIOK1Rv6z3
         TmylK5diu3adMQ9XtS+31ek8/maD0WypZZcyxoW4wvzmHa4LnzsrCrER8xQKWakaJmHp
         +xRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGBrb5nLKrmb2MSSaCP60n3ZQjgfgw4okFWk9l0CG0XchPUrL7j/ijIEGr3ayIeiq4nv6OBmSOnz0UfqB0G6/83IWw3C7pXYbDwr9O
X-Gm-Message-State: AOJu0Yx63j9nanw7fTkM70ud2msDXSl7MtWT6+J1BdTcguNwQVsgC/nU
	1cx0K57XqGVLA+s/Vu+sbWKdKFlOUk4U20xY6lek0v62Uzi4UI7JSwRnIqT2SxQ=
X-Google-Smtp-Source: AGHT+IFcjZPdSjwdhRZc+nZsDK1tBXTV9ToeKuYOV9I7MWvMKdFyTLe3sxT6lJtaaMcKP9OprZr8vQ==
X-Received: by 2002:adf:e648:0:b0:357:40e8:e574 with SMTP id ffacd0b85a97d-35740e8e60amr5679648f8f.37.1716902025896;
        Tue, 28 May 2024 06:13:45 -0700 (PDT)
Received: from [10.3.5.161] (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090805sm11546560f8f.48.2024.05.28.06.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 06:13:45 -0700 (PDT)
Message-ID: <2e872daa-a9d8-430f-9a6c-90001dd3391e@baylibre.com>
Date: Tue, 28 May 2024 15:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8188: Add support for Mali
 GPU on Panfrost
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, mandyjh.liu@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
 <20240527093908.97574-6-angelogioacchino.delregno@collabora.com>
 <f553b3f2-d895-446a-a741-7a151ebeb3ed@baylibre.com>
 <4715d477-5f66-47db-973f-af64a3009113@collabora.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <4715d477-5f66-47db-973f-af64a3009113@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/24 12:36, AngeloGioacchino Del Regno wrote:
> Il 27/05/24 16:53, Julien Panis ha scritto:
>> On 5/27/24 11:39, AngeloGioacchino Del Regno wrote:
>>> Add the necessary OPP table for the GPU and also add a GPU node
>>> to enable support for the Valhall-JM G57 MC3 found on this SoC,
>>> using the Panfrost driver.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>
>> [...]
>>
>>> +        gpu: gpu@13000000 {
>>> +            compatible = "mediatek,mt8188-mali", "arm,mali-valhall-jm";
>>> +            reg = <0 0x13000000 0 0x4000>;
>>> +
>>> +            clocks = <&mfgcfg CLK_MFGCFG_BG3D>;
>>> +            interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +                     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +                     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +            interrupt-names = "job", "mmu", "gpu";
>>> +            operating-points-v2 = <&gpu_opp_table>;
>>> +            power-domains = <&spm MT8188_POWER_DOMAIN_MFG2>,
>>> +                    <&spm MT8188_POWER_DOMAIN_MFG3>,
>>> +                    <&spm MT8188_POWER_DOMAIN_MFG4>;
>>> +            power-domain-names = "core0", "core1", "core2";
>>
>> Hi Angelo,
>>
>> I think you should add something like that here:
>> #cooling-cells = <2>;
>> (the warning is raised when I run 'make dtbs_check')
>>
>> Julien
>>
>
> I can either add it to a v2 of this series, or you can add it in your patch where
> you're actually adding the thermal support.
>
> I have no preferences about who adds it, and I agree that cooling-cells should
> eventually get there, so I'll leave the choice to you :-)
>
> Cheers,
> Angelo

I will add it to my patch.
Julien


Return-Path: <linux-kernel+bounces-252860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34289318FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B211F22863
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6D446AF;
	Mon, 15 Jul 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FLvMxbCq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA443D3BD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063499; cv=none; b=oN53/DmzfAsV4YoTBhmOiczo9DDuVsu+bpdP9AoOj8eQEDgHo4gd22Fm4EQwKRcgT42nqreTtIX74UVHZIT9hEC5YcugvcVif/fmoMoyRBli0kTFh1yBGN0uQ8cgTBe3JIXEDsIkzANSJZ/vCTp2PXS7KJ9wh/x0Ck5E37whWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063499; c=relaxed/simple;
	bh=BcJbKmVKSGDM/WHI+1p7JiS2U0qfJkD2DUYs97sj0vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtOR1vJ1zAUfrLde0+rI1Ul0+Dd3yf0aD8ok6T9bGU5qmhd3Fe//XVdIzLcuchPtdDJ3Brz8ZZm4uyqCoBSA2zpIdrVRPRh6t9i9cJXeky7Fbm21PWU1x2qV6nqqy06ptx/u0iITpidhRM2wlSQaFKI8ax39cSLR9IKcb3dVP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FLvMxbCq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4267300145eso35372395e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721063495; x=1721668295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSOszyLr52vvd3J2gSBMUHz1uDskXOJN7E3GeY5OGHo=;
        b=FLvMxbCqDXEVQPhKeJwbYewIZzW2D2mFdr4/X6waE/6LEDoQY5N9oN0RhEkFeqvTrP
         A7bSxblLMfmcEg+ALIWbJslMGchD5lj5RvK9XEiXumVL4bvmMyf5Hjx+igCagsX9Vb8e
         OoZXhUbBG10ZMcFh8NvwWv2M8eiOYOvWw3MzC+m5f0VSrnu1Tc7BVkA/jDgZ+gDFFQ0A
         8RRD5uxOXC4wCe2QedSNZJnp7Bvr9xuIi+Se0Uo4DCkXlC6n5zTkijttVnwuakGjZOAT
         XeF5XP5fo/lXOO1zDs8DNiP2NowiC7trZnsqGuQfyx9MB1XEOiYFtWIEnSGkkzEcwZOK
         u8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063495; x=1721668295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSOszyLr52vvd3J2gSBMUHz1uDskXOJN7E3GeY5OGHo=;
        b=MgnUcnzxvyFl7zwv/uk4PUnFqWDfSZl9LnvD4tn+bja4S9PW5dW2RWCKWWoKkkamwQ
         NOVbeaAgo64m9P91opbpaJcQai7EMz+wkwlzaRgaxp7ens8eM0L0hvx24SXc3OlE+oZE
         wvR4Gd2dHUmz7LYBBaccBCQzjXc+luhMh04MgIl9hDciThaDsyxkNMnZ2l6O/kmY/zdz
         0A204qVsRPC+VPPmtRoZMSVQGv0te+WIEYzmt+i2GV8CdbTIJ8zQGINlz3kAa1py2QnL
         gwqFSCMRjgPAPSkIqg0ilLBm5o2/0A/Tz/f+oFnG7ReQetPMLooRfGYEp6Crqu4etfxs
         LIgQ==
X-Gm-Message-State: AOJu0YyGbB6KH6YNrjBWZRGzMYihx92au6dWuiJAMpJ3In9XvUGT1heo
	V4r0L0s947POFDJHLp72Jnk3YHUD9P0NA0zejpxpzqFmQo6Jb61M8DFE9YL6sps=
X-Google-Smtp-Source: AGHT+IHOHPisiK8XidFLa4CeSrrPquV4Tt/J8vlYz8N+N7fTL2d+kepabCLUgdbWLlDd4HajJwchgw==
X-Received: by 2002:adf:f848:0:b0:367:957d:b46d with SMTP id ffacd0b85a97d-368240c1d04mr276813f8f.66.1721063494905;
        Mon, 15 Jul 2024 10:11:34 -0700 (PDT)
Received: from [192.168.1.94] (21.31.102.84.rev.sfr.net. [84.102.31.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3f2esm6950148f8f.18.2024.07.15.10.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 10:11:34 -0700 (PDT)
Message-ID: <48e7b828-77f1-4ff3-9ff2-cdb563c14878@baylibre.com>
Date: Mon, 15 Jul 2024 19:11:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the mediatek tree
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>,
 "khilman@baylibre.com" <khilman@baylibre.com>
References: <ZnBn-vSj-ssrJFr2@sirena.org.uk>
 <01f2ee94-f8b0-449c-aa19-3ee38a2e36a1@baylibre.com>
 <d87b7376-5ba2-4810-90cb-76648d4a8080@kernel.org>
 <be5a8b12-b042-48cc-9508-759a2a285a8b@kernel.org>
 <99b7f55f-2909-450f-88ce-8cbe8f41c7f8@baylibre.com>
 <9674d79f-83c0-44bf-bcf0-e78f8bdbfbd3@linaro.org>
 <ebd65254-c0bb-4c07-810a-e46ba7e0b929@kernel.org>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <ebd65254-c0bb-4c07-810a-e46ba7e0b929@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/24 09:40, AngeloGioacchino Del Regno wrote:
> Il 18/06/24 20:03, Daniel Lezcano ha scritto:
>> On 18/06/2024 18:45, Julien Panis wrote:
>>> On 6/18/24 12:20, AngeloGioacchino Del Regno wrote:
>>>> Il 18/06/24 12:03, AngeloGioacchino Del Regno ha scritto:
>>>>> Il 18/06/24 09:49, Julien Panis ha scritto:
>>>>>> On 6/17/24 18:44, Mark Brown wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> After merging the mediatek tree, today's linux-next build (arm64
>>>>>>> defconfig) failed like this:
>>>>>>>
>>>>>>> /tmp/next/build/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi:113.6-121.3: 
>>>>>>> Warning (graph_port): /fragment@4/__overlay__: graph port node name should be 'port'
>>>>>>> Error: /tmp/next/build/arch/arm64/boot/dts/mediatek/mt8186.dtsi:2399.29-30 syntax error
>>>>>>> FATAL ERROR: Unable to parse input tree
>>>>>>> make[4]: *** [/tmp/next/build/scripts/Makefile.lib:431: 
>>>>>>> arch/arm64/boot/dts/mediatek/mt8186-corsola-magneton-sku393216.dtb] Error 1
>>>>>>>
>>>>>>> Caused by commit
>>>>>>>
>>>>>>>    d7c1bde38bf37a5 ("arm64: dts: mediatek: mt8186: add default thermal zones")
>>>>>>>
>>>>>>> I have used the last version of the mediatek tree from 20240613 instead.
>>>>>>
>>>>>> Hello Mark,
>>>>>>
>>>>>> Here is the explanation:
>>>>>> https://lore.kernel.org/all/71d53ff6-fdae-440d-b60d-3ae6f0c881d9@baylibre.com/
>>>>>> https://lore.kernel.org/all/6d9e0f19-9851-4f23-a8b8-6acc82ae7a3d@baylibre.com/
>>>>>>
>>>>>> For some reason, the 2 first commits of the series were not applied
>>>>>> with the dts. These commits are needed because they contain some
>>>>>> definitions used by the dts.
>>>>>>
>>>>>> Julien
>>>>>
>>>>> I'm not sure how should I proceed here.
>>>>>
>>>>
>>>> Reiterating, I'm sure how should I proceed.
>>>>
>>>> I'm removing those patches from mediatek for-next until further notice.
>>>>
>>>> Regards,
>>>> Angelo
>>>
>>> Just for my information: Should we just wait for another maintainer
>>> to pick the 2 missing patches ? Who is in charge of doing it ?
>>
>> I've picked the 2 first patches but they are going through the validation process through our CI. 
>> They will be available in a couple of days in linux-next.
>>
>> If you want me to drop them and let them go through the Mediatek tree, just let me know.
>>
>
> Thanks but no, thanks :-)
>
> Please, keep them in the thermal trees where they belong.
> I will adjust accordingly.
>
> Cheers,
> Angelo

Hello Angelo,

AFAICS, the dt-bindings patches are now in v6.10.
Would it be possible to re-apply the dts patches please ?

Julien


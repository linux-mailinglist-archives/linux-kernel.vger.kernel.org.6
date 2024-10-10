Return-Path: <linux-kernel+bounces-359089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41AB99874A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCF6B267CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438EC1C9B8C;
	Thu, 10 Oct 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz6YT9c2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0A1C6F76;
	Thu, 10 Oct 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565961; cv=none; b=B8PSeJcXZfEOkXRn4iplZYyTaE/31rpzvz4zIn5bAhWM7JmyDC3k0G2MLmq/5Cu2sOlWqoc2HbdiNaiTMMLdx6/5CDRNw1EKCKiFUYs2vJzNVje+9koXgA2655gFw034dZiN1scLjvGEZQdgTh64RhwVvEf4lBZIdFdCTrM+BME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565961; c=relaxed/simple;
	bh=ZtVR3mU4eUg9P6NpnRu+zb1/VuU0gwd8DxPL8K2CXsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaNiJi6s4oai/O5oKNVqG7sNvz1r63PV7qk+Oj8U4AFd4voy54+pTfxiAcSseCI30DuCzFUTYUS9dVmKMQV95t7+Ykfed1h+TC4OyXj7rD34pogDBnwAPQHnVEn6a78irBXTvl1bhPUeIOtsC9fFCtBm08uW0aGfQ8uOl6nJ7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz6YT9c2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fada911953so17714291fa.0;
        Thu, 10 Oct 2024 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728565958; x=1729170758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRnZRSG2eoYSDSz68/sP2zAXSgCW07pnk18DG/2+H6Y=;
        b=Qz6YT9c25ts+A1CsuYb8omLSCmgoCtaoTUIbzDvZie2vnJTdT2GeK/GDbKJvlD6hNX
         U6MwhLS85PbQKUGkwCBuqRZ9Z1ptZQC42DIhoK1GGCa8upWNEHlGPkcZRIdaWRy/XQA9
         M96XxSuEvpXkrPA1/WTxzLHQpN1ATtVI8EVJMOvyticBcyZRK9vZGmyOOiMavMZLbLnK
         wQxbOnhG6RJfpybPkiJDd2oA/ILwBi3i7zd7UadNq1tlrD9f84EF2pv7GvBLN0vryxpU
         XO6ZMNZGwN9OLDSiWVSPYtGpGK7Vg+lIKz2LURmaJl02jhwPZ3gFCDeeSODwUbVtBBaF
         Yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565958; x=1729170758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRnZRSG2eoYSDSz68/sP2zAXSgCW07pnk18DG/2+H6Y=;
        b=R5xwLURCOlaYHqs1zsj2SMg8/a1ceSTiaUIgJuY2Iu29grG/4u74JQZoxg1+qM0Fgj
         1d1hGxfCQlvRlfvogpeJioCEYdlNfEOYtKIpkQ8cap3d/kNoPyA29JGTXhyIPzG8m+MV
         Yv6H5+/RqmhcKAF40M28VHEZ6fpfmqizFZdchIBCRGcBum69yzSFZMC8aCW1+oW4bRlb
         zZHH/IsaTIQuJ6TzzRLXVk4gI+XlGx8PW+qhcKYvFeAbCaNCFhTSRySspexDvuJlLEmf
         I5krGTcsR+mMpK3zzmNKs0n+4m2J02c+JR9iCplZ4cWsYc5odb3W+jxRh7T6oEub+Qky
         fzFg==
X-Forwarded-Encrypted: i=1; AJvYcCUtBL5E+DwyzCWazApX1/oaK8GDXa3H5DS1VaoSfvGNC7uF3JJoHSSmTnMrH1TbRUKIyftmwFSMOIAp@vger.kernel.org, AJvYcCVb9PlnX6ZG4vDvf2O5sV9USOqmq56XH4udzDXzk1fHC8EZ8+SEvVetkivXJFI0HqXupcXtpacRDwPq@vger.kernel.org, AJvYcCWgTeF6oMqdtwg9Lfw0de8gPLnKjMmW59E2LEZu+TpqG3KQijlF/gSB2TFZ8ksrMu4YX2OeEMvzxVYl/OFa@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiqXJfhh9mOomx7yMs7sDk3CkOjPzKDJYgf84PWVIw9vVRzxI
	FObCnyN2MqMaS6x7t07Ii66E6bV98fivSAXOGaBT79WqO9ZrijYupH1sAYrh
X-Google-Smtp-Source: AGHT+IEUkmo6BSFMfs3DhvYxndBIE+RTpexMHgWjQyytLnGrtanEQDgJwQ5jLMmGoecdNAvUv0gKiA==
X-Received: by 2002:a05:6402:5408:b0:5c8:93fe:3f7e with SMTP id 4fb4d7f45d1cf-5c933550288mr3177019a12.11.1728565946608;
        Thu, 10 Oct 2024 06:12:26 -0700 (PDT)
Received: from [10.31.18.55] ([95.183.227.31])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2560sm761734a12.17.2024.10.10.06.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:12:26 -0700 (PDT)
Message-ID: <02a0487d-4538-4796-b779-da059f4e6ddd@gmail.com>
Date: Thu, 10 Oct 2024 16:12:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sam Shih <sam.shih@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20241010124529.78460-1-y.oudjana@protonmail.com>
 <20241010124529.78460-3-y.oudjana@protonmail.com>
 <d9bd5573-4860-4a59-b03c-2c353a9b556b@collabora.com>
Content-Language: en-US
From: Yassine Oudjana <yassine.oudjana@gmail.com>
In-Reply-To: <d9bd5573-4860-4a59-b03c-2c353a9b556b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/2024 3:59 pm, AngeloGioacchino Del Regno wrote:
> Il 10/10/24 14:45, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
>> clock and reset controllers. These provide the base clocks and resets
>> on the platform, enough to bring up all essential blocks including
>> PWRAP, MSDC and peripherals (UART, I2C, SPI).
>>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   MAINTAINERS                                  |   4 +
>>   drivers/clk/mediatek/Kconfig                 |   9 +
>>   drivers/clk/mediatek/Makefile                |   1 +
>>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 138 +++++++
>>   drivers/clk/mediatek/clk-mt6735-infracfg.c   | 107 +++++
>>   drivers/clk/mediatek/clk-mt6735-pericfg.c    | 124 ++++++
>>   drivers/clk/mediatek/clk-mt6735-topckgen.c   | 394 +++++++++++++++++++
>>   7 files changed, 777 insertions(+)
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
>>   create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
>>
> 
> You're so, so, so, so..... *so close* to get this one upstream.
> 
> Read the comments below and *please*, fix it and send a v6 *as soon as 
> you can*,
> so that we get a good chance to see this in v6.13 and so that you can 
> move on
> with upstreaming the other stuff that you got for this SoC.
> 
> ..snip...
> 
>> diff --git a/drivers/clk/mediatek/clk-mt6735-infracfg.c b/drivers/clk/ 
>> mediatek/clk-mt6735-infracfg.c
>> new file mode 100644
>> index 0000000000000..eceb13af3222a
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt6735-infracfg.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-gate.h"
>> +#include "clk-mtk.h"
>> +
>> +#include <dt-bindings/clock/mediatek,mt6735-infracfg.h>
>> +#include <dt-bindings/reset/mediatek,mt6735-infracfg.h>
>> +
>> +#define INFRA_RST0            0x30
>> +#define INFRA_GLOBALCON_PDN0        0x40
>> +#define INFRA_PDN1            0x44
>> +#define    INFRA_PDN_STA            0x48
> 
> #define<tab>INFRA_PDN_STA .... I know this is a typo, but you'll have to 
> fix it.
> 
> Please replace the tabulation with a space, so that this is consistent 
> with all
> of the other definitions that you have in here.
> 
>> +
>> +#define RST_NR_PER_BANK            32
>> +
> 
> ..snip..
> 
>> diff --git a/drivers/clk/mediatek/clk-mt6735-pericfg.c b/drivers/clk/ 
>> mediatek/clk-mt6735-pericfg.c
>> new file mode 100644
>> index 0000000000000..6f298d5538782
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt6735-pericfg.c
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-gate.h"
>> +#include "clk-mtk.h"
>> +
>> +#include <dt-bindings/clock/mediatek,mt6735-pericfg.h>
>> +#include <dt-bindings/reset/mediatek,mt6735-pericfg.h>
>> +
>> +#define PERI_GLOBALCON_RST0        0x00
>> +#define PERI_GLOBALCON_RST1        0x04
>> +#define PERI_GLOBALCON_PDN0_SET        0x08
>> +#define PERI_GLOBALCON_PDN0_CLR        0x10
>> +#define    PERI_GLOBALCON_PDN0_STA        0x18
> 
> same here
> 
>> +
>> +#define RST_NR_PER_BANK            32
> After which:
> 
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>

Tried so hard to catch all typos but I guess some still had to make it 
through. One quick fix coming up!


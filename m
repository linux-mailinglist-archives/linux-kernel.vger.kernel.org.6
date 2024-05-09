Return-Path: <linux-kernel+bounces-174530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C68C102E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69F32850A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B115278D;
	Thu,  9 May 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2DDXDJS"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E6158D98;
	Thu,  9 May 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260377; cv=none; b=IvYNsdgtWyLDPBJt6QQP6YKo/G9RsQ8BeqBL2vWUS2GcHUoF7JJT/+eJMZysRe3524Efi/yyLyoREZOTlDOyBfS47QeOGy16Yl0iNbpqOaDMhc/uIR3oycCTS0abYpq+fLhWdsUmmJyHJ0o0WtqVmqVUXcczP6DB7fhIShq0TN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260377; c=relaxed/simple;
	bh=/VciWFKtAdaZRdo+HMOaQf3fXGYQctPQXc4gCbjVjkg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BX34zTfX1SSUqWmdKoljwz53CIv2TSaahhIeOjfZAhqm+DAQo4gm0Kt+cSJc/YLcfwWPzR23usyx5knDtnrQBoLQycRwBYG3b/w7WmUt+bmMenaMV1Ez7uA3RdbVPv1xaL9x0MKtZoiiLKOOdCnLMmoYREo1FkVNJn93rDDKdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2DDXDJS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34e663aa217so570320f8f.1;
        Thu, 09 May 2024 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260366; x=1715865166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeqYlf9c4EFhi9TNIZzRvyO42T/eA+jGpWv1NKDPZXk=;
        b=U2DDXDJS+ZiBzXuXYrc8vJgyZ7fU7+XbDbYd9PGFouvK5Yo/BqpnKr44hvhoJSY4Q6
         JGoDIJNDq+IXhlWGfaqB7LwcfKRZrP8aLjSFMEpynV2f/6VyvxpmI6uffZ49ILs0Ffkz
         u9h4VpXUM6zNdcQCQxggJXI7UE1df3+PA8I1HY0Kprru25LhElTQ2j3TNenW5I/ARSEA
         AmzFLoizsuvpEO1usIQtV46Ut+WZk5WrG8L2Bx3Zurd0ABlhZf1z3tqflO0Og4tJcaTf
         ilqH4NE4Jo8PS1QZh8GshCQLtQ9b96L6qIfQle/Ty8mkajtQSd9wX93ry6lP9mN9UUSX
         emSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260366; x=1715865166;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeqYlf9c4EFhi9TNIZzRvyO42T/eA+jGpWv1NKDPZXk=;
        b=xQIUhhTM49o6jCzSaOR4wj+fRbK/UNrWRFQePB5qmP9qrGzHjxJTf2/qWFwjVfariE
         ck6dRRWDIvrRKAGiqLNwFdq28fIiRHWPMGXxtyKkSwlcE+aDj9PPlhLC80KspZH2HEHY
         FHLeSxv7Gb+lEAm6R37lO567ldAfiygqIwkjx6TY96r4y4WuDaTxeOoA4ufpwzPJqQXH
         yRzbq8uQtGHlwtGDmJ0nOOuX1VkxdkId0t73evZtVHEvrlg/lVqGK8KHubGXf+sMdme9
         YnTJYMQK2jeyaIqRCz4godSyvVBHIz7BHXSDQcyoS5L1r7JlUa7epLACy93uokJl65zM
         4w0A==
X-Forwarded-Encrypted: i=1; AJvYcCXYB+7eURbzn1VKt/s4hljmbE/GTWwE9YuZ1rTXSSMpTm6H+HlMLJ3Hd/iNUOxe2LHliJb3n3yc+ssrwO3TvzcLSIJr3Se54iv9r/MinpCeK0eSdeDhjxZPhJCQ1o81Quy2cRFUabtvmYDieKXHHO6O8rPk7nPBVdZLNhfEKhZpNPURSQ==
X-Gm-Message-State: AOJu0YyjF8OIAlJA9hMq1PCj+q/yqgXQN9V8hzjxGhW3ndPR02WyHbvO
	tfyESm0oPsN6MbTRFtewsoa3C2J0tCo7gzxY+Oma8UjKQSoAzS0=
X-Google-Smtp-Source: AGHT+IEC7WafECIZydYUdeAbxXAmqunwb457qqLbk5bNV+opK2hsUeI5mP0GAZJxRMOafc4vJyH5uQ==
X-Received: by 2002:adf:cd89:0:b0:343:65a8:406d with SMTP id ffacd0b85a97d-34fcb3acc64mr4369892f8f.64.1715260366006;
        Thu, 09 May 2024 06:12:46 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:b44:d8c3:6fa8:c46f? ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a45sm1697584f8f.39.2024.05.09.06.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 06:12:45 -0700 (PDT)
Message-ID: <d5fcf678-741b-48c0-988e-4722ac756a11@gmail.com>
Date: Thu, 9 May 2024 15:12:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add DSI support for RK3128
From: Alex Bee <knaerzche@gmail.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 sebastian.reichel@collabora.com, Sandy Huang <hjc@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
References: <20240509120715.86694-1-knaerzche@gmail.com>
 <38423821.XM6RcZxFsP@diego> <1190cfb6-e2d1-4910-ad57-f7566343ff19@gmail.com>
Content-Language: en-US
In-Reply-To: <1190cfb6-e2d1-4910-ad57-f7566343ff19@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.05.24 um 14:43 schrieb Alex Bee:

> Hi Heiko
>
> Am 09.05.24 um 14:21 schrieb Heiko Stübner:
>> Hi Alex,
>>
>> Am Donnerstag, 9. Mai 2024, 14:07:08 CEST schrieb Alex Bee:
>>> This series aims to add support for the DesignWare MIPI DSI 
>>> controller and
>>> the Innoslicon D-PHY found in RK3128 SoCs. The code additions are 
>>> rather
>>> tiny: It only need some code in the Rockchip dw-mipi-dsi glue layer for
>>> this SoC, add support for an additional clock and do some changes in 
>>> the
>>> SoC's clock driver. Support for the phy was already added when the
>>> Innosilicon D-PHY driver was initially submitted. I tested it with a
>>> 800x1280 DSI panel where all 4 lanes that are supported are used.
>>>
>>> changes in v2:
>>>    To improve power-efficiency when the DSI controller is not in use, I
>>>    dropped the patch which made hclk_vio_h2p a critical clock and 
>>> instead
>>>    added support for an AHB clock to the DSI controller driver and 
>>> updated
>>>    the bindings and the addition to the SoC DT accordingly.
>> The naming already suggests that hclk_vio_h2p is not a clock-part of
>> the actual dsi controller, but more an internal thing inside the clock
>> controller.
>>
>> At least naming and perceived functionality would suggest a chain of
>>     hclk_vio -> hclk_vio_h2p -> pclk_mipi
> I personally wouldn't give to much on naming when it comes to Rockchip
> CRUs. Actually looking at "Fig. 2-5 Chip Clock Architecture Diagram 4" of
> RK312x its:
>
>
> ... -> hclk_vio
>
>                    -> hclk_h2p (clock in question)
>                    -> pclk_mipi (DSI APB clock)
>                    -> hclk_rga
>                    -> hclk_vop
>                    ....
>
> Also there is no other display output path (HDMI, LVDS) which requires 
> this
> clock to be enabled. They all work when it's disabled. That really 
> makes me
> think it's just the AHB clock line for the DSI controller. Maybe Andy can
> share some details?

Anyway: I just looked at the "MIPI Controller architecture" part of the 
TRM - there is not even AHB clock line, only APB. So I revert the change 
with the additional clock, make the h2p-clock critical again and resend.

Alex

>> In any case, I really don't see hclk_vio_h2p to be in the realm of the
>> actual DSI controller, but more a part of clock-controller / 
>> interconnect.
>> Similar to the NIU clocks for the interconnect.
>>
>> rk3588 actually tries to implement this already and while the
>> gate-link clocks are described as "recent", I think this definitly 
>> the same
>> concept used a most/all older Rockchip SoCs, just nobody cared about 
>> that
>> till now ;-) [0] .
>>
>> So TL;DR I'd really prefer to not leak CRU-details into the DSI 
>> controller.
>>
>>
>> Heiko
>>
>> [0] Which reminds me that I should look at Sebastian's make GATE-LINK
>> actually-work-patch.
>>
>>
>>
>>


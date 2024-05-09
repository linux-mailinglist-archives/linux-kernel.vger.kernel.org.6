Return-Path: <linux-kernel+bounces-174510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF508C0FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044EE28447C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3BB13C3C8;
	Thu,  9 May 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HazLUMNQ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18671FAA;
	Thu,  9 May 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258619; cv=none; b=hQ5k5E0TB2dBDrY6w1pEwJw/Rpov3biHrDHOMkzI0yyBSQkCXktGVBXmh0Ra1ethmapbcEqP36kxxbevYQIfPDPReWcNJsHWcaBREmtein2NcGjp/+A4mZUnbh367Xaisnbvp5ZJhhQpS6CxIu/1tN0CGlDDFWoUWEoKx/5s4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258619; c=relaxed/simple;
	bh=KcIWzp0sfje7CGcGU82xszyGblw9AanZy6vBopdy/Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFmsoLkR6y+xg/pu7WohgJYi8yU7dPODFjb4orhBOFI1M3iJJo//urX02WL0HP8toa4Xovxzn+7hQ0BLUB9jn5TjoxPXvMoFlNDLMJ8sdZslOxtravmRu4wopxrckcOGjeiJ4O4ZB241AQxcben6VT73I93zCZs3wc+HMcx5d5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HazLUMNQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso6022785e9.1;
        Thu, 09 May 2024 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715258616; x=1715863416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukFRa6jd0YhZA7RQLCPnJfFHsXtdSwr8V5mOexEjdho=;
        b=HazLUMNQ3Bzlk/DkRiUvstFqGbnuEQNljsKGkmBCKAFpfk35RDz/KhO/Svb8tcEjvC
         OI0wEI4SMLCx0BKl1rrzU8S0UGxECbTwLEe7RnRvF/ROhlEtAkFRJiTMD99gR5QgD7DQ
         3jqutA6MxMnmAnKGPSTtgX+75q3MnG13EaWhMoGy/36S0ZakqKQgfg8kJmr7GZlpob8z
         gFd4Tq0NKJEZxJbm3GgDqIbhvhMSgNvvtcN4b2MCsyeOagLWaz5r9Mzo/0L+ti45ypQA
         b1l5LcmP4dM9zwExUEW4RZNYvf1StRaRom9rjTnMlSC6Cg1mTCLXtSK0fE4r7WXiKQVw
         SiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715258616; x=1715863416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukFRa6jd0YhZA7RQLCPnJfFHsXtdSwr8V5mOexEjdho=;
        b=LmEOjdqK3VyUpMQ3odOuMjLIRpop0BBMFUDSsH3VwmaPmbkL6GoL5tGBTCwHSvonVB
         RGIjdqqvWIRVK6WpoIDA66nLFKhJR0PXTCBXpD5j0A1xB+Ms+1kPNRUUneNn3o5Gz6/Z
         stcAju62OD7Hz015RqP/8dAFjNPXU46wFjHINDNQGrYqGjBjDm5xNw/Wk5JQaj3wwUiU
         X0GXK/Sn7PzzllkYCcq2tm30EoU8Ht0TCbKfdNM8vKJHegETRxONCcqpetFXFW6hZP98
         MHr1lAjjLD9IjYopasoGG6GpAXQvn5yCYCRhqV7Dki71uJe5EZBTKI4efBMsNK+aH75M
         YNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBY3zk5V3uIRVHavuZUnfO1CxXHjewbeuyt2ddN471EiYvqFNBPdUnDe4XWziRK0c/qI3zIumHsjXAncp1mZSfQKjCLLY8gGZZZVftaJBYx1qkKWdW1r31fo+pKJQvc/f0lG/bRxszX+uybrloo4AQ1LU7joGmMDHTf0+Rpg0QMiHBpw==
X-Gm-Message-State: AOJu0Yxt2QU3ily0Wmv+z/0RfrutVXvRAHUUU9JKRiZxtenEOpQbZ/dk
	dzazkr4H0QXW5ue9F4GSBRztqv/tmO+rKERXrobJNfYVa0r8gCA=
X-Google-Smtp-Source: AGHT+IH91edNyT90V4bTzKolAoCvVxJlY9gxXvUn7JsOUYnFiQrJLSLCJeZJDn8SANfleGSnxvbfFw==
X-Received: by 2002:a05:600c:450c:b0:418:fb6f:5f59 with SMTP id 5b1f17b1804b1-41f71cc25a8mr45229895e9.2.1715258616089;
        Thu, 09 May 2024 05:43:36 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:b44:d8c3:6fa8:c46f? ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b26675sm59904325e9.2.2024.05.09.05.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 05:43:35 -0700 (PDT)
Message-ID: <1190cfb6-e2d1-4910-ad57-f7566343ff19@gmail.com>
Date: Thu, 9 May 2024 14:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add DSI support for RK3128
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
 <38423821.XM6RcZxFsP@diego>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <38423821.XM6RcZxFsP@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko

Am 09.05.24 um 14:21 schrieb Heiko Stübner:
> Hi Alex,
>
> Am Donnerstag, 9. Mai 2024, 14:07:08 CEST schrieb Alex Bee:
>> This series aims to add support for the DesignWare MIPI DSI controller and
>> the Innoslicon D-PHY found in RK3128 SoCs. The code additions are rather
>> tiny: It only need some code in the Rockchip dw-mipi-dsi glue layer for
>> this SoC, add support for an additional clock and do some changes in the
>> SoC's clock driver. Support for the phy was already added when the
>> Innosilicon D-PHY driver was initially submitted. I tested it with a
>> 800x1280 DSI panel where all 4 lanes that are supported are used.
>>
>> changes in v2:
>>    To improve power-efficiency when the DSI controller is not in use, I
>>    dropped the patch which made hclk_vio_h2p a critical clock and instead
>>    added support for an AHB clock to the DSI controller driver and updated
>>    the bindings and the addition to the SoC DT accordingly.
> The naming already suggests that hclk_vio_h2p is not a clock-part of
> the actual dsi controller, but more an internal thing inside the clock
> controller.
>
> At least naming and perceived functionality would suggest a chain of
> 	hclk_vio -> hclk_vio_h2p -> pclk_mipi
I personally wouldn't give to much on naming when it comes to Rockchip
CRUs. Actually looking at "Fig. 2-5 Chip Clock Architecture Diagram 4" of
RK312x its:


.. -> hclk_vio

                    -> hclk_h2p (clock in question)
                    -> pclk_mipi (DSI APB clock)
                    -> hclk_rga
                    -> hclk_vop
                    ....

Also there is no other display output path (HDMI, LVDS) which requires this
clock to be enabled. They all work when it's disabled. That really makes me
think it's just the AHB clock line for the DSI controller. Maybe Andy can
share some details?

Alex

> In any case, I really don't see hclk_vio_h2p to be in the realm of the
> actual DSI controller, but more a part of clock-controller / interconnect.
> Similar to the NIU clocks for the interconnect.
>
> rk3588 actually tries to implement this already and while the
> gate-link clocks are described as "recent", I think this definitly the same
> concept used a most/all older Rockchip SoCs, just nobody cared about that
> till now ;-) [0] .
>
> So TL;DR I'd really prefer to not leak CRU-details into the DSI controller.
>
>
> Heiko
>
> [0] Which reminds me that I should look at Sebastian's make GATE-LINK
> actually-work-patch.
>
>
>
>


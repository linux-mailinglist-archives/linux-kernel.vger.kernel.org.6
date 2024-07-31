Return-Path: <linux-kernel+bounces-269066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD08942D09
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAB228670D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998421AD9EC;
	Wed, 31 Jul 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ntb83/xh"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE61AD418
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424510; cv=none; b=J1f08zue40AuZy0aEXvgwqcwIY+RmEhT/D2wbJlGY+VhlC0Ro8wnaLhKIYb+qtXEeijO4OCJkMP8QoNV2KX3hGi/BYhbwYpHVYcFtgw8RzmN+YtWWBWKYDbQjYyYZR6HxmUsXJFO+DUssNM5sgYIs3fjGaYmeuJE3xu86GI8pI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424510; c=relaxed/simple;
	bh=129OKtKzx44VILp63egCG0C2vD+sKbj8r5GCRoJm/A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMGdHiJGg7oMZ6SPX3kVUrPSjLgoe+/mDz757iZTcIwYWNkvef79dAM6dygig78mGbhXTTu4WNrC6hFkZN2gVzJJS1xb9QdYIVUXOetY5tX4BcvXvHf+MbnvZ9STRcdDd6IeDc2tedBchszu39fD3eRI5iCHZB+EfEho1uFH6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ntb83/xh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a0c6ab3354so3755601a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722424508; x=1723029308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kGAZyGhud7vE7vIGusXcM32em4s8MLn39W5gHMldUOQ=;
        b=Ntb83/xhDk1um5ltV++lyPOljj5IADZXqvBGrHdEuLtdxtbCvhqRGXyKsgn9TXKaCa
         fDgd/SGzYuUuWsKJt3iYDteHkgmtOzfEsDmDn6tZ61N+6qNJzkYf/Df7vnImfh5Gdyrg
         hkZkmg4Ur3Hq0Z/rGAwHAi6Xz/fEY771t8/As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424508; x=1723029308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGAZyGhud7vE7vIGusXcM32em4s8MLn39W5gHMldUOQ=;
        b=JHFbz9FsjF3Eyr+W243pj28tP+33+73P15kGDSedW+OsZ/DMpmyp0bT0uNy6yo606F
         ovA9uj4rrjz9nFTUywjW+RAJpwEPgJ1l24cYXX260rB/IOtLDdTVk+KUgJJMEdeYsZjd
         dJMmx9FqRpAao+B8GN8GRd1Z/2LupIAxWkQwblhy++IGkb8IpQGNSysFOX6s6WQMRZus
         L3JPDeH2IGj1kCmetActlC73DjPQxRTzJ0kc5pqTzSF86VBNlW2RjWA16cEHUVhK9I9w
         XOUpiWzUWbtrWSYLSwl+3UzMUg+DtfCiRonl2RI3E5TFV1WypfztQBctmgdTKCTyJAP/
         wwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFwUzSCnGFBK7rs7wz5nvMg46OE41aaNZNBsZ+Ht0A2sCA6Jg291mbhB0X+DIHTqelIy534YSBuuFnPVYMHlS5po/45YFtRTpp45Vp
X-Gm-Message-State: AOJu0YzThmkoLf7s/M8xpSuJMajg1sE1JwElINVLAKG5kg4NpWinaZb2
	Vw/CgQwL8PSkt+WZr1anEe9om9yZJIk+eF0kLRG4YITxi+1ITkCf+8Z93OpqLw==
X-Google-Smtp-Source: AGHT+IFVgXPWsMgMgE5M0JWQZ4697i/w3bfILr0K1/Zur2SqvYwF+niY0tB9kRNNpEG78NZJZZ88tQ==
X-Received: by 2002:a17:90a:b304:b0:2c9:a88d:26f2 with SMTP id 98e67ed59e1d1-2cf7e86eac7mr12128873a91.36.1722424507487;
        Wed, 31 Jul 2024 04:15:07 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf0eesm1054976a91.41.2024.07.31.04.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 04:15:07 -0700 (PDT)
Message-ID: <3ded8aea-ee11-43da-9dd7-1259cf931747@broadcom.com>
Date: Wed, 31 Jul 2024 13:14:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Alexey Charkov <alchark@gmail.com>, Jacobe Zang <jacobe.zang@wesion.com>,
 robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-5-jacobe.zang@wesion.com>
 <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/2024 12:16 PM, Alexey Charkov wrote:
> Hi Jacobe,
> 
> 
> On 31/07/2024 9:11 am, Jacobe Zang wrote:
>  > WiFi modules often require 32kHz clock to function. Add support to
>  > enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>  > to the top of brcmf_of_probe
>  >
>  > Co-developed-by: Ondrej Jirman <megi@xff.cz>
>  > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>  > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>  > ---
>  >  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++++++++-
>  >  1 file changed, 11 insertions(+), 1 deletion(-)
>  >
>  > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>  > index e406e11481a62..7e0a2ad5c7c8a 100644
>  > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>  > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>  > @@ -6,6 +6,7 @@
>  >  #include <linux/of.h>
>  >  #include <linux/of_irq.h>
>  >  #include <linux/of_net.h>
>  > +#include <linux/clk.h>
>  >
>  >  #include <defs.h>
>  >  #include "debug.h"
>  > @@ -70,12 +71,16 @@ void brcmf_of_probe(struct device *dev, enum 
> brcmf_bus_type bus_type,
>  >  {
>  >      struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>  >      struct device_node *root, *np = dev->of_node;
>  > +    struct clk *clk;
>  >      const char *prop;
>  >      int irq;
>  >      int err;
>  >      u32 irqf;
>  >      u32 val;
>  >
>  > +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>  > +        return;
> 
> Did you test this? The DTS patch you sent as part of this series doesn't 
> list "brcm,bcm4329-fmac" in the compatible, so this will probably return 
> right here, skipping over the rest of your patch.
> 
> Please test before resending, both with and without the driver for the 
> Bluetooth part of the chip (since it also touches clocks).
> 
> You are also changing the behavior for other systems by putting this 
> check further up the probe path, which might break things for no reason. 
> Better put your clk-related addition below where this check was 
> originally, rather than reorder stuff you don't have to reorder.

That was upon my suggestion. That check was originally at the top of the 
function, but people added stuff before that. I agree that makes the 
compatible "brcm,brcm4329-fmac" required which is what the textual 
binding stated before the switch to YAML was made:

"""
Broadcom BCM43xx Fullmac wireless SDIO devices

This node provides properties for controlling the Broadcom wireless 
device. The
node is expected to be specified as a child node to the SDIO controller that
connects the device to the system.

Required properties:

  - compatible : Should be "brcm,bcm4329-fmac".
"""

Not sure whether this is still true for YAML version (poor YAML reading 
skills ;-) ), but it should as the switch from textual to YAML should 
not have changed the bindings specification.

>  > +
>  >      /* Apple ARM64 platforms have their own idea of board type, 
> passed in
>  >       * via the device tree. They also have an antenna SKU parameter
>  >       */
>  > @@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum 
> brcmf_bus_type bus_type,
>  >          of_node_put(root);
>  >      }
>  >
>  > -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>  > +    clk = devm_clk_get_optional_enabled(dev, "lpo");
>  > +    if (!IS_ERR_OR_NULL(clk)) {
>  > +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
>  > +        clk_set_rate(clk, 32768);
>  > +    } else {
>  >          return;
> 
> Why return here? If the clock is optional, a lot of systems will not 
> have it - that shouldn't prevent the driver from probing. And you are 
> still not handling the -EPROBE_DEFER case which was mentioned on your 
> previous submission.

Right. The else statement above could/should be:

} else if (clk && PTR_ERR(clk) == -EPROBE_DEFER) {
         return PTR_ERR(clk);
}

Regards,
Arend


Return-Path: <linux-kernel+bounces-371168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5A99A374E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CB1B24006
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197441885BE;
	Fri, 18 Oct 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Xq3f9Z"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD618CBF9;
	Fri, 18 Oct 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236874; cv=none; b=k0EzDvnFLW4JF2H80cPvgfLhWULgkfrXZE+Jo+7HcunkaQtqBM3++yf0TSNOgz1J7kn07he4YDFSIOyR4N2Ie9iT6QApiGIBJQJOtCUUfMUzj17u11qhM9fUGbh43bxzSyO/uQslAkkEU3JTxSFeI6ceRVx4wo/pVHUtzPmJrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236874; c=relaxed/simple;
	bh=su/SJYn6k8uSBeNIki1b/EDFY+XXGgPKYnO2plFdOpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJkm6Q2rK4JlMrVNBmoPYeCrEETEGyI9OkQ4FE1WTVDzFSx1IOC52Ip0Mn8NWgf7KaiS4N5yfysPvKBlV3pIU9JUlEPoRX13iYKa0oUm+R5nijPOimLRPKas6BMDpaUB9h0D6ylDetHoNZSvQZnWBo9hyj/6SE1YMFvAqy5vR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8Xq3f9Z; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso323591a91.1;
        Fri, 18 Oct 2024 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729236872; x=1729841672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BE1vQWp4gl/Ca50JBXWtWLVPTPuHPjeem6iZP1NO0ik=;
        b=O8Xq3f9ZcylFBL2OyXNSr00b+OUE9zCaNROhb3Mlj9mEvHH4H1aSFpSkI5ILDBaES2
         1I7kB8wSRAt2tFizoAw1irDvOzIE1XlhCyGYWkX+Picqlrpgco6qyR0rIwyFS+T+fLr2
         gbjZuTn2wjKXdgUE1iwAvAzJ/y88OEo+ANxQkhNeNLgnYiUpvi5CrgmkzLlPUM0qbA9V
         Z/bRYIDCXWazAa7Q/wYQKJ1sg5PslhJb2yzcZRp0IUBzyTCnCKcVZVe1J9HQidA2G6d4
         MksVX093RhzkO4TRxJmROwjld3kGJR5MWIob+716Ak9R18kSr1ERVfsSrm1RFhHS0prC
         L7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729236872; x=1729841672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BE1vQWp4gl/Ca50JBXWtWLVPTPuHPjeem6iZP1NO0ik=;
        b=bVxooV0+zFa7TPkTAAL0rImqUPmVIqSDDIg9PjCm4f8xqd7sFa5U9pkmKRf4K16QFt
         oyS4KFD1s6YPOQJhXBHWhQkwYo7QKIhk5AkQ1dXR3STwnUBvZNkYMWDQulsRq8tejGoy
         ewqMTOFxa0uu2jaxSDmYmVMqgHWnyiRZ/CRU/pqEXj8QbAN2YWP6UMOvIZecMyC+XriH
         JxX/goBfCITCX5reCGkrS0q3o3wzzjCPLEPIs9f7r3I/t3sC3g4BZZZtre/F7qf/Fi3i
         Z+stjIciVIuHuXPHaU6sBdBhSPwnH+k7YUzwsqkBitMdREqmx7+sZ6AChZTMRENEPldx
         i45w==
X-Forwarded-Encrypted: i=1; AJvYcCVHumjKd0Hv4IoQPbjMPgjoDAKTFA+6k/yE2bnpDLUC+zcDw7P+2/Qiv5tDZZeozlPmWS3nyfyGE7nI@vger.kernel.org, AJvYcCXlT+exSZVOXNeJLWBZCSDrkiJ+GlntMGZWWb4Uu8mh0ILe2mLvVYzyJLhcqETYEGCAbHk7D+tdJVIG6x3G@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0B9uO0HL+GahF1BQcAFcP73sngg3sCIxJc0lwe+G7SzoIjZor
	536Lbw/hYQVZUY5HbFfl4faSFvm5qygAneBB41CigQwU/e8WLzDy
X-Google-Smtp-Source: AGHT+IGtmuIgcIKvK3x5XpGlcMFj9hlDpBsifrljjglg5JsYwsKk2FFU4HGoKay0+/WgcAah+/gZxg==
X-Received: by 2002:a05:6a20:9184:b0:1cf:2be2:8dd1 with SMTP id adf61e73a8af0-1d92c5847b5mr1001142637.10.1729236872114;
        Fri, 18 Oct 2024 00:34:32 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc25249esm742612a12.55.2024.10.18.00.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 00:34:30 -0700 (PDT)
Message-ID: <3cd260c8-86e5-4833-b23e-b73dc6417f81@gmail.com>
Date: Fri, 18 Oct 2024 15:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: rockchip: add rk3576 vo1-grf
 syscon
To: Dragan Simic <dsimic@manjaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com,
 yubing.zhang@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
 <ca0ee8752791f53bac23933e1582dd86@manjaro.org>
 <d2a200aa-1301-4940-a39c-0412fe741994@gmail.com>
 <ee27926c06bedd62f417dbd7d01ce8b3@manjaro.org>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <ee27926c06bedd62f417dbd7d01ce8b3@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dragan,

On 2024/10/18 14:37, Dragan Simic wrote:
> Hello Frank,
>
> On 2024-10-18 08:18, Frank Wang wrote:
>> On 2024/10/18 13:02, Dragan Simic wrote:
>>> On 2024-10-17 04:52, Frank Wang wrote:
>>>> From: Frank Wang <frank.wang@rock-chips.com>
>>>>
>>>> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
>>>> configured in usbdp phy driver.
>>>>
>>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>>  - This is a new patch adds rk3576-vo1-grf syscon.
>>>
>>> Could you, please, clarify a bit why is this additional patch
>>> needed in this series?
>>
>> I mentioned in the commit content. The usbdp-phy driver select dp
>> lanes via configuring the vo1-grf.
>
> Yes, I already saw that in the patch description.  Though, and
> I apologize if I'm missing something obvious, I can't see where
> is it actually used in the code?  Is it yet to be used in the
> dts(i) files?
>
> I'd appreciate if you could clarify that just a bit further, so
> I can hopefully understand it better.
>

Yes, the usbdp_phy node in dts(i) will assign the vo1-grf phandle like this:

usbdp_phy: phy@2b010000 {
         ...
         rockchip,vo-grf = <&vo1_grf>;
};

And the usbdp-phy driver parses it and assign to udphy->vogrf, it uses 
in rk_udphy_dplane_select().

The related codes have already existed in the current driver, so for 
RK3576, just only need to do a configuration.


Best regards,
Frank

>>>> v1:
>>>>  - none
>>>>
>>>>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>> b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>> index 50d727f4b76c6..fd42217ab85e7 100644
>>>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>> @@ -33,6 +33,7 @@ properties:
>>>>                - rockchip,rk3576-usb-grf
>>>>                - rockchip,rk3576-usbdpphy-grf
>>>>                - rockchip,rk3576-vo0-grf
>>>> +              - rockchip,rk3576-vo1-grf
>>>>                - rockchip,rk3576-vop-grf
>>>>                - rockchip,rk3588-bigcore0-grf
>>>>                - rockchip,rk3588-bigcore1-grf
>>>> @@ -283,6 +284,7 @@ allOf:
>>>>          compatible:
>>>>            contains:
>>>>              enum:
>>>> +              - rockchip,rk3576-vo1-grf
>>>>                - rockchip,rk3588-vo-grf
>>>>                - rockchip,rk3588-vo0-grf
>>>>                - rockchip,rk3588-vo1-grf
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip



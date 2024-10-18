Return-Path: <linux-kernel+bounces-371017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D589A353A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF56D2820DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2723D18132F;
	Fri, 18 Oct 2024 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMuCuTa7"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE115C144;
	Fri, 18 Oct 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232325; cv=none; b=ZaiHEZNqeapWeH0Ewtncg3PhT8DpeaG8ZB79TeSs5iy/EbCtsFvvrD4fy3loYvK1TWwWSvBm7mjI2QN0sfCGRvNW0WePQy9Y5w3soesxluzQjYeTNcGZf5HtMaQ1xZnDAMh6n65dPm2mSRMmdCtr/E+hvmUAOvE3TlHefxjtwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232325; c=relaxed/simple;
	bh=NzeMR7erdNWgJu71wd43ok/PJEvMdq8EmPPUMY13qLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikdk0MyLXTIdutZSXRq6ClWBipldinhu07uvVHfy0113sJrALI0NOA6HO1/rjx7zs6x9+Ekh6n18KyTgvQHz0jY/ttj0ay4QI+Bh1aSS22nsklv5M5BvdgwuMILAzw2OgMxp0x9Qj7yveOEZ+JCkowMR5C97pIMzWiHMte8NE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMuCuTa7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so48007a91.2;
        Thu, 17 Oct 2024 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729232323; x=1729837123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouUINbwY2JBh/LI60xwCfEtsQIXolR7Vwp/EQ6dj3+o=;
        b=GMuCuTa7dJfbJ2Lg9UKOKhWq9467HQ3tbf3iqoWVLqkK5u4lh2T/G1692DARrNpzLn
         gOrOazGE4gIYxm+yEglqctLkDrfd3x/ROGF1XHK8nX/NY08uivObiBTDj8U4dewcdJO4
         jJxBgTTPzr7z+MjP6wzf4VeZLYSIaO9U18gzZddsaFG8HdTG4swkEP6GPxYlqBJ8phK8
         7T4uz33dy4jbCawDQETH9WCdOSjqPK1/U6lRS6LeuEwHrUBDw6fparfA7ep3CqPBeYeN
         efo3ZATC2/mqygkChqwzRHqywcbn5xmzY0R61AaGmATHYVkcoOMy+blI4UnpzSI/NdUP
         GJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729232323; x=1729837123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouUINbwY2JBh/LI60xwCfEtsQIXolR7Vwp/EQ6dj3+o=;
        b=RFxgV6wQFEnAngw02fjCp/6qN3B8xd6yXZ3zQgvTqQjz1Wiydx/k1t5bcXONOpVwIz
         8JmV9mHxBKnFESIUcmZDSQkBIU90S3nEDK7CXjQpKGBkvGxBcgrjDsVRn7GXCYlF17im
         nlLtRsiMYva03FZh8BlMffxQ3+6n2l4zIjZQhKiNdQ5givGryX5jyMXSN7n1MBxYOwLE
         uDB1uMW5UsB6nADzSwf4wVGN8JHGrq2kHEn1cCUgfFm6vom0deTG3cSlBM3kVHMD2ZBl
         HuTOcK4gOZgmE4PrT7jy7UeyGb6in+sFDIvA9osu+7Cwxx2UZPVgEE79ICBYK9vNjEb4
         3PaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXANVBTkxnaMrHqElC9q2YuJ7vWRp/q/r/LYvJCnY4Z428JtW5x3abGKuiRSRjaswDG3EkDcV4Klnue@vger.kernel.org, AJvYcCXK53K8ySzKEn+GNjXkawbLelmG1Su67uzamQzXIN/QrCB0qyk2JeI8+6/v6w0oTSr1/dyRschrZ54uUfab@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8ZXZW3XWcrj5h3BkTHGwG8Re4zDvPbU3/QA4SwRYYrUAf/m9
	fAkwfRyTSGXDxlqp74yZabY39yY1FhBx5VFfWWCkaWoNZaDLbaAcd1xLYw==
X-Google-Smtp-Source: AGHT+IHTa4o1U0/RWcsBQd2x+1sXi55hJr+ER1bPmWHpKN8wglThFLNxkxKayVdgTq2xyvVigaVFug==
X-Received: by 2002:a17:90b:1a81:b0:2e2:ada8:2984 with SMTP id 98e67ed59e1d1-2e5618d5990mr787518a91.4.1729232323248;
        Thu, 17 Oct 2024 23:18:43 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8d6cf9sm5875815ad.143.2024.10.17.23.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 23:18:41 -0700 (PDT)
Message-ID: <d2a200aa-1301-4940-a39c-0412fe741994@gmail.com>
Date: Fri, 18 Oct 2024 14:18:35 +0800
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
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <ca0ee8752791f53bac23933e1582dd86@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dragan,

On 2024/10/18 13:02, Dragan Simic wrote:
> Hello Frank,
>
> On 2024-10-17 04:52, Frank Wang wrote:
>> From: Frank Wang <frank.wang@rock-chips.com>
>>
>> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
>> configured in usbdp phy driver.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>> Changelog:
>> v2:
>>  - This is a new patch adds rk3576-vo1-grf syscon.
>
> Could you, please, clarify a bit why is this additional patch
> needed in this series?
>

I mentioned in the commit content. The usbdp-phy driver select dp lanes 
via configuring the vo1-grf.

Best regards,
Frank

>> v1:
>>  - none
>>
>>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>> b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>> index 50d727f4b76c6..fd42217ab85e7 100644
>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>> @@ -33,6 +33,7 @@ properties:
>>                - rockchip,rk3576-usb-grf
>>                - rockchip,rk3576-usbdpphy-grf
>>                - rockchip,rk3576-vo0-grf
>> +              - rockchip,rk3576-vo1-grf
>>                - rockchip,rk3576-vop-grf
>>                - rockchip,rk3588-bigcore0-grf
>>                - rockchip,rk3588-bigcore1-grf
>> @@ -283,6 +284,7 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> +              - rockchip,rk3576-vo1-grf
>>                - rockchip,rk3588-vo-grf
>>                - rockchip,rk3588-vo0-grf
>>                - rockchip,rk3588-vo1-grf



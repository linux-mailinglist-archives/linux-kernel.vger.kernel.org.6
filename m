Return-Path: <linux-kernel+bounces-337904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E49850DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BBF1C22C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083D148307;
	Wed, 25 Sep 2024 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bytncnkh"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C99136672;
	Wed, 25 Sep 2024 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727230169; cv=none; b=JgFBr7CkQrK413XBtn9boOJVsxtfjB3Zk467WKPWo8SbCWj0expSIvpy0MaD9t0JAtZoBx87vS3jf4P08mnvpx2nyeujtEXMRi3prmoiGvw+c7NGT8p7gSG4ZFCRXN1DV5AioSjTZf2iPnxar9aeqz7cD3ioRzV811SC0tB7meA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727230169; c=relaxed/simple;
	bh=dALrHiqc+AULWuHCigbUNG/T0LDQA1gxAoWOKjKKFpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbjME6017OthbFKGSpaRWdABimqe+c9GCKvzSJiklFQS/A9PAUa3ifVlIlDRf8hHL/DXKv0OHLqG10X5c0w9YkXE91mbqKUPNPm1i4HdQco70bCt4V2Wd8ZKbNIE4qy1G8xt5ACfzBCAuGsbJVtzaA1FfqgkCosDDNi8AcX4Bi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bytncnkh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8a9a15a7fso1176057a91.0;
        Tue, 24 Sep 2024 19:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727230167; x=1727834967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhT4emZQMu0iLsfja78mVDr5B3L8j965fQjbvHU4u9w=;
        b=bytncnkhhzX90WPXW3QnqW2R4zbU2jmCCWm3oapUDF1othhy9pdEtUvdSh9VefvawA
         dDT6jnTcGVZIREZaj20y8rLWNt8NtEFbdlqKj2+AE9jBK/zG3t+WLCMHsQqwuw1O5S//
         qR64AyPr1g4R2yJYz3Rmndwp4GJoPuDv7XG76wdERR1pthjeketNhrGUaBUnvzMexGjW
         lnX2D+nVbe3RmMGq1ebLlpYt20BTksmYfwv86jKhqZX8ARWxkxpzdsgb99ZK1h6JuXGx
         vw9BSUG7NWWJ7wcU4O4Ph4Q/qCb2oaEomf4T+/ZMnpsG3lCmum/9NTuwfzHBqAoQvCFt
         m3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727230167; x=1727834967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhT4emZQMu0iLsfja78mVDr5B3L8j965fQjbvHU4u9w=;
        b=eg9FsP/cafsbn+f9y2oh5oqG8urQJuebDnQH1sdwR/cdMey5kM9siN41C85wm4Jgy6
         xIh0bItX5te2ORkqyzYz31yohY/cw8pFxyy0gLu400VFV916jp10Y+UA03P5XVAxhUin
         agoPbupdZPATIGp6ZOaeIfSZ0DfCdqFggSjXdmfgidnDaCvTbY2bv/MOPXAXCEJx9kiP
         dkZ+0Y5cupuu/sMtoRdDwekiFtQTogPwPOs4hkFlqpumZ82piF/iO2kztNg/I8PVQ96W
         YZGb1lT2j4ZTe7wcjBFcjXM+AonPjsq6T09wne5TP1ZxzAzKDfSDxXqkakVVbzkBiLbE
         /Kdg==
X-Forwarded-Encrypted: i=1; AJvYcCWmlHoJ+VJA61Ga8vX1sCEE+YXAT3eq9NVYyI/lot254+cx30jZanbDzdiUIyZiaSHWE1Coj1PI0eZko8r3@vger.kernel.org, AJvYcCX+EWAv4eLWrmiLdtFo/bJ/c6oT8JoPoBKZyk0ncTZMc+PW/LR1Ni9cSE44o/Nw2ekIScIajbEwfk6V@vger.kernel.org
X-Gm-Message-State: AOJu0YyarYQfwjRIaQxF7vyMSZ0zhohiVKA+/mw3mLC5jJDVzruVjMGa
	tPjNNmNUNCGBzlThe990K+7bBIj1Sy/+/NXqCSBkBFeqaO6L7HGz
X-Google-Smtp-Source: AGHT+IEgOjNFa2IPtnydRtu4ja6d33MWXnvg3q5KwwfLA4hgKFc9OYCnHhghim3qoE66AaUQyL+GJA==
X-Received: by 2002:a17:90b:3a86:b0:2db:60b:9be5 with SMTP id 98e67ed59e1d1-2e06affdd19mr597228a91.8.1727230167336;
        Tue, 24 Sep 2024 19:09:27 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e6660sm287402a91.24.2024.09.24.19.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 19:09:27 -0700 (PDT)
Message-ID: <87146372-6d05-4994-8f64-47f4cb07e2b4@gmail.com>
Date: Wed, 25 Sep 2024 10:09:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, krzk@kernel.org
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com,
 Frank Wang <frank.wang@rock-chips.com>
References: <20240924085510.20863-1-frawang.cn@gmail.com>
 <20240924-overtly-curable-13df2e7fdc9b@spud>
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <20240924-overtly-curable-13df2e7fdc9b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Conor,

On 2024/9/25 0:11, Conor Dooley wrote:
> On Tue, Sep 24, 2024 at 04:55:09PM +0800, Frank Wang wrote:
>> From: Frank Wang <frank.wang@rock-chips.com>
>>
>> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>> Changelog:
>> v2:
>>   - Categorize clock names by oneOf keyword.
>>
>> v1:
>>   - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/
>>
>>   .../bindings/phy/rockchip,inno-usb2phy.yaml      | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> index 5254413137c64..8af4e0f8637fc 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> @@ -20,6 +20,7 @@ properties:
>>         - rockchip,rk3366-usb2phy
>>         - rockchip,rk3399-usb2phy
>>         - rockchip,rk3568-usb2phy
>> +      - rockchip,rk3576-usb2phy
>>         - rockchip,rk3588-usb2phy
>>         - rockchip,rv1108-usb2phy
>>   
>> @@ -34,10 +35,20 @@ properties:
>>       const: 0
>>   
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     clock-names:
>> -    const: phyclk
>> +    minItems: 1
>> +    maxItems: 3
> clock-names isn't a required property, you can't allow jumbling the order
> like this does without breaking the ABI. Why can't the new device have
> phyclk in position 1?

I sent a draft changes in patch v1 comments which put the "phyclk" in 
position 1, Krzysztof said I have messed the order, so I reorder them in v2.
Did I misunderstand? anyway, should the changes like the below?

@@ -34,10 +35,20 @@ properties:
       const: 0

     clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3

     clock-names:
-    const: phyclk
+    minItems: 1
+    maxItems: 3
+    items:
+      oneOf:
+        - description: PHY input reference clocks.
+          const: phyclk
+        - description: aclk for USB MMU.
+          const: aclk
+        - description: aclk_slv for USB MMU.
+          const: aclk_slv


BR.
Frank

>> +    items:
>> +      oneOf:
>> +        - description: aclk for USB MMU.
>> +          const: aclk
>> +        - description: aclk_slv for USB MMU.
>> +          const: aclk_slv
>> +        - description: PHY input reference clocks.
>> +          const: phyclk
>>   
>>     assigned-clocks:
>>       description:
>> @@ -143,6 +154,7 @@ allOf:
>>             contains:
>>               enum:
>>                 - rockchip,rk3568-usb2phy
>> +              - rockchip,rk3576-usb2phy
>>                 - rockchip,rk3588-usb2phy
>>   
>>       then:
>> -- 
>> 2.45.2
>>



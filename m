Return-Path: <linux-kernel+bounces-258878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF181938DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8231B1F21138
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D416CD01;
	Mon, 22 Jul 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="0IhFle3D"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DF31B977
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645154; cv=none; b=c4nglvncBHTNN7gT72S9S+sSMHlKUTCoiL/KPqsqGY8vJ4oe2vqf6v/3pL2jfMdZPAgoe+1UxNwkD18pLSg4VfOuWiGP4TnAQRnwR/9nfUqdI7K2nyP1VA4kGIUXJ/Otpzw/n9uOL1GqM9e+KdBbB2DEAlmcwf4Zb0Pf4Q9tDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645154; c=relaxed/simple;
	bh=aF3j0TrmnVp1p2npQybDiv9LcE984vxGW4haXJ10hMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6nB9YfwCDK66a8Fj1tjxv3wnDj8TE2owP/Jfi1FFazI/AXrAbmuQLJ2tGWbG1RNUJUYo9N5SAhzZssq9UZgiCSPj+0MGjapOh4WZvFcuKZ2UQEtYJRtmJiPrj8q05pguNgaUacGO6MaeezinYUAgspZeoT3DyxPyHcFirO4ZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=0IhFle3D; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d0fc15efbso26123b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1721645151; x=1722249951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yk4UQACOPEhu0mUYszop0tJksRuFg9b/i8uYeB9F4sQ=;
        b=0IhFle3DAfFitRliix32nUj3H1My774JMDpbk/6S/WygCcTXtVli0pym5Ga5vqhqR4
         TxlX6jvvclN4WpajwpMXC+vbbHTsll8QhwSpo7v9UeHZxzOfBukQkNvU/e09GnjVvmfS
         O/Gc6jRnr+6S+i1VeRUE/t/2ai0n2tqDu3wropDjmB5B9CKchEY8hrYq7hqPs8Bn10Gn
         fDcD63WBdQsRP4IqOtj1jtc7LJqrcI1No+zxXyXA6swN9670fJCsQNhVCarwyyxDtXgj
         1Pe9W82Qh+XehAtNRirohnt5T/mgEyHeO6g2da3bGZePVgeNqnNwVQzouYmCATaQZYJI
         I5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645151; x=1722249951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk4UQACOPEhu0mUYszop0tJksRuFg9b/i8uYeB9F4sQ=;
        b=jlSypS2CEW2BZh0qFfdBzM/r1jygaVa/OhlvJPkHS4IWX5VrtJ80fBbfbjEM6R1xMg
         JDKIwV3/7/yVZfG7mLa6Zx0GsT5oDRF7qdOHBw0J6alOnsVzEf3rtby4oEo0YLTyG6zT
         0A0SXjwhxnoR++gYKe0Nqmp5X4Gw+mWBrl8x5Oz8YrLTFcxSVZ3AM6Y5aTTz5pqff9f9
         B+Uhsd5f3uh/xSrLqve1gfZDJRFM2yINKM4n6xGlgDi0e2v3hptUIBOc2th3fj4zBq/Y
         TkKOZlSKCLjDLyyTytKC0DVxz/ghcQuTt0c36rMmX9kD9l7Ab1Bqo3fKxulDpnDzbK08
         tQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqjcQV+mHQZJPHqpO7pHxLSnjZGjGbd/EVkRk7nbM851BF7KdWu88Xe0aLfTWuloqf3EysLSrPjmuoxASN7ZAylWekZc0IaszeIR0e
X-Gm-Message-State: AOJu0YyDxvjvtSciHXye2bra5DCGMrMzYPUatlE/fbEn9p6A54iqqOR+
	WEocMsyaO2884FuE0I/zMvP6Gl2kDQbYwkQdJUyehn2f/w6us/VNymI+f1E3tw==
X-Google-Smtp-Source: AGHT+IGbTDbBwca1C4VrH0/hA3S6xV1DimazE2cwql0k7QUaUo+m4vZviNr4xZ00h+PE/OuBz/gSuA==
X-Received: by 2002:a05:6a00:391b:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70d08635b76mr5376790b3a.3.1721645150824;
        Mon, 22 Jul 2024 03:45:50 -0700 (PDT)
Received: from [172.22.58.167] ([117.250.76.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff5a149csm5078144b3a.169.2024.07.22.03.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 03:45:50 -0700 (PDT)
Message-ID: <5a865811-a6c0-47ad-b8a0-265bb31d4124@beagleboard.org>
Date: Mon, 22 Jul 2024 16:15:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: ti,cc1352p7: Add boot-gpio
To: Conor Dooley <conor@kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>
 <20240719-scuttle-strongbox-e573441c45e6@spud>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20240719-scuttle-strongbox-e573441c45e6@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/19/24 20:25, Conor Dooley wrote:
> On Fri, Jul 19, 2024 at 03:15:10PM +0530, Ayush Singh wrote:
>> boot-gpio (along with reset-gpio) is used to enable bootloader backdoor
>> for flashing new firmware.
>>
>> The pin and pin level to enabel bootloader backdoor is configed using
>> the following CCFG variables in cc1352p7:
>> - SET_CCFG_BL_CONFIG_BL_PIN_NO
>> - SET_CCFG_BL_CONFIG_BL_LEVEL
>>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> index 3dde10de4630..a3511bb59b05 100644
>> --- a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> @@ -29,6 +29,9 @@ properties:
>>     reset-gpios:
>>       maxItems: 1
>>   
>> +  boot-gpios:
>> +    maxItems: 1
> I think this needs a description that explains what this is actually
> for, and "boot-gpios" is not really an accurate name for what it is used
> for IMO.

I was using the name `boot-gpios` since cc1352-flasher uses the name 
boot-line. Anyway, would `bsl-gpios` be better? Or for more descriptive 
names, I guess it can be `bootloader-config-gpios` or 
`bootloader-backdoor-gpios`.


Ayush Singh



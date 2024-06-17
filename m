Return-Path: <linux-kernel+bounces-217113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C98690AAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145191F233C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AEE194132;
	Mon, 17 Jun 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYyJK7R9"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26A1BDCD;
	Mon, 17 Jun 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718619663; cv=none; b=nh7Y0GXHva0Y93gjevq8Splf+3HUvh0+e8xBh7lA/hxTt0+iOAdB5wD21AdOO1lrd6pyoBBxVWT+YSTFzHybrAMPqxavN3K7Q/Sy/WYLG399wscVdLVhMc6dsAbfl7ELkktCdRRSS23e9/NEQSaw83ro/pLQuwTQpZmZajrKKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718619663; c=relaxed/simple;
	bh=hma8mMPlNw0XPIyVpQPHEbIDI4S64MWji2iDW3ZuWZU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=puXOUDzCAhuSIfhECtCNJleFZ6h5Xg4VVjcPZwkqgEYFE1yc7pxAPnOIx95LLdHvpLPpt7Bkfn/ESrZuYN9EAwlxiJYXkbu1bkvco/hpfXupxO8N//6WK3vecoLlijvmNf5QCAZonTKIkjf624fH7gzd2JjSLzNFXgIKqldNCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYyJK7R9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a63359aaaa6so633183566b.2;
        Mon, 17 Jun 2024 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718619660; x=1719224460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uHfz5gEjeGSF+rOMoEalB7WTEbRFmK0VDhLIXxLJjyM=;
        b=SYyJK7R9hRyNYh0qdOUDmE7QA/WtTQKTwiqR76JshjqM9TV62gzyfA0o2IVbVjytuc
         rLpCzHgTGioXDcGqdxy/T7lhVE7keYt8MARXGS2tWEGdbeyD64A/28auanksh/uAyqpb
         KRD4cEypIXM88bsZFUPielXqDvrNWJCyqieEFv6+oPzziUdOICHHzCdguPoUogzlD2bG
         MNtOX/jmApZf36O0Vpgbk64sGALUFUwbloOyCazs7rto6SUR1353k+YoYr5099ypdqGj
         n3V2PTpiR9zvAXTSO1f+GgHDMTKMfYz45lq2s3Hx/u4Z/miXzSgV5bUz1MxdgySdlYqF
         eaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718619660; x=1719224460;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHfz5gEjeGSF+rOMoEalB7WTEbRFmK0VDhLIXxLJjyM=;
        b=mVCqVZ9Ph03QBrEd/zFJUsQDpSY/HMRwRqgkJcsYIAr/bEVasmRb51gQzUxln73KQE
         6BUxQ3cBN4a4g89JPdTR7l+lwSIzlTfaXHtzDEYHIDdPcn8h+bfB52Sx3Gt/FUgz4XpA
         0x7On7riCG0dDvxbFazB0p0Dd/6oV9xHR3zjkeXFb8gldfGG/X5Vtg/7mXdt9+KyVmsF
         qcpLkAJbvSKBbWjO+/6ecgmI33HqrDdiTYOkbH3UlpP7wdvH+x7LSKawoIglrOEhSp7l
         ck4lexmvtJvYbc9Mz6c35RQd3yRwPXkB4U9n20iAgutx+glixEa0T10kC8UJnsMdZcG3
         WoZg==
X-Forwarded-Encrypted: i=1; AJvYcCULGIRNOlkMX4PzQqJ2TxGTO3FIKTeCrEq/CocMeqJvkGaEDvvq8y6KayJyO3tQqDO1CL0hW0v20+fy9BHSfnHyXwfMm4/9+YuUW8byxtIKTEptiT8Dz43E72m70l27pC0LAdg3+E0JEA==
X-Gm-Message-State: AOJu0YxafKAWKJxbC3JpVSHlMIH69nKt0H25aIqb8/s56aKuQ0t1Jh0p
	y60gimLpcPmHFlN8jilpgtBUHVxhwaX+37Z5+hTNvwRQmXKwXkZ0
X-Google-Smtp-Source: AGHT+IHeyhFwbJ02FHOefpxR67mlMUl7SBsrp6KlB/ktW30pRVoaZ2fDCDwgr8eiuKSf7S+gP/BYVQ==
X-Received: by 2002:a17:906:3e96:b0:a6f:5c1a:c99d with SMTP id a640c23a62f3a-a6f60dc56fbmr551002466b.53.1718619659791;
        Mon, 17 Jun 2024 03:20:59 -0700 (PDT)
Received: from ?IPV6:2001:8f8:183b:6864:7071:8881:6a51:3e82? ([2001:8f8:183b:6864:7071:8881:6a51:3e82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3344sm508978966b.19.2024.06.17.03.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 03:20:59 -0700 (PDT)
Message-ID: <a25472f5-3e88-408c-a033-5e338dce6340@gmail.com>
Date: Mon, 17 Jun 2024 14:20:52 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
To: Jacobe Zang <jacobe.zang@wesion.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "heiko@sntech.de" <heiko@sntech.de>
Cc: Nick Xie <nick@khadas.com>, "efectn@protonmail.com"
 <efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-3-jacobe.zang@wesion.com>
 <f147be11-fc35-44c2-88e8-7421fee47ace@letovo.ru>
 <TYZPR03MB70017A6280F060A6F4A1DD9880CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Language: en-GB
In-Reply-To: <TYZPR03MB70017A6280F060A6F4A1DD9880CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(sorry, the previous one got sent in HTML by accident)

On 17/06/2024 12:55, Jacobe Zang wrote:
>> You refer to wlan in the commit message, but there is nothing wlan
>> related in the patch itself. Update the commit message perhaps?
> At that time, I want to describe that wlan and bluetooth were from the module named BCM43438. But, it's true that wlan do not be metioned in the code. I will update it in next version.
>
>> I thought you'd need to also reference the respective GPIO to be able to trigger its
>> state, not just switch the pinctrl configuration to GPIO.
> You means the shutdown-gpios? I configure it in the bluetooth node, it can't be configure in rfkill node at the same time.

In Documentation/devicetree/bindings/net/rfkill-gpio.yaml shutdown-gpios 
is listed as a required property, did you try building the sources with 
CHECK_DTBS=1 in make arguments?

If you already control this GPIO from elsewhere (such as from the 
bluetooth driver), then perhaps you don't need to define a separate 
rfkill device at all.

>> I'm also wondering if bt_reset_pin is the right one to use here. On my
>> Rock 5B I had to trigger bt_wake_pin to get Bluetooth up and running.
> Yes, I try to configure bt_reset_pin, bt_wake_host_irq and  bt_wake_pin in pinctrl separately. Each of them works well. After I connected a BT device to Edge2, I input rfkill block 1, bluetooth function failed. Then I input rfkill unblock 1, it can rework. So at last I only configure the bt_reset_pin.

That doesn't necessarily mean that the hardware gets an rfkill signal, 
what you describe above could also come from the software alone. It 
would be great to somehow check if the physical pin state gets triggered 
once you switch rfkill state from userspace, and then that the bluetooth 
device handles it appropriately (e.g. gets into a hardware-disable state 
somehow).

Best regards,
Alexey



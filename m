Return-Path: <linux-kernel+bounces-356386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A9B99604B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D96282F51
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383B17B50B;
	Wed,  9 Oct 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Rx3CZs"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4D154BEE;
	Wed,  9 Oct 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457518; cv=none; b=atC/8LFW1WrjMMFd0bMt3KAMQymiK4UDWM4hzNfblRHjoQAt9INhg26X0GFx3sv69x/3XJtvqCCmYQu50+d0pCzA0kjf+voBHcp1H9b8Yw8ZW/SFJxlEzXyQ3OEeGbaIs49QUnA8jpRW0Hy+WmnoMfNgYCKdDMm7apKANGzAAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457518; c=relaxed/simple;
	bh=YCIx982kyUeiQ3vLW1jfbTf3goeF3hAgEt+yuonQZf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GR2UrKYYDLA4luPDq5c3zCO78Kdu9pjd7KLsmYDqym4fm1eVC1JygxyJFO067GlAG9ujIk/XvR3HtLdDCrCHtTUslJ6JF7IKaIT3wpmBpFZHSgKjN+PUn1gAT7/1zFPN3ep3g4+oE/pBD6rS7tybgYr+w7D8gTdCL6K0dq0Qe6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Rx3CZs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c5da67ebdso924495ad.3;
        Wed, 09 Oct 2024 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728457517; x=1729062317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PsttQzQnb+x++Ac4O21sV5bCfoQ9BqH8BGu0KsKCls=;
        b=g1Rx3CZsFHASNTMnSIzzWQW5Wg45sWBhybqxt3NlP2xnwR0LpwXv6Nss5xk+GC4osI
         eu5tB6rEpPtou8kpgALF2lFVW7/KT6ouFFJ6aoUcjXalD1ZyIkfHwKvRrtnNJuKnPTD0
         nvngCtNfY0rynvgcgTH8dIbbH6osM8Yft2e4gSxNfpngworfCvhWpzA9mBku/bFbEHfX
         rBVyG2onYFscsqelkS9VgvRhbSFoKkUFr8rU12xSAr3NodX3nvQC+BSuB2QTcID2/zvc
         2WSd+Lpw8bomJw4bhG/QAFi6ND7CT0aAKK/LOt1AY0/yeiwtAsCO67w+jQ/Xcgo7MCv9
         jPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728457517; x=1729062317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PsttQzQnb+x++Ac4O21sV5bCfoQ9BqH8BGu0KsKCls=;
        b=f1fsSN4wVmmLogdd4JqBm5iNGI3cnpN8omeLFVdcIVhuOTwMNQtoEtCqoWr2XT5L53
         +5x5Rr62/5gm5QiI36MVHj9cfKppKFCI5oYYHMlmocPcmKNaX2+Cnmeal9hjXqdEgGy+
         C3+ZklcmUZnK8aHOU3O6Fl4+YDmUBzbT6RjxpvPA8TS3SyuThlwAA1/C9+KiNb7r6ACt
         r+0ZWLQcr76SKMw107t39UhWixWJhYjb6nIDCL+SAcCBHYisbCEXjVsjWBb6IQW/sOXm
         qOu0hsToQMcSieQ+N2K2CL8YKsHMVav/35LAWBGtyqeebW4XcqNFHdQYD0/mFfABpS6H
         jWkA==
X-Forwarded-Encrypted: i=1; AJvYcCV6FtjILOrzawS+Md1JNUwrU1tVa6kn5S9QdefkeiMo3dLB8ep5wWBK4RjMS0vi9iwZp8L205kIDDyoZ6MP@vger.kernel.org, AJvYcCWIduz7M2MCIRw3M8WgghRpJFsns9sjVO9cooG+ZEcvq44LkdW1c2AzQCBMmxYGFXS31vG7e/0IsfYM@vger.kernel.org
X-Gm-Message-State: AOJu0YzTv9exWNftGLNxaqs66ykhIztNz3RqgQKYJuqPrezySU9oQ8DZ
	fcJJsD5aByIrHVm880StrZHWivo4252TTcQV/OOYcYCvuWxEg5gqFN+8a9d5
X-Google-Smtp-Source: AGHT+IG7PnAUHEJLpzgaXL9YFNjOnk7DuRaS4UAqakjWFQ9FWQK1+0D/8QDxNJWl5tLElNKe+gPb4w==
X-Received: by 2002:a17:902:c40b:b0:207:457f:b8f6 with SMTP id d9443c01a7336-20c636eba31mr9875125ad.2.1728457516823;
        Wed, 09 Oct 2024 00:05:16 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a2bbbsm65245605ad.294.2024.10.09.00.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:05:16 -0700 (PDT)
Message-ID: <e107c9b1-f3b0-43f1-b50a-988fa978188c@gmail.com>
Date: Wed, 9 Oct 2024 15:05:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] phy: rockchip: inno-usb2: convert clock management
 to bulk
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240929061025.3704-1-frawang.cn@gmail.com>
 <jx55slsincpzq6mugfsyc6qpbku2555azj7lithwggo733ggnb@rkqsxpsyoaw7>
 <13fe91e1-2471-4a59-9581-628ce7773fdc@gmail.com>
 <ac325385-cb3e-4002-b100-de73eb5a9ac7@kernel.org>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <ac325385-cb3e-4002-b100-de73eb5a9ac7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,
On 2024/10/8 22:35, Krzysztof Kozlowski wrote:
> On 08/10/2024 05:07, Frank Wang wrote:
>>>> +	}
>>>> +
>>>> +	if (!IS_ERR(refclk)) {
>>>> +		clk_name = __clk_get_name(refclk);
>>>>    		init.parent_names = &clk_name;
>>>>    		init.num_parents = 1;
>>>>    	} else {
>>>> @@ -1406,18 +1424,29 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>>>>    	if (IS_ERR(rphy->phy_reset))
>>>>    		return PTR_ERR(rphy->phy_reset);
>>>>    
>>>> -	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
>>>> -	if (IS_ERR(rphy->clk)) {
>>>> -		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
>>>> +	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
>>>> +	if (ret == -EPROBE_DEFER) {
>>> This does not make much sense. Why would you proceed on other critical
>>> errors?
>>>
>>> You want to use optional variant, I guess?
>> Yes, the clock properties are optional.
> And? So are you going to use optional variant of clk get or not? Is it
> appropriate? Are you going to improve it?

Using devm_clk_bulk_get_all() not only get clk_bulk_data, but also can 
get num_clks. The clocks numbers (num_clks) are used for search the 
ref_clk in rockchip_usb2phy_clk480m_register(). However, right now, the 
optional variant of clk_*_optional functions can not get num_clksor must 
know num_clks, then can get clk_bulk_data. Best regards, Frank
> Best regards,
> Krzysztof
>



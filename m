Return-Path: <linux-kernel+bounces-563116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40DAA63721
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0A816AD0E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32F918801A;
	Sun, 16 Mar 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPxTuTcc"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAEF3FE4;
	Sun, 16 Mar 2025 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151707; cv=none; b=NWApNtHYW4JjIzt01qhsrEXYWbwMwKWYpmK6lWJs0kB4L/sOyKoLW56+/wTI0FDiVAPQbS9uvF0hZKjxjBz9MAClxI9h2n4dYPh/XcUSgBnvzlFYRog9OHC8EcB0sitcfyAZXtLe8tSrAFocBxLnJbXOGBctmZU5UBcXKxcpwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151707; c=relaxed/simple;
	bh=ekmzAmP8Y8iH5QY/PxjyugTDakULmRUAQEXxogkFKnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk1dvQo0oN+KGeJ7a0j852XZfU2zOzU9IPvatHd4einvR8wtRU83n25UHNph8destUfrGEe9+MOvIHGpiGyf4cw3aTwpmE5xO26nmmLFGizFS90pZNCrwOjtb4bDhZvbNLZnAPtph8T+fTvxQOLkTTE3QUT8NgvigA4J0W1zEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPxTuTcc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac25d2b2354so641323766b.1;
        Sun, 16 Mar 2025 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151704; x=1742756504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaARcnuSuLuxpai/InAGA0xtSCdbGWktXfe+Ii7D/U4=;
        b=jPxTuTccNW9ZDqqDtTSDob5npX+ueDz+Dv9r0u19YWHFqp8C5a/O1K5+dW1l/BFiKx
         ZGzvA4p6AzoWVJSKt+Z1MVoFqAPFNxHxWdaOb1FYHZnSSBKjgdqG5FyLnPCJhxOJZLxG
         KGykkVm2zhskq9y0bJUt9AHe0VdeahWSpxtcOV+fwLXG8WNnsqLvNmuuhvqOyxU1J/ls
         j7+qmlO9plPs6F8qbqmX58QT7wUymWnKgLTvj7hB8FkSxuXy9TfL1gbFvngs2TgnjiRK
         NYX6723JU0JZPtdW8q87xUyTRvc1pNkhYFqcv1Vow5FActQPsupZXIg7MrTja/hs9PnY
         E7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151704; x=1742756504;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaARcnuSuLuxpai/InAGA0xtSCdbGWktXfe+Ii7D/U4=;
        b=ownR68o4Jp3fu2tXSBAa+a+DLUOXGvcYKu13Aa3sjeTdN1CNsEcyxxWDsXruws8YSz
         Hcy+kkIvWh+hCKDz0ex03fVWY9VDeP/OBreFujiRjhh4hDAxaJTMgr3393CNsXmYE35b
         +ItZFONTp+c0APaSsWgwSzbI5o4x1FItsvliAnZWt8aoBIrdDSkEQnlPDSN+Vjpkt93x
         /cMpkNnCjeJkW0T4BtBTbp22OgGbmFzwkD2YLoe5UQsd5b5fW7JzB7EJqa3qx88jyhiC
         TFfyeHz2dYzfXvdh4qOsPja7COUiAyWURCA6/r7593CoT0yUeN/XAqOthan4NHt3QSsm
         6V3w==
X-Forwarded-Encrypted: i=1; AJvYcCV6ORnuR4JWsPHPDaMUr2wRHfLriS8h5hSun8DDr4UBmaMWk0BytHJBgz0+8as15PXDKkqaB8efnmbfoFwy@vger.kernel.org, AJvYcCWl4PlvYJvjIJjPrqBL21y8JsUVB2a3S3SByIWJR5MpgPLIO+ucEe4NxuHQ+EVrgc0FcK9+DXrTCzgh@vger.kernel.org, AJvYcCXXsHnZBusoxtmFA0VEFzUEFgRjngy47hsFG7I+uhvBG+QNRtv4Vqvc2diUjN4AoaFC7NnguSHdAsij@vger.kernel.org
X-Gm-Message-State: AOJu0YyyiNoFzzPfs1Ij6uU/hiFsVz8SSE8wq4Hz31ghuo3ks7fxs0FW
	UnNEfcjjKNWTpzrBncD504LCGBTZvITUkGNs9GDRa+o4PitK07h8
X-Gm-Gg: ASbGnctQ0N18ICPcZ5u+tYzHJLVRuHV1THUs9fwWl8PMowtqi3eZo1gK+2ABazuREdK
	+J6ieZkkaeuutYgGS/fgDZBoJtNni1TJSlXE3UmVIwPgu9u6QelNv5Yow+h6YcCqK+UnogJQL6o
	Or6kDzymv0tP+jQ4cVunTyx59vN+BwgkVxrGJ8VKn0FIYBdObZSAWtOTO/oEjwEW3A7gZ2Knf8Y
	cOQvTtJXdwih/Fw1tsRji2k+AAwfkA5yDjsqnZueilFHDJs2A799SnBlprF408ctK7tGplQdn+r
	q21gv5u2QUArwN5KBl1XyZJJ7u5s9kXgcjOEAXaXQ8ipPyCTHOl2faFDlSV27liPO9GHBACCIdB
	4xeyXbD5+xsp+zJs9f8DIDA==
X-Google-Smtp-Source: AGHT+IHgXXtMhyuLsuMBCutEq5j1h8RgZgLKJgXD8Pc87mm4FhtnDm/alvyi1kWX2iTdBEa+bID4kw==
X-Received: by 2002:a17:907:7fa6:b0:abc:4b7:e3d3 with SMTP id a640c23a62f3a-ac3302f1068mr1042069866b.27.1742151703874;
        Sun, 16 Mar 2025 12:01:43 -0700 (PDT)
Received: from [192.168.50.244] (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a4094dsm527846366b.126.2025.03.16.12.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 12:01:42 -0700 (PDT)
Message-ID: <fffe0118-6235-446c-a9c5-93f5d1f5ed04@gmail.com>
Date: Sun, 16 Mar 2025 20:01:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] clk: bcm: kona: Move CLOCK_COUNT defines into the
 driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-1-d6fb5bfc3b67@gmail.com>
 <20250310-proficient-free-antelope-abb6b7@krzk-bin>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250310-proficient-free-antelope-abb6b7@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.03.2025 09:40, Krzysztof Kozlowski wrote:
> On Sat, Mar 08, 2025 at 08:50:39AM +0100, Artur Weber wrote:
>> CLOCK_COUNT defines for each CCU are stored in the DT binding header.
>> This is not correct - they are not used by device trees, only internally
>> by the driver.
>>
>> Move the CLOCK_COUNT defines directly into the driver in preparation
>> for dropping them from the DT binding include.
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>>   drivers/clk/bcm/clk-bcm21664.c |  8 ++++++++
>>   drivers/clk/bcm/clk-bcm281xx.c | 10 ++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
>> index 520c3aeb4ea9c4a431512c0909f9545c1761d17a..fa6e1649d6f5f459b63026109caea9e2f72e22dd 100644
>> --- a/drivers/clk/bcm/clk-bcm21664.c
>> +++ b/drivers/clk/bcm/clk-bcm21664.c
>> @@ -17,6 +17,8 @@ static struct peri_clk_data frac_1m_data = {
>>   	.clocks		= CLOCKS("ref_crystal"),
>>   };
>>   
>> +#define BCM21664_ROOT_CCU_CLOCK_COUNT	(BCM21664_ROOT_CCU_FRAC_1M + 1)
> 
> I hit that wall too, no worries. It might surprise you but 0+1 != 1 :),

Do you mean that I should specify the clock count directly rather than
incrementing the last ID? Some other drivers seem to do this the way I
did here (samsung/clk-exynos*, renesas/r9a06g032-clocks.c).

> so you redefine a define. You need to test this patch bisectability.

I assume renaming the define to not collide with the old name is the way
to go?

Best regards
Artur



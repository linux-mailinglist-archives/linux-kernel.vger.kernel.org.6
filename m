Return-Path: <linux-kernel+bounces-416557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F63D9D46D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB82CB23C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AE13C3C2;
	Thu, 21 Nov 2024 04:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmu2K4iq"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBD230992;
	Thu, 21 Nov 2024 04:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163766; cv=none; b=DESq6rXOCYAdpU2SBQnjWgPrHaZS6ZDITWP8ivQm7NeGDB5Jo7lAKcqkyI1r4KebO531o+06ONObn3ktJPKyULtpJM9WQt/6LipKZ+k895gqgGtdtHq1t2AFtg05xPBDIrl5y9fV4h1JcjKwvV4VHvQofqzkC1GEsTNpJpsd41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163766; c=relaxed/simple;
	bh=w/ZDhYOu0RkIOtqFQxjfFSWf+1RINjccP17wzWKW3yI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jV5cxrk3kRvi3JmjrYrE8Z/+/WEyDXuXaXdXpS/4ZRWO4ALh6YCrpgM8+HUXnd5of8dRrxKu4gHxW8WnQ4p3ub/XyTNyCCBXHiNKj2LUAXAScUwDE4KJNv4PW6ICbJq+R8N7rGLizlDBcvFezn9OQscuypPdnSTKK5gKz73M0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmu2K4iq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so512762b3a.0;
        Wed, 20 Nov 2024 20:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163764; x=1732768564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/0XIMY2uA6o6zIyzy4M5ULjqGepYEcYqaZjgiCOkJw=;
        b=Pmu2K4iqDrCCxmn8l2KgUS8Gb7cKSIILHjD9h9wyHJmcn0bl96YFr00f0c02blTjjS
         6kHTI3Ve8wLuwbz8vgsTpoW/wlXJKKQj/Y+KweAyTScz0keI4SZ95fxrmJa5ApVPqMfy
         Y4lKACOIE2D5XlZb5LVcPmwkBZq+TDcZrcfo7NkgtC5VMXwEoJpAI/zzyy1mhtCOFlma
         mcUD/pU1YwU66tUTSQDUpMZi3QMwwee6P8dRNKSe+cLMCtq0uYq5geVyi9kqD4Gp/uos
         Ka0O8B1yfR8G2/TICOUT9KIKxHzQMfApP/TVkibS8UNKQAjHf5YzRl+tgFRc2zxzZPez
         VUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163764; x=1732768564;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/0XIMY2uA6o6zIyzy4M5ULjqGepYEcYqaZjgiCOkJw=;
        b=K70HboIrPW55kId334xGzFOps2WcGoo82CgLs6m26suZFypNSnFswu1B4rIm3H4G3B
         YDNso5TA2IvZj5geI3j6CrscM54ZGlMSlPrwj6GnXMP/09/IMdhw4Whm7niC4jhMdU+v
         CQ9bzcSkdioHPLZi9Halp+R6Wc8rV7sbBKTl4srqb3tmWfdDJhlVfJbcPYjcRXQZUA1L
         H+2JVX8AlycDiNdfBMPS2nJHa5ih4aVt9yx6NaSbZoXa8aast/6pFfkte2fe1ItF9ZnY
         WJbf0KYRYc38oHeK1LudiQK5nZgk4Cm80yRvFkQhhU09vE+IOQmwLLjbKFz+e40+cyPt
         6hxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7AnUgbdG0H0BYG0VofK8eQHjv9yGabZLA+0zh01xHqG0gyseiaT0rUxsFzHUkAtJaTWbxaSRJZEusRd7r@vger.kernel.org, AJvYcCXd++veNDjV8ykP5hCUfJ8Ot3XP1mx13wsHmCbDWJQIxfADBA+3+WjUH4ZQkJBJ1cBNWjkVfHX6yE0m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VqVDFfNEO9MFWXG6p3j6AEWAzpSmtZmdfEutPjOO2xJ0ykZb
	lTg1y9n9gYyNFfeknLARPeT1vKmCbln+0aczKPJ20gxyzY95gSa3
X-Google-Smtp-Source: AGHT+IFaemvzryO7WCLz5Ca6Xg1J+x2yyqw0JJSN0FkNyVQdTywTiZN7n88034g5Msg4VO8+oq5ykA==
X-Received: by 2002:a05:6a00:21cd:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-724bed5a647mr6328217b3a.22.1732163764184;
        Wed, 20 Nov 2024 20:36:04 -0800 (PST)
Received: from [10.10.14.80] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb659fccesm393651a12.73.2024.11.20.20.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 20:36:03 -0800 (PST)
Message-ID: <b13e5063-3b07-43ec-a7cc-b19e73b7c9e0@gmail.com>
Date: Thu, 21 Nov 2024 12:33:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
From: PeterYin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
Content-Language: en-US
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,
   I believe this series' path will conflict with upstream due to 
version differences between OpenBMC and upstream. I will update to the 
latest version of the DTS from upstream and submit a new version 
accordingly.

Thanks,
Peter.

Peter Yin 於 11/21/24 10:53 寫道:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
> 
> Base on:
> https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> 
> Base on:
> https://lore.kernel.org/all/14e1a0f581417d4228aea8c2569598d42b4bd334.camel@codeconstruct.com.au/
> 
> v1->v2
>    - Provide additional details for SGPIO.
>    - Add adc128d818 device
> 
> v1
>    - Patch 0001 - Harma: Revise node name
>    - Patch 0002 - Harma: Add retimer device
>    - Patch 0003 - Harma: Revise GPIO line name
>    - Patch 0004 - Harma: add e1s power monitor
>    - Patch 0005 - Harma: fan board io-expande
>    - Patch 0006 - Harma: add adc128d818
> 
> Peter Yin (6):
>    ARM: dts: aspeed: Harma: Revise node name
>    ARM: dts: aspeed: Harma: Add retimer device
>    ARM: dts: aspeed: Harma: Revise GPIO line name
>    ARM: dts: aspeed: Harma: add e1s power monitor
>    ARM: dts: aspeed: Harma: fan board io-expander
>    ARM: dts: aspeed: Harma: add adc128d818
> 
>   .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 134 ++++++++++++++----
>   1 file changed, 110 insertions(+), 24 deletions(-)
> 


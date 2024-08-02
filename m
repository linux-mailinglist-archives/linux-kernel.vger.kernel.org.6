Return-Path: <linux-kernel+bounces-272115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E5945738
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ED11F24742
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65D2C1A5;
	Fri,  2 Aug 2024 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRx9c5yf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD4DDA6;
	Fri,  2 Aug 2024 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722574665; cv=none; b=uf7xg73tfZavyIZGQMKGHWIs5wuoD+J5anX/IUBNmZFq42zjIWnZouh9R+C4TnmSS78pJGWOFD8EL4zklG+AIUhq7kd75WQv5tmCF+RPRI3kyBS0VvyHqCNTaQYA9Bk1MOWj9b9p72Kb6YdP5ZJ9VXTHpWn+rthFCO4OWWGVDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722574665; c=relaxed/simple;
	bh=ClY1xWctajAODs8lW27Ly344sHCaHVC1TvyMi1aPCGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GftZGiYunMF5U3F9IuvOXDpli6aDJEefh1GOp9LLQs4CFX3ggounvVeYMr7K/EyYeGcjjtsJjP4PVe97bQLB9Eh1Yc3VrbPs5wXq7kqWk1Y1EUmIU2ge4hnobycbtquDHRN2UroHuTZmVQ0250+rqVmTmur3ZHdKwd/OW1F48e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRx9c5yf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc5296e214so61441285ad.0;
        Thu, 01 Aug 2024 21:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722574664; x=1723179464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClY1xWctajAODs8lW27Ly344sHCaHVC1TvyMi1aPCGo=;
        b=WRx9c5yfe3EjSuxxz87LRoZKYwxIauN9+P9wuZBt7kebprhIIp3ymQWRb+9VWW//Q1
         tK/PLvWA15U9B9mvQWMS9w9ndVO6vVPWWg4RSjynkcKWvPqbg062vWisnaMhdiKD2lNo
         ZPNqQSfb5abYu01aIuPy+NtTM8QsVHR+nIHAFLZOTep7XgyDd7PlBDcdnAIjiqI9Q7o6
         CYlyXQf4qouCCn4nGyq9Tet8WTIf1X8aG+CPViyTPv+fA9Q5vKpHj61RiyCQma9xbmfc
         t9YH/Z/3TcSEHs0Mv1eipYHk+FUwnodeF8Xpz+BQVy7q8xtQrXXH8eY5ddhzuvje9dgs
         n5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722574664; x=1723179464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClY1xWctajAODs8lW27Ly344sHCaHVC1TvyMi1aPCGo=;
        b=gyq9hyakRF81clROIw9NOLczjGCeBv3WmEdrmQBlYzQaqxXbewwYNnrnK4OVZvJaP9
         pkXVdnRNoKVU2bzcsT1BEYbvQwh45Ud6bTKcfYl7XV6w7qWM8zU0jYsab4wAowoeiJ4S
         X7oJvwKxiXoMPVH/wGwirmKSpnuHB7s2akzMoWUEV+QWSPPQ9+D3pceH0jGYfaL13cs6
         XfHuXpGAcqx3h5mjQfe5+CN/GYYfmTkaspbDj9nRajYaVmm63xqjd62de5fGXL73KwCr
         hq5UKBYGdv6U0AUPFJk1TYb+ZprBlfzBehnXQHbuHXivuJ166UztkGXfLRoNZuZLxVSy
         UqeA==
X-Forwarded-Encrypted: i=1; AJvYcCXPZ6yK++ojJ68BXfrXyUJESZNESNN0e8fGY9BihmQ1pjuQJDFGccqoo/cK6j45EZUHzqG1JlEn5SVcVsS6aThr6Cj9+rNrbjEalQ==
X-Gm-Message-State: AOJu0YwpjwOlGTs6MLVQ0KwdfJSX0SwNs31gsaDDLXwTMAmT2ZBnhNDY
	thl4Xb/3paAayzNoTg4OD1WcxXSXEWmyOvZzbBfT2ilXHlySDKei4HUV6Q==
X-Google-Smtp-Source: AGHT+IEjndBPKaZuFvBDvzeVo6OJ/KzRcDEKZqlPbxKQyH6/Win1FbAdn+/HKpH/YQEFBQ/srVIw1g==
X-Received: by 2002:a17:903:1d1:b0:1fd:9fd8:1b2f with SMTP id d9443c01a7336-1ff57250e14mr35322045ad.8.1722574663706;
        Thu, 01 Aug 2024 21:57:43 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f52a2dsm7973495ad.65.2024.08.01.21.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 21:57:43 -0700 (PDT)
Message-ID: <d1e08364-8f87-4282-9392-31db3330eae9@gmail.com>
Date: Fri, 2 Aug 2024 12:57:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: nuvoton: add new driver for the Nuvoton MA35
 SoC USB 2.0 PHY
To: Markus Elfring <Markus.Elfring@web.de>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240801053744.807884-3-hpchen0nvt@gmail.com>
 <9cca717a-c7e9-4bf7-8cde-3a90fcfb1df5@web.de>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <9cca717a-c7e9-4bf7-8cde-3a90fcfb1df5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Markus,

Thank you for your reply.



On 2024/8/1 下午 05:50, Markus Elfring wrote:
> …
>> +++ b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
>> @@ -0,0 +1,146 @@
> …
>> +MODULE_DESCRIPTION("Nuvoton ma35d1 USB2.0 PHY driver");
>> +MODULE_AUTHOR("hpchen0nvt@gmail.com");
> …
>
> How do you think about to add a personal name to such an email address?

I'm sorry. I forgot to put my name here. I'll make it up.


> Regards,
> Markus


Best regards,

Hui-Ping Chen




Return-Path: <linux-kernel+bounces-186737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3684C8CC82B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FB2B21296
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3C14600C;
	Wed, 22 May 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6MPU2pG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FC1BF2A;
	Wed, 22 May 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413582; cv=none; b=Hd6uLMdo2Kdm0DnSTik8Vdn766QDbBKuoOTL4YoscY2hpTDDUiesoqPLr5R9pZCCsi2L72fhm6Jieg7+DJypst/1b4G57/hLwrTFsFwXXwZ+VtnhbgOknp6/WxanOYWgcx2UImzzC2n8Va18w8KO1QkJ5kJEdZrr1J4gLWfAazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413582; c=relaxed/simple;
	bh=xkrR6IPW5zCI76KHl1RFejY7rkHho3bM710x/IuE2FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFsR8I1NCFWT6ZxrbywgzCvgUj3yjgUrbp6GDu1ab0znSmAJWhoI2H1a9XQDQ4bBx2raGSnjsle5df0NKcIfMKGovV2owY5V2hONiLdQ7WfFtvPf2LLqy9OJXWPxHjb1zBnoEQULqzc7b54+vh7y+Vwyf5vNc86Rhwq5yXkHL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6MPU2pG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee12baa01cso14439255ad.0;
        Wed, 22 May 2024 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716413580; x=1717018380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oJk6+xKIyz5mK5nJJg/0/99657topvzZt0Q0FzyFr2U=;
        b=M6MPU2pGwgG1kPmfwmgzN+7djVoIuPvFR3wp91bCA83IgXpTFYXJB9VOcX4lGt07qN
         hL0g7NAXSkbTXOo30oUkkyQARye4xiZNccVK/pMy2s1XuMe/uUoVtYCz1I6cbraKxfm5
         eDoCiSbeCpTMzanQ1Cwlwsh1tYeD5+0iVvfBKptJZJtKOxyY/dHeOWSclZv5CcQkgsDy
         sGTqBK4PB3lUKELKWTzvb1ldF1F8VBXQe/13HoESHgbVUmXHM6jgg1BlCgxYRS7WSqMX
         Lkn51kmTQxPm8wCk6VCUY1iCGMNLqIBo5gAR9dLHIWnPzxUqrjJsQKLjL2d7+Fwl/XSe
         FkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716413580; x=1717018380;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJk6+xKIyz5mK5nJJg/0/99657topvzZt0Q0FzyFr2U=;
        b=Xsfr0wS2ujT64IheUCYgFCBtRwD8o8zjPGM35zoj+EVKCQ3PYlIsp17Is95nqXT9NM
         0ttAAajkQQQiQGrph8ct4BXm7EBUezdrBoyK4Ah7OEYLeyo0GtWj1weEwv0wYSFehKqF
         RvgNM+jPsgyJYSkhIRY7ZHaFCTE9WUwF35qPiffUgT8rpYzFboBjsfu63tTqlbR/rFhr
         PF079rwBbrdyOjvNYTyWVtnAj85/QNTH9cWirGxZYY1oQQBTKgyKEaR0qNUxbYtyQmml
         a+as78b2D9jcNpa84gu2wjeAgYhDbg29h0Z8JbPLZX8LecI9mc+aYxAF8nhEHfdhdWKZ
         UzSg==
X-Forwarded-Encrypted: i=1; AJvYcCVeBOVFLIU1S6IoX4bELCUADn+btJp6UIvMRcu6WiAkoBGdFJcAegvn02unXhvcFJ7MQf+fTSKSoPg07Nwbkam0SDwEdtiWDVtVT03bWI0LKd1eb3gXr0x5AEa0Q/vHP7UhAYQApC3y
X-Gm-Message-State: AOJu0YyUWGiDV3IGA08BMZxy0g7sopBGOekckHYe2kNYsYVkZ9AAziJk
	IG+dZSaCjFvMFFy/zl/2aS7QRFTcpRAvTWCZOMT3euQxJ5eOI/E3
X-Google-Smtp-Source: AGHT+IFJ9dXFDNVwoVRlfF68BKFVlcFQsJATscamH7UbEPJSYYRBXkXrmyGxq4rxXFOKnWuYDgm/+w==
X-Received: by 2002:a17:902:d58b:b0:1f2:f481:418a with SMTP id d9443c01a7336-1f31c976f14mr35597445ad.13.1716413580338;
        Wed, 22 May 2024 14:33:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d484fsm242798845ad.39.2024.05.22.14.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 14:32:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a5631f4-597f-4672-b6f1-dce9858f38f6@roeck-us.net>
Date: Wed, 22 May 2024 14:32:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org,
 Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
 sboyd@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
 <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
 <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
 <ZkfqKMqkUc/Sr7U2@shell.armlinux.org.uk>
 <646bd149-f29a-4c91-ab00-4f6d2fce23fd@roeck-us.net>
 <ZkhSOvkaAwsTe7Dm@shell.armlinux.org.uk>
 <44151fe7-1822-4b95-8981-9a1f1884d662@leemhuis.info>
 <Zk28HtN30TJvnZan@shell.armlinux.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zk28HtN30TJvnZan@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 02:34, Russell King (Oracle) wrote:
> On Wed, May 22, 2024 at 08:53:18AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hmmm. Communication problem aside, this in the end seems to be a
>> regression that is caused by a change of yours. Maybe not a major one
>> that is making a fuzz about, but still one that would be good to get
>> fixed. So who will take care of that?
> 
> I have suggested several approaches to fixing it, and each time I'm
> being ignored by Guenter, who seems to have some other agenda -
> because he seems to believe that using dev_name() when registering
> the clk with clkdev is wrong... despite the fact that clkdev uses
> dev_name().
> 

I don't have an agenda. I did not intentionally ignore anyone.
Misunderstand, maybe, but not ignore. I don't care how this is fixed.
All I intended to do was to report it. My apologies to anyone who
I managed to offend.

> What I am uncertain about is:
> 1) whether clkdev is even necessary here, or whether it is pure noise.
>     I think it's pure noise.  Why? The dev_name() that is being used#
>     to register the clk seems to be the _source_ device of the clock,
>     whereas the name given should be the _consumer_ of the clock (when
>     clk_get(dev, con_id) is called, dev is the _consumer_ device, and
>     this is the device that dev_name() is used internally with.) Thus,
>     if _that_ device is not the same as the struct device that is being
>     passed to dev_name() when registering the clk, the entry in clkdev
>     is utterly useless.
> 
> 2) why someone would think that using best_dev_name() to work around
>     this would be a good idea. One might as well pass the string
>     "hahaha" when registering the clk - because if the device name is
>     truncated, clk_get() is not going to find it. So, by registering
>     it with clkdev, we're just eating memory for no reason.
> 
> Therefore, this change is finding bugs elsewhere. Should it cause a
> boot failure? No, and I'm happy to make clkdev just warn about it.
> However, reverting the change means we're not going to find these
> issues.
> 
> Why was the change originally proposed (by Duanqiang Wen) ? The reason
> was because of this truncation causing clk_get() to fail unexpectedly.
> 
> I am all for a _sensible_ discussion over this - not one that seems to
> have an agenda about "should dev_name() be used when registering a
> clk" that seems to be Guenter's approach because _that_ is not the root
> cause of the issue and I've already explained that _that_ is not the
> issue here. Yet, Guenter insists on that.
> 

I don't know if using dev_name() is wrong or not. I don't know much
if anything about the clock subsystem. Someone else said that using
dev_name() would be a "bad idea", or at least that was my understanding.
That is all. Again, my apologies for any misunderstanding and for
getting involved beyond the initial report.

Either case, I really don't want to be involved further, and
_please_ don't make any assumptions or decisions based on anything
I may have said out of ignorance.

Thanks,
Guenter



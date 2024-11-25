Return-Path: <linux-kernel+bounces-421610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0769D8D81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F271675AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB06F06D;
	Mon, 25 Nov 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgDvR45z"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D31C1F29
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567448; cv=none; b=ODmbXotVW98D3k3WemUOhV2Ah1pEkiCHHdFSl3TojTxXSnxlQM20z2CccPDJb+S7fyMp/M+nq1UWwj/3GRGNqwZBv6cJrRgFd+apB0vhHuA6UKgpEyfiSHyokn9p81wVpMAkDXEMWHQmLF69TMiaHRC5R5Xq1jwaUaAFC6eFf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567448; c=relaxed/simple;
	bh=65PaTC/HbYF99a5Hco8G4c56d0dIVvfFhv3aGlzXe6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GH/QaGB+J4hyTgHz3N/MfnsA1qOgV5p1WUkEDj97xq22vd+10WrQzEe332/sIvYTa6OhB8lyyFRCfyKHAbFA9yA8qEbUpboa6r/ZCGA4qxiRLTlZCLdaX1NSg+fObvUVXOPAp9VzcyBDTtfSlE4FqHJepkgV9Herei6mWsAJfds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgDvR45z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3823f1ed492so3297747f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732567446; x=1733172246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1h1xtXn9O10xHO5yhfOYksISIXiohDCPtwyyzzpp7c=;
        b=JgDvR45zn0v6FfiWd/NmlSKC/1l22LWPok+RxFX/t+D4H7U7gWOnLvClKqE4Wbe0dM
         fY7Ym9xvtijOdc+6X+k8r4hmjefoDocJ8zygg9MMPtXPJuNrYTMrH7kBklBMhbyVkjiF
         FDDnuL6XGbtKD/IV8hs0TUa78jjuEeuPgAX6aEX0oz5cdvgg/c5USAKMQ+Df5UEkyAE5
         9+C6DC8XsRpoIF+RealNI8JGcVhksiYeuLjsJMnP1Sk/D0Zb6m9SvxwyfHUWTfDRGHGP
         8G53XFhEHPCHHu0MPRASFUzzOQ67HprRaVjww4vAoeRphGDPNtlz+F93n3LFmMUyeo2P
         zuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732567446; x=1733172246;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1h1xtXn9O10xHO5yhfOYksISIXiohDCPtwyyzzpp7c=;
        b=bPEuZtkQcROgtzpqSa/Nn7UrmZgFRotgEkbUHDLqw3HD7OiA4LrO13WALATlGUQrE3
         ufwoZI7RwJ8o6IGtVD9Qxdta7+tTuFH9aWymWhR1qh7gIOFPMnFjnql+3urSYtFNbhmj
         8NSqMiUObkGJaLEs12XSGxvH4LdWWT2jqxkagCV22yZJrArhxMRwP6ps/mHDZRk+Ci0h
         GqWESIVLRNFV09u31H8qVqGyrGNGkjfKRMbd4gZ2MOrBCSn/wrg28zb4XveeipjWin8m
         RLM72lfwICv8+Aj5SmKDEPtsCHQqoE1+P87o+sJ3onzXuzFLL7JTXt8jMPOS0ZqP8qUw
         4qyA==
X-Forwarded-Encrypted: i=1; AJvYcCWDd69J1s5qDmVLQyhQixnFMJeUgqZAw23w2UETvy1t82Mv5TPHGD77jrij7baK6iJRKpTRiK1oL+MPYvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVz0fnff45wihTXx2bYNDs5ufy9WUy7IOF/q3ktFcX1h+VO4v
	cgO+ABcKeVjZj5rg6z9i9HOcj3Qm21VLSe0tIkzc8vr+q/ZgrsHi8aPS270G
X-Gm-Gg: ASbGncs0l66fUGJrETL6VvUM5W68PKQ85T9kZeI3CNL25rlViS5y4oAsyS6PpIa5uTw
	yqgjyPnkwF8N0Xh7XgUmGMxaJGsltldMH6XlKGpY8yqtFYskiIh3dm+bEq1yzVqMiZ0JqjL5pOc
	fIwpBAfdm6ind3fXhx8RoqofIX26T3bwzhxWvoQFL88BDgGKbGTsOUjPfab8d3Fn9niutISlfYj
	n4i22LQULX+mBE5R1DQ3euZ9JjbipR602ch/DxUZq4vBokcIefOxSWr
X-Google-Smtp-Source: AGHT+IHssahZ5xMx0eGbMBprIparMFGBhoC0dy8hQmg3uwMTfWj3iM1TXoLQpEyUGD6jJBL4P82ZfA==
X-Received: by 2002:a5d:6c66:0:b0:382:485b:f976 with SMTP id ffacd0b85a97d-385bfaf1e19mr665293f8f.15.1732567445589;
        Mon, 25 Nov 2024 12:44:05 -0800 (PST)
Received: from [192.168.0.100] ([188.24.69.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3289sm11337185f8f.64.2024.11.25.12.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:44:05 -0800 (PST)
Message-ID: <2da70bdc-97d5-4bef-bb66-3becf40c54ec@gmail.com>
Date: Mon, 25 Nov 2024 22:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: detach regmap from dev on regmap_exit
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <20241122151631.220609-1-demonsingur@gmail.com>
 <3b35bd30-c4ca-459d-985e-d221a5cda2c8@sirena.org.uk>
From: Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
In-Reply-To: <3b35bd30-c4ca-459d-985e-d221a5cda2c8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/24 2:22 PM, Mark Brown wrote:
> On Fri, Nov 22, 2024 at 05:16:30PM +0200, Cosmin Tanislav wrote:
> 
>> +int regmap_detach_dev(struct device *dev, struct regmap *map)
>> +{
>> +	if (!dev)
>> +		return 0;
>> +
>> +	return devres_release(dev, dev_get_regmap_release,
>> +			      dev_get_regmap_match, (void *)map->name);
>> +}
>> +EXPORT_SYMBOL_GPL(regmap_detach_dev);
> 
> Why is this exported?
> 

I only did it because regmap_attach_dev() was also exported.
I can make it static for V2.

>> @@ -1445,6 +1457,7 @@ void regmap_exit(struct regmap *map)
>>   {
>>   	struct regmap_async *async;
>>   
>> +	regmap_detach_dev(map->dev, map);
>>   	regcache_exit(map);
>>   
>>   	regmap_debugfs_exit(map);
> 
> The one caller is in the same file so it can be static.



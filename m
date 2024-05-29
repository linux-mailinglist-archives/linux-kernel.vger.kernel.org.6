Return-Path: <linux-kernel+bounces-194167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE288D37CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B2B1F23075
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18221171AD;
	Wed, 29 May 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayitMtMG"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C051B810
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989791; cv=none; b=NL8t7EJXzJ3h0gfp6t9BR2uANbk9ibB137Pld4B+IV2enSeG/3Ef/9jr029xW0GKbZ6b1094ByrV//X5rf0HqdSZHJFrLUApvab3T67TJG/fzjRU3YFdpzHpowcc7vLyuV6o8c4U+6VAciolDvBicx4LZP6KcnzzU4RrznI34CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989791; c=relaxed/simple;
	bh=z/nech4YiyG1wccCfK9E60TNraeQd74bohAjLE5cmKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzFgNvRDQVtUQaEK58b8vCp4AKHguPbWcdXUqXlRFgxR/ehFxcTXyd5x9aEW4jQ1ZfVd9C5I/B/xZmV5/8RBMM31tz9B9xzgLJELA6XsJtkI7pZQLoee7iR1MCLZffSYDbMjn9SNOHEOf3isWfAoAnO9wfcEMJKu2NR2x8kFryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayitMtMG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f47eb21f0aso17949225ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716989789; x=1717594589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dicpLSmGeHTxR8brlcEnN0cI1QEPfhfEJAkQtcJYjXg=;
        b=ayitMtMGY385wcGm2LwYmG8g2VOhXcF7SN/tS3j2t7+NGdhWNkv9rC35HbyhiFtbtd
         Z2CViidvA4wuIlvv/vdtJc7YiVyeNbej3B5x/TsL5tCSnA7X0HQrxWs7B5uTs7whA8hH
         Se8yHtoqAoQNOABxP7AFoEsECnsVB1Tid0GpvC0zzVCp3fp+WAIsTPB0PwMKFrtx0Uwh
         BK8l6Wy3qEklQ+4JEaIH6AFD5lePc8AoHUIflZsWJTDhKBGwUCApozIdYcbUjseh/FwO
         /6kmN8T8qcdc+ftvZVqYDlL7eFPpVIDtnJMtUDmotQUWealzxHK3Iu+Pa+FyBnORk0WZ
         yDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989789; x=1717594589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dicpLSmGeHTxR8brlcEnN0cI1QEPfhfEJAkQtcJYjXg=;
        b=Q0+hqggE60c8YdWQsg3ALhqB/UwzLmnbCLF6qyTld4eIwPTFw09MMkVwr1ytZ7cp3i
         Xjic6mknMuMd/X/Zvze4Soy6SMkT8KGdbLVWL+ZkADzrCNr85poRrlUPByC8kKDh7I3G
         QkFWObSI/cebMp/pkMZby7LH93+GHMASnP3VZj4czQjyTbndvI6bk7vbOlACmHp+WyhL
         aAcui7y6Be7itnMeLSGDkISJ/cys0RJbjr9E7yZu9HD4FPUjgX0HQGHAwu5iJVVhTj8u
         E3yEjPhXB+Ea6LEvGaRIuWHnZggSf1V25tOlr+A9UPkVCF6xUR+wazT7fYFAWldGRyUG
         keMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5BWMU1peFhyQsy39q1ODDTJPsvyi8Z74L8uXPNgi+Iu1hSU/OesZjBP4o/2QOTW7UqXK5BYzHZ2PEW3mOhgNEp7EbBTHaRZC8ZxOi
X-Gm-Message-State: AOJu0YwvzGkD6WxOB2IYPXzF6pF92CN9EsUNWAZLW0PYvilKAXJBne+3
	UqOBk9p/Mmx7/8cOxtanhmGwrYU/qOrhX0NeJ26vSd1fDQT49VZS
X-Google-Smtp-Source: AGHT+IG2bzrds8yi4l23vZDAB9yvZEHtwj8ed98GsFY012BXS9ao17xB0hQkMahe4hP7gPU0TMZLBA==
X-Received: by 2002:a17:902:ce87:b0:1f4:8a83:a2dc with SMTP id d9443c01a7336-1f48a83a580mr95544275ad.10.1716989789220;
        Wed, 29 May 2024 06:36:29 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f5e6a0c323sm7448965ad.259.2024.05.29.06.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 06:36:28 -0700 (PDT)
Message-ID: <12ac8cc2-3117-4cb5-ab3a-2e8add3270a6@gmail.com>
Date: Wed, 29 May 2024 22:36:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/xenbus: handle potential dangling pointer issue in
 xen_pcibk_xenbus_probe
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: skhan@linuxfoundation.org, sj@kernel.org,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20240529122232.25360-1-yskelg@gmail.com>
 <0c53415d-3394-455a-a6b5-99d3efb92318@suse.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <0c53415d-3394-455a-a6b5-99d3efb92318@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/29/24 9:27 오후, Jürgen Groß wrote:
> On 29.05.24 14:22, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> If 'xen_pcibk_init_devices()' fails. This ensures that 'pdev->xdev' does
>> not point to 'xdev' when 'pdev' is freed.
>>
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> ---
>>   drivers/xen/xen-pciback/xenbus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/xen/xen-pciback/xenbus.c
>> b/drivers/xen/xen-pciback/xenbus.c
>> index b11e401f1b1e..348d6803b8c0 100644
>> --- a/drivers/xen/xen-pciback/xenbus.c
>> +++ b/drivers/xen/xen-pciback/xenbus.c
>> @@ -54,6 +54,7 @@ static struct xen_pcibk_device *alloc_pdev(struct
>> xenbus_device *xdev)
>>       INIT_WORK(&pdev->op_work, xen_pcibk_do_op);
>>         if (xen_pcibk_init_devices(pdev)) {
>> +        pdev->xdev = NULL;
>>           kfree(pdev);
>>           pdev = NULL;
>>       }
> 
> NAK.
> 
> This doesn't make any sense, as pdev is freed.
> 
> 
> Juergen

Thanks for the code review Juergen!

I don't know if it's a big deal, but I think that if pdev->xdev don't
replace it with NULL, 'struct xenbus_device *xdev' address value stays
in the kmalloc cached memory.

And most of the kernel code I've seen does this (even when it's
'free_pdev()'), so I sent a patch.

In the very unlikely event that. I was thinking if someone look at the
value without initializing the kmalloced memory, someone might see the
'xenbus_device *xdev address'.

Warm Regards,

Yunseong Kim


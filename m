Return-Path: <linux-kernel+bounces-365555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB199E451
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6231C219DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4811E766C;
	Tue, 15 Oct 2024 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIiPjHaZ"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FA1E412E;
	Tue, 15 Oct 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988875; cv=none; b=IVy5qkRDzqjIVRfnPr2xnc7z5/n1B1BsuvklYqsCdwlCg7ujw8+c8MGeM8LJ3kVhP8GfVk+2c0n0bxziYcZCudzl2SrS3Qm/C4+NVG8EpRNKJMnXy0nNaC0+2f3SOPIVWjDMpywbr2Ovqo45SK48orXX6opyt4eetkR+8PW20fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988875; c=relaxed/simple;
	bh=I0YUfGXPzMIAI9Ac3qW1d4PBH53PG9CQY+8DNL03GXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEpNK5CoSi2A5JOfODQGtvMEol90/OhHYadeT0/dTD4I+QLQF3pj0V3ntWPZHaH43zSYoib/Kiva4zB+WqLXuLj/PLKuSgED8pgNV6HH6+kRhxFPybI887jZddO4hu/6gVtHZENKAioXk0hpMvP5CkCfhsValEbxMEcSB906byw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIiPjHaZ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e29715bf0d1so339576276.1;
        Tue, 15 Oct 2024 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728988873; x=1729593673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3/WbdREEl4te5sZAp/8ssTqtRGzQbZSM2jyEGrIsWk=;
        b=RIiPjHaZT37nGwU0KBpbdUbEBhCfX2MIKdi5rVa9E1AySjp7pATSjoTHsPds+bjTZb
         NNLIK9rfAc1gydsqtVmONzJaca5HyKujrNrzasZ8fa72kFptrPZNqJ2XX/YVc8r7vCOA
         0kJXZS+4hjnCOLnkTEnJ7Y3X3gGKZ3iByrtAxJNBT5LJq0psKCOaM0vrHiRLs18xJDjh
         54s0z1MsmzS8YDg+yV0f1avwvZ92N+Vw/ZOmMNO/Lyu1xZe34MuCPvz9Rm7gQxaiUISz
         vpcZ49dSbwDpTtNvt5SLdAsQFzdC8kmbLowWMVcnDR6/ghaDrZd+0nC3xbeJZlb8fvse
         qGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988873; x=1729593673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3/WbdREEl4te5sZAp/8ssTqtRGzQbZSM2jyEGrIsWk=;
        b=JcCzQn/IRc4PT1qTv7w7z+DPYfOa9Bp5Mr3tDbvavKLJPIf4A208+6cKqOcJDUMvD9
         u7szV5ocn0rCRGpKBFYcYhL32r7bWbBXH0ckA3ZxjWptiXX51QgBDSxRNanD7liKqEyO
         Ps3jirHtwPDOKH4oP22xBuffb9vHP3NVxtXvAIsVrPS7WojTSy8NB/omlIOffBrV5ymo
         R1SBT62a2ePMGPAK5DOyCW5ubuRvkrXDV3XxR5AMRnw2b30ggHshbAWmZbXFgASFDrhZ
         hvw9/NC1iGFX7ohazOdlrV+h2mpKd8FCLqKCLIbnXB9DsiSJyB/2N0Pbrm8LQQsdajKi
         nZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVri6zhbUCWEhRtsK2rKAT970fN0fHf/whydFZ6z6hVeP2ZT4jDljt1SA+Qf1NKqmhGh0iLCRCSDrU=@vger.kernel.org, AJvYcCWIwANnaAv1/uRO1ZEAJrRVBHWZiYbpPAgBT4kj4TNlVyDq1FtJeRRxuylMfHQ6RI2GCMaK7teW72N3jYB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnrpo/HlgIzZ/kH4tZvsu7b0jh50VIHqHpRbgKBaGOZq2TUBjd
	R6SyeniREXp3Y8mKpjh0KZa5iIWYjs3p7sdPgdDXb9v9bYrvK7Z3
X-Google-Smtp-Source: AGHT+IFv6YlB+HGbl1AwY6T3tyg5V/1Q0VbI5rC4V8jwvMOecX9uYW+v0b/jmkGv+XK5XBCD/ANcww==
X-Received: by 2002:a05:6902:13cc:b0:e29:b46:7849 with SMTP id 3f1490d57ef6-e2931e00729mr8468901276.52.1728988872777;
        Tue, 15 Oct 2024 03:41:12 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfaf03sm190100276.7.2024.10.15.03.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:41:11 -0700 (PDT)
Message-ID: <b2b43b1b-2304-40bf-9506-82d3cd8d88c5@gmail.com>
Date: Tue, 15 Oct 2024 18:41:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
To: Yanteng Si <si.yanteng@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
 jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
References: <20241012171357153parWX6Has5WheQyGlP0kP@zte.com.cn>
 <ecdc7672-965a-4bc5-8e0a-a407de82407f@gmail.com>
 <87ed4isd7b.fsf@trenco.lwn.net>
 <22fde7ff-457b-4b69-b548-69cff915569d@linux.dev>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <22fde7ff-457b-4b69-b548-69cff915569d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/15/24 11:29, Yanteng Si wrote:
> 
> 
> 
> 在 2024/10/15 03:21, Jonathan Corbet 写道:
>> Alex Shi <seakeel@gmail.com> writes:
>>
>>> Hi Jiang,
>>>
>>> Your patch format is still odd in 'Subject':
>>> Subject: =?UTF-8?B?wqBbUEFUQ0ggdjVdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBwaHlzaWNhbF9tZW1vcnkucnN0IHRvIFNpbXBsaWZpZWTCoENoaW5lc2U=?=
>>> Content-Type: text/plain;
>>>          charset="UTF-8"
>>> X-MAIL:mse-fl2.zte.com.cn 49C9DsLB077233
>>> X-Fangmail-Anti-Spam-Filtered: true
>>> X-Fangmail-MID-QID: 670A3DD9.001/4XQd8n4BCPz5B1DK
>>>
>>> It should a English word.
>>> You need to send patch to yourself and apply it to check if
>>> everything all right.
>> I think the formatting is OK - the patch applies fine here.  I would
>> appreciate a review of the actual content, though...:)
> <https://lore.kernel.org/linux-doc/1add7be9-0da0-4463-a3ea-80e2fd99bd19@gmail.com/>
> From the very beginning, we have reviewed the content. Moving forward,
> we will continue with the review process, but we would really appreciate
> receiving feedback from the translator, even if it's just a simple "OK".
> 
> Alex, I believe we need to draft a Chinese translation guide, in order to
> minimize the review work that is unrelated to the content itself.

Yes, that's right. A few more request could make things easier. 

> 
> Thanks,
> Yanteng
> 
>>
>> Thanks,
>>
>> jon
>>
> 


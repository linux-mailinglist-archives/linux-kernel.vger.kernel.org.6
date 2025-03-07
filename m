Return-Path: <linux-kernel+bounces-551013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE0A566EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD36C1897AED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B02217718;
	Fri,  7 Mar 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDh0OMzU"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796C20764E;
	Fri,  7 Mar 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347637; cv=none; b=X2We93V53x15U9RWL9JXuy33wL2+oRSAJMyRFOdVgBV0i/2x9aqdC2iaoOdAbiGo/JAF04g+atxn3FhTuzIjMXkXkE3C+5FJOF5Eicdle4E8lBGpyajT5SAXheviQmcQL/5ig9XAl2edEkYA7twG7bTzpRv842HcuCs7OFoS2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347637; c=relaxed/simple;
	bh=I9Ix3U0W41expU7X/Dm9VIv651I61ZHx/8rqhJrlFys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CG4I62PTEUcnOKbPQCbj8sZhv0xM2s4Y/iUC59Cws0We1BpatuiExVS/FOddSMye/GLF7OkIdAfQZOSGTj8dfFYaLpmeG5V3TRcNagL49vyV7xz6YM3m4BgSBIe/+0dtIqC5RQOUQwndNHkyS8sRtuZmxQFebSDgEaI0/YZkOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDh0OMzU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2241053582dso2690655ad.1;
        Fri, 07 Mar 2025 03:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741347635; x=1741952435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8UqIfgpaGc5zJjDWkkoCZZvtajjxdMIfBLrEowvjIPg=;
        b=PDh0OMzUHRFNyp9exWivwI/VjjxXiO0HueliZEknNojBMteEvXULqh6BpMyCP81Bvu
         1GbyN9hY+XqYPPCxS+eUApc8wgw9cuTHo7MGe4IMtGCwH3v4M5gi7L30wuS2H5xoRDqS
         +PwpZ6VTKs0RYIdk7haFdayh2x2LUSjLv8sUCbnI8YGVdDzh8LInyISkZIv9ch6R79Th
         50+J9W9wJaW3f2/oGMjh+BPwqtaeAxycsXGZvJUZ4HmmV7lwdqpTS/DGvJYGii4DtGWF
         wtFPQZxGOeZw0Q4sfBWQ64LQoKUN6zIJsBtYAQZIJnds2y7Woqui7p9BxXa70cjllTky
         43Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347635; x=1741952435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UqIfgpaGc5zJjDWkkoCZZvtajjxdMIfBLrEowvjIPg=;
        b=ciTNY2JCavnT2LjaRtGGZ+ojEhgAugXKtf5r09A4tAb3h4FNCOCqHErbptQrHAdKAt
         1XeOWnfPsHTlmvST84kuAX7ExqY1x3a/LJspMF6Yug+jiKMiuq1dnzsOWp8v53dzbDCz
         8zOfWF1SPlsAmweUB+iQa8K3cgOQK7bayfMDvUsQ4nkHvvHq5WXdQOW/C15ZgEBimNFj
         McdGtwaR/Mi8ou0UZaX7Mms6/6TBqEECcfMb57NaFfRfNafiLuoI+qTAZfDwCtdyKozw
         jY9JBNzuopupyoLvpUSUUnWyWRyd3+so+JvguzrCioTuxrFvaeGf0oalsi2sjZVT0uIo
         dWeA==
X-Forwarded-Encrypted: i=1; AJvYcCV5hO4w+smaRgAYU5ueRfndbQIfHu2rRyk9yyGP9+X1lwznC3uyCYGxwQ6EL3ApoUz8IT5XNMVhZBz/GevX@vger.kernel.org, AJvYcCXXGHlM05A60V4Xcgvf9ba2Btmc4lCLje7Yg8iUF2QSOic8lvxlwmvfQxKXa4bo4OSIDgCcLQJ1BWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM030USy3Hwe/ZTL45krCycs/yxu3DoXKi37dEZWKtlNkvj9vl
	h+bgRlmmhh2r1abXLITzsZtkXtHgFMPshp1spYp0gyYOAdzBr4Aj
X-Gm-Gg: ASbGncuokfQnRTpVsNA7worWKYKoZ6U9TKJM+A4ElIHo9zN7jjtmgStJH3otUJ3ONsE
	sCM0MqP1D1MRLmLIJ1aaJZ04e5wAOeEtxvYpomPEn6NV9uFFFmE2281PCk83WJPOLtEK4yeMnc1
	Rqzt6if0WIaGJNIQtQ0cllzCpPcInfcqf1i4FX7Dj23osUKUvIt7oQkgUNSkHVu4oAijScCCvwi
	/7MqQjlci3ca2uw0t1iIb7Y8uZO0UwxCjxO6tTmXEZB1yNpINocN+gtUq+u+kfJZZTj8K6nSwFg
	l3kudU6ZVsTxHXxBjTWKzr/7aC+lDImhVfEBz5z/nR2dBDBjKTtdkpRcdMHyu+6F3ei6fhfu8Ua
	47RfTZ5PTf7ie0+M=
X-Google-Smtp-Source: AGHT+IHAQFCRCwe2R0RBVbabIC9mKCCEvLPEC7/LRCTgcq+4UsG7X8fmuRaJ2R6NSsPISjXf/BTVgg==
X-Received: by 2002:a17:902:ce0a:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-224289945b0mr52457245ad.26.1741347635027;
        Fri, 07 Mar 2025 03:40:35 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8b6sm27893455ad.136.2025.03.07.03.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:40:34 -0800 (PST)
Message-ID: <f4ee5a3b-8d1e-4d6a-bafa-c8d4d376f388@gmail.com>
Date: Fri, 7 Mar 2025 20:20:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Yury Norov <yury.norov@gmail.com>, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <e3637b13-1f51-445b-8d9d-bd53a691eca3@gmail.com>
 <20250307112812.3la74kiomyqbzhk5@vireshk-i7>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250307112812.3la74kiomyqbzhk5@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Viresh Kumar wrote:
> On 07-03-25, 19:57, Akira Yokosawa wrote:
>> Didn't come up in your diff, but you need additional changes shown below:
>>
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index 656d2208467e..a6c1961cc535 100644
>> --- a/include/linux/cpumask.h
>> +++ b/include/linux/cpumask.h
>> @@ -285,10 +285,10 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>>  }
>>  
>>  /**
>> - * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
>> - *                        @n+1. If nothing found, wrap around and start from
>> + * cpumask_next_and_wrap - get the next cpu in *@src1p & *@src2p, starting from
>> + *                        @n+ 1. If nothing found, wrap around and start from
>>   *                        the beginning
>> - * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
>> + * @n: the cpu prior to the place to search (i.e. search starts from @n +1)
>>   * @src1p: the first cpumask pointer
>>   * @src2p: the second cpumask pointer
>>   *
>> @@ -306,9 +306,9 @@ unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
>>  }
>>  
>>  /**
>> - * cpumask_next_wrap - get the next cpu in *src, starting from @n+1. If nothing
>> + * cpumask_next_wrap - get the next cpu in *@src, starting from @n +1. If nothing
>>   *                    found, wrap around and start from the beginning
>> - * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
>> + * @n: the cpu prior to the place to search (i.e. search starts from @n +1)
>>   * @src: cpumask pointer
>>   *
>>   * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src is empty.
> 
> How did you find these ? I only looked for build warnings / errors earlier (with
> make htmldocs).   Anything else I should be doing to find these issues ?

Well, you need to see the rendered html pages in your browser. :-)

Or, look into the rst output from
   "scripts/kernel-doc -rst <file with kernel-doc comments>",
and see if it makes sense as reStructuredText.

It seems to me there are very few people actually do it ...

But I fat-fingered in the above diff.

>> @@ -285,10 +285,10 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>>  }
>>  
>>  /**
>> - * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
>> - *                        @n+1. If nothing found, wrap around and start from
>> + * cpumask_next_and_wrap - get the next cpu in *@src1p & *@src2p, starting from
>> + *                        @n+ 1. If nothing found, wrap around and start from
        Obviously, should be  @n +1.

>>   *                        the beginning

> 
> Thanks for your help Akira.
>

You are welcome.



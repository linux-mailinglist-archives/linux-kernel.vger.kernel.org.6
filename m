Return-Path: <linux-kernel+bounces-267366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090B9410B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C9028670A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C519E7C7;
	Tue, 30 Jul 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6gb7aG5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5312DD88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339527; cv=none; b=ogr4Ruh2fg+ucb9ONe7X3fnmCxTdCLjNR+n0Cy1bKle0gVXBuDUssDev7WpfHV642vk2/1zzulMmm6F5lh/vU0NruH7102RCJ/bH6/LjfZ1YC53c9xOZkb1cTKudM7voc6SdgZfNGaKRdSMzuwfnO1OeoBnRRHe5b3H6wGsn2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339527; c=relaxed/simple;
	bh=gMX/uY3P00RuMEhik2gboHQR3I6sJ6AQz4rzZO6AJn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIne9qMv1dKbL5WR4wOcrj65X78ZAqlKNr9SiaQL/3ngec2iGPRocZno+HXhwTj5nvlwgFoE7IY12ftoBZLTKKwyZmLDsrXQi9m3VE4AcklRRSImnLcRW1fOddeGscS+A53ycxO9EAE2dVV7My7JDvhHkGnOytX5He85qq2kG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6gb7aG5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc56fd4de1so26326755ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722339525; x=1722944325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MFqGZ8807+PNXQ8BnyhmtNVvHRUHtuiqEf4+LLnxW4=;
        b=Q6gb7aG5mKK/nHrD6dj176JtynQbc72PQJo0nRbAmYz0lo7NHFlDBiFpYd1b1lZcD+
         A2vykQu1BV60qlrhC6DQbx2COooSiqYcB3TxtTduhlzJC89UlZ6C19wWRjkvI4gpKomj
         bqYldhHtMCUyhOcpMCsxWAVS54Cy64k5nkV41jKSJQpb+zzbfRtJZ1JOmugF/8V+YxHw
         N4QmxHkKtQMLBk9aBRgJRFUgQ0jOvRW9ZrDwgCZxI0fxqGgX+UOZzA9t3CRjKJaGLzPt
         GkmsCkOrjyUI+cUiA86X5r2eKJfK2Bb5IQFoypPOOgWNVrGxG2VWtR22jrwo6vCK320s
         CMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339525; x=1722944325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MFqGZ8807+PNXQ8BnyhmtNVvHRUHtuiqEf4+LLnxW4=;
        b=MQdWR5FtmCwc02XnlNZhuM4OLhnO636QVK36IRco9TsZBuuP+bqBgqsIsVK6jnCjlL
         LlgtS7/vugKxQwux/LiwFKk/HTCEwGCjKYaUseWcVROQcash3UVrRpCsRr+5ledAdXUQ
         bgLUZwX+ovDOYYtjEvU6Jah0qNHsIUVi0SK89m9FB8QOxq6uvXx5dUAC16uTFiTi+wDr
         r/hLYTzEGQkglmSDYjXcnpFEO5YiCOcPya7oD13KWag674WmT0YIy3XwgNaUFXYdQRyd
         1e5Qw8mW1qvILdnhlDiVOTuD8sWBMhrNLLmCY2h+RG6BBxNdSPCQy4DGfJ2LO/8Rb487
         UWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+HcZKqP7l+YG0K3LIJSp+aDCKvoiuNI4BRO3/mGd5laJnycOB8VKGcUpvtSMN+mjSnJy/aSfCOt50JCtk4bMq+A/Gbj0+ot2/eCsv
X-Gm-Message-State: AOJu0YwGaXA7oRXvXe5STGpXNYIwk4H6905gvNAfnR95hBoUn3/BTkip
	ssZgZ8gxcF68VgxbF3XEIPaNOI1mWOOWtPMoxjAD9V90rcW8hKo/
X-Google-Smtp-Source: AGHT+IEBBOHnFCkjS4erYNgJjiprwps8xwQLgMn5LY7rnBhZttmUOgpWuMTyJ9yoYQq+SzqmMUcUrQ==
X-Received: by 2002:a17:902:e850:b0:1fb:4f57:6a65 with SMTP id d9443c01a7336-1ff37c3167fmr25480215ad.30.1722339525125;
        Tue, 30 Jul 2024 04:38:45 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1ac12sm99336475ad.186.2024.07.30.04.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:38:44 -0700 (PDT)
Message-ID: <5ed6a7fa-31e0-4516-8cbf-8a725377aa32@gmail.com>
Date: Tue, 30 Jul 2024 19:38:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/22] mm/zsmalloc: introduce __zpdesc_clear_movable
To: Sergey Senozhatsky <senozhatsky@chromium.org>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-19-alexs@kernel.org>
 <20240730093419.GA16599@google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240730093419.GA16599@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 5:34 PM, Sergey Senozhatsky wrote:
> On (24/07/29 19:25), alexs@kernel.org wrote:
> [..]
>> +static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
>> +{
>> +	__ClearPageMovable(zpdesc_page(zpdesc));
>> +}
> 
> [..]
> 
>> @@ -846,7 +846,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
>>  {
>>  	struct page *page = zpdesc_page(zpdesc);
>>  
>> -	__ClearPageMovable(page);
>> +	__zpdesc_clear_movable(zpdesc);
>>  	ClearPagePrivate(page);
> 
> Just a quick question, I see that you wrote wrappers for pretty
> much everything, including SetPagePrivate(), but not for
> ClearPagePrivate()?

Hi Sergey,

Thanks for comment!
Yes, it's better to have one for clear, I'll sent a patch soon.

Alex


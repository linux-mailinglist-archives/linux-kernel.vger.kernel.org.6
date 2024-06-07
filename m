Return-Path: <linux-kernel+bounces-205843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16AC900119
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2000DB22285
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA8C15ECE0;
	Fri,  7 Jun 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2RRvYNI"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA1158214
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756844; cv=none; b=jfXV8diGCZ8EmnULwOg2NUEAtQfaPNcK+1F8Z3g4J387R0uNabGyI2OlQbNKRhlKVSzOvJ9P8h/MQqoNR7LEmXI8KSWwyNCfR2SW8zhhq/nSsXHYYzjQksNl3Nv1seZkIGw+lGm6PZ99eABS5Ryrusc8WE+NQX0k9YvDCxO3yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756844; c=relaxed/simple;
	bh=eAWRovgC+VzdKEpU+1G33Mn91o9lCr3uIPYDWufULu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se94DUaUVKvywmJLxd8h8A7c0vUK/SEWT5KXKSLI+APudjWYF9yNvZA2TBt5Lh1ULm5SjWwR/P7tmuLPY8XHBmvNebRFB/NS1ntub+Py/YS5WYrBtYk9XFEco1BDSLsKxhvi5D2ia5SGGx2YTpPEYGkdL142vXxNT6K3Lr6lFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2RRvYNI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso2198299a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717756841; x=1718361641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4jK93kf7r9hryn5ss3PeYfJYkjhZA2vuicyJegK6VI=;
        b=P2RRvYNIJsoaNHXXPTJOpPXlAndHxlHCW648p7U+lOffaabx1PaOHZcDeMS7XxWQXl
         BXCjl8dLLkMmagPvyfnpjgwspDL+O7vgL5P0ZoiORj53xrVR4GAGxFimA2aJNIfwcwqI
         P4NQVP8xk98n8c0ML5rIXaIUCDqMeBIvl1BiVdsleaxsWyuuumR2PX70HaFDfB4woXdE
         JL0zsXIxoCjnNBAGdZeroGwNCjrii+WCbR6j1fADsRQRGiy/SdUSsflbxpPOFNs3TsYY
         VZy+YNB3AHsFY6Go5IxalLnlsnY3hJQyzrPsV3AufYv/kU9/sTYJJiXTFgiuij6e+7fd
         rKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756841; x=1718361641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4jK93kf7r9hryn5ss3PeYfJYkjhZA2vuicyJegK6VI=;
        b=rlHc4COeLQnMiyRfVL87OVHXgAW9nRgEJpFXJtOQUFqjr88MWc9bEwnI3fproNqPWs
         zMJTvQRMQykRD0GhXEnZS+W+UlLczm/WEIiueR9c6+41AYU4wiWobxWIjtMI6x7h8Wqu
         CebNV1GJlO+J5+tVcJrZca9VpIEnru259trLL95aB1Eg3QCOxUIXFyoExMMd2o+W0FeT
         e7CKg2xPB+qd0ESxFQsl1UdjPdI//8fMSZ0xvvA6IS6aLZ3qmrV2Bcm2uNXVEN80vGCD
         3PxTy2rLpx7RvK/15w0htJj+4nAeQodGCa/17+LqB2DKH1s3X++XDkXO6h4O7adydvNT
         Leww==
X-Forwarded-Encrypted: i=1; AJvYcCU1bm7QyTzOlHiR9td7OVhcsBWR4tUE1Cc5I/ra9HA2whMjXkDP6Cgox4cOtFL5kQdNQqJlvLj+qGZjx1tlNDemjhdooB+8K7hlq1/j
X-Gm-Message-State: AOJu0YzHbFvtYWvtwxougUS8SNaIRGTy18dxnJ3n1qOyzu8UuuNtHVPF
	FW0R3oFMrT8L6nSRJNAqXuvDHdGX+ThvUhBFBhjidpMRPJ8qlh9S
X-Google-Smtp-Source: AGHT+IGbojGw0dNMmhCKeu+pjC1rlkUV0eLTpHGyjYEpDdn3YpUEO7RRTrVPBAz0VGFBs+D9DgXctg==
X-Received: by 2002:a50:8aca:0:b0:57a:27e8:deb with SMTP id 4fb4d7f45d1cf-57c4dee2ccamr2206942a12.12.1717756840503;
        Fri, 07 Jun 2024 03:40:40 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:fe7a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2542658a12.90.2024.06.07.03.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 03:40:40 -0700 (PDT)
Message-ID: <e695bf8e-9745-41ba-9986-fc888df71d3f@gmail.com>
Date: Fri, 7 Jun 2024 11:40:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
To: Shakeel Butt <shakeel.butt@linux.dev>, yosryahmed@google.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
 <20240604105950.1134192-2-usamaarif642@gmail.com>
 <nes73bwc5p6yhwt5tw3upxcqrn5kenn6lvqb6exrf4yppmz6jx@ywhuevpkxlvh>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <nes73bwc5p6yhwt5tw3upxcqrn5kenn6lvqb6exrf4yppmz6jx@ywhuevpkxlvh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/06/2024 09:55, Shakeel Butt wrote:
> On Tue, Jun 04, 2024 at 11:58:24AM GMT, Usama Arif wrote:
> [...]
>>   
>> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
>> +{
>> +	unsigned long *data;
>> +	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
>> +	bool ret = false;
>> +
>> +	data = kmap_local_folio(folio, i * PAGE_SIZE);
>> +
>> +	if (data[last_pos])
>> +		goto out;
>> +
> Use memchr_inv() instead of the following.

I had done some benchmarking before sending v1 and this version is 35% 
faster than using memchr_inv(). Its likely because this does long 
comparison, while memchr_inv does a byte comparison using check_bytes8 
[1]. I will stick with the current version for my next revision. I have 
added the kernel module I used for benchmarking below:

[308797.975269] Time taken for orig: 2850 ms
[308801.911439] Time taken for memchr_inv: 3936 ms

[1] https://elixir.bootlin.com/linux/v6.9.3/source/lib/string.c#L800


#include <linux/time.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/string.h>

#define ITERATIONS 10000000
static int is_page_zero_filled(void *ptr, unsigned long *value)
{
     unsigned long *page;
     unsigned long val;
     unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;

     page = (unsigned long *)ptr;
     val = page[0];

     if (page[last_pos] != 0)
         return 0;

     for (pos = 1; pos < last_pos; pos++) {
         if (page[pos] != 0)
             return 0;
     }

     *value = val;

     return 1;
}

static int is_page_zero_filled_memchr_inv(void *ptr, unsigned long *value)
{
     unsigned long *page;
     unsigned long val;
     unsigned long *ret;
     page = (unsigned long *)ptr;

     val = page[0];
     *value = val;

     ret = memchr_inv(ptr, 0, PAGE_SIZE);

     return ret == NULL ? 1: 0;
}

static int __init zsmalloc_test_init(void)
{
     unsigned long *src;
     unsigned long value;
     ktime_t start_time, end_time;
     volatile int res = 0;
     unsigned long milliseconds;

     src = kmalloc(PAGE_SIZE, GFP_KERNEL);
     if (!src)
         return -ENOMEM;

     for (unsigned int pos = 0; pos <= PAGE_SIZE / sizeof(*src) - 1; 
pos++) {
         src[pos] = 0x0;
     }

     start_time = ktime_get();
     for (int i = 0; i < ITERATIONS; i++)
         res = is_page_zero_filled(src, &value);
     end_time = ktime_get();
     milliseconds = ktime_ms_delta(end_time, start_time);
     // printk(KERN_INFO "Result: %d, Value: %lu\n", res, value);
     printk(KERN_INFO "Time taken for orig: %lu ms\n", milliseconds);

     start_time = ktime_get();
     for (int i = 0; i < ITERATIONS; i++)
         res = is_page_zero_filled_memchr_inv(src, &value);
     end_time = ktime_get();
     milliseconds = ktime_ms_delta(end_time, start_time);
     // printk(KERN_INFO "Result: %d, Value: %lu\n", res, value);
     printk(KERN_INFO "Time taken for memchr_inv: %lu ms\n", milliseconds);

     kfree(src);
     // Dont insmod so that you can re-run
     return -1;
}

module_init(zsmalloc_test_init);
MODULE_LICENSE("GPL");



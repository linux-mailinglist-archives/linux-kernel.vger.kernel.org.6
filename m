Return-Path: <linux-kernel+bounces-244065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0725929EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182451C217EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CAD4D8B7;
	Mon,  8 Jul 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N2qEmVWR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA82EAF9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429502; cv=none; b=QkFWIzyK7Lv6/fW0JONLVSvf5rjITkFJHHaLQ/T8UGSh6IZV/r8Y1D2I9PC8nvcJZpyLXEdIkb7ApR06D17GS7axT/YQMnm7XvYvBmtNBUpfbunabGAIiJC5uKJhDvQhdCAJbpoo4vezdk5WM5jIUaKX9fbVy4YOYrJC4ZYcf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429502; c=relaxed/simple;
	bh=XMF2MqDns5pCwE8CcsNuQXiO25HOfipCVkWhVX+41Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7po3NNDOtdpF6V3UhDJZBZGfdgaNpAA8XDOPuR1dRD/V9NqD9coiuVJGRKK5tG0qZwofncLNPRKi+FH1Rbn9OQs0uZZsuFA8XipPpH2R/VOD33u+ywb4bRVmu88vdGOAG+EJQ3PFlupaM8+HkpofGCBEFutvi5FszOSw/5cHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N2qEmVWR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77e392f59fso174563066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720429497; x=1721034297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLguUnqOILj2nltoMSMd+O56+i+Df9CclOmYvB+j5Mk=;
        b=N2qEmVWRa/O01O195gtQXeqZRs4SRgaDPcUKHHDphEc6YiJzVbbaP0eNYT4wNB8Te5
         M2LmsfWKcExG1exTEYMPL4uWBWIaZmZOGiF2GXy3L/3GjD9wIp4GKXOJ4BI1oUjH8rQf
         Qx0yK9K++UieXKD75LFl1Rz1yvDxZS90xfR8ZzyF2T8MZsaLCvihufYaT43s7hDc6IfI
         uU3el560Yq57B6zBeJoIC428+UtO3LlA4oDU7M5cFAlWlxAId19dxfgPdk2UaQpOYeCh
         HB0fRwdXTyVRm/m44SoVK8rgmx0wBKie4AqmPDYpDua70CqQ4QWun53Ue/DS6KasOxD2
         hpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720429497; x=1721034297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLguUnqOILj2nltoMSMd+O56+i+Df9CclOmYvB+j5Mk=;
        b=kf0F8HRX0wm0GVN03aXc0411ZR4KJLSxArLhwIaJIROy2U19LIUvPIxnWCZzRTIefs
         N/+4DAonM6JTES0DYFd7uLCjhgZvHJCZblKqUHsWe6bkDoVgYf+cfZH9id7LS8tqqEdJ
         1s7a1QHgqu6J1vFPuA6btS/G7ffZfYnBpMqREymhsgNN00eqgLSV3HwTbJSwn0kh+Vkj
         qShtY594VWmy8zh1tboDvj5UtkSTX+dU0gufB6A8GI0fZzHunE/UaruhuOf1RNmLJlPc
         0kFnKpYocW0mc+siqL6us5fnl+Q2CCOE/pTYVzijELRmyTyhMgp0OEyeDl3GxVrGY/59
         NWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVL6cfzptaQtx0Fh/8BDzKKIj+4w4J6eOBQzYO5WEybfjqH99YsxEm4n0FjcfwqyJABQLOCKOSIp1iwxXRNjHZr2vQNUPCgrRu8vBH
X-Gm-Message-State: AOJu0Ywu8nSdojf+kV9jJ91zWs1XQvPfRanPEPpSE6RTH7q1FQ1SK27b
	z7jkAVwXktxljxVSsSo39vD4xQ1Xo55iC4DhKrN2NoPpxG0jHnuuxOo74BSahP0=
X-Google-Smtp-Source: AGHT+IEfKmbjb7PP9nIF3X70+mcGNp57v/tF5rZEvNSyggSxpN3frMu/fbTIhNoinwcH4OyrIkBJcw==
X-Received: by 2002:a17:907:118e:b0:a72:7c0d:8fdc with SMTP id a640c23a62f3a-a77ba45525dmr798422866b.14.1720429496940;
        Mon, 08 Jul 2024 02:04:56 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065208sm911918466b.118.2024.07.08.02.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 02:04:56 -0700 (PDT)
Message-ID: <2d9ffe19-1663-499c-9699-c13ab7a341ee@suse.com>
Date: Mon, 8 Jul 2024 11:04:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: make multicall debug boot time selectable
To: boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org
References: <20240703115620.25772-1-jgross@suse.com>
 <d28f8da5-7903-41c8-9213-4e24e376c837@oracle.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <d28f8da5-7903-41c8-9213-4e24e376c837@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.07.24 00:36, boris.ostrovsky@oracle.com wrote:
> 
> 
> On 7/3/24 7:56 AM, Juergen Gross wrote:
> 
>>   #define MC_BATCH    32
>> -#define MC_DEBUG    0
>> -
>>   #define MC_ARGS        (MC_BATCH * 16)
>>   struct mc_buffer {
>>       unsigned mcidx, argidx, cbidx;
>>       struct multicall_entry entries[MC_BATCH];
>> -#if MC_DEBUG
>> -    struct multicall_entry debug[MC_BATCH];
>> -    void *caller[MC_BATCH];
>> -#endif
>>       unsigned char args[MC_ARGS];
>>       struct callback {
>>           void (*fn)(void *);
>> @@ -50,13 +46,84 @@ struct mc_buffer {
>>       } callbacks[MC_BATCH];
>>   };
>> +struct mc_debug_data {
>> +    struct multicall_entry debug[MC_BATCH];
> 
> 'entries'? It's a mc_debug_data's copy of mc_buffer's entries.

Yes, this is better.

> Also, would it be better to keep these fields as a struct of scalars and instead 
> have the percpu array of this struct? Otherwise there is a whole bunch of 
> [MC_BATCH] arrays, all of them really indexed by the same value. (And while at 
> it, there is no reason to have callbacks[MC_BATCH] sized like that -- it has 
> nothing to do with batch size and can probably be made smaller)

As today the mc_buffer's entries are copied via a single memcpy(), there
are 3 options:

- make mc_debug_data a percpu pointer to a single array, requiring to
   copy the mc_buffer's entries in a loop

- let struct mc_debug_data contain two arrays (entries[] and struct foo {}[],
   with struct foo containing the other pointers/values)

- keep the layout as in my patch

Regarding the callbacks: I think the max number of callbacks is indeed MC_BATCH,
as for each batch member one callback might be requested. So I'd rather keep it
the way it is today.

>> +    void *caller[MC_BATCH];
>> +    size_t argsz[MC_BATCH];
>> +};
>> +
>>   static DEFINE_PER_CPU(struct mc_buffer, mc_buffer);
>> +static struct mc_debug_data __percpu *mc_debug_data;
>> +static struct mc_debug_data mc_debug_data_early __initdata;
> 
> How about (I think this should work):
> 
> static struct mc_debug_data __percpu *mc_debug_data __refdata = 
> &mc_debug_data_early;
> 
> Then you won't need get_mc_debug_ptr().

I like this idea.


Juergen


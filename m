Return-Path: <linux-kernel+bounces-547640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BEA50BE2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057DE7A36A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF42254AEC;
	Wed,  5 Mar 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWpAMt79"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB464252905
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204081; cv=none; b=fWU+jXzy3RUYmuTL9Z1giTUTvnO0alLWRZ6TXjRFv/Yr2i2U5UTplTdoumO2aCxdT9sJJlyCc9eRkFLodbQIJWtiEs7AAz2cXmBd5VVUZlvbW+XmnMnoCnehYBK5NL/Q/rHF8kZD+TMhUcgiLALwkek6xHbiwQeeB/MyXusivQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204081; c=relaxed/simple;
	bh=ed8V+8VoqbYkOfA9sgscCYNEqRJYIs3LL9AnbgoNAO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tD9c199EK07SE7JMpwlkBSoZZ+O2X8e/b2dVt0K78Ke3CIhLwjlkhn7RvJ6Zta8Q9G+s3LVesvc44ehoKIuPpRdr+qID+/XsPo3RUkob/ZbeQvTI1am4+OseDKDxAk2R5b5C3XNVjuZk9Nv+K2juF4NPI2XhMKkftt+zY5YQIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWpAMt79; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741204077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eGWydqnoXIhCLQqdot4fyHdmsRNksb4I77lqc7a9rY0=;
	b=aWpAMt79QwcI9lJ0/9umS0vWKp/aZEm84/ZnYXg0PYyE3wf2HxhCHXtzjihjcQNLZIh623
	iORu8MbPkQe2EPnMj2g/Ey4EhzLa9M1c9VVqOXxd6tCbN5bmTq0LXM/th0ycKbS39s8HIX
	tlgK+0aRkIuDAu5eAZGWFN/cIL96D5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-gBq9hXJfOiyD2LR2kpsGew-1; Wed, 05 Mar 2025 14:47:56 -0500
X-MC-Unique: gBq9hXJfOiyD2LR2kpsGew-1
X-Mimecast-MFC-AGG-ID: gBq9hXJfOiyD2LR2kpsGew_1741204075
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so12601875e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204075; x=1741808875;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eGWydqnoXIhCLQqdot4fyHdmsRNksb4I77lqc7a9rY0=;
        b=gtRgG5a6/07WZywlhVK3fVZ7kAS/p55dGXOZYOA/O3uZpeCNm3pFfwKxuXmQZ3cV6B
         WL3tUMDhHfkCNAM/iIWwrZ2kYcZSqM9EFLPIih3G5muv5SzZOn8EhE8LAkoM8g1mYHU+
         Wmjlx6QvoEn6Myw/ijC2DOu+nMS8i4nFbGNVL1HlXCvdwN8EXJU6R0PzPvNBJwp4Qgg1
         /rHEgSDdWKmH+SX0NoQqdyFP7sll1GXv4wszUgC5gmC4Sg3f17haI+Zw+1OfgcegAffV
         3u8H/m6jXzE6ikaCE/WoRMWe3TLD0IZjmSMbNSNk1CHuwVxS9aOQV7elH6KH7a/Hh1GI
         1otQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZOCcUCKO0lczqQp/l/iwPAR91LQjYLNB90dnNWdIpt7qZOUmEOyRwMWrwGwDZiPdIfWDNYagfa/9jBSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/z3fRvliy0caumFBZsKwvOc8h4m6M+g9bbZo6mjReC6I+/B2B
	mi1pNK7PCvNLGZyrPAjKDdRjgVJMNtMYAUAM9AIbvogJuz0pJ/KmJzi6MT93zgepqh1erLuHaee
	UCA8oLdN9CU4Yb4/t7cYA47fgUcN+VRTa12te5SC7208C5zaT4nZ7O7AhhLMILsKHD4uWHGs9
X-Gm-Gg: ASbGnct+PWsZf5bIv2acyybYYeBiBz2u0w0I4JlI0CI6a08/70NCUqkUtrUvPOR+YMu
	9Hi403BwF7lOrjoWq1f72GG9QsBLP9tC5CJVZ5qxEeg0GFMc1cjoJ76eoI4zYJHwgk4zrKewS7Q
	iRrCROSwACmXhUQloYBap12tVJPx7MlV65MnKLf1VYtccGCjViQs1NMyvkfwBhxfVkhoRadsU+F
	e+o6WiRlj2tsWVoLCXBm4a2xctjV5HmTLoYI9YiCek1XpGE5OGgeita4CV2Sjx9QxKFz6GOiTHT
	OwpFtYNm0PBWCCrsAs1tOA/oOEfBIgMH1o0wUi3ig0ggawCeKjVq76M1gsbrSgnzf3hAbLalhXj
	dpq+gWe81R5vw6z/K09kfN+PfRHZw3+MCDKPGeJuG2LQ=
X-Received: by 2002:a7b:ca48:0:b0:43b:d6ec:3d57 with SMTP id 5b1f17b1804b1-43bd6ec3de3mr31096935e9.15.1741204075052;
        Wed, 05 Mar 2025 11:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0XZGZCIlmOlRS0LbFcH+/JVJl+ID+X2yGng1e5xV1yy07EP7WWTcYimXXucuhZJRVuD//ew==
X-Received: by 2002:a7b:ca48:0:b0:43b:d6ec:3d57 with SMTP id 5b1f17b1804b1-43bd6ec3de3mr31096645e9.15.1741204074608;
        Wed, 05 Mar 2025 11:47:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:5b00:84f2:50f3:bdc8:d500? (p200300cbc7395b0084f250f3bdc8d500.dip0.t-ipconnect.de. [2003:cb:c739:5b00:84f2:50f3:bdc8:d500])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426d34csm27332645e9.5.2025.03.05.11.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:47:54 -0800 (PST)
Message-ID: <62f93f79-a8d4-44a5-b276-3ac5af4ab25c@redhat.com>
Date: Wed, 5 Mar 2025 20:47:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 0/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Tong Tiangen <tongtiangen@huawei.com>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250305152055.GB28112@redhat.com>
 <CAEf4BzbyFy0eQHLac3zR8GiGDOUqYoTGAWDbFaeou903OGOTpg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAEf4BzbyFy0eQHLac3zR8GiGDOUqYoTGAWDbFaeou903OGOTpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.03.25 20:43, Andrii Nakryiko wrote:
> On Wed, Mar 5, 2025 at 7:22 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> On 03/04, David Hildenbrand wrote:
>>>
>>> Currently, uprobe_write_opcode() implements COW-breaking manually, which is
>>> really far from ideal.
>>
>> To say at least ;)
>>
>> David, thanks for doing this. I'll try to read 3/3 tomorrow, but I don't
>> think I can really help. Let me repeat, this code was written many years
>> ago, I forgot everything, and today my understanding of mm/ is very poor.
>> But I'll try anyway.
>>
>>> Are there any uprobe tests / benchmarks that are worth running?
>>
>> All I know about uprobe tests is that bpf people run a lot of tests which
>> use uprobes.
>>
>> Andrii, Jiri, what you advise?
>>
> 
> We do have a bunch of tests within BPF selftests:
> 
> cd tools/testing/selftest/bpf && make -j$(nproc) && sudo ./test_progs -t uprobe

I stumbled over them, but was so far not successful in building them in 
my test VM (did not try too hard, though). Will try harder now that I 
know that it actually tests uprobe properly :)

> 
> I also built an uprobe-stress tool to validate uprobe optimizations I
> was doing, this one is the most stand-alone thing to use for testing,
> please consider checking that. You can find it at [0], and see also
> [1] and [2] where  I was helping Peter to build it from sources, so
> that might be useful for you as well, if you run into problems with
> building. Running something like `sudo ./uprobe-stress -a10 -t5 -m5
> -f3` would hammer on this quite a bit.

Thanks, I'll play with that as well.

> 
> I'm just about to leave on a short vacation, so won't have time to go
> over patches, but I plan to look at them when I'm back next week.
> 
>    [0] https://github.com/libbpf/libbpf-bootstrap/tree/uprobe-stress
>    [1] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com/
>    [2] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZqKCR-EQz6LTi-YvFY4RnYb_NnQXtwgZCv6aUo7gjkHg@mail.gmail.com
> 
>> Oleg.
>>
> 


-- 
Cheers,

David / dhildenb



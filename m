Return-Path: <linux-kernel+bounces-345562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583498B784
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497311C225B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCABE19D8BB;
	Tue,  1 Oct 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOSFziIh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096019D897
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772493; cv=none; b=QYrQ0Dae1pYPCWRUPJHcxj8iwrnCS44NY3MI8pmZ0Kwcl0iYihgmGMMViY0FJ6Z02yudlcsePTPWF+7fNGr1yQQ7k6LMU5YWNatJ0WkBrSLA098f5S5/YXzKzlBVXTD/lnZ+hNSuHXO3lSa9p0PwJDhQWzwN67oP+zFcwmykmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772493; c=relaxed/simple;
	bh=5rBqJi7KbcX0m4Q7h+qAjw9hT3YhtE4uNLRYh6G6eLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOFNuJcv/V1wEg6tl2cI/xtc/hKL4q4LN24Sm+i+2wVURl9v2LNKr/vi+SXJ0mPeCTLdYRJP+7fzDf8MwGl7RtWCwkJ9aXGuuFlGI9VXJG+M5Nr4Qrq6lVA73QGwYQSaMUAesUeUsfM1hxvTzJyNJya9qqsDT34bhXchwp0llAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOSFziIh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727772488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEm5ojuJhoOn7g8PXFU5ISZLz6VkoHdsbScboyQ/Uho=;
	b=EOSFziIhq+TUyUPBqjIgWYJlglezv6dvNxVJGEk1UeA4p/7UImzBs2TVTPHPSQpv1Zrhy7
	u7lzQ2X7qBBpDsHw/KV06WrabxJny2R9/VQle/uu3mvz6c6ycPHB45NAAk8GlLNeWgh9Wl
	u0E4Iz7dCnt/BruVFmH5Hch/YDsBLTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Kl6OPojZPjCmWbP2hvxDVg-1; Tue, 01 Oct 2024 04:48:07 -0400
X-MC-Unique: Kl6OPojZPjCmWbP2hvxDVg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8cso29918895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772486; x=1728377286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEm5ojuJhoOn7g8PXFU5ISZLz6VkoHdsbScboyQ/Uho=;
        b=SxvcghN6GtFo6k8OW1QRfWIhwqjMaUuW/R6UPqS0zPD4Gsg5BRy77PNZ0ELsecRoWn
         +keEBUWLJjhDWtxlyp6Gn7ssf1gi8/x3sOmr3wn/4PfcswcS/QZ1hX76HxeAhYBdhEAb
         zLisIhsz7LPDiftQQbITeDb4JOC/by+HlLplYbIy5s5rDEYh6xd74pZU0gVREBj/TlNz
         35XxAca+fV4Jg3mjoCT7iRHjLgL//8pneEBlvcBphZd3gZrlGsRDeMciXBQKWrk6/IXW
         aCnXi8SSXzHOPp8naAGOXlBBOMEtWAQLk1m8pPHnZNgkCIFlPl/OaFSyPni4iZidw0DG
         xmYg==
X-Forwarded-Encrypted: i=1; AJvYcCXBNnKFu4VMbEi7hqiKBUTYygdEYV+X1+y+SeSc7VQZlU2j1G2/eluvAsV6uufVSHhAqjWxybttq+okVUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoaaoXNMG9NQWY8vBp6Nh8ReSfiqqvbYWpbV8MOYM7QefF4tf
	pArtC2sGoondTVcUrPLYZur6f3NItUfw1Mh0Oezp+CRjYjYGz1Fm7qVyVufT7adSoINYFUPb5E1
	TwwFBID07AEfJktIbbJkC4FSytG3OnYco0JoK+u3fNnYVf9D4P+62D7GpfrllFQ==
X-Received: by 2002:a05:600c:1c23:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-42f5840e8a9mr122347615e9.7.1727772486232;
        Tue, 01 Oct 2024 01:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPtSgDKS1it6DiWxvh0im92E3owB74jDJaXSXgMvOd6krcftJvW5F6+aJBQjNEVgz4ZFyOqw==
X-Received: by 2002:a05:600c:1c23:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-42f5840e8a9mr122347315e9.7.1727772485717;
        Tue, 01 Oct 2024 01:48:05 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dd2eadsm126156215e9.6.2024.10.01.01.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:48:05 -0700 (PDT)
Message-ID: <a9bf1065-462e-4ea0-920b-8358b54a33de@redhat.com>
Date: Tue, 1 Oct 2024 10:48:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test attr: Add back missing topdown events
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
 Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240311081611.7835-1-vmolnaro@redhat.com>
 <alpine.LRH.2.20.2403201314570.4040@Diego> <ZroNTkdA8XDFaDks@x1>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZroNTkdA8XDFaDks@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/24 15:25, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 20, 2024 at 01:16:48PM +0100, Michael Petlan wrote:
>> Hello Ian,
>> we've resent this patch, as the previous discussion about this
>> was unfinished somehow, if I remember correctly. Is this fix
>> acceptable?
>> Thank you!
>> Michael
> 
> Ian,
> 
> 	I think this fell thru the cracks, do you have something to add?
> 
> - Arnaldo
>  
Hi Ian,

do you have anything to add to this patch so that the issue
could be resolved?

Thanks,
Veronika
>> On Mon, 11 Mar 2024, vmolnaro@redhat.com wrote:
>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>
>>> With the patch 0b6c5371c03c "Add missing topdown metrics events" eight
>>> topdown metric events with numbers ranging from 0x8000 to 0x8700 were
>>> added to the test since they were added as 'perf stat' default events.
>>> Later the patch 951efb9976ce "Update no event/metric expectations" kept
>>> only 4 of those events(0x8000-0x8300).
>>>
>>> Currently, the topdown events with numbers 0x8400 to 0x8700 are missing
>>> from the list of expected events resulting in a failure. Add back the
>>> missing topdown events.
>>>
>>> Fixes: 951efb9976ce ("perf test attr: Update no event/metric expectations")
>>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>>> ---
>>>  tools/perf/tests/attr/test-stat-default    |  90 ++++++++++----
>>>  tools/perf/tests/attr/test-stat-detailed-1 | 106 +++++++++++-----
>>>  tools/perf/tests/attr/test-stat-detailed-2 | 130 ++++++++++++-------
>>>  tools/perf/tests/attr/test-stat-detailed-3 | 138 ++++++++++++++-------
>>>  4 files changed, 320 insertions(+), 144 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
>>> index a1e2da0a9a6d..e47fb4944679 100644
>>> --- a/tools/perf/tests/attr/test-stat-default
>>> +++ b/tools/perf/tests/attr/test-stat-default
>>> @@ -88,98 +88,142 @@ enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>>  [event13:base-stat]
>>>  fd=13
>>>  group_fd=11
>>>  type=4
>>> -config=33280
>>> +config=33024
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>>  [event14:base-stat]
>>>  fd=14
>>>  group_fd=11
>>>  type=4
>>> -config=33536
>>> +config=33280
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>>  [event15:base-stat]
>>>  fd=15
>>>  group_fd=11
>>>  type=4
>>> -config=33024
>>> +config=33536
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
>>>  [event16:base-stat]
>>>  fd=16
>>> +group_fd=11
>>>  type=4
>>> -config=4109
>>> +config=33792
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>>>  [event17:base-stat]
>>>  fd=17
>>> +group_fd=11
>>>  type=4
>>> -config=17039629
>>> +config=34048
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>>>  [event18:base-stat]
>>>  fd=18
>>> +group_fd=11
>>>  type=4
>>> -config=60
>>> +config=34304
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>>>  [event19:base-stat]
>>>  fd=19
>>> +group_fd=11
>>>  type=4
>>> -config=2097421
>>> +config=34560
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>>  [event20:base-stat]
>>>  fd=20
>>>  type=4
>>> -config=316
>>> +config=4109
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>>  [event21:base-stat]
>>>  fd=21
>>>  type=4
>>> -config=412
>>> +config=17039629
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>>  [event22:base-stat]
>>>  fd=22
>>>  type=4
>>> -config=572
>>> +config=60
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>>  [event23:base-stat]
>>>  fd=23
>>>  type=4
>>> -config=706
>>> +config=2097421
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>>  [event24:base-stat]
>>>  fd=24
>>>  type=4
>>> +config=316
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +[event25:base-stat]
>>> +fd=25
>>> +type=4
>>> +config=412
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +[event26:base-stat]
>>> +fd=26
>>> +type=4
>>> +config=572
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +[event27:base-stat]
>>> +fd=27
>>> +type=4
>>> +config=706
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +[event28:base-stat]
>>> +fd=28
>>> +type=4
>>>  config=270
>>>  optional=1
>>> diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
>>> index 1c52cb05c900..3d500d3e0c5c 100644
>>> --- a/tools/perf/tests/attr/test-stat-detailed-1
>>> +++ b/tools/perf/tests/attr/test-stat-detailed-1
>>> @@ -90,99 +90,143 @@ enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>>  [event13:base-stat]
>>>  fd=13
>>>  group_fd=11
>>>  type=4
>>> -config=33280
>>> +config=33024
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>>  [event14:base-stat]
>>>  fd=14
>>>  group_fd=11
>>>  type=4
>>> -config=33536
>>> +config=33280
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>>  [event15:base-stat]
>>>  fd=15
>>>  group_fd=11
>>>  type=4
>>> -config=33024
>>> +config=33536
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
>>>  [event16:base-stat]
>>>  fd=16
>>> +group_fd=11
>>>  type=4
>>> -config=4109
>>> +config=33792
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>>>  [event17:base-stat]
>>>  fd=17
>>> +group_fd=11
>>>  type=4
>>> -config=17039629
>>> +config=34048
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>>>  [event18:base-stat]
>>>  fd=18
>>> +group_fd=11
>>>  type=4
>>> -config=60
>>> +config=34304
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>>>  [event19:base-stat]
>>>  fd=19
>>> +group_fd=11
>>>  type=4
>>> -config=2097421
>>> +config=34560
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>>  [event20:base-stat]
>>>  fd=20
>>>  type=4
>>> -config=316
>>> +config=4109
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>>  [event21:base-stat]
>>>  fd=21
>>>  type=4
>>> -config=412
>>> +config=17039629
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>>  [event22:base-stat]
>>>  fd=22
>>>  type=4
>>> -config=572
>>> +config=60
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>>  [event23:base-stat]
>>>  fd=23
>>>  type=4
>>> -config=706
>>> +config=2097421
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>>  [event24:base-stat]
>>>  fd=24
>>>  type=4
>>> +config=316
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +[event25:base-stat]
>>> +fd=25
>>> +type=4
>>> +config=412
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +[event26:base-stat]
>>> +fd=26
>>> +type=4
>>> +config=572
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +[event27:base-stat]
>>> +fd=27
>>> +type=4
>>> +config=706
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +[event28:base-stat]
>>> +fd=28
>>> +type=4
>>>  config=270
>>>  optional=1
>>>  
>>> @@ -190,8 +234,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event25:base-stat]
>>> -fd=25
>>> +[event29:base-stat]
>>> +fd=29
>>>  type=3
>>>  config=0
>>>  optional=1
>>> @@ -200,8 +244,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event26:base-stat]
>>> -fd=26
>>> +[event30:base-stat]
>>> +fd=30
>>>  type=3
>>>  config=65536
>>>  optional=1
>>> @@ -210,8 +254,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event27:base-stat]
>>> -fd=27
>>> +[event31:base-stat]
>>> +fd=31
>>>  type=3
>>>  config=2
>>>  optional=1
>>> @@ -220,8 +264,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event28:base-stat]
>>> -fd=28
>>> +[event32:base-stat]
>>> +fd=32
>>>  type=3
>>>  config=65538
>>>  optional=1
>>> diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
>>> index 7e961d24a885..01777a63752f 100644
>>> --- a/tools/perf/tests/attr/test-stat-detailed-2
>>> +++ b/tools/perf/tests/attr/test-stat-detailed-2
>>> @@ -90,99 +90,143 @@ enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>>  [event13:base-stat]
>>>  fd=13
>>>  group_fd=11
>>>  type=4
>>> -config=33280
>>> +config=33024
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>>  [event14:base-stat]
>>>  fd=14
>>>  group_fd=11
>>>  type=4
>>> -config=33536
>>> +config=33280
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>>  [event15:base-stat]
>>>  fd=15
>>>  group_fd=11
>>>  type=4
>>> -config=33024
>>> +config=33536
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
>>>  [event16:base-stat]
>>>  fd=16
>>> +group_fd=11
>>>  type=4
>>> -config=4109
>>> +config=33792
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>>>  [event17:base-stat]
>>>  fd=17
>>> +group_fd=11
>>>  type=4
>>> -config=17039629
>>> +config=34048
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>>>  [event18:base-stat]
>>>  fd=18
>>> +group_fd=11
>>>  type=4
>>> -config=60
>>> +config=34304
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>>>  [event19:base-stat]
>>>  fd=19
>>> +group_fd=11
>>>  type=4
>>> -config=2097421
>>> +config=34560
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>>  [event20:base-stat]
>>>  fd=20
>>>  type=4
>>> -config=316
>>> +config=4109
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>>  [event21:base-stat]
>>>  fd=21
>>>  type=4
>>> -config=412
>>> +config=17039629
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>>  [event22:base-stat]
>>>  fd=22
>>>  type=4
>>> -config=572
>>> +config=60
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>>  [event23:base-stat]
>>>  fd=23
>>>  type=4
>>> -config=706
>>> +config=2097421
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>>  [event24:base-stat]
>>>  fd=24
>>>  type=4
>>> +config=316
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +[event25:base-stat]
>>> +fd=25
>>> +type=4
>>> +config=412
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +[event26:base-stat]
>>> +fd=26
>>> +type=4
>>> +config=572
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +[event27:base-stat]
>>> +fd=27
>>> +type=4
>>> +config=706
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +[event28:base-stat]
>>> +fd=28
>>> +type=4
>>>  config=270
>>>  optional=1
>>>  
>>> @@ -190,8 +234,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event25:base-stat]
>>> -fd=25
>>> +[event29:base-stat]
>>> +fd=29
>>>  type=3
>>>  config=0
>>>  optional=1
>>> @@ -200,8 +244,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event26:base-stat]
>>> -fd=26
>>> +[event30:base-stat]
>>> +fd=30
>>>  type=3
>>>  config=65536
>>>  optional=1
>>> @@ -210,8 +254,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event27:base-stat]
>>> -fd=27
>>> +[event31:base-stat]
>>> +fd=31
>>>  type=3
>>>  config=2
>>>  optional=1
>>> @@ -220,8 +264,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event28:base-stat]
>>> -fd=28
>>> +[event32:base-stat]
>>> +fd=32
>>>  type=3
>>>  config=65538
>>>  optional=1
>>> @@ -230,8 +274,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event29:base-stat]
>>> -fd=29
>>> +[event33:base-stat]
>>> +fd=33
>>>  type=3
>>>  config=1
>>>  optional=1
>>> @@ -240,8 +284,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event30:base-stat]
>>> -fd=30
>>> +[event34:base-stat]
>>> +fd=34
>>>  type=3
>>>  config=65537
>>>  optional=1
>>> @@ -250,8 +294,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event31:base-stat]
>>> -fd=31
>>> +[event35:base-stat]
>>> +fd=35
>>>  type=3
>>>  config=3
>>>  optional=1
>>> @@ -260,8 +304,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event32:base-stat]
>>> -fd=32
>>> +[event36:base-stat]
>>> +fd=36
>>>  type=3
>>>  config=65539
>>>  optional=1
>>> @@ -270,8 +314,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event33:base-stat]
>>> -fd=33
>>> +[event37:base-stat]
>>> +fd=37
>>>  type=3
>>>  config=4
>>>  optional=1
>>> @@ -280,8 +324,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event34:base-stat]
>>> -fd=34
>>> +[event38:base-stat]
>>> +fd=38
>>>  type=3
>>>  config=65540
>>>  optional=1
>>> diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
>>> index e50535f45977..8400abd7e1e4 100644
>>> --- a/tools/perf/tests/attr/test-stat-detailed-3
>>> +++ b/tools/perf/tests/attr/test-stat-detailed-3
>>> @@ -90,99 +90,143 @@ enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>>  [event13:base-stat]
>>>  fd=13
>>>  group_fd=11
>>>  type=4
>>> -config=33280
>>> +config=33024
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
>>>  [event14:base-stat]
>>>  fd=14
>>>  group_fd=11
>>>  type=4
>>> -config=33536
>>> +config=33280
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
>>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
>>>  [event15:base-stat]
>>>  fd=15
>>>  group_fd=11
>>>  type=4
>>> -config=33024
>>> +config=33536
>>>  disabled=0
>>>  enable_on_exec=0
>>>  read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
>>>  [event16:base-stat]
>>>  fd=16
>>> +group_fd=11
>>>  type=4
>>> -config=4109
>>> +config=33792
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
>>>  [event17:base-stat]
>>>  fd=17
>>> +group_fd=11
>>>  type=4
>>> -config=17039629
>>> +config=34048
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
>>>  [event18:base-stat]
>>>  fd=18
>>> +group_fd=11
>>>  type=4
>>> -config=60
>>> +config=34304
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
>>>  [event19:base-stat]
>>>  fd=19
>>> +group_fd=11
>>>  type=4
>>> -config=2097421
>>> +config=34560
>>> +disabled=0
>>> +enable_on_exec=0
>>> +read_format=15
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
>>>  [event20:base-stat]
>>>  fd=20
>>>  type=4
>>> -config=316
>>> +config=4109
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
>>>  [event21:base-stat]
>>>  fd=21
>>>  type=4
>>> -config=412
>>> +config=17039629
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
>>>  [event22:base-stat]
>>>  fd=22
>>>  type=4
>>> -config=572
>>> +config=60
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
>>>  [event23:base-stat]
>>>  fd=23
>>>  type=4
>>> -config=706
>>> +config=2097421
>>>  optional=1
>>>  
>>> -# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
>>>  [event24:base-stat]
>>>  fd=24
>>>  type=4
>>> +config=316
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
>>> +[event25:base-stat]
>>> +fd=25
>>> +type=4
>>> +config=412
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
>>> +[event26:base-stat]
>>> +fd=26
>>> +type=4
>>> +config=572
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
>>> +[event27:base-stat]
>>> +fd=27
>>> +type=4
>>> +config=706
>>> +optional=1
>>> +
>>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
>>> +[event28:base-stat]
>>> +fd=28
>>> +type=4
>>>  config=270
>>>  optional=1
>>>  
>>> @@ -190,8 +234,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event25:base-stat]
>>> -fd=25
>>> +[event29:base-stat]
>>> +fd=29
>>>  type=3
>>>  config=0
>>>  optional=1
>>> @@ -200,8 +244,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event26:base-stat]
>>> -fd=26
>>> +[event30:base-stat]
>>> +fd=30
>>>  type=3
>>>  config=65536
>>>  optional=1
>>> @@ -210,8 +254,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event27:base-stat]
>>> -fd=27
>>> +[event31:base-stat]
>>> +fd=31
>>>  type=3
>>>  config=2
>>>  optional=1
>>> @@ -220,8 +264,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event28:base-stat]
>>> -fd=28
>>> +[event32:base-stat]
>>> +fd=32
>>>  type=3
>>>  config=65538
>>>  optional=1
>>> @@ -230,8 +274,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event29:base-stat]
>>> -fd=29
>>> +[event33:base-stat]
>>> +fd=33
>>>  type=3
>>>  config=1
>>>  optional=1
>>> @@ -240,8 +284,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event30:base-stat]
>>> -fd=30
>>> +[event34:base-stat]
>>> +fd=34
>>>  type=3
>>>  config=65537
>>>  optional=1
>>> @@ -250,8 +294,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event31:base-stat]
>>> -fd=31
>>> +[event35:base-stat]
>>> +fd=35
>>>  type=3
>>>  config=3
>>>  optional=1
>>> @@ -260,8 +304,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event32:base-stat]
>>> -fd=32
>>> +[event36:base-stat]
>>> +fd=36
>>>  type=3
>>>  config=65539
>>>  optional=1
>>> @@ -270,8 +314,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event33:base-stat]
>>> -fd=33
>>> +[event37:base-stat]
>>> +fd=37
>>>  type=3
>>>  config=4
>>>  optional=1
>>> @@ -280,8 +324,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event34:base-stat]
>>> -fd=34
>>> +[event38:base-stat]
>>> +fd=38
>>>  type=3
>>>  config=65540
>>>  optional=1
>>> @@ -290,8 +334,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
>>> -[event35:base-stat]
>>> -fd=35
>>> +[event39:base-stat]
>>> +fd=39
>>>  type=3
>>>  config=512
>>>  optional=1
>>> @@ -300,8 +344,8 @@ optional=1
>>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>>>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
>>> -[event36:base-stat]
>>> -fd=36
>>> +[event40:base-stat]
>>> +fd=40
>>>  type=3
>>>  config=66048
>>>  optional=1
>>> -- 
>>> 2.43.0
>>>
>>>
>>
> 



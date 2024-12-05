Return-Path: <linux-kernel+bounces-433412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FB9E5812
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE38728C2A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373521A421;
	Thu,  5 Dec 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ByvkqnoU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FAE212B33
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407280; cv=none; b=N7+4lwXWFki7U7ejMrdGTwaZRUg4zB0bR7qKzdFRoxmAS5izE1n2Gu4SYzFMCiD4xEmk7b5tnmeBgYGUj30S+YwWfM0ThdAZsvaYKonvcsYxtJ4M+rBoNihZoTB+AeS0Vu8Z7UlgJcvrTFUkq1z0WB+vl76N4LvOBREt7AybKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407280; c=relaxed/simple;
	bh=6Asccw/pBvXBRTex0yHdpkL0o/gqh4BKdYKv5u5n7Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMRMBZc2X1wzZZ/h059fkRuDrXHLotGsplaQ3RT+UySyAl7uajouguBwfvr2pXqKlu/YcqJzz8wX+howvk+jMs1kR0egElPTZ/KGiNiqwT14cMwZkEFCOT49OxFhwRjYn2RpuLhUk8hUvqwEpTeFBkltO5slsxPCcnt2h5RZcMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ByvkqnoU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7251331e756so1023753b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733407277; x=1734012077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpRORDlOSyyK0TIPTg7jGlq72w4s19iZ1HiN79ixu8Y=;
        b=ByvkqnoUWoS/W7FnIdS1rxZZKoOSsU6WB8enJkhUudKSlw4X5lEBekJI9MgggHKcuf
         ARjdKd5hEWx9Q/jHevMK+OGGXWZmmtRBrHwqGvaGzTdQmTIYYYp8JNRClNblQyKX73Bf
         rzzlje1Rkunqgte/1gctdt+c/La/aGKdu1CyHjjQfAcKjyh4eY+bgVXiiC1PN/CDQj96
         OqfcBM6onnJO3EXG9pB/Oe6+51jdchAx2gYQw+bWahcANsOx5SBzKsi/pG5HO1x+ftm8
         3P5JajWnd4miUcSny+aZNprOuIwaXrNqSioSDKULP2GpzAxGVHwnIX2W7bHDqyTW8cNR
         fkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733407277; x=1734012077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpRORDlOSyyK0TIPTg7jGlq72w4s19iZ1HiN79ixu8Y=;
        b=hFrBJvGE4GxhK2YjA9k3fB5uJbCFSiR+2kMDkXuwxvfzuECkVjUnuYmbNVBOnPpTli
         +jxwUYTLGsYic5xtU1WpGJVNx1/IdeY5ylMNzMjNZK44m+e2CcO6EloiH+eB55wj78er
         GKET1pPkhjqMA5CF0Yx4FATAWpaT0GK5wa3XtBAVTj5a13f9gxWzY6U2euTxzzLc+y9p
         6m0YCaHqNNU1MgoS/UrCAWFY78CiEQu2oIn82iVZEZLwEeW3Ir8iJh+0zj7A8sn7EMe3
         UDFkCFeesDzh0LAhJIk7QEB6U2xL1yVSP5L8PvTL1yVDbqtq/2fX+PCL+NgylUVcP+Sg
         GWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi1w2HzBmrb3e3LUZ/00zfnE/ojJfwuDZyGmQY0b8lJBzsA85HdJUSgzSpbB5vBkIb/GWLZA22q7Tb11Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZHuhHm5UzZO6oMU+qv7NEAHn7HAT4qqZwFv/JUPrVe4Ahz+G
	3aca8a1MGftpdLeqR4VlAwaI+9yWC8GmbHOuTe70NwKdGuvAyjjFAqzdF9HqrEg=
X-Gm-Gg: ASbGncsNw7zLQX/VtjGkfqtxij0Y2gle8YmRWSBl/6wmaM8srZHBcwn3gfCe/XQDjZI
	u3+7f5DfRLhLyp39/LibqFXL3jxhA+toY9xnQ7pw9F/vYK3V3y0OnJ1i9gCTKAC8OgoksVmTn3f
	8ok1oQgBSJ0NE6xU7/eIO3GGIryFsIrL/+Qsur+gSmmgP/OE9rr9w36C6MCuS7Gl5JUAGSMfg7A
	Ep+ATW7DjboisDfL3BFEsPU2HBDzyUeA6/0swre+X6BI1QCjALTkNbgULEr/ZI=
X-Google-Smtp-Source: AGHT+IH92ckWqdHzNoS5FeUm7rB/Ewh7sQxaVePWUF8KGCELq4PdI0tWd7UGDqOxQ3hhCkHlFxiYZQ==
X-Received: by 2002:a17:903:22cb:b0:215:94eb:ada8 with SMTP id d9443c01a7336-215bd26a30amr140967095ad.51.1733407277491;
        Thu, 05 Dec 2024 06:01:17 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9f8bsm12480755ad.124.2024.12.05.06.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 06:01:16 -0800 (PST)
Message-ID: <73c70244-8dd8-4a5d-a132-1074e6205d37@bytedance.com>
Date: Thu, 5 Dec 2024 22:01:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 00/12] perf record: Add event action support
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <Z0jPPRA8JXSrwyaC@x1> <Z04qmNnt86zcGE5Q@google.com>
 <ff9bc82e-669b-44b7-a02c-f5c704c0cd9b@bytedance.com>
 <CAP-5=fVocYqEbv6P=UP7rQCUhZHSmJZ3GGE08koTMG2rWWumgA@mail.gmail.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <CAP-5=fVocYqEbv6P=UP7rQCUhZHSmJZ3GGE08koTMG2rWWumgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 12/5/24 03:54, Ian Rogers wrote:
> On Wed, Dec 4, 2024 at 12:35 AM Yang Jihong <yangjihong@bytedance.com> wrote:
>>
>> Hello,
>>
>> On 12/3/24 05:46, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Thu, Nov 28, 2024 at 05:14:53PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
>>>>> In perf-record, when an event is triggered, default behavior is to
>>>>> save sample data to perf.data. Sometimes, we may just want to do
>>>>> some lightweight actions, such as printing a log.
>>>>
>>>>> Based on this requirement, add the --action option to the event to
>>>>> specify the behavior when the event occurs.
>>>>
>>>> 'perf record' is centered on saving data to disk without processing
>>>> events, while it has sideband events for some needs, like processing BPF
>>>> related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOAD
>>>> and UNLOAD), doing things in a "live" way as your patchkit does seems
>>>> more appropriate to do in 'perf trace' :-)
>>>
>>> Agreed, 'perf trace' looks like a better place as you seem to target
>>> tracepoint events mostly.
>>>
>> Okay, will do it in 'perf trace'.
>>
>> Attaching to a kprobe events will also be supported in the future.
> 
> Hi Yang,
> 
> Just some extra information in case it is useful on python scripting,
> which could be reused to avoid writing a new interpreter as in this
> series. There are quite a few perf script examples here:

Thanks for your suggestion. I think using python scripting, similar to 
bcc, is more suitable for scenarios with complex requirements.
For some simple and lightweight scenarios, such as just printing some 
information in real time, one-line command (similar to dtrace)may be 
more suitable to implement user-defined sample.
This is just my idea, hope to discuss to improve the usability of 
perf-tool. :-)

> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/scripts/python?h=perf-tools-next
> There are also standalone scripts here including for tracepoints:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/python?h=perf-tools-next
> One of the things missing for standalone scripts was being able to
> conveniently parse events - you'd need to manually determine PMU type
> and config values. That is fixed in this reviewed but not merged
> series:
> https://lore.kernel.org/lkml/20241119011644.971342-1-irogers@google.com/
> 
> I'd like to see the python code improved as it allows quicker command
> creation like your example. Another example I'd recently tweaked is:
> https://lore.kernel.org/lkml/20241119180130.19160-1-irogers@google.com/
> Ultimately I think it would be nice to be creating tools using UIs
> like textualize:
> https://www.textualize.io/
> and our Gecko Google summer-of-code project was an improvement here:
> https://lore.kernel.org/lkml/ZOrsiZA+C0zbWEQS@yoga/
> 
> Other than basic functionality, perf's python support could be
> improved in a number of ways that we've discussed in office hours or
> on the list. Some things that come to mind:
> 1) The perf script callback mechanism doesn't feel particularly
> pythonic, generators or coroutines could be better.
> 2) We should probably have more library python code rather than adding
> new functions to `tools/perf/util/python.c` - I may do this to add
> type hints for mypy. If we could have a subset that works without the
> C code then it could be a basis for `perf.data` file analysis not tied
> to Linux, or `pip install`-able. There is a similar library with
> simpleperf, but shipping something with the perf codebase means we can
> keep the file format and library synchronized.
> 3) We'd like to reduce the number of dependencies `perf` as a command
> has, and libpython is a big one. Something `uftrace` did was dlopen
> libpython to avoid needing to link against it. A project similarly
> rethinking python binding with C code is HPy.
> 
Yes, we can greatly simplify the development work by using python.
In the end, if we can allow users to import perf python library and use 
a few simple codes to implement a customized data collection, it will be 
of great help to improve the usability of the perf tool.


Actually, I think perf-tool has a lot of functions and is very helpful 
for performance optimization, but the threshold is relatively high for 
beginners. (I don’t know if this is appropriate :-))

I have some considerations in improving the usability of the tool, but I 
don’t know if it is appropriate:
1. Provide rich prompt information, such as perf-help can provide some 
user requirements in an interactive way, provide common perf commands 
and usage methods; or provide some usage cases through keywords
2. Use some graphical interfaces as the backend so that users can use it 
in an easy-to-understand way
3. Based on the python you mentioned above, I think it is a good way to 
allow some developers to customize sampling data more easily.


Thanks,
Yang.


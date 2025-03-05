Return-Path: <linux-kernel+bounces-546409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0701A4FA51
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C799A3AC6F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362220551B;
	Wed,  5 Mar 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsb9rFWx"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DD1FC7CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167465; cv=none; b=AUb1OchfxVus1EbfreKL1yhlaVfbHEE2l+nHnpg07znpNznnPylYr8jbzH7+CSzJsL/BTmrlcEKoA5Ac5v0qvibnVmhLRdMWKPTGXdJJuHt5bQA5rAB0L1Bbl0kx3bCgYGPjdBO+u3iz04hAQ4amQBtBgMfPcYzPTNJr9ByINJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167465; c=relaxed/simple;
	bh=isjro7OOWBCeb6GkdES/x2yquOYlb6X+fXMrG+gQ09k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKGeNT5pLMYj5JUaWDUAMXiZ6+V+X6xtXAaD8eP7veptfvYscccu05yLm7RMhEF+kTOfGsgxFqL/mLPcHYN+0SoP+AnnH26HylbcIyQkZY4utA3C4AoVvvJUFc5jzJ9cZcHv3mxGbGx7Qtu4Y+xZ5r8CYvEe9cUs7EZdnYUlYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qsb9rFWx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394036c0efso41725345e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741167462; x=1741772262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Grr+Ryd7sxW458ZEYnV+lJNtq+fkIQR73sXzq9266bY=;
        b=qsb9rFWxYeS1w5erYBXTPQUINWG32R01F/sK8zotXtSgjpGLrMw4AvYq9lipiph+rv
         mZDC32zRZXaf/2Ej0+1RsTGECNvwBvSaqDw9XU35K3yc/Ew+dIDFRmBI1Nxkf4dVt6UU
         TbTElUmkYvliAfkU/D3cFKERJ5Th8Ar62UWeLYIn25ZToctuqApgWGf00saqDuJjRRRy
         vPnSjWB6mMltnojQQelLuICyQX6ZXAwUFkk7zs2Xq1/cEwLtzLiQCS8w+l41pbN5j40L
         i8OGTlDgAhHufJ4Se1ZBRRLpLsPswQlG/kN3GE9/YxrSG611bqVd8eGrXGJlNA0EgEQa
         vbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167462; x=1741772262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Grr+Ryd7sxW458ZEYnV+lJNtq+fkIQR73sXzq9266bY=;
        b=JlyIBO52bBGvW9ZhEeriM1mE/fm/crJ7WqizuFc32A0M1L2AzY5gf6Ja0Mkuikz4+H
         WzPV78iQgSuT6TDyZ16dQ5T+8J4CsnG0XzQc/J78xmDY30lbOmXil+83G5HibshfajQa
         JIcfnD0iFywD1E9cSE2d8YP3r7xtY+N1aoEZ9bjyEN96iYtvdwa7n+KWDDynKE1ekXlN
         MGR7/D0y4RTOEkwfABoy003wEw/oG/kGt+kE4BS9Il6rVLmxLU4WEPnazyDrwdzO3mhs
         JQJM1ptUKc/OQr89NhyqqXEDGVbARgWzucq6cW2I2csg2pEPTHux3URkIYGtFTXWOR9P
         7q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjvClE+PIeZ3/DIUV9z4PdXFEvtlVU6+fNbLifJkMJRLyJPudkaK2FPFrHDQxkWpRdYw/6c+mMLkS/l5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45eIQheyEFyX13T3N6DJIPJyRvph0mTY5l7Fv/I7sUsmzdvES
	euBuSGkcaEbu4f2A8azQZHexVCM+3Y4tUW1BVjYxW+B7FsD/z7k+ITWTpRP+6ds=
X-Gm-Gg: ASbGncvGwImrzb1LbnWrsImytLqwGFni8gtskYO9p/F7cOGxWhsdtiZY84QK3JOthdU
	7OPiDWIlkvMNSl/8RK3ROwLWLs0ZgeBXI2uiJ9VyBSXT3oiroHkWMAgP7Iwvm/XQh34X4O0+bRa
	Bxca7S8oxl9VwtnrSy5qWo4nD3fCUVefxytPPurMxaDZC/tGHH6PkuAwnFQMMtRqvl43gWLLOUP
	vtOhr+diAIzdjc0dRHXhHrbVf65S9CpLSOugMZw6FDDBLS0zg3bhkTbPKYjJdgTpsKHAoeBu2Hu
	Ijh3aA2bfMr+yrRY+BO/uMiGqU27JFO1pBVNYvaIt3zQE3ONQyps6/U=
X-Google-Smtp-Source: AGHT+IHLvj7BNI5tvdYEjWzU14lOUssmMCCnp9Uix4nr7D2htDflU5rgXZLhEFrgq2kEhSCjpXYOag==
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr2232774f8f.16.1741167462428;
        Wed, 05 Mar 2025 01:37:42 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a38sm20595393f8f.75.2025.03.05.01.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 01:37:42 -0800 (PST)
Message-ID: <36123515-a268-40cb-b010-2600c2f5c1c6@linaro.org>
Date: Wed, 5 Mar 2025 09:37:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove some PMU events for FUJITSU-MONAKA
To: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
Cc: 'John Garry' <john.g.garry@oracle.com>, 'Will Deacon' <will@kernel.org>,
 'Mike Leach' <mike.leach@linaro.org>, 'Leo Yan' <leo.yan@linux.dev>,
 'Peter Zijlstra' <peterz@infradead.org>, 'Ingo Molnar' <mingo@redhat.com>,
 'Arnaldo Carvalho de Melo' <acme@kernel.org>,
 'Namhyung Kim' <namhyung@kernel.org>, 'Mark Rutland' <mark.rutland@arm.com>,
 'Alexander Shishkin' <alexander.shishkin@linux.intel.com>,
 'Jiri Olsa' <jolsa@kernel.org>, 'Ian Rogers' <irogers@google.com>,
 'Adrian Hunter' <adrian.hunter@intel.com>,
 "'Liang, Kan'" <kan.liang@linux.intel.com>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>,
 "'linux-perf-users@vger.kernel.org'" <linux-perf-users@vger.kernel.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "Akio Kakuno (Fujitsu)" <fj3333bs@fujitsu.com>
References: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
 <96b323eb-15b2-4b60-8522-83bf2f57694b@linaro.org>
 <OSZPR01MB6908AA7CEB24ED38F9289D6DD4CC2@OSZPR01MB6908.jpnprd01.prod.outlook.com>
 <OS3PR01MB6903726FDA70250F72A73410D4CB2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <OS3PR01MB6903726FDA70250F72A73410D4CB2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 6:40 am, Yoshihiro Furudera (Fujitsu) wrote:
> Hi, James
> 
>>
>> Hi, James
>> Thank you for your comment.
>>
>>> On 27/02/2025 5:40 am, Yoshihiro Furudera wrote:
>>>> The following events are not counted properly:
>>>>
>>>> 0x0037 LL_CACHE_MISS_RD
>>>> 0x400B L3D_CACHE_LMISS_RD
>>>
>>> These two are discoverable so will still appear in
>>> /sys/bus/event_source/devices/armv8_pmuv3_0/events/ if the hardware
>>> says they exist. It might be better to change the json strings of
>>> these two to warn that they don't work if that's the case, otherwise
>>> Perf will still list them and you'll be worse off.
>>
>> I will leave these 2 events and
>> add a warning message to the description in the JSON file.
>> I will handle other events in the same way as these 2 events.
> 
> I'm thinking of adding one of the following warnings
> to the description of events where inaccurate counts
> occur on FUJITSU-MONAKA.
> Is this okay?
> 
> 1.Simple version
> "Note: This event does not count accurately."
> 
> 2.Detailed version
> "Note: This event does not count accurately because it counts as a miss regardless of whether the L3 prefetch is a hit or miss."
> 
> I think "2.Detailed version" is better.
> 
> example:
> {
>      "EventCode": "0x0396",
>      "EventName": "L2D_CACHE_REFILL_L3D_MISS",
>      "BriefDescription": "This event counts operations that cause a miss of the L3 cache. Note: This event does not count accurately because it counts as a miss regardless of whether the L3 prefetch is a hit or miss."
> }
> 
> Best Regards,
> Yoshihiro Furudera

You could have both by using BriefDescription and PublicDescription. The 
longer one being available with 'perf list -v'. I think that's what that 
feature is for.

Either way you should probably also update the description before the 
note, so add 'hit or miss' to the first sentence:

"EventCode": "0x0396",
"EventName": "L2D_CACHE_REFILL_L3D_MISS",
"BriefDescription": "This event counts operations that cause a hit or 
miss of the L3 cache. Note that this incorrectly counts both hits _and_ 
misses."




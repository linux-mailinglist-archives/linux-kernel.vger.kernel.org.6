Return-Path: <linux-kernel+bounces-448995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E59F482E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4E21885784
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2D1DF257;
	Tue, 17 Dec 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVIqhT4I"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC021DE3C5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429494; cv=none; b=EvZ13ue8YHz6QDakGqnzoNsWjcKoN8QXNVuYizTpwdQr5H5qFb4swubRACuAyfJWbt40FHPsE7qBML46o9Via8gDl6O6Rw9YOMM7Pjbd5UfX7OifzQO/vFiSPEvPTlaS4brEqPBYpH+ZXPZR63HIhwesUyEKYNuG50PXQMpZUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429494; c=relaxed/simple;
	bh=U6oBPhvDLx0rEmMRcE+K74j+YiLxx5/kbqELNfLlE3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Are+VU1PFOQqeuLqN6hYfL46/rQP1LJ+EFJARn2tD5xWf3MQzR9ZyL4ieMHQXC0TfpKN9uNvtVlX53vRgk6+O23WowraGFuIoDf1qwitPky1w1Nlkx2CDfX7fMPvwnhEyHhsT0Gy3R86KkXLwwCDg/GnhRCH2zT7tZC8LMZWV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVIqhT4I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862d6d5765so3483634f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734429491; x=1735034291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/VKyM8ryPjHMJUY0N3SOuUv5n1VPnB0Cz+2hkmq5/I=;
        b=bVIqhT4IuCSD+XtRU6u4lI4j+5NsAzW8Uq+v2XzZMHjePc0FuuKhfiOI4ySFbp2VV0
         eYooC1yBDxJ3Ii1xw0HDF1XKeRprILPKOx5hOPhUjtDURAb8shHuh8r85Urx1GFzYggD
         OLrl95DK5mPRciMet90E3jnUhGGgMTp5RtE5EcSRN/t8push0YdAgSSFRqZuZYQnfjLE
         Glzj8OA3fNegufX6izGVhd9oZuwZn4zx2kPYmT/rFsrJtUlILyIP2lRdiCnOvxMTPRQV
         7CITpePNKSCBpeVvm5EL7wpSCJZV9DWB2ynqeIyyY/CP9e9tnwItp67+PJpR9OgYIGkL
         5edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734429491; x=1735034291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/VKyM8ryPjHMJUY0N3SOuUv5n1VPnB0Cz+2hkmq5/I=;
        b=GqUcDd1c88ZRPCmM3z6xHfcIQOYbEUMxZ6UuA9mZnpxST5IA15dIpKyQzXZ5DgPwQs
         Ss6QYgbj0B6jScZhdHACmgSCHVvPMocyCo13SGhsqoRTcfmkvM8H2NWVHey4QC961wzW
         /iP/WAwk97okM4b/W1jaJ8KAmCxeTo+To5l+CcXC8E4YksAVsDI4gT7fRc4fDOvQyfu5
         DLAfCr4SHCGvUXMDWiyg0J2fngcMXOhilyRJmMKi75Ip7h3vzlLCcH88xkP8MAC/ots/
         koNgSwW13CiA6C0NcFTbAhQ22UPqRemJ2YmcXlwW12uW6FglbDVPK3zAAJcSs42ziVCs
         rhlA==
X-Forwarded-Encrypted: i=1; AJvYcCWund5iACt1uiLI/HJzIfmq9PxiPfLU0170AcufqoE7gc+sc8HGpu+hWEbdNJgh64AWjZLRXA2rOVvQTBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8QhDeVDBwT+fSEj6SGJYgLSnWoRbiZCfeEKgL2mUwYiGZ43a
	W78a77BKOCAjpHZ+gPrwpZn1ocsftWrTGddv6Q63faA/p5gT0qF04fOidiOgfOs=
X-Gm-Gg: ASbGncvbyXn9yWIcESSsmXXDMXLjyuahp22J2+cV4bLKPkkjG63Igz/XrVBqU87fsF7
	KzQzRJu6Vb52nZw/mYJU+gBFRD5l4x6N4Pa47zlU/n7lxFu8eXooXkzI8aDNk4zV1RgGxlUsFJO
	WsArfEBhcbTPOLWshtytIDJlU+tZ54JiRnbugfGHVOJpMPLDGfzKXI0dQL/MC5KGcaiVBeasEa7
	/usR5DjExirieRapm9gnJzCpOM46Vg6ff5tcHSZ8rIXFZpIVqqn5wqmh7e/VD5wlkw=
X-Google-Smtp-Source: AGHT+IHZ5G++DI6ac3nyEo1wQgi/CHocyZJfFsN7w9MxFXI87OESVz+Q9Oxf6gwUCboWcpHim+BSPA==
X-Received: by 2002:a5d:5f42:0:b0:382:51ae:7569 with SMTP id ffacd0b85a97d-38880ac7758mr11514269f8f.18.1734429490745;
        Tue, 17 Dec 2024 01:58:10 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c54bsm166398105e9.13.2024.12.17.01.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:58:10 -0800 (PST)
Message-ID: <cb11fe5e-e6ab-4653-b925-4c3cb5273b43@linaro.org>
Date: Tue, 17 Dec 2024 09:58:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu event
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
 'Ilkka Koskinen' <ilkka@os.amperecomputing.com>,
 'Xu Yang' <xu.yang_2@nxp.com>, 'Jing Zhang' <renyu.zj@linux.alibaba.com>,
 'Lucas Stach' <l.stach@pengutronix.de>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>,
 "'linux-perf-users@vger.kernel.org'" <linux-perf-users@vger.kernel.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "Akio Kakuno (Fujitsu)" <fj3333bs@fujitsu.com>,
 "'nick.forrington@arm.com'" <nick.forrington@arm.com>
References: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
 <ee89c235-a126-4874-994d-b2489eb1c00f@linaro.org>
 <OS3PR01MB690303F6D0FAF71ADDE7AA4BD43D2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
 <OS3PR01MB6903A0317D8BB90A9B4DD7E8D4042@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <OS3PR01MB6903A0317D8BB90A9B4DD7E8D4042@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/12/2024 6:35 am, Yoshihiro Furudera (Fujitsu) wrote:
> Hi, James
> 
>>> Also in the common files, we're using the description strings from the
>>> Arm ARM. I noticed that the ones from your spec are slightly different.
>>> This is ok for now, but if we add any new Arm cores that use the same
>>> events this description may get overwritten. For example
>>> ASE_SVE_INST_SPEC in the Arm ARM is currently "Operation speculatively
>> executed, Advanced SIMD or SVE".
>>>
>>> If you have any actual relevant details that are different from the
>>> common string, you should put them in .../arch/arm64/fujitsu/monaka.
>>> But if you are ok with the potential overwrite (which looks like it
>>> should be ok) then you can leave them as is.
>>
>> I think it's okay to overwrite it, but I'll check the specs.
> 
> Regarding this matter, the descriptions of the events added to the common files
> (common-and-microarch.json, recommended.json) will be modified to match Arm ARM.
> Then, we will write current descriptions as "BriefDescription" in .../arch/arm64/fujitsu/monaka.
> We will post this as a v3 patch later.
> 
>>
>>>
>>> [...]
>>>
>>>> diff --git
>>>> a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>>>> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>>>> new file mode 100644
>>>> index 000000000000..80bf17fb8f4c
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>>>> @@ -0,0 +1,8 @@
>>>> +[
>>>> +    {
>>>> +        "ArchStdEvent": "CPU_CYCLES"
>>>> +    },
>>>
>>> Other cores put CPU_CYCLES in bus.json. For user friendlyness I would
>>> put the common ones into the same existing groups. The same issue
>>> applies for some other common events.
>>>
>>
>> I will update as suggested.
> 
> MONAKA's event grouping is based on the grouping of "neoverse n1/n2".
> We found that the groups in "neoverse n1/n2" may differ from those in other cores.
> For example, "CPU_CYCLES" is classified in general.json in "neoverse n1/n2",
> but in bus.json in many other cores.
> 
> As a result, it is not possible to completely match the event groups of other cores.
> We will be checking the current grouping of events and modifying them as much as possible
> to match the other core, and will post this later as a v3 patch.
> 
> Best Regards,
> Yoshihiro Furudera

Hmmm ok, I didn't realize it was already inconsistent. Still it's better 
to try to not introduce a third variant though.



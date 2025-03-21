Return-Path: <linux-kernel+bounces-571957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B12A6C4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50E948262D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C491230BE4;
	Fri, 21 Mar 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eQswZ8i5"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B715D5B6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590633; cv=none; b=cvMxNEVC59VV9qdp4Pnb4zGya867vFmANYrT64c7IgpZB2iP/rqGu2YTTkCSmZh+5wqYromg5PoUTEM9TIlqzg/ZSeOacJdzX2NvsQQssk1Klvwb84W+Dx9RFavO0/Ix/PuUuQ7LJmr9+TVrOYYsGRvewF9UuX4dXBkta7TyprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590633; c=relaxed/simple;
	bh=nawzriq4on1/iaCI5X9SVu5Slxu6nQOPXEWq0FryO9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmntdOx0J1bM/GhTf0xnb3VPWTWDSAIfpVXj1cObX8rFDbKSL8EaAowVmFyRYbi3vnx7DK788oIuZt8TNMemuB5irPM3xraQlw+sVsxSOJiuekQHxFsccI/ayg54VONHwY/Hlj+8elOMjB17wgddQErQlpMp0AT9n5fMZcnElxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eQswZ8i5; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85db7a3da71so171984639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742590631; x=1743195431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9+5tlGWdTjjnvMyRFuoxH5wURyyyxF85+K/XRxuX8I=;
        b=eQswZ8i5d4Q5RDWegcFGBFY+oxUrK/C5S6nj7OEv+W2ZYRJLjeSOPuNU09iwdGT+8k
         v4FV8WovsimW5uSoTeWwg8O4TTj5nIeFg6fyTkWyGJjFaWHxbX6P5D4pfTkIdwjHOjmk
         PYzCIwMpEObJxu1f3ILKcPlqK+vIf+9HdMJx7FQTO4aYUYmj3rIE65CHofvlyo6OY7jM
         IoDxtRzFAeatiZOyo+sGlNBdhOY29gk4poDpxaxu8GgwHjzfOti1ZaWNYGfPs56IQ0sc
         6FW0FcJwZ3oPwsQxDKVpAaqoCzPjhQTlhvLn2KMbB3Bo9KbpNcKY7ko5K9ld3ldOvESq
         1eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590631; x=1743195431;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9+5tlGWdTjjnvMyRFuoxH5wURyyyxF85+K/XRxuX8I=;
        b=wDI1Y53sfUadAyx+QbbiVzZqhMv2kSsv4rjaISv2JR7fWms2UajVhhR2W5zHfgfu3j
         d0jY3z5xDfQvuumEahRzvH84p1BbxER/4kXHFmcoOvn09ATLRtg/lfHbHkLdKnUfzmT+
         JXVra5F+HkdoE9lVSyvOd95ohJR/c2ko6idIxMRYU8E9Ge/lH5lAjUOQhVZOK7MHtNbY
         /mkPR3My+4olXN4jUf8hIkjUnQ+eru4OQctgcOZsBxyTVyYYdAl09LI/mIQOlIOzpXc6
         yeF84xi69FgPvqmD1cSKSkGtcWRCW+Sw93OQ7uistU+tYtuu+UajH2TGdRzFbNSSBELt
         gAFg==
X-Forwarded-Encrypted: i=1; AJvYcCVcdU+UFARbtf1jatBHNnHDd5bv6oSBTvje9/OljdR5eCmmYdfc6mLPFCIHOs8RdpbXhHt+ssi5c3vKTGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7sNF8vba/VLNpQ7byhvMuveR6YY1BKcTFfl03fUAmMUQgJ75f
	+oXsA9yo43vf7UpOW3HmPFtjPN5Vv6+OtCiKl45IUtjVRM2FkbZfRKbDvHpO2wuZeEzQKn653cH
	/
X-Gm-Gg: ASbGnctV8kj44pjQ6sztBjFj7+5DuecLWJgdmkvn6N0r1Enb/oK+x5VeQerG4XGmj5P
	rmOagz8vSyp2S6LdC5m5BVCBTM3ZxjZISPHPDXNbrWw2ORZqqPqzGutjECrfwzFbh2N+k0+4j67
	xiFLuKH/ObHB7PrT+U0biiL6TvaR3OIlkmuANQ+Nh99MAhUHHnAL4H77ekpaEGNVcan4T3puofp
	oUI7XbE4NSyqq8rBC5yfS3HKM0HZ9O/dUW8KefOt7r5Y0QUo2H+EW2Vm+Z89zDRIpWXhHIniYtg
	wqTw9M60lWK1yTKtMc44fL6STcVHib5NAELR13p1FBdySyjZ/0XmXi+wXcuMpw==
X-Google-Smtp-Source: AGHT+IGIhc6f43oVUMs3yKpZ/Qi3MN06te1GZdlnQ8JYifCqR1/BD6VFgf6pM5hzDXs+HJFOuNTjfg==
X-Received: by 2002:a05:6602:4c03:b0:85d:a211:9883 with SMTP id ca18e2360f4ac-85e2cb59528mr567711439f.10.1742590631162;
        Fri, 21 Mar 2025 13:57:11 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdcfef4sm613828173.31.2025.03.21.13.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:57:10 -0700 (PDT)
Message-ID: <7c42afed-e877-4136-a6d6-8ebc9864cc04@sifive.com>
Date: Fri, 21 Mar 2025 15:57:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
To: Atish Patra <atishp@atishpatra.org>
Cc: linux-riscv@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Atish Patra <atishp@rivosinc.com>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
 <Z7ZLB-wZY9wTZSBZ@google.com>
 <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
 <1198d3ac-d715-4f82-853e-bf9d0ad9dde7@sifive.com>
 <CAOnJCUKUY8YQ0UtLa39EkGEjckiOqdnuqEsf2ak4Dcp779iY+Q@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAOnJCUKUY8YQ0UtLa39EkGEjckiOqdnuqEsf2ak4Dcp779iY+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Atish,

On 2025-03-21 1:31 PM, Atish Patra wrote:
> On Fri, Mar 7, 2025 at 1:19 AM Samuel Holland <samuel.holland@sifive.com> wrote:
>> On 2025-03-01 3:21 AM, Atish Patra wrote:
>>> On Wed, Feb 19, 2025 at 1:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>> On Wed, Feb 12, 2025 at 05:21:33PM -0800, Samuel Holland wrote:
>>>>> This series updates the PMU event JSON files to add support for newer
>>>>> SiFive CPUs, including those used in the HiFive Premier P550 board.
>>>>> Since most changes are incremental, symbolic links are used when a set
>>>>> of events is unchanged from the previous CPU series.
>>>>>
>>>>> I originally sent this series about a year ago[1], but received no
>>>>> feedback. The P550 board is now available (and I have tested this series
>>>>> on it), so it would be good to get perf support for it upstream.
>>>>>
>>>>> [1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-samuel.holland@sifive.com/
>>>>>
>>>
>>> Tested the patches that are part of sifive's release tree for p550.
>>> Both perf stat/record seems to work fine
>>> for a bunch of events.
>>>
>>> Based on that
>>> Tested-by: Atish Patra <atishp@rivosinc.com>
>>
>> Thanks for testing!
>>
>>> @Samuel Holland : perf report that the following two events are not
>>> supported on the p550 board.
>>>
>>> cycle and instruction count:
>>>   core_clock_cycles
>>>        [Counts core clock cycles]
>>>   instructions_retired
>>>        [Counts instructions retired]
>>>
>>> I assumed that these are raw events cycle/instruction retired events
>>> that can support
>>> perf sampling as well. Maybe I am missing something ? DT binding ?
>>
>> perf is correct. Those two events are not supported on P550, only by the newer
>> cores (bulled-0d and p650). Yes, those are aliases of cycles and instructions
>> that were added to support sampling.
>>
> 
> Thanks for the confirmation. Are there other events that can be used to sample
> instruction count on P550 ? I did not find anything in the perf list
> or the json file.
> I am not sure if I missed something.

Likely the closest approximation is ORing together the instruction class
retirement events from instruction.json: cpu/r0x3fffe00/. The difference between
that and "instructions" looks to be well within 1% for CPU-intensive workloads.
Maybe it makes sense to add an entry for this combination in the JSON? Would it
be appropriate to call it "instructions_retired"? The same thing could be done
for the older SiFive cores.

Regards,
Samuel



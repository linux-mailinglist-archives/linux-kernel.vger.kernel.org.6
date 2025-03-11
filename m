Return-Path: <linux-kernel+bounces-556273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17642A5C383
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B637A9FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2325CC87;
	Tue, 11 Mar 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZyyy0d4"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011D25CC7C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702413; cv=none; b=qKVG9IcDBNhek75ucOYXPaciZJTXv542IOpDOkOZyrkJEBuN+UUatzaTd0884MYZuiNcaJ0GHgorAWQRaepCB/mXHEa1bVPBr3Z+tE9CwRmPHmdqIeNcQvWaSk6szDVwg50K/tizKkbzhY59E+IHWJNK6wAfd3TvhWTv0ZDHpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702413; c=relaxed/simple;
	bh=ArKux3sa+By8S2kxsGVmvIGfUXIoRTno8CyZ4M/LSco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRgOpR9h/1e/xVZ+eD48ndsmGIyfbmWaQpHTINTt8z6jriAHe4CBvg/PLO8lJ5M3lmhJxZXzQ2uDSPHqRG8SSa9YZuBwzE3EMfZbYvM/4K5o4Wl/hw2J1zQeJVkDUzJofK7LM6m7M/1TnaxOSyphSLp2BhwA/3blPRdnYz+8sX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CZyyy0d4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc148so2667049f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741702410; x=1742307210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Itt67/2JfHkiqaMAIqXre3nmprPzyRAS1yoN5mC4m5A=;
        b=CZyyy0d4WuVMhlY29Z511BPH43AjuMNvb0BXwwJFGn87tvzaxtTmgYwLD2qZCsSxmr
         F7PTjn6k5AgmtVubvOo/7zCbuyZizAKSATtBwMAIFDhNd0Dj9SF6sMwhI4zFrYqBtQPX
         +C8GP1IQefb1twD5P/VdTziaKpJwuw2sBKZ4Lpnj2f9THRKuuiubaAw5KFi+CnyT0Vi5
         oZexv9TKuwheHFAp7yaCs5PsyRB+c4RMYNnH22kx6OTQcEd/ybfXgXNjx4Zxk74Rqptq
         iYbMOnrYZJbdGTKmMsvlbPgRc6DDpdZoDnz75+C2KLvcTpwxwbG4UbNoEAqDE6loH4jP
         MihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702410; x=1742307210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Itt67/2JfHkiqaMAIqXre3nmprPzyRAS1yoN5mC4m5A=;
        b=i6RP7eiZk+q/ThyDOi9dMT4cCochRNQK3M1eLVRMms/x+CsGxCFl2OraKtb49/gpIW
         Sa9x8WkkfOLSKbu0/1YJbCSPQc4dWI+uG19Roe1q49wIjElzDXmerrDKMzYcN5gMoiCf
         s9kqsBLWuTESPyzaVX1ZEYk3zpdqgxEkHfDBRjRp/hsqA99GX+9yDRT3V/wjTV0kLtRr
         fmrT8GA/wDRNcTgjxkHz1M3fBc/FShtTSXENZNJikV5x3+Aj+SFilL2Y5BUxDr4zlVFz
         pM+vKiGLsnGUFVaEN1Rh6tHeXvC1KfvxNpmkeyT7aAxAY1l6Y3k1PBsloBhNHES19ues
         j1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSIbDNVbwtZuOrlXHqO3AdhM7qnPCD9E4oUnFK74sggxwbpm30l8YfinfUHLocnqxK01FewUl8wKnrOrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8X1FmkwDgzgpki6PT9md+4YxOcz2mm+BmUAHBpXTwUu90Q0E
	pzbSoZchgXj/JbJOQWtTiWXiNR/JZJvAq8a9Tmn6+AdzmC8/I4pKXMsqmEM75is=
X-Gm-Gg: ASbGnct2732IPoANu8XK4PPU78T78UKvuZ5OpNtSdL1jX7eY+USef+O7Z41JNYzYRVX
	jQOk7Q0IoDr+qeGz33fxqKV6SHTGhrPuvZcG3rmhaliQ/vc/8c9/Dol0X8a7QkrwJvdCG6JwHbM
	PS0azhTRDmEwSKGaxWSkhyEjg2iEUjEhUqY86U4q6Dz3n9j0un2dUagjiWj9H8X3MxMeoTmimgh
	WWSA2YEHA7/6dxF9dg+GUdKl4uv4oNrNGOosyaDOucI7L92N6D0S6CQRPTDrhN2At7QRP3A/F/a
	AkNNGtRNi+IO9QkoCyBZ2XgOGVftIJmTV+oFp44Hg08JNgSI3p0u
X-Google-Smtp-Source: AGHT+IHls/TUQgoGj46tBQ4rgEriKNzc2+1Ape+0fvCY/GTWqqvwj2dMBh7MeBTYrGXLvD7zhGwqqQ==
X-Received: by 2002:a5d:64eb:0:b0:38f:34a7:ebfb with SMTP id ffacd0b85a97d-3926c883ed3mr4143649f8f.55.1741702409541;
        Tue, 11 Mar 2025 07:13:29 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.65.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e3250sm18368985f8f.61.2025.03.11.07.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:13:29 -0700 (PDT)
Message-ID: <39f7e3ae-d274-4de4-8b8e-bcf1ad6f0932@linaro.org>
Date: Tue, 11 Mar 2025 14:13:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf list: Collapse similar events across PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
 <CAP-5=fX+aSDLMDL3DMNCQ4tDuhaZPv-L6OgfOso3q5wf7anoGg@mail.gmail.com>
 <12da919e-5674-4b12-a51d-ed767cc0b1ac@linaro.org>
 <CAP-5=fWVw499hZ7WM7A+vUmxALX7M-kYXoEehQkv-fh6qHOoOg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWVw499hZ7WM7A+vUmxALX7M-kYXoEehQkv-fh6qHOoOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/03/2025 5:35 pm, Ian Rogers wrote:
> On Fri, Mar 7, 2025 at 6:08 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 05/03/2025 9:40 pm, Ian Rogers wrote:
>>> On Tue, Mar 4, 2025 at 5:50 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> Instead of showing multiple line items with the same event name and
>>>> description, show a single line and concatenate all PMUs that this
>>>> event can belong to.
>>>>
>>>> Don't do it for json output. Machine readable output doesn't need to be
>>>> minimized, and changing the "Unit" field to a list type would break
>>>> backwards compatibility.
>>>>
>>>> Before:
>>>>    $ perf list -v
>>>>    ...
>>>>    br_indirect_spec
>>>>          [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]
>>>>    br_indirect_spec
>>>>          [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a57]
>>>>
>>>> After:
>>>>
>>>>    $ perf list -v
>>>>    ...
>>>>    br_indirect_spec
>>>>          [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,armv8_cortex_a57]
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    tools/perf/builtin-list.c      |  2 ++
>>>>    tools/perf/util/pmus.c         | 75 +++++++++++++++++++++++++++++++++++++-----
>>>>    tools/perf/util/print-events.h |  1 +
>>>>    3 files changed, 70 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>>>> index fed482adb039..aacd7beae2a0 100644
>>>> --- a/tools/perf/builtin-list.c
>>>> +++ b/tools/perf/builtin-list.c
>>>> @@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
>>>>                   .print_event = default_print_event,
>>>>                   .print_metric = default_print_metric,
>>>>                   .skip_duplicate_pmus = default_skip_duplicate_pmus,
>>>> +               .collapse_events = true
>>>
>>> So collapse_events is put in the callbacks but isn't a callback. I
>>> think skipping duplicates and collapsing are the same thing, I'd
>>> prefer it if there weren't two terms for the same thing. If you prefer
>>> collapsing as a name then default_skip_duplicate_pmus can be
>>> default_collapse_pmus.
>>>
>>
>> I can use the existing callback and rename it. That does have the effect
>> of disabling this behavior in verbose mode which may be useful or may be
>> unexpected to some people. But it seems pretty 50/50 so fewer callbacks
>> are probably better.
>>
>>>>           };
>>>>           const char *cputype = NULL;
>>>>           const char *unit_name = NULL;
>>>> @@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
>>>>                           .print_event = json_print_event,
>>>>                           .print_metric = json_print_metric,
>>>>                           .skip_duplicate_pmus = json_skip_duplicate_pmus,
>>>> +                       .collapse_events = false
>>>>                   };
>>>>                   ps = &json_ps;
>>>>           } else {
>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>> index 4d60bac2d2b9..cb1b14ade25b 100644
>>>> --- a/tools/perf/util/pmus.c
>>>> +++ b/tools/perf/util/pmus.c
>>>> @@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const void *b)
>>>>           /* Order by PMU name. */
>>>>           if (as->pmu == bs->pmu)
>>>>                   return 0;
>>>> -       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>>>> +       ret = strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       /* Order by remaining displayed fields for purposes of deduplication later */
>>>> +       ret = strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
>>>> +       if (ret)
>>>> +               return ret;
>>>> +       ret = !!as->deprecated - !!bs->deprecated;
>>>> +       if (ret)
>>>> +               return ret;
>>>> +       ret = strcmp(as->desc ?: "", bs->desc ?: "");
>>>> +       if (ret)
>>>> +               return ret;
>>>> +       return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
>>>>    }
>>>>
>>>> -static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
>>>> +enum dup_type {
>>>> +       UNIQUE,
>>>> +       DUPLICATE,
>>>> +       SAME_TEXT
>>>> +};
>>>> +
>>>> +static enum dup_type pmu_alias_duplicate_type(struct sevent *a, struct sevent *b)
>>>>    {
>>>>           /* Different names -> never duplicates */
>>>>           if (strcmp(a->name ?: "//", b->name ?: "//"))
>>>> -               return false;
>>>> +               return UNIQUE;
>>>> +
>>>> +       /* Duplicate PMU name and event name -> hide completely */
>>>> +       if (strcmp(a->pmu_name, b->pmu_name) == 0)
>>>> +               return DUPLICATE;
>>>> +
>>>> +       /* Any other different display text -> not duplicate */
>>>> +       if (strcmp(a->topic ?: "", b->topic ?: "") ||
>>>> +           strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
>>>> +           a->deprecated != b->deprecated ||
>>>> +           strcmp(a->desc ?: "", b->desc ?: "") ||
>>>> +           strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
>>>> +               return UNIQUE;
>>>> +       }
>>>>
>>>> -       /* Don't remove duplicates for different PMUs */
>>>> -       return strcmp(a->pmu_name, b->pmu_name) == 0;
>>>> +       /* Same display text but different PMU -> collapse */
>>>> +       return SAME_TEXT;
>>>>    }
>>>>
>>>>    struct events_callback_state {
>>>> @@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
>>>>           return 0;
>>>>    }
>>>>
>>>> +static void concat_pmu_names(char *pmu_names, size_t size, const char *a, const char *b)
>>>> +{
>>>> +       size_t len = strlen(pmu_names);
>>>> +       size_t added;
>>>> +
>>>> +       if (len)
>>>> +               added = snprintf(pmu_names + len, size - len, ",%s", b);
>>>> +       else
>>>> +               added = snprintf(pmu_names, size, "%s,%s", a, b);
>>>> +
>>>> +       /* Truncate with ... */
>>>> +       if (added > 0 && added + len >= size)
>>>> +               sprintf(pmu_names + size - 4, "...");
>>>> +}
>>>> +
>>>>    void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
>>>>    {
>>>>           struct perf_pmu *pmu;
>>>> @@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>           struct events_callback_state state;
>>>>           bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
>>>>           struct perf_pmu *(*scan_fn)(struct perf_pmu *);
>>>> +       char pmu_names[128] = {0};
>>>>
>>>>           if (skip_duplicate_pmus)
>>>>                   scan_fn = perf_pmus__scan_skip_duplicates;
>>>> @@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>>>>           qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>>>>           for (int j = 0; j < len; j++) {
>>>>                   /* Skip duplicates */
>>>> -               if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j], &aliases[j + 1]))
>>>> -                       goto free;
>>>> +               if (j < len - 1) {
>>>> +                       enum dup_type dt = pmu_alias_duplicate_type(&aliases[j], &aliases[j + 1]);
>>>> +
>>>> +                       if (dt == DUPLICATE) {
>>>> +                               goto free;
>>>> +                       } else if (print_cb->collapse_events && dt == SAME_TEXT) {
>>>> +                               concat_pmu_names(pmu_names, sizeof(pmu_names),
>>>> +                                                aliases[j].pmu_name, aliases[j+1].pmu_name);
>>>> +                               goto free;
>>>> +                       }
>>>> +               }
>>>
>>> I think a label called 'free' is a little unfortunate given the
>>> function called free.
>>> When I did things with sevent I was bringing over previous `perf list`
>>> code mainly so that the perf list output before and after the changes
>>> was identical. I wonder if this logic would be better placed in the
>>> callback like default_print_event which already maintains state
>>> (last_topic) to optionally print different things. This may better
>>> encapsulate the behavior rather than the logic being in the PMU code.
>>>
>>
>> Yeah I can have a look at putting it in one of the callbacks. But in the
>> end builtin-list.c is the only user of perf_pmus__print_pmu_events()
>> anyway so makes you wonder if the whole thing can be moved to
>> builtin-list and open coded without the callbackyness.
> 
> I wanted to hide some of the innards of pmus, so I think that's the
> reason it is as it is. The whole `sevent` was pre-existing and
> maintained so that the output was the same.
> 

Looking at this a bit more it is possible to move all of 
perf_pmus__print_pmu_events() (including its dependencies and perf list 
specifics) out of pmus.c into print-events.c without exposing any new 
innards of pmus. Only struct pmu_event_info would be used, but that's 
not private and is already used elsewhere.

It's difficult to do this change only in the print_event callback 
because it relies on having the _next_ event, not the previous event. 
We're already tracking last_topic, and if we start passing all the 
next_* items too it gets a bit unmanageable.

If it's all moved then doing display specific processing across the 
whole list becomes quite easy.



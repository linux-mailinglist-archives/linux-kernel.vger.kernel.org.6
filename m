Return-Path: <linux-kernel+bounces-276379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364A9492C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3501B29BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B118D636;
	Tue,  6 Aug 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btFklZkd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982318D631
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953478; cv=none; b=BOvx/7+0brDwcukLB8YhbMNdU94/2DrCBO7ZVEApaKEfVorDKZvY1raCs9ca6x4lJBahah7PLtGe4S5hH3rq16Rz4JLzew3kbJkATneSO/A0ZyvLPIqvNLfminOO+jHk6FIREKMxZ2ABQCyuzksWcL9E0OJN0PJYJFeN5cyz0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953478; c=relaxed/simple;
	bh=KQWbkh77J9/75R/D1B0+2HrtnaU3HpD6PS4GdhfPDhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnrVnijky53A+iPqsOh4geZJ67XZ1c9eFbtyxYRWk0v6nlM2GqGUn05jWQ5Hf416b0GK8ewoUzL4/SoPnmgrFyTxA829zrgPiwVeg+XgsCwSZlJ1BOOgNSlorouFHC2skMBtwaPfdJbuunjD8jo+ovFTXwzRYPyfrmuur6HsLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btFklZkd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722953478; x=1754489478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KQWbkh77J9/75R/D1B0+2HrtnaU3HpD6PS4GdhfPDhU=;
  b=btFklZkdbp0llPGl6k75V4q/8Yl+pcHJ97jxt2pm5KQvxTO98mHFVTd+
   T2YEJAI5131Xsa9/Y7RbvTmG9KnyVhmGDrEHo5eOcjCbbgzHHHk1iJR8i
   BOzw7oyWFXddkXHes47v5lFkmqDZPnFiamygCmpRb+BdmS/Jp3lscYrNb
   NZS+T8YsnYfrt50yRB1Olyqlh9PLfxZp8WLAFPY9WyNsAtSFSvxH+T8fc
   638e7Hjpm9YzygBmjwE95HygjnQPBJmHcYg0tjqDPtGuVBfuSwGTbZd6P
   TSdz3MciUA+wCOmu+aOhbTjEaKepO2mPWeKkQQomGdgmvCE0bYQ6Ciyz0
   A==;
X-CSE-ConnectionGUID: 7nD015KJTYqsGEdHzN8pyg==
X-CSE-MsgGUID: p+xk4W8eRguulQA35VfjmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20787854"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="20787854"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:11:17 -0700
X-CSE-ConnectionGUID: HDwAGLFURV6h7/3gChj9ww==
X-CSE-MsgGUID: tqRVMWETR7OtaWP+Hpm49A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61153055"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:11:15 -0700
Received: from [10.212.84.25] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E4F9620CFED4;
	Tue,  6 Aug 2024 07:11:13 -0700 (PDT)
Message-ID: <01ea531d-9540-47ad-9e18-46eeddc92ff4@linux.intel.com>
Date: Tue, 6 Aug 2024 10:11:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] perf evsel: Assign abbr name for the branch counter
 events
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
 ak@linux.intel.com, eranian@google.com
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-6-kan.liang@linux.intel.com>
 <CAM9d7ciC54X5dth=6uziMS8kKHu=wfZFX8j_et3Gzvgeq3M-cw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7ciC54X5dth=6uziMS8kKHu=wfZFX8j_et3Gzvgeq3M-cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-08-02 8:14 p.m., Namhyung Kim wrote:
> On Wed, Jul 3, 2024 at 1:03 PM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> There could be several branch counter events. If perf tool output the
>> result via the format "event name + a number", the line could be very
>> long and hard to read.
>>
>> An abbreviation is introduced to replace the full event name in the
>> display. The abbreviation starts from 'A' to 'Z9', which can support
>> up to 286 events. The same abbreviation will be assigned if the same
>> events are found in the evlist. The next patch will utilize the
>> abbreviation name to show the branch counter events in the output.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/util/evlist.c | 53 +++++++++++++++++++++++++++++++++++++++-
>>  tools/perf/util/evsel.h  |  4 +++
>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 6f5311d01a14..028169dcb53d 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -33,6 +33,7 @@
>>  #include "util/bpf-filter.h"
>>  #include "util/stat.h"
>>  #include "util/util.h"
>> +#include "util/env.h"
>>  #include <signal.h>
>>  #include <unistd.h>
>>  #include <sched.h>
>> @@ -1262,15 +1263,65 @@ u64 evlist__combined_branch_type(struct evlist *evlist)
>>         return branch_type;
>>  }
>>
>> +static struct evsel *
>> +evlist__find_dup_event_from_prev(struct evlist *evlist, struct evsel *event)
>> +{
>> +       struct evsel *pos;
>> +
>> +       evlist__for_each_entry(evlist, pos) {
>> +               if (event == pos)
>> +                       break;
>> +               if ((pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) &&
>> +                   !strcmp(pos->name, event->name))
>> +                       return pos;
>> +       }
>> +       return NULL;
>> +}
>> +
>> +#define MAX_NR_ABBR_NAME       (26 * 11)
>> +
>> +/*
>> + * The abbr name is from A to Z9. If the number of event
>> + * which requires the branch counter > MAX_NR_ABBR_NAME,
>> + * return NA.
>> + */
>> +static char *evlist__new_abbr_name(void)
>> +{
>> +       static int idx;
>> +       char str[3];
>> +       int i = idx / 26;
>> +
>> +       if (idx >= MAX_NR_ABBR_NAME)
>> +               return strdup("NA");
>> +
>> +       str[0] = 'A' + (idx % 26);
>> +
>> +       if (!i)
>> +               str[1] = '\0';
>> +       else {
>> +               str[1] = '0' + i - 1;
>> +               str[2] = '\0';
>> +       }
>> +
>> +       idx++;
>> +       return strdup(str);
>> +}
>> +
>>  void evlist__update_br_cntr(struct evlist *evlist)
>>  {
>> -       struct evsel *evsel;
>> +       struct evsel *evsel, *dup;
>>         int i = 0;
>>
>>         evlist__for_each_entry(evlist, evsel) {
>>                 if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
>>                         evsel->br_cntr_idx = i++;
>>                         evsel__leader(evsel)->br_cntr_nr++;
>> +
>> +                       dup = evlist__find_dup_event_from_prev(evlist, evsel);
>> +                       if (dup)
>> +                               evsel->abbr_name = strdup(dup->abbr_name);
>> +                       else
>> +                               evsel->abbr_name = evlist__new_abbr_name();
>>                 }
>>         }
>>         evlist->nr_br_cntr = i;
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index a733d3407b35..bf37442002aa 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -152,9 +152,13 @@ struct evsel {
>>          * br_cntr_idx: The idx of the branch counter event in the evlist
>>          * br_cntr_nr:  The number of the branch counter event in the group
>>          *              (Only available for the leader event)
>> +        * abbr_name:   The abbreviation name assigned to an event which is
>> +        *              logged by the branch counter.
>>          */
>>         int                     br_cntr_idx;
>>         int                     br_cntr_nr;
>> +       char                    *abbr_name;
> 
> I think it's better to have an array (of 4 characters?) instead of a
> pointer as it's supposed to be a short string.

Sure. I think 3 characters should be enough, since the abbr name is only
from A to Z9.

Thanks,
Kan
> 
> Thanks,
> Namhyung
> 
>> +
>>         /*
>>          * bpf_counter_ops serves two use cases:
>>          *   1. perf-stat -b          counting events used byBPF programs
>> --
>> 2.38.1
>>
> 


Return-Path: <linux-kernel+bounces-353656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5649930D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09ED7B27645
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91411D88CA;
	Mon,  7 Oct 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+61gw87"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FD1D86D5;
	Mon,  7 Oct 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313944; cv=none; b=DcUbmF2x05Tc1UaFSD+XcaS2YviYFUFJHK/bESgfKVpIhUI1i/21QmZIi5WI9rnG31BZxshNEbL1+zE4pfE25NJVkqD9KOyvRPOEzSKS1vpheYPeUBkYabBVy4a3bhpGcDAYoPtO1fERTcJLobuBsptMZ0XHqjzV6uqUhuuCaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313944; c=relaxed/simple;
	bh=B6fA8GmvooZrPml4opBiwYvSC4vNfeViT79CvNrIeZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKmDaqfOY5bc+FRdKHKhfqcBJ0/6eM3OBRbH4Zdv8uCzGDiCgCVgPV1xdnxwlnRZ0XSMO0WxyZRi+W4ZHatfl94YHGlKbThwh9ZJtZRlIcFVSWZEcHcGk+Nvv0ld3Gp/ulZ2Q5H4/xuHLuwXlB1ygNjY/VMdcJp6ZFLv+zRJdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+61gw87; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313943; x=1759849943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B6fA8GmvooZrPml4opBiwYvSC4vNfeViT79CvNrIeZI=;
  b=F+61gw87RwS+OgGu7SE4hlSdUWerNrdTPyM/5SoL0PZIpowIuMJ8mAlo
   eCS2EELN9K+E0Cgu9ztVkSWmeyKwZdS19bd/tfTOfSfQYcYRFmqC01My7
   ZkJSaZWYkRawFVGPVewhEhiE3a5D51+E4xRFAHuFPKPwJvWrtMtc55gJ7
   kVRsnLeGvEQWIJRt4XAkx1MgpwtU2ZlMOPlBMcMZagBS7I/YxbnlvLofZ
   avqp0MrOHwJIJJ1rTCwF8EYcAOWcaOqv0gQWsmEjJyl5M8Lk1tQHUEvsy
   v6xkbRb3/rsFPGjZk9uTxxNnwkoFzVJJnDYb9g9kTDi907f0Mb00cOVIx
   g==;
X-CSE-ConnectionGUID: 543JZuecTxmVO6ftCxvvsA==
X-CSE-MsgGUID: jjGSrprvTZO64OzDHZ2bxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27408832"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27408832"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:12:22 -0700
X-CSE-ConnectionGUID: opPQXGVVTR6GgpPDiH+fwQ==
X-CSE-MsgGUID: 6zSCTWIDSwef3ycMisIYmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75618081"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:12:14 -0700
Message-ID: <233d7712-b475-4342-9efc-362618e1f3b3@intel.com>
Date: Mon, 7 Oct 2024 18:12:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V11 01/10] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
To: Leo Yan <leo.yan@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240806155514.17900-1-adrian.hunter@intel.com>
 <20240806155514.17900-2-adrian.hunter@intel.com>
 <20241006103947.GA30834@debian-dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241006103947.GA30834@debian-dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 13:39, Leo Yan wrote:
> Hi Adrian,
> 
> Sorry I review this series in very late time and I might bring up
> duplicate questions (though I hope not).

No problem - you are very welcome :-)

> 
> On Tue, Aug 06, 2024 at 06:55:05PM +0300, Adrian Hunter wrote:
>> Hardware traces, such as instruction traces, can produce a vast amount of
>> trace data, so being able to reduce tracing to more specific circumstances
>> can be useful.
>>
>> The ability to pause or resume tracing when another event happens, can do
>> that.
>>
>> Add ability for an event to "pause" or "resume" AUX area tracing.
>>
>> Add aux_pause bit to perf_event_attr to indicate that, if the event
>> happens, the associated AUX area tracing should be paused. Ditto
>> aux_resume. Do not allow aux_pause and aux_resume to be set together.
>>
>> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
>> event that it should start in a "paused" state.
>>
>> Add aux_paused to struct hw_perf_event for AUX area events to keep track of
>> the "paused" state. aux_paused is initialized to aux_start_paused.
>>
>> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
>> callbacks. Call as needed, during __perf_event_output(). Add
>> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
>> handler. Pause/resume in NMI context will miss out if it coincides with
>> another pause/resume.
>>
>> To use aux_pause or aux_resume, an event must be in a group with the AUX
>> area event as the group leader.
>>
>> Example (requires Intel PT and tools patches also):
>>
>>  $ perf record --kcore -e intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/ uname
>>  Linux
>>  [ perf record: Woken up 1 times to write data ]
>>  [ perf record: Captured and wrote 0.043 MB perf.data ]
>>  $ perf script --call-trace
>>  uname   30805 [000] 24001.058782799: name: 0x7ffc9c1865b0
>>  uname   30805 [000] 24001.058784424:  psb offs: 0
>>  uname   30805 [000] 24001.058784424:  cbr: 39 freq: 3904 MHz (139%)
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        debug_smp_processor_id
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        __x64_sys_newuname
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            down_read
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                __cond_resched
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                    in_lock_functions
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_sub
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            up_read
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    in_lock_functions
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                preempt_count_sub
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            _copy_to_user
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])        syscall_exit_to_user_mode
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            syscall_exit_work
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                perf_syscall_exit
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    debug_smp_processor_id
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_trace_buf_alloc
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_get_recursion_context
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            debug_smp_processor_id
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        debug_smp_processor_id
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_tp_event
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_trace_buf_update
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            tracing_gen_ctx_irq_test
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_event
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            __perf_event_account_interrupt
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                __this_cpu_preempt_check
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            perf_event_output_forward
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                perf_event_aux_pause
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                    ring_buffer_get
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_lock
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_unlock
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                    pt_event_stop
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        native_write_msr
>>  uname   30805 [000] 24001.058785463: ([kernel.kallsyms])                                        native_write_msr
>>  uname   30805 [000] 24001.058785639: 0x0
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Acked-by: James Clark <james.clark@arm.com>
>> ---
>>
>>
>> Changes in V11:
>> 	Make assignment to event->hw.aux_paused conditional on
>> 	(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE).
>>
>> Changes in V10:
>> 	Move aux_paused into a union within struct hw_perf_event.
>> 	Additional comment wrt PERF_EF_PAUSE/PERF_EF_RESUME.
>> 	Factor out has_aux_action() as an inline function.
>> 	Use scoped_guard for irqsave.
>> 	Move calls of perf_event_aux_pause() from __perf_event_output()
>> 	to __perf_event_overflow().
>>
>> Changes in V9:
>> 	Move aux_paused to struct hw_perf_event
>>
>> Changes in V6:
>> 	Removed READ/WRITE_ONCE from __perf_event_aux_pause()
>> 	Expanded comment about guarding against NMI
>>
>> Changes in V5:
>> 	Added James' Ack
>>
>> Changes in V4:
>> 	Rename aux_output_cfg -> aux_action
>> 	Reorder aux_action bits from:
>> 		aux_pause, aux_resume, aux_start_paused
>> 	to:
>> 		aux_start_paused, aux_pause, aux_resume
>> 	Fix aux_action bits __u64 -> __u32
>>
>>
>>  include/linux/perf_event.h      | 28 +++++++++++++
>>  include/uapi/linux/perf_event.h | 11 ++++-
>>  kernel/events/core.c            | 72 +++++++++++++++++++++++++++++++--
>>  kernel/events/internal.h        |  1 +
>>  4 files changed, 108 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 6bb0c21d6335..8e508f77f42c 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -170,6 +170,12 @@ struct hw_perf_event {
>>  		};
>>  		struct { /* aux / Intel-PT */
>>  			u64		aux_config;
>> +			/*
>> +			 * For AUX area events, aux_paused cannot be a state
>> +			 * flag because it can be updated asynchronously to
>> +			 * state.
>> +			 */
> 
> I would like to name the events calling AUX pausing and resuming as
> trigger events.
> 
> I am confused for this comment. If I understand correctly, it means
> the field 'aux_paused' will not be updated by AUX event itself.
> Alternatively, this field will be operated by the triggering events.

Yes, by the triggering events.

> 
>> +			unsigned int	aux_paused;
> 
> Combining with the __perf_event_aux_pause() function, should not the
> field 'aux_paused' be defined as atomic type? Especially if we
> consider the SMP concurrency between the triggering events.

Triggering events are in the same group which cannot be scheduled
on more than 1 CPU at the same time.

> 
>>  		};
>>  		struct { /* software */
>>  			struct hrtimer	hrtimer;
>> @@ -294,6 +300,7 @@ struct perf_event_pmu_context;
>>  #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
>>  #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>> +#define PERF_PMU_CAP_AUX_PAUSE			0x0200
>>  
>>  struct perf_output_handle;
>>  
>> @@ -366,6 +373,8 @@ struct pmu {
>>  #define PERF_EF_START	0x01		/* start the counter when adding    */
>>  #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
>>  #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
>> +#define PERF_EF_PAUSE	0x08		/* AUX area event, pause tracing */
>> +#define PERF_EF_RESUME	0x10		/* AUX area event, resume tracing */
>>  
>>  	/*
>>  	 * Adds/Removes a counter to/from the PMU, can be done inside a
>> @@ -405,6 +414,18 @@ struct pmu {
>>  	 *
>>  	 * ->start() with PERF_EF_RELOAD will reprogram the counter
>>  	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
>> +	 *
>> +	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
>> +	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
>> +	 * PERF_EF_RESUME.
>> +	 *
>> +	 * ->start() with PERF_EF_RESUME will start as simply as possible but
>> +	 * only if the counter is not otherwise stopped. Will not overlap
>> +	 * another ->start() with PERF_EF_RESUME nor ->stop() with
>> +	 * PERF_EF_PAUSE.
>> +	 *
>> +	 * Notably, PERF_EF_PAUSE/PERF_EF_RESUME *can* be concurrent with other
>> +	 * ->stop()/->start() invocations, just not itself.
>>  	 */
>>  	void (*start)			(struct perf_event *event, int flags);
>>  	void (*stop)			(struct perf_event *event, int flags);
>> @@ -1660,6 +1681,13 @@ static inline bool has_aux(struct perf_event *event)
>>  	return event->pmu->setup_aux;
>>  }
>>  
>> +static inline bool has_aux_action(struct perf_event *event)
>> +{
>> +	return event->attr.aux_sample_size ||
>> +	       event->attr.aux_pause ||
>> +	       event->attr.aux_resume;
>> +}
>> +
>>  static inline bool is_write_backward(struct perf_event *event)
>>  {
>>  	return !!event->attr.write_backward;
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 4842c36fdf80..0524d541d4e3 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -511,7 +511,16 @@ struct perf_event_attr {
>>  	__u16	sample_max_stack;
>>  	__u16	__reserved_2;
>>  	__u32	aux_sample_size;
>> -	__u32	__reserved_3;
>> +
>> +	union {
>> +		__u32	aux_action;
>> +		struct {
>> +			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
>> +				aux_pause        :  1, /* on overflow, pause AUX area tracing */
>> +				aux_resume       :  1, /* on overflow, resume AUX area tracing */
>> +				__reserved_3     : 29;
>> +		};
>> +	};
>>  
>>  	/*
>>  	 * User provided data if sigtrap=1, passed back to user via
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index aa3450bdc227..e8989db0de18 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2097,7 +2097,7 @@ static void perf_put_aux_event(struct perf_event *event)
>>  
>>  static bool perf_need_aux_event(struct perf_event *event)
>>  {
>> -	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
>> +	return event->attr.aux_output || has_aux_action(event);
>>  }
>>  
>>  static int perf_get_aux_event(struct perf_event *event,
>> @@ -2122,6 +2122,10 @@ static int perf_get_aux_event(struct perf_event *event,
>>  	    !perf_aux_output_match(event, group_leader))
>>  		return 0;
>>  
>> +	if ((event->attr.aux_pause || event->attr.aux_resume) &&
>> +	    !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
>> +		return 0;
>> +
>>  	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
>>  		return 0;
>>  
>> @@ -7904,6 +7908,49 @@ void perf_prepare_header(struct perf_event_header *header,
>>  	WARN_ON_ONCE(header->size & 7);
>>  }
>>  
>> +static void __perf_event_aux_pause(struct perf_event *event, bool pause)
>> +{
>> +	if (pause) {
>> +		if (!event->hw.aux_paused) {
>> +			event->hw.aux_paused = 1;
>> +			event->pmu->stop(event, PERF_EF_PAUSE);
> 
> As mentioned above, we need to assure the atomiticy for "aux_paused".

Cannot be accessed by more than 1 CPU at a time.

> 
>> +		}
>> +	} else {
>> +		if (event->hw.aux_paused) {
>> +			event->hw.aux_paused = 0;
>> +			event->pmu->start(event, PERF_EF_RESUME);
>> +		}
>> +	}
>> +}
>> +
>> +static void perf_event_aux_pause(struct perf_event *event, bool pause)
>> +{
>> +	struct perf_buffer *rb;
>> +
>> +	if (WARN_ON_ONCE(!event))
>> +		return;
>> +
>> +	rb = ring_buffer_get(event);
>> +	if (!rb)
>> +		return;
> 
> Here why we acquire 'rb' pointer'? Seems to me, we should only
> operation on a specific AUX event. Thus in this case, we should store
> the 'aux_in_pause_resume' field into the structure perf_event.

It is following the same paradigm used by AUX Area sampling.
Refer perf_aux_sample_output() calls perf_pmu_snapshot_aux().

> 
>> +
>> +	scoped_guard (irqsave) {
>> +		/*
>> +		 * Guard against self-recursion here. Another event could trip
>> +		 * this same from NMI context.
>> +		 */
>> +		if (READ_ONCE(rb->aux_in_pause_resume))
>> +			break;
> 
> I understand the race condition between normal flow and NMI flow.
> 
> If directly bail out if "aux_in_pause_resume" is true, will it cause
> unpaired issue. E.g. one event invokes AUX_PAUSE, and then another
> event in the NMI context calls AUX_RESUME, because the NMI context
> runs to here and detect the field "aux_in_pause_resume" is true, then
> it directly bail out and has no chance to resume the AUX event.

aux_pause and aux_resume can be on unrelated events that race anyway,
so it up to the user to choose events that make sense.  For example
2 events that are paired anyway like tracepoints at the start and end
of a syscall, or an event that indicates that something has gone
unexpectedly wrong like a breakpoint in an error path.

> 
> If this is the case, it is better to use read_poll_timeout_atomic() ?
> 
> Thanks,
> Leo
> 
>> +
>> +		WRITE_ONCE(rb->aux_in_pause_resume, 1);
>> +		barrier();
>> +		__perf_event_aux_pause(event, pause);
>> +		barrier();
>> +		WRITE_ONCE(rb->aux_in_pause_resume, 0);
>> +	}
>> +	ring_buffer_put(rb);
>> +}
>> +
>>  static __always_inline int
>>  __perf_event_output(struct perf_event *event,
>>  		    struct perf_sample_data *data,
>> @@ -9706,6 +9753,11 @@ static int __perf_event_overflow(struct perf_event *event,
>>  
>>  	ret = __perf_event_account_interrupt(event, throttle);
>>  
>> +	if (event->attr.aux_pause)
>> +		perf_event_aux_pause(event->aux_event, true);
>> +	if (event->attr.aux_resume)
>> +		perf_event_aux_pause(event->aux_event, false);
>> +
>>  	if (event->prog && !bpf_overflow_handler(event, data, regs))
>>  		return ret;
>>  
>> @@ -12083,11 +12135,25 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>>  	}
>>  
>>  	if (event->attr.aux_output &&
>> -	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
>> +	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
>> +	     event->attr.aux_pause || event->attr.aux_resume)) {
>>  		err = -EOPNOTSUPP;
>>  		goto err_pmu;
>>  	}
>>  
>> +	if (event->attr.aux_pause && event->attr.aux_resume) {
>> +		err = -EINVAL;
>> +		goto err_pmu;
>> +	}
>> +
>> +	if (event->attr.aux_start_paused) {
>> +		if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
>> +			err = -EOPNOTSUPP;
>> +			goto err_pmu;
>> +		}
>> +		event->hw.aux_paused = 1;
>> +	}
>> +
>>  	if (cgroup_fd != -1) {
>>  		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
>>  		if (err)
>> @@ -12883,7 +12949,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
>>  	 * Grouping is not supported for kernel events, neither is 'AUX',
>>  	 * make sure the caller's intentions are adjusted.
>>  	 */
>> -	if (attr->aux_output)
>> +	if (attr->aux_output || attr->aux_action)
>>  		return ERR_PTR(-EINVAL);
>>  
>>  	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
>> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
>> index 451514442a1b..001b1cbf6f0e 100644
>> --- a/kernel/events/internal.h
>> +++ b/kernel/events/internal.h
>> @@ -51,6 +51,7 @@ struct perf_buffer {
>>  	void				(*free_aux)(void *);
>>  	refcount_t			aux_refcount;
>>  	int				aux_in_sampling;
>> +	int				aux_in_pause_resume;
>>  	void				**aux_pages;
>>  	void				*aux_priv;
>>  
>> -- 
>> 2.34.1
>>
>>



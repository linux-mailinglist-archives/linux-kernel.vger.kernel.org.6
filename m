Return-Path: <linux-kernel+bounces-575919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF0A708E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C257A476C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD7E15381A;
	Tue, 25 Mar 2025 18:16:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB46FC5;
	Tue, 25 Mar 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926578; cv=none; b=rG1Be0PnReTv6vu4pmOglRxEEQgGYsohcTkjVkkaDWR4ZXjLoQK5HRBMWIvTc8/c6BAeD4vGRScDcuB2Pk3aqogVAQkIaQEFE6eMOWW5BBF7zRurXiH4PSDyUr67Qs2ZEDPzhQMSevYKC2cXJNAhoOVch3xaROlsY7CoDt7dKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926578; c=relaxed/simple;
	bh=O1SdpavdqJlL1CY3aMPSqFOlhjjjFGnjQkLS+wd6LJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNX86DoxDLaZ7soiNOevb4zDOuMGS8dO4z1AgvN5eL2ZcWLyYPmpbzEQnfJ9cVydLDoPqH+CYldjLG/F71fOPNg1qibG4ljO8bUM3sRIEm4v+35QN6cnlpVdBN5ED/VDz2oHPmOfhrQlGUSXUS7wFHE7YowdtAwm6SN44/R2ZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A37E41692;
	Tue, 25 Mar 2025 11:16:17 -0700 (PDT)
Received: from [10.57.85.102] (unknown [10.57.85.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44D6D3F58B;
	Tue, 25 Mar 2025 11:16:10 -0700 (PDT)
Message-ID: <28029bd8-e875-4281-9c2c-d9463a7cce53@arm.com>
Date: Tue, 25 Mar 2025 18:16:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tracing: Rename trace_synth() to synth_event_trace2()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Alice Ryhl <aliceryhl@google.com>
References: <20250318180814.226644-1-douglas.raillard@arm.com>
 <20250318180814.226644-3-douglas.raillard@arm.com>
 <20250319223728.ca7a5ac6fa37798d17bd2e29@kernel.org>
 <3732e7f8-a452-4f65-8e8b-1575c01d33b9@arm.com>
 <20250324152945.e47bc6d1e491658cfc6924fe@kernel.org>
 <9f030639-2ce2-4400-90e4-6c7dfbabf42c@arm.com>
 <20250325122542.02973078@gandalf.local.home>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250325122542.02973078@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25-03-2025 16:25, Steven Rostedt wrote:
> On Tue, 25 Mar 2025 16:05:00 +0000
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>> Yes, the dynamic API was exactly what I needed unfortunately. I'm porting the kernel module we have to Rust (using our own bindings as
>> we cannot mandate CONFIG_RUST=y). While I have some support for C code generation based on the Rust source, it is significantly more
>> convenient to simply use a dynamic API. In the current state of my code, defining an event is as simple as:
>>
>>     let f = new_event! {
>>     	lisa__myevent2,
>>     	fields: {
>>     		field1: u8,
>>     		field3: &CStr,
>>     		field2: u64,
>>     	}
>>     }?;
>>     
>>     // Emit the event
>>     f(1, c"hello", 2);
>>     f(3, c"world", 4);
>>
>> So it's as non-confusing can be: the event name is stated plainly and the field names and types are mentioned once, with no repetition.
>> The result can simply be called to emit the event, and when dropped, the event is unregistered.
> 
> Interesting.
> 
>>
>>
>> On top of that in ways unrelated to Rust:
>> 1. We have some really high traffic event (PELT-related) that include some data that is not always needed (e.g. taskgroup name).
>>      We currently regularly hit memory size limitation on our test device (pixel 6), and using trace-cmd record instead of
>>      trace-cmd start is not always a good idea as this will have an effect on scheduling, disturbing the very thing we are trying
>>      to observe. Having the dynamic API means we could simply omit the fields in the event that we don't care about in a specific
>>      experiment via dynamic configuration.
>>
>> 2. Some events may or may not be supported on the system based on some runtime condition. Currently, there is no great way for
>>      the module to feed back that info. No matter what, the event exists, even if the machinery that is supposed to emit it is
>>      disabled for whatever reason. If some user starts tracing the event "everything will work" and there will be no event in the
>>      trace. That may make the user think a condition did not trigger, whereas in fact the whole machinery was simply not operating.
>>      Being able to register or not the event dynamically solves that cleanly, as enabling the event will simply fail as it won't
>>      have been registered in the first place.
>>
>> 3. We will likely at some point relay events coming from some non-CPU part of the system into the ftrace buffer. If and when that
>>      happens, it would be ideal if that producer can simply declare the events it supports, and our module dynamically create the
>>      matching synthetic events. That would avoid any problem coming from mismatching source that would otherwise plague such setup.
>>
>> So considering things seem to work overall with not much tuning needed, it would be sad to have to revert to TRACE_EVENT() macro
>> and end up having to do more work for a worse result. If that's the route you choose though, it may be nice to amend the
>> documentation to clearly state this API is testing-only and not supported in normal use case, as it currently reads:
>>
>>     The trace event subsystem provides an in-kernel API allowing modules
>>     or other kernel code to generate user-defined 'synthetic' events at
>>     will, which can be used to either augment the existing trace stream
>>     and/or signal that a particular important state has occurred.
> 
> Note, there is also a CUSTOM_TRACE_EVENT() macro that can attach to any
> tracepoint (including those that have a TRACE_EVENT() already attached to
> them) and create a new trace event that shows up into tracefs.
  
I think I came across that at some point indeed. We probably could make use
of it for some of the events we emit, but not all. Also this was introduced
in 2022, but I need to support v5.15 kernels (2021), so maybe one day but not today :(

The event that does not fit this use case is emitted from a workqueue worker that
fires at regular interval to poll for some data. So there is no particular tracepoint
to attach to, we just emit an event from our own code. In the future, we will
probably end up having more of that sort.

> I still do not think "synthetic events" should be used for this purpose.
> They are complex enough with the user interface we shouldn't have them
> created in the kernel. That documentation should be rewritten to not make
> it sound like the kernel or modules can create them.
> 
> That said, it doesn't mean you can't use dynamic events for this purpose.
> Now what exactly is that "new_event!" doing?

That new_event!() macro takes the name and the list of fields and creates two related
things:
1. An EventDesc value that contains the a Vec of the field names and their type.
    Upon creation, this registers the synthetic event and unregisters it when dropped.

2. An associated closure that takes one parameter per field, builds an array out of them,
    and using the captured EventDesc emits the events.

Since the closure captures the EventDesc, the EventDesc cannot be dropped while some code
is able to call the closure, and since the EventDesc is responsible for the lifecycle of
the kernel synthetic event, there is no risk of "use after unregister".

The value returned by the macro is the closure, so it can just be called like a normal
function, but dropping it will also drop the captured EventDesc and unregister the event.

The field types have to implement a FieldTy trait, which exposes both the type name
as expected by the synthetic events API and conversion of a value to u64 for preparing
the array passed to synth_event_trace_array():

   pub trait FieldTy {
       const NAME: &'static str;
       fn to_u64(self) -> u64;
   }

Once the whole thing is shipping, I plan on adding a way to pass a runtime list of fields
to actually enable to new_event!(), so that the event size can be dynamically reduced to
what is needed and save precious MB of RAM in the buffer, e.g.:

   // Coming from some runtime user config, via module parameter or sysfs
   let enabled_fields = vec!["field", "field2"];

   let f = crate::runtime::traceevent::new_event! {
   	lisa__myevent2,
   	fields: {
   		field1: u8,
   		field3: &CStr,
   		field2: u64,
   	},
	enabled_fields,
   }?;

> I guess, what's different to that than a kprobe event? A kprobe event is a
> dynamic trace event in the kernel. Could you do the same with that? Or is
> this adding a nop in the code like a real event would?

Considering we not only need to emit events from existing tracepoints but also just from
our own code (workqueue worker gathering data not obtained via tracepoints), I don't think
kprobe-based solution is best unless I missed some usage of it.
  
> 
> I'm not against rust dynamic events, but I do not think synthetic events
> are the answer. It will just cause more confusion.

Is there some way of creating an event that would not hardcode the detail at compile-time
like the TRACE_EVENT() macro does ? In ways that are not designed to specifically feed a
well-known upstream data source into ftrace like tracepoints or kprobes. Our kernel module
is essentially sitting at the same layer as TRACE_CUSTOM_EVENT() or kprobe events, where
it takes some data source (some of it being from our own module) and feeds it into ftrace.

Maybe what I'm looking for is the dynevent_cmd API ? From the kernel doc:

   Both the synthetic event and k/ret/probe event APIs are built on top of a
   lower-level “dynevent_cmd” event command API, which is also available for more
   specialized applications, or as the basis of other higher-level trace event
   APIs.

I'd rather avoid shipping an out-of-tree reimplementation of synthetic events if possible,
but if that API is public and usable from a module I could live with that as long as it allows
creating "well behaved" events (available in tracefs, enable/disable working,
instances working etc) and is stable enough that the same code can reasonably be expected to work
from v5.15 to now with minor tweaks only.
  
> I also added Alice to the Cc, as she has created trace events for Rust.

Interesting, I could not find anything in the upstream bindings. All there seems to be is
a crude tracepoint binding that only allows emitting a tracepoint already defined in C.
If that's of any interest, I also have code to attach probes to tracepoints dynamically from Rust [1]

My plan B for emitting events is to use the infrastructure I have to include C-based function in the
Rust codebase to sneakily use the TRACE_EVENT() macro like any non-confusing module [2].


[1] The tracepoint probe bindings I have looks like that:

   // Create a probe that increments a captured atomic counter.
   //
   // The new_probe!() macro creates:
   // 1. The closure
   // 2. A probe function that uses the first void* arg to pass the closure pointer
   //    and then calls it
   // 3. A Probe value that ties together both 1. and 2.. This is the value returned
   //    by the macro.
   let x = AtomicUsize::new(0);
   let probe = new_probe!(
	// That dropper is responsible for dropping all the probes attached to it,
	// so that we pay only once for tracepoint_synchronize_unregister() rather
	// than for each probe.
   	&dropper,
         // Essentially a closure, with slightly odd syntax for boring reasons.
   	(preempt: bool, prev: *const c_void, next:* const c_void, prev_state: c_ulong) {
   		let x = x.fetch_add(1, Ordering::SeqCst);
   		crate::runtime::printk::pr_info!("SCHED_SWITCH {x}");
   	}
   );

   // Lookup the tracepoint dynamically. It's unsafe as the lifetime of a
   // struct tracepoint is unknown if defined in a module, 'static otherwise.
   // Also unsafe since the tp signature is not checked, as the lookup is 100% dynamic.
   // I could probably make use of typeof(trace_foobar) function to typecheck that against the
   // C API if the lookup was not dynamic, at the cost of failing to load the module rather than
   // being able to dynamically deal with the failure if the tp does not exist.
   let tp = unsafe {
   	Tracepoint::<(bool, *const c_void, * const c_void, c_ulong)>::lookup("sched_switch").expect("tp not found")
   };

   // Attach the probe to the tracepoint. If the signature does not match, it won't typecheck.
   let registered = tp.register_probe(&probe);

   // When dropped, the RegisteredProbe value detaches the probe from the
   // tracepoint. The probe will only be actually deallocated when its
   // associated dropper is dropped, after which the dropper calls
   // tracepoint_synchronize_unregister().
   drop(registered);


[2] FFI infrastructure to include C code inside the Rust code for bindings writing.
This is a function defined and usable inside the Rust code that has a body written in C:

   [cfunc]
   fn myfunction(param: u64) -> bool {
   	r#"
         // Any C code allowed, we are just before the function
         // definition
   	#include <linux/foo.h>
   	";
   
   	r#"
         // Any C code allowed, we are inside a function here.
   	return call_foo_function(param);
   	";
   }

The r#" "# syntax is just Rust multiline string literals. The optional first literal gets dumped before the function,
the mandatory second one inside, and an optional 3rd one after. The #[cfunc] proc macro takes care of generating the C
prototype matching the Rust one and to wire everything in a way that CFI is happy with. Since the C code is generated
at compile time as a string, any const operation is allowed on it, so I could work my way to a snippet of C that
uses TRACE_EVENT() in the first string literal and calls the trace_* function in the function body.

The C code ends up in a section of the Rust object file that is extracted with objdump in the Makefile and fed back to
Kbuild. That's very convenient to use and avoids splitting away one-liners like that, does not break randomly
like cbindgen on some Rust code I don't control coming from 3rd party crates, and since the module is built at runtime
by the user, it also has the big advantage of not requiring to build cbindgen in the "tepid" path.
  
> -- Steve


Douglas


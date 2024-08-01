Return-Path: <linux-kernel+bounces-271170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F17944A54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DEB23841
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4A189B96;
	Thu,  1 Aug 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nm1nIEPj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68930189B8D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511593; cv=none; b=HRgFUXsLrkT9cU+LdW6kMZI7oPrvOK9q0Vp/T7e6/tnuIT7yQiQjuByzO5aYJK+9k72uUf9LhmCY9ci4aj02ZQre+Sgwt3qoh/rNzHh6NWt4TcXfTsAgSh9gHsCltygoNT0EkY2QpZ/WYVj/diCIfqU1wiTr5QVlNolCtxKOa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511593; c=relaxed/simple;
	bh=Qek14WoIbgclopjgMp6oiP8pH9ROFWMQCydc7apge7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJgIoJEpW/0nabzmC5gV+GFDIGqy28S7NzfDewB/C8PYk6/RoGfrmA3MutJ8/Gk728m1UKcbSqv9v6m/HvVQP2GELfmefOUjD5bsN7K+5Y0+o/MVVltWkxNhPi38rIgUG2L+v/i9gQSH0G+zT6NthNhh38Z57njwmJntoNTAnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nm1nIEPj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-369cb9f086aso3754767f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722511589; x=1723116389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+M2SR/RY5p4TJxiVGH3F4V/gh4EsMPcP8VWO2qKogU=;
        b=Nm1nIEPjbbbI4qfbOFEt48yne+HROTv0KPOiLM1kYGfsK2tUpvNlxFNgEqG8Q+iuxX
         LCVY1+c8ZhPtNsjtcaZa/pmQ/eAIWnWsM9qX9LDgCLH1eEU57p9tZCtcYdFjnMOU8bZ7
         Ku3KLg4Elr0OD4MpHmJ26LFWVoEz/Bjxc6S7aIiXrtmCeyGlYSgEK5h6vTOoYQ3xTVV7
         wRyvB2y06hXu1+J/9ksm79FLs7w37s1B/HXLY2ge6MpE+tz6P7Mt5PPG3mNWgsXc0Hcl
         mjexKt0K9C6HspfPWkqx6EXr8kkxObm70UJJQSEr74NgU82pRYEysn44DA1hbfASJAlb
         aAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722511589; x=1723116389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+M2SR/RY5p4TJxiVGH3F4V/gh4EsMPcP8VWO2qKogU=;
        b=hDV7ilGJG/hHig8TVm7mV+U7w5NmBYeVNNav3AJMhScxp+/lWlT43G1saLPbR1HXZ8
         5cffbBX6qopDcbB8Xq2GLXpluQCXZuNCBAcuXvh2i1uDgrRNDXwWzSuzHNuCpsQ7vlZH
         ADcfPA8TgrNLpkhw2xxaKSOQQTu9t1Q0/sIXkEyNDTVa8fug5Cl8A1kMO96w2wfVB/9n
         k0Myv3hzuwAXkQlFrSAZvJno/gpYAcleJr59SiLFj7leFhJpgsuVZItYVOozuLZ+r106
         Ye//tzgK8K2FP970R/2St4gOIngfXzJNIuUmw4X2OlT3YxSYaBqqC7gnUU6whD11zjpR
         qqAA==
X-Forwarded-Encrypted: i=1; AJvYcCXhJOKXzfjTgtnNC6DpN9cg/6DWXEmxrbg4CIeFWwJr5fU19aAN/GEYUBPC9Enuktvd6Eg0CTylnUpy0IJqA5nax7VJiMigtECfXcuH
X-Gm-Message-State: AOJu0YxKaNTQ5D2txzJ8jhgbzcZjTFsvkkpbJaXMYVDBTlcgBdd1eJVd
	DQlIofuwV+UgRDxKIILhayc109JwsxpDq8WDMiPu5NLd41oQOLcV1zBzDp6yUy8=
X-Google-Smtp-Source: AGHT+IGVhDqxxV96/9i8/7+DVsTlnqqPa4yPL9Mfod4irOHVfq1fPXB+3IUdKbHLPnD+dTfoINukxw==
X-Received: by 2002:a5d:6510:0:b0:367:326b:f257 with SMTP id ffacd0b85a97d-36baace4feamr1663650f8f.33.1722511588335;
        Thu, 01 Aug 2024 04:26:28 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e515fsm19214125f8f.45.2024.08.01.04.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 04:26:27 -0700 (PDT)
Message-ID: <6b273a37-ea34-429e-898d-ff40494ef567@linaro.org>
Date: Thu, 1 Aug 2024 12:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Al Grant <Al.Grant@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Mike Leach <mike.leach@linaro.org>
Cc: "acme@redhat.com" <acme@redhat.com>,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "scclevenger@os.amperecomputing.com" <scclevenger@os.amperecomputing.com>,
 Leo Yan <Leo.Yan@arm.com>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <GV1PR08MB8033F9A11DD9447AF57EF9F386B22@GV1PR08MB8033.eurprd08.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <GV1PR08MB8033F9A11DD9447AF57EF9F386B22@GV1PR08MB8033.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/08/2024 11:28 am, Al Grant wrote:
> 
> 
>> -----Original Message-----
>> From: James Clark <james.clark@linaro.org>
>> Sent: Thursday, August 1, 2024 11:00 AM
>> To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>; Mike Leach
>> <mike.leach@linaro.org>
>> Cc: acme@redhat.com; coresight@lists.linaro.org; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> darren@os.amperecomputing.com; scclevenger@os.amperecomputing.com; Leo
>> Yan <Leo.Yan@arm.com>
>> Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm if
>> address continuity is broken
>>
>>
>>
>> On 24/07/2024 3:45 pm, James Clark wrote:
>>>
>>>
>>> On 24/07/2024 7:38 am, Ganapatrao Kulkarni wrote:
>>>>
>>>>
>>>> On 23-07-2024 09:16 pm, James Clark wrote:
>>>>>
>>>>>
>>>>> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>>>>>
>>>>>>
>>>>>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>>
>>>>>>>> Hi James,
>>>>>>>>
>>>>>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>> To generate the instruction tracing, script uses 2 contiguous
>>>>>>>>>> packets address range. If there a continuity brake due to
>>>>>>>>>> discontiguous branch address, it is required to reset the
>>>>>>>>>> tracing and start tracing with the new set of contiguous
>>>>>>>>>> packets.
>>>>>>>>>>
>>>>>>>>>> Adding change to identify the break and complete the remaining
>>>>>>>>>> tracing of current packets and restart tracing from new set of
>>>>>>>>>> packets, if continuity is established.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Ganapatrao,
>>>>>>>>>
>>>>>>>>> Can you add a before and after example of what's changed to the
>>>>>>>>> commit message? It wasn't immediately obvious to me if this is
>>>>>>>>> adding missing output, or it was correcting the tail end of the
>>>>>>>>> output that was previously wrong.
>>>>>>>>
>>>>>>>> It is adding tail end of the trace as well avoiding the segfault
>>>>>>>> of the perf application. With out this change the perf segfaults
>>>>>>>> with as below log
>>>>>>>>
>>>>>>>>
>>>>>>>> ./perf script
>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d
>>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>>> objdump: error: the stop address should be after the start address
>>>>>>>> Traceback (most recent call last):
>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 271, in
>>>>>>>> process_event
>>>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 105, in
>>>>>>>> print_disam
>>>>>>>>       for line in read_disam(dso_fname, dso_start, start_addr,
>>>>>>>> stop_addr):
>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 99, in
>>>>>>>> read_disam
>>>>>>>>       disasm_output = check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>> check_output
>>>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>>>>>>>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> ^^^^
>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z',
>>>>>>>> '--start-address=0xffff80008125b758',
>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned
>>>>>>>> non-zero exit status 1.
>>>>>>>> Fatal Python error: handler_call_die: problem in Python trace
>>>>>>>> event handler
>>>>>>>> Python runtime state: initialized
>>>>>>>>
>>>>>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>>>>>     <no Python frame>
>>>>>>>>
>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>> systemd._reader, systemd.id128, report._py3report, _dbus_bindings,
>>>>>>>> problem._py3abrt (total: 7)
>>>>>>>> Aborted (core dumped)
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni
>>>>>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>>>>>> ---
>>>>>>>>>>    tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>>>>>>>>>>    1 file changed, 10 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>>>>>            cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>            return
>>>>>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> Do you need to write into the global cpu_data here? Doesn't it
>>>>>>>>> get overwritten after you load it back into 'prev_ip'
>>>>>>>>
>>>>>>>> No, the logic is same as holding the addr of previous packet.
>>>>>>>> Saving the previous packet saved ip in to prev_ip before
>>>>>>>> overwriting with the current packet.
>>>>>>>
>>>>>>> It's not exactly the same logic as holding the addr of the previous
>>>>>>> sample. For addr, we return on the first None, with your change we
>>>>>>> now "pretend" that the second one is also the previous one:
>>>>>>>
>>>>>>>     if (cpu_data.get(str(cpu) + 'addr') == None):
>>>>>>>       cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>       return  <----------------------------sample 0 return
>>>>>>>
>>>>>>>     if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>         cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but no
>>>>>>> return
>>>>>>>
>>>>>>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
>>>>>>
>>>>>> Yes, it is dummy for first packet. Added anticipating that we wont
>>>>>> hit the discontinuity for the first packet itself.
>>>>>>
>>>>>> Can this be changed to more intuitive like below?
>>>>>>
>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> index d973c2baed1c..d49f5090059f 100755
>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>>>>>                   cpu_data[str(cpu) + 'addr'] = addr
>>>>>>                   return
>>>>>>
>>>>>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>>>>>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>>>>>
>>>>>>           if (options.verbose == True):
>>>>>>                   print("Event type: %s" % name)
>>>>>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>>>>>
>>>>>>           # Record for previous sample packet
>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>>>
>>>>>>           # Handle CS_ETM_TRACE_ON packet if start_addr=0 and
>>>>>> stop_addr=4
>>>>>>           if (start_addr == 0 and stop_addr == 4):
>>>>>>                   print("CPU%d: CS_ETM_TRACE_ON packet is inserted" %
>>>>>> cpu)
>>>>>>                   return
>>>>>>
>>>>>> +       if (stop_addr < start_addr and prev_ip != 0):
>>>>>> +               # Continuity of the Packets broken, set start_addr
>>>>>> to previous
>>>>>> +               # packet ip to complete the remaining tracing of the
>>>>>> address range.
>>>>>> +               start_addr = prev_ip
>>>>>> +
>>>>>>           if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>>>>>>                   print("Start address 0x%x is out of range [ 0x%x ..
>>>>>> 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>>>>>>                   return
>>>>>>
>>>>>> Without this patch below is the failure log(with segfault) for
>>>>>> reference.
>>>>>>
>>>>>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e cs_etm// -C 1
>>>>>> dd if=/dev/zero of=/dev/null
>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>>>>>> [root@sut01sys-r214 perf]# ./perf script
>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d
>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>> objdump: error: the stop address should be after the start address
>>>>>> Traceback (most recent call last):
>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 271, in
>>>>>> process_event
>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 105, in
>>>>>> print_disam
>>>>>>       for line in read_disam(dso_fname, dso_start, start_addr,
>>>>>> stop_addr):
>>>>>>
>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 99, in
>>>>>> read_disam
>>>>>>       disasm_output = check_output(disasm).decode('utf-8').split('\n')
>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>> check_output
>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>>>>>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> ^^
>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z',
>>>>>> '--start-address=0xffff80008125b758',
>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned
>>>>>> non-zero exit status 1.
>>>>>> Fatal Python error: handler_call_die: problem in Python trace event
>>>>>> handler
>>>>>> Python runtime state: initialized
>>>>>>
>>>>>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>>>>>     <no Python frame>
>>>>>>
>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>> systemd._reader, systemd.id128, report._py3report, _dbus_bindings,
>>>>>> problem._py3abrt (total: 7)
>>>>>> Aborted (core dumped)
>>>>>>
>>>>>>
>>>>>> dump snippet:
>>>>>> ============
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>           ffff800080313f04:       36100094        tbz     w20, #2,
>>>>>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0, [x21,
>>>>>> #968]
>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> __perf_event_header__init_id+0x54
>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>> event->clock();
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     x29, x30,
>>>>>> [sp, #-16]!
>>>>>>           ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>           ffff80008030cb0c:       97faba67        bl ffff8000801bb4a8
>>>>>> <sched_clock>
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64 return
>>>>>> sched_clock();
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     x29, x30,
>>>>>> [sp, #-32]!
>>>>>>           ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>           ffff8000801bb4b4:       a90153f3        stp     x19, x20,
>>>>>> [sp, #16]
>>>>>>           ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
>>>>>>           ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>>>>>>           ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
>>>>>>           ffff8000801bb4c8:       94427cf8        bl ffff80008125a8a8
>>>>>> <sched_clock_noinstr>
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns =
>>>>>> sched_clock_noinstr();
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     x29, x30,
>>>>>> [sp, #-64]!
>>>>>>           ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>           ffff80008125a8b4:       a90153f3        stp     x19, x20,
>>>>>> [sp, #16]
>>>>>>           ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>           ffff80008125a8bc:       910d0294        add     x20, x20,
>>>>>> #0x340
>>>>>>           ffff80008125a8c0:       a90363f7        stp     x23, x24,
>>>>>> [sp, #48]
>>>>>>           ffff80008125a8c4:       91002297        add     x23, x20, #0x8
>>>>>>           ffff80008125a8c8:       52800518        mov     w24, #0x28
>>>>>>                   // #40
>>>>>>           ffff80008125a8cc:       a9025bf5        stp     x21, x22,
>>>>>> [sp, #32]
>>>>>>           ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>>>>>           ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>>>>>>           ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c
>>>>>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>
>>>>>>
>>>>>> With fix:
>>>>>> =========
>>>>>>
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>           ffff800080313f04:       36100094        tbz     w20, #2,
>>>>>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0, [x21,
>>>>>> #968]
>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> __perf_event_header__init_id+0x54
>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>> event->clock();
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     x29, x30,
>>>>>> [sp, #-16]!
>>>>>>           ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>           ffff80008030cb0c:       97faba67        bl ffff8000801bb4a8
>>>>>> <sched_clock>
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64 return
>>>>>> sched_clock();
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     x29, x30,
>>>>>> [sp, #-32]!
>>>>>>           ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>           ffff8000801bb4b4:       a90153f3        stp     x19, x20,
>>>>>> [sp, #16]
>>>>>>           ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
>>>>>>           ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>>>>>>           ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
>>>>>>           ffff8000801bb4c8:       94427cf8        bl ffff80008125a8a8
>>>>>> <sched_clock_noinstr>
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns =
>>>>>> sched_clock_noinstr();
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     x29, x30,
>>>>>> [sp, #-64]!
>>>>>>           ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>           ffff80008125a8b4:       a90153f3        stp     x19, x20,
>>>>>> [sp, #16]
>>>>>>           ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>           ffff80008125a8bc:       910d0294        add     x20, x20,
>>>>>> #0x340
>>>>>>           ffff80008125a8c0:       a90363f7        stp     x23, x24,
>>>>>> [sp, #48]
>>>>>>           ffff80008125a8c4:       91002297        add     x23, x20, #0x8
>>>>>>           ffff80008125a8c8:       52800518        mov     w24, #0x28
>>>>>>                   // #40
>>>>>>           ffff80008125a8cc:       a9025bf5        stp     x21, x22,
>>>>>> [sp, #32]
>>>>>>           ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>>>>>           ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>>>>>>           ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>
>>>>> It looks like the disassembly now assumes this BLR wasn't taken. We
>>>>> go from ffff80008125a8e4 straight through to ...
>>>>>
>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c
>>>>>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>> Event type: branches
>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720
>>>>>> period: 1 time: 5986372298040 }
>>>>>>           ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>>>>>           ffff80008125a8e8:       f8756ae3        ldr     x3, [x23, x21]
>>>>>
>>>>> ffff80008125a8e4 which is just the previous one +4. Isn't your issue
>>>>> actually a decode issue in Perf itself? Why is there a discontinuity
>>>>> without branch samples being generated where either the source or
>>>>> destination address is 0?
>>>>>
>>>>> What are your record options to create this issue? As I mentioned in
>>>>> the previous reply I haven't been able to reproduce it.
>>>>
>>>> I am using below perf record command.
>>>>
>>>> timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero of=/dev/null
>>>>
>>>
>>> Thanks I managed to reproduce it. I'll take a look to see if I think the
>>> issue is somewhere else.
>>>
>>
>> At least for the failures I encountered, the issue is due to the
>> alternatives runtime instruction patching mechanism. vmlinux ends up
>> being the wrong image to decode with because a load of branches are
>> actually turned into nops.
>>
>> Can you confirm if you use --kcore instead of vmlinux that you still get
>> failures:
>>
>>     sudo perf record -e cs_etm// -C 1 --kcore -o <output-folder.data> -- \
>>       dd if=/dev/zero of=/dev/null
>>
>>      perf script -i <output-folder.data> \
>>       tools/perf/scripts/python/arm-cs-trace-disasm.py -d llvm-objdump \
>>       -k <output-folder.data>/kcore_dir/kcore
>>
>> But I still think bad decode detection should be moved as much as
>> possible into OpenCSD and Perf rather than this script. Otherwise every
>> tool will have to re-implement it, and OpenCSD has a lot more info to
>> make decisions with.
>>
>> One change we can make is to desynchronize when an N atom is an
>> unconditional branch:
> 
> There's a CPU hardware erratum affecting multiple CPU types and
> generations (including Neoverse N1 and V1), where a branch to the
> next instruction will be traced as an N atom regardless of whether it's
> unconditional, taken conditional, indirect etc. This was detected by
> a similar check in one of our other ETM decoders and we root-caused
> it to incorrect ETM implementation.
> 
> The safe check for current silicon is that it's an unconditional branch
> that is direct and whose target is not the next instruction.
> 
> You can't infer that an N atom on an unconditional indirect branch is
> a synchronization error, since it may have actually branched to the
> next instruction, e.g. in a switch-like construction.
> 
> Maybe OpenCSD could make the stricter check (as written below)
> configurable so you could enable it if you knew for sure that the trace
> wasn't affected by this erratum, but that's not a safe default.
> 
> Al
> 
> 

That's good to know. In that case it would be better to exclude branches 
to the next instruction from the check then rather than make it 
configurable. At least for direct branches, that way it "just works".

Indirect looks a bit more complicated because you have to wait for the 
address, but I'm sure it can be done one way or another.

>>
>>    diff --git a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>> b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>> index c557998..3eefd5d 100644
>> --- a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>> +++ b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
>> @@ -1341,6 +1341,14 @@ ocsd_err_t TrcPktDecodeEtmV4I::processAtom(const
>> ocsd_atm_val atom)
>>            //  save recorded next instuction address
>>            ocsd_vaddr_t nextAddr = m_instr_info.instr_addr;
>>
>> +        // must have lost sync if an unconditional branch wasn't taken
>> +        if (atom == ATOM_N && !m_instr_info.is_conditional) {
>> +             m_need_addr = true;
>> +             m_out_elem.addElemType(m_index_curr_pkt,
>> OCSD_GEN_TRC_ELEM_NO_SYNC);
>> +             // wait for next address
>> +             return OCSD_OK;
>> +        }
>> +
>>
>> Another one we can spot is when a new address comes that is before the
>> current decode address (basically the backwards check that you added).
>>
>> There are probably others that can be spotted like an address appearing
>> after a direct branch that doesn't match the branch target.
>>
>> I think at that point, desynchronising should cause the disassembly
>> script to throw away the last bit, rather than force it to be printed as
>> in this patch. As I mentioned above in the thread, it leads to printing
>> disassembly that's implausible and misleading (where an unconditional
>> branch wasn't taken).
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org


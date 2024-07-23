Return-Path: <linux-kernel+bounces-260157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F793A3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F5B1C20CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0C6157480;
	Tue, 23 Jul 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8ygzzTw"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42806154C04
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749603; cv=none; b=HnCLNVJO9NThSSp0q0LEByTkCBfoGJzt2OrJ7buaurx5Jgi5QrzW46f6ZM3HCja+J6qT6hKLmUQjZIhjefC3CbL94RVdjvWhdalyCyn8JEROga3nvzkWbye7nDgb3hvArcrBsJ1niGVI/U3e1BUIyNbrR9YowHgPC2CyMM1fgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749603; c=relaxed/simple;
	bh=jgvY3Gi+p4RNmIMwIMsB7jmP8X/N17yQZWPOVhncUl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLJ9cTGrihyBdNgJnpCyb9cdP6L+xsJjDFeEzh9xNg7S42Rp5qJsS3ShH+wLkzpeHo8zIDRf6AQ8RYfYkJkcHjp8KVoJd8yoACuytIFg+z0QRov69gkaO4q11XHk8SGWcwIKRs17PBHdyOMirqR7juPIZeLSnKiRLHcKU6kEWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p8ygzzTw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so40770925e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721749599; x=1722354399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfTvOrM/WoGKLyPs+9lQs/5iTeQr073tDakrjVBkWzk=;
        b=p8ygzzTwEwl70TggHM3ZyiC8CAjCWOzXIinYRVOoN/dlFL/F1JSTQkfsqYIrH3aU3j
         cBsWFWAHHY9aFv+rDQf+DjRpxHElDwLM3xJA6FzajQKbm8j+PQQOUkPyNjXqwefw9dqd
         UxOBoc1XFScvueQugitcsMFxPBoSKXN4P+BmiLQ9b5KAJc4An5vbW7n6o9t/+6YplT8f
         MKsbwB8J1q5x9EZR0Y41txTpCCFaAIcNcJKRPOASMN9K8NSN10Hv6Yi66kJEItlHZ/he
         9Hjmn9iySdykA1HDbi/6YSVRPto+6kU5dv7DzCMNC8PNLE2ZUngPyQ0ePDZ/7R2sckZY
         vNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721749599; x=1722354399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfTvOrM/WoGKLyPs+9lQs/5iTeQr073tDakrjVBkWzk=;
        b=V6Z6psmitEyBl10hLSjTaPMKx47ieVze93y6nkP40daf2ehX6ro37WTFh60Z2EaWk9
         hh/jQceHYWgnv29atrfhRn2X7h8PgAeMGxvOWKLckORMK0AznczjHUlllqF9ib0sWB/A
         +UbVn7jj3Lch23IpHX7e6PWeYO1toa5xPBLtggG51wCTahhoAr8g0VNf9OIE8Vv0PLNr
         x1ki2ysLzwInuUpatefqfDoVgXHWykLVY/B7o5bywsT95y1N5Z6T7V1jwKo+KnN3Rp9A
         GskL/G3w5bycKa8yXH7yQUoESDTrhOf4pJNUWijl/3MwyI3jkg7V+fvHD9rKfhLu2O9W
         LzTg==
X-Forwarded-Encrypted: i=1; AJvYcCVhMkzSv4/JXV45nTcrACYyO1GwaCkzysgXv6iMUAxc4J6Lug8bG5zAPgS4QdCDe5TEx4B3c7LW2TZcu9ZRFpf+TcWlaDS6brHSdBjJ
X-Gm-Message-State: AOJu0YyECzeFL1/wcBV34l5XiLUnSQRTX2jljAumRM4HS3TlycRiFXAR
	SHzh1FlWJMw+idYK5RC0J7xzzK3f9kZ/OtbAHrwBVs5LImxHW8J11lqHnhDqfVc=
X-Google-Smtp-Source: AGHT+IH/yIO6nxjTk//VLsxou/pALRtIhP+CcS8EfiGVfKN5BNUhiZSv5i+MiMICmuaxV+NiWDal4w==
X-Received: by 2002:a05:600c:a07:b0:426:6416:aa73 with SMTP id 5b1f17b1804b1-427ecfe03fbmr21773395e9.12.1721749599363;
        Tue, 23 Jul 2024 08:46:39 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427ef3f4665sm20930845e9.0.2024.07.23.08.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 08:46:38 -0700 (PDT)
Message-ID: <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
Date: Tue, 23 Jul 2024 16:46:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 james.clark@arm.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
 Leo Yan <leo.yan@arm.com>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
> 
> 
> On 23-07-2024 06:40 pm, James Clark wrote:
>>
>>
>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>
>>> Hi James,
>>>
>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>
>>>>
>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>> To generate the instruction tracing, script uses 2 contiguous packets
>>>>> address range. If there a continuity brake due to discontiguous branch
>>>>> address, it is required to reset the tracing and start tracing with 
>>>>> the
>>>>> new set of contiguous packets.
>>>>>
>>>>> Adding change to identify the break and complete the remaining tracing
>>>>> of current packets and restart tracing from new set of packets, if
>>>>> continuity is established.
>>>>>
>>>>
>>>> Hi Ganapatrao,
>>>>
>>>> Can you add a before and after example of what's changed to the 
>>>> commit message? It wasn't immediately obvious to me if this is 
>>>> adding missing output, or it was correcting the tail end of the 
>>>> output that was previously wrong.
>>>
>>> It is adding tail end of the trace as well avoiding the segfault of 
>>> the perf application. With out this change the perf segfaults with as 
>>> below log
>>>
>>>
>>> ./perf script --script=python:./scripts/python/arm-cs-trace-disasm.py 
>>> -- -d objdump -k ../../vmlinux -v $* > dump
>>> objdump: error: the stop address should be after the start address
>>> Traceback (most recent call last):
>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>>> process_event
>>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>>> print_disam
>>>      for line in read_disam(dso_fname, dso_start, start_addr, 
>>> stop_addr):
>>>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in 
>>> read_disam
>>>      disasm_output = check_output(disasm).decode('utf-8').split('\n')
>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in check_output
>>>      return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>      raise CalledProcessError(retcode, process.args,
>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>>> '--start-address=0xffff80008125b758', 
>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>>> non-zero exit status 1.
>>> Fatal Python error: handler_call_die: problem in Python trace event 
>>> handler
>>> Python runtime state: initialized
>>>
>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>    <no Python frame>
>>>
>>> Extension modules: perf_trace_context, systemd._journal, 
>>> systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
>>> problem._py3abrt (total: 7)
>>> Aborted (core dumped)
>>>
>>>>
>>>>> Signed-off-by: Ganapatrao Kulkarni 
>>>>> <gankulkarni@os.amperecomputing.com>
>>>>> ---
>>>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>>>>>   1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>           return
>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>> +
>>>>
>>>> Do you need to write into the global cpu_data here? Doesn't it get 
>>>> overwritten after you load it back into 'prev_ip'
>>>
>>> No, the logic is same as holding the addr of previous packet.
>>> Saving the previous packet saved ip in to prev_ip before overwriting 
>>> with the current packet.
>>
>> It's not exactly the same logic as holding the addr of the previous 
>> sample. For addr, we return on the first None, with your change we now 
>> "pretend" that the second one is also the previous one:
>>
>>    if (cpu_data.get(str(cpu) + 'addr') == None):
>>      cpu_data[str(cpu) + 'addr'] = addr
>>      return  <----------------------------sample 0 return
>>
>>    if (cpu_data.get(str(cpu) + 'ip') == None):
>>        cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but no return
>>
>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
> 
> Yes, it is dummy for first packet. Added anticipating that we wont hit 
> the discontinuity for the first packet itself.
> 
> Can this be changed to more intuitive like below?
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..d49f5090059f 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -198,6 +198,8 @@ def process_event(param_dict):
>                  cpu_data[str(cpu) + 'addr'] = addr
>                  return
> 
> +       if (cpu_data.get(str(cpu) + 'ip') != None):
> +               prev_ip = cpu_data[str(cpu) + 'ip']
> 
>          if (options.verbose == True):
>                  print("Event type: %s" % name)
> @@ -243,12 +245,18 @@ def process_event(param_dict):
> 
>          # Record for previous sample packet
>          cpu_data[str(cpu) + 'addr'] = addr
> +       cpu_data[str(cpu) + 'ip'] = stop_addr
> 
>          # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>          if (start_addr == 0 and stop_addr == 4):
>                  print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>                  return
> 
> +       if (stop_addr < start_addr and prev_ip != 0):
> +               # Continuity of the Packets broken, set start_addr to 
> previous
> +               # packet ip to complete the remaining tracing of the 
> address range.
> +               start_addr = prev_ip
> +
>          if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>                  print("Start address 0x%x is out of range [ 0x%x .. 
> 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>                  return
> 
> Without this patch below is the failure log(with segfault) for reference.
> 
> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e cs_etm// -C 1 dd 
> if=/dev/zero of=/dev/null
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.087 MB perf.data ]
> [root@sut01sys-r214 perf]# ./perf script 
> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d objdump -k 
> ../../vmlinux -v $* > dump
> objdump: error: the stop address should be after the start address
> Traceback (most recent call last):
>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
> process_event
>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in print_disam
>      for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in read_disam
>      disasm_output = check_output(disasm).decode('utf-8').split('\n')
>                      ^^^^^^^^^^^^^^^^^^^^
>    File "/usr/lib64/python3.12/subprocess.py", line 466, in check_output
>      return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>      raise CalledProcessError(retcode, process.args,
> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
> '--start-address=0xffff80008125b758', 
> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned non-zero 
> exit status 1.
> Fatal Python error: handler_call_die: problem in Python trace event handler
> Python runtime state: initialized
> 
> Current thread 0x0000ffffb90d54e0 (most recent call first):
>    <no Python frame>
> 
> Extension modules: perf_trace_context, systemd._journal, 
> systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
> problem._py3abrt (total: 7)
> Aborted (core dumped)
> 
> 
> dump snippet:
> ============
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>          ffff800080313f04:       36100094        tbz     w20, #2, 
> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>          ffff800080313f08:       f941e6a0        ldr     x0, [x21, #968]
>          ffff800080313f0c:       d63f0000        blr     x0
>              perf 12720/12720 [0001]      5986.372298040 
> __perf_event_header__init_id+0x54 
> .../coresight/linux/kernel/events/core.c  586         return 
> event->clock();
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff80008030cb00 <local_clock>:
>          ffff80008030cb00:       d503233f        paciasp
>          ffff80008030cb04:       a9bf7bfd        stp     x29, x30, [sp, 
> #-16]!
>          ffff80008030cb08:       910003fd        mov     x29, sp
>          ffff80008030cb0c:       97faba67        bl ffff8000801bb4a8 
> <sched_clock>
>              perf 12720/12720 [0001]      5986.372298040 local_clock+0xc 
> ...t/linux/./include/linux/sched/clock.h   64         return sched_clock();
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff8000801bb4a8 <sched_clock>:
>          ffff8000801bb4a8:       d503233f        paciasp
>          ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, [sp, 
> #-32]!
>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>          ffff8000801bb4b4:       a90153f3        stp     x19, x20, [sp, 
> #16]
>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>          ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
>          ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>          ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
>          ffff8000801bb4c8:       94427cf8        bl ffff80008125a8a8 
> <sched_clock_noinstr>
>              perf 12720/12720 [0001]      5986.372298040 
> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105         
> ns = sched_clock_noinstr();
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff80008125a8a8 <sched_clock_noinstr>:
>          ffff80008125a8a8:       d503233f        paciasp
>          ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, [sp, 
> #-64]!
>          ffff80008125a8b0:       910003fd        mov     x29, sp
>          ffff80008125a8b4:       a90153f3        stp     x19, x20, [sp, 
> #16]
>          ffff80008125a8b8:       b000e354        adrp    x20, 
> ffff800082ec3000 <tick_bc_dev+0x140>
>          ffff80008125a8bc:       910d0294        add     x20, x20, #0x340
>          ffff80008125a8c0:       a90363f7        stp     x23, x24, [sp, 
> #48]
>          ffff80008125a8c4:       91002297        add     x23, x20, #0x8
>          ffff80008125a8c8:       52800518        mov     w24, #0x28 
>                  // #40
>          ffff80008125a8cc:       a9025bf5        stp     x21, x22, [sp, 
> #32]
>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>          ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
>          ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>          ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>          ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
>          ffff80008125a8e4:       d63f0000        blr     x0
>              perf 12720/12720 [0001]      5986.372298040 
> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c   
> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
> 
> 
> With fix:
> =========
> 
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>          ffff800080313f04:       36100094        tbz     w20, #2, 
> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>          ffff800080313f08:       f941e6a0        ldr     x0, [x21, #968]
>          ffff800080313f0c:       d63f0000        blr     x0
>              perf 12720/12720 [0001]      5986.372298040 
> __perf_event_header__init_id+0x54 
> .../coresight/linux/kernel/events/core.c  586         return 
> event->clock();
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff80008030cb00 <local_clock>:
>          ffff80008030cb00:       d503233f        paciasp
>          ffff80008030cb04:       a9bf7bfd        stp     x29, x30, [sp, 
> #-16]!
>          ffff80008030cb08:       910003fd        mov     x29, sp
>          ffff80008030cb0c:       97faba67        bl ffff8000801bb4a8 
> <sched_clock>
>              perf 12720/12720 [0001]      5986.372298040 local_clock+0xc 
> ...t/linux/./include/linux/sched/clock.h   64         return sched_clock();
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff8000801bb4a8 <sched_clock>:
>          ffff8000801bb4a8:       d503233f        paciasp
>          ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, [sp, 
> #-32]!
>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>          ffff8000801bb4b4:       a90153f3        stp     x19, x20, [sp, 
> #16]
>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>          ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
>          ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>          ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
>          ffff8000801bb4c8:       94427cf8        bl ffff80008125a8a8 
> <sched_clock_noinstr>
>              perf 12720/12720 [0001]      5986.372298040 
> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105         
> ns = sched_clock_noinstr();
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff80008125a8a8 <sched_clock_noinstr>:
>          ffff80008125a8a8:       d503233f        paciasp
>          ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, [sp, 
> #-64]!
>          ffff80008125a8b0:       910003fd        mov     x29, sp
>          ffff80008125a8b4:       a90153f3        stp     x19, x20, [sp, 
> #16]
>          ffff80008125a8b8:       b000e354        adrp    x20, 
> ffff800082ec3000 <tick_bc_dev+0x140>
>          ffff80008125a8bc:       910d0294        add     x20, x20, #0x340
>          ffff80008125a8c0:       a90363f7        stp     x23, x24, [sp, 
> #48]
>          ffff80008125a8c4:       91002297        add     x23, x20, #0x8
>          ffff80008125a8c8:       52800518        mov     w24, #0x28 
>                  // #40
>          ffff80008125a8cc:       a9025bf5        stp     x21, x22, [sp, 
> #32]
>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>          ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
>          ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>          ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>          ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
>          ffff80008125a8e4:       d63f0000        blr     x0

It looks like the disassembly now assumes this BLR wasn't taken. We go 
from ffff80008125a8e4 straight through to ...

>              perf 12720/12720 [0001]      5986.372298040 
> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c   
> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
> Event type: branches
> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 period: 
> 1 time: 5986372298040 }
>          ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>          ffff80008125a8e8:       f8756ae3        ldr     x3, [x23, x21]

ffff80008125a8e4 which is just the previous one +4. Isn't your issue 
actually a decode issue in Perf itself? Why is there a discontinuity 
without branch samples being generated where either the source or 
destination address is 0?

What are your record options to create this issue? As I mentioned in the 
previous reply I haven't been able to reproduce it.



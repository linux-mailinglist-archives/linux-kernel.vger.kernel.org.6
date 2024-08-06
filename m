Return-Path: <linux-kernel+bounces-276568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D67C94955C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8016A1C22580
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6E39FF3;
	Tue,  6 Aug 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5Vy6+kC"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA33987D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960875; cv=none; b=KWtftPXhMWs5dfpmaeLfO+rqgecEChN3wA8Vwuo7wtfMRdnXZT2HEELN3wT6oQLDNDvY6bmZsKymqQF2rNNmuXrTAqq3gFRCl5+MkYJacJPn+UKbIrIWzvEMZIR/kgG3+j+F7mEbFJRgNIL+KcVveCBEYMFC4sNF7f4ubdGKee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960875; c=relaxed/simple;
	bh=uHD6GZqwbehm2fmaH3ZhtJIrlre6yIeyA5KgY0aJxKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaMC1tl3Y6BPhkyTNGj/vSQFioO/FG80ExmPrAUf9eemZkHJtdtr5N2JNgd0s5/fA2CgejNd3amfJNnCeLjjojXSOb8F7WEsLxnh50miKJDAWYMgQ3Aml86DvWrNnP6pY9O56MWgf4pcp2DLj4vNWCDg7ONW0VchG1/38VFw6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5Vy6+kC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-368712acb8dso457280f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722960870; x=1723565670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwE6hlo0OdlzNWkHWO30iqsenG8a/fCI+3dXYjv6btY=;
        b=D5Vy6+kCmpAXNwsQNMtNSjncjvinwh+LXMAeBSd67ubOXwc4ODo5lc/Xha9NR0ps1v
         7fw54LMjFaT63A+35sqRpvvEjden9aCTxyab8wKaUtZlcS0JAtXaCYTWSwT41mu1hvli
         zNlsV1IhoiHv5iPU/HlVQ4DL3cpbPJXt5AvNiuge7fZsO3TeeXeqhlgP/Ckq/htyMQRf
         czM8BBZMmvZ2Zhq0WJMtGg/BDefjzBqS3OG7998/VQM8Zpe4PjoYhjf4+YbP55dtX0+2
         F8UBxqKro/N+W/o3qKoF4RAtqFS3R6I/RtNnRyW3TZZZOKKmkn08MO3dm6GlvDd2yURk
         YbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960870; x=1723565670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwE6hlo0OdlzNWkHWO30iqsenG8a/fCI+3dXYjv6btY=;
        b=uXH+snINJ7zxWnxBJpP8YmuQUmmi4WcI6e7JyFnKiBZ8eaugpCXyPPB3PijoQmEaWb
         quswe8wSocrO2NPW5cT7yk/8oUrK/mvdcSwI4X4iZW8Yov3oYRbCHSMLVW0sKV5YbDd+
         OHuZsNor15faUEQXiJ1h1GjfI61aVvg0hEr7YM6W3XlLfo1V8LVsJkwArE24t/DoC8f6
         KTICuYauQr+D/uQB2zlexwmgxxqtLHCHU6hf/a088Xmnt6ERqoVyzk3nezw6WPu2ytqM
         vz8fyhgckMglMOTmxbnM7OonS213bdQ0tQYq9yKLCi5sQr5ppw43uwu3hY6KLJipuUi7
         qxNw==
X-Forwarded-Encrypted: i=1; AJvYcCXEoVDJfFJN48LO8USPW41x9yFfSR93+K2vsP5iYfmxPk1OOJV/K6SKnJL6vL3vySt1Lg4Vhcp26oPPzRcKZTsTrRfBj0udeduhRFYy
X-Gm-Message-State: AOJu0YyHd5yDcH0CQ1HGI1ZeGLlMVsQ9q0TL/c2Flf1OOhX6VUF8idZN
	aGoyf5JmwKYrRgM28Unr1chHwUiMlM0zxkfExjkuEJuFcKMrPzAp7kN537wgDoY=
X-Google-Smtp-Source: AGHT+IGRp/zTXB/4vLOQxgOzDBTukuLQUjzrjBWNlMkKRjx12qN54zDl/wKLzYUc3uq74lO/oLwaHA==
X-Received: by 2002:adf:e883:0:b0:368:65ad:529 with SMTP id ffacd0b85a97d-36bbc0e0d0fmr9050651f8f.17.1722960870057;
        Tue, 06 Aug 2024 09:14:30 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06d007sm13397106f8f.90.2024.08.06.09.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:14:29 -0700 (PDT)
Message-ID: <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
Date: Tue, 6 Aug 2024 17:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: scclevenger@os.amperecomputing.com,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Leo Yan <leo.yan@arm.com>, Al.Grant@arm.com,
 Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/08/2024 4:02 pm, Steve Clevenger wrote:
> 
> 
> On 8/6/2024 2:57 AM, James Clark wrote:
>>
>>
>> On 06/08/2024 10:47 am, James Clark wrote:
>>>
>>>
>>> On 06/08/2024 8:02 am, Ganapatrao Kulkarni wrote:
>>>>
>>>>
>>>> On 05-08-2024 07:29 pm, James Clark wrote:
>>>>>
>>>>>
>>>>> On 05/08/2024 1:22 pm, Ganapatrao Kulkarni wrote:
>>>>>>
>>>>>>
>>>>>> On 01-08-2024 03:30 pm, James Clark wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 24/07/2024 3:45 pm, James Clark wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 24/07/2024 7:38 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 23-07-2024 09:16 pm, James Clark wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi James,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>>> To generate the instruction tracing, script uses 2
>>>>>>>>>>>>>>> contiguous packets
>>>>>>>>>>>>>>> address range. If there a continuity brake due to
>>>>>>>>>>>>>>> discontiguous branch
>>>>>>>>>>>>>>> address, it is required to reset the tracing and start
>>>>>>>>>>>>>>> tracing with the
>>>>>>>>>>>>>>> new set of contiguous packets.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Adding change to identify the break and complete the
>>>>>>>>>>>>>>> remaining tracing
>>>>>>>>>>>>>>> of current packets and restart tracing from new set of
>>>>>>>>>>>>>>> packets, if
>>>>>>>>>>>>>>> continuity is established.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi Ganapatrao,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Can you add a before and after example of what's changed to
>>>>>>>>>>>>>> the commit message? It wasn't immediately obvious to me if
>>>>>>>>>>>>>> this is adding missing output, or it was correcting the
>>>>>>>>>>>>>> tail end of the output that was previously wrong.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It is adding tail end of the trace as well avoiding the
>>>>>>>>>>>>> segfault of the perf application. With out this change the
>>>>>>>>>>>>> perf segfaults with as below log
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> ./perf script
>>>>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py --
>>>>>>>>>>>>> -d objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>>>>> address
>>>>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 271,
>>>>>>>>>>>>> in process_event
>>>>>>>>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr,
>>>>>>>>>>>>> stop_addr)
>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 105,
>>>>>>>>>>>>> in print_disam
>>>>>>>>>>>>>       for line in read_disam(dso_fname, dso_start,
>>>>>>>>>>>>> start_addr, stop_addr):
>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 99,
>>>>>>>>>>>>> in read_disam
>>>>>>>>>>>>>       disasm_output =
>>>>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>>>>>>> check_output
>>>>>>>>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>>>>> check=True,
>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python
>>>>>>>>>>>>> trace event handler
>>>>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>>>>
>>>>>>>>>>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>>>>>>>>>>     <no Python frame>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni
>>>>>>>>>>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>    tools/perf/scripts/python/arm-cs-trace-disasm.py | 10
>>>>>>>>>>>>>>> ++++++++++
>>>>>>>>>>>>>>>    1 file changed, 10 insertions(+)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git
>>>>>>>>>>>>>>> a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>>>>>>>>>>            cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>>>            return
>>>>>>>>>>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Do you need to write into the global cpu_data here? Doesn't
>>>>>>>>>>>>>> it get overwritten after you load it back into 'prev_ip'
>>>>>>>>>>>>>
>>>>>>>>>>>>> No, the logic is same as holding the addr of previous packet.
>>>>>>>>>>>>> Saving the previous packet saved ip in to prev_ip before
>>>>>>>>>>>>> overwriting with the current packet.
>>>>>>>>>>>>
>>>>>>>>>>>> It's not exactly the same logic as holding the addr of the
>>>>>>>>>>>> previous sample. For addr, we return on the first None, with
>>>>>>>>>>>> your change we now "pretend" that the second one is also the
>>>>>>>>>>>> previous one:
>>>>>>>>>>>>
>>>>>>>>>>>>     if (cpu_data.get(str(cpu) + 'addr') == None):
>>>>>>>>>>>>       cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>       return  <----------------------------sample 0 return
>>>>>>>>>>>>
>>>>>>>>>>>>     if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>>         cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but
>>>>>>>>>>>> no return
>>>>>>>>>>>>
>>>>>>>>>>>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
>>>>>>>>>>>
>>>>>>>>>>> Yes, it is dummy for first packet. Added anticipating that we
>>>>>>>>>>> wont hit the discontinuity for the first packet itself.
>>>>>>>>>>>
>>>>>>>>>>> Can this be changed to more intuitive like below?
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>> index d973c2baed1c..d49f5090059f 100755
>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>>>>>>>>>>                   cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>                   return
>>>>>>>>>>>
>>>>>>>>>>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>>>>>>>>>>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>>>>>>>>>>
>>>>>>>>>>>           if (options.verbose == True):
>>>>>>>>>>>                   print("Event type: %s" % name)
>>>>>>>>>>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>>>>>>>>>>
>>>>>>>>>>>           # Record for previous sample packet
>>>>>>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>>>>>>>>
>>>>>>>>>>>           # Handle CS_ETM_TRACE_ON packet if start_addr=0 and
>>>>>>>>>>> stop_addr=4
>>>>>>>>>>>           if (start_addr == 0 and stop_addr == 4):
>>>>>>>>>>>                   print("CPU%d: CS_ETM_TRACE_ON packet is
>>>>>>>>>>> inserted" % cpu)
>>>>>>>>>>>                   return
>>>>>>>>>>>
>>>>>>>>>>> +       if (stop_addr < start_addr and prev_ip != 0):
>>>>>>>>>>> +               # Continuity of the Packets broken, set
>>>>>>>>>>> start_addr to previous
>>>>>>>>>>> +               # packet ip to complete the remaining tracing
>>>>>>>>>>> of the address range.
>>>>>>>>>>> +               start_addr = prev_ip
>>>>>>>>>>> +
>>>>>>>>>>>           if (start_addr < int(dso_start) or start_addr >
>>>>>>>>>>> int(dso_end)):
>>>>>>>>>>>                   print("Start address 0x%x is out of range [
>>>>>>>>>>> 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start),
>>>>>>>>>>> int(dso_end), dso))
>>>>>>>>>>>                   return
>>>>>>>>>>>
>>>>>>>>>>> Without this patch below is the failure log(with segfault) for
>>>>>>>>>>> reference.
>>>>>>>>>>>
>>>>>>>>>>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e
>>>>>>>>>>> cs_etm// -C 1 dd if=/dev/zero of=/dev/null
>>>>>>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>>>>>>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>>>>>>>>>>> [root@sut01sys-r214 perf]# ./perf script
>>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d
>>>>>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>>> address
>>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 271,
>>>>>>>>>>> in process_event
>>>>>>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 105,
>>>>>>>>>>> in print_disam
>>>>>>>>>>>       for line in read_disam(dso_fname, dso_start, start_addr,
>>>>>>>>>>> stop_addr):
>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 99, in
>>>>>>>>>>> read_disam
>>>>>>>>>>>       disasm_output =
>>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>>>>> check_output
>>>>>>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>>> check=True,
>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python trace
>>>>>>>>>>> event handler
>>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>>
>>>>>>>>>>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>>>>>>>>>>     <no Python frame>
>>>>>>>>>>>
>>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> dump snippet:
>>>>>>>>>>> ============
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>>           ffff800080313f04:       36100094        tbz     w20,
>>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>>> [x21, #968]
>>>>>>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>>> event->clock();
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     x29,
>>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>>           ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>>>>>>           ffff80008030cb0c:       97faba67        bl
>>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>>> return sched_clock();
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     x29,
>>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>>           ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>>>>>>           ffff8000801bb4b4:       a90153f3        stp     x19,
>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>           ffff8000801bb4b8:       d5384113        mrs     x19,
>>>>>>>>>>> sp_el0
>>>>>>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>           ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>>> w0, #0x1
>>>>>>>>>>>           ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>           ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105
>>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     x29,
>>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>>           ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>>>>>>           ffff80008125a8b4:       a90153f3        stp     x19,
>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>           ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>>           ffff80008125a8bc:       910d0294        add     x20,
>>>>>>>>>>> x20, #0x340
>>>>>>>>>>>           ffff80008125a8c0:       a90363f7        stp     x23,
>>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>>           ffff80008125a8c4:       91002297        add     x23,
>>>>>>>>>>> x20, #0x8
>>>>>>>>>>>           ffff80008125a8c8:       52800518        mov     w24,
>>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>>           ffff80008125a8cc:       a9025bf5        stp     x21,
>>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>>           ffff80008125a8d0:       b9400296        ldr     w22,
>>>>>>>>>>> [x20]
>>>>>>>>>>>           ffff80008125a8d4:       120002d5        and     w21,
>>>>>>>>>>> w22, #0x1
>>>>>>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   x21,
>>>>>>>>>>> w21, w24
>>>>>>>>>>>           ffff80008125a8dc:       8b1502f3        add     x19,
>>>>>>>>>>> x23, x21
>>>>>>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>>> [x19, #24]
>>>>>>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93
>>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> With fix:
>>>>>>>>>>> =========
>>>>>>>>>>>
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>>           ffff800080313f04:       36100094        tbz     w20,
>>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>>> [x21, #968]
>>>>>>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>>> event->clock();
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     x29,
>>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>>           ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>>>>>>>           ffff80008030cb0c:       97faba67        bl
>>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>>> return sched_clock();
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     x29,
>>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>>           ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>>>>>>>           ffff8000801bb4b4:       a90153f3        stp     x19,
>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>           ffff8000801bb4b8:       d5384113        mrs     x19,
>>>>>>>>>>> sp_el0
>>>>>>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>           ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>>> w0, #0x1
>>>>>>>>>>>           ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>           ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105
>>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     x29,
>>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>>           ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>>>>>>>           ffff80008125a8b4:       a90153f3        stp     x19,
>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>           ffff80008125a8b8:       b000e354        adrp    x20,
>>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>>           ffff80008125a8bc:       910d0294        add     x20,
>>>>>>>>>>> x20, #0x340
>>>>>>>>>>>           ffff80008125a8c0:       a90363f7        stp     x23,
>>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>>           ffff80008125a8c4:       91002297        add     x23,
>>>>>>>>>>> x20, #0x8
>>>>>>>>>>>           ffff80008125a8c8:       52800518        mov     w24,
>>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>>           ffff80008125a8cc:       a9025bf5        stp     x21,
>>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>>           ffff80008125a8d0:       b9400296        ldr     w22,
>>>>>>>>>>> [x20]
>>>>>>>>>>>           ffff80008125a8d4:       120002d5        and     w21,
>>>>>>>>>>> w22, #0x1
>>>>>>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   x21,
>>>>>>>>>>> w21, w24
>>>>>>>>>>>           ffff80008125a8dc:       8b1502f3        add     x19,
>>>>>>>>>>> x23, x21
>>>>>>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>>> [x19, #24]
>>>>>>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>>
>>>>>>>>>> It looks like the disassembly now assumes this BLR wasn't
>>>>>>>>>> taken. We go from ffff80008125a8e4 straight through to ...
>>>>>>>>>>
>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93
>>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>>> Event type: branches
>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>           ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>>>>>>>>>>           ffff80008125a8e8:       f8756ae3        ldr     x3,
>>>>>>>>>>> [x23, x21]
>>>>>>>>>>
>>>>>>>>>> ffff80008125a8e4 which is just the previous one +4. Isn't your
>>>>>>>>>> issue actually a decode issue in Perf itself? Why is there a
>>>>>>>>>> discontinuity without branch samples being generated where
>>>>>>>>>> either the source or destination address is 0?
>>>>>>>>>>
>>>>>>>>>> What are your record options to create this issue? As I
>>>>>>>>>> mentioned in the previous reply I haven't been able to
>>>>>>>>>> reproduce it.
>>>>>>>>>
>>>>>>>>> I am using below perf record command.
>>>>>>>>>
>>>>>>>>> timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero
>>>>>>>>> of=/dev/null
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks I managed to reproduce it. I'll take a look to see if I
>>>>>>>> think the issue is somewhere else.
>>>>>>>>
>>>>>>>
>>>>>>> At least for the failures I encountered, the issue is due to the
>>>>>>> alternatives runtime instruction patching mechanism. vmlinux ends
>>>>>>> up being the wrong image to decode with because a load of branches
>>>>>>> are actually turned into nops.
>>>>>>>
>>>>>>> Can you confirm if you use --kcore instead of vmlinux that you
>>>>>>> still get failures:
>>>>>>>
>>>>>>>     sudo perf record -e cs_etm// -C 1 --kcore -o
>>>>>>> <output-folder.data> -- \
>>>>>>>       dd if=/dev/zero of=/dev/null
>>>>>>>
>>>>>>>      perf script -i <output-folder.data> \
>>>>>>>       tools/perf/scripts/python/arm-cs-trace-disasm.py -d
>>>>>>> llvm-objdump \
>>>>>>>       -k <output-folder.data>/kcore_dir/kcore
>>>>>>>
>>>>>>
>>>>>> With below command combination with kcore also the issue is seen,
>>>>>> as reported in this email chain.
>>>>>>
>>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>>> dd if=/dev/zero of=/dev/null
>>>>>>
>>>>>> ./perf script -i kcore/data \
>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- \
>>>>>> -d objdump -k kcore/kcore_dir/kcore
>>>>>>
>>>>>>
>>>>>> However, with below sequence(same as your command) the issue is
>>>>>> *not* seen.
>>>>>>
>>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>>> dd if=/dev/zero of=/dev/null
>>>>>>
>>>>>> ./perf script -i kcore/data ./scripts/python/arm-cs-trace-disasm.py \
>>>>>> -- -d objdump -k kcore/kcore_dir/kcore
>>>>>>
>>>>>> Do you see any issue with the command, which is showing the problem?
>>>>>> Also the output log produced by these both commands is different.
>>>>>>
>>>
>>> BTW are you running this on the target or somewhere else? It's
>>> suspicious that "-i kcore/data" works at all because there is no
>>> kernel image given to Perf. Unless you are running on the target and
>>> then I think it will just open the one from /proc. Or maybe it uses
>>> /boot/vmlinux by default which also wouldn't work.
>>>
>>> Also the difference between "--script=python:" and just giving the
>>> script name is in the parsing of the arguments following " -- ".
>>> Sometimes they're also parsed as Perf arguments (like the -v becomes
>>> perf verbose and -k becomes the Perf vmlinux rather than the script).
>>>
>>> I _think_ you want the " -- " when "--script" is used, and no "--"
>>> when it's not. But there are some other combinations and you'll have
>>> to debug it to compare your two exact scenarios to see why they're
>>> different.
>>>
>>> But ignoring that issue with the argument format, you mentioned you
>>> didn't see the issue any more with one version of --kcore. So I'm
>>> assuming that confirms the issue is just a decode image issue, so we
>>> shouldn't try to patch this script?
>>>
>>
>> Although one change we should make to the script is change the example
>> to use kcore. We can leave in one vmlinux one as an example if kcore
>> isn't available, but add a note that it will fail if any patched code is
>> traced (which is almost always).
> 
> James, you may recall the year old thread
> https://lore.kernel.org/all/ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com.
> I described there an awkward workaround Ampere has used to solve the
> patched code problem. At the time, it sounded like the maintainers were
> interested in getting away from using the python script, mostly for
> speed purposes. I didn't see the discussion go any further.
> 

Oh yes thanks for the reminder. I wasn't thinking about the source code 
lines and debug symbols in this thread. I suppose your merging of kcore 
and vmlinux gives both the correct image and the symbols, but I was only 
focused on the image being correct, so only kcore was enough.

It looks like everything we want to do from your previous thread is in 
addition to the fixes from this one. Even if we auto merge kcore + 
symbols and move the disassembly into Perf, we still want to detect 
decode issues earlier and not have IPs jumping backwards. Whether it's 
the script or Perf doing that the behavior should be the same.

To summarise I think these are the changes to make:

   * Improve bad decode detection in OpenCSD
   * Get the script to auto merge kcore and vmlinux
     * Maybe we could get Perf to do this if both a kcore folder and -k
       vmlinux are used?
   * Improve the performance, either in the script or move more
     functionality into Perf


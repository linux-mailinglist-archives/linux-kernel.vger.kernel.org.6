Return-Path: <linux-kernel+bounces-259989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C816C93A0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262E1B21C72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E8915253F;
	Tue, 23 Jul 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t39UAl7u"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2447150981
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740242; cv=none; b=q9oRRy4NtZt2hB4XjVOjajFWHQxUAhyDzHiQnVosPAR7SaBc+qXqGDpkreE/izqCWh411i8ZqiS5KvBKhzbhBr3Ll+FEvR6GB1zBgbHvCAg5x0p+BxZZk7ZpMEPb90DA3ZIk/2AmYQVCc+n8Rw8lms8KVk2d+/HYu6e73dFdwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740242; c=relaxed/simple;
	bh=Sm3Zu/kkGyojoAGjP82oQQmjLeFSHyHNe6PyqpHkUJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJUijmMjryTyquNJHdEAOWB4oFyrzgNuFuoUlKQ+rDtB9mkekpqLw2SyD9mujM5kXhJkvSuYBALBf3mmYcCkQWzb0v87UvVPnWKvKRyw3tYA7tf1yKIlhsiUPoPc96qdZsVFu+5mWTThbJEkP9JnNj4djnt8U0+SD0wzUZ/Cwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t39UAl7u; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368557c9e93so2919012f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721740239; x=1722345039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmnZGs9h8UXmQiX7cdmDYs2SqUBB+oH005eXrbrPLEE=;
        b=t39UAl7ufPUXXy8IOT5cn7qSgzfk6Z7Cqt9V6e3THq17BnTjAlXAID7eo7gC8hYsRa
         cv29+zp+as1I5A1WSWTf5QFJsxuyU8dq8R977//rb9U0S6QQnTKbtjXxJ+2HbeS0etPz
         kWzxl1RT0mL54ff0WoyC81qusgOEg5gmsbydR0kR0twPUSsryX3d3nwJ+xrO0/1Py6gl
         MuJTbfHoGDCARD6LEuwFzP9MTODdhb5oF2M0fJRktupiNJPeMrkc0vO7BmQqeGZVaA/o
         j+/q/rqgQlF4t77FN2UEl/TVlsIoBeD58HFD+jL2FV+XyeoGj+1HtAW0LnefTyfgpxqB
         pAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740239; x=1722345039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmnZGs9h8UXmQiX7cdmDYs2SqUBB+oH005eXrbrPLEE=;
        b=ezd7hqL1kKgt6E34G1B3mz9igmTZF6d5KxdH5EKt+UeNyad4eHLeiw0EQy0Ax7dqHi
         gXBdzdkc2Eyg3KOof3DKNlgkL+SXbwxNgNiquO+5s01HUq0ikBkE1UwgLUfpuiSVkq6U
         4+s5c/s4ZSCQMY8lBtrNdSRQeY6EzfhX0YfLDlzC0wTKhWorMtBhmfdJ1N6MVAUFLvJI
         X1BMkxkzbjiZNbGdU5d12YdrM2fu8uyPeuWMgekV0FD2bUA3YT74YDffi72Q5tFGu7uk
         DMxbrm+Zaal3vmDosxEH+S/7ofW30RNdeVQNpWspMJIRqCm9G2kPgSYyQUaBsx+hDT0K
         9zmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPjiP1kFmBAIRAOKFBNnA2nfg6JDA0kBLlRIdO/OWc4EiZpVgqS+Df1EV9mfXHnjJDLyDdH0EDmSVgGIiYiImPE9jvuTq/gxhH6SY/
X-Gm-Message-State: AOJu0YxNudAoo/YP+URSmbRaRDpS0SyxYdlgLmwoSt3iOie4s2t+k3vJ
	O0of5f1wEgMiG2url26ycoSjN2sBujePu9OTQIBodHMMUy7aZLaDFFb8B8wcows=
X-Google-Smtp-Source: AGHT+IFEIrDDYHUd5kqrtaL6dqmOmODWqrqO516kkukbC9SSnNU8uiwDiG1oOsLBBFsiEZUmS981QQ==
X-Received: by 2002:a5d:5744:0:b0:368:5b78:c92e with SMTP id ffacd0b85a97d-369bae136c6mr5853601f8f.24.1721740239109;
        Tue, 23 Jul 2024 06:10:39 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6936d62sm168482195e9.42.2024.07.23.06.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:10:38 -0700 (PDT)
Message-ID: <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
Date: Tue, 23 Jul 2024 14:10:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 james.clark@arm.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
 Leo Yan <leo.yan@arm.com>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, scclevenger@os.amperecomputing.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
> 
> Hi James,
> 
> On 19-07-2024 08:09 pm, James Clark wrote:
>>
>>
>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>> To generate the instruction tracing, script uses 2 contiguous packets
>>> address range. If there a continuity brake due to discontiguous branch
>>> address, it is required to reset the tracing and start tracing with the
>>> new set of contiguous packets.
>>>
>>> Adding change to identify the break and complete the remaining tracing
>>> of current packets and restart tracing from new set of packets, if
>>> continuity is established.
>>>
>>
>> Hi Ganapatrao,
>>
>> Can you add a before and after example of what's changed to the commit 
>> message? It wasn't immediately obvious to me if this is adding missing 
>> output, or it was correcting the tail end of the output that was 
>> previously wrong.
> 
> It is adding tail end of the trace as well avoiding the segfault of the 
> perf application. With out this change the perf segfaults with as below log
> 
> 
> ./perf script --script=python:./scripts/python/arm-cs-trace-disasm.py -- 
> -d objdump -k ../../vmlinux -v $* > dump
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
> Current thread 0x0000ffffb05054e0 (most recent call first):
>    <no Python frame>
> 
> Extension modules: perf_trace_context, systemd._journal, 
> systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
> problem._py3abrt (total: 7)
> Aborted (core dumped)
> 
>>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> index d973c2baed1c..ad10cee2c35e 100755
>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>           return
>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>> +
>>
>> Do you need to write into the global cpu_data here? Doesn't it get 
>> overwritten after you load it back into 'prev_ip'
> 
> No, the logic is same as holding the addr of previous packet.
> Saving the previous packet saved ip in to prev_ip before overwriting 
> with the current packet.

It's not exactly the same logic as holding the addr of the previous 
sample. For addr, we return on the first None, with your change we now 
"pretend" that the second one is also the previous one:

   if (cpu_data.get(str(cpu) + 'addr') == None):
	cpu_data[str(cpu) + 'addr'] = addr
	return  <----------------------------sample 0 return

   if (cpu_data.get(str(cpu) + 'ip') == None):
   	cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but no return

Then for sample 1 'prev_ip' is actually now the 'current' IP:

   prev_ip = cpu_data[str(cpu) + 'ip']

This means that prev_ip is sometimes the previous sample's IP only 
sometimes (samples following 1), otherwise it's the current IP. Does 
your fix actually require this bit? Because we already save the 'real' 
previous one:

   cpu_data[str(cpu) + 'ip'] = stop_addr

Also normally we save ip + 4 (stop_addr), where as you save ip. It's not 
clear why there is no need to add the 4?


>>
>>    prev_ip = cpu_data[str(cpu) + 'ip']
>>
>>    ... then ...
>>
>>    # Record for previous sample packet
>>    cpu_data[str(cpu) + 'addr'] = addr
>>    cpu_data[str(cpu) + 'ip'] = stop_addr
>>
>> Would a local variable not accomplish the same thing?
> 
> No, We need global to hold the ip of previous packet.
>>
>>> +    prev_ip = cpu_data[str(cpu) + 'ip']
>>>       if (options.verbose == True):
>>>           print("Event type: %s" % name)
>>> @@ -243,12 +247,18 @@ def process_event(param_dict):
>>>       # Record for previous sample packet
>>>       cpu_data[str(cpu) + 'addr'] = addr
>>> +    cpu_data[str(cpu) + 'ip'] = stop_addr
>>>       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>>>       if (start_addr == 0 and stop_addr == 4):
>>>           print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>>>           return
>>> +    if (stop_addr < start_addr):
>>> +        # Continuity of the Packets broken, set start_addr to previous
>>> +        # packet ip to complete the remaining tracing of the address 
>>> range.

After looking a bit more I'm also not sure why stop_addr < start_addr 
signifies a discontinuity. What if the discontinuity ends up with 
stop_addr > start_addr? There's no reason it can't jump forwards as well 
as backwards.

Can you share the 3 samples from the --verbose output to the script that 
cause the issue?

I see discontinuities as having the branch source (ip) set to 0 which is 
what we do at the start:

    Sample = { cpu: 0000 addr: 0x0000ffffb807adac phys_addr: 
0x0000000000000000 ip: 0x0000000000000000 pid: 28388 }

Then the ending one has the branch target (addr) set to 0:

   Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 
0x0000000000000000 ip: 0x0000ffffb7eee168 pid: 28388 }


And it doesn't hit objdump because of the range check:

  Start address 0x0 is out of range ...

So I don't see any missing disassembly or crashes for this.

>>> +        start_addr = prev_ip
>>> +
>>>       if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>>>           print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] 
>>> for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>>>           return
> 
> Thanks,
> Ganapat


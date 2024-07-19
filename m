Return-Path: <linux-kernel+bounces-257385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B5293794A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641391C20889
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE6383AE;
	Fri, 19 Jul 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhzS8Y+j"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777B1DFC7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400000; cv=none; b=hA/ShfrELhpKWVO9iAhOLBBqCaAIfApkPSrV4lZRB5mvpCKwdfYSFo6fsn9J8lyhKWVA9cZyjnfyU1bj+O4W6u3or7bqCIySP9+xfgmoNTWTtAQ9R9G62anduSBT9s+OTwsstOVeBZsJ9ndtf4L4ZSNAHxYEx9rDfxL+aFtw2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400000; c=relaxed/simple;
	bh=nplFswjdkgHLZ7KdvPhLkEoLF8Yc75WWEc2rB9WYX4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tArCx9MwuZadLEMP/PMVPEPHv0vJgRhvHC9n+juYswPxzIG8F0PSyd+BnMYDcpdb/RGw/Flz78/MoB6S9p3ORDtDJjf4T1QbAnMO/TdjPh8kpAmipgptdMpChAptmp4oiNwqgB+HQjWXQdS+QYhiXx6jVRpKmrPnjOR95VqPlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhzS8Y+j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso12723455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721399997; x=1722004797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1FW/V7pDWxiQ2TYaLUH9gtn/5zuS9XpAkNz2yymyxI=;
        b=bhzS8Y+j2NtzafznrEpP+lPY/JtM/MpptKM9jxD7e10WksW/9gVTpqQq3Nz5vzc0xd
         eFJl1GCrNi+opa84RgriP56+mvwpG2DFT/C5ZOqBjjc4+ViK0IZshnmW2o1ItnbZsUOs
         4PUqv8ZSc36h9Zwz9L2RU05nOegKFZg3xybZSdgNJZ9vgyWkmwPUGVE+X1WDRvNfwLZQ
         fXRdF9FhL7RiBN0OM272eCRiCLwr1v1SaoTG/X4YgL1BU26Y7gIrNygs4D5qojefWmlN
         mLoeEwipe/Nef9+fcBIL4E044qa2p8zXI50JY21xzeWYCvt67wSuuK9Krkg4Khe/SRuY
         hzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399997; x=1722004797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1FW/V7pDWxiQ2TYaLUH9gtn/5zuS9XpAkNz2yymyxI=;
        b=tdkIacVsFYM9b+NiWCi0u4HsHdnsuAKhsgLh9FrrRkdaIqjnihAJFFfUGVnOL6ErsS
         vR53VRbYNuxT2W1jX9y+ng/Cgx6F0ARiyjp0IftmjFE6obBNGpod/awfmlPmX5rfzin+
         +9ILYFFm6irguojKEw++5rg/W4oIk4tibY9EMIDcJJs/aC/blxX1xCMSAWwBRAZE3aIh
         ssi4sGQiNcV8TCk2qfT3Au/hubEvJKI9D9tqTlUxsaSSY+968g5aLyxOYbD2El2CG1aU
         Z4W5QjjRAay+KvVbHU9p0aGTJ+XeTRgPVW/MB4D1QxeWlNn4iPSvuS4ifZXW8LmUarRU
         Sh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs/rFPX3EQeAqEyvzxyDHDuM325MsrbijuH/gfZFAOHdGd21cJ2Wj6GpXN4+mrrS17F7GiItLIQtzKSbAr1/FRBt9JgoiqHU5thl4z
X-Gm-Message-State: AOJu0Yy+IdQIGwFb4A19XH7a2WjG8+oMbw9Y2vTp/Ec/WHhKWeChkr9i
	D0B1epUnq6ydZGDs8uj4ev0Tpo2YN+1/uJkE68rm297OEFQzV1o3smjnXLcRveNhuxb/CJ0aflW
	gojc=
X-Google-Smtp-Source: AGHT+IE3In+JqFkEVwNvElNo9kdVbjvo5k9lB8+QaM+6m56dXxco1vvgKB4IE1JTqCxxdvZ8OFPnSw==
X-Received: by 2002:a05:600c:1d03:b0:426:5f02:7b05 with SMTP id 5b1f17b1804b1-427c2cade52mr61407375e9.2.1721399997129;
        Fri, 19 Jul 2024 07:39:57 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d8fbacc8sm14840355e9.28.2024.07.19.07.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 07:39:56 -0700 (PDT)
Message-ID: <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
Date: Fri, 19 Jul 2024 15:39:55 +0100
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
> To generate the instruction tracing, script uses 2 contiguous packets
> address range. If there a continuity brake due to discontiguous branch
> address, it is required to reset the tracing and start tracing with the
> new set of contiguous packets.
> 
> Adding change to identify the break and complete the remaining tracing
> of current packets and restart tracing from new set of packets, if
> continuity is established.
> 

Hi Ganapatrao,

Can you add a before and after example of what's changed to the commit 
message? It wasn't immediately obvious to me if this is adding missing 
output, or it was correcting the tail end of the output that was 
previously wrong.

> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..ad10cee2c35e 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -198,6 +198,10 @@ def process_event(param_dict):
>   		cpu_data[str(cpu) + 'addr'] = addr
>   		return
>   
> +	if (cpu_data.get(str(cpu) + 'ip') == None):
> +		cpu_data[str(cpu) + 'ip'] = ip
> +

Do you need to write into the global cpu_data here? Doesn't it get 
overwritten after you load it back into 'prev_ip'

   prev_ip = cpu_data[str(cpu) + 'ip']

   ... then ...

   # Record for previous sample packet
   cpu_data[str(cpu) + 'addr'] = addr
   cpu_data[str(cpu) + 'ip'] = stop_addr

Would a local variable not accomplish the same thing?

> +	prev_ip = cpu_data[str(cpu) + 'ip']
>   
>   	if (options.verbose == True):
>   		print("Event type: %s" % name)
> @@ -243,12 +247,18 @@ def process_event(param_dict):
>   
>   	# Record for previous sample packet
>   	cpu_data[str(cpu) + 'addr'] = addr
> +	cpu_data[str(cpu) + 'ip'] = stop_addr
>   
>   	# Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>   	if (start_addr == 0 and stop_addr == 4):
>   		print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>   		return
>   
> +	if (stop_addr < start_addr):
> +		# Continuity of the Packets broken, set start_addr to previous
> +		# packet ip to complete the remaining tracing of the address range.
> +		start_addr = prev_ip
> +
>   	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>   		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>   		return


Return-Path: <linux-kernel+bounces-278294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F031A94AE64
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A539728389B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441813C3C2;
	Wed,  7 Aug 2024 16:48:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521782D05D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049331; cv=none; b=Erj+esyh998HDex0b3OwdFclHws0aNQvOrh22WhPbwqjToe0nS9d8AEe1/Atx/C76yC+9TP9x1f2a/od9Zzcpqy9yuk+Kga29I+FEw/Td5gYgsFnh4WyptrcvOJEFPvDfivH6h/67zL3HyEgXQtZy+H0mpiOaocP10inkIS9VvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049331; c=relaxed/simple;
	bh=Cg4idp8Y8dHiIfUeaJPMIoEe6gjWTzhVsYXnt4MWgH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBOQ4dsa+aDQU9tn3tnoI/XtHHnMh+swnbH2XUgjkGN2HywSkAHbRnznfhJh/QFs5uxK+PmGs+mFts6BEnmZ0rvHy9HQp7brUIzJoSZbZaacR7tkBgBSlkVmUm/LhAF9qWfI5hPZQp/9ujxvzAnpuXgoKeJfRlLQKNf6VoT1KW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAC63FEC;
	Wed,  7 Aug 2024 09:49:12 -0700 (PDT)
Received: from [10.1.27.29] (PF4Q20KV.arm.com [10.1.27.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50AF03F766;
	Wed,  7 Aug 2024 09:48:45 -0700 (PDT)
Message-ID: <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
Date: Wed, 7 Aug 2024 17:48:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
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
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

On 8/7/2024 3:53 PM, James Clark wrote:

A minor suggestion: if the discussion is too long, please delete the
irrelevant message ;)

[...]

>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -257,6 +257,11 @@ def process_event(param_dict):
>>                  print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>                  return
>>
>> +       if (stop_addr < start_addr):
>> +               if (options.verbose == True):
>> +                       print("Packet Dropped, Discontinuity detected
>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
>> dso))
>> +               return
>> +
> 
> I suppose my only concern with this is that it hides real errors and
> Perf shouldn't be outputting samples that go backwards. Considering that
> fixing this in OpenCSD and Perf has a much wider benefit I think that
> should be the ultimate goal. I'm putting this on my todo list for now
> (including Steve's merging idea).

In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:

   case CS_ETM_DISCONTINUITY:
        /*
         * The trace is discontinuous, if the previous packet is
         * instruction packet, set flag PERF_IP_FLAG_TRACE_END
         * for previous packet.
         */
        if (prev_packet->sample_type == CS_ETM_RANGE)
                prev_packet->flags |= PERF_IP_FLAG_BRANCH |
                                      PERF_IP_FLAG_TRACE_END;

I am wandering if OpenCSD has passed the correct info so Perf decoder can
detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
be set (it is a general flag in branch sample), then we can consider use it in
the python script to handle discontinuous data.

> 
> But in the mean time what about having a force option?
> 
>> +       if (stop_addr < start_addr):
>> +               if (options.verbose == True or not options.force):
>> +                       print("Packet Dropped, Discontinuity detected
>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
>> dso))
>> +               if (not options.force):
>> +                       return

If the stop address is less than the start address, it must be something
wrong. In this case, we can report a warning for discontinuity and directly
return (also need to save the `addr` into global variable for next parsing).

I prefer to not add force option for this case - eventually, this will consume
much time for reporting this kind of failure and need to root causing it. A
better way is we just print out the reasoning in the log and continue to dump.

Thanks,
Leo


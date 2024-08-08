Return-Path: <linux-kernel+bounces-279032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4055794B818
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0661F2210B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E51891A5;
	Thu,  8 Aug 2024 07:42:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B26188CB6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102950; cv=none; b=mmYptuCHDgm7WK2QgH3v/XeVtMXRjsUUEmUcotOOpFXTIL2Kx8j02wsKLtvQoQ0aJIhQtZv06PyEhqo9Hzdq8wG9oXbmO59wgp9ygqppzgwWoQEscjzE3MIsU12rAXwu6q8Gv3nt/BI43riu2pQMDhUeiuE+DFkE2I2etVdR0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102950; c=relaxed/simple;
	bh=kDn7biSlM0cKDBjevp2RwUhW0P0Nid2uD0ChY9zvU4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMdrXmmlPDEoTNvr5WGszctqEzFnuLae3z9MyVtD1iR8Ok+/p6hzjhpQ0Udp3W7IjXwE+ucj5XoxlHynlDHwiN54iKmjf2WIq2tQJ/JYhWVG8WSfKd/PLMwjwFZiH3ZDF/WVXyL1LKt+kioXimQnpwRvVORc7XAY+6gPqL8tbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ADE7FEC;
	Thu,  8 Aug 2024 00:42:47 -0700 (PDT)
Received: from [10.1.36.15] (PF4Q20KV.arm.com [10.1.36.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ED1B3F71E;
	Thu,  8 Aug 2024 00:42:18 -0700 (PDT)
Message-ID: <d34d402c-7765-41be-8a7c-b9d564c5bedb@arm.com>
Date: Thu, 8 Aug 2024 08:42:14 +0100
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
 James Clark <james.clark@linaro.org>, scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
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
 <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
 <d3c86965-090b-41c5-85a9-187704754072@arm.com>
 <915fefb2-b0bc-4306-83ec-22570719e8e4@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <915fefb2-b0bc-4306-83ec-22570719e8e4@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/8/2024 5:36 AM, Ganapatrao Kulkarni wrote:
> 
> On 08-08-2024 12:50 am, Leo Yan wrote:
>> On 8/7/2024 5:18 PM, Ganapatrao Kulkarni wrote:
>>
>>> Is below diff with force option looks good?
>>>
>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> index d973c2baed1c..efe34f308beb 100755
>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> @@ -36,7 +36,10 @@ option_list = [
>>>                      help="Set path to objdump executable file"),
>>>          make_option("-v", "--verbose", dest="verbose",
>>>                      action="store_true", default=False,
>>> -                   help="Enable debugging log")
>>> +                   help="Enable debugging log"),
>>> +       make_option("-f", "--force", dest="force",
>>> +                   action="store_true", default=False,
>>> +                   help="Force decoder to continue")
>>>   ]
>>>
>>>   parser = OptionParser(option_list=option_list)
>>> @@ -257,6 +260,12 @@ def process_event(param_dict):
>>>                  print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>>                  return
>>>
>>> +       if (stop_addr < start_addr):
>>> +               if (options.verbose == True or options.force):
>>> +                       print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
>>> +               if (options.force):
>>> +                       return
>>
>> I struggled a bit for the code - it is confused that force mode bails out
>> and the non-force mode continues to run. I prefer to always bail out for
>> the discontinuity case, as it is pointless to continue in this case.
> 
> Kept bail out with force option since I though it is not good to hide
> the error in normal use, otherwise we never able to notice this error in
> the future and it becomes default hidden. Eventually this error should
> be fixed.

As James said, the issue should be fixed in OpenCSD or Perf decoding flow.

Thus, perf tool should be tolerant errors - report warning and drop
discontinuous samples. This would be easier for developers later if face
the same issue, they don't need to spend time to locate issue and struggle
for overriding the error.

If you prefer to use force option, it might be better to give reasoning and
*suggestion* in one go, something like:

    if (stop_addr < start_addr):
       print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
       print("Use option '-f' following the script for force mode"
       if (options.force)
           return

Either way is fine for me. Thanks a lot for taking time on the issue.

Leo
 
> Having said that, It is also seems OK to avoid the error with the
> warning message as you suggested.
> 
>>
>>            if (stop_addr <= start_addr):
>>                print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % \
>>                      (stop_addr, start_addr, dso))
>>                return
>>
> 
> Thanks,
> Ganapat


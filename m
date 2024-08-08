Return-Path: <linux-kernel+bounces-279329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C67694BBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1273F282460
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143318B467;
	Thu,  8 Aug 2024 11:05:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06615444E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115141; cv=none; b=uylkK+N9jEbqLwBfSoGh6jqzAoxr5bjhkDFVpM9tn6cTBkzZpfOlBTWZMNX+c+Mu6sDlQ4dWkdqPvboQBugWQxCcVe8boDdYnnRdD8Zj8etmqr4K4crrTlKr1RSjgj/ig+R3HWGhF8dRhUzP8Mw8J7wdzNPr2UB1rChXcXRHtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115141; c=relaxed/simple;
	bh=s2RYLFncmG2WYX+igiLHT0dpOe3piCqggTFe9UKhRtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9rvN/J85Zz1TkRQ74mq8IP4hyw8lXAtgim6wUJCx66nMaSO+ZNeNUDxhZqkq3yYn3LSzmjg1jGAPQaMm833Po5wuT+MBVBUuqex9zHp0qylzS7V1VRUvPSl7pGhPUYVmGsn39uRJcFFKWcEfTQuBE+p+jenp3cDvAECw7MV5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55CAFEC;
	Thu,  8 Aug 2024 04:06:03 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 691233F71E;
	Thu,  8 Aug 2024 04:05:36 -0700 (PDT)
Message-ID: <7c79c6cf-b07a-468a-9263-ea23d5fe12ee@arm.com>
Date: Thu, 8 Aug 2024 12:05:34 +0100
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
 <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/24 10:32, James Clark wrote:

[...]

>>> I suppose my only concern with this is that it hides real errors and
>>> Perf shouldn't be outputting samples that go backwards. Considering that
>>> fixing this in OpenCSD and Perf has a much wider benefit I think that
>>> should be the ultimate goal. I'm putting this on my todo list for now
>>> (including Steve's merging idea).
>>
>> In the perf's util/cs-etm.c file, it handles DISCONTINUITY with:
>>
>>     case CS_ETM_DISCONTINUITY:
>>          /*
>>           * The trace is discontinuous, if the previous packet is
>>           * instruction packet, set flag PERF_IP_FLAG_TRACE_END
>>           * for previous packet.
>>           */
>>          if (prev_packet->sample_type == CS_ETM_RANGE)
>>                  prev_packet->flags |= PERF_IP_FLAG_BRANCH |
>>                                        PERF_IP_FLAG_TRACE_END;
>>
>> I am wandering if OpenCSD has passed the correct info so Perf decoder can
>> detect the discontinuity. If yes, then the flag 'PERF_IP_FLAG_TRACE_END' will
>> be set (it is a general flag in branch sample), then we can consider use it in
>> the python script to handle discontinuous data.
> 
> No OpenCSD isn't passing the correct info here. Higher up in the thread
> I suggested an OpenCSD patch that makes it detect the error earlier and
> fixes the issue. It also needs to output a discontinuity when the
> address goes backwards. So two fixes and then the script works without
> modifications.

Great! Just remind, with the fixes above, we might still need to enhance the
script to consume the PERF_IP_FLAG_TRACE_END flag, this can allow the script
to be reliable.

[...]
  
>> I prefer to not add force option for this case - eventually, this will consume
>> much time for reporting this kind of failure and need to root causing it. A
>> better way is we just print out the reasoning in the log and continue to dump.
> 
> But in this case we've identified all the known issues that would cause
> the script to fail and we can fix them in Perf and OpenCSD. There may
> not even be any more issues that will cause the script to fail in the
> future so there's no point in softening the error IMO. That will only
> hide future issues (of which there may be none) and make root causing
> harder when it hits some other tool.

It is fine for me - with friendly logs as discussed in other replies.

Thanks,
Leo


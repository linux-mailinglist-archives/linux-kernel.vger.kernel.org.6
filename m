Return-Path: <linux-kernel+bounces-181139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F08C7802
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165A11C221A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97DF148830;
	Thu, 16 May 2024 13:56:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F34206C;
	Thu, 16 May 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867787; cv=none; b=asNcqzG3+OboJaHZg/tiWFFGtdV9VP90qI/AVo3V1VMLZwYTzoGd+uwZ0mdu1kqQXo424sMWkmSZXABSfrsKLWn7g4Bc1uKj1HOTX9H65lHeFuespm3uQg5rfWJfoa9oDgkLnXXDmotM45UMIKpe8YOK5YWbYBabDXap7bP5CNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867787; c=relaxed/simple;
	bh=ufVV9p+KR5KWRUPFyPw4/PLj0QNqQJpk5Penf19fI4E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KSIi/8BkNDsuWh5rMnnuQ/szgxX42CWqI5eIRIsET2TVuOqCAhtEadBSBZFCzRPCHqGe7XZi+o0q57CDoYJ9Qjwu/i/knA0/RruV1OhJHeHcBglZpdh/Z9OyaTHYv/yGGjITY2LQP82erYgf/RtGr610ek2eGXMkTroVyo4EUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82BEDDA7;
	Thu, 16 May 2024 06:56:48 -0700 (PDT)
Received: from [10.91.2.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E147D3F7A6;
	Thu, 16 May 2024 06:56:21 -0700 (PDT)
Message-ID: <e5469460-209b-44f2-8b3a-1e67539e281b@arm.com>
Date: Thu, 16 May 2024 15:56:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] coresight: Add reserve trace id support
From: James Clark <james.clark@arm.com>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, songchai <quic_songchai@quicinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20240516025644.4383-1-quic_jinlmao@quicinc.com>
 <20240516025644.4383-3-quic_jinlmao@quicinc.com>
 <34e8c1b9-e351-46c9-abbc-2cef9d0a71db@arm.com>
Content-Language: en-US
In-Reply-To: <34e8c1b9-e351-46c9-abbc-2cef9d0a71db@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/05/2024 15:23, James Clark wrote:
> 
> 
> On 16/05/2024 04:56, Mao Jinlong wrote:
>> Dynamic trace id was introduced in coresight subsystem so trace id is
>> allocated dynamically. However, some hardware ATB source has static trace
>> id and it cannot be changed via software programming. Reserve trace id
>> for this kind of hardware source.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>  .../hwtracing/coresight/coresight-platform.c  | 26 +++++++++++++++++++
>>  .../hwtracing/coresight/coresight-trace-id.c  | 24 +++++++++++++++++
>>  .../hwtracing/coresight/coresight-trace-id.h  | 11 ++++++++
>>  include/linux/coresight.h                     |  1 +
>>  4 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 9d550f5697fa..d3e22a2608df 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -183,6 +183,17 @@ static int of_coresight_get_cpu(struct device *dev)
>>  	return cpu;
>>  }
>>  
>> +/*
>> + * of_coresight_get_trace_id: Get the atid of a source device.
>> + *
>> + * Returns 0 on success.
>> + */
>> +static int of_coresight_get_trace_id(struct device *dev, u32 *id)
>> +{
>> +
>> +	return of_property_read_u32(dev->of_node, "trace-id", id);
>> +}
>> +
>>  /*
>>   * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>>   * and fill the connection information in @pdata->out_conns
>> @@ -315,6 +326,12 @@ static inline int of_coresight_get_cpu(struct device *dev)
>>  {
>>  	return -ENODEV;
>>  }
>> +
>> +static int of_coresight_get_trace_id(struct device *dev, u32 *id)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>>  #endif
>>  
>>  #ifdef CONFIG_ACPI
>> @@ -794,6 +811,15 @@ int coresight_get_cpu(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(coresight_get_cpu);
>>  
>> +int coresight_get_trace_id(struct device *dev, u32 *id)
>> +{
>> +	if (!is_of_node(dev->fwnode))
>> +		return -EINVAL;
>> +
>> +	return of_coresight_get_trace_id(dev, id);

Can we somehow make this function name distinct from the trace ID
functions. It's a bit hard to read that it's called
coresight_get_trace_id() but it doesn't actually get an ID from the
existing trace ID stuff.

>> +}
>> +EXPORT_SYMBOL_GPL(coresight_get_trace_id);
>> +
>>  struct coresight_platform_data *
>>  coresight_get_platform_data(struct device *dev)
>>  {
>> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
>> index af5b4ef59cea..536a34e9de6f 100644
>> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
>> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
>> @@ -110,6 +110,24 @@ static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map
>>  	return id;
>>  }
>>  
>> +static int coresight_trace_id_set(int id, struct coresight_trace_id_map *id_map)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&id_map_lock, flags);
>> +
>> +	if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
>> +		return -EINVAL;
>> +	if (WARN(test_bit(id, id_map->used_ids), "ID is already used: %d\n", id))
>> +		return -EINVAL;
> 
> Do these returns not skip unlocking the spinlock?
> 
> It might be slightly fewer changes if we update the existing
> coresight_trace_id_alloc_new_id() to add a new "only_preferred" option.
> 
> Then use the existing system id allocator which already handles the lock
> and unlock properly:
> 
>   static int coresight_trace_id_map_get_system_id(struct
>                              coresight_trace_id_map *id_map, int id,
> 
>                              bool only_preferred)
>   {
>   ...
> 	spin_lock_irqsave(&id_map_lock, flags);
> 	/* prefer odd IDs for system components to avoid legacy CPU IDS
> 	id = coresight_trace_id_alloc_new_id(id_map, id, true,
>                                              only_preferred);
>         spin_unlock_irqrestore(&id_map_lock, flags);
>   ...
> 
> I suppose the end result is the same as your implementation, but it
> trades making one existing function slightly more complicated instead of
> adding some new ones.

It's also not that obvious that there is the new reserve function, but
you still free the ID with the same coresight_trace_id_put_system_id().

Another benefit of adding arguments to the existing functions is that we
keep just ...get...() and ...put...(). 'Reserve' implies some other new
mechanism, but it's really a normal get. I think we should do one of
these two options for the top level API:

#1 (when id != 0, then it's an "only preferred" preferred ID:
  coresight_trace_id_get_system_id(int id)
  coresight_trace_id_put_system_id(int id)

#2
  coresight_trace_id_get_system_id()
  coresight_trace_id_get_system_id_resrv(int id)
  coresight_trace_id_put_system_id(int id)


Return-Path: <linux-kernel+bounces-239137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA79256FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387FFB219A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41C13D612;
	Wed,  3 Jul 2024 09:39:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC342A80;
	Wed,  3 Jul 2024 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999598; cv=none; b=nlp4f9Ws3Waz+oqmyB9NZ7GgcGgcO5ybd37bigPjpOjU+H8dFKMjkeQGkQDTNWXhyZTL89AOc90uDprVYBn9vajgITquS+r72nUn+uBSTJygcvwaaUlx73F9GPHmXNlBD8tbqY5rb+zpAkhLeLDbJwxNp4PJleCvan/ODQYW2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999598; c=relaxed/simple;
	bh=qvGX/Rkj145//3zq3L4wSy6A5IyR7NvdVRRkzXoDf3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRP7gt4LvjCogFG2GPlz9FF9h32Wb0XgFE9pEDHTV7Ht0ohx3PzX6Kev1YGvFjiX2LLo5N+1Aa1gp2sFoAzaQlHr6cy5ufWqn+jMY7/lPQZ2WdOQRSTBmrl3eQUqnliNHOkW8nlNvl9ovQJx5ajArSZ3UHiptBvcvTVEJAZhEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDAAF367;
	Wed,  3 Jul 2024 02:40:13 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5693F762;
	Wed,  3 Jul 2024 02:39:44 -0700 (PDT)
Message-ID: <dc97b56e-e40f-42e0-953d-b216400cbbb8@arm.com>
Date: Wed, 3 Jul 2024 10:39:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] coresight: tmc: Add support for reading crash data
To: Linu Cherian <lcherian@marvell.com>
Cc: mike.leach@linaro.org, james.clark@arm.com,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-6-lcherian@marvell.com>
 <df91af49-383b-4686-8b5c-3e9b0b9b2a18@arm.com>
 <20240620014827.GA125816@hyd1403.caveonetworks.com>
 <6476fa2e-b7db-4bc2-a7a6-26b32af6c9f3@arm.com>
 <20240703042952.GA256716@hyd1403.caveonetworks.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240703042952.GA256716@hyd1403.caveonetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 05:29, Linu Cherian wrote:
> 
> Hi Suzuki,
> 
> Sorry for the late reply.
> 
> On 2024-06-21 at 16:24:45, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
>> On 20/06/2024 02:48, Linu Cherian wrote:
>>> On 2024-06-10 at 22:04:16, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
>>>> On 05/06/2024 09:17, Linu Cherian wrote:
>>>>> * Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
>>>>>      captured in previous crash/watchdog reset.
>>>>>
>>>>
>>>> I am still not convinced if we really need this new mode. We should :
>>>>
>>>> 1) Register the new misc device to expose the "reserved" saved trace
>>>> data, only when the metadata is crc checked and it indicates "valid"
>>>> trace data.
>>>
>>> Ack.
>>>
>>>>
>>>> 2) Always allow reading from the "reserved" buffer when the above file
>>>> is opened. At open(), once again check if the mdata.valid is true (see
>>>> below), if not, return -EIO.
>>>>
>>>> 3) Whenever we use the buffer in "RESERVE" for a session, also set the
>>>> mdata.valid == false. This would prevent any further read from the
>>>> /dev/crash_xxx device. Which makes sense, as the data is lost.
>>>>
>>>
>>> Well, how about the below changes
>>> a. Clear the valid bit only upon user request so that, user is free to do
>>> multiple reads of crashdata buffer.
>>
>> I don't see the need for it. With the proposed changes as long as we
>> don't overwrite the trace using RESERVE mode, the user can read it and
>> they don't need to explicitly clear the field.
>>
>> The current changes do not prevent the user from overwriting the buffer
>> any way using the RESERVE mode. And we can get rid of the "READ CRASH"
>> mode.
> 
> Okay Agree. I misunderstood your previous comment.
> 
> 
>>
>>> Clearing the mdata.valid can be triggered using a write to the file like
>>> echo 0 > /dev/crash_tmc_etxx.
>>>
>>> b. In order to prevent the buffer overwrite, when mdata.valid = true
>>>      * ETR sink mode: dont allow the user to change the buffer mode to "RESERVE"
>>>      * ETB sink mode: dont copy panic trace data to reserve buffer during
>>>        kernel panic.
>>
>> Why ? It is the users responsibility (I would add inittab job to capture the
>> trace) to collect the trace, before you start using the "reserve"
>> mode.
>>
>> You may additionally prevent the mode change to "RESERVE" if someone has
>> opened the /dev/crashxxx.
> 
> Agree.
> 
>>
>>>
>>>> This way, you don't need to dance with a new mode always provide the
>>>> reserve buffer contents, if it is valid (with an ongoing RESERVE mode)
>>>> invalidating the buffer and the change is much much simpler.
>>>>
>>>
>>> In general, we tried to reuse the existing normal trace buffer read operations
>>> for the crash data reads as well. Hence we need a way to special case the crash data
>>> reads in few places like for eg. tmc_etr/etb_get_sysfs_trace.
>>
>> I understand, but that is unnecessarily complicating the existing
>> framework.
>>
>>>
>>> Its not clear to me if you are suggesting to write parallel independent
>>> functions to manage the crash device reads OR its just about relying on
>>> drvdata->crash_mdata.valid to special case the common read functions insead
>>> of csdev->mode ? Please clarify.
>>
>> Use parallel independent functions to read from crash device. No new
>> mode. All we need to do when someone opens the /dev/crash--:
>>
>> 1) See if the metdata.valid == true
>> 2) Block further "mode" changes to RESERV_BUF. Hold a refcount
>> 3) Provide the buffer from crash buffer.
>> 4) Upon close()=> drop the refcount from (2)
>>
>> Related question, does anyone need the "metdata" ? e.g. flush status ?
>> Or do we think that only the trace data is required ?
>>
> 
> Only trace data would be required similar to how the sysfs reads are
> done. Currently metadata is consumed only by the driver at the time of
> buffer read for calculating offsets etc.

How about, other info: e.g., was there a flush failure ? The trace data 
may not be reliable if there was flush failure. We could leave it to the
user to figure out from the trace read ?

> 
>>
>>
>>>
>>>
>>>>
>>>>> * Add special device files for reading ETR/ETF crash data.
>>>>>
>>>>> * User can read the crash data as below
>>>>>
>>>>>      For example, for reading crash data from tmc_etf sink
>>>>>
>>>>>      #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
>>>>>
>>>>> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
>>>>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>>>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>>>> ---
>>>>> Changelog from v8:
>>>>> * Added missing exit path in __tmc_probe
>>>>> * Few whitespace fixes and a checkpatch fix.
>>>>>
>>>>>     .../coresight/coresight-etm4x-core.c          |   1 +
>>>>>     .../hwtracing/coresight/coresight-tmc-core.c  | 150 ++++++++++++++++-
>>>>>     .../hwtracing/coresight/coresight-tmc-etf.c   |  72 +++++++++
>>>>>     .../hwtracing/coresight/coresight-tmc-etr.c   | 151 +++++++++++++++++-
>>>>>     drivers/hwtracing/coresight/coresight-tmc.h   |  11 +-
>>>>>     include/linux/coresight.h                     |  13 ++
>>>>>     6 files changed, 390 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> index a0bdfabddbc6..7924883476c6 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> @@ -1011,6 +1011,7 @@ static void etm4_disable(struct coresight_device *csdev,
>>>>>     	switch (mode) {
>>>>>     	case CS_MODE_DISABLED:
>>>>> +	case CS_MODE_READ_CRASHDATA:
>>>>>     		break;
>>>>>     	case CS_MODE_SYSFS:
>>>>>     		etm4_disable_sysfs(csdev);
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> index daad08bc693d..0c145477ba66 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> @@ -106,6 +106,60 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
>>>>>     	return mask;
>>>>>     }
>>>>> +int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
>>>>> +{
>>>>> +	int ret = 0;
>>>>> +	struct tmc_crash_metadata *mdata;
>>>>> +	struct coresight_device *csdev = drvdata->csdev;
>>>>> +
>>>>> +	if (!drvdata->crash_mdata.vaddr) {
>>>>> +		ret = -ENOMEM;
>>>>> +		goto out;
>>>>> +	}
>>>>> +
>>>>> +	mdata = drvdata->crash_mdata.vaddr;
>>>>> +	/* Check data integrity of metadata */
>>>>> +	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
>>>>> +		dev_dbg(&drvdata->csdev->dev,
>>>>> +			"CRC mismatch in tmc crash metadata\n");
>>>>> +		ret = -EINVAL;
>>>>
>>>> After the comments above, if at all we retain this, please use -EIO
>>>
>>>
>>> Ack.
>>>
>>>>
>>>>> +		goto out;
>>>>> +	}
>>>>> +	/* Check data integrity of tracedata */
>>>>> +	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
>>>>> +		dev_dbg(&drvdata->csdev->dev,
>>>>> +			"CRC mismatch in tmc crash tracedata\n");
>>>>> +		ret = -EINVAL;
>>>>
>>>> Same here, -EIO
>>>
>>> Ack.
>>>
>>>>
>>>>> +		goto out;
>>>>> +	}
>>>>> +	/* Check for valid metadata */
>>>>> +	if (!mdata->valid) {
>>>>> +		dev_dbg(&drvdata->csdev->dev,
>>>>> +			"Data invalid in tmc crash metadata\n");
>>>>> +		ret = -EINVAL;
>>>>> +		goto out;
>>>>> +	}
>>>>
>>>> -ENXIO
>>>
>>> Ack.
>>>
>>>>
>>>>
>>>>> +	/* Sink specific crashdata mode preparation */
>>>>> +	ret = crashdata_ops(csdev)->prepare(csdev);
>>>>> +	if (ret)
>>>>> +		goto out;
>>>>> +
>>>>> +	if (mdata->sts & 0x1)
>>>>
>>>> If at all we need this, please use TMC_STS_FULL instead of hard coding
>>>> numbers.
>>>
>>>
>>> Ack.
>>>
>>>
>>>>
>>>>> +		coresight_insert_barrier_packet(drvdata->buf);
>>>>> +
>>>>> +out:
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata)
>>>>> +{
>>>>> +	struct coresight_device *csdev = drvdata->csdev;
>>>>> +
>>>>> +	/* Sink specific crashdata mode preparation */
>>>>> +	return crashdata_ops(csdev)->unprepare(csdev);
>>>>> +}
>>>>> +
>>>>>     static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>>>>>     {
>>>>>     	int ret = 0;
>>>>> @@ -156,6 +210,9 @@ static int tmc_open(struct inode *inode, struct file *file)
>>>>>     	struct tmc_drvdata *drvdata = container_of(file->private_data,
>>>>>     						   struct tmc_drvdata, miscdev);
>>>>> +	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA)
>>>>> +		return -EBUSY;
>>>>> +
>>>>>     	ret = tmc_read_prepare(drvdata);
>>>>>     	if (ret)
>>>>>     		return ret;
>>>>> @@ -180,13 +237,12 @@ static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
>>>>>     	return -EINVAL;
>>>>>     }
>>>>> -static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>>>>> -			loff_t *ppos)
>>>>> +static ssize_t tmc_read_common(struct tmc_drvdata *drvdata, char __user *data,
>>>>> +			       size_t len, loff_t *ppos)
>>>>>     {
>>>>>     	char *bufp;
>>>>>     	ssize_t actual;
>>>>> -	struct tmc_drvdata *drvdata = container_of(file->private_data,
>>>>> -						   struct tmc_drvdata, miscdev);
>>>>> +
>>>>>     	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
>>>>>     	if (actual <= 0)
>>>>>     		return 0;
>>>>> @@ -203,6 +259,15 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>>>>>     	return actual;
>>>>>     }
>>>>> +static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>>>>> +			loff_t *ppos)
>>>>> +{
>>>>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>>>>> +						   struct tmc_drvdata, miscdev);
>>>>> +
>>>>> +	return tmc_read_common(drvdata, data, len, ppos);
>>>>> +}
>>>>> +
>>>>>     static int tmc_release(struct inode *inode, struct file *file)
>>>>>     {
>>>>>     	int ret;
>>>>> @@ -225,6 +290,61 @@ static const struct file_operations tmc_fops = {
>>>>>     	.llseek		= no_llseek,
>>>>>     };
>>>>> +static int tmc_crashdata_open(struct inode *inode, struct file *file)
>>>>> +{
>>>>> +	int ret;
>>>>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>>>>> +						   struct tmc_drvdata,
>>>>> +						   crashdev);
>>>>> +
>>>>> +	if (!coresight_take_mode(drvdata->csdev, CS_MODE_READ_CRASHDATA))
>>>>> +		return -EBUSY;
>>>>> +
>>>>> +	ret = tmc_read_prepare(drvdata);
>>>>> +	if (ret) {
>>>>> +		coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	nonseekable_open(inode, file);
>>>>
>>>>
>>>> As mentioned in the beginning, please use "mdata.valid" to deny any open
>>>> requests and that way you could simplify most of the code and make a single
>>>> function to handle all of the crash device handling.
>>>
>>> Did you meant using drvdata->crash_mdata.valid to special case common
>>> functions instead of relying on csdev->mode ? Please clarify.
>>
>> You may reuse "code" for reading from a buffer. But please do not use a
>> mode to switch buffer. Instead, you could refactor common "code" to a
>> function and pass appropriate buffer to the function.
> 
> Okay. Got it. Will rework accordingly.
> 
>>
>>>
>>>>
>>>>
>>>>> +
>>>>> +	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static ssize_t tmc_crashdata_read(struct file *file, char __user *data,
>>>>> +				  size_t len, loff_t *ppos)
>>>>> +{
>>>>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>>>>> +						   struct tmc_drvdata,
>>>>> +						   crashdev);
>>>>> +
>>>>> +	return tmc_read_common(drvdata, data, len, ppos);
>>>>
>>>> Simply provide the reserve buffer data, instead of creating ETB / ETR
>>>> specific handling.
>>>
>>> The differences between tmc_etb/etr_get_sysfs_trace applies to crash
>>> data reads as well. So its not clear to me why we dont need ETB/ETR specific handling.
>>
>> My point is they all read from the "drvdata->crashbuf" isn't ? If you have a
>> crash_buf_fops, that would apply to ETB/ETR/ETFs as they all have
>> the data stored in the reserved buffer area. It doesn't matter for crash
>> buf. For sysfs trace it is different, because the trace data is at different
>> places. ETB has in internal SRAM, ETR has in RAM etc.
>>
> 
> The difference that i was trying to point out was on the offset part.
> For ETB sink mode, the start offset is always 0 and for ETR its based on RWP
> and hence the changes. So my understanding is that we still need to have
> seperate functions for tmc_etb/etr_get_sysfs_trace while reading from
> the reserved buffer area. CMIIWH.

We don't. We simply use a single function:

/*
  * Read from crash_buf @size bytes from @offset and copy to @target_buf
  * @mdata describes the metadata for the crash buffer.
  *
  */
tmc_read_crash_buf(crash_buf, mdata, offset, size, target_buf)
{
	real_offset = mdata.first_byte; // RRP for ETR. 0 for ETB
	real_size = mdata.size; // Size for the total buffer.

	to_read = min(size, real_size - real_offset);

	copy_from(crash_buf + real_offset), to_read bytes => target_buf
}

Suzuki




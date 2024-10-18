Return-Path: <linux-kernel+bounces-371385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83E99A3A66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC7B283013
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10513200CB1;
	Fri, 18 Oct 2024 09:46:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569018872A;
	Fri, 18 Oct 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244784; cv=none; b=hW6vJv0NR6YmDGVxLuTvD3aCDfCGDfnb+7KW3uCHUyQhPVQUs1oewG1MfzcZxptnSPUh7nRKvDeXhI/WKzrhZbFniVQwYgjJR763pQ5JAjwtWLA4xlbpwZtYXRAmOlaPbrLS2YtNwFc+mpIpUOleZjHJkjP29dbTXgLJZ+cWh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244784; c=relaxed/simple;
	bh=azHhQksD+K7NQxomrk2erox1QKFqxrV59ouOXwU43Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5tM0XATIOZrMWxQ9N0XT0SoJ6sVYOEslFw/T4HdJTPGLFaG/QXCvut/DpLDpCfAxVOwqUUwsqV4eV+Ys8gLL+X39IVr4Ix5WLglKocWDLHMXF4huWczMCZ1mz9ZEAxhLVi3tur48j3uiv18Z7/hfLjJOuDNsKMOoySX90E6FNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCC2EFEC;
	Fri, 18 Oct 2024 02:46:50 -0700 (PDT)
Received: from [10.57.22.188] (unknown [10.57.22.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A06B93F58B;
	Fri, 18 Oct 2024 02:46:18 -0700 (PDT)
Message-ID: <05ed4a6f-cb41-4953-a654-9988f0fcd373@arm.com>
Date: Fri, 18 Oct 2024 10:46:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/8] coresight: tmc: Add support for reading crash
 data
Content-Language: en-GB
To: Linu Cherian <lcherian@marvell.com>
Cc: mike.leach@linaro.org, james.clark@arm.com,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-6-lcherian@marvell.com>
 <f1acfd07-7317-4b7e-bb81-ea9a894f25ac@arm.com>
 <20241017114054.GC896339@hyd1403.caveonetworks.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241017114054.GC896339@hyd1403.caveonetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2024 12:40, Linu Cherian wrote:
> On 2024-10-03 at 18:55:54, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
>> Hi Linu
>>
>> On 16/09/2024 11:34, Linu Cherian wrote:
>>> * Add support for reading crashdata using special device files.
>>>     The special device files /dev/crash_tmc_xxx would be available
>>>     for read file operation only when the crash data is valid.
>>>
>>> * User can read the crash data as below
>>>
>>>     For example, for reading crash data from tmc_etf sink
>>>
>>>     #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
>>
>> There are some comments below, please take a look.
>>
>>>
>>> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
>>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>> ---
>>> Changelog from v9:
>>> - Removed READ_CRASHDATA mode meant for special casing crashdata read
>>> - Added new fields full, len, offset to struct tmc_resrv_buf
>>
>> Why do we need "full" ? See more on that below.
>>
>>>     so as to have a common read function for ETR and ETF
>>> - Introduced read file operation, tmc_crashdata_read
>>>     specific to crashdata reads common for both ETR and ETF
>>> - Introduced is_tmc_crashdata_valid function
>>>     Special device file /dev/crash_tmc_xxx will be available only when
>>>     crashdata is valid.
>>> - Version checks added to crashdata validity checks
>>> - Mark crashdata as invalid when user starts tracing with ETR sink in
>>>     "resrv" buffer mode
>>>
>>>    .../hwtracing/coresight/coresight-tmc-core.c  | 206 +++++++++++++++++-
>>>    .../hwtracing/coresight/coresight-tmc-etf.c   |  36 +++
>>>    .../hwtracing/coresight/coresight-tmc-etr.c   |  63 ++++++
>>>    drivers/hwtracing/coresight/coresight-tmc.h   |  18 +-
>>>    include/linux/coresight.h                     |  12 +
>>>    5 files changed, 333 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> index 54bf8ae2bff8..47b6b3f88750 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> @@ -105,6 +105,125 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
>>>    	return mask;
>>>    }
>>> +bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata)
>>> +{
>>> +	struct tmc_crash_metadata *mdata;
>>> +
>>> +	if (!tmc_has_reserved_buffer(drvdata) ||
>>> +	    !tmc_has_crash_mdata_buffer(drvdata))
>>> +		return false;
>>> +
>>> +	mdata = drvdata->crash_mdata.vaddr;
>>> +
>>> +	/* Check version match */
>>> +	if (mdata->version != CS_CRASHDATA_VERSION)
>>> +		return false;
>>> +
>>> +	/* Check data integrity of metadata */
>>> +	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
>>> +		dev_dbg(&drvdata->csdev->dev,
>>> +			"CRC mismatch in tmc crash metadata\n");
>>> +		return false;
>>> +	}
>>> +	/* Check data integrity of tracedata */
>>> +	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
>>> +		dev_dbg(&drvdata->csdev->dev,
>>> +			"CRC mismatch in tmc crash tracedata\n");
>>> +		return false;
>>> +	}
>>> +	/* Check for valid metadata */
>>> +	if (!mdata->valid) {
>>
>> minor nit: This could be checked right after the VERSION and we verify
>> the CRC anyway later and thus could skip all the CRC calculations if
>> !valid.
> 
> 
> Ack.
> 
>>
>>> +		dev_dbg(&drvdata->csdev->dev,
>>> +			"Data invalid in tmc crash metadata\n");
>>> +		return false;
>>> +	}
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
>>> +{
>>> +	int ret = 0;
>>> +	unsigned long flags;
>>> +	struct tmc_crash_metadata *mdata;
>>> +	struct coresight_device *csdev = drvdata->csdev;
>>> +
>>> +	spin_lock_irqsave(&drvdata->spinlock, flags);
>>> +
>>> +	if (!is_tmc_crashdata_valid(drvdata)) {
>>> +		ret = -ENXIO;
>>> +		goto out;
>>> +	}
>>> +
>>> +	mdata = drvdata->crash_mdata.vaddr;
>>> +	/*
>>> +	 * Buffer address given by metadata for retrieval of trace data
>>> +	 * from previous boot is expected to be same as the reserved
>>> +	 * trace buffer memory region provided through DTS
>>> +	 */
>>> +	if (drvdata->resrv_buf.paddr != mdata->trace_paddr) {
>>> +		dev_dbg(&csdev->dev, "Trace buffer address of previous boot invalid\n");
>>
>> Couldn't this be made part of the "is_tmc_crashdata_valid()" and not
>> repeated everytime we do the read ? Surely, this can't change after
>> boot.
> 
> Ack. Will move.
> 
>>
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* Sink specific crashdata mode preparation */
>>> +	ret = crashdata_ops(csdev)->prepare(csdev);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	if (mdata->sts & 0x1)
>>> +		coresight_insert_barrier_packet(drvdata->buf);
>>> +
>>> +	drvdata->reading = true;
>>
>> Why are we dealing with drvdata->reading ? That is supposed to be only
>> for the normal trace reading ?
> 
> Ack. Will remove, we dont need this.
> 
>>
>>> +out:
>>> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>> +	return ret;
>>> +}
>>> +
>>> +int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata)
>>> +{
>>> +	int ret;
>>> +	unsigned long flags;
>>> +	struct coresight_device *csdev = drvdata->csdev;
>>> +
>>> +	spin_lock_irqsave(&drvdata->spinlock, flags);
>>> +
>>> +	/* Sink specific crashdata mode preparation */
>>> +	ret = crashdata_ops(csdev)->unprepare(csdev);
>>> +
>>> +	drvdata->reading = false;
>>
>>
>>
>>> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static inline ssize_t tmc_get_resvbuf_trace(struct tmc_drvdata *drvdata,
>>> +					  loff_t pos, size_t len, char **bufpp)
>>> +{
>>> +	s64 offset;
>>> +	ssize_t actual = len;
>>> +	struct tmc_resrv_buf *rbuf = &drvdata->resrv_buf;
>>> +
>>> +	if (pos + actual > rbuf->len)
>>> +		actual = rbuf->len - pos;
>>> +	if (actual <= 0)
>>> +		return actual;
>>
>> return 0 ? Because, we went beyond the file position, not because there was
>> an error. So, that it doesn't look like we are suppressing an ERROR ?
> 
> 
> return 0 looks fine to me. Will recheck on this.
> 
>>
>>
>>> +
>>> +	/* Compute the offset from which we read the data */
>>> +	offset = rbuf->offset + pos;
>>> +	if (offset >= rbuf->size)
>>> +		offset -= rbuf->size;
>>> +
>>> +	/* Adjust the length to limit this transaction to end of buffer */
>>> +	actual = (actual < (rbuf->size - offset)) ?
>>> +		actual : rbuf->size - offset;
>>> +
>>> +	*bufpp = (char *)rbuf->vaddr + offset;
>>> +
>>> +	return actual;
>>> +}
>>> +
>>>    static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>>>    {
>>>    	int ret = 0;
>>> @@ -224,6 +343,70 @@ static const struct file_operations tmc_fops = {
>>>    	.llseek		= no_llseek,
>>>    };
>>> +static int tmc_crashdata_open(struct inode *inode, struct file *file)
>>> +{
>>> +	int ret;
>>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>>> +						   struct tmc_drvdata,
>>> +						   crashdev);
>>> +
>>> +	ret = tmc_read_prepare_crashdata(drvdata);
>>
>> I don't see the point of this "prepare" and unprepare callbacks, as they
>> can be made generic by populating the mdata->rrp,rwp fields accordingly ?
>>
>> i.e., while populating the mdata-> fields, for ETR, do what you do now.
>> For ETF you could :
>>
>> mdata->rrp = 0;
>> mdata->dba = 0;
>> mdata->rwp = drvdata->len;
>> mdata->size = drvdata->len >> 2;
>> mdata->sts = TMC_STS_FULL;
> 
> Agree with your point that this would get rid of sink specific
> callbacks.
> 
> But few points to consider before we go with the above approach,
> 
> * mdata register snapshots wont be true to their definition,
>    with such encodings.
> 
>    We had a similar discussion on this earlier regarding mdata->size,
>    ie. We decided to stick to register format instead of storing bytes.
>    https://lore.kernel.org/linux-arm-kernel/20240620041054.GC125816@hyd1403.caveonetworks.com/

Understood. But whoever fills in the metdata does need to fill the
mdata information above ? Including calculating the hash. So, I think it
is fair to say that mdata is populated in a way that makes sense
just by looking at it. In fact, we should :


mdata->dba = <address of the tracedata>
mdata->rrp = mdata->dba;
mdata->rwp = mdata->rrp + drvdata->len;
mdata->size = drvdata->len >> 2;
mdata->sts = TMC_STS_FULL;

Rather than filling in 0's.


> 
> * We will have more comparable code between normal trace buffer reading
>    and reading trace buffer after panic with sink specific callbacks,
>    even though we keep the code seperate.

Lets not create "customs" here. We have a callback for a reason. i.e,
the ETF has an internal SRAM which is not accessible directly by the CPU
and ETR uses normal RAM.

While in this case, we have the data in CPU accessible RAM and the
"driver" in this case is crash handling and can be agnostic of where
the data was captured (ETF vs ETR)


Suzuki


> 
> Please let me know your thoughts on this.




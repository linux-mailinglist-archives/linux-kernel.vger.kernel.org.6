Return-Path: <linux-kernel+bounces-206246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24888900644
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BDF1C218F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5C1991D5;
	Fri,  7 Jun 2024 14:17:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A42C196C65;
	Fri,  7 Jun 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769856; cv=none; b=JbGkrjVVJt+yubTocGEdgp0L+hLGneSjVSYFviF/cDK4TFZp5OqIm2OwCKZ61TBS9GlPUiLjOkN1MYS31pc3D9oH2iukNQbmCHo2Ste/90eFAxjCXeVbZsMuqz9BEdfjavKv9Cfz6JD991PBEiikgtVOF0PkiC/lDZh2js+SudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769856; c=relaxed/simple;
	bh=8Ydd0HPEQjqOxcdyNn+M4mD18QDKZMXTaKlNZ2fiMgE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VUh0T58RV7iF/UiJqfjnCKXER1gQnXcZL1UXwONRwusgaHD34A0sadQ0d4PgmjoeUHyYKRKT9slUM4fesDKlSzxgd0omevzqzt28Mrjqq2Klx9Ub2fxk4pDFX0+iXjliDsHicJQoruVn22B4a6Rm/RwPLz4Kb9wma9fpCxpuys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83BAC153B;
	Fri,  7 Jun 2024 07:17:58 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69E4A3F64C;
	Fri,  7 Jun 2024 07:17:32 -0700 (PDT)
Message-ID: <9fe19909-ddfa-4595-99a5-e8edc0805ca8@arm.com>
Date: Fri, 7 Jun 2024 15:17:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] coresight: tmc: Add support for reading crash data
From: James Clark <james.clark@arm.com>
To: Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-6-lcherian@marvell.com>
 <a676105a-2f38-498b-87cb-94e0c2406408@arm.com>
Content-Language: en-US
In-Reply-To: <a676105a-2f38-498b-87cb-94e0c2406408@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/06/2024 17:09, James Clark wrote:
> 
> 
> On 05/06/2024 09:17, Linu Cherian wrote:
>> * Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
>>   captured in previous crash/watchdog reset.
>>
>> * Add special device files for reading ETR/ETF crash data.
>>
>> * User can read the crash data as below
>>
>>   For example, for reading crash data from tmc_etf sink
>>
>>   #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
>>
>> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>> ---
>> Changelog from v8:
>> * Added missing exit path in __tmc_probe
>> * Few whitespace fixes and a checkpatch fix.
>>
>>  .../coresight/coresight-etm4x-core.c          |   1 +
>>  .../hwtracing/coresight/coresight-tmc-core.c  | 150 ++++++++++++++++-
>>  .../hwtracing/coresight/coresight-tmc-etf.c   |  72 +++++++++
>>  .../hwtracing/coresight/coresight-tmc-etr.c   | 151 +++++++++++++++++-
>>  drivers/hwtracing/coresight/coresight-tmc.h   |  11 +-
>>  include/linux/coresight.h                     |  13 ++
>>  6 files changed, 390 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index a0bdfabddbc6..7924883476c6 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -1011,6 +1011,7 @@ static void etm4_disable(struct coresight_device *csdev,
>>  
>>  	switch (mode) {
>>  	case CS_MODE_DISABLED:
>> +	case CS_MODE_READ_CRASHDATA:
>>  		break;
>>  	case CS_MODE_SYSFS:
>>  		etm4_disable_sysfs(csdev);
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index daad08bc693d..0c145477ba66 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -106,6 +106,60 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
>>  	return mask;
>>  }
>>  
>> +int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
>> +{
>> +	int ret = 0;
>> +	struct tmc_crash_metadata *mdata;
>> +	struct coresight_device *csdev = drvdata->csdev;
>> +
>> +	if (!drvdata->crash_mdata.vaddr) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	mdata = drvdata->crash_mdata.vaddr;
>> +	/* Check data integrity of metadata */
>> +	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
>> +		dev_dbg(&drvdata->csdev->dev,
>> +			"CRC mismatch in tmc crash metadata\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +	/* Check data integrity of tracedata */
>> +	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
>> +		dev_dbg(&drvdata->csdev->dev,
>> +			"CRC mismatch in tmc crash tracedata\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +	/* Check for valid metadata */
>> +	if (!mdata->valid) {
>> +		dev_dbg(&drvdata->csdev->dev,
>> +			"Data invalid in tmc crash metadata\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* Sink specific crashdata mode preparation */
>> +	ret = crashdata_ops(csdev)->prepare(csdev);
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (mdata->sts & 0x1)
>> +		coresight_insert_barrier_packet(drvdata->buf);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>> +int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata)
>> +{
>> +	struct coresight_device *csdev = drvdata->csdev;
>> +
>> +	/* Sink specific crashdata mode preparation */
>> +	return crashdata_ops(csdev)->unprepare(csdev);
>> +}
>> +
>>  static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>>  {
>>  	int ret = 0;
>> @@ -156,6 +210,9 @@ static int tmc_open(struct inode *inode, struct file *file)
>>  	struct tmc_drvdata *drvdata = container_of(file->private_data,
>>  						   struct tmc_drvdata, miscdev);
>>  
>> +	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA)
>> +		return -EBUSY;
>> +
>>  	ret = tmc_read_prepare(drvdata);
>>  	if (ret)
>>  		return ret;
>> @@ -180,13 +237,12 @@ static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
>>  	return -EINVAL;
>>  }
>>  
>> -static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>> -			loff_t *ppos)
>> +static ssize_t tmc_read_common(struct tmc_drvdata *drvdata, char __user *data,
>> +			       size_t len, loff_t *ppos)
>>  {
>>  	char *bufp;
>>  	ssize_t actual;
>> -	struct tmc_drvdata *drvdata = container_of(file->private_data,
>> -						   struct tmc_drvdata, miscdev);
>> +
>>  	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
>>  	if (actual <= 0)
>>  		return 0;
>> @@ -203,6 +259,15 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>>  	return actual;
>>  }
>>  
>> +static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>> +			loff_t *ppos)
>> +{
>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>> +						   struct tmc_drvdata, miscdev);
>> +
>> +	return tmc_read_common(drvdata, data, len, ppos);
>> +}
>> +
>>  static int tmc_release(struct inode *inode, struct file *file)
>>  {
>>  	int ret;
>> @@ -225,6 +290,61 @@ static const struct file_operations tmc_fops = {
>>  	.llseek		= no_llseek,
>>  };
>>  
>> +static int tmc_crashdata_open(struct inode *inode, struct file *file)
>> +{
>> +	int ret;
>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>> +						   struct tmc_drvdata,
>> +						   crashdev);
>> +
>> +	if (!coresight_take_mode(drvdata->csdev, CS_MODE_READ_CRASHDATA))
>> +		return -EBUSY;
>> +
>> +	ret = tmc_read_prepare(drvdata);
>> +	if (ret) {
>> +		coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>> +		return ret;
>> +	}
>> +
>> +	nonseekable_open(inode, file);
>> +
>> +	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
>> +	return 0;
>> +}
>> +
>> +static ssize_t tmc_crashdata_read(struct file *file, char __user *data,
>> +				  size_t len, loff_t *ppos)
>> +{
>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>> +						   struct tmc_drvdata,
>> +						   crashdev);
>> +
>> +	return tmc_read_common(drvdata, data, len, ppos);
>> +}
>> +
>> +static int tmc_crashdata_release(struct inode *inode, struct file *file)
>> +{
>> +	int ret = 0;
>> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
>> +						   struct tmc_drvdata,
>> +						   crashdev);
>> +
>> +	ret = tmc_read_unprepare(drvdata);
>> +
>> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>> +
>> +	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations tmc_crashdata_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= tmc_crashdata_open,
>> +	.read		= tmc_crashdata_read,
>> +	.release	= tmc_crashdata_release,
>> +	.llseek		= no_llseek,
>> +};
>> +
>>  static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
>>  {
>>  	enum tmc_mem_intf_width memwidth;
>> @@ -542,6 +662,18 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
>>  	return burst_size;
>>  }
>>  
>> +static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
>> +					 const char *name)
>> +{
>> +	drvdata->crashdev.name =
>> +		devm_kasprintf(&drvdata->csdev->dev, GFP_KERNEL, "%s_%s", "crash", name);
>> +	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
>> +	drvdata->crashdev.fops = &tmc_crashdata_fops;
>> +	if (misc_register(&drvdata->crashdev))
>> +		dev_dbg(&drvdata->csdev->dev,
>> +			"Failed to setup user interface for crashdata\n");
>> +}
>> +
>>  static int __tmc_probe(struct device *dev, struct resource *res)
>>  {
>>  	int ret = 0;
>> @@ -642,8 +774,13 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>>  	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
>>  	drvdata->miscdev.fops = &tmc_fops;
>>  	ret = misc_register(&drvdata->miscdev);
>> -	if (ret)
>> +	if (ret) {
>>  		coresight_unregister(drvdata->csdev);
>> +		goto out;
>> +	}
>> +
>> +	if (is_tmc_reserved_region_valid(dev))
>> +		register_crash_dev_interface(drvdata, desc.name);
> 
> I think this would be better if it checked the CRC of the metadata in
> the same way it does before reading the file.
> 
> Now we have two forms of "region valid", one that's any non-zero value,
> and the other "really valid" one. And because we don't check the CRC
> here we register a device that can't be used.
> 
> I found it a bit confusing because without enabling debug prints I
> didn't know why the file couldn't be read. So I wasn't sure if it was
> because it wasn't valid or some other reason.
> 
> I also wasn't able to get a valid region after booting the crash kernel.
> But maybe the memory isn't preserved across the reboot on my Juno, so I
> don't think that's necessarily an issue?

Ok so I double checked by writing 0x123456 into the reserved region and
confirmed that it _is_ preserved when booting the panic kernel on my
Juno. So I'm not sure why I wasn't able to read out the crash dump.

I did see the "success" message from tmc_panic_sync_etr() at least some
of the times, although I do remember it not printing out every time. I
don't know if this is just an issue with outputting to serial after a
panic or something else was going on?

Did you ever see the success message not print out? Or not able to read
back the data when you were testing it?


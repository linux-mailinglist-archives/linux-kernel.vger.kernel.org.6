Return-Path: <linux-kernel+bounces-374334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F179A68B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2F4B2359D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C91F1310;
	Mon, 21 Oct 2024 12:36:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768081E884E;
	Mon, 21 Oct 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514198; cv=none; b=orc8H7HEPzMpxHeYacvdPALSjOmSBEStAsF2C86e+vV9egaP3+d+VbvYwdPaApcF60j1Sz94XhiJ92l4RPkKRYio5KVeDLul0xx7Ge/RUVuGxIUOR9+r9Lx7cqA8nAQ+ZcbvRzz7cnolDYbp3/pS+3BHQ3hOX5Nb5Y6Nidh9950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514198; c=relaxed/simple;
	bh=pGjxOAo38J7DvNsv0qsRBEiB1i0Qpqbdm/HFUd5B7ek=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CBxDUehgsJGWZNUVBMkLMkbJC5/Xe7/dMvuA3kjYrf5YVxsx/N+79hbV/RLGQlVeQAvvUsG3QmgbeJx9CZolU+z3aszQ74fiqDjwpEaqQBjLcs7BZOEXPOGqaAQGy+qOMAIW/l1dBS3ByoPxWnAdZfW5O5bUysh3ROzxp0wlokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68768DA7;
	Mon, 21 Oct 2024 05:37:04 -0700 (PDT)
Received: from [10.57.64.219] (unknown [10.57.64.219])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A3513F528;
	Mon, 21 Oct 2024 05:36:32 -0700 (PDT)
Message-ID: <4ddc9078-1059-45a2-8f44-c904d62c854f@arm.com>
Date: Mon, 21 Oct 2024 13:36:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] coresight: dummy: Add static trace id support for
 dummy source
Content-Language: en-GB
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mao Jinlong <quic_jinlmao@quicinc.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20241018032217.39728-1-quic_jinlmao@quicinc.com>
 <20241018032217.39728-4-quic_jinlmao@quicinc.com>
 <b2f9aa93-a50a-4bfd-9df0-9e3a170404f8@arm.com>
In-Reply-To: <b2f9aa93-a50a-4bfd-9df0-9e3a170404f8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2024 13:31, Suzuki K Poulose wrote:
> On 18/10/2024 04:22, Mao Jinlong wrote:
>> Some dummy source has static trace id configured in HW and it cannot
>> be changed via software programming. Configure the trace id in device
>> tree and reserve the id when device probe.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../sysfs-bus-coresight-devices-dummy-source  | 15 +++++
>>   drivers/hwtracing/coresight/coresight-dummy.c | 59 +++++++++++++++++--
>>   2 files changed, 70 insertions(+), 4 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight- 
>> devices-dummy-source
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices- 
>> dummy-source b/Documentation/ABI/testing/sysfs-bus-coresight-devices- 
>> dummy-source
>> new file mode 100644
>> index 000000000000..c7d975e75d85
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-dummy-source
>> @@ -0,0 +1,15 @@
>> +What:        /sys/bus/coresight/devices/dummy_source<N>/enable_source
>> +Date:        Oct 2024
>> +KernelVersion:    6.13
>> +Contact:    Mao Jinlong <quic_jinlmao@quicinc.com>
>> +Description:    (RW) Enable/disable tracing of dummy source. A sink 
>> should be activated
>> +        before enabling the source. The path of coresight components 
>> linking
>> +        the source to the sink is configured and managed 
>> automatically by the
>> +        coresight framework.
>> +
>> +What:        /sys/bus/coresight/devices/dummy_source<N>/traceid
>> +Date:        Oct 2024
>> +KernelVersion:    6.13
>> +Contact:    Mao Jinlong <quic_jinlmao@quicinc.com>
>> +Description:    (R) Show the trace ID that will appear in the trace 
>> stream
>> +        coming from this trace entity.
>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/ 
>> hwtracing/coresight/coresight-dummy.c
>> index bb85fa663ffc..602a7e89e311 100644
>> --- a/drivers/hwtracing/coresight/coresight-dummy.c
>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>> @@ -11,10 +11,12 @@
>>   #include <linux/pm_runtime.h>
>>   #include "coresight-priv.h"
>> +#include "coresight-trace-id.h"
>>   struct dummy_drvdata {
>>       struct device            *dev;
>>       struct coresight_device        *csdev;
>> +    u8                traceid;
>>   };
>>   DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
>> @@ -72,6 +74,32 @@ static const struct coresight_ops dummy_sink_cs_ops 
>> = {
>>       .sink_ops = &dummy_sink_ops,
>>   };
>> +/* User can get the trace id of dummy source from this node. */
>> +static ssize_t traceid_show(struct device *dev,
>> +                struct device_attribute *attr, char *buf)
>> +{
>> +    unsigned long val;
>> +    struct dummy_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    val = drvdata->traceid;
>> +    return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>> +}
>> +static DEVICE_ATTR_RO(traceid);
>> +
>> +static struct attribute *coresight_dummy_attrs[] = {
>> +    &dev_attr_traceid.attr,
>> +    NULL,
>> +};
>> +
>> +static const struct attribute_group coresight_dummy_group = {
>> +    .attrs = coresight_dummy_attrs,
>> +};
>> +
>> +static const struct attribute_group *coresight_dummy_groups[] = {
>> +    &coresight_dummy_group,
>> +    NULL,
>> +};
>> +
>>   static int dummy_probe(struct platform_device *pdev)
>>   {
>>       struct device *dev = &pdev->dev;
>> @@ -79,6 +107,11 @@ static int dummy_probe(struct platform_device *pdev)
>>       struct coresight_platform_data *pdata;
>>       struct dummy_drvdata *drvdata;
>>       struct coresight_desc desc = { 0 };
>> +    int ret, trace_id;
>> +
>> +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +    if (!drvdata)
>> +        return -ENOMEM;
>>       if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
>> @@ -90,6 +123,25 @@ static int dummy_probe(struct platform_device *pdev)
>>           desc.subtype.source_subtype =
>>                       CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
>>           desc.ops = &dummy_source_cs_ops;
>> +        desc.groups = coresight_dummy_groups;
>> +
>> +        ret = coresight_get_static_trace_id(dev, &trace_id);
>> +        if (!ret) {
>> +            /* Get the static id if id is set in device tree. */
>> +            ret = coresight_trace_id_get_static_system_id(trace_id);

This may be worth an error message, it is a rare one. Othewise, there is
no clue on what caused the failure. Or have a specific error code as a
result ?

>> +            if (ret < 0)
>> +                return ret;

e.g., return -EBUSY ? /* Device or resource not available */

>> +
>> +        } else {
>> +            /* Get next available id if id is not set in device tree. */
>> +            trace_id = coresight_trace_id_get_system_id();
>> +            if (trace_id < 0) {
>> +                ret = trace_id;
>> +                return ret;
>> +            }
>> +        }
>> +        drvdata->traceid = (u8)trace_id;
>> +
>>       } else if (of_device_is_compatible(node, "arm,coresight-dummy- 
>> sink")) {
>>           desc.name = coresight_alloc_device_name(&sink_devs, dev);
>>           if (!desc.name)
>> @@ -108,10 +160,6 @@ static int dummy_probe(struct platform_device *pdev)
>>           return PTR_ERR(pdata);
>>       pdev->dev.platform_data = pdata;
>> -    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> -    if (!drvdata)
>> -        return -ENOMEM;
>> -
>>       drvdata->dev = &pdev->dev;
>>       platform_set_drvdata(pdev, drvdata);

Additionally we should drop the system_id if registering the coresight 
device fails.


Suzuki

>> @@ -131,7 +179,10 @@ static void dummy_remove(struct platform_device 
>> *pdev)
>>   {
>>       struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
>>       struct device *dev = &pdev->dev;
>> +    struct device_node *node = dev->of_node;
> 
> ^^ Why is this needed ? The rest looks fine to me
> 
>> +    if (IS_VALID_CS_TRACE_ID(drvdata->traceid))
>> +        coresight_trace_id_put_system_id(drvdata->traceid);
>>       pm_runtime_disable(dev);
>>       coresight_unregister(drvdata->csdev);
>>   }
> 



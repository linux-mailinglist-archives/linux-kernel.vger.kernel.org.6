Return-Path: <linux-kernel+bounces-528711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF388A41B36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA8C1706CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A419068E;
	Mon, 24 Feb 2025 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C1+kKCtw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14586200BB3;
	Mon, 24 Feb 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393260; cv=none; b=VWHVw4t2PwDmwVX07zpTVw5lYizqyeYPDvxP5bh2GfJOBVkatJZspLRHO+RM3c86iWyKbZieg9zbSc5E9h1GX+QjNsXBI9VET4TzuQwyzwYe6NUnEcWVvy76Vwe1bOLRQh1oYQfsuHsIqSWD3gZ+BYtVmu7IlirEm4PH2n2Lj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393260; c=relaxed/simple;
	bh=bDumf9YGotuIKsBd7RSPAQki40YRIhPESOlRGHAgfNw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ixJL2aEp/KTMfCrRKgJxxIkD5h4kQzNYMbIotWSp+mNGqSzA2zqxhAf11DaCzkYwsE83+mos3PTVxaT/ZS8HbvD18bHOkQmHCcWz7Mk200lja4k8QuszO35MLkrAGssJeOWfNeMtLtKyzoE+xIVxgB6rxX9tIuRTORKe/K77Qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C1+kKCtw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9C0d0020840;
	Mon, 24 Feb 2025 10:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8zPDqkV/POv5dJgtiuW574ziA/qlzT5EpkIKdvC30g=; b=C1+kKCtwGXnoYBKO
	YiJvDwp2k+OaReleTzxDplh1VqAz4lAOe0mPYLzlMrU4+1t7N8rr6K96lERkgWwx
	IhCPuURsgCe+CeAOVpwK5d8u9UUU1/51vrt2/vSeQ9IxF7cLQdRvAph1ES1He5vg
	hIJAYw0GGpOvHwpI7zosoqFoHDfWnWj0xu35OliR/3pkU9LdSyjhW+yLK8C6SQWn
	T43tI+B3s0FBa0m97VqIsrnCK26k1aZgEPiYghRIaa6EGfr1U/68C9SPCbz4EtAJ
	lhWETrxd1GnbpNnZlJZ4lh5QimjXCck4pTTlLtAnVIxN4Pnn4e0pAkU4t7ww2cpC
	hZPYew==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6t2mp0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 10:34:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51OAY1rF032240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 10:34:01 GMT
Received: from [10.133.33.32] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Feb
 2025 02:33:55 -0800
Message-ID: <2c5c1c8e-a10b-48fb-a0ec-c8164b4f3908@quicinc.com>
Date: Mon, 24 Feb 2025 18:33:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/7] Coresight: Add Coresight TMC Control Unit driver
From: Jie Gan <quic_jiegan@quicinc.com>
To: James Clark <james.clark@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>
CC: Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250217093024.1133096-1-quic_jiegan@quicinc.com>
 <20250217093024.1133096-7-quic_jiegan@quicinc.com>
 <35d1a923-4e8e-4fe2-bf4a-0b78b1d511e3@arm.com>
 <a594bdee-7d9e-4d79-a5ee-a34dafa2869f@quicinc.com>
 <37cb0da5-fcca-41e0-95d8-280fd95541c9@linaro.org>
 <a7b301b5-bd9b-4b50-9299-e44a78fcf5a8@quicinc.com>
Content-Language: en-US
In-Reply-To: <a7b301b5-bd9b-4b50-9299-e44a78fcf5a8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BDzBlCEfOtFqD7M4_WpIg0aHrEU5wOke
X-Proofpoint-GUID: BDzBlCEfOtFqD7M4_WpIg0aHrEU5wOke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240077



On 2/24/2025 6:04 PM, Jie Gan wrote:
> 
> 
> On 2/24/2025 5:53 PM, James Clark wrote:
>>
>>
>> On 24/02/2025 3:32 am, Jie Gan wrote:
>>>
>>>
>>> On 2/21/2025 7:39 PM, Suzuki K Poulose wrote:
>>>> On 17/02/2025 09:30, Jie Gan wrote:
>>>>> The Coresight TMC Control Unit hosts miscellaneous configuration 
>>>>> registers
>>>>> which control various features related to TMC ETR sink.
>>>>>
>>>>> Based on the trace ID, which is programmed in the related CTCU ATID
>>>>> register of a specific ETR, trace data with that trace ID gets into
>>>>> the ETR buffer, while other trace data gets dropped.
>>>>>
>>>>> Enabling source device sets one bit of the ATID register based on
>>>>> source device's trace ID.
>>>>> Disabling source device resets the bit according to the source
>>>>> device's trace ID.
>>>>>
>>>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>>> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
>>>>> ---
>>>>>   drivers/hwtracing/coresight/Kconfig          |  12 +
>>>>>   drivers/hwtracing/coresight/Makefile         |   1 +
>>>>>   drivers/hwtracing/coresight/coresight-ctcu.c | 268 ++++++++++++++ 
>>>>> + ++++
>>>>>   drivers/hwtracing/coresight/coresight-ctcu.h |  24 ++
>>>>>   include/linux/coresight.h                    |   3 +-
>>>>>   5 files changed, 307 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 drivers/hwtracing/coresight/coresight-ctcu.c
>>>>>   create mode 100644 drivers/hwtracing/coresight/coresight-ctcu.h
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/ 
>>>>> hwtracing/ coresight/Kconfig
>>>>> index 06f0a7594169..ecd7086a5b83 100644
>>>>> --- a/drivers/hwtracing/coresight/Kconfig
>>>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>>>> @@ -133,6 +133,18 @@ config CORESIGHT_STM
>>>>>         To compile this driver as a module, choose M here: the
>>>>>         module will be called coresight-stm.
>>>>> +config CORESIGHT_CTCU
>>>>> +    tristate "CoreSight TMC Control Unit driver"
>>>>> +    depends on CORESIGHT_LINK_AND_SINK_TMC
>>>>> +    help
>>>>> +      This driver provides support for CoreSight TMC Control Unit
>>>>> +      that hosts miscellaneous configuration registers. This is
>>>>> +      primarily used for controlling the behaviors of the TMC
>>>>> +      ETR device.
>>>>> +
>>>>> +      To compile this driver as a module, choose M here: the
>>>>> +      module will be called coresight-ctcu.
>>>>> +
>>>>>   config CORESIGHT_CPU_DEBUG
>>>>>       tristate "CoreSight CPU Debug driver"
>>>>>       depends on ARM || ARM64
>>>>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/ 
>>>>> hwtracing/ coresight/Makefile
>>>>> index 4ba478211b31..1b7869910a12 100644
>>>>> --- a/drivers/hwtracing/coresight/Makefile
>>>>> +++ b/drivers/hwtracing/coresight/Makefile
>>>>> @@ -51,3 +51,4 @@ coresight-cti-y := coresight-cti-core.o 
>>>>> coresight- cti-platform.o \
>>>>>              coresight-cti-sysfs.o
>>>>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>>>>   obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>>>>> +obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-ctcu.c b/ 
>>>>> drivers/ hwtracing/coresight/coresight-ctcu.c
>>>>> new file mode 100644
>>>>> index 000000000000..e1460a627c4d
>>>>> --- /dev/null
>>>>> +++ b/drivers/hwtracing/coresight/coresight-ctcu.c
>>>>> @@ -0,0 +1,268 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All 
>>>>> rights reserved.
>>>>> + */
>>>>> +
>>>>> +#include <linux/clk.h>
>>>>> +#include <linux/coresight.h>
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/err.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/mutex.h>
>>>>> +#include <linux/of.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +#include "coresight-ctcu.h"
>>>>> +#include "coresight-priv.h"
>>>>> +
>>>>> +DEFINE_CORESIGHT_DEVLIST(ctcu_devs, "ctcu");
>>>>> +
>>>>> +#define ctcu_writel(drvdata, val, offset)    __raw_writel((val), 
>>>>> drvdata->base + offset)
>>>>> +#define ctcu_readl(drvdata, offset)        __raw_readl(drvdata- 
>>>>> >base + offset)
>>>>> +
>>>>> +/*
>>>>> + * The TMC Coresight Control Unit uses four ATID registers to 
>>>>> control the data
>>>>> + * filter function based on the trace ID for each TMC ETR sink. 
>>>>> The length of
>>>>> + * each ATID register is 32 bits. Therefore, the ETR has a related 
>>>>> field in
>>>>> + * CTCU that is 128 bits long. Each trace ID is represented by one 
>>>>> bit in that
>>>>> + * filed.
>>>>> + * e.g. ETR0ATID0 layout, set bit 5 for traceid 5
>>>>> + *                                           bit5
>>>>> + * ------------------------------------------------------
>>>>> + * |   |28|   |24|   |20|   |16|   |12|   |8|  1|4|   |0|
>>>>> + * ------------------------------------------------------
>>>>> + *
>>>>> + * e.g. ETR0:
>>>>> + * 127                     0 from ATID_offset for ETR0ATID0
>>>>> + * -------------------------
>>>>> + * |ATID3|ATID2|ATID1|ATID0|
>>>>> + */
>>>>> +#define CTCU_ATID_REG_OFFSET(traceid, atid_offset) \
>>>>> +        ((traceid / 32) * 4 + atid_offset)
>>>>> +
>>>>> +#define CTCU_ATID_REG_BIT(traceid)    (traceid % 32)
>>>>> +#define CTCU_ATID_REG_SIZE        0x10
>>>>> +
>>>>> +struct ctcu_atid_config {
>>>>> +    const u32 atid_offset;
>>>>> +    const u32 port_num;
>>>>> +};
>>>>> +
>>>>> +struct ctcu_config {
>>>>> +    const struct ctcu_atid_config *atid_config;
>>>>> +    int num_atid_config;
>>>>> +};
>>>>> +
>>>>> +static const struct ctcu_atid_config sa8775p_atid_cfgs[] = {
>>>>> +    {0xf8,  0},
>>>>> +    {0x108, 1},
>>>>> +};
>>>>> +
>>>>> +static const struct ctcu_config sa8775p_cfgs = {
>>>>> +    .atid_config        = sa8775p_atid_cfgs,
>>>>> +    .num_atid_config    = ARRAY_SIZE(sa8775p_atid_cfgs),
>>>>> +};
>>>>> +
>>>>> +static void ctcu_program_atid_register(struct ctcu_drvdata 
>>>>> *drvdata, u32 reg_offset,
>>>>> +                       u8 bit, bool enable)
>>>>> +{
>>>>> +    u32 val;
>>>>> +
>>>>> +    CS_UNLOCK(drvdata->base);
>>>>> +    val = ctcu_readl(drvdata, reg_offset);
>>>>> +    val = enable? (val | BIT(bit)) : (val & ~BIT(bit));
>>>>
>>>> minor nit: If possible do not use the ternary operator like this. It 
>>>> is much better readable as:
>>>>
>>>>      if (enable)
>>>>          val |= BIT(bit);
>>>>      else
>>>>          val &= ~BIT(bit);
>>>>
>>>
>>> Will do this way.
>>>
>>>>> +    ctcu_writel(drvdata, val, reg_offset);
>>>>> +    CS_LOCK(drvdata->base);
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * __ctcu_set_etr_traceid: Set bit in the ATID register based on 
>>>>> trace ID when enable is true.
>>>>> + * Reset the bit of the ATID register based on trace ID when 
>>>>> enable is false.
>>>>> + *
>>>>> + * @csdev:    coresight_device struct related to the device
>>>>> + * @traceid:    trace ID of the source tracer.
>>>>> + * @port_num:    port number from TMC ETR sink.
>>>>> + * @enable:    True for set bit and false for reset bit.
>>>>> + *
>>>>> + * Returns 0 indicates success. Non-zero result means failure.
>>>>> + */
>>>>> +static int __ctcu_set_etr_traceid(struct coresight_device *csdev, 
>>>>> u8 traceid, int port_num,
>>>>> +                  bool enable)
>>>>> +{
>>>>> +    struct ctcu_drvdata *drvdata = dev_get_drvdata(csdev- 
>>>>> >dev.parent);
>>>>> +    u32 atid_offset, reg_offset;
>>>>> +    u8 refcnt, bit;
>>>>> +
>>>>> +    atid_offset = drvdata->atid_offset[port_num];
>>>>> +    if (atid_offset == 0)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    bit = CTCU_ATID_REG_BIT(traceid);
>>>>> +    reg_offset = CTCU_ATID_REG_OFFSET(traceid, atid_offset);
>>>>> +    if (reg_offset - atid_offset > CTCU_ATID_REG_SIZE)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    guard(raw_spinlock_irqsave)(&drvdata->spin_lock);
>>>>> +    refcnt = drvdata->traceid_refcnt[port_num][traceid];
>>>>> +    /* Only program the atid register when the refcnt value is 0 
>>>>> or 1 */
>>>>
>>>> A normal trace source won't be enabled more than once (e.g., ETM). 
>>>> The only odd one out is the STM, which may be driven by multiple 
>>>> agents.
>>>> So this refcounting looks necessary.
>>>>
>>>
>>> Besides, for the TPDMs which shared the trace_id of the TPDA also 
>>> need the refcnt. Consider we have TPDM1 and TPDM2 connected to the 
>>> same TPDA device. Once we disable one of the TPDM without checking 
>>> the refcnt, the filter function will be disabled for another TPDM.
>>>
>>>>> +    if (enable && (++refcnt == 1))
>>>>> +        ctcu_program_atid_register(drvdata, reg_offset, bit, enable);
>>>>> +    else if (!enable && (--refcnt == 0))
>>>>> +        ctcu_program_atid_register(drvdata, reg_offset, bit, enable);
>>>>
>>>> minor nit:
>>>>
>>>>      if ((enable && !refcount++) ||
>>>>          (!enable && --refcount))
>>>>          ctcu_program_atid_register(drvdata, reg_offset, bit, enable);
>>>>
>>>>
>>>
>>> I did (enable && (++refcnt == 1)) just because I think we only need 
>>> program the register when refcnt is equal to 1. We dont need 
>>> reprogram the register with same value when refcnt greater than 1. So 
>>> I think it's better for the performance?
>>>
>>>> Also, see my comment the bottom for "refcount" being u8 .
>>>
>>> Sure, will check.
>>>
>>>>
>>>>
>>>>> +
>>>>> +    drvdata->traceid_refcnt[port_num][traceid] = refcnt;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int ctcu_get_active_port(struct coresight_device *sink, 
>>>>> struct coresight_device *helper)
>>>>> +{
>>>>> +    int i;
>>>>> +
>>>>> +    for (i = 0; i < sink->pdata->nr_outconns; ++i) {
>>>>> +        if (sink->pdata->out_conns[i]->dest_dev)
>>>>> +            return sink->pdata->out_conns[i]->dest_port;
>>>>
>>>> Don't we need to make sure it matches the helper ? What if there are 
>>>> multiple helpers ? e.g, a CATU connected to the ETR and CTCU ?
>>>> Or even try the opposite ? i.e. search the helper and find the port
>>>> matching the sink ?
>>
>> Good catch, looks like this should be done the opposite way around.
>>
>>>>
>>>>      struct coresight_platform_data *pdata = helper->pdata;
>>>>
>>>>      for (i = 0; i < pdata->nr_inconns; ++i)
>>>>          if (pdata->in_conns[i]->dest_dev == sink)
>>>>              return pdata->in_conns[i]->src_port;
>>>>
>>>> Not sure if that works with the helper device connection, James ?
>>
>> Yeah connections are always made in both directions.
>>
>>> Can we check the subtype of the helper device? We should only have 
>>> one CTCU helper device for each ETR.
>>>
>>> enum coresight_dev_subtype_helper subtype;
>>>
>>> for (i = 0; i < sink->pdata->nr_outconns; ++i) {
>>>      subtype = sink->pdata->out_conns[i]->dest_dev- 
>>> >subtype.helper_subtype;
>>>      if (subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CTCU)
>>>         return sink->pdata->out_conns[i]->dest_port;
>>>
>>
>> I don't think we need to check the type, just search all the CTCU's 
>> in_conns until you find the sink.
>>
>> As Suzuki says, by looking at the out_conns of the sink you might find 
>> a different helper device. Checking that it really is connected to the 
>> sink is probably more robust that relying on the type anyway.
>>
> 
> Hi James,
> 
> Thanks for explaination, will update per Suzuki's suggestion.
> 
> Jie
> 

Hi Suzuki James,

Just for confirm, the updated codes from opposite way should be:

struct coresight_platform_data *pdata = helper->pdata;

for (i = 0; i < pdata->nr_inconns; ++i)
     if (pdata->in_conns[i]->src_dev == sink)
     	return pdata->in_conns[i]->dest_port;

Just because the direction when create connection is sink->helper, am right?

--------------------------     ---------------------------
    src_dev(sink) src_port| --> |dest_port dest_dev(helper)
--------------------------     ---------------------------
Thanks,
Jie

>>
> 
> 
> 
> 
> 



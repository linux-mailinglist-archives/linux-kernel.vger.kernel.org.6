Return-Path: <linux-kernel+bounces-295622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979EC959F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB71F22C81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AB1B1D68;
	Wed, 21 Aug 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oYdD9PUC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5B1AF4FE;
	Wed, 21 Aug 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248771; cv=none; b=UTymXTEj+ScyLQ56QHsJcNeAaJeRc+ly9oTCyKNifEarMytbHdf/YMqmMgPYqUnkET0C/mv9KqtoEE52CBrsEma2OChHNqdjDq9sYte9PIJNIIxOj8sae88/qEDd89r2up4F+5B7GQzXcXV+tiW/Glp7QlwDjIL+NIf0Kvxa6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248771; c=relaxed/simple;
	bh=PbsGLzZ4F2xFlswHSWkQ0Qe3Zqk504RHzbTzx+4gtPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JOrypRhpIZCTCzISySA/AnCmVFKwpEevucOxzSvVlE0kQ9tpuPWBosyXlHVmM+uD6tz54+3t/t6mE72PuJWYMAdIv6DPk9/YV4cB6OL5pf01Qx6UO7YArs2ar70fjpc0XXsFe/XuO3Le+OYEDuXk72+ElDHZXIWKRxMNOFOEgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oYdD9PUC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBlu4r004447;
	Wed, 21 Aug 2024 13:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1xxem4oI9613Xn/OwqDA6eOFQB+ziH820o/I4+C2zDA=; b=oYdD9PUC0KMYzYvB
	8PvEmI546nHUhjZ3OjsjU6wEhSkYlyLOldqzzXRIygJMKsI+SZI5TV0KeMVLMDVk
	/EgjZMlVaLkz2Q023+1AXoy5vaTyiq1SNlvRhqp42qky70/TOxT+uVV78uOvTZJo
	clLkdEoXWkCr1nDQ3hp3jKTSqOuWvvIqIgym3ps8rfKRk31oNOWiaxj7epGVL7Cq
	XmP6zENZ8Vgp+b3125Qgn3YB7laOKTsaACOJhXL4H3/taMuVkDksA3zGCtqjC58w
	LwXTzQYbI3z/7C/li0d1lwhEWs3L1X2qpS9/sha/Sfv3CaSfVxRvSS5InuXrautJ
	YS9zxw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414v5cbq02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 13:59:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LDxNAh009342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 13:59:23 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 06:59:22 -0700
Message-ID: <eb2ac608-d847-4392-b9fc-9a1a88e947ff@quicinc.com>
Date: Wed, 21 Aug 2024 21:59:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc3: core: Call cpu_relax() in registers
 polling busy loops
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240820121501.3593245-1-quic_zhonhan@quicinc.com>
 <20240820121501.3593245-2-quic_zhonhan@quicinc.com>
 <20240820220536.lgxvvbfboheknyll@synopsys.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <20240820220536.lgxvvbfboheknyll@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2LWOHy2tHAQ4ojYp0wiZ--CfYbz7Fizu
X-Proofpoint-ORIG-GUID: 2LWOHy2tHAQ4ojYp0wiZ--CfYbz7Fizu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210101

On 8/21/2024 6:05 AM, Thinh Nguyen wrote:
> On Tue, Aug 20, 2024, Zhongqiu Han wrote:
>> Busy loops that poll on a register should call cpu_relax(). On some
>> architectures, it can lower CPU power consumption or yield to a
>> hyperthreaded twin processor. It also serves as a compiler barrier,
>> see Documentation/process/volatile-considered-harmful.rst. In addition,
>> if something goes wrong in the busy loop at least it can prevent things
>> from getting worse.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 734de2a8bd21..498f08dbbdb5 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -2050,6 +2050,8 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
>>   		if (!offset)
>>   			break;
>>   
>> +		cpu_relax();
>> +
>>   		val = readl(base + offset);
>>   		major_revision = XHCI_EXT_PORT_MAJOR(val);
>>   
>> -- 
>> 2.25.1
>>
> 
> We're not polling on a register here. We're just traversing and reading
> the next port capability. The loop in dwc3_get_num_ports() should not be
> more than DWC3_USB2_MAX_PORTS + DWC3_USB3_MAX_PORTS.
> 
Hi Thinh,
Thanks a lot for the review~

yes, now i know that the iterations are limited so it wouldn't make
sense to relax here. I will be careful about this next time and sorry
for this.

> What's really causing this busy loop you found?
> 
actually no practical issue.
> If polling for a register is really a problem, then we would have that
> problem everywhere else in dwc3. But why here?
> 

I also think that polling for a register is not a problem, but if there
polling for a register in the potential infinite loop, It's better to
relax the cpu and as i saw, basically there are two types of
implementations in other codes for the relax cpu target,

1. use (u/m)sleep or (u/n)delay function or the iterations limited,
such as:

(1)
core.c- if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
core.c-         retries = 10;
core.c-
core.c- do {
core.c:         reg = dwc3_readl(dwc->regs, DWC3_DCTL);
core.c-         if (!(reg & DWC3_DCTL_CSFTRST))
core.c-                 goto done;
core.c-
core.c-         if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) ||
                     DWC3_IP_IS(DWC32))
core.c-                 msleep(20);
core.c-         else
core.c-                 udelay(1);
core.c- } while (--retries);

(2)
gadget.c-       /* poll until Link State changes to ON */
gadget.c-       retries = 20000;
gadget.c-
gadget.c-       while (retries--) {
gadget.c:               reg = dwc3_readl(dwc->regs, DWC3_DSTS);
gadget.c-
gadget.c-               /* in HS, means ON */
gadget.c-               if (DWC3_DSTS_USBLNKST(reg) ==
                                          DWC3_LINK_STATE_U0)
gadget.c-                       break;
gadget.c-       }

By the way, for (2) case, the retries is 20000, seems the value is large
without relax if break the loop only while retries is 0, but as we know
although if there need delay/relax, we cannot easily use (u/m)delay or m
u(sleep) functions because we need consider to avoid the "scheduling on
atomic/invalid context" BUG. Just shared my guess, unless there is
optimization comparison data after relax cpu or practical issue here.


2. use cpu_relax() to relax for busy loop, such as:

(1)
ulpi.c-static int dwc3_ulpi_busyloop(struct dwc3 *dwc, u8 addr, bool read)
..........................
ulpi.c-
ulpi.c- while (count--) {
ulpi.c-         ndelay(ns);
ulpi.c:         reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYACC(0));
ulpi.c-         if (reg & DWC3_GUSB2PHYACC_DONE)
ulpi.c-                 return 0;
ulpi.c-         cpu_relax();
ulpi.c- }

(2)
host/ohci-pxa27x.c:     while (__raw_readl(pxa_ohci->mmio_base + UHCHR) 
& UHCHR_FSBIR)
host/ohci-pxa27x.c-             cpu_relax();

(3)
gadget/udc/fsl_udc_core.c:      while (fsl_readl(&dr_regs->usbcmd) & 
USB_CMD_CTRL_RESET) {
gadget/udc/fsl_udc_core.c-              if (time_after(jiffies, timeout)) {
gadget/udc/fsl_udc_core.c- 
dev_err(&udc->gadget.dev, "udc reset timeout!\n");
gadget/udc/fsl_udc_core.c-                      return -ETIMEDOUT;
gadget/udc/fsl_udc_core.c-              }
gadget/udc/fsl_udc_core.c-              cpu_relax();
gadget/udc/fsl_udc_core.c-      }


Anyways, for current patch there the iterations are limited, thanks a
lot for the review and the discussion and i will be careful next time.

> Thanks,
> Thinh


-- 
Thx and BRs,
Zhongqiu Han


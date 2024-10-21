Return-Path: <linux-kernel+bounces-374503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B49A6B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A901F21B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84D1F8931;
	Mon, 21 Oct 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8iIYyQZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF11F4717
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519095; cv=none; b=mNxn+SyzeTEy+Wx76MFVrgFuwIHAnM2YUZmDIXYURm39K4YJUGHi8X0//xZvJOTZuYodPLCsSdptjMNeGIC3iIOYe9qGLLqHCpW14dX/lYoJGNxOrD2UFgqkoQSKJXIJkjcBPJCkqXFA+7X2TGv60mIZHe3Kx3pZh0rTl0NW1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519095; c=relaxed/simple;
	bh=NPhBoj3xcxNlJXTqklaF506IqEIEDAzTVf1JM8EHZD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tK86QhzGmOJ6/NocMD3G4DSZo1tdMINoxHgKN8Wod8JmLd3HhDIj4hloVYlUtBh18LjXgZMICGx/T5t4UAMOVEPZZWcpjOueRiBkh+Gn8dSUAOn8r8ubQZXxqAE07di5QfKcL9QS06fvoGcd1NdlpMkghi3GvlfrA6BnJgj+Vao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8iIYyQZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9UE7P019311
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OI7Wh1fO6bHFXo1JQ2ZRfpx/pcAU9uIg8fircEPSrek=; b=N8iIYyQZQDBb9wae
	XDu6UWUeU8JwCQDB/K7WWmfH104Se6MFWPl8QeLsBsWI7qXEgGWbByrcr78uhLhc
	nAxgNVD4eXoqfGRt2x5MWYGXqqAVZpl+zCJ0FeDJbdkwkshqPzNfVj7yeauJ6wiw
	+seHBCy4mBdgtS926WY9YL2VyL54TlwCTyigFXNETaSKPLjtcWtl862P/rdVA/Sf
	QDzqEUaQSCjLJc8RvrzNXkbHeT/jEODvwrfWmscsy/N0qFUzeGGULhc28DtLNYeT
	1un6ORL6VViWekNt0dqyiujeNTP2FaE2CZkq7jfZanJd+4YUHihP6Udt/OfXE9wS
	eoTIhg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vc50xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:58:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cda6fd171bso11611666d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729519090; x=1730123890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI7Wh1fO6bHFXo1JQ2ZRfpx/pcAU9uIg8fircEPSrek=;
        b=m9IDu9vP0Hx0uYyn7JBKZ4jGBs+KfGs27p1+PoN/P/gvPOpDVg5qGzGpo8vNFwqqaQ
         kSB1wYkjOikBjjtN3xX94CTduHVFlfne9brVA8WPQtnDlJYObquHrwjqkRbcuT0WIW9N
         qQgppfGzs0l0ZdpgpBIvaKHVBek0loDIjtYDhecZJ1mKLHIk0RSFbU5dKY7HBCImqJze
         DkJov6Ts6B9aVVZazJ9FS3KTAZJvX8mzDpVApvSm/yV/6nqkdaWi8Mo60r/AzxM3ILzP
         03pMcDi9sEssJlqDXmDEQbT5nafeJe6YqwO8mDj7I0Z3YSw2U8qBpnkCAJBHRs8WgLil
         l/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCsf1Im5FsW50oiAs0O2wU+qWnN6yDLu9Dr4N+zuJFFSFuH5yYiycu7kEkHWZVXmEyJ3ekhOUKaXA52Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwJ7rhE6h4vBBJK9LgumTfmaEACz808MqpFqB7O6CoKF4IVv5
	Q5DFmIx1axmWrjNM3RLvPnRMfT/c1kGQizu4DrpnBK8M1HLbnkHlIDnB9LcZ8LbG2kOG9J4tabv
	1nIA3bFXDKt+hPKAqGfrPTXzVievmysM7C5HyYNxbhCtU3vcMo0XGUbJdU7k97ZQ=
X-Received: by 2002:ad4:5ae2:0:b0:6cb:bc57:d840 with SMTP id 6a1803df08f44-6cde14be181mr79937956d6.3.1729519090077;
        Mon, 21 Oct 2024 06:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCScMjTKswmyH1uzl8JIZj7OfIdN55ExFoP9OG2mAym/s4cspQQgTi+8KuXBFsGXeVZUKm3A==
X-Received: by 2002:ad4:5ae2:0:b0:6cb:bc57:d840 with SMTP id 6a1803df08f44-6cde14be181mr79937766d6.3.1729519089768;
        Mon, 21 Oct 2024 06:58:09 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b974sm1964000a12.67.2024.10.21.06.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 06:58:09 -0700 (PDT)
Message-ID: <24a674f5-17ba-49d1-a865-77f907a05c65@oss.qualcomm.com>
Date: Mon, 21 Oct 2024 15:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: llcc: add support for SAR2130P and
 SAR1130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241019-sar2130p-llcc-v1-0-4e09063d04f2@linaro.org>
 <20241019-sar2130p-llcc-v1-2-4e09063d04f2@linaro.org>
 <7fa066b6-a214-4866-9d0a-f75896531d84@oss.qualcomm.com>
 <CAA8EJprvQTGABZ6LAq1qXRfPgOz7VzxPuKnRz_EO_4S6tveXgQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAA8EJprvQTGABZ6LAq1qXRfPgOz7VzxPuKnRz_EO_4S6tveXgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OduracxbdD8eesNq01aS3rstZAjmYolm
X-Proofpoint-ORIG-GUID: OduracxbdD8eesNq01aS3rstZAjmYolm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210100

On 21.10.2024 3:13 PM, Dmitry Baryshkov wrote:
> On Mon, 21 Oct 2024 at 14:04, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 19.10.2024 6:26 PM, Dmitry Baryshkov wrote:
>>> Implement necessary support for the LLCC control on the SAR1130P and
>>> SAR2130P platforms. These two platforms use different ATTR1_MAX_CAP
>>> shift and also require manual override for num_banks.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  drivers/soc/qcom/llcc-qcom.c       | 468 ++++++++++++++++++++++++++++++++++++-
>>>  include/linux/soc/qcom/llcc-qcom.h |  12 +
>>>  2 files changed, 474 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>>> index a470285f54a875bf2262aac7b0f84ed8fd028ef1..ef84fe3b2af4e777126a8308bfd4ec47b28aeae2 100644
>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>> @@ -32,6 +32,7 @@
>>>  #define ATTR1_FIXED_SIZE_SHIFT        0x03
>>>  #define ATTR1_PRIORITY_SHIFT          0x04
>>>  #define ATTR1_MAX_CAP_SHIFT           0x10
>>> +#define ATTR1_MAX_CAP_SHIFT_sar       0x0e
>>>  #define ATTR0_RES_WAYS_MASK           GENMASK(15, 0)
>>>  #define ATTR0_BONUS_WAYS_MASK         GENMASK(31, 16)
>>>  #define ATTR0_BONUS_WAYS_SHIFT        0x10
>>> @@ -140,6 +141,11 @@ struct qcom_llcc_config {
>>>       bool need_llcc_cfg;
>>>       bool no_edac;
>>>       bool irq_configured;
>>> +     /*
>>> +      * special workarounds for SAR2130P and similar platforms which have
>>> +      * slightly different register mapping.
>>> +      */
>>> +     bool is_sar_chip;
>>
>> This is not the only odd ball, please make max_cap_width variable
> 
> I'm not sure what you mean here. Moving max_cap_width to the drv_data
> / configuration? Or do you mean something else?

Match data (qcom_llcc_config) is fine, as qcom_llcc_cfg_program is only
called from .probe.

max_cap_width would be a new field that denotes the width of MAX_CAP
(which seems to always be at [31:n])

> 
>>
>> [...]
>>
>>> +     /*
>>> +      * For some reason register returns incorrect value here.
>>> +      * List compatibles instead of using .is_sar_chip since there might be
>>> +      * SAR-like chips which have other number of banks.
>>> +      */
>>> +     if (of_device_is_compatible(dev->of_node, "qcom,sar1130p-llcc") ||
>>> +         of_device_is_compatible(dev->of_node, "qcom,sar2130p-llcc")) {
>>> +             num_banks = 2;
>>> +     } else {
>>> +             ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>>> +             if (ret)
>>> +                     goto err;
>>> +
>>> +             num_banks &= LLCC_LB_CNT_MASK;
>>> +             num_banks >>= LLCC_LB_CNT_SHIFT;
>>> +     }
>>>
>>> -     num_banks &= LLCC_LB_CNT_MASK;
>>> -     num_banks >>= LLCC_LB_CNT_SHIFT;
>>>       drv_data->num_banks = num_banks;
>>
>> This too
> 
> This can probably go to qcom_llcc_config.

Yep

Konrad


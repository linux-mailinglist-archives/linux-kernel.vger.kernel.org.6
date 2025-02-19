Return-Path: <linux-kernel+bounces-522188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F3A3C732
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776A6188801A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5F1FDE27;
	Wed, 19 Feb 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkF8PQfI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD31FA267
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989021; cv=none; b=mXCj2sVlSSD1Ezrio0oDftkqLc07FSHVLP52JJ+hXo1PHrL6fvW7uoWR7/maraWASrSHyTUUtQTIczN97GG0EjhH0RrG0B4cFySUkHzAIelN9caJzoK8F3BHyzmfjzAAo5lrbbW+bL/GIyqXoQqdiBa4rlWcTKmZhJiytZmHm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989021; c=relaxed/simple;
	bh=15VaQUR3mVRx8iK8PNZZm73Twuwc4zEsxbB0vznGbtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYQTthz9CClk0OUFI/BCDtKGFva2x/xDIiPMlnxPqR0qTKc8FAEoBMnB6UE1eyBYgk38P/+QGnq4uEEsWoWsBdCd2zQqjcYmdZ7WIE43cLlxwLyNixxGnXAbMOl7ts7Yzj2lQ1qjZlTHRAVFI8VO7NbuBjdDj1XIQ44dz6WOXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkF8PQfI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JH6B7j026275
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qQslAvi5S986c+CjPVwrSpIZbbdcJIt8ngmHdJF+C/U=; b=nkF8PQfIfQje6KRr
	KSwQyilucMEK03aWgOdWOQcMz0xUn7tFMNh1KmwvNpCsHwh3giSMAbgAiQnQhSMo
	LLBemn5CCafeGH7ioa/s4KcOQ12No3Mnv7s0bKrTgRVizxN9/r/7Eh7G4GIqmPWS
	Wb/vKUXjxYWQA8MYykdPH+3mqwiFTVIHrI1dVeilISCDE+8BKudmRdnTxdThMmQJ
	Z6G5bI6MqIyKu8lm+iFwlUja2RwbUtQp0UoMIFob4NoqpHX6FSiEZ/9LGnyG7IYV
	iyJKYu69UINKTejKxldrLycXfom28oHUbJIe/uczQzZ/uhFevB8EMVT6vrN8d2oL
	mRDP8w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0kkj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:16:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so236836a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989017; x=1740593817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQslAvi5S986c+CjPVwrSpIZbbdcJIt8ngmHdJF+C/U=;
        b=w05mz/deiou+iGsZMNNUGiJeQbfAnrl8juLl+AKLE4yCps8TiKhiyATE4Yd0Xfm42K
         MArQ9NbAbavvjVkhwI/jOqjI2t9RhpB2IVQ17of/KSRJ25GYuH6WxkuZ3kRfvdV7xvNC
         lzupkvSO7oh4hHKTPLo2MQx7DOXaimtsZTfcyZoTeeAQBhtRBCdONCNABM95VnShGB11
         Ih1YWHjRIyAAsYTrf0dWlPU3SXWLcrlQ/rt9LopuhXIYsg3MhYf7QKvCAT5FCTommsHX
         40pu5lzsWKHuWuv7EIM91BSg3h22r6KdATv/XSR69wD4mIsYGdAHlm6Gi9EqNg0/5Uzj
         r/cw==
X-Forwarded-Encrypted: i=1; AJvYcCUNcPZ0/2lWS8vAiipBtoEbQZR2KSQWHHFZuYDuctlicYKS5nJTgvgZFWPQYrNHiyQkhvc3szOuCq73VHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhMm8+F1wmATPOP7fMSe13e5gua58R10NTgjRpTyty+tAtEHI
	mx39Ng1TZc0ykwYkStViXjVdA5UvmkvpSd3M9TnVwagYto6eh9+nQ7Pli/qH2ygRi4C4iVLFiYM
	v7hd9DzLxh0MSpDXQGNPAjWCHxqGP5NOypZoneULpTdZCH9uYf1QnKdaOGRwlbB8=
X-Gm-Gg: ASbGncuHkB3uBvBH+tBrPCQrVKXAof3rK6e2Hg9ynmsNj5/MqbofAebQybVOaSov8Yh
	l961axbp785uTTtaUXVWVmvfdg3X5iDVEjdO0ApC5W0A0+XqTX+UfSEBi9lcKdaIAIyyhymcHAR
	sxDB2lwmOjnKxik9cGIaVtvT4cioJqlsXKA30gUAU28D5y3pCdduhatLwsbNzsUt+ha5qBnpE6F
	GMDlvpLIKgkZ3V1RZPv6QCFrPCfgrzGc6XaHBUSsjVoLen0xnGuRVXiAArErpXHymmUqK3abB4p
	Q/5tpBgIbVIt8AbXrxXeGdEZqzbUWWYIQbiWvfRwGckrgQymkm+M9JMqCS3CWhAAxsizlQ==
X-Received: by 2002:a05:6a00:4fd6:b0:730:8386:6078 with SMTP id d2e1a72fcca58-7326144b06dmr34414955b3a.0.1739989017265;
        Wed, 19 Feb 2025 10:16:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkfav6Ju8/K3VElkqoRX368Q55GZumfH5apyL2HHSvMb+wlEvPQ8L6XzFqhtEEGHHEmIMxAg==
X-Received: by 2002:a05:6a00:4fd6:b0:730:8386:6078 with SMTP id d2e1a72fcca58-7326144b06dmr34414855b3a.0.1739989016806;
        Wed, 19 Feb 2025 10:16:56 -0800 (PST)
Received: from [10.71.108.77] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324f22fd95sm11016795b3a.11.2025.02.19.10.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 10:16:56 -0800 (PST)
Message-ID: <a9ab6b36-0801-430d-87e4-c02538510127@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 10:16:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] thermal: qcom-spmi-temp-alarm: add support for LITE
 PMIC peripherals
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
 <20250213210403.3396392-5-anjelique.melendez@oss.qualcomm.com>
 <2v2nxdv2ofd2cwvatrpmo6w7o46o26y6w77myioailuin5ymal@z2mabzkbcrgl>
Content-Language: en-US
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
In-Reply-To: <2v2nxdv2ofd2cwvatrpmo6w7o46o26y6w77myioailuin5ymal@z2mabzkbcrgl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ky1psBJuWjpzFRqJvJH3iOijporURP_5
X-Proofpoint-ORIG-GUID: ky1psBJuWjpzFRqJvJH3iOijporURP_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190140

On 2/13/2025 2:09 PM, Dmitry Baryshkov wrote:
> On Thu, Feb 13, 2025 at 01:04:03PM -0800, Anjelique Melendez wrote:
>> Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
>> utilizes a pair of registers to configure a warning interrupt
>> threshold temperature and an automatic hardware shutdown
>> threshold temperature.
>>
>> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> ---
>>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 204 +++++++++++++++++++-
>>   1 file changed, 203 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
>> index a10f368f2039..081db1a85b8a 100644
>> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
>> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
>> @@ -22,6 +22,7 @@
>>   #define QPNP_TM_REG_TYPE		0x04
>>   #define QPNP_TM_REG_SUBTYPE		0x05
>>   #define QPNP_TM_REG_STATUS		0x08
>> +#define QPNP_TM_REG_IRQ_STATUS		0x10
> 
> Is it a generic register or a LITE one?
> 

This is generic register. All temp alarm devices have this IRQ status 
register at 0x10 offset but only temp alarm LITE devices read this register

Thanks,
Anjelique



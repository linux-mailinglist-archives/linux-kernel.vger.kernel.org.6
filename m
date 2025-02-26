Return-Path: <linux-kernel+bounces-533360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F3FA45904
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164651653F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165D226CFD;
	Wed, 26 Feb 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo2a96YB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D4225416
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559964; cv=none; b=F2WLrSCnEA76FVpW1HblmpRdDf1APPa+77bLllIUIt0mYg0V39ET+FTI6t50+oNOj1MWfcHDpu6xfsOOIs2eUq5kTG5cIvKXP7zYDPsALjkRRhCLrcnASFz/jBT9BTl+lnl6gx+/372QlNwS/JlNnmsWUZTyCL9WWuKENp1yBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559964; c=relaxed/simple;
	bh=RASzz04ZIexabz1WnXUW+GlS/PrfwuS50BtY+K2ie8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCP3cFp9FOf8pmcL2c7Erd33vYqvvXVEx/nF5gGEYwh/v2cxXnpN8Bus/UBx0iG0A8zileUimmWdbnVde0OlYFlIHubO0xEiJlTpaT/LzyQCRTz922ZceX7NXaGxBydfa7VyQi7BZt/3sWe1DQBeLmNHVNbiinLmobHfAOMsAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bo2a96YB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWpOr012246
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n04MMEZm+776Edy2BZXCJwY6EGHO/xjYajIKZPiVcsw=; b=bo2a96YBaB1CSqU5
	Ah6K+TAVWLnmbUToE9+9QZTHYyEg7zPN/LagAwY6JWdCzSElLd2a8MG9XR2Eg7Yo
	anuFxiWF+lMph4UuETuf6a3Mb4Ai++1JxykjKUXXgYAMXuydcmFbk/xhhbiq+JS7
	DSIBdJHPZH7hhveqfyAqqlpAt9IxXxjqgu/WzGCniXOmlhOXpXPPV33htBu8E8cZ
	ap6GRihwEDW2Wb4quMh4/ljhpfTdWr1ne4JxLlWwOoSRwYGfn88TX7gqHS8ohWTR
	lC2Pg/nICboKgU3XUMGaq1UilO0WNxiWXmcpyJSl4W58d5E+nlhAx43kg0tHsSwv
	DDrajQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prk1axh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:52:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22178547841so191827455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559955; x=1741164755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n04MMEZm+776Edy2BZXCJwY6EGHO/xjYajIKZPiVcsw=;
        b=HrpcMKK1XWWF0S1Ga6nTHqfBfSa+e6UtiaBNOZQgPc7ZJjOLDkGPhHu5Tuz2uAxHQE
         TJ/IOPRGlBdOLIHP0NPJSBdWbDu36rYAkcItxzvkeXt0/OKz2gzhYxEXWmEOD3WthACd
         mnIRSSmU+WWKqWRZAZvrSiQhh3ZQMPrIFYYp8vjuAT6odN7u2WgS5tMLk0k/VAKitSyO
         dyJhIyFhFDfpUfD+wFdFSHR3XjI643iUSCUhhl5vnHAURr6qYFlMKVzBKmvctBPC2m5L
         ugV0traqBh4XhQxmaUDWAH+e9weKBlnUZr7OeeQ8ZQn5ua8K83zXmWK1D9goPeHZ/xwp
         gDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSrX7YHxqNnL/eF5ScMCH9wJYmV/2YKAdQSEFnLiZIyDWpIws0HyRqVyshcDOahBIkkFWPBrC87+KK1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YygzfHZ1Ve62+Gn0kRS/vz9ielEfeMkCpvsOCW3TCU505FPe6hD
	xYH7UnqebDA2Exe3z3ghLgDjBGutVZ9xYbjgBAwfmIoBBKYca1A1TFPCc9ajbgNNQhBW9bquKF9
	Gxg1HGo+VRtFHqUVHQ4dvV6kKTqBnmuOociV9rG5EHnS95+dDGy3VJAek6gVGCdw=
X-Gm-Gg: ASbGnctvK+qFXD5Ek5p8qPGMPX2+QjegOV4VxpKd8jkeDt4LWEJabtkl7gbgnG5e97n
	qEooW9VsXw1X0ImxwJOVmeVgRN21q9gdRjfVXnFzNrxgdOvxlrXh2oDey5/N64LpPQGpufSF5ZF
	iSmCzYV+n7IChyz5nBD809X8aJUT90BjRzaMSMmJVSpIwr3JwCyS9UbRs77kSltCyW75LCb20SE
	ZaE/WCJKm3U2S84jg0/y9jm1bL1e8OMvbXs/hf/wtBkkag5dTBj5YzopOCwxDHAvwIV9EWoLYau
	pYholLGZaDQcA/M6aYOPi0B7UChHhqD5cddxdJp7jQjV
X-Received: by 2002:a17:902:d4cf:b0:216:4853:4c0b with SMTP id d9443c01a7336-223201f7d84mr41221025ad.33.1740559954626;
        Wed, 26 Feb 2025 00:52:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf629KRJkq4TmfJ2tQbXLT1D80gBVLyUAAPMBjcxrvnCwbYZ3/j9fge56XWA6VW8ot4WsA6w==
X-Received: by 2002:a17:902:d4cf:b0:216:4853:4c0b with SMTP id d9443c01a7336-223201f7d84mr41219795ad.33.1740559952738;
        Wed, 26 Feb 2025 00:52:32 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092eb0sm26943325ad.142.2025.02.26.00.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 00:52:32 -0800 (PST)
Message-ID: <dafe240f-c531-43f9-8787-bb8ba4ddea49@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 14:22:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-6-jishnu.prakash@oss.qualcomm.com>
 <20250201122731.2762b1f8@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250201122731.2762b1f8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CcHpgJS3VOr0AkCodevOcItto0IlRmeN
X-Proofpoint-ORIG-GUID: CcHpgJS3VOr0AkCodevOcItto0IlRmeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260071

Hi Jonathan,

On 2/1/2025 5:57 PM, Jonathan Cameron wrote:
> On Sat,  1 Feb 2025 00:02:42 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which
>> implements the threshold setting and interrupt generating
>> functionalities of QCOM ADC_TM drivers, used to support thermal
>> trip points.
> 
> Very short wrap. For commit descriptions 75 chars is fine.
> 
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Various minor comments inline.
> 
> Jonathan
> 
>> ---
>> Changes since v4:
>> - Fixed a compilation error and updated dependencies in config as suggested
>>   by reviewer.

...

>>
>> +
>> +MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
>> +
>> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
>> +	.adrv = {
>> +		.id_table = adctm5_auxiliary_id_table,
>> +		.probe = adc_tm5_probe,
>> +	},
>> +	.tm_event_notify = adctm_event_handler,
>> +};
>> +
>> +static int __init adctm5_init_module(void)
>> +{
>> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
>> +}
>> +
>> +static void __exit adctm5_exit_module(void)
>> +{
>> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
>> +}
>> +
>> +module_init(adctm5_init_module);
>> +module_exit(adctm5_exit_module);
> 
> Can use module_auxiliary_driver() to replace this boilerplate.
> The embedded adrv shouldn't stop that working that I can see.
> 

I tried to do this, but it does not work with the embedded adrv.


When I tried this change:

    -static int __init adctm5_init_module(void)
    -{
    -       return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
    -}
    -
    -static void __exit adctm5_exit_module(void)
    -{
    -       auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
    -}
    -
    -module_init(adctm5_init_module);
    -module_exit(adctm5_exit_module);
    +module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);


Ideally this should have worked as I see module_auxiliary_driver() takes a single argument of type struct auxiliary_driver. But it failed with errors like this:


    drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:474:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '.' token
     module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);
                                                     ^

    drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:474:49: error: 'struct adc_tm5_auxiliary_drv' has no member named 'adrv_init'
     module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);
                                                     ^

    drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:474:49: error: 'struct adc_tm5_auxiliary_drv' has no member named 'adrv_exit'
     module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);
                                                     ^


I think this happens because module_auxiliary_driver() is defined as a macro, like this:

    #define module_auxiliary_driver(__auxiliary_driver) \
        module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)

And when the text substitution for the argument is done, we would end up with lines like this in the expansion finally:

    module_init(adctm5gen3_auxiliary_drv.adrv_init);
    module_exit(adctm5gen3_auxiliary_drv.adrv_exit);


I'm facing similar issues, of the input argument being misinterpreted, if I use a pointer to the struct auxiliary_driver member (adrv), and dereference it as argument to module_auxiliary_driver().

I think module_auxiliary_driver() can only take a simple variable name as input, because in all the examples of its usage I found, I see there is a "struct auxiliary_driver" initialization just before the initialized variable is passed to module_auxiliary_driver().

In this auxiliary driver, I need to have adrv embedded within the struct adc_tm5_auxiliary_drv wrapper, as I also need to have the .tm_event_notify member, to expose a callback to the main driver, so I don't think I can change this.


I'll address your other comments in the next patch series.

Thanks,
Jishnu

> 
>> +
>> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
> 



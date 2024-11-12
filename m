Return-Path: <linux-kernel+bounces-405728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AA9C564E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5961F215C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F21FA847;
	Tue, 12 Nov 2024 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zf7Wpbgl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500701FA839
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409424; cv=none; b=bvT+GzjXbQ7ymRlFZzdtOmSHd1ldCBVk+jdz6sS9pfkDwpyZReVszlHizx2H6PzubUtcrLCCoKYz24Hu9lWY2aePmxyCSY66dOx3gHWNfo91vU+s2nJ5KkB33qpTO/I8JAoRBeWRzds0ckvDAeI/sR9Yhodx+T5ZH3xEew4/JK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409424; c=relaxed/simple;
	bh=G0Qe2OADcAQsfACZt2BcP1eMIcjortGkp4YDbkFFOYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxcAd0WxXFrRp1opP+aRP54PCuaFcNPfrGgbsHdGK2+kAUyF5PLPhpOw2fPCtVEpXlCEjjAUPa3R93rdx0TYLmzJH4RghiTex365q7tnJNE0/FCOS4eUQslzhIrhS3T0Th3Mvp+jRXGsWqGO+1wG6rh6gi+lJ4WP/cLwvoJ+Lv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zf7Wpbgl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC6Acnq004270
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d7fGoZsQujJug+U+jHgYocLKquVR4HJgVH5ELiDsVtU=; b=Zf7WpbglOftzO5UU
	RfZHbfYkITaFaGhwrV1yrBSs5M1xbbNUQsN9bUq3jv/mxRma5h2n9xa7b9OOge1p
	JVBehQDw3O2+TXgrm2j/wjWhyvSmuEZLZah0sos6cURsHaY9x5d5sqcl3rRR72ez
	1oE+dpjtDYrITI997+zOZhZnB3DapTO7XzzxaU2Z/sWCUmyxhvJJPycxes3QeMv0
	hfBrCC7NEEDXIwTkRzAs6oobyqXTBHhY/gG60sXF778vhrVmr0cCm6jg06HYfQh/
	Fd8p+aCBGwAnjzID8jAiY4GrYffP2HM527rmH+KATLNEctonMd76aFi/CJfPCvxg
	L/KrcQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v1h6gpue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:03:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d3742af01eso1866146d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409421; x=1732014221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7fGoZsQujJug+U+jHgYocLKquVR4HJgVH5ELiDsVtU=;
        b=ePEuZyDvYHkWGGypIOMdfsp8814BoZv01UG6ZDSZn+J7Ne8+X1ZKFf6HwVi6tW47LJ
         Vida+r9ebmsc5xYKynv98jFPul+4OvoFdxiVvE3adHSM5kwLNeArQCRQcwejq5fQrL3X
         w7Q5S/Zwbgl2OK9xv/dC/QdebYzWkGm1nQFqnu/g80puiXSWkUSA/LGVvjJ25Hl5/DkV
         sMDKTcz1N/G/5XMJY2MVQ1jJNY0ZKxkeM6ztzeO9+1ZymEnxXKHDwIeGgNvC8L2RH0qC
         m5Plh8IAEDcgQ/7Vsmm8YVDIXUkwEybV0li2E3VG/jdXQjPNhoBWSi0UYnOs8lEgs9GE
         OtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrT9nrEhpHyZQ9GHRzGCpaZwtCayi8YIIAPDyYkTAsEzFMky2eyUlXkW7MhU0gULUXnITDUL3l9IZUvg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegxnJmU9F4Fk3S8d8r+K95tCjUudWMmMBkEL2JOufWiBRIP79
	zEi5i5V2tu1lS47vGSkACmyZ+g7Y8KK+6ob/NLYv7ZaKlqBNgjfHdDE2CvywdKxK+4IPt/IqdkO
	svXzY1F70Qrc8VBc8FGthly427S2n6MzKeZrdE6itomL1gfz0YaJMeHll/95uzW8=
X-Received: by 2002:a05:620a:4441:b0:7b3:2107:397 with SMTP id af79cd13be357-7b331dc992cmr795518185a.15.1731409421124;
        Tue, 12 Nov 2024 03:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1fhQJCIFJPwzZ+PR7cMWjAglUJ/e3/68X4A0MvFsQcnHnwg/lt4fE0sGY44qyhmK5ZwJw9g==
X-Received: by 2002:a05:620a:4441:b0:7b3:2107:397 with SMTP id af79cd13be357-7b331dc992cmr795515285a.15.1731409420681;
        Tue, 12 Nov 2024 03:03:40 -0800 (PST)
Received: from [192.168.123.190] (public-gprs527294.centertel.pl. [31.61.178.255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf1d2cf5c5sm3562974a12.31.2024.11.12.03.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:03:40 -0800 (PST)
Message-ID: <6565a4ec-6db6-4442-a07f-ace467c47395@oss.qualcomm.com>
Date: Tue, 12 Nov 2024 12:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Konrad Dybcio <konradybcio@gmail.com>, srinivas.kandagatla@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
 <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
 <8cb665f5-4885-4853-804a-7313decc719c@quicinc.com>
 <2c7ece9d-95e8-4d01-a9da-c1d5d7388771@gmail.com>
 <fc676574-ffac-40d2-aa47-8d7cb61b5e3f@quicinc.com>
 <9bd3d4e2-aba1-423c-946a-f5c60da71497@oss.qualcomm.com>
 <f5ceee66-9d09-44f9-9217-3abd467d1086@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f5ceee66-9d09-44f9-9217-3abd467d1086@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: l9cSkdWu3zOZkpL795gWAG-I8LrYo2pX
X-Proofpoint-GUID: l9cSkdWu3zOZkpL795gWAG-I8LrYo2pX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120090



On 11-Nov-24 12:51, Manikanta Mylavarapu wrote:
> 
> 
> On 11/7/2024 8:17 PM, Konrad Dybcio wrote:
>> On 6.11.2024 11:25 AM, Manikanta Mylavarapu wrote:
>>>
>>>
>>> On 11/6/2024 2:42 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 11/6/24 09:47, Manikanta Mylavarapu wrote:
>>>>>
>>>>>
>>>>> On 11/4/2024 7:21 PM, Konrad Dybcio wrote:
>>>>>> On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
>>>>>>> Add thermal zone nodes for sensors present in IPQ5424.
>>>>>>>
>>>>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>>>>> ---
>>>>>> [...]
>>>>>>
>>>>>>> +
>>>>>>> +        cpu3-thermal {
>>>>>>> +            polling-delay-passive = <0>;
>>>>>>> +            polling-delay = <0>;
>>>>>>> +            thermal-sensors = <&tsens 13>;
>>>>>>> +
>>>>>>> +            trips {
>>>>>>> +                cpu-critical {
>>>>>>> +                    temperature = <120000>;
>>>>>>> +                    hysteresis = <9000>;
>>>>>>> +                    type = "critical";
>>>>>>> +                };
>>>>>>> +
>>>>>>> +                cpu-passive {
>>>>>>> +                    temperature = <110000>;
>>>>>>> +                    hysteresis = <9000>;
>>>>>>> +                    type = "passive";
>>>>>>
>>>>>> You have a passive trip point without passive polling
>>>>>>
>>>>>
>>>>> Okay, will remove this.
>>>>
>>>> You most likely want to preserve it, while keeping a sensible
>>>> polling frequency, so that userspace will be aware of the current
>>>> CPU temperature. <100> sounds like a sensible value here.
>>>>
>>>> Konrad
>>>
>>> Temperature sensor's present in IPQ5424 supports interrupts.
>>
>> Correct.
>>
>>> Hence no need to configure polling frequency.
>>
>> No, that interrupt firing signifies crossing the temp threshold (meaning
>> no updates beyond that) or the tsens watchdog barking.
>>
>> Konrad
> 
> An interrupt fires when the temperature crosses a threshold.

Which means you can't monitor the temperature at runtime
without polling..

Konrad


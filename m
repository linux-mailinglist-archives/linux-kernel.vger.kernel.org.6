Return-Path: <linux-kernel+bounces-444762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320A9F0C33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E203282222
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA131DF721;
	Fri, 13 Dec 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcrSlY4g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34D1DF256
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092829; cv=none; b=VcnWfRSqnXCMRclzI1JJ7nVLCkpOB9WumLc/zRiyPVzqNMn7KqWVVTV8QErX97xs+s1Dld7km9guzwEJXQNUJih6uxDNnv03sjBrx8kJRqZrIc6tCQDoajcaA1C1cKQfeeqj9Hkb4KnvPVVphzpEKIak6EgAmRpHZxVLegSMkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092829; c=relaxed/simple;
	bh=awQ6yMFLqYbagPDBPx0q9W776ur7HcZkdEWlrc7lNic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR0YXMoV3sRpBk/rTZQPtHOMki+uDDx8urJ9FeqjNW19XNjLFcl9oIR3aZcE2jlThr1GiXbs4KgUK62yF3t414cUuZfA3YofR//ED/cLU/6rxw5VmBn46QAjZ71+fldSmTRo5F5RITKzPu4LpVZUS3R2ypNQ4PdNGciz0cYfCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcrSlY4g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8RjV0022842
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LPgAkXv7b2t7BMdGT4iGi2WvRyUCin9YR+JLoyKxeDw=; b=fcrSlY4gtj8CmAeK
	LsGGhwkVN/kYEov2zkeKP7WxVACnexyks8lYlGIg+nBc+Dz+8JHGYxFDRNxFX+wh
	r0LOqKxjNv8wZzNOvH/wQVnOnXf/2gngWyTwSoaa+kcRzvIVNeI5Mv3a6CRyhC+4
	j5qj27hoq8cpUhWgWSIpkWQsRxUe8NuD4syGtXUgQ38KYZ/PxF+O94oKzpbbJqND
	cKYkuOumnP7UCq5dbz1XLaNltIfJIEkzHZ2U22YSwdKT24FMuZ5DU+EoHJeKj72a
	jj6NLNjyYtWX6KBkb32wsepUKOUlYBPGKzZP2iSdY73g2ouTYHYXPlVHBuF7jg7R
	lyemRA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wnaegt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:27:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8e7016630so4150396d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734092825; x=1734697625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPgAkXv7b2t7BMdGT4iGi2WvRyUCin9YR+JLoyKxeDw=;
        b=HWzWgjPjemTO3o2GGTZf1St3BQhF/yu22mzhu5eGRdLQhrlHrlkUqIVwoKSFIY3mhl
         DdXkpZPiuMtNTzG2fhab+bLFbdbX+Eerj5t6eejsYe4bXVAI68NvbpmhjxiwamMl5vmg
         dPy6+BXSL0Tl5eGDG2dZYpZe1X6uJfuLY/m+MMs7Gj/VOLy+L1wG1+RVPYld7STubJg5
         dPYODFxQj5CWnmBjBCaXeQxsmeGXzVgOiO5Ra9Egop1m55CjNOuM03MKPyzN5WtKGLU5
         OtqeI2FjEmbgO9gO9VxIh27pLizTjOjG2AQ93fFncOELYQDCtbLWaWw15kdOsFeR2YTe
         IchA==
X-Forwarded-Encrypted: i=1; AJvYcCVXPJQBzv1gOaq3qWeGylkN6rmoBJ8xtfqlUnFC7D9iPLHjpu1bhu29/zrNx70mpr4XQOjMXIOigRWHWXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqd9CHHditI6HEGm8Y+6T4CbfyUvkBmRmFl0GZ/6cmcY7O69X
	ROHcEJOynnHVyIVFkPaHXgO9TfTqz+FBkplq1OSsnZx28bviXWCV0HgJqlIjU+fUeuL2NTYO0Km
	CESaEnWl5Rab3Dg7dGtt3dMBrAJ5RCJQ7I3EV10A+yI5mFYynfcYO8ZRAsBd2nhY=
X-Gm-Gg: ASbGncsKox5lRYRbjvd+VASUuriq7fpK7y7ikcN/8x9a2Qg1zrPSwGoAx85YxUfa81y
	xQcCqlBhUw/WaWwGKGepRS2KD9EuCENK61PD+faCn0u3YwQU7SH7pyR6YWDTmjoneAyR1WHUpyA
	ZykUr62unHlwIjFkw7ahQuCKGuvEMgGl59wWTz0IeaSAG660ZIFZaE8GU1q4E7yS5h6LfeApvgI
	UwyBkKr7qkM93bRA+RwMT7MPfoZbTtcN6zOMkPe5Bc7hOvPg2qxkWT9hnDooqW1V8fWhsSOrc53
	4yed1GoOqA/FXQ2hAj6a/ehUc1ywrHfsm/6a
X-Received: by 2002:a05:6214:1316:b0:6d8:8cb0:b403 with SMTP id 6a1803df08f44-6dc96873dacmr13659726d6.11.1734092825441;
        Fri, 13 Dec 2024 04:27:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIE7i+AV76VWiX+gdH25rKxmzqbBtSlr728v+AI/iX/yXzQgqyvJtusFDFEGgIdGnR/ZcuoA==
X-Received: by 2002:a05:6214:1316:b0:6d8:8cb0:b403 with SMTP id 6a1803df08f44-6dc96873dacmr13659446d6.11.1734092825001;
        Fri, 13 Dec 2024 04:27:05 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3df2fc65bsm8594450a12.54.2024.12.13.04.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:27:04 -0800 (PST)
Message-ID: <3dfdf882-eb1d-498e-96b9-90c6cdcaa44c@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 13:27:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add Huawei Matebook E Go
 (sc8280xp)
To: Pengyu Luo <mitltlatltl@gmail.com>, konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org, chenxuecong2009@outlook.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        gty0622@gmail.com, johan+linaro@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
References: <5b5ad9f7-5071-4b4e-940d-aedecf179600@oss.qualcomm.com>
 <20241213122135.593760-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241213122135.593760-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Dzxp3Rq6G-nx2Q_am_vbbnNv-H7QYFxD
X-Proofpoint-GUID: Dzxp3Rq6G-nx2Q_am_vbbnNv-H7QYFxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130087

On 13.12.2024 1:21 PM, Pengyu Luo wrote:
> I am not sure, huawei even provided the PMGK driver, but I think it is
> not loaded.
> 
> If you talking about adsp cdsp and sdsp/slpi (this one should be
> unrelated), in the firmware driver files, some of them are same
> as the x13s one
> 
> adspr.jsn
> adspua.jsn
> battmgr.jsn
> cdspr.jsn
> 
> as for qcadsp8280.mbn should be different from x13s, in the old days,
> Gao and Chen used firmware from x13s totally, and the firmware didn't
> work (If I remember correctly, can't be loaded).
> 
> As I know, the adsp firmware is tied with many things, even if huawei
> have moved many features to EC, the device still need it. (like normal
> usb function, audio? btw, this device can use audioreach-tplg.bin from
> x13s as well, I am not sure if it fits well.)

The jsn files are just descriptions of what "services" should be used
(including the battmgr service) for the userland utility, and nowadays
we have a kernel driver that does the same:

drivers/soc/qcom/qcom_pd_mapper.c

Start your ADSP with the firmware from your device and post the dmesg
output.

[...]

>>>>> +     chosen {
>>>>> +             #address-cells =3D <2>;
>>>>> +             #size-cells =3D <2>;
>>>>> +             ranges;
>>>>> +
>>>>> +             framebuffer0: framebuffer@c6200000 {
>>>>> +                     compatible =3D "simple-framebuffer";
>>>>> +                     reg =3D <0x0 0xC6200000 0x0 0x02400000>;
>>>>> +                     width =3D <1600>;
>>>>> +                     height =3D <2560>;
>>>>> +                     stride =3D <(1600 * 4)>;
>>>>> +                     format =3D "a8r8g8b8";
>>>>> +             };
>>>>> +     };
>>>>
>>>> This should be redundant, as you should have efifb
>>>>
>>>
>>> I think no, it won't boot up without it(stuck at EFI stub: Booting Linux
>>> Kernel)
>>
>> Do you have CONFIG_EFI and CONFIG_FB_EFI enabled?


Very very weird. Are you booting with clk_ignore_unused pd_ignore_unused
in kernel cmdline?

Konrad


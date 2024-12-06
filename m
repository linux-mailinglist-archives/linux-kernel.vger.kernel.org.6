Return-Path: <linux-kernel+bounces-434983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7409E6DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E218833CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179D200124;
	Fri,  6 Dec 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCqcmWzP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E71D63CB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487381; cv=none; b=ekYIOOnvAH7DC1h2aHSBhF4RuCHuDF8hr45hdk/WqRrHPrTsKiI44EBdKRsdSraX2LR9sN4s/Nq/2rWZ35B1LqSpgQ7luh2Uwn8t2Kammfue3sYufjQ1aDwjVoA4Oh/K+PWHQW4O1kfc+f+Ta2uHf0qUGDLAW/D6vroY0iCA6II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487381; c=relaxed/simple;
	bh=sgr8TfyHIsW2M0ldFdGsnHqIa0HX/kept5tDUtOrpVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Etn7ejxkpqdqHoywEvQmB4BhQUn9QVGfflosKeZhpT0lJzxnxbheZOTTfsv4FNP4cEi7aEHq/awuUQCF0D7/6xj5Lzdh9Crq9FsqX0UUyto+oIyTiROi3B8rvOwse9Zu8dCXfUxGHWPXESoG6R/1CEr0dYpvIsIukK3o7g8v5nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCqcmWzP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B69Sv6T017242
	for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2024 12:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wqn/yXsEWgwFk7d3eySSwki1BDLyTCTQlHP/ia3/cxM=; b=UCqcmWzPLUvv0AHA
	cMNIplYbTUsIo4e4U2Sa3fcfIMBsWElM2xeIx24a1viF757Ja0WkONRXtswdf82m
	zIiiGQGU7nL7I+hasHzKSZf5FY85UqNj1QarBFI0YahiahE5Tf9wohybia2zJFBk
	hmqfLRNlXntHECkusRbnDiyixW3MLanOhj5Y4qaJz9Eax73KWKgnhj81MZiQkE8n
	xdpnnZEkir9fLJRoZpHiyPcBqCpRHWEBMq/9aX2mo6Xmg8tH4dIOAwV2EUNCEeTP
	Qo7soNWQ1rDEll+pzZDq5ghQffzf9D/62d3IynNVEbLifqZo3FPyazNvoQQD/TLL
	5ozFNg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bxny8ep0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:16:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8824c96cdso5228286d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733487377; x=1734092177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqn/yXsEWgwFk7d3eySSwki1BDLyTCTQlHP/ia3/cxM=;
        b=O5rZbcsjwiL9YhnykdsB6KFdFjaqVDPAqjaaALAROpPXe5aeKENcC00AqFub1IM9u5
         vaTvqCrjGN27CZvhmPt8hLg6EZtmWccEsiuKuscYr1wJyYaEFOu9eUdVq+g+f70lqdmL
         /VWcydc4u7y34FePUpRGlTFdmka64ousaPZ90f7zz9VA5uVbw4zEtBYKzsQWzHWcYxd8
         9vxtIUpfC6YgbJRniA+IL+NLcbhDwdWxReJd0oMOUsTlZcrategWc77BDdGweevzxpkK
         mtbQsvrSnxoUM16JJC7zeajJKHY68P6WxLxBY4uOmD2UXTlvLpul8Qc7f/dj4bwIhgik
         W4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNHb1eRTdrSQn1SZkHtgVndI8yhFfJjYhVTEBjXbCHQHCW431Qr5cAWhVVGK419OQtH11WlMhi7xJhIgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYVj3KpnzzUUcFgm9EGk3oEClcN6wY3WZU/QNyrDeAFrhTU7P
	Yd23a9HJEHaEydR+NsSGE9o1bZ4nk2W9uPwVjwXURDLGc837Z6YH0jeeoeRs/rfUM9/td3A1d0M
	l3VP5JFhV5ecODbQTiIGnbNYcA/uWq2WYf5Po7nXRiPBR+YdMpE+CxMC7O3lj6js=
X-Gm-Gg: ASbGnctcSSdr4oVpTJ/eoY2p2J2IN/hf58TxI2nmkKzt0uu0/j2FVfTVHJkaDz5mwaC
	E054yqcuE92+qR73bCwfcMiGe2P6vKcFcfNlp/HngZCqTZ+WivjGKo5Khdaa3G+zRUG9btNaYfZ
	CGk5pO7nRafoYvLCpkpg/86/TMp4+s33WjMReKy6kNzYDnZO7NClyhS4IvWoo6vBmCNIWrZkOiQ
	7/wxYfGI6dwjarhdjrcnY74PWHy+UQT7WWZamw1JcFsxsjUfI7ZqdH8m2F5ADOJOdPXoJ5BXRoB
	XhaTrDREsAEB9eIuSsGkdMEpzHrZB+0=
X-Received: by 2002:a05:620a:298c:b0:7b5:1fa4:852f with SMTP id af79cd13be357-7b6bcaf65c4mr155283585a.8.1733487377434;
        Fri, 06 Dec 2024 04:16:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEETLo4Pi7QkkrYelwKpeurP40wBqMjikrVmWp4FkyL4k13VPynW3pOCmPRkCjhQrr/6mEsvQ==
X-Received: by 2002:a05:620a:298c:b0:7b5:1fa4:852f with SMTP id af79cd13be357-7b6bcaf65c4mr155282185a.8.1733487377020;
        Fri, 06 Dec 2024 04:16:17 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm231473166b.87.2024.12.06.04.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:16:15 -0800 (PST)
Message-ID: <7107275e-1ccf-4f09-ada3-e082833d9364@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 13:16:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: qcs615: add WiFi/BT nodes
To: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: agross@kernel.org, ath11k@lists.infradead.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, kvalo@kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, quic_jjohnson@quicinc.com,
        quic_miaoqing@quicinc.com, quic_vgarodia@quicinc.com,
        stanimir.k.varbanov@gmail.com, quic_jiaymao@quicinc.com
References: <20241203060318.1750927-1-quic_yuzha@quicinc.com>
 <1ca062dd-8910-4caf-a133-0e5717b43540@oss.qualcomm.com>
 <649dc6c0-f0e1-4dca-8f93-d0f81803cd70@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <649dc6c0-f0e1-4dca-8f93-d0f81803cd70@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _9pWcvxlwAOEv77kRUiedZcNNCqpHUeJ
X-Proofpoint-ORIG-GUID: _9pWcvxlwAOEv77kRUiedZcNNCqpHUeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=917 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060092

On 6.12.2024 4:22 AM, Yu Zhang (Yuriy) wrote:
> 
> 
> On 12/6/2024 1:14 AM, Konrad Dybcio wrote:
>> On 3.12.2024 7:03 AM, Yu Zhang(Yuriy) wrote:
>>> Add a node for the PMU module of the WCN6855 present on the qcs615
>>> board. Assign its LDO power outputs to the existing WiFi/BT module.
>>>
>>
>> subject:
>>
>> arm64: dts: qcom: qcs615-ride: ....
>>
>> [...]
>>
>>> +
>>> +    vreg_conn_1p8: vreg_conn_1p8 {
>>> +        compatible = "regulator-fixed";
>>> +        regulator-name = "vreg_conn_1p8";
>>> +        startup-delay-us = <4000>;
>>> +        enable-active-high;
>>> +        gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
>>> +    };
>>> +
>>> +    vreg_conn_pa: vreg_conn_pa {
>>> +        compatible = "regulator-fixed";
>>> +        regulator-name = "vreg_conn_pa";
>>> +        startup-delay-us = <4000>;
>>> +        enable-active-high;
>>> +        gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
>>> +    };
>>
>> Are any of these boot-on?
>>
> Yes, these are used wcn6855-pmu：
>      vddio-supply = <&vreg_conn_pa>;
>      vddpmu-supply = <&vreg_conn_1p8>;

What i meant is, whether these regulators are enabled at boot
time (i.e. without software intervention). If that's the case,
`regulator-boot-on;` should be added

Konrad


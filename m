Return-Path: <linux-kernel+bounces-568143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86AA68EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A335D1725B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B2E1B87E2;
	Wed, 19 Mar 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oUHAbp2d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B271A4F0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393579; cv=none; b=LmpADrOZMrqOnESkvE5dJAjCk3V8CvV4z3wa4q5LGwPT2c+FWEiyOitUbXt449oGIgjJQuaIZ20bjG3fZ9QEJm9vQZqVAmL2fwxlWVY1cHyrBdya88JRA0n6gL3zsAA3pYrGL3nrDXn0KjSb5sFUOXRg/PZ9ZSh73lLVSyM8/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393579; c=relaxed/simple;
	bh=5DWmJ/vB+nuOgG4IiuLkc/p0ct35XmQZ+JB72FIohaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9pB9qWfgDeCVewUEkMsuUkiFQ6kwdmJB05m1JfjPFqhpHPUPRa1i7xaA3LdZ4ZKF0BqnG1VtePsYaF3yIGIqIjKv2+QkPa/LhCvVQXZ8pJFcAEqKgtomdtWZOTFmXFpfQ44FkQgOkl0AxH6nmTSY4+N6qd2LZVKQSr9WzWPJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oUHAbp2d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JDYJli020468
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cKjCn1nbXeoxGr9BwqJAmP/yO1JNx3WOXukLkw7iD0Q=; b=oUHAbp2d8aCOum9M
	3ctc2QwpnAlNaaFGe6/E49g+RNzj5X0YDddSELfvmvLbFU2MTLWSGZ6sEajTMLRB
	9JQFjcR9NRx93kqKatHY3YM6B4n/K0jjm8lM2Rs8gUc67WoxV01oUuF9wBoKDycm
	KZ0KpEE0BTAopQzkndmVMuoOETeKCxGyuSWMT6VfwOZ05bcYeE7WdLve3/6RXyhN
	vSwCgnD5BUKpee/Kb1B++myfQfnTXvqbWVvXlXebDhiwJuwfZzuLoYMyIKOAXN8a
	vQPjSVisPQiAoMnpKwuMWbh0F9CJUFNvpZAuZblCqdTcPRZuq57QrWSdkIEh//vh
	ba3NRA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwtw5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:12:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5841ae28eso98371185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393575; x=1742998375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKjCn1nbXeoxGr9BwqJAmP/yO1JNx3WOXukLkw7iD0Q=;
        b=OGi05BP90yAWumZC12GJDUbiLge0TTlMhkjzSE8mc5I0GdmgWcL+wPJWEhpVHQhg4x
         ykLoFtOTcDpKPh+vuB1B/wQClN6mS56EeihEwbaUF8Hh/ZbwOF7Hl8U4aqIIGuGzaVyj
         3nirCIdMFBweZLeXVbVkx4LgGUb4cW8sWyKi4h58/bt58rTvxd5VTbKq8VUpAet8EkKp
         TooT2rdXNCOOQldQpvIyjMUlBQgixv9BbNDuTSHIEUNROE+Z7L4G6z018+WQQCAzveEy
         /BL1ehcVt8J35z0DQMXVn8cGd/R6gaV4FC9m3eu4bpcGygV0SldoA5ZCFZum8xV9CfNf
         1QPw==
X-Forwarded-Encrypted: i=1; AJvYcCX9p6xxsWpbiGix+RuCBmGhOphg28+Tjrqly2A9+EKPfad7EOLFAJs29TTXkHhtoyTYGFcmj3GWcyvc5U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBSuND/QCvTSdy0qsNlNlBr3fHnrsMFaBL2XKUT+ca/pkrcAf5
	Ek2nwKfFdDsNmy3Km1Adm0msRrySqZorKWoq6styakt6YWvZsOQUimOxv5l1vuZ3UUXghIJyCBi
	84VVk8F6yvc8T4RAztrsLl4N0C91ur1wchyHkwDWtU3NmUQ/aNshawWtgkEAK8zM=
X-Gm-Gg: ASbGnctYHasn3P4vBdNXnNYlEXuezN6m/auhXs/3q/Je+Ynv4bGj8+NuJbNKvPOSyJd
	bi9mSPTJHvRnyHezW80D4AKNWhtPT8+MzfEEHFu6uqEePhDH20N8SHm4FTYFsEKww3jwZT0Ws9G
	slEziX91GDneTD15uosxpyPSq4D7gDHXoelwzuoAXZtuysMYUR+BRZu54EeACeScBHVZvpzBxKQ
	kEaouItQc+mVo7V7asTKRzkRn+rzXPU1l86D6WDo+aKiJMl0rO4LzEKu96A1C+AuH1vhVXeV7YY
	DSEXzoAI02FAzjvflWfkxLrAKVQSWVQ25lG6y7FMFVf1hHZVNI+aRb9WNG50lTOL+VnoQg==
X-Received: by 2002:a05:620a:1791:b0:7c3:cccc:8790 with SMTP id af79cd13be357-7c5a83ed8f9mr153846785a.5.1742393574817;
        Wed, 19 Mar 2025 07:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR5GG5jIo37yigwHHxhBC8JtJGCujFZ5q+enPT07+CLq68F0KYw05pDmn7EUX/s2MRvf6HyA==
X-Received: by 2002:a05:620a:1791:b0:7c3:cccc:8790 with SMTP id af79cd13be357-7c5a83ed8f9mr153843185a.5.1742393574028;
        Wed, 19 Mar 2025 07:12:54 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3a82198eesm209111166b.184.2025.03.19.07.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:12:53 -0700 (PDT)
Message-ID: <38677d30-e2ac-427b-9de6-9e5f1465e7a3@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 15:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
 <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
 <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
 <hkm76yogjp6fjrldkyatekhg7orcd6wkc43d2e7cwzqfrdxjwh@b4f2rilmf6gh>
 <303194d4-d342-ea4c-0bb6-5f5d0297ba23@quicinc.com>
 <xkjozxbchqi6mhstqctejfk7vmwux4kdff2nyrcu5nxqzxv73z@agb7rbapsvx2>
 <f2e67746-853d-8545-133a-13452548d504@quicinc.com>
 <ip7xacfkpv7gf5w3gdgrweo5z7bqxmkfmvgsjfaurk5j5ac6mp@nqccdhunhwws>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ip7xacfkpv7gf5w3gdgrweo5z7bqxmkfmvgsjfaurk5j5ac6mp@nqccdhunhwws>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YT3v19oZ-M5xBwfGh-VK9aATSd9ROJUw
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dad0e7 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=9XCCm2T1sdJvpMR4L6IA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YT3v19oZ-M5xBwfGh-VK9aATSd9ROJUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190096

On 3/19/25 12:06 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 19, 2025 at 04:16:33PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 3/19/2025 3:51 PM, Dmitry Baryshkov wrote:
>>> On Wed, Mar 19, 2025 at 03:46:00PM +0530, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 3/19/2025 3:43 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, Mar 19, 2025 at 09:14:22AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>>
>>>>>> On 3/18/2025 10:30 PM, Dmitry Baryshkov wrote:
>>>>>>> On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
>>>>>>> <krishna.chundru@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>>>> Add a node for the TC956x PCIe switch, which has three downstream ports.
>>>>>>>>>> Two embedded Ethernet devices are present on one of the downstream ports.
>>>>>>>>>>
>>>>>>>>>> Power to the TC956x is supplied through two LDO regulators, controlled by
>>>>>>>>>> two GPIOs, which are added as fixed regulators. Configure the TC956x
>>>>>>>>>> through I2C.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>>>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>>>>>>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>>>>>> ---
>>>>>>>>>>      arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>>>>>>>>>>      arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>>>>>>>>>>      2 files changed, 117 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> @@ -735,6 +760,75 @@ &pcie1_phy {
>>>>>>>>>>         status = "okay";
>>>>>>>>>>      };
>>>>>>>>>>
>>>>>>>>>> +&pcie1_port {
>>>>>>>>>> +    pcie@0,0 {
>>>>>>>>>> +            compatible = "pci1179,0623", "pciclass,0604";
>>>>>>>>>> +            reg = <0x10000 0x0 0x0 0x0 0x0>;
>>>>>>>>>> +            #address-cells = <3>;
>>>>>>>>>> +            #size-cells = <2>;
>>>>>>>>>> +
>>>>>>>>>> +            device_type = "pci";
>>>>>>>>>> +            ranges;
>>>>>>>>>> +            bus-range = <0x2 0xff>;
>>>>>>>>>> +
>>>>>>>>>> +            vddc-supply = <&vdd_ntn_0p9>;
>>>>>>>>>> +            vdd18-supply = <&vdd_ntn_1p8>;
>>>>>>>>>> +            vdd09-supply = <&vdd_ntn_0p9>;
>>>>>>>>>> +            vddio1-supply = <&vdd_ntn_1p8>;
>>>>>>>>>> +            vddio2-supply = <&vdd_ntn_1p8>;
>>>>>>>>>> +            vddio18-supply = <&vdd_ntn_1p8>;
>>>>>>>>>> +
>>>>>>>>>> +            i2c-parent = <&i2c0 0x77>;
>>>>>>>>>> +
>>>>>>>>>> +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> I think I've responded here, but I'm not sure where the message went:
>>>>>>>>> please add pinctrl entry for this pin.
>>>>>>>>>
>>>>>>>> Do we need to also add pinctrl property for this node and refer the
>>>>>>>> pinctrl entry for this pin?
>>>>>>>
>>>>>>> I think that is what I've asked for, was that not?
>>>>>> Currently there is no pincntrl property defined for this.
>>>>>
>>>>> Does it need to be defined separately / specially?
>>>>>
>>>> yes we need to define this property now.
>>>
>>> Could you please point out existing schema files defining those
>>> properties?
>> sorry I was not able to get which schema file you are requesting for,
>> if it is tc956x it is in this series only.
>>
>> What I understood from these conversation is we need to define pinctrl
>> property and refer the reset gpio pin in next series. If it was wrong
>> please correct me.
> 
> You claimed that pinctrl properties (there are several of those) are to
> be defined in the schema for TC956x. I asked you to point out other
> schema files which define those properties for the devices that use
> GPIO pins.

pinctrl-x is part of common schema (see gh/devicetree-org/dt-schema/)

Konrad


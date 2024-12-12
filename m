Return-Path: <linux-kernel+bounces-443588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FB09EF8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5362964D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0722966A;
	Thu, 12 Dec 2024 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVOnnz53"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAD225403
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025374; cv=none; b=MpwXXeK8r9pLB8jxNAG/KG1YcnuRRXOY853FVt4Rko/1a9JjmIN6ASrhWhoeCHYVR7Rxb99Vv3cKCRLAbUS9fwjzuKZuHOacV5V8+fKVXb9DmAcu6l2AFl+oi3WYInu4rcKJ/nVpgkqGwsUGP7/utS/iXmPiowGOWe0v0mj6jIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025374; c=relaxed/simple;
	bh=wAlK88JYcV847qs8c3xWU3FbShcCq8K9khJzpevf8PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmc9yu9H30uVJn45Fwf5l7ohBfVLUhxDLMIl12Fpao8LoLdNlpEI9Ha1ENsFgSxcnA+vsQLq0ImQXNSFW0RLoTwBkBMyOYusWx+i8mCxCsW5striADpiAMiv3mQFqLjgtsxXmsXcK/5SsLq3mKA9CGagi1wi3v6+velLP0SyjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MVOnnz53; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDDcE7000446
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GJcjv/I4Z4KqAcVR7dqnPgSMnHijRfhBkwkSl80xYAM=; b=MVOnnz53VTZ3eoc+
	bEqJR53zHYbDvqzlK8/PXkGz4PgEQw9fjLl/0xK0DZzdsqZ1Uj3ITXxkIKtJMd4/
	5wPE33DdY05p9gK+ftPKD9bjTRTV0mBOjszpP8Id56KfC9q5dejUJK2mZUZ4xVD6
	ndB2kz70TKJUtvORoq9UaAWFOQJilVyXHmEpwj8EGDpBAzYCg0NLTtiLoId3zg9O
	riexURUUjyZlaNkZc9SRTncpe/2wOtUTBqTRAXPc+iNbllR66WqW+QQkC8kVChFO
	NJ4zc+aAy6CuhcLW1DmgGv6mdkKtZkJ2Nvu4n0+CCG7sux5pa6JPiVcVyXgb+lyt
	3RFb5Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes2938-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:42:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8824c96cdso2393086d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025369; x=1734630169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJcjv/I4Z4KqAcVR7dqnPgSMnHijRfhBkwkSl80xYAM=;
        b=gZ5zi8zt/msqe8c1OelPqDwdpnSPnNhWmQEWoZYJAqIXhBMMvySlc5N7jwnLkZI4R/
         DdkY+AClyvZi90hxr4qhJ0ygYAYcZtw8KUy0BoYfVv5wZBavPTSWAzblvzvPtrn7BpUt
         eqvPOD0+zzm/cDEobegMG4WYPvbyfM34cgeOt4XuQQt+yyTq4w/J5bjGt/Vo4qDJ9Snc
         JshkQMZQni6sXUp9j9D7TPQO4CXxu2jvKCvISqbcbhxlOyB8utbxvXgDqb2MygLhJ+do
         /R7nADBtcGAXgmkgtra7i0cyzxOj3XkT/g9r0cQ13OgG2qPlTL4bGpMuj13sC1afTg8Y
         2Z2w==
X-Forwarded-Encrypted: i=1; AJvYcCVBXj/Gf0Eyna+aVg/LfQdzjzseECYFaDQHV0klpg7GsyYm63+sGCpsTOk8o8Q77aG0OnexAsbAk0DH9t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtW3hY/L2/Ijo1U+wmZRglcfEGT6nB9i110UkeL8zgcclumVg
	p/WB+320N//QSZ43HFSXg+GnX/3cvKZgp8vbrgYvvxmr+ulq4nCYwIkNYg53o+PSs/HvYurtyNj
	XIx+gjllb5IUm6y+WWvP9tjFsCKcutu6UxtW6HFvRAkXpgLSEYI2kzZ1Z50CGaO4=
X-Gm-Gg: ASbGnctw068u9fUZDt9QjO0SGC/4Yu8eHwGvhY/PC1K34d/s82mqvQDrRdbbgZWu0vp
	6934+XD7MKJbDIlChW8a/NWOPJZ9HMEgsywHhpfRBXJcpQ+1FAM0Nu86Zk53ULKaSdRlcZ+kCgT
	eDe5L3UDYJYBNXU3hzxs/Eeb1iBUXS2OEY/hUpUyZPWOvqABLxr3xcTy4drtLSSOEPabvLVA4Yw
	dmFyUc7RgGofhiKy7YpMuX6kAGnDvPbe/OMrfOqCNd0VvDZ2xg5QS+0LJ+/rzhcQjOTPlWFpysi
	4m+lLXGNiXs01ZIRak+r6tWNJrG3nEwh10VB8A==
X-Received: by 2002:a05:620a:4549:b0:7b6:d089:2749 with SMTP id af79cd13be357-7b6f8941a79mr61274885a.7.1734025369195;
        Thu, 12 Dec 2024 09:42:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9TEKccAFcMcJnSB0aDrqPhs1h8Hp8GL+jIWcf0PYQWUlYIJEoIbGnr5TfFdrzIRCcorD5/g==
X-Received: by 2002:a05:620a:4549:b0:7b6:d089:2749 with SMTP id af79cd13be357-7b6f8941a79mr61273585a.7.1734025368701;
        Thu, 12 Dec 2024 09:42:48 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6707a5110sm731706166b.36.2024.12.12.09.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:42:48 -0800 (PST)
Message-ID: <efab0b18-f1f0-457a-b1d5-8734f178141d@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 18:42:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Enable Bluetooth on qcs6490-rb3gen2 board
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_anubhavg@quicinc.com,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
 <173386568587.497565.1413799827375300987.robh@kernel.org>
 <3c313557-ca99-4e6f-9d71-641e8c256126@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3c313557-ca99-4e6f-9d71-641e8c256126@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oSpmGHbt22WKNugfVfFoZl6cv5P5FdE5
X-Proofpoint-ORIG-GUID: oSpmGHbt22WKNugfVfFoZl6cv5P5FdE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120126

On 12.12.2024 11:46 AM, Janaki Ramaiah Thota wrote:
> 
> 
> On 12/11/2024 3:12 AM, Rob Herring (Arm) wrote:
>>
>> On Mon, 09 Dec 2024 16:04:51 +0530, Janaki Ramaiah Thota wrote:
>>> - Patch 1/4 Add description of the PMU of the WCN6750 module.
>>> - Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
>>> - Patch 3/4 use the power sequencer for wcn6750.
>>> - Patch 4/4 add support for the WCN6750 PMU.
>>>
>>> ----
>>> Changes from v4:
>>> * Added reviewed tag by Krzysztof in p1
>>> * Updated the p2 commit message with sw_ctrl and wifi-enable are
>>>    handled in wifi FW.
>>> * Added blank line between the nodes in p2
>>> * Placed the structures in proper order in p4
>>> * Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/
>>>
>>> Changes from v3:
>>> * Defined the PMU node and used the its output to power up BT
>>> * Used power sequencer for wcn wcn6750 module
>>> * Split the patch to multiple as per subtree
>>> * Add description of the PMU of the WCN6750 module
>>> * Include separate UART state node for sleep pin configuarion
>>> * Link to v3: https://lore.kernel.org/linux-arm-msm/20241022104600.3228-1-quic_janathot@quicinc.com/
>>>
>>> Changes from v2:
>>> * Sorted nodes alphabetically
>>> * Link to v2: https://lore.kernel.org/linux-arm-msm/20241010105107.30118-1-quic_janathot@quicinc.com/
>>>
>>> Changes from v1:
>>> * Corrected the board name in subject
>>> * Link to v1: https://lore.kernel.org/linux-arm-msm/20241009111436.23473-1-quic_janathot@quicinc.com/
>>>
>>> Janaki Ramaiah Thota (4):
>>>    regulator:·dt-bindings:·qcom,qca6390-pmu:·document wcn6750-pmu
>>>    arm64: dts: qcom: qcs6490-rb3gen: add and enable BT node
>>>    Bluetooth: hci_qca: use the power sequencer for wcn6750
>>>    power: sequencing: qcom-wcn: add support for the WCN6750 PMU
>>>
>>>   .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 168 +++++++++++++++++-
>>>   drivers/bluetooth/hci_qca.c                   |   2 +-
>>>   drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>>>   4 files changed, 217 insertions(+), 2 deletions(-)
>>>
>>> -- 
>>>
>>>
>>>
>>
>>
>> My bot found new DTB warnings on the .dts files added or changed in this
>> series.
>>
>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>> are fixed by another series. Ultimately, it is up to the platform
>> maintainer whether these warnings are acceptable or not. No need to reply
>> unless the platform maintainer has comments.
>>
>> If you already ran DT checks and didn't see these error(s), then
>> make sure dt-schema is up to date:
>>
>>    pip3 install dtschema --upgrade
>>
>>
>> New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 20241209103455.9675-1-quic_janathot@quicinc.com:
>>
>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'enable-gpios' is a required property
>>     from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'swctrl-gpios' is a required property
>>     from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddio-supply' is a required property
>>     from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddbtcxmx-supply' is a required property
>>     from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddasd-supply' is a required property
>>     from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pinctrl@f100000: Unevaluated properties are not allowed ('qup_uart7_sleep' was unexpected)
>>     from schema $id: http://devicetree.org/schemas/pinctrl/qcom,sc7280-pinctrl.yaml#
>>
> 
> Since the DTS files for all boards using the WCN6750 BT chip are not updated according to the PMU node, updating the bluetooth/qualcomm-bluetooth.yaml file will result in similar warnings for other boards.

Oh I didn't forsee this.. You must fix up any bindings errors that
result from your changes (i.e. binding errors are the same as compilation
errors).

That means patch 2 can't be merged unless the bluetooth dt-bindings
are adjusted. And for the bindings to be adjusted, you'll have to also
add the PMU node to all boards implementing wcn6750.

Fortunately, they are all based on some variants of the same SoC, so
they should all have the same power plumbing.

Konrad


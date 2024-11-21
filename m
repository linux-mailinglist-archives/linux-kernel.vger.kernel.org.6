Return-Path: <linux-kernel+bounces-417154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499119D4FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EA41F2298B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A351DC185;
	Thu, 21 Nov 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kc4NtqD5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C181CD1E2;
	Thu, 21 Nov 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202793; cv=none; b=q9ehLG8A0CX5pnPS+tHwFmluDdIhAWxUynKW15G8x6VmNRWNmmDI3iem6nj61OSiqSWu7fZbNhMjvv0cQqIpxKfTm3tLBcTkdgBQ0W92CsRJ3Wque/xA1RkufB8ep2POUQFmI+H2eh0XisNpRYLxB7AGs58nUm6uywlBEtsqh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202793; c=relaxed/simple;
	bh=OHWQm2VRZ1ER4KnT2oWoJP+6nlIkLvtdAABfjToY01A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jvRuM1r3UW1aEcTruaIJK1T4+M6wV/PkGHSmdfwC1bTlQOAJki4a1seTK/zy7nILDKirXvoZptBGYxkife75dNWkdSJCB5UunmsQTCV6m2JYnR0piNEfoqwElnbZzyABWe3BDczYXlez6v3N634wlmWgHx7LM/sVurABolM90cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kc4NtqD5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8xWCA019249;
	Thu, 21 Nov 2024 15:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kRCjDYD4w0WJlkjoLPG8L8w0uuKnmPwbmXPSZA313CU=; b=Kc4NtqD52KWvoCZr
	NBrHn7EgMY9UoX0wAwt0Q9sPBTeImmX1MOudwJqgOmak2W1konuxzID8ummwZadw
	uQqtYCGsyaUkxQE5A8DRNmDufFrM3GRel//m+nwc3C+OnDFYAd+NA+m1DHR5zAwD
	8RrTNu54lDNt2do7HsrJTKRgAcmhArb9n6rsa2Yyd4t4PpLb3W7jNJJ8BeHPF4sp
	C0a9Dup9HcfIe1E/UaWo7xqic4DzJUTQRQg+6ED9wzqIt6nOGs7nhBz7j2KC0x+U
	JMZz/hzOEpXV8UtruGf+Gde07n/5mFwNWKykKqdsHYfYQJE2DMZfNNkDCEy56yRq
	oZ4abQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431c7hmhtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 15:26:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALFQLwV025490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 15:26:21 GMT
Received: from [10.216.32.38] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 07:26:18 -0800
Message-ID: <c12b1668-43c2-4b42-9379-99582e45e38a@quicinc.com>
Date: Thu, 21 Nov 2024 20:56:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add microchip USB5807 HUB
Content-Language: en-US
To: Mike Looijmans <mike.looijmans@topic.nl>, Rob Herring <robh@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.656f2a13-85bf-42a3-8490-f97f2538d8c3@emailsignatures365.codetwo.com>
 <20230522074510.16367-1-mike.looijmans@topic.nl>
 <168474408440.1935852.10036260685386476051.robh@kernel.org>
 <96bc29bf-b601-4852-ac9a-50091698529d@quicinc.com>
 <e3c88450-fbe3-42b9-a2ed-901ffdadfe1c@topic.nl>
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <e3c88450-fbe3-42b9-a2ed-901ffdadfe1c@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BGdlCCllxYGgqSoxenT3z0spYZdQfnqF
X-Proofpoint-GUID: BGdlCCllxYGgqSoxenT3z0spYZdQfnqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210119

On 11/21/2024 3:24 PM, Mike Looijmans wrote:

> Hi Akash,
>
> I was planning to, but the project was terminated so there was no 
> budget to finalize it. You're free to take over and make the required 
> changes.
>
> M.
Thanks for quick response, will push the updated patchset.
Akash
>
> On 21-11-2024 09:34, AKASH KUMAR wrote:
>> Hi @Mike
>>
>> Do you have plans to mainline this change?
>>
>> We are using microchip hub in one of our project and we need this 
>> driver,
>> we have taken your change and able to enable usb hub.
>> Please check if you can push updated patchset addressing the comments 
>> from Rob.
>>
>> On 5/22/2023 1:58 PM, Rob Herring wrote:
>>> On Mon, 22 May 2023 09:45:09 +0200, Mike Looijmans wrote:
>>>> The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
>>>> This driver resets the chip, optionally allows D+/D- lines to be
>>>> swapped in the devicetree config, and then sends an ATTACH command to
>>>> put the device in operational mode.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> Add minItems
>>>>
>>>> Changes in v2:
>>>> Rename to microchip,usb5807.yaml
>>>> Remove reset-gpios description
>>>> Add maxItems
>>>> Add vddXX-supply properties
>>>>
>>>>   .../bindings/usb/microchip,usb5807.yaml       | 58 
>>>> +++++++++++++++++++
>>>>   1 file changed, 58 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
>>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.example.dtb: 
>>> usb-hub@2d: swap-dx-lanes: size is 32, expected 8
>>>     From schema: 
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See 
>>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230522074510.16367-1-mike.looijmans@topic.nl
>>>
>>> The base for the series is generally the latest rc1. A different 
>>> dependency
>>> should be noted in *this* patch.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit after running the above command yourself. 
>>> Note
>>> that DT_SCHEMA_FILES can be set to your schema file to speed up 
>>> checking
>>> your schema. However, it must be unset to test all examples with 
>>> your schema.
>>


Return-Path: <linux-kernel+bounces-184605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F18CA982
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45591C212BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F255783;
	Tue, 21 May 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OUP2FBmq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688851C5F;
	Tue, 21 May 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278366; cv=none; b=ClhkDIkQi1SzpvSjTnTEXrr1N2aTH4DBBSmNBNWBMCfAJ1eP7hZgHw9+N6MQXqwGCkH+sKjuxuVpUd2jbYBJri02lBkDtgARj3iRuccXWHPqlpW7wiOvrsZb96iuBcyqlb7LhdDK0v1mB0KRg3ceAKoPn9URgGEbt/k+etI2Sz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278366; c=relaxed/simple;
	bh=dDzr2Kq7YQW0WMi8zQhoYJ7lugqwpbm3uT3tZIkLV88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qWa1o5U21CPkRpha9K0dyTWwcZkEjVHU0Q0j/cOGpI3W5fEIf+YW5UF6ek5nKt5DQ3LAndUGYwsSvkJK7xguocd474dXZkNaJ5SMjLI5Pa9SU35TO0oOSdZSmKSkdziz65Gzuq+7o7dWGlXWejrYlGEt/dnG+eJ+rWsvx7P/f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OUP2FBmq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L2oMkH014910;
	Tue, 21 May 2024 07:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zIgpIyur9nbJscUg9pxBqZNwhuZ+nxxWucEn5KNslCk=; b=OU
	P2FBmquLZAU8vLzq3SPTEqwErmLztNd6QPa3Ermp1e18eDTZk/4UUUXr3TWEbsnW
	3xDPWLqzTnHeo4EcE2t4EMwS9ZDCHN6/t1CLGb/afx54DWEF33jonBpNoHEA6gxg
	vlpgRal3dxXcM72V+BUMk/bcK9DOZZ1qdqGM7V05jbpntJcAyMWl4p9IV+exeFhU
	0UumwDcYbVi4i07Z01HCk7OMIcKMXR43D5uY4vt6eZ8b9gqldnGcPVE08GjrBwxq
	b1ORaMapANI2dG6miDGZ30OgKxtLfnIdEmqmLz9FoFFgoEt48dr6Gs0V80rUpmAv
	jWJ+r4tOrTaQNwMFe0vA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pq5d72s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 07:59:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44L7x46B023233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 07:59:04 GMT
Received: from [10.216.37.160] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 00:58:59 -0700
Message-ID: <235e966d-ba19-db06-82ea-cd15bff12847@quicinc.com>
Date: Tue, 21 May 2024 13:28:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/7] ASoC: dt-bindings: document wcd937x Audio Codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>
References: <20240516044801.1061838-1-quic_mohs@quicinc.com>
 <20240516044801.1061838-2-quic_mohs@quicinc.com>
 <ff003cb8-460b-4a97-b4f7-990244781209@kernel.org>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <ff003cb8-460b-4a97-b4f7-990244781209@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: szdf7H8SJD3oCrOVaDvgLNb5E0nkuKqr
X-Proofpoint-ORIG-GUID: szdf7H8SJD3oCrOVaDvgLNb5E0nkuKqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_04,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210059

On 5/19/2024 11:30 PM, Krzysztof Kozlowski wrote:
> On 16/05/2024 06:47, Mohammad Rafi Shaik wrote:
>> From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>>
>> Document the Qualcomm WCD9370/WCD9375 Audio Codec and the
>> Soundwire devices than can be found on Qualcomm QCM6490 based platforms.
>>
>> The Qualcomm WCD9370/WCD9375 Audio Codec communicates
> 
> Thank you for your patch. There is something to discuss/improve.
> 
Thanks for the review.
>> +
>> +  qcom,tx-port-mapping:
>> +    description: |
>> +      Specifies static port mapping between device and host tx ports.
>> +      In the order of the device port index which are adc1_port, adc23_port,
>> +      dmic03_mbhc_port, dmic46_port.
>> +      Supports maximum 4 tx soundwire ports.
>> +
>> +      WCD9370 TX Port 1 (ADC1)               <=> SWR2 Port 2
>> +      WCD9370 TX Port 2 (ADC2, 3)            <=> SWR2 Port 2
>> +      WCD9370 TX Port 3 (DMIC0,1,2,3 & MBHC) <=> SWR2 Port 3
>> +      WCD9370 TX Port 4 (DMIC4,5,6,7)        <=> SWR2 Port 4
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 4
>> +    maxItems: 4
>> +    items:
>> +      oneOf:
> 
> oneOf here is not needed. Previously used enum should be fine.
> 
okay, will add enum instead oneOf.
> 
>> +        - minimum: 1
>> +          maximum: 4
>> +
>> +  qcom,rx-port-mapping:
>> +    description: |
>> +      Specifies static port mapping between device and host rx ports.
>> +      In the order of device port index which are hph_port, clsh_port,
>> +      comp_port, lo_port, dsd port.
>> +      Supports maximum 5 rx soundwire ports.
>> +
>> +      WCD9370 RX Port 1 (HPH_L/R)       <==>    SWR1 Port 1 (HPH_L/R)
>> +      WCD9370 RX Port 2 (CLSH)          <==>    SWR1 Port 2 (CLSH)
>> +      WCD9370 RX Port 3 (COMP_L/R)      <==>    SWR1 Port 3 (COMP_L/R)
>> +      WCD9370 RX Port 4 (LO)            <==>    SWR1 Port 4 (LO)
>> +      WCD9370 RX Port 5 (DSD_L/R)       <==>    SWR1 Port 5 (DSD)
>> +
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 5
>> +    maxItems: 5
>> +    items:
>> +      oneOf:
> 
> Again, no need for oneof.

ACK

> 
>> +        - minimum: 1
>> +          maximum: 5
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    soundwire@3210000 {
>> +        reg = <0x03210000 0x2000>;
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        wcd937x_rx: codec@0,4 {
>> +            compatible = "sdw20217010a00";
>> +            reg  = <0 4>;
>> +            qcom,rx-port-mapping = <1 2 3 4 5>;
>> +        };
>> +    };
>> +
>> +    soundwire@3230000 {
>> +        reg = <0x03230000 0x2000>;
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        wcd937x_tx: codec@0,3 {
>> +            compatible = "sdw20217010a00";
>> +            reg  = <0 3>;
>> +            qcom,tx-port-mapping = <2 2 3 4>;
>> +        };
>> +    };
>> +
>> +...
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
>> new file mode 100644
>> index 000000000000..5c76083691ea
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,wcd937x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm WCD9370/WCD9375 Audio Codec
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description:
>> +  Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC.
>> +  It has RX and TX Soundwire slave devices.
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +  - $ref: qcom,wcd93xx-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: qcom,wcd9370-codec
>> +      - items:
>> +          - const: qcom,wcd9375-codec
>> +          - const: qcom,wcd9370-codec
>> +
>> +  vdd-px-supply:
>> +    description: A reference to the 1.8V I/O supply
>> +
>> +required:
>> +  - compatible
> 
> I guess VDDPX is not really optional in the hardware is it?
> 
yes right,

The VDDPX is mandatory supply for all usecases.

will add it as required property.
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    codec {
>> +        compatible = "qcom,wcd9370-codec";
>> +        pinctrl-names = "default", "sleep";
>> +        pinctrl-0 = <&wcd_reset_n>;
>> +        pinctrl-1 = <&wcd_reset_n_sleep>;
>> +        reset-gpios = <&tlmm 83 0>;
> 
> Use defines for common/known flags, like GPIO flags.
> 

Yes, will use the GPIO flags.

>> +        vdd-buck-supply = <&vreg_l17b_1p8>;
>> +        vdd-rxtx-supply = <&vreg_l18b_1p8>;
>> +        vdd-px-supply = <&vreg_l18b_1p8>;
>> +        vdd-mic-bias-supply = <&vreg_bob>;
>> +        qcom,micbias1-microvolt = <1800000>;
>> +        qcom,micbias2-microvolt = <1800000>;
>> +        qcom,micbias3-microvolt = <1800000>;
>> +        qcom,micbias4-microvolt = <1800000>;
>> +        qcom,rx-device = <&wcd937x_rx>;
>> +        qcom,tx-device = <&wcd937x_tx>;
>> +        #sound-dai-cells = <1>;
>> +    };
>> +
>> +    /* ... */
>> +
>> +    soundwire@3210000 {
>> +        reg = <0x03210000 0x2000>;
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        wcd937x_rx: codec@0,4 {
>> +            compatible = "sdw20217010a00";
>> +            reg  = <0 4>;
> 
> Just one space goes before =
> This applies to all places.
> 

ACK

>> +            qcom,rx-port-mapping = <1 2 3 4 5>;
>> +        };
>> +    };
>> +
>> +    soundwire@3230000 {
>> +        reg = <0x03230000 0x2000>;
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        wcd937x_tx: codec@0,3 {
>> +            compatible = "sdw20217010a00";
>> +            reg  = <0 3>;
> 
> Best regards,
> Krzysztof
> 
Thanks & Regards,
Rafi.


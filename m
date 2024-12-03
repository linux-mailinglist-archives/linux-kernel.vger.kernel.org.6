Return-Path: <linux-kernel+bounces-429518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FA9E1D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ECA164E39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8F1E1A08;
	Tue,  3 Dec 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWRDQpjo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055B1DE4FA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231737; cv=none; b=nh14j59Myu01hwnKXxMvaO1j5rt1pkTSDeygqGNDHKlf1TqIeibwRf1P06JxQLL3y3L8txT1gl3RYOH4PGtDuSNMf4iQyhZI4rGPmSXgx0XoI5wr4M27+G5zYyZnCoVtC4pZqnBxrQbNXdFbxgpA88s5FI+QegxR0Bhh2ZQ2DD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231737; c=relaxed/simple;
	bh=+NPaEEWIYefTBr1ED8QNa5xuRbDe5vHJEQkJB5mkpZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+EoIvv67n3Vzizso4qE1P+VS/kIjQw4jXXVCC/sflS3FPKGGpbp5SKqrIZyN2OUlOtIpXWwtfmu4wEsPdm3kWSNc7gBRt9709maJ7P8zT6ISaNZogDrqHY/1BGT4L4rEkqflmSZPD/b+m0AsL3FWOrIpaBIUyE0Ram1nlrTM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWRDQpjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B38uadt026469
	for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2024 13:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOK0liPv4TVk7FI2JPCBS/XyPbuhpQDC9APsqCH7Jao=; b=NWRDQpjo8TUHBjas
	6wX2UFGulEFhPXQSMbRpLfPTD1I/1wZFftSDrMMWOsCFa77vwY0ofW2H8UXvEvCX
	0Al3LihgCq0MfL5HQPskJmG8fVuof/orUbuzSF7f48+iclRS7b0O5cspzC95vsig
	X4qXnx3WFIAwttOIGJveva7EDwfI1G150HI1AnlYDNctZT2MIhsMt6moae9iemsk
	yM7puynGVQOmKqTBGHjTknwVptfOGOD9g55cDNtEpR2N0KZjhJY/sw7CPz+PPljs
	nQpb9WqcNZEhMrFh2NflwZEu10I0eb1Y4QFYFNWMlpjW6TbNuOc/x22qA4VWQKVS
	9Idqfw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437ufe80ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:15:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee0c9962daso5177953a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231734; x=1733836534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOK0liPv4TVk7FI2JPCBS/XyPbuhpQDC9APsqCH7Jao=;
        b=bLs/9UJCPyTK2ZN4rU29N0uEXZlJB4hPqA6Fgnz9ZZd8Mb2tZoU52kZL0HSsGNKbRz
         ucgWxaRLft78xZeq2hu2irAL7Rx3ZldNZwDJdSma2ii6RYPNaapYyY/N7/AF0MVD02Oi
         l3VVvCmrs4IFqUssY82RJTob02YJ4UrHiWI3AQdqX5I04xlRW3ypm7xO3Z8QWdbfw0gf
         EPFIixtj9q1aVgPOnDamDvqjqgg5P64Uw9qtxVUxCZCwLrNxCHSD9vZ/Izj45lYzb324
         JSvEKjCQR8Xjwl0/l8z6tBlPH9rKFHasyqZg+DAvePjXEREQhiz3rAWtPIbF5qVafrgd
         SDVw==
X-Forwarded-Encrypted: i=1; AJvYcCUZWLC+gTReS9vk01OG2lBw2Cq8UcxiBtaK2qw9CrCaiS1O3Vszoc7ueN7OvWBR3wWM7xfo1Edgx7yhuzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCWUgM5cdBLWsTuIu4BdYjRYLNggzGbeEH2Fal4BoetgliVZr
	8Cdbz3dvzIXpKrx0qp1Ivg0/GQpRqU+3NP4ObNGXw1l2+Sr5Pyq5VKf6ArMqG0IZ74RU+OsoDUt
	hSA0tT/HuSjUUSa4s1xsa0q5i/CvpVEGzqrgEgaW+BXpuE/Af/b+xp3tmTbMY9uA=
X-Gm-Gg: ASbGncuUsC0J4tYeGjbV4k0aOda1TSRjcnhVyH8PnqWxfQJGNzN2S5h7IgrAnd1zRVi
	KFN94j5K4dd6QNgNLgxv5Uz6/RW5BLWGWLiV1W8B3N6o0oTFZ3QXKYvs9VSOk6G5bxUtlw5lVEV
	vehEJKQW93EArzkR0qpEeahC4i9XPEG6GHCqV1RIc+1SiJErWz1CAq5Fwmtm+6N5rWoaLgbLiOB
	FbceaOX9gq9JtanR6gjQp83a44JR/q4zU3C11KXH+9AIjcV4DybqEvvK9LYkQShzMTosg8bAUyQ
	GXgFyg9SAFIq
X-Received: by 2002:a17:90b:1c10:b0:2ee:94d1:7a89 with SMTP id 98e67ed59e1d1-2ef011dedcemr3026480a91.1.1733231734088;
        Tue, 03 Dec 2024 05:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw64pLfrf6J3m44FM7ZHDGjsd9KKn4g/o9z71wBvUR/1fQLyIXagLUL9Sj7vaQecZGFOnF7w==
X-Received: by 2002:a17:90b:1c10:b0:2ee:94d1:7a89 with SMTP id 98e67ed59e1d1-2ef011dedcemr3026432a91.1.1733231733653;
        Tue, 03 Dec 2024 05:15:33 -0800 (PST)
Received: from [192.168.31.128] ([152.58.197.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eea91a5ac8sm4722451a91.41.2024.12.03.05.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:15:33 -0800 (PST)
Message-ID: <d095ae2a-3f9d-464c-9dc8-a3e73eac6598@oss.qualcomm.com>
Date: Tue, 3 Dec 2024 18:45:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: Add USB multiport
 fingerprint reader
To: Johan Hovold <johan@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org
References: <20241118-x1e80100-crd-fp-v1-0-ec6b553a2e53@linaro.org>
 <20241118-x1e80100-crd-fp-v1-1-ec6b553a2e53@linaro.org>
 <Z07bgH5vVk44zuEH@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <Z07bgH5vVk44zuEH@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S9jyeRUhuR2dOytZFqDolXQF_3xy3TAa
X-Proofpoint-GUID: S9jyeRUhuR2dOytZFqDolXQF_3xy3TAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030113



On 12/3/2024 3:50 PM, Johan Hovold wrote:
> [ +CC: Krishna, Thinh and the USB list ]
> 
> On Mon, Nov 18, 2024 at 11:34:29AM +0100, Stephan Gerhold wrote:
>> The X1E80100 CRD has a Goodix fingerprint reader connected to the USB
>> multiport controller on eUSB6. All other ports (including USB super-speed
>> pins) are unused.
>>
>> Set it up in the device tree together with the NXP PTN3222 repeater.
>>
>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 48 +++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
>> index 39f9d9cdc10d..44942931c18f 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
>> @@ -735,6 +735,26 @@ keyboard@3a {
>>   	};
>>   };
>>   
>> +&i2c5 {
>> +	clock-frequency = <400000>;
>> +
>> +	status = "okay";
>> +
>> +	eusb6_repeater: redriver@4f {
>> +		compatible = "nxp,ptn3222";
>> +		reg = <0x4f>;
> 
> The driver does not currently check that there's actually anything at
> this address. Did you verify that this is the correct address?
> 
> (Abel is adding a check to the driver as we speak to catch any such
> mistakes going forward).
> 
>> +		#phy-cells = <0>;
> 
> nit: I'd put provider properties like this one last.
> 
>> +		vdd3v3-supply = <&vreg_l13b_3p0>;
>> +		vdd1v8-supply = <&vreg_l4b_1p8>;
> 
> Sort by supply name?
> 
>> +		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
>> +
>> +		pinctrl-0 = <&eusb6_reset_n>;
>> +		pinctrl-names = "default";
>> +	};
>> +};
>> +
>>   &i2c8 {
>>   	clock-frequency = <400000>;
>>   
>> @@ -1047,6 +1067,14 @@ edp_reg_en: edp-reg-en-state {
>>   		bias-disable;
>>   	};
>>   
>> +	eusb6_reset_n: eusb6-reset-n-state {
>> +		pins = "gpio184";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +		output-low;
> 
> I don't think the pin config should assert reset, that should be up to
> the driver to control.
> 
>> +	};
>> +
>>   	hall_int_n_default: hall-int-n-state {
>>   		pins = "gpio92";
>>   		function = "gpio";
>> @@ -1260,3 +1288,23 @@ &usb_1_ss2_dwc3_hs {
>>   &usb_1_ss2_qmpphy_out {
>>   	remote-endpoint = <&pmic_glink_ss2_ss_in>;
>>   };
>> +
>> +&usb_mp {
>> +	status = "okay";
>> +};
>> +
>> +&usb_mp_dwc3 {
>> +	/* Limit to USB 2.0 and single port */
>> +	maximum-speed = "high-speed";
>> +	phys = <&usb_mp_hsphy1>;
>> +	phy-names = "usb2-1";
>> +};
> 
> The dwc3 driver determines (and acts on) the number of ports based on
> the port interrupts in DT and controller capabilities.
> 
> I'm not sure we can (should) just drop the other HS PHY and the SS PHYs
> that would still be there in the SoC (possibly initialised by the boot
> firmware).
>

The DWC3 core driver identifies number of ports based on xHCI registers. 
The QC Wrapper reads this number via interrupts. But these two values 
are independent of each other. The core driver uses these values to 
identify and manipulate phys. Even if only one HS is given in multiport 
it would be sufficient if the name is "usb2-1". If the others are 
missing, those phys would be read by driver as NULL and any ops to phys 
would be NOP.

Regards,
Krishna,

> I had a local patch to enable the multiport controller (for the suspend
> work) and I realise that you'd currently need to specify a repeater also
> for the HS PHY which does not have one, but that should be possible to
> fix somehow.
>  >> +
>> +&usb_mp_hsphy1 {
>> +	vdd-supply = <&vreg_l2e_0p8>;
>> +	vdda12-supply = <&vreg_l3e_1p2>;
>> +
>> +	phys = <&eusb6_repeater>;
>> +
>> +	status = "okay";
>> +};
> 
> Johan
> 


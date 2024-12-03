Return-Path: <linux-kernel+bounces-429780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DA9E2444
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DC16CDA2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE0205E2E;
	Tue,  3 Dec 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XD/PUHdv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A31F76B0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240255; cv=none; b=DaCvW3mval18v2DqEMDBy1wd3yYpQInxMVitz2rwvZQ/tMIqCy4ikSIGhu/vJxI+2XCZlfcq1XslaqNGmqjHQhzYBkwYP88Q6KjjR8uhvSFgrBd/gZYm2FaX9OlWGKkqgQ96QxwdaMFIQVWmLevHglz/v7amg0qJgdH9+wzRnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240255; c=relaxed/simple;
	bh=fO/qh5sqTmf1eBA7gFi+J1C/OQQ+064q95v0fANMQ3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaPMDqixKzVEYAwsbghxPik3r7IW32MK50SyNqT41YrVPkeDc7nMNlp40lS/OHGVVAmhcRAJNIz+/OHD5ZGx29d6wWr/UqG6n+KK4r4Uuilaev1T7JvJfQmU1n1KiOR+WhKjOQqdPoaKWtIIKEXTVD76XzIApvJPXtnW17dd23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XD/PUHdv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3FXk7d010103
	for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2024 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WVsAf3br7q2QiAZQkRJosEe0peHLoK9e9ACnt+YXgwE=; b=XD/PUHdv0pH24DGj
	QktgXOvaT1YY7+tqc+sgFM6pJkrFYRvvxXEqjtw1dSD7jCicsW4iTFdW3HiSbkTV
	ASikHoLrlvz00Cm+zbDh1SHI6CQeEQiRIL9c2SSAekoxzsYOuw+w2DTtKzm612mk
	r/uu/ASE56q8BW3hia+/A2B42PTA7tN/HaR7r/2MCVY/V2/GeHeooLnZJlPI6eaj
	kAij6dxg7dAJiq1qGxSk+etXFAnwNzrDjI+vjitoWWqy038DcNEytwb14Vztyt2y
	Z6gLrF4nsybrJsXcqnbNlpmwFGPIhdlYlaxHydpZEaWCko4sD5fU5cdx2HAi1xpi
	yX/3Iw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v7ysf3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:37:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee964e6a50so3939827a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733240251; x=1733845051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVsAf3br7q2QiAZQkRJosEe0peHLoK9e9ACnt+YXgwE=;
        b=rklEF/nS9zYzkiLR5Awf+zMwawY2MRZvlWRU3XTr6MMQDNleKqDQznGSYfuPL1/vaw
         aGCBvC+MAiD+VJosXprd3oYFyh61P5b42d797vEND9xmcBo9dh/Ma4U2tki/yP6GI/7/
         MfUk3VcBtnSfx00Icl/7icSFxN4k2bh2PW8AOp3//xbKoTvFkwnhQpecanHLJM6ekCj/
         LM1puVfSTPWgnJYN0UAigAKoOMtWKbGztZJ8Aj5TqXj++HBryxe/PDf09Gob+pJKfaDZ
         ZWKeh++zmkv7fwCOof5jqN55o+k5EF3vsMaQWq0LIMGqKY93Ep5cOWdqTsZMh3FL+FWh
         Z4gw==
X-Forwarded-Encrypted: i=1; AJvYcCWGoVzl1O3eOzTkZ3CXI9rhZhnlKp8LABMnDXfA5NfbIRvCM/paQe7+PL5xRtvkkhVmBWCa4xNQhBUolcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdGT/Fwa9t2/nb2CIREuJuqRUDzGVxwp0t+vVd4wtSWT85X0+
	6BEV3xABZ1qCNNDAlPF+/t8gxS1UJm6WRFRzR/Fn39n7Bi8ndkZPDtPEGZpxUKdj9uiQhiLyL8/
	/XqXtdtU2Iv9S57T4CWQTHLv44lwnoQ3uhEpNdz9UbFhtyfAdL7XNFuGXXxQCaLY=
X-Gm-Gg: ASbGncsgE7NcDxyMY7QH+KdKw1pCxq+Igu1D/958gS5F/0+N4Tbo5RKa7Js0cC1PiVN
	nsj0jo2lm61opeubaTs+IBJ3aAN+CQFUg7CcXFU3E1gTyhMTGJFuKLmiFFlKOBKrBKTiosKu9pO
	XZFacdj5JgahRDOwE/v4BkdVuIDN8JKp//Jgb58sWnx8OPwD/6FIJ1eSrueDMODufMA2pdZX1zU
	oeZyVmi+ZZ8DX6s4i5A6qPaMg6KIVXtl+oVcHGmRDN001PtF+VuqwOOmhbYTgNopN0IU2KFTnZ4
	7H55QG0Fatvd
X-Received: by 2002:a17:90b:4e90:b0:2ee:a58d:cd96 with SMTP id 98e67ed59e1d1-2ef01204128mr3593126a91.18.1733240250762;
        Tue, 03 Dec 2024 07:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1wCFkJuDY3iAo1YW3xzVreeVpHJUxKTejY6gq824aM6cXlEoKfgBRQ345ghJyDtEXjV2f1g==
X-Received: by 2002:a17:90b:4e90:b0:2ee:a58d:cd96 with SMTP id 98e67ed59e1d1-2ef01204128mr3593087a91.18.1733240250314;
        Tue, 03 Dec 2024 07:37:30 -0800 (PST)
Received: from [192.168.31.128] ([152.58.197.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee488af41dsm8955256a91.28.2024.12.03.07.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 07:37:29 -0800 (PST)
Message-ID: <41106fd7-5348-4d21-9ae7-8466f5634b4c@oss.qualcomm.com>
Date: Tue, 3 Dec 2024 21:07:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: Add USB multiport
 fingerprint readery
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Johan Hovold <johan@kernel.org>
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
 <Z07bgH5vVk44zuEH@hovoldconsulting.com> <Z07r3Upr50vLluyn@linaro.org>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <Z07r3Upr50vLluyn@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h_9XA-v3L7TH8I0FHowSSTLcG-VAWbss
X-Proofpoint-GUID: h_9XA-v3L7TH8I0FHowSSTLcG-VAWbss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030132



On 12/3/2024 5:00 PM, Stephan Gerhold wrote:
> On Tue, Dec 03, 2024 at 11:20:48AM +0100, Johan Hovold wrote:
>> [ +CC: Krishna, Thinh and the USB list ]
>>
>> On Mon, Nov 18, 2024 at 11:34:29AM +0100, Stephan Gerhold wrote:
>>> The X1E80100 CRD has a Goodix fingerprint reader connected to the USB
>>> multiport controller on eUSB6. All other ports (including USB super-speed
>>> pins) are unused.
>>>
>>> Set it up in the device tree together with the NXP PTN3222 repeater.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 48 +++++++++++++++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
>>> index 39f9d9cdc10d..44942931c18f 100644
>>> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
>>> @@ -735,6 +735,26 @@ keyboard@3a {
>>>   	};
>>>   };
>>>   
>>> +&i2c5 {
>>> +	clock-frequency = <400000>;
>>> +
>>> +	status = "okay";
>>> +
>>> +	eusb6_repeater: redriver@4f {
>>> +		compatible = "nxp,ptn3222";
>>> +		reg = <0x4f>;
>>
>> The driver does not currently check that there's actually anything at
>> this address. Did you verify that this is the correct address?
>>
>> (Abel is adding a check to the driver as we speak to catch any such
>> mistakes going forward).
>>
> 
> Yes, I verified this using
> https://git.codelinaro.org/stephan.gerhold/linux/-/commit/45d5add498612387f88270ca944ee16e2236fddd
> 
> (I sent this to Abel back then, so I'm surprised he didn't run that :-))
> 
>>> +		#phy-cells = <0>;
>>
>> nit: I'd put provider properties like this one last.
>>
>>> +		vdd3v3-supply = <&vreg_l13b_3p0>;
>>> +		vdd1v8-supply = <&vreg_l4b_1p8>;
>>
>> Sort by supply name?
>>
> 
> Ack.
> 
>>> +		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
>>> +
>>> +		pinctrl-0 = <&eusb6_reset_n>;
>>> +		pinctrl-names = "default";
>>> +	};
>>> +};
>>> +
>>>   &i2c8 {
>>>   	clock-frequency = <400000>;
>>>   
>>> @@ -1047,6 +1067,14 @@ edp_reg_en: edp-reg-en-state {
>>>   		bias-disable;
>>>   	};
>>>   
>>> +	eusb6_reset_n: eusb6-reset-n-state {
>>> +		pins = "gpio184";
>>> +		function = "gpio";
>>> +		drive-strength = <2>;
>>> +		bias-disable;
>>> +		output-low;
>>
>> I don't think the pin config should assert reset, that should be up to
>> the driver to control.
>>
> 
> I can drop it I guess, but pinctrl is applied before the driver takes
> control of the GPIO. This means if the GPIO happens to be in input mode
> before the driver loads (with pull up or pull down), then we would
> briefly leave it floating when applying the bias-disable.
> 
> Or I guess we could drop the bias-disable, since it shouldn't be
> relevant for a pin we keep in output mode all the time?
> 
>>> +	};
>>> +
>>>   	hall_int_n_default: hall-int-n-state {
>>>   		pins = "gpio92";
>>>   		function = "gpio";
>>> @@ -1260,3 +1288,23 @@ &usb_1_ss2_dwc3_hs {
>>>   &usb_1_ss2_qmpphy_out {
>>>   	remote-endpoint = <&pmic_glink_ss2_ss_in>;
>>>   };
>>> +
>>> +&usb_mp {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_mp_dwc3 {
>>> +	/* Limit to USB 2.0 and single port */
>>> +	maximum-speed = "high-speed";
>>> +	phys = <&usb_mp_hsphy1>;
>>> +	phy-names = "usb2-1";
>>> +};
>>
>> The dwc3 driver determines (and acts on) the number of ports based on
>> the port interrupts in DT and controller capabilities.
>>
>> I'm not sure we can (should) just drop the other HS PHY and the SS PHYs
>> that would still be there in the SoC (possibly initialised by the boot
>> firmware).
>>
>> I had a local patch to enable the multiport controller (for the suspend
>> work) and I realise that you'd currently need to specify a repeater also
>> for the HS PHY which does not have one, but that should be possible to
>> fix somehow.
>>
> 
> I think there are two separate questions here:
> 
>   1. Should we (or do we even need to) enable unused PHYs?
>   2. Do we need to power off unused PHYs left enabled by the firmware?
> 
> For (1), I'm not not sure if there is a technical reason that requires
> us to. And given that PHYs typically consume quite a bit of power, I'm
> not sure if we should. Perhaps it's not worth spending effort on this
> minor optimization now, but then the device tree would ideally still
> tell us which PHYs are actually used (for future optimizations).
> 
> For (2), yes, we probably need to. But my impression so far is that this
> might be a larger problem that we need to handle on the SoC level. I
> have seen some firmware versions that blindly power up all USB
> controllers, even completely unused ones. Ideally we would power down
> unused components during startup and then leave them off.
>

This question might be a dumb one, if so please ignore it.

But if we skip adding unused phys in DTS node, the core driver wouldn't 
have access to all phys and we wouldn't be able to get references to 
unused ones (un-mentioned ones in DTS). So how can we power them off 
from core driver if we don't have reference to them ?

Regards,
Krishna,


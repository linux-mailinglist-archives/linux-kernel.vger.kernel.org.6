Return-Path: <linux-kernel+bounces-566495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F296A678C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A447A7CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33492101AF;
	Tue, 18 Mar 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjgqsM2r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE320FABC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314296; cv=none; b=E88PrdcU4PZ+PTqBU0Al+Lcg9RH/VBNU9P77C5RwxBrvcWExEW+/4AOTz9ip2bZ1NvZrrbopM2UDejklD5FI3vmXWdTx8BWui4Nxi2XABMgGkNvEbcM+pVDYy33bBob8Ep7k4OSFeSaKvyvc/QVFpbWHQibe90ie1OluW/lYx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314296; c=relaxed/simple;
	bh=eyFDJE4YRl3b2EEj6y8xT7rbh/9hzJ7Y5/dRWTDk1b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlMgx+Gf/GFpGtNdJJSfmMo5NXBr5N4OQXPDjSjzKsX6Y1hRzZ5aJlkC822U6pvz1WK9qeOPTqONxsYPPRdVGlb1XKoPGtElKd5as2QJPJZjgsAoNKmHAsJ1aAdCYoyIRLErWZTVFNFHED/YuugxyIrey2qDCj1/FSFOmvSLTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjgqsM2r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAjroD020855
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cM8AZCQm2iZ9HJ9wuCI4b2L0bxljhZ1yX+T89jHuzZQ=; b=RjgqsM2rFGN8p1tD
	DxdRLIoVkkaqG6ZgaIm2Mh7xMj8shM0hA75hwi6vy5Zh6Q9PIoCoyf/9PA6aBw3l
	eawJVpn/KwKbQpTcAwiWXxjAgLSnPJ8260Q07KKzl1JQNH+sHgE4sAIBgGwu86RD
	OJIHUwI1ZapnnJHgMXadRiXYTZSpN1nuVaY5US2eXSEMzEt/ftAN9VUN/0jvsg6i
	nRTI1Wwy00/zNY3vnz/uWB00eyJwY0B/TMB5rqn6aLcvPv8JbPQiLOeOcdsMTvLI
	5qbn+8ZCfG9zkOn3/VS8Igzr4nAisFqW1UXQ7QToFXyB+X9JezysHhcmp5B/KNFA
	hA/CPA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exxbjdt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:11:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225107fbdc7so93413175ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314293; x=1742919093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cM8AZCQm2iZ9HJ9wuCI4b2L0bxljhZ1yX+T89jHuzZQ=;
        b=sbqp8ztmmbLMyUg8yKgIdRfY2HUqq4ObPlmTdFlqJ4M2EX+FrijD+g6ok/nAnnyW2J
         6LOOMAXbCgxd+2Bdo2IZIGhsnBP/kChFtg9lEJwMVnas5fDEHRL6XK5uVmDkMIWVWzhA
         /SzNY4yRnafJ+2LbO0gcOg0nJdl1ise7rvsfU8AqZAb6zSAucMGt0Sorq0dPHKUYgx4Y
         G4xPIhLoqUMQ4iIB1fNipNnQzYwOAIsNqJ2WOxyq4Id9yLS6O7UN3HQmXa97kEPSHgC/
         Ra6wW9uaDVodZ45VCksYX5pfTX8sAWsQ0pKvKm4Ud/duyEAf+PDSYHdE7VF3jo5UWFr2
         Nahg==
X-Forwarded-Encrypted: i=1; AJvYcCXXnkr5BnzW+JFRmpEh662oRYpJ7/TX9vHHCTk6qHxVusBdOnsFDJ5qoYhDPJgeaFK3i/NvYXsx2rPFEUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTGfmgNYYWTHYYI2M5mBnC2UgIpMPv+ybIFOBqSJwh/IfsYDd
	zwQDLaAP0r4i8Zki3zoqF8rBK0czdUiVsqGdC5bUWY/2a2e+LiqL0yd724Hsot91n3KSQ3TTwSw
	aIGOiybOiv9+PdmIhdzxx84tsVA8lWUn/tNmSZ1L3MtSc1JU7NyQ6/7bgZ3+jRI8=
X-Gm-Gg: ASbGncuH8f6pR+x242CpgnEp7gEnWsNmpzsqZtbBi6ycBXKS+DKIrLQ1dzUgTV4cH/f
	EYGO45474HQgFDFj2JM4WpnlVe0ocIgcMZFn1e2Ff5I0+RL3OFWKTfxWl7OsGq+OsFg+nrX/3ME
	0S99MlkLuvFwP2XTAP17ZYSUp75z6yUSnFLx39XjKL//FMWhl95hhU+T2cad7zYkNSiSFFCvMhG
	nQIr+VdKrhJOlLWsswD6EvvUv8KsjTCZvPg1d6O2TouLHiBQ9msI7R6I8T8FUgcY3BRYKe9jS2f
	DZcDk3gO2x0Z/8TQOVe4twQsAR/uXvFRzct8w4amolTtwQ==
X-Received: by 2002:a17:903:40cb:b0:224:a74:28cd with SMTP id d9443c01a7336-225e0ab5216mr226833885ad.31.1742314292636;
        Tue, 18 Mar 2025 09:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDWxl7Dn7VJ/dGBJeY8Nm/beDoadgREWVQ+bpzZHWe/2JguBoReZYgna/7NMPu2dIQzrTEQA==
X-Received: by 2002:a17:903:40cb:b0:224:a74:28cd with SMTP id d9443c01a7336-225e0ab5216mr226833365ad.31.1742314292246;
        Tue, 18 Mar 2025 09:11:32 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.228.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d0asm96645755ad.130.2025.03.18.09.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:11:31 -0700 (PDT)
Message-ID: <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 21:41:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QN1oRhLL c=1 sm=1 tr=0 ts=67d99b35 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=gzHQz5DndFXDghOZWxpFUA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=WTmwj_6TxTBwwd-b0B4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 5IyR9DYeWoMPuxPMFBss3SxLZIf6WGjr
X-Proofpoint-GUID: 5IyR9DYeWoMPuxPMFBss3SxLZIf6WGjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180119



On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
>> Add a node for the TC956x PCIe switch, which has three downstream ports.
>> Two embedded Ethernet devices are present on one of the downstream ports.
>>
>> Power to the TC956x is supplied through two LDO regulators, controlled by
>> two GPIOs, which are added as fixed regulators. Configure the TC956x
>> through I2C.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>>   2 files changed, 117 insertions(+), 1 deletion(-)
>>
>> @@ -735,6 +760,75 @@ &pcie1_phy {
>>   	status = "okay";
>>   };
>>   
>> +&pcie1_port {
>> +	pcie@0,0 {
>> +		compatible = "pci1179,0623", "pciclass,0604";
>> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		device_type = "pci";
>> +		ranges;
>> +		bus-range = <0x2 0xff>;
>> +
>> +		vddc-supply = <&vdd_ntn_0p9>;
>> +		vdd18-supply = <&vdd_ntn_1p8>;
>> +		vdd09-supply = <&vdd_ntn_0p9>;
>> +		vddio1-supply = <&vdd_ntn_1p8>;
>> +		vddio2-supply = <&vdd_ntn_1p8>;
>> +		vddio18-supply = <&vdd_ntn_1p8>;
>> +
>> +		i2c-parent = <&i2c0 0x77>;
>> +
>> +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
>> +
> 
> I think I've responded here, but I'm not sure where the message went:
> please add pinctrl entry for this pin.
>
Do we need to also add pinctrl property for this node and refer the
pinctrl entry for this pin?

- Krishna Chaitanya.



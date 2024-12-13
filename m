Return-Path: <linux-kernel+bounces-444317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28339F04A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9ED188BAF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487218BC3D;
	Fri, 13 Dec 2024 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J5SftBCY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E9185B56
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070351; cv=none; b=UGWQSH11yZQkO9hJfizd6n4B+3vlYyfiBDlu0XyY+aqlfMPiF6hBvD7pabIDLOI2/VapwIrdWRFIS6lhJBWB38Ob2d/n/EOh83F9AOkTptQZdDlrxXw11n5+y20ShrLiBod9RISzipZk/q4773AfVwd+fEFsDpDvyJG0TfhVdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070351; c=relaxed/simple;
	bh=Fd3/VWN2N6P5eVMa35mdJbmYGdNDz/fHyVveuRA/u8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz+kHmon26x71Vgygc3q41ZjfwO//Z5FtHKAmKHhQgFCaaMQ4p8GEpQQfx63P93/b8O06O4Ummi74iJ5Lsy6HGNavvmHDQlcDO/jwQxzpHQF6LldeufGsHZ+z3MEi6wXsJ/Ms1rd2EO1CU83smkTbAng17kjyDaqRdO0XdnQDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J5SftBCY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHcWsh031003
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wwe1OOBMeBw4pTIdS1aMnLDqOgTpzuUj5DXnIN3oiDk=; b=J5SftBCY/6zqvHzO
	PPYIRDshHwrZ0dGhsQhW9Q1Znb1MHMRIZL/7VOE2W73k7XEXolLgoowsT7rbNqYI
	yXTDO3mZgvIir/3TN0u5wcx4BZHBy5DmPg0VFKs3JWVtcaI3ZpirI5RJdHSNSDs8
	y8aandTof1iuouz2nhbVglwe273TJn44BujdKvWM0cf8y/99lR8yTWOeAApVM35I
	DuhLJdVSMosvyVc+ml1cEB4fjTXrcBZQVcm3z53G/giIzWOSB+PO18NXQEO4Xd/w
	5vLAn/bsFJF/ub1F8rkol0KTh9l9lVPVxofXMhDZBvDBUoRzBnaAr5ESOsi5lMPL
	ZYdQgg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw4dn45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:12:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166e907b5eso15401385ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734070346; x=1734675146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwe1OOBMeBw4pTIdS1aMnLDqOgTpzuUj5DXnIN3oiDk=;
        b=C/2XawyZJ/kbZlDWSakxPvXrlAvDLgNAQyYMRxr8B4ncqcWBMIMiDjrTDlPhsMtnX6
         lgbhK/Fxh76UQeF/DgddA/bjtj9FEU1mLFtE3ydxosDhXHVh/l4yU6a5eLZCizEgDzy4
         y52CLQs5ItVtTPKp9KpuDDCI/9SG/aXkl0XAwLY7elkMPLfF/oMnCTyXeCbeAnxk3laY
         QN33B/CISk90TUg+7cXT0RgBafXeNYYWQi10VRCj1oVweNmoJYbd7dxkS8G+Y+63JSPK
         O+/ykSU5M3LY9LtSf+JMD+d31DFijeQSooC52bLrq0TcucV+wRAo7nJ0Kf3xVvEo0FRA
         ka3g==
X-Forwarded-Encrypted: i=1; AJvYcCUTpbPMx1rXp5+LdIXzfYBhQPBgIFHlYGuYjojCr3CyYgaAKcdz/ddbs7YQOdb6hHxCtFzX6QQm9KoFd3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd5bmlDoHkV0GKB+2XYkUeqpCpuruY9xte9r4MSP+mkGs+/zry
	Pnxh6O/S75mVzvUb2Cjh3DOTYbrZ81514y7XiDN9Vk7iQl/Ml6egeOyPk8QDFfCCt6RFQLDEOQM
	v0V8wUisUY9D+hf+DbBUXVNdJT8rRAduyIpEYyI8zmQy56C4BQ2MM3Pyz7NdptiTiL0uQ8Dg=
X-Gm-Gg: ASbGncv+QMg4BHTvB6wclzEnVdL8UMGCoIrSvvPWytXeBZOj35gEOIZgD+6k5aBt6H7
	LWb84ik8k+v0kRcblhByZR2ckDCC8Up67wMNMWbf811WzVjODEaByEDqXx3Pz05PZnt72nOLvOz
	XQx2j0fUmIXveoqkHqVMIzhkecszZej9H2HDAeqsCNG7rFae9INIItICXpJ+r+icKVsXBsqpy33
	0yzrYlC/8yX7Hti9BEvIcrUFDkPPr1RsEM7sGZz3qGfmTTHUPB0sxj9Z2VkcbG8p3mk3K+TMKfX
	m5Jx+pShvgd1
X-Received: by 2002:a17:902:e883:b0:216:725c:a11a with SMTP id d9443c01a7336-218929994ccmr23468395ad.10.1734070346484;
        Thu, 12 Dec 2024 22:12:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwZo0qz6/vneMrabgMrN7CpSW2+2zGTs7N3GavcOTZPNZVDSST77pmI8yugosIUdToCQZjnA==
X-Received: by 2002:a17:902:e883:b0:216:725c:a11a with SMTP id d9443c01a7336-218929994ccmr23468155ad.10.1734070346118;
        Thu, 12 Dec 2024 22:12:26 -0800 (PST)
Received: from [10.92.163.196] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2161e5a6f23sm112693745ad.266.2024.12.12.22.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 22:12:25 -0800 (PST)
Message-ID: <b7452fd4-cd9c-4e09-8524-ecc4b60ae90d@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 11:42:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add support for secondary USB
 node on QCS615
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20241211-add_usb_host_mode_for_qcs615-v2-0-2c4abdf67635@quicinc.com>
 <20241211-add_usb_host_mode_for_qcs615-v2-1-2c4abdf67635@quicinc.com>
 <5943f27b-1123-44b3-b93d-56fc45512d3b@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <5943f27b-1123-44b3-b93d-56fc45512d3b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EqpxleAYoX2IBROTZK3sDVTXor_DivWN
X-Proofpoint-GUID: EqpxleAYoX2IBROTZK3sDVTXor_DivWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130043



On 12/12/2024 11:40 PM, Konrad Dybcio wrote:
> On 11.12.2024 9:26 AM, Song Xue wrote:
>> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>
>> Add support for secondary USB controller and its high-speed phy
>> on QCS615.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> Co-developed-by: Song Xue <quic_songxue@quicinc.com>
>> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615.dtsi | 76 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> index b8388dcca94cd8f4e6f1360305d5f6c7fff4eec3..651c6c8b8bc40886139fa235874e834928e14e77 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>> @@ -3079,6 +3079,20 @@ usb_1_hsphy: phy@88e2000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		usb_hsphy_2: phy@88e3000 {
>> +			compatible = "qcom,qcs615-qusb2-phy";
>> +			reg = <0x0 0x088e3000 0x0 0x180>;
>> +
>> +			clocks = <&gcc GCC_AHB2PHY_WEST_CLK>, <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "cfg_ahb", "ref";
> 
> Having this be a vertical list would be nice
> 
> Nonetheless, this looks good and the magic numbers all line
> up with what the computer tells me. You may want to check
> with Krishna Kurapati whether snps,parkmode-disable-ss-quirk
> here as well.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


Thanks for the review Konrad.

This is HS only controller and this quirk is not necessary.

Regards,
Krishna,


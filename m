Return-Path: <linux-kernel+bounces-566142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C14A673C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D95C1753B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72620C001;
	Tue, 18 Mar 2025 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+JQGd+C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBD1C5F06
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300580; cv=none; b=VMSKlKZ1FHpie0bfxIfG8QcyRy/HiPw8PfeW1khWc2V/QrOUx42RhjVjznQ0kWDSKxGY5LTDHtuEEM+3b+fg7WdHUogYKJld2rVoyRXUbq4LV3AIQjKjZ5UDWPQ0vZXFljk/g4p/0fxniPv+iPSc1FH5DCYYrYAopr14xAqJhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300580; c=relaxed/simple;
	bh=z7MHbWA8wTh6DUp+/c7Elu1kyk7stQvuEEcp95epsUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrWYKMGf1cR8Sp7R2O5kXy5IxYopFRLvS86j5LHoVvQOJDVXkQxlguhV0sMvgCxFhu7j6yL6QHtiaDQgOgT6TDZgiq24e1TUyCWakyRrsHDzxnLn2pdMy65A4xwDKWoo5mlPWAM6BKSbIJ4Plh4m6iSsZQ/blqYetCY7m1pO30c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+JQGd+C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IA3ODI011322
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i14HDXOoyA3/EpN59E7vZh8BMFz4S9zJS+p548JjvvM=; b=D+JQGd+CFfFJrCIq
	pXhAG19cTtbo93pCdEUY7l68gjFVVmHLYwkzzA8dKQwrmvVKeZdLqmZhRACAQoX7
	u3b5sFGQ5Du4zx0EOgMcckaH/XsCdAYm6AkAuPVtWVypwXCPYirev5b3w8xm0bFi
	jDLtMEht4aRJFRnZAaF80OfqgyYmG7PPhAGgzcteh+oIA8rJk5J8XtPA0ehrfVeK
	8970sQxE7kVixQ2xPMManL9L6XLZflVJgDdHZvPd69FhcA9VHwSfZ2VWVdZlTUFI
	ibG64FePKlmJKRQkg8Qrho7ZUV9yvAo/X+kPS0v4Z7AlSId9x/BV07azlAoeETHZ
	F7VRzw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx31rat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:22:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c547ab8273so34681685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300573; x=1742905373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i14HDXOoyA3/EpN59E7vZh8BMFz4S9zJS+p548JjvvM=;
        b=snIyKc4xB+ixx3M7JhqWpWcTYGfzaEUGdRP/Sh4VE6l1nGHwNtvtGkm3d+fLgKZWdE
         AW//Wsrgn1BjTy4xP7NrYN0YLoIMOUVzCVGZK7D5effwY7w0HPkb4HY4UGw0yUZJtPwh
         2L7hqcN1WCzcZZDf6g27vKvesy1N1KJv7C7nJv3wrFxRsa/hwGgAqvjJqTDM1L7fadan
         I6VrJ2sf5UwcFZUKI3Hg8QLop6+PvflotJNLFgHyKKHHnc7QvccJxLbMVfFWtNcSiyWe
         YGbkZPjijndm6xtpVGa3rauLebkudP8swl5WuzyCxHBxWGxJdoWONNfbyQKkTPKBKu5o
         iGrg==
X-Forwarded-Encrypted: i=1; AJvYcCXgBfzYXny/OUT/W823I7wd7RzXFihFphPZpKmGYyOku5W1oTF3tHA20unqaGG/DCB7H8zlIie++B76HCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BJR0OQ/QBNNHPAOXfSk2kMQ1QBQOnh/PT3NmgQE7AY8ejhDR
	9p9MKgQdfq51jWrzoCMb2X9y/PVu+/wu9Vaz6Syg60/uWUqV2b7jKtMr0X0CMXzD8Mh10Sddbl3
	zWoenZdI5GIasiN3aE0to8bklfK719dw5va+AOlurZ2XlEBXcvojCpAaoTF5bhgk=
X-Gm-Gg: ASbGncspyDCmi7CFcnpWYROgNKWRCVnRK2wOLkTbtf9AIvsuu6VZX5VJvOSUz8IwZNm
	QTBxFRDS77Cv0/hTpaqqjE8kMkWXNgzI7by1wFfq+7wE1p3DtSkAsa+84gMHAA+SteeTtBrCa3+
	rYY/Lsmu5HpaIbrA/DATSv2YnydGGgP1AbiOMOgwX/9U/ZyCwlyn51A19CQKDOCEBldFB3GeiTE
	LBIHwwU2GognKMJeJi42keBwnsKomdyaPSUWZ09BlqeIt5NSo67em62GauwoaUACXvNGK4RqMj1
	0F+FFhmVI3nYCwWGz0LnvjavmBOon/Q5M6TuPSwqwDmAR03GsTx/MTZucO/9aynhzIfSXw==
X-Received: by 2002:a05:622a:513:b0:475:820:9f6f with SMTP id d75a77b69052e-476c8143179mr78084451cf.9.1742300573435;
        Tue, 18 Mar 2025 05:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPfLxajfVPWkyT//A6LLChpF9lL43u3ZMxxaO2AIrk7SMUm0YTxdb9RtAPBgHZZ4+yqvDwVQ==
X-Received: by 2002:a05:622a:513:b0:475:820:9f6f with SMTP id d75a77b69052e-476c8143179mr78084151cf.9.1742300573022;
        Tue, 18 Mar 2025 05:22:53 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e5ebsm7519361a12.2.2025.03.18.05.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 05:22:52 -0700 (PDT)
Message-ID: <909def95-0dc5-4002-8df3-8a4c6a8ee132@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 13:22:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8775p: add support for video node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250311-dtbinding-v1-0-5c807d33f7ae@quicinc.com>
 <20250311-dtbinding-v1-3-5c807d33f7ae@quicinc.com>
 <awgq7zqeqkp2iwyk7vbn3mugsaq723bisxzhaswmzpt3iyc5rw@2vsarnkjdrjr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <awgq7zqeqkp2iwyk7vbn3mugsaq723bisxzhaswmzpt3iyc5rw@2vsarnkjdrjr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67d9659e cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=afI7V7Hr0sYJsfamgFsA:9 a=edriFSTTzQEwYP1i:21 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: tBnkHZYcZp0MsHzIxYhN3dgl2mz9YgH-
X-Proofpoint-GUID: tBnkHZYcZp0MsHzIxYhN3dgl2mz9YgH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180092

On 3/17/25 12:31 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 11, 2025 at 05:33:55PM +0530, Vikash Garodia wrote:
>> Video node enables video on Qualcomm SA8775P platform.
>>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 67 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 3394ae2d13003417a15e64c9e47833725ec779e6..09db8e2eb578f1cada0f4a15e3f844dc097bd46d 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
>>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>> +#include <dt-bindings/clock/qcom,sa8775p-videocc.h>
>>  #include <dt-bindings/dma/qcom-gpi.h>
>>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>> @@ -3783,6 +3784,72 @@ llcc: system-cache-controller@9200000 {
>>  			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
>>  		};
>>  
>> +		iris: video-codec@aa00000 {
>> +			compatible = "qcom,sa8775p-iris";
>> +
>> +			reg = <0 0x0aa00000 0 0xf0000>;
>> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
>> +					<&videocc VIDEO_CC_MVS0_GDSC>,
>> +					<&rpmhpd SA8775P_MXC>,
>> +					<&rpmhpd SA8775P_MMCX>;
>> +			power-domain-names = "venus",
>> +					     "vcodec0",
>> +					     "mx",
>> +					     "mmcx";
>> +			operating-points-v2 = <&iris_opp_table>;
>> +
>> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0_CLK>;
>> +			clock-names = "iface",
>> +				      "core",
>> +				      "vcodec0_core";
>> +
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>> +					&config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ALWAYS>,
>> +					<&mmss_noc MASTER_VIDEO_P0 QCOM_ICC_TAG_ALWAYS
>> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>> +			interconnect-names = "cpu-cfg",
>> +					     "video-mem";
>> +
>> +			firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";
>> +			memory-region = <&pil_video_mem>;
>> +
>> +			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
>> +			reset-names = "bus";
>> +
>> +			iommus = <&apps_smmu 0x0880 0x0400>,
>> +				 <&apps_smmu 0x0887 0x0400>;
>> +			dma-coherent;
> 
> I think almost missed it:
> 
> 	status = "disabled";
> 
> Don't enable the device by default, there is a chance of the firmware
> being not present.

On a sidenote, venus driver broke sync_state by requesting the firmware at
load time, instead of at the time of first open (though the latter could
introduce some latency on first video playback, but both are debatable) -
what does iris do here?

Konrad> 


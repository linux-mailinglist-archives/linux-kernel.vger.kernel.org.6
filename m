Return-Path: <linux-kernel+bounces-426218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BD9DF068
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB47DB210B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75CB198E9E;
	Sat, 30 Nov 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JMM0VVtT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6A148838
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732971113; cv=none; b=eEM0ZEgcQLy4tLz/VKexJxuTBaCKQGdkhs9KFBC02c9MNgkJ3GfwxqDJmUGYuDAgZ1pR2esRUMoZgeyNw0dLUDZ5o0y+k7pOT95OgR8cvfU6em3dfx1TKx/rrEk1b/4C/KDS9bozlqrh1v2xmOGKmAUlDLQAWWOki5cDR+aavwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732971113; c=relaxed/simple;
	bh=gi5mmuk/mJHVFDVAV31LndXqKMPAMGLKJLsHigMMh7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlBjdbKM4i3TQINK8TCyZ92dBllcB4kbX5pj6/QyrY6VJOpLW40+SAkoZ/Y5w7Iqzn3IWp6u/dDAXF552/UiHzse86DHoMyAOFVErS98CLRD3tdp+5U7qmMv/eOOoDUIY+PkhOk/Vi8b2yaPi5JVv7d9A895LCVX07LrjJNzjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JMM0VVtT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AU3l1uS002788
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 12:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	StwTPo2hRaKrn+J62/SCn5SxTaqI0vjjh/U5AM1hyx0=; b=JMM0VVtTfvkBUu/W
	z891qlkP4HKF4uPLE1Sa/y/TGAkbNEsOWB8pqWuRgnvdLJ3tsCbOcuAkhed5HnY7
	UKJ8huHH1upYIn3WuSFlztRQ5wIJt1+qZ1kcmkLvpza5ebsUTh33QmGUE9fHT3CG
	vlDtPP5tzd6q9LmeIW8qFYrwFh0tsha5063XlefnyLBrdi4og2VS4DqpIIGnKmDx
	wOW3pt6Fy8F/0wAzRvy7bVO5YAfRui5RE544B8Aznt5AkBPm9bQROkschQzB0y/z
	QEPIpUhenSHNozUZLLcwgI4yTYE4qqbg5eD2tLSLOtK5xv7qx7x+wm9z1doQq45n
	+OfYRw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437u368pk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 12:51:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-466d3ec228bso2111821cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 04:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732971110; x=1733575910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StwTPo2hRaKrn+J62/SCn5SxTaqI0vjjh/U5AM1hyx0=;
        b=aDJUuJL7CT9k3BrIexX5J5LaCpPDu3uNxQs+L70/Nz11ahPv5KZlMlXtpUNNcZA+fS
         MQAglC7VXVtb0gWiXJUv4q/uLl5wvvSrrpOX27C1MFq2NBrDVsDdu1bcH7YqD/qeXvfM
         xAaa7DkvL7GZFB7z4NeVzkezxQ0N1GOgB5lB+qRuzX977UMV8pAEnNh1tlwmyHdgfbT3
         t0Bv6O3qztS2/4bIsYq4+unBKj6PGNVBG+06/+nudZs33wiaXVtxX/mPwqtxlwt5QoCW
         OmvnSGOCuoXRTRN2VBSQSH16ZXKWixFjKVMfycGohslEa/+axuBx/wBSQHXeOss/+tp/
         0vmw==
X-Forwarded-Encrypted: i=1; AJvYcCXSFkcDEfebv61LxvsQC/z5rG8xr/Xy11HFvECaO0ItFs4T2hskVbQLTmqGS5Sfq56xA76l+afJE/Gt+9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzayooI/b4KM54DzqioDvU+noCK96b7e6gEvS8be8BHBvXNoWy0
	8ednaO8KlgcYdkhfkB2RyPq39ic0dHybt9GguR3q8Gds1+QxpbD+j6JN/TIkGEC+JE/zJBOGHlQ
	LpDNiKlnek+54yO0lGsrnYgb8UdYd/Dd385uvF0IGnTIWBqStWSmmplVmyxirW/U=
X-Gm-Gg: ASbGncsQG2r43wZZ06GvhUBo1Aq/vQxGtCZEgV4ssF19wCyi9Fc4tmPhbqMcmY6nWI7
	ObOusXgyakOL1H9JLkFzs7x2ktpIJyuDhHqINDhXkMoHFEkXk1tZ01uAWAA72fjlyZcfTKJjhYc
	y2AHL5trcG+/eTHYZEbI36vUP/zF9ksvCPGu2g9mCwnJ+2VD/qcg7vRxTs7EIhXRl3UHOhJLuJd
	FHjI2lmkeKKb2NDi6IHMtoL2CZ0PGabhgeaGHe69+XUuWCsGReslZg9W4GsFIImoh8orM3T4ql3
	MgKKwMTJOFm8Z8cxVSmghTY+fJ6Lebs=
X-Received: by 2002:a05:620a:3953:b0:7b6:6f16:6a7 with SMTP id af79cd13be357-7b67c2eb7d5mr848048785a.7.1732971109576;
        Sat, 30 Nov 2024 04:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcwtpdHRWjG1k5koeTggKw/EQDeudOBLvFo6jwqdy6D3oOdqJ+p7TfYNaPlQumUj2tNdSydg==
X-Received: by 2002:a05:620a:3953:b0:7b6:6f16:6a7 with SMTP id af79cd13be357-7b67c2eb7d5mr848046585a.7.1732971109213;
        Sat, 30 Nov 2024 04:51:49 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de7f2sm276477266b.53.2024.11.30.04.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 04:51:48 -0800 (PST)
Message-ID: <095ad153-db49-4e95-98ac-f896f1826e21@oss.qualcomm.com>
Date: Sat, 30 Nov 2024 13:51:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/4] arm64: dts: qcom: sa8775p: add EPSS l3
 interconnect provider
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-5-quic_rlaggysh@quicinc.com>
 <67c9a6d8-90ea-41f4-baac-1d67c9e5576e@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <67c9a6d8-90ea-41f4-baac-1d67c9e5576e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GK_dsPT84jErmCQUzHNt3_ALARVgG4AF
X-Proofpoint-ORIG-GUID: GK_dsPT84jErmCQUzHNt3_ALARVgG4AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411300106

On 27.11.2024 8:21 PM, Krzysztof Kozlowski wrote:
> On 25/11/2024 18:45, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
>> SoCs.
>> Update the generic compatible for SM8250 and SC7280 SoCs to
>> "qcom,epss-l3-perf" as they use PERF_STATE register for L3 scaling.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 19 +++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi  |  2 +-
>>  arch/arm64/boot/dts/qcom/sm8250.dtsi  |  2 +-
>>  3 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 9f315a51a7c1..0c2bd15f9ef0 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>>  #include <dt-bindings/dma/qcom-gpi.h>
>> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
>>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>  #include <dt-bindings/firmware/qcom,scm.h>
>> @@ -4282,6 +4283,15 @@ rpmhpd_opp_turbo_l1: opp-9 {
>>  			};
>>  		};
>>  
>> +		epss_l3_cl0: interconnect@18590000 {
>> +			compatible = "qcom,sm8250-epss-l3",
>> +				     "qcom,epss-l3-perf";
> This is sa8775p, not sm8250. Wrong compatible.

The bigger issue here is that a treewide binding adjustment is
coupled with a feature addition in a single patch.

They should be separate.

Konrad


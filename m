Return-Path: <linux-kernel+bounces-425474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD879DC297
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BAAB224A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B71991DB;
	Fri, 29 Nov 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+ba56HH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C1197A67
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732878849; cv=none; b=Nk/HmvOExspcUkW4IB3NhFqGthe1IATcD638mw5Z4nDFDZoJyZarCf3nqn+4yJ1SqnmYgMOZDseP7QJugRI8rvWznCca4mPrjWh7xXQnqeUe/xX8XtD+RD/RvmaZeCx2fPSOts0qmv6ng0+93gqmGX7RmFE8EOby+RKspJirxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732878849; c=relaxed/simple;
	bh=cstglfYBauIS3JdfffF2An7qCkZsMHY7Xxx+C8VW4Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOyMgkgCiyN2dbhi2RjrHOPmyUt8x9oYoLPkws/RXMr7O+RW26okC7ebpG9FiwHsm94GDCfEHtuhc8bLaSY+G/7RhIQIzyQ0sFEiHDJKcQIrpRMlhx+TImc/khUq1raqR3U06MwL7cTfbs2SvIxUaMFocEBFEfaJ5JRrIJXyTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+ba56HH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASMi0Xc016539
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BAYSwvTyJwQulmVNF+wY/HlCJDdBfbXeIaNl/2czgb0=; b=N+ba56HHvusIT2IO
	kx1iz/q1ttMfI8igtIpnn+FC9YmsRsALtO0X0wpI+vUNE17dazNCxzIb0motQ2bK
	jmgxyfjq+oKfMiHKLjpF3bN2qzFYILfZBddz6bZjIDvBSGQX36Lc/6wvY7Ufnuou
	I/fjADxFrpOtnOIiUpXhwJoM438z1hb/THqOzNX9CDHM4pQiUEJr35S3lyJFK3xM
	mwIvVNAZFJ7oP4+0JNk39MHDtDrbQE7OACtW0jEF8+EJxbXAalQ77RyWwVgh3PCG
	OCe41oJUrsHL8wiHdPFftZMvSaWAj8YBZpQPgtZeyugQNwDgXUHcnX1se8D7GlDT
	R5kBQA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43671ed8ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:14:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4668a6d41a5so1620441cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732878846; x=1733483646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAYSwvTyJwQulmVNF+wY/HlCJDdBfbXeIaNl/2czgb0=;
        b=CxwwloNifuHQkHGY46BU3+Ld0RcBv3I4wYB4d4OKT5wKhobzWYwSp55gflkdpCJzle
         6VHnaCqtuVL1Hzsi3Fi8CfWbMlUOm7NKVU9qVjtY2WqavYtEZ1fXE3H4BNgdgxxWpiD+
         0oGDCvMVZtUvsTJsO17AHf0x22iN2G5GIkhFKx7ymTlqabYBXsLSZ/7wcM2J1bliDn8X
         wbtEYvsFv4WB58q9C5th/18JxuKOrw/65ewzCbEgg2BBhvjIh7p094ZI86AW3368U24Z
         qQi0o2dJelbPeLRaWrBE0fdi491fCDXOIuy8KCAW4UOjOnr4RJUZljZhsrrFnjDAJKE4
         Pm0w==
X-Forwarded-Encrypted: i=1; AJvYcCVMRPo74QY1/17yL08hrAMMF5J8RBpSXmI5pTiz9smvSIMyhLhBIRy2GScCDwfPcuCrWJn40EEI4jAzQQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HznV5d2VhoU9e58bNMb6fqhMHLJkMcLqUsRj+QTdm+5So47p
	BAnaT5Bc8TdEfBg95AB0s3706VTCuQFGyuslA27nhPBYAV/aiC3V1CCfji4099Wok/2KLv1cfXU
	L+6FKLtkENT/ISff4kg4CvhbONLhLCXbRM2ZIqcC9AxNabvfCe/nXnww34sZq5vg=
X-Gm-Gg: ASbGnctd45Pyicn+nbw71mUZ8FJs1Tp+z5doexrwt4Kds5l1RTfkS0+vBugnWpWDJhd
	wYweaeadkegSgJG1d/FmYaZA0ZQ1K3YMswWyweYNwyqEJuCPLeZGIOg23ZpSeT6Zs+atYU2aZEx
	J7Mr8LUbWFuTWVRYo51FPQDYrF8/MyNHRhNZM9Oe9D/c+kwEUtauMHWfJ6UY/CtYC2YKR2+7b/6
	Z9rSe3GkUXMrL+iyJ3b2qY1LcTt/MUts8gqfprEP7DiiZFVo1ZKvaq5G3LCu1522JKZNEzIDj5E
	LgzDksUbv1Manz8EMIsS07h+NnD2HEQ=
X-Received: by 2002:a05:622a:15c8:b0:463:5391:de49 with SMTP id d75a77b69052e-466b3687a32mr71373011cf.11.1732878846163;
        Fri, 29 Nov 2024 03:14:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0IkMRxCz6HR49nl4DM/5oNGJ9HIJVwhr8KR8G6mkB7EYgbxMsXDp14lpVrXF+HS3SvrioVQ==
X-Received: by 2002:a05:622a:15c8:b0:463:5391:de49 with SMTP id d75a77b69052e-466b3687a32mr71372741cf.11.1732878845666;
        Fri, 29 Nov 2024 03:14:05 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097eb1fe8sm1723809a12.74.2024.11.29.03.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:14:05 -0800 (PST)
Message-ID: <5ae55ca2-d9ef-49c0-8868-2c5bb665ddb1@oss.qualcomm.com>
Date: Fri, 29 Nov 2024 12:14:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs8300-ride: Enable PMIC
 peripherals
To: Tingguo Cheng <quic_tingguoc@quicinc.com>, quic_fenglinw@quicinc.com,
        quic_tingweiz@quicinc.com, kernel@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-0-28af84cb86f8@quicinc.com>
 <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-2-28af84cb86f8@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-2-28af84cb86f8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h289Hbwokqik6PtBbEdCDnNXKEqb6IUD
X-Proofpoint-GUID: h289Hbwokqik6PtBbEdCDnNXKEqb6IUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411290092

On 26.11.2024 10:35 AM, Tingguo Cheng wrote:
> Enable PMIC and PMIC peripherals for qcs8300-ride board. The qcs8
> 300-ride uses 2 pmics(pmm8620au:0,pmm8650au:1) on the board, which
> are variants of pmm8654au used on sa8775p/qcs9100 -ride(4x pmics).
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 7eed19a694c39dbe791afb6a991db65acb37e597..9447efb9cd01654b74ec4c18dec58b1956ffe710 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "qcs8300.dtsi"
> +#include "sa8775p-pmics.dtsi"
>  / {
>  	model = "Qualcomm Technologies, Inc. QCS8300 Ride";
>  	compatible = "qcom,qcs8300-ride", "qcom,qcs8300";
> @@ -223,6 +224,28 @@ &gcc {
>  		 <0>;
>  };
>  
> +&pmm8654au_0_pon_resin{
> +	linux,code = <KEY_VOLUMEDOWN>;
> +
> +	status = "okay";
> +};
> +
> +&pmm8654au_2{
> +	status = "disabled";
> +};
> +
> +&pmm8654au_2_thermal{
> +	status = "disabled";
> +};
> +
> +&pmm8654au_3{
> +	status = "disabled";
> +};
> +
> +&pmm8654au_3_thermal{
> +	status = "disabled";
> +};

Are all these PMICs absent?

Konrad


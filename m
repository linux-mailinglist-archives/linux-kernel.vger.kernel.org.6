Return-Path: <linux-kernel+bounces-391237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380D9B843D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2431F239FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBAC1CBEBE;
	Thu, 31 Oct 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QLyl/b1b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A11CB51C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405931; cv=none; b=b76ovP//9M+HvDA5OdifHY69J0Ex4oJiswr6NyEiwNdQKije1ypUlGegEu/QbUJz0AuIXUaByJAoDbcRjCclt6vFSVhyYrlBvXWx2mERGRK19kqiIpeWh+dAt0JATuyOU6uVmbkI0YWZDVT+Tw8m6uasViMlTO3bvb2XcFbv5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405931; c=relaxed/simple;
	bh=ZtAVjPxgYxzMtH9aW8STEf1QR6wb+MN6NfwJGe0MZxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8ywlLWIWs/hNQAGloJJ11oUHTZTaYdQCT4Ihuo2glswCY1ZFhAUUmI4qRX1dNsDfmtq0ZfZHWac5hspFjUJLYBLrfKuUmtER97otqRHgtd2C6m/Gi55++hmu8PQ/qOVx0cw7oCJiwclR1xU84cFdDha4YBxUtSUBvxWvPPv4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QLyl/b1b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VC7R5D020861
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+lwChbtf4QlnyS3a2fLibTs+TIvRzaYRIdxAmVV+Nho=; b=QLyl/b1bFoZBbmDs
	U6x0dCHx3E85PrnOaN6+Jwpd9KmVRZB9G64Jbn+y+pamzB4FXO4opdY01bUeHtCJ
	9zkwj/bEvO0ZeaXsyJJqPMg6ZAnkcNOdkUlQ6cbVLci3movx91VCeSrtjBX961i/
	hC8lHaxtDGRiaxgb1H7jZA+h8IwH/UNkmoUR12sMc8vCVvEEC+9CMGrO2J/WSKuG
	KuokHUT/1gtHkZSjK0Qd9k9EY7eE4PQCfoYLOXkDQTBTVpsarLkKr+xAeb3HJxL9
	ZfA5ceIs2byOfiuqvWCAyV1qgkOjxzVYtX/fqldkCfH8LnJtsPtkSubI10LCpgev
	INApJA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42m1rpjrrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:18:47 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb87df274dso103099eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405927; x=1731010727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lwChbtf4QlnyS3a2fLibTs+TIvRzaYRIdxAmVV+Nho=;
        b=m/gGoZkQqM6G+nigzFHG0FKklZUTpFeqRYK4Xt6UBjoPN9nbT6LPvgNQqHfSvaQr+2
         v8dveLCFD9CW4cgfWRMhgh5q2iUQTfXD2nHAIA1kFc3wypJwS6DtvPQ04syqvnX+fdV+
         AC5jHCeMmsEWP3Fuc4KZsP3s1jj6wL1K8haa+2XhvCGgd355bAQWhPPCsuXIdCdcGllJ
         SkPoDdc+z4NG7ixeegegUmzKi/wH7TVWE+dL6tul5K/vwyueFq+nwTtxWadtXDbhXLBJ
         bqbJltkNxRsgT2xAhpBnK+UG6UzPtFrentUMI/Cthf5ZAndpvb27LIQeZPCGoZZ27NkU
         /vvg==
X-Forwarded-Encrypted: i=1; AJvYcCWny7k9Bg6gsMubC0Si6n18mrL2TcDLUvnS0+6S+X4HL1+aCeBvittFE0aAWmsF1KGhnZT46zbBVp4IxvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvW2qxMNN4PODiJvrzD0RHB8bS9skJNbsTXcPYoIFVsBc5q6l
	9vi+FPF4ibNhwmwKOOWmsKcSZPMRsc/yD7DdvFd4mo45OhrCqoRcQgyNDOmiuvf10ALbhGU7Fdg
	6QKOZbTno49+b+yuJgPOXIzeDwwOBVbAxfPPNf/QTyPTDUFNgt+t6fJy+IIV+5rg=
X-Received: by 2002:a05:6808:1488:b0:3e6:24a6:f148 with SMTP id 5614622812f47-3e6384a3182mr5529881b6e.5.1730405926964;
        Thu, 31 Oct 2024 13:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKrXFnhagF7X7syfI1//VxiRkYcsCZRZNjwpIrrX3+vJvnvmLryqItYJyXUaawNRnQpQnCnw==
X-Received: by 2002:a05:6808:1488:b0:3e6:24a6:f148 with SMTP id 5614622812f47-3e6384a3182mr5529869b6e.5.1730405926612;
        Thu, 31 Oct 2024 13:18:46 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4f45sm100262466b.71.2024.10.31.13.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:18:45 -0700 (PDT)
Message-ID: <e19d9f78-361f-496c-be81-e1ca1f0efc05@oss.qualcomm.com>
Date: Thu, 31 Oct 2024 21:18:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] arm64: dts: qcom: x1e001de-devkit: Enable SD card
 support
To: Marc Zyngier <maz@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        robh+dt@kernel.org, dmitry.baryshkov@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, conor+dt@kernel.org, abel.vesa@linaro.org,
        srinivas.kandagatla@linaro.org, quic_jjohnson@quicinc.com,
        jens.glathe@oldschoolsolutions.biz
References: <20241025123551.3528206-1-quic_sibis@quicinc.com>
 <20241025123551.3528206-3-quic_sibis@quicinc.com>
 <86zfml1tbv.wl-maz@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <86zfml1tbv.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j21VE7RFPBk4wC3z1pwI8oz54mKkrU64
X-Proofpoint-ORIG-GUID: j21VE7RFPBk4wC3z1pwI8oz54mKkrU64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=971 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310153

On 30.10.2024 4:52 PM, Marc Zyngier wrote:
> On Fri, 25 Oct 2024 13:35:50 +0100,
> Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> The SD card slot found on the X1E001DE Snapdragon Devkit for windows
>> board is controlled by SDC2 instance, so enable it.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> index 432ffefc525a..f169714abcd3 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> +++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> @@ -672,6 +672,19 @@ &remoteproc_cdsp {
>>  	status = "okay";
>>  };
>>  
>> +&sdhc_2 {
> 
> It doesn't look like this path exists in the upstream dtsi. I guess
> this applies on top of another series that isn't exclusively
> targeting the devkit?

<20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>

Konrad


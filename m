Return-Path: <linux-kernel+bounces-382301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482319B0C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7149284218
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C118452E;
	Fri, 25 Oct 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljImiyuC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BD15444E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878382; cv=none; b=kUE1G4SDpIOgYgIluzRtZDyF3he9UiW12WvQw3rXHJWOgoZ2Vw4kzqw1sRssiiFq3VHqhyBXR1CfxuN3jvpCPHVVzupsYO7j8Eo8xpAPqhtgOsboXPxx2peC5tMFBYRcGnJIo6o8I2dcjm8r+kCSeN757kVcz1x+QdCFqjnmdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878382; c=relaxed/simple;
	bh=oIuIuspz76OCuYP6ZhuCIco1Uhz8q72qC71gvsc83xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0Xa9jTGYWWXOfwyVMi2bHNDLDMm/aFUmTqp7NGu9kQDhzbxK8/IAG9QqsZp3OOLYnrsBstMTlKd9lGY8oM+nRGETHv4SxQ4BvG7wk+4P2rzFrAmiSOAxYJSDFooBtfkjNcpqF5Hcl+jqJHjAFYAAZUokEuLg9YN1Z+3tZl6Q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljImiyuC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDMpbY028676
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gp4O+oOSOissF91Pvneay/lgbVotgfOx/AKhK7rAXrg=; b=ljImiyuC/X0YEfWW
	pFPe7pES7hK57F+CBg7FmRM5K72bP+yG81uWphYP0gx29K5UB9ljCa0nACWMbidc
	LliPRMH5+/PtJjs8pT9UT5PRTHSpymjwXZNCRYPgrtSs6aDieLC6ovKmMXLmhU5J
	gcI9CoK1halYW5dhQPpcbWLMHa+VYu3vPKzebwV0LF92fpji3TaQhci3hNBlYNbs
	rF4lYvILDUqZOV0nd26POlt7PnyLXl73zOwyzLcZxE9dJY6UR0hndsaKh1RUCTuJ
	KIxO1A+8naMA3rnP4ATelU8q8RTW+U8ms4AAQ20FgHYfZ0nYe+6UTybbLv7v7sfk
	TrVnwg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fdtxntqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:46:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe149b1cfso6428356d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878371; x=1730483171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gp4O+oOSOissF91Pvneay/lgbVotgfOx/AKhK7rAXrg=;
        b=trcHeSOUcKdpqt1JtMeJfuZz+SKEz8GBIu9cJNyTJXUqDbc6jFovcdnJkEA/u9Zpni
         he1anLSDQ2+biH+HvmwCIEbSyhAQF/AA1jQ3pq+Uw6fqUOKux61BT+0vjRUaa5pC1hGi
         78XBCyw2gKjk/rv40xwXg9TA0TKaQoHpuhg6UroCZ7oFAWcC6zUivv4bPL/mafy+1j4m
         We0Kc9M6bOMylCA+2LfKnXZzWRRW9sEQc85NUzPlpUdufwW/pPi5UiAxkVTVMS43VXW3
         xod2a5mYDH5dhB7ywLdZMdluiMHFP9J/LO9m1U2GmKNNsreNpMs9X3AuHv3Aug4f0J/g
         El5A==
X-Forwarded-Encrypted: i=1; AJvYcCUnxTEz/S6zMa+3bAYw9i+9M9Equ8cEjL8VFieYfEixO5+r6m0MI7OLiliFNPCkpZQHS5iueF0yqJOxMGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybhvFJgoI4F/PT1lL2+t6BvXFku9J8xCNdfo7LmxoH9K1Jw6rL
	0dBA12QB4UQv+TLnYv7+H3CpYlP4FJC7FaJh5M8/ZdRJzbeG0C9kyAkGKDT78ylkxMdc2QSmVjS
	R/8oglCqPmTjNQ3Csom4VqT4w2f9JS5UiND+jtKudnOKl8nRvzJIZhOTSX5WjD1A=
X-Received: by 2002:ad4:5cee:0:b0:6cb:f3df:cb9 with SMTP id 6a1803df08f44-6d185837663mr1613566d6.9.1729878371379;
        Fri, 25 Oct 2024 10:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpDSpwMF/KD6STy7ZyXj15CbXpF87KjDotLoxTNXjlOrvboEQbQCx49/+xITyhMb+FVdgP2g==
X-Received: by 2002:ad4:5cee:0:b0:6cb:f3df:cb9 with SMTP id 6a1803df08f44-6d185837663mr1613396d6.9.1729878371019;
        Fri, 25 Oct 2024 10:46:11 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63197d5sm833015a12.72.2024.10.25.10.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:46:09 -0700 (PDT)
Message-ID: <c81b26dc-1c52-42b6-ba68-95906b9c524c@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 19:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs615: Add LLCC support for QCS615
To: Song Xue <quic_songxue@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241011-add_llcc_dts_node_for_qcs615-v1-1-e7aa45244c36@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241011-add_llcc_dts_node_for_qcs615-v1-1-e7aa45244c36@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vhRaLBRk0JOpM9JeVUlhDkH7jxu8-qBr
X-Proofpoint-ORIG-GUID: vhRaLBRk0JOpM9JeVUlhDkH7jxu8-qBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250136

On 11.10.2024 12:41 PM, Song Xue wrote:
> The QCS615 platform has LLCC(Last Level Cache Controller) as the system
> cache controller. It includes 1 LLCC instance and 1 LLCC broadcast
> interface.
> 
> Add LLCC node support for the QCS615 platform.
> 
> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> ---
> This patch series depends on below patch series:
> https://lore.kernel.org/all/20240926-add_initial_support_for_qcs615-v3-0-e37617e91c62@quicinc.com/
> https://lore.kernel.org/linux-arm-msm/20241010-add_llcc_support_for_qcs615-v2-1-044432450a75@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index ac4c4c751da1fbb28865877555ba317677bc6bd2..b718a4d2270d64ed43c2eca078bfe52b78ff680c 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -495,6 +495,14 @@ dc_noc: interconnect@9160000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		llcc: system-cache-controller@9200000 {
> +			compatible = "qcom,qcs615-llcc";
> +			reg = <0x0 0x9200000 0x0 0x50000>,
> +			      <0x0 0x9600000 0x0 0x50000>;

Please pad both addresses to 8 hex digits (e.g. 0x09200000)

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


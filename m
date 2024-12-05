Return-Path: <linux-kernel+bounces-434020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0659E603A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8688A284F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1D1CD1ED;
	Thu,  5 Dec 2024 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hqteXwO7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FAE1B6D1F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435200; cv=none; b=u9UxBO+8Gv9cHCAyNsoodNJG4y3xbrHrrf/TL7YGpNAedbnBieR4fEN7qyDYGPIu9VmFmziBBxJpYwKpxSRO78tZ6+Mxd/URt1aH22j4YUN5sl8B1qRvgOI+c7ZMaB/G/tsmsckPaedroOWlwcg/yqWFtLvMNy3gzE7fTejEdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435200; c=relaxed/simple;
	bh=NOvBU5kPr//INWOr0+0y9QOrcf9NtMLBo14Y0ptvaiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTYpYLxwMw4ivr1N2ZGLFRQrORnbptYUAKgJdp7bGIAHuHBAQ0/3QhJ8nwOWHbf71fYtCxVjiw8qMbQB4Kh5nog2abwMzdS7NWB0+ZmoM8E/cVONDlzKhrNHZCp6/WDUwofg0pIhHgnXYMzY17/xSGb66xd7UOyw0rcTVlzuNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hqteXwO7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Haper007706
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 21:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	klKiOTWRYLpHJsIA7V1xW4E3d1Zon1XQRRggfmfjlrs=; b=hqteXwO7JDZmSf9M
	LWy1w/6A7FepABguTaxfmzqnPT9yvQSZ4iSnwfar2qhLo+DJQoGajsw8TyL58G79
	CvT2G+wLgtND44LFSc9VAg1CoP+w8SCqQ8PUaTFGPENbKXn+zs+tUOqTj3kTzUw2
	s+j9VekxL6kPIQLn0Ez2PeCa+UJ6LNAEgwj8qhJhQ+Dvrpz4ojP94bjkjwpjm/MJ
	Tz+9h/okGRsOSZv5npRn6vJpJI1wljPu+hGg1uHTp1lMwoEt97y7K5k9CvLkA3xM
	pk15D0NU8lOIJskIpTbqDtwln3e/nQJgR9hFgtp6dpXTeCtCFJEfBDkXkEDjuu4n
	/Dmmmg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ben88y7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:46:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-466c5605601so2919461cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733435197; x=1734039997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klKiOTWRYLpHJsIA7V1xW4E3d1Zon1XQRRggfmfjlrs=;
        b=CnH54+VLpPJcpy7+RkXIVWzVOQdmaUQc8HauguP/kpCxKXNuUkdznFuiJSbygsPZEa
         0u9oCzvy2Q/jcBEtu/9i1PPHZbpg7bmWiJX3kQQaWAi8/DuAB5KhmwJigRHqPKH53fZM
         SsZHaXbEvMWnm/5ZasXm8vGnwj7f98xpH5AlyF6th5GSCkiCza2oIBSfIH+9EkxwHFXd
         wpMvtXRyw0iB2nd5VigZgS9Q0TVZfpdj9ZFVnxB5JHzJ5sNTTwhm4tanYc54hW/3LpJG
         I/TNTYUQe6M8KdyRKjYh7+I3ufHi4DKcAI65j2LNAnClc7+65wKqpDO1W50SWaeT4H//
         3Hhw==
X-Forwarded-Encrypted: i=1; AJvYcCU65y87kgT8yUnyOedWTAVYpUumxekSVi+PtDvmJzMVeKCUZ5wIzK9/d3W+vNyvIeou+AW8LgOrIQ0hGLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygClf9sQyOPfJGnxvGfoUloGLlPd3gLQueKrUHNBJZSIEDe9s3
	JfdlNyTtQrJwjJp2wsfit+uvNGJ425vQq8aGbBOg7iVuCtENYeOHN/gUL98I+jwZI+yJ0/YAs93
	bmZv9sypSJewshhWuW2HAp99s+6hU0XEv6DzxdDqel+96xO9OLtRFK6HdBugtQN4=
X-Gm-Gg: ASbGncv/xJnpHDl/yT4NuiDQufuk9KHsGagqrOTZs7ftHLiPzfzyG1pXG5RCJ9pVWEV
	hqSg6Td5M6a4d/ArjeSqMrGaBwCSmt1gBGKDe+u72XelF/jwhjI/qQbWUPP/FI82AriFNRz07sz
	JZLSYT2Wu9s9WseNx/jxCS1lcjTm56ClFzCfYLodjFOgrXpCiR4MI3EgoBGQ585FZySrD3XlTRn
	6v5xFA6qusmC2kc03F0q85A7bmsBx/W+BU86di55xKJs8JNnyHlAY4aPhAGapyQJMlPjN0TbPkf
	SJLdsGKmfX1XAJOQtoiKUwylNU9mEGY=
X-Received: by 2002:ac8:5943:0:b0:463:648d:56 with SMTP id d75a77b69052e-46734cbceedmr4793891cf.5.1733435196932;
        Thu, 05 Dec 2024 13:46:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf8DilADacg13bVlIRhRs75Bxsdhk32J4YapDiQecr0yhzNtzVm6UbqIkKibQ0R0Bj6FzmCw==
X-Received: by 2002:ac8:5943:0:b0:463:648d:56 with SMTP id d75a77b69052e-46734cbceedmr4793711cf.5.1733435196578;
        Thu, 05 Dec 2024 13:46:36 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58e0asm143634266b.5.2024.12.05.13.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 13:46:36 -0800 (PST)
Message-ID: <466ea213-5f20-4a9f-a9dc-751756792845@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 22:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs8300-ride: Enable Display Port
To: Yongxing Mou <quic_yongmou@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Kumar <quic_riteshk@quicinc.com>
References: <20241127-dp_dts_qcs8300-v1-0-e3d13dec4233@quicinc.com>
 <20241127-dp_dts_qcs8300-v1-2-e3d13dec4233@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241127-dp_dts_qcs8300-v1-2-e3d13dec4233@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nis0jm_SpVWKHOA-KNfS2lBS4-Fnfsdh
X-Proofpoint-GUID: nis0jm_SpVWKHOA-KNfS2lBS4-Fnfsdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050162

On 27.11.2024 11:45 AM, Yongxing Mou wrote:
> Enable DPTX0 along with their corresponding PHYs for
> qcs8300-ride platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---

[...]

> +
> +	dp0-connector {
> +		compatible = "dp-connector";
> +		label = "DP0";
> +		type = "full-size";

I was surprised to see it but yeah this is real

> +
> +		port {
> +			dp0_connector_in: endpoint {
> +				remote-endpoint = <&mdss_dp0_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> @@ -223,6 +235,30 @@ &gcc {
>  		 <0>;
>  };
>  
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dp0 {
> +	status = "okay";
status should be the last property

> +
> +	pinctrl-0 = <&dp_hot_plug_det>;
> +	pinctrl-names = "default";
> +};
> +
> +&mdss_dp0_out {
> +	data-lanes = <0 1 2 3>;
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +	remote-endpoint = <&dp0_connector_in>;
> +};
> +
> +&mdss_dp0_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l4a>;
I couldn't find the reference for these, so I have to trust you

Konrad



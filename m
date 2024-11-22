Return-Path: <linux-kernel+bounces-418258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F99D5F76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E131B233D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4611DE8B8;
	Fri, 22 Nov 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7Oxb1ED"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AB187321
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280542; cv=none; b=oJwfwHl7dAXESZD2sjkoKSNo9h+DdyJsRide365YhBNvCqtz8mVDxu4FdQVU3TWsChdWah+24oml+eAwf5hJ9+Qz+om/HrdA7cFlXuBUhXmf9ruLyJ4tSy8zIPinfhkj0EPWTguCRnVUka4eRNga6Cyjp5hrgsEllfqLokMRYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280542; c=relaxed/simple;
	bh=hkkzOJ6GCj35VVaA6tuA70DPXj9UWp2xzAz9EycU77Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tb4Q9uXpghNOXEJwzg34fqC8v3cJ7evSwGkA7GdLf/W92p7M3Kn6/HRUlva1cAk1xQZmSaN0yduohmn/Qb1Mnq11AXuB1CXpB58Oc9lgHjvLsuUsbz3aU6RS/OWdYjaknYUS2meofRb3G1Wh0XKCB1XxoXKj91kicZR3WlpkiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7Oxb1ED; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM9KUJu019239
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OUtwXsA6fi06uw94keaemdw+7r4z9cngQFHn1Kq0AiM=; b=X7Oxb1EDLNtUHv0D
	+CoQ8pf8rqsmp5UdPsUg69OBdBqyageSreq/wPbQxDlwi3LOenAprkwjo4iIm8fP
	3j/j7bBNu3NQ6PIvWIVHm39uDdBiKh3IW9aO8Bxpip8+szM2FKI7O/oKPZ2l1Oi/
	WtBaduyjRg9pkVdpfZ/lX3lNJpH+6Id6bfptGMwZfob/eqZziBL4NQ/tPZoUmIqZ
	U2EEMOa30Z0SRGL0/a84zAWZB062e3fqAcrS6+6Itn28lrknOp+5Jllf7w5cE+w0
	jnLo/nAk0MAGW83kvAicPchBZARU/Z4tot6UzhJg5cflMdpxyQIfo36qdDY3HO35
	IHb47Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431c7hqg0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:02:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46093edbf1fso5436641cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280538; x=1732885338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUtwXsA6fi06uw94keaemdw+7r4z9cngQFHn1Kq0AiM=;
        b=vkMIQj4xx6pQT6kZz9yox/Rnv0tFOTyGiNPZdaHvjPJMNpU+JwihInJ+GzCUPY8BB1
         ngmtDZYZt1DWSnZkFxk9WCV93rU4jmS1MtxECI1oDFd1RXIRU6/kla7dvY5mTrf/xaK6
         x6gzKkm+VUT8RDju7mkAT7z79Uqx0iLswjWIMPALKr/RdO3AHjbf6tl/1qFLhlSa7Sb8
         yxvqruQjtjItXNWRRH8kFPpk06jfAN63gj/mVnXnmCktt8Vt2300rxaPH54x+rarl9Vy
         Qmk9ISqxOu7jRHOls+M5t0NUzZOnlc8p42MRq8ARJD05ipR78qMoRcZ99aXyj3RmGseK
         sCCA==
X-Forwarded-Encrypted: i=1; AJvYcCXxIecSpCjFqrPWSZ5WKtPzScu5Kdd9WJndKA5XuIv2XhPt8aEyGN1ygC4gdxMHI43c7AcsNlSel38Lp3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNRS2qtjdo5R4SQ4H7Jb5RiHVWX77SpgNe16ljuztv6vI8r7D
	smC1Vzhsv2GuDcNRq+k4yT4iYzdCNUB8/i5/HcXS/uDy9sJLS0UrNCn3qDktOijttsuxdk6S1Uw
	Dncy/75x31r0h3ngSPHt0drxRUhxZx6aRvmkfj4/GHW6ouzLMeYuK49GXnxjklbM=
X-Gm-Gg: ASbGncsq1a8zWk3nweMnQAiCl7bjykCILp0ajX60hENadnruFzZwgvq9z2SCqxY4dCJ
	2I6hXeOM7vf4/aCdTRX2pm54c/ml+n1Yqz6sxwhTT97NtXcatuwGVPpGF7E1Ot1X2/6rPbh1jej
	zflH9i3srMbHT/u1Q1pl23Ltnt+vrn9ViOuBvNyhQWMpBY5vuJV6qR9r7V9Jer4LDUmIrWg+pnj
	B0KerucPVuxiBKWmhTnwJoooyM16e6lc+3rfQ5B7VW3o/1E4fRhhvFo7I587uASsnWegNINSrrp
	TCB8r7JMAySzJ0/I7YAsIQyAV68Hzws=
X-Received: by 2002:a05:620a:c93:b0:7b1:4add:f234 with SMTP id af79cd13be357-7b5144c7c3fmr144859785a.1.1732280537943;
        Fri, 22 Nov 2024 05:02:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhI3EtfapA7M3nlK78FHUcQBl/pt+MLm9ptP++4+wo8qRREO7ed8WW8w1263P0hSJNC7GqZQ==
X-Received: by 2002:a05:620a:c93:b0:7b1:4add:f234 with SMTP id af79cd13be357-7b5144c7c3fmr144857385a.1.1732280537550;
        Fri, 22 Nov 2024 05:02:17 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fe71sm96767066b.110.2024.11.22.05.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 05:02:17 -0800 (PST)
Message-ID: <9a2862c2-4241-44a4-acac-b37fce237ceb@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 14:02:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: sa8775p: add DisplayPort device
 nodes
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com,
        quic_vproddut@quicinc.com, quic_abhinavk@quicinc.com
References: <20241121091401.20584-1-quic_mukhopad@quicinc.com>
 <20241121091401.20584-2-quic_mukhopad@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241121091401.20584-2-quic_mukhopad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zEVklkDJt9DRKu17xEaKjDNzj7lpMNwC
X-Proofpoint-GUID: zEVklkDJt9DRKu17xEaKjDNzj7lpMNwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220110

On 21.11.2024 10:14 AM, Soutrik Mukhopadhyay wrote:
> Add device tree nodes for the DPTX0 and DPTX1 controllers
> with their corresponding PHYs found on Qualcomm SA8775P SoC.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 218 +++++++++++++++++++++++++-
>  1 file changed, 217 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index f7a9d1684a79..7fd0d89bf7a9 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3343,6 +3343,25 @@
>  				interrupt-parent = <&mdss0>;
>  				interrupts = <0>;
>  
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dpu_intf0_out: endpoint {

Style: please add a newline between last properties and first subnodes

[...]

> +			mdss0_dp0_phy: phy@aec2a00 {
> +				compatible = "qcom,sa8775p-edp-phy";
> +
> +				reg = <0x0 0xaec2a00 0x0 0x200>,

Addresses should be padded to 8 hex digits with leading zeroes

> +				      <0x0 0xaec2200 0x0 0xd0>,
> +				      <0x0 0xaec2600 0x0 0xd0>,
> +				      <0x0 0xaec2000 0x0 0x1c8>;
> +
> +				clocks =<&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,

Missing space after '='

(ditto in other nodes)

Konrad


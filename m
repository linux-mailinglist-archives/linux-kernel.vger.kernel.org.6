Return-Path: <linux-kernel+bounces-393251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D29B9E49
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72F01C21AA7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3C16191B;
	Sat,  2 Nov 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LSZVSLXa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E947602D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730540173; cv=none; b=CoKSwGyyB7lcpKHtjmrEa94bFCDAWWDrrdlyIaBv2xjFQ9aJ3egDcqaQpy5taroD/M87Xeok8Rp2ZZWC/MkXrdVRUBJpd7MYRCSERB81ftnVvOcrbDI0NBDGRL9WW9Ur3mam8NcmTmC1ODl1zCm9NIUpfqBAoCEfEHAnFvrjOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730540173; c=relaxed/simple;
	bh=UnCtBaOSgA/sU0BThnRnBlmMsS042zthQzkmU2N+Hz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im/MciiPRM8b2jT1gkzx8RiSPAo/3s2vCzx+urpWiyek5tcibB+Tk8qMtjlVTJoRBejpqrcMHU7R4Kp1vFMXfryjRFLLxeP5Yy6ZpxBuJxNDoVCuWLTqFw/rp0+BdOuRZD1YX1sNQgrMRy3MWkvzZacgOdB8EPttOc2sl6zeezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LSZVSLXa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A24W4RE001056
	for <linux-kernel@vger.kernel.org>; Sat, 2 Nov 2024 09:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YM8HACUKl4ocuSlUDdw9y8YU3/9YMZaLj+z480woTi0=; b=LSZVSLXacyh0ddjd
	ae+mcmjmZMVkYhPno7rxKIYjDSq9omMggEyR+sMaeDE1Ri9KA+SdHmXenOiPvVyp
	vZZ+FkymvF1mplcFa6AI+s4Z0l4IRoynlDSNYB26d5PFeg6GNlsn7XAXLQixK1Sc
	Q/acs1Mde+1OOKTs2qz2mlrjd1AFv+kTnL76RVRO9NbjxkCE7df75JXVHpTSSoMe
	6PUmFCQ3GePFjVZHJh+0Zdt48pAu1HXtbQm9qqItGd1ZME7Iw8+URZKzQHhW3BlB
	Xf03G3HQ/BCIxZ66DJRFJ1tGiIS1QbCKGr9NdxVYn3Gxu/VkJpIKTrTh8DmyqEaJ
	21gPZg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4trdq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 09:36:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbd0a3f253so8396546d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 02:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730540169; x=1731144969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YM8HACUKl4ocuSlUDdw9y8YU3/9YMZaLj+z480woTi0=;
        b=WrmmjvIZLf0L1aL/6PwqSj9/yRMRgFDzo+YLBQONVUVqi2i80VEJen5X2eFjlQ84Ot
         5IyugXlLnHPOxp1+vtSAnc4HCj5ZawstxjKddGSIy3hJ12huEnunFX+jaf+ry4oE8yKS
         mt1CpMuWpPlTVii6bpNkTIbo3AkJcvG9cDTH3ZR66FkKzJzov6Nia/gD8iCCP0YdH4cj
         zmOI66F9u1tymjevDoKkwjxr3BGuXPV6HXpUuszFuNFUr1IJqcQpRVJAAphVL8/p80aU
         JiGbIb7CJle2hdKZnR+//lfiyVSPo0yM7bYV/DF55mWVNxbxtyRyvYQW3VuKF7QnmZgW
         nKaw==
X-Forwarded-Encrypted: i=1; AJvYcCWvFGoQX8CaJ+2G9ZhbOADduDR/BISuM7wIwx+fecV/ojIFp4xKiklIIt2drjpRuvFaQnrqZ6dBEgFWQPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqhYW7SL7WfbdSSOx8JNgMcCJTGC+6YJW8yVrUhzv5p1tnhNG3
	cpzhqYzoaLcGhWpIlQKpeKzEfx8SW8DURjIlW+AJPDjvE6kJrA+NITq6DcaBPKsn9HHh6aQIepL
	lSzixM8QLrPzjPMNmdmFVP3LMKATuUwLkG4TXhUB6gwxFBTg5Eba36me43OAXBsc=
X-Received: by 2002:a05:620a:4091:b0:7a9:b52a:a6f2 with SMTP id af79cd13be357-7b193f080dcmr1729302685a.8.1730540169280;
        Sat, 02 Nov 2024 02:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOpuZhSc/uUOWj0mnoU2gw1NJRB4sXHPQcGTLP8tl7/FwvWLjafzIamKU51fvqyvtbBO+7rA==
X-Received: by 2002:a05:620a:4091:b0:7a9:b52a:a6f2 with SMTP id af79cd13be357-7b193f080dcmr1729300985a.8.1730540168925;
        Sat, 02 Nov 2024 02:36:08 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565df86esm291855266b.112.2024.11.02.02.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 02:36:08 -0700 (PDT)
Message-ID: <c4407327-1060-4805-abb8-0c7bcb067ee4@oss.qualcomm.com>
Date: Sat, 2 Nov 2024 10:36:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: Add base sm8750 dtsi and mtp and
 qrd dts
To: Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
References: <20241021232114.2636083-1-quic_molvera@quicinc.com>
 <20241021232114.2636083-5-quic_molvera@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241021232114.2636083-5-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fym9Hf_Ho1sZEDZfcrjud5gSuqNKxdsi
X-Proofpoint-ORIG-GUID: fym9Hf_Ho1sZEDZfcrjud5gSuqNKxdsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411020085

On 22.10.2024 1:21 AM, Melody Olvera wrote:
> Add base dtsi for the sm8750 SoC describing the CPUs, GCC and
> RPMHCC clock controllers, geni UART, interrupt controller, TLMM,
> reserved memory, interconnects, regulator, and SMMU nodes. Also add
> MTP and QRD board dts files for sm8750.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Co-developed-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Co-developed-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

[...]

> +&spmi_bus {
> +	pm8550ve_d: pmic@3 {

These usually go to a separate file each.. But I see why that would
be difficult here.

Lately I've been a fan of <socname>-pmics.dtsi. WDYT, Bjorn?

[...]

> +		apps_smmu: iommu@15000000 {
> +			compatible = "qcom,sm8750-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x15000000 0x0 0x100000>;
> +

[...]

> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;

This is usually dma-coherent, you can determine that through a smoke
test

> +		};
> +
> +		intc: interrupt-controller@16000000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x16000000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x16080000 0x0 0x200000>;    /* GICR * 12 */

These comments are copypasted gen to gen and don't bring much
information atop what's in bindings

Konrad


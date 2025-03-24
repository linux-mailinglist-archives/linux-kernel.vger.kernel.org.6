Return-Path: <linux-kernel+bounces-574286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AABA6E328
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A74F3AC02F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A2A192D77;
	Mon, 24 Mar 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3l8S/Ag"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416618B03
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843753; cv=none; b=kkLc3DfHMALI0z4cOlnoDCmVcwWrd6kr8KmkDqSkpJr36fW705W+c/r6gWnjLkBsU4wR/YeYvbifq2ex8XWAUE/E2NhhkWplDSlM69s/cZHQ29RJKuhY19r/fhaolb0qD3bLWmR/FrUvbr8kHCITglUKv5vB6qsGZX3daNOz96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843753; c=relaxed/simple;
	bh=fBNjGhw6eywjKM4CPjTagVCVi48iAj00DoDAQIEtcVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJpSk/UHR5URi0394hY9Gx06+X6eE1iDcVbUQL0K1Y4k/HHpyuYCwBwAdQ//0thF6cZNy1yN8IolMKoiHh7GIIAUA4CBOnHXxgQfd/+wMZ5tAVHmhCjAFOAPmjElN8cVP+h+K/yAdh5U8m/DuNfc88/qRxLfZoFRRvR5quUNhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3l8S/Ag; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OJ0wXM004809
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g3WlA5imHAbR+jao8j3DyOpD0bdaiCLBhc5RaKXj5z4=; b=Z3l8S/Ag79s1WMv7
	hGqHRFCxtFF/PTWnSmWTp2wvAP/2/2T1BzfZ9SDFxkX8OSNyeUYmPw1KDsJ0EhB+
	PGY2Gh7fpOXeA6xrxJC4G0U5WI3QlM1FziRzPvsZHMxt7dp2tK+ouX8+ZKXSriQ2
	lLvH/MelqWNHgrwuNyjVxV2EzizsAd2Uce14/a2eYBLlDTzhT8DXjZdYqDl8Lh+f
	sJ/DNZcmT9yfyG/BlFMtFZOWYrt9wHIC0ASwCehN2npqq34GHlFCJnVB8Pw5Pv/4
	LTKI2jkaLNzpN7hOdGVpVBK+gO/mZrSntgnQrWMYhoGyEMQ1GQvRs4lcwGmM+NJr
	pBswtA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79nfvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:15:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-476695e930bso4704671cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742843749; x=1743448549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3WlA5imHAbR+jao8j3DyOpD0bdaiCLBhc5RaKXj5z4=;
        b=OKLoS4dRN9hIjxKMUoINUucZfD7hPtCLpCNPE6aDd31PW4okuSSWe/T2UCgO6mkAeZ
         /HmmHuWsYVxeDNjPe7f2rKzfOkinR0RZ6XzJK597izY3aV/aLxpvcND9lpRcNl/AzKgW
         s0mbB+Lml8r2SNQ1Aydi07SWSfxbLH8HLN3XMGUDUerzXK3BGo3uqQLCvTKgfZxxE5Dy
         QNVsrhVg753te0UElawWAlXlfkhTzQp89/NqwKyyOdT+i5uymabD7nWku8h7Q5Y6UCCp
         eRqTl+TFkprggPfh7cihobg8NQ4/uxoQ5iHhhU0reNYgKmYTganGimdI6DhuZP+Ineok
         OHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwFmT3x/ncmQFZm3ERutph/HQkcFF60ioMJ3mqxrvqb4bQ2365eb/Wjo55Xp3Aaidwa13IfoYWvOTlTuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYI5HBL1ck08ixjFfQCsBarnGEzuvDwOH6D1IOLjOatE9rgRfs
	nw7wGhtUPZ2ghTX5QPykwC1RhvOX8nos/W0aZQR3l+2V9zPmM1du6gfCUna1b8hwNqQrvTUv0oc
	RpnL+KUTB50goXVzsV9JfQ/woAeVX2f2o4s6H2AkZFl0S+VEYaU455XnmPX9NsAA=
X-Gm-Gg: ASbGncum8ZqvFT/HEkfxW4zIc5iw6gXphmgFtoPJmbjWJnD4DbLz2gBvIuY9fpTMz8l
	iOxCEx1EOgXlcIkouFahKc+nUzop0hNYWzi4KyqSiyxf2srf+5cfe3m6tINf+mmb8e0p4tuMOPW
	7uYocVVxBH/7st008KclOaZkDa1HAQi62XnaHba0ogvZ1ENoqc7xSHR97bwQkeMf7xFxNIV/Gay
	EvHFNl+3jYeOiN6EpusnFpF5glhlkPYQMdG4+WPB/uEmGfWyw4REkA6wVkIox2GllDafCQ93DMH
	uQDYSdXXoPtD1kBM99AcEJlD4eUSVpvVieasEiFfZcf1TLSX4twS4BUEQQ+8EX1XY3OMNw==
X-Received: by 2002:a05:622a:8b:b0:474:efa8:3607 with SMTP id d75a77b69052e-4771dd591camr75030571cf.1.1742843748418;
        Mon, 24 Mar 2025 12:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtmaP6yOrhxO/q6iKc0oEvHBuaQJo1z8Kot1OeZWFMeia/4semGeZRZf9taq7A7UDWKD4wzA==
X-Received: by 2002:a05:622a:8b:b0:474:efa8:3607 with SMTP id d75a77b69052e-4771dd591camr75030291cf.1.1742843747870;
        Mon, 24 Mar 2025 12:15:47 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb658e4sm719173166b.87.2025.03.24.12.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:15:47 -0700 (PDT)
Message-ID: <2b038454-8994-490c-9d59-9bd03f52e337@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 20:15:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
 <20250322-perst-v1-2-e5e4da74a204@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250322-perst-v1-2-e5e4da74a204@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GFgC-K3PmP1iI8QbfcOJps01fbwN-Bid
X-Proofpoint-ORIG-GUID: GFgC-K3PmP1iI8QbfcOJps01fbwN-Bid
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e1af66 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=bSnlr1PQR7FYCNIf-OoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240137

On 3/22/25 4:00 AM, Krishna Chaitanya Chundru wrote:
> Move phy, perst, to root port from the controller node.
> 
> Rename perst-gpios to reset-gpios to align with the expected naming
> convention of pci-bus-common.yaml.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0f2caf36910b..6c21c320a2b5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2271,9 +2271,6 @@ pcie1: pcie@1c08000 {
>  
>  			power-domains = <&gcc GCC_PCIE_1_GDSC>;
>  
> -			phys = <&pcie1_phy>;
> -			phy-names = "pciephy";
> -
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie1_clkreq_n>;
>  
> @@ -2284,7 +2281,7 @@ pcie1: pcie@1c08000 {
>  
>  			status = "disabled";
>  
> -			pcie@0 {
> +			pcieport1: pcie@0 {

pcie1_port0 (or pcie1_port), please

Konrad


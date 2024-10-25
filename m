Return-Path: <linux-kernel+bounces-382439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D29B0DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDD31C21DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A020EA37;
	Fri, 25 Oct 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NcqtlBZx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2220D503
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882083; cv=none; b=H7z/Wq2ElWn3wmhQGzFkicp+FpZQfJKWqEVzhnZttouM3UG/FH90JpodB3pOz6LPDb5oycI5uAe3x2NTSHGjzRXxA+xJzpJquccLQckUtDzrrVai60o9OpR0KZxeyhA9ucsxRgu1CWU7foDwD0v4I66NOA938cUDlNqBsd60LJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882083; c=relaxed/simple;
	bh=/CG4JuQ10DWL9F+Yvd/xIpn0XcOUOtWCOMrizs5JWI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/Hz4JWSbkcczQMJcpJDuC4fRGyTc55BwsKtAMCjhX4LzI/o7pt4w3rQyom5gvTs7hmHx+qN0tbCj6i2Lc7xzhU/mhWG0iA9qfkaYZOauI5/h0pF69lXwn8ziRYNcj+TZJOPX6VRrANfp4vVCuJUKwcGR7HJZ3VyZgmv3oLN1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NcqtlBZx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAo6XG006742
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFXog9CzN1JbPT5MLjqR2YdEriiY44hNAsTYnjYNF1A=; b=NcqtlBZx9dkCDGQl
	TfIVDtv5TzuNICmaIwYhQgZBLm/pQTEh3fESCfGPuGafOYkOWA1+wJsMRcbKc3TF
	mNOG0kbQ1BmRxYfQjLvF6IgQuvLA6G6Pkp5dVvc52QJiS8+yXXD7AfCATzZnfklN
	GXlKfhpli0nbnAYfLRlajt+eIriz3mC73mtpPQthBUu4ZYxqTQdV3iyw6JGMBCnT
	JpYuGzaUq5kEg8rpdJhAFVFJOyjEyj0j24+HzC6JUBfOuoanJfYruftYs7dJRgFu
	NVMZ8q+Yq3fXexAbBHHklWp6uzkIiR8b8s4LxXjU32+K2iNhmhB1jyEgpFF/GJ7S
	G4HAhg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g9x6hemv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:48:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbf3f7273cso6658126d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882073; x=1730486873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFXog9CzN1JbPT5MLjqR2YdEriiY44hNAsTYnjYNF1A=;
        b=jqo9wFHZfxL5t8raPLGV63+KnSPQptLISqvzf1a/QeQ/8J9MUGLuaIhqgCPC8d57x9
         rSnHzzKSTB7QjGODs7N4JQtzyq/HQV9d1p11uMei10RGs2ZUO16i7CyqpKSsUm78JGZd
         CIR+sV2uuaamSE9o9qV78kk/dFZiFJYhc+2SplSPag7TAPDvG9cUT1UCgC+8NH0RC5k/
         VK7MrfS//OqUrGidnZz8K32G1sYuie7nG1SzC6ArWSwwF4jBCtSIMPvsIngku+Vu2m4X
         Y2HClypcrfeXXPpdDkcZTncO4Shr9id9OTgWs9kzrANiUxa5WCkleq0VmQpICT+1ppZz
         PAJg==
X-Forwarded-Encrypted: i=1; AJvYcCWK5Rwrca/Ev5rQTTNihyOqmgTvow21fa6WF/5Bgeg5bbySgMN56EJf/xrTd/ScGK4hV6s5V6S07UlqyKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONtuoiWjLp2wdlpsHQRkCJkXZW2QJFX9eTfnDfps0imkoR39f
	Y2wv//b83fb1KPwKvMLFmSkNFYFBemMMoYkDBrQA8aoGqFuCZlDd+QbB29kysTFSYT7hF85eG3V
	a3overtEAIW848l+m6XNknADKIseAfPkcTc1bnG4Npi1HR6pL0SrdfnfBQrXqLS0=
X-Received: by 2002:a05:6214:194b:b0:6cb:f0f2:f56d with SMTP id 6a1803df08f44-6d185680265mr3060026d6.4.1729882073455;
        Fri, 25 Oct 2024 11:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhdXcaShoo57RMGPsZA2dXvZ8ufIsmj4l3pV7Tjjs+OrGQgre4DCGpRASRUtkmM1ZVAtzCzA==
X-Received: by 2002:a05:6214:194b:b0:6cb:f0f2:f56d with SMTP id 6a1803df08f44-6d185680265mr3059836d6.4.1729882073055;
        Fri, 25 Oct 2024 11:47:53 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029a68sm97186366b.83.2024.10.25.11.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:47:51 -0700 (PDT)
Message-ID: <69be09ec-e9a5-4fb6-890e-74a65f3ce404@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add coresight nodes for QCS615
To: Jie Gan <quic_jiegan@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20241017030005.893203-1-quic_jiegan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241017030005.893203-1-quic_jiegan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LxaL7fcMcFXceE83c-fXnG8yK1fei9Cf
X-Proofpoint-ORIG-GUID: LxaL7fcMcFXceE83c-fXnG8yK1fei9Cf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250144

On 17.10.2024 5:00 AM, Jie Gan wrote:
> Add following coresight components on QCS615, EUD, TMC/ETF, TPDM, dynamic
> Funnel, TPDA, Replicator and ETM.
> 
> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
> ---
> Already checked by command:dtbs_check W=1.
> 
> Dependencies:
> 1. Depends on qcs615 base dtsi change:
> https://lore.kernel.org/all/20240926-add_initial_support_for_qcs615-v3-5-e37617e91c62@quicinc.com/
> 2. Depends on qcs615 AOSS_QMP change:
> https://lore.kernel.org/linux-arm-msm/20241017025313.2028120-4-quic_chunkaid@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 1632 ++++++++++++++++++++++++++
>  1 file changed, 1632 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index 856b40e20cf3..87cca5de018e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -202,6 +202,18 @@ l3_0: l3-cache {
>  		};
>  	};
>  
> +	dummy_eud: dummy_sink {

Node names (after the ':' and before the '{' signs) can't contain
underscores, use '-' instead.

[...]

> +		stm@6002000 {
> +			compatible = "arm,coresight-stm", "arm,primecell";
> +			reg = <0x0 0x6002000 0x0 0x1000>,

Please pad the non-zero address part to 8 hex digits with leading
zeroes, across the board

This looks like a lot of nodes, all enabled by default. Will this run
on a production-fused device?

Konrad


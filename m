Return-Path: <linux-kernel+bounces-405752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D29C571F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C5CB616E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1020D1FA82E;
	Tue, 12 Nov 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDA9agfM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F01F77B6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410862; cv=none; b=uGD/UPEJHSOTesT0U7/g7+ptwf8OAX86CWm20vBEcf0RpUcHYqpytKZkGuv/HjgHt2NNva2mS/I7k1r1VKMp0ldg26cqEmBat82z9u7XomrzbtkCkhGT/aQ5TrBAjz/txrmtV/Y78sLIFk79G50KczAEzVoVz/1kZdxrZMq2I44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410862; c=relaxed/simple;
	bh=IwFPI0wS/zSh9KO3kInJdnvla0lwEg1CpwDSNeOb+RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ep1lUMyk9a5jR63NCmdCKcJL3+kzJCLm8LmBsdEiPkUTLF9TDuNbC1K+jMJbm88c/LG7eF51FvD/fYhdbGFbr6CgTT8+B/sdWf88WerK3z9prC4bhFH22L4bD00vGdMO/X3vHPY7/6FzUQWe9mAggxnpyB8VD5jiHV1ANWmZSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDA9agfM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC1vUld005359
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8FysoUKQCmcH3GBytp0zaytK1t5Y0Chtzi5AW8BBt9k=; b=XDA9agfMHtXL6wLl
	wlAyhlRmH6aKjDOaNi4pwo+i0ZyDxWtXtEMyxGFMPikmhUlM7+jUmB++LXavl4Ev
	snNGQ+Ky8cPerfbaRAVgBFt6SarshXIzQdCtL10aroiPc4hGug2sReVpLN8G23UD
	0aZVDzCpMMb15k1p/SpLOzKQvcNFwMOkbBNVq6nqkMtvbRkSODTAGnD4QsVGnapN
	Z1iHD0uHZxa5jkA/Aeg0sD0Zu0S8TY4UG2rnlTkeYYirbrTkTtUW+5+VhFxWoJnd
	hMJyaEGsXe0fs95bOiQxhXbeKq2z2oJCnQTx3QmjPrbnxx32W8RQBrkq1+fec5Ev
	hyN96A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uwt5h950-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:27:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e320038b5aso156009a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410859; x=1732015659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FysoUKQCmcH3GBytp0zaytK1t5Y0Chtzi5AW8BBt9k=;
        b=WdmUVN2A16ld62is6FP7wtrts2MjkRAmS2uauX/be+d21H3E4r9H2voe/UzcsVD/mW
         9q9jwn1cUijDUgyoBQT/8KVAr2ZNj1RENm0VsgzXdM8AwRgEnZFVXYd4tSZORmsVkoN9
         co4W/rzqA7lnxQgrUkRtxbA1DaOIT7ACP4brrFY3o797oPLlve7sEdEDtvV66zwheuEV
         4gQBNvo4aPu+gYhuHzep9XF8IneWZBTcerb0UbYU1cBXeEkWE9WCXyrTigVNQOL2nZAV
         D1+66gGck7koqtbfDGSaKqNqYpP3uq5HMmVQQJCrGxjV4qoy5Vn3yw4GWok31mZOG4MZ
         OLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwEqRWSSf/o8+BE3xLoZ2i2+z3RAGg3ljgJl9CDZNZofMqTOu3ZfXDqBlzRWFu2f3yaBgdHDtOShBACOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9F2kGm9QU0V+8GAZA5DRGMCAGNOGDv5ZeRYuc/roey4xrQuv4
	5PUEDkwhVYLTzcZitv1OMz76TGHbJwXKDwENCDmm74cbJ1Bs07OE99V0SgjZZ5PKoumFnP8tvAb
	uHXLRzPgv3QKAru348HRP/+57xqE4r/nzqYA2ZnL7ysUF5gLfqNqINTO1uoPw4sY=
X-Received: by 2002:a17:902:f646:b0:207:14b3:11a7 with SMTP id d9443c01a7336-211835ad362mr97306255ad.14.1731410859553;
        Tue, 12 Nov 2024 03:27:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFFqOC1u19hi/xuXAev00tu4AN5Xhtkx8dXOV2vADFYDwPCJfvX72qKqUQDtVAeXkB3P4NrQ==
X-Received: by 2002:a17:902:f646:b0:207:14b3:11a7 with SMTP id d9443c01a7336-211835ad362mr97306155ad.14.1731410859221;
        Tue, 12 Nov 2024 03:27:39 -0800 (PST)
Received: from [192.168.123.190] (public-gprs527294.centertel.pl. [31.61.178.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def4b5sm711984766b.146.2024.11.12.03.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:27:37 -0800 (PST)
Message-ID: <341a864e-d3b4-4b79-8b91-79ff6f06879a@oss.qualcomm.com>
Date: Tue, 12 Nov 2024 12:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: qcom: qcs8300: Add ADSP and CDSP0 fastrpc nodes
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241112074945.2615209-1-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241112074945.2615209-1-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jvKUpwy9pDjH1XJlABMmD7yDquoPfKdX
X-Proofpoint-ORIG-GUID: jvKUpwy9pDjH1XJlABMmD7yDquoPfKdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=885
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120093



On 12-Nov-24 08:49, Ling Xu wrote:
> Add ADSP and CDSP0 fastrpc nodes for QCS8300 platform.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---

[...]


> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "cdsp";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x19c1 0x0440>,
> +							 <&apps_smmu 0x1dc1 0x0440>,
> +							 <&apps_smmu 0x1961 0x0400>,
> +							 <&apps_smmu 0x1d61 0x0400>,
> +							 <&apps_smmu 0x1981 0x0440>,
> +							 <&apps_smmu 0x1d81 0x0440>;

If you do SID & ~MASK, many of these come out to the same
value. Could you try to simplify the entries?

Konrad


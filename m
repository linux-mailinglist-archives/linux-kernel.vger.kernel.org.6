Return-Path: <linux-kernel+bounces-433802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ECB9E5D36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C41624EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E97225785;
	Thu,  5 Dec 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Um77fAcR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE021A458
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420048; cv=none; b=oEMV1vqWOkFB9dVke/9s8PcSy2ksS7A83CC5mEwS2idIC/AuW9bgwNmSWPDogNiIWCmDZultcL4EvnveN3KBLNWh4NdCwLc57nCJTt9+fjbzT9g6YyF9NUV/CS+sslx1XRhUUsKMh0od4MYtVxx9+X4+mnI0AKcJQhfQ7C9vbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420048; c=relaxed/simple;
	bh=ErR45etpBQW67008uzXSO64KJgR8F5qcJ8yKDrdpiaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emz9hPkSSJZCqdZlW5NRIl61MSuuVT/4eLpJMvULvBgpXEaIy37bHtXKqPHRgN7K+RLkz8YG/isNrteWRNohE8E0fLnyZxnPfeS3nr196m4mQYBps5jtub2FdDybuJP/fALD8VlYlwKXTqItGP04nadLT1pRgJWNniRwpCRnmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Um77fAcR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HWJhS010925
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 17:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sWfzeHzPMS1IcCqXdujMcNqA3F3fqajcpXaAmp3fkEw=; b=Um77fAcRknJg94Ck
	2Tc88LHnj+oqrdZNmnF5QVcW+jhO8AFOjMFbIoAvWVCVJ8GKO7gyEme6sA5rOa+2
	vw0kv/DWEqOeD9+PEoRwZt4GgQMSvO3/RwiHIIDkfpMZzYTYRJf3XcAcS7q1U8To
	e/1lgYjLt+knPXvpUoc82IAebCUJ2S16yGaxGGro1KchFJkMwNfFIADePjN3LSc5
	r5CkZnUTux5rJtZz4BiFTl5chgC9EznIx4BZN3+4wVHENSZkfyqCOKkrbmkFkNGi
	MLZJv+yzO/rZZUxwXbtUmwUB1627A7KN+9e/TX3RnmU3gkJS2zVHIWPaY1tghXwl
	egOJcA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w910dwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:34:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b66e2b7287so3150285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420045; x=1734024845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWfzeHzPMS1IcCqXdujMcNqA3F3fqajcpXaAmp3fkEw=;
        b=FTxPoSMs0tqOgg9XyQ+WACJ2/pYq348dgGySo+haWJrQwihLTuoQyJogVw9qzn9Xua
         Q+4TK8IuDPTuoZPW38u3d9QRzog+e0dc7b+8uuIaAkM/S4IQBD0DjoT8+sewjiLMLoVV
         eQW64XSyCWYniRArQnHGUYgksO65fPeom1500oAobu0M6EgaRGEqC4cZf37HEPbqy1Us
         tlMS5ZYw3JDN4I9JHS9HsEYwQDH/EDtCplc7B7EnQ2Y5DYZ9WApv64qeW9VjgKNuBbvU
         aUoSLIdB8a8N6ihLV2CGoQtDY73s0o2jdV0FqxVTUnQ+7PEnztC7glN4pQ/ZyGBfjrra
         FjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/lCPwiEL6/mvGSiUqEutiic1ceuvbyNaM7+W/Snki+J2u6+LiDr0VgiXFIONabkbN6O8KP8cG6E0jG1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBOiqLmBeDwcHVtDTE10X0aGBh1iQBnzGp7sA7hV2HakO0bL/
	eieGFoBDMjusJP1HJpXYZTZk8lMxo3/HyTmuQuqW1M/uoyM7cgNep8sv8PDzf5LPq6gIdyuMQid
	yDVc4069aQDkGkgdI7FCZRpcpNLNcs4Gh6T6KwHRhJhwSpofuqvpPpLVxbT/XaCs=
X-Gm-Gg: ASbGncuHJFuFcrx3Pcudk1itiFU//oTtewER4V+/yiA42Hz3uAQVY/J+X7OOPrfwVMB
	JuEYG/c2rI3asstOiaUG1MAz3UR7aqT/0OsqZ/z9hqdy/V3JFd/SKtXXrZpxBQmUW7W2HfTOyeT
	JlHSzG46TrnJ0i4n29GukXm5CVFe1UpdRDCcGH22ocarO/bmgSdxhzDxEIft6pAefWiC1jElsFd
	rwS92Xwbrfs7qlgGXqLxJJKn967Tsidcj0Ix7bNFmI/tzNTn0Ci/7bTSSpTyNedygi8Ha3b7H+F
	cWet+UDhjL5+GqdRM6hKsV+KJMKnaBw=
X-Received: by 2002:a05:620a:2a0a:b0:7b1:3bf8:b3c4 with SMTP id af79cd13be357-7b6bca1437cmr4669985a.0.1733420045078;
        Thu, 05 Dec 2024 09:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn+YSIkAxvBPUmW+ektuB1ONEtrSu4RodZeTIDoAMUuqgS1Sk4wf/LaoZLm1fMkVJYAIn85A==
X-Received: by 2002:a05:620a:2a0a:b0:7b1:3bf8:b3c4 with SMTP id af79cd13be357-7b6bca1437cmr4668385a.0.1733420044721;
        Thu, 05 Dec 2024 09:34:04 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62602cf52sm118774066b.115.2024.12.05.09.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:34:04 -0800 (PST)
Message-ID: <4e6ec861-ef4f-4384-aab9-107c710987af@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 18:34:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8750: Add Modem / MPSS
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
 <20241122-b4-sm8750-cdsp-v1-2-9a69a889d1b7@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241122-b4-sm8750-cdsp-v1-2-9a69a889d1b7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: N8qQI76WxD5dcFxu87_PuAOs9cIYUbE3
X-Proofpoint-GUID: N8qQI76WxD5dcFxu87_PuAOs9cIYUbE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=794 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050128

On 22.11.2024 4:26 PM, Krzysztof Kozlowski wrote:
> Add nodes for the MPSS and its SMP2P.  These are compatible with earlier
> SM8650 with difference in lack of fifth memory region for Qlink Logging.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

[...]

> +
> +		remoteproc_mpss: remoteproc@4080000 {
> +			compatible = "qcom,sm8750-mpss-pas";
> +			reg = <0x0 0x04080000 0x0 0x4040>;

This also seems to be 0x100000-long

Konrad


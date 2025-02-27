Return-Path: <linux-kernel+bounces-537266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F5A489D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E495188F58C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D726A1AD;
	Thu, 27 Feb 2025 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKDdFcPG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B126E97A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687902; cv=none; b=XFQMdfzoO3qqfSuZ2aLqxy7t0jXbhqssKfeCNuFPpSckC645wNUCpuDx+UBw7LZcVVgCfVRalEAtbpmrCPEY3vEE6oBYUTgVjpdigBiHHwp/HBtCZTSU3MEMUoE6c3HCUPG92spQA497yTipeQvyPKHY6OSpmhp5I5veo0Ef8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687902; c=relaxed/simple;
	bh=9OS+6hDbVfFUXI6JvuGQyhuYnfONFb79Dd8enGJP7LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Flx8ZndxXHgCT8d9lJV0ynDCqgNwS3ZS8OU5bINRmZPBIkqP48MZp/3664AugBaLMCBedcamXCI3OwDzWna5zLlz4fjNKv8hyJoaLJrqId/6yUgYRivbIXzZaW3OhBXjKMvFm/Ko48OVhEYW9dArRHnFUriwLzyydmBdkeK1E5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mKDdFcPG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RASEDN000617
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R2Lz3mKGlc595elVKM7mSM1xzMWVbV3RMA869FQ0GuU=; b=mKDdFcPGmd2KRYNg
	RtcOKQLZO7JS4jTGW/dN+rxi/5oNoV5Jy1LLTdEnxmYSkKDz/e+961dgrS8NYgIJ
	+yk30bEM7rROeqO4/v8qI+MRlekwvTVjZfNKEzKaO7x2LXZ9W8hYCrn8cr0Tdbql
	nhkcMR6UsY393//8p6AsZk8c/6t0/qmhC+/5wpNnss4v/cuPduqSfoqDUVOKkq1O
	VFMX3okx2LxyaXP/cBCSKkGxtr5m1BcxybB79P2w2JmoOa53S15O5nPEp1YaPnYh
	HhAPdTKFCJzD+QLFeDNXo4pDm2JjTVqiclHfpAugh8FA/l+OQH9giFTNaEktf3wk
	QqJX3A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4522skw2yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:24:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-471f842ebcaso2456451cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740687898; x=1741292698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2Lz3mKGlc595elVKM7mSM1xzMWVbV3RMA869FQ0GuU=;
        b=kyRvDQp6SEopJgcggGJHVLEePWZoh2RrAE//EwZijeLBK1L4WXsFLZiy4U3sYv1iTD
         q1l2ktO8VR33fJb0+HMtj+H30W2mPHsO8sf5TdIWpL7QYFo95L2oi9tJJm2dcLwZPlKr
         1KH4ZU4T1m84ON5g5ITReVWbMHI9TQQ9OeU4+4JKU8r5M5u2rzZ2Xs2Wxq1yZj/1nHa4
         ZyN2WVFMgdz9d5GcdbXr9GNf5IvHWRD+HoVKmB88Ool0kVkebv/6vCU1yGr9Mg+SFiZH
         JEbrhipIyVarg7tAs4BcMQyLSns/WorbZlSV46X/raKnZzV4Ds63n3dMhnFvsvmv9g6r
         XIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQo0kQctrF8SNP6915e+gSAK+89iCdhxkra0oj09BaI/Hc8LfdNqv13gHXlEYrPu2CN0cnm3/TcWnFCxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PUgUDyRfGaYRF2UUNenxBKKrVLw0kAU+uWAKenMM2EHuFobS
	DvAl0x3fV+lmrCAGJmbnC1+3nzRhYQ1Kpmv0wrqdJs0shFTc5BXFBeJsoJJH24vN0XnaSULGIVx
	XW/JNJrDg1xPd20DD9DhfFXkWO1UEpAJlbv60KHFrf9W1vg1Fxig4XNVfoPCj0x+hNS/GjIA=
X-Gm-Gg: ASbGncvGr09nFqlDNWmDjkfHsbkc6MtXqb2jD7TFq/eL0tRbuBDQLXiEK/afBIKICgF
	uasWzNqPZWrfsdUqRq62a+fsOYo2oWREbyskmxluXUemr1FtVrYCCCsvRY5jKa0lQUuS9qIlCB0
	aKzecDNop9wnzW7iDiIvGj1in/IlXdHSMTl/+m35z1KmNWGZSK45og/5obFZ/HDmPtsNP99rQ9k
	EMEMOKvPCoU+mPyesaMJAxCjbWmGFy6NUhIbViFexXHnZS98SBk7buuayXrS99WoOCjV79WHaFC
	SmGfs+VaF9zkvmBhcM096DnoS1pssrCjH23GnFjTxM5T5JImcMZcQv7jPlodsAip7qsfew==
X-Received: by 2002:ac8:7f42:0:b0:472:45:3c26 with SMTP id d75a77b69052e-474bbf8e759mr2422001cf.0.1740687898647;
        Thu, 27 Feb 2025 12:24:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2xUDBpX4MmMCSHKRY8D+mNnEPixSG2zUCQ+NshUqO+fba4A46XDtRcVS2g0DoX6R6pBbxOw==
X-Received: by 2002:ac8:7f42:0:b0:472:45:3c26 with SMTP id d75a77b69052e-474bbf8e759mr2421791cf.0.1740687898197;
        Thu, 27 Feb 2025 12:24:58 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c74fba2sm173787966b.131.2025.02.27.12.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 12:24:57 -0800 (PST)
Message-ID: <2d09ebea-1f64-4ed7-8514-b73eca534875@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 21:24:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs615: add TRNG node
To: Abhinaba Rakshit <quic_arakshit@quicinc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-enable-trng-for-qcs615-v2-0-017aa858576e@quicinc.com>
 <20250228-enable-trng-for-qcs615-v2-2-017aa858576e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250228-enable-trng-for-qcs615-v2-2-017aa858576e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2h1qJXGzFKRXB0qazbohOghLo0ZpWn6t
X-Proofpoint-ORIG-GUID: 2h1qJXGzFKRXB0qazbohOghLo0ZpWn6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=779
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270151

On 27.02.2025 9:15 PM, Abhinaba Rakshit wrote:
> The qcs615 SoC has a True Random Number Generator, add the node
> with the correct compatible set.
> 
> Signed-off-by: Abhinaba Rakshit <quic_arakshit@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


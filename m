Return-Path: <linux-kernel+bounces-444087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C19F009A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE31E16AA96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1941DEFE2;
	Thu, 12 Dec 2024 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtxJPCZq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342741DED7C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047818; cv=none; b=fYd6h8LCSZVrTKo1SwwUbdakRvB3H6bIN7ZASGQUp78g5ZRCfnDN0RXbktKF8VQV2xaBx6lxX0rLi/yHPrtLMs5Ucc2HG7Q4wiV2qB/CWdimdQk6L5TajT3fJojv1XPmWPW5Z5OO64+hQrlHZ/dOUG3dboG8MzSuJlRGo50TEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047818; c=relaxed/simple;
	bh=aypqBEDo7cxiaQTVJnF2pXmioUjFcR+5fj45JQdYhgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrRONvyk9Jkmx1bDFF/SKCVxBY/IjwnqM7TwOW3HsALNyVQpyLVFKpFb8XUV1wMEktRgfwjYWeRc+OTBWPO7lJgkAoOUVKRXTqJ8pWR5F0eMBPksV9G1fptPA9MCuRKbf6fxinswokgp8bJamMI8ntqgZC52o6tsA/+dJboFJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtxJPCZq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGcgKv019800
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	igkze4eNvMlgvzpqcEPf2X9VDFsvbmDI+1YMKHbfq4A=; b=BtxJPCZq328LwSdu
	+HOEKW+BHMKvUkpMRZu4bo0yu0dUqfHn6m5Z9hWE6GZtKgZ1YG9TnYSKfOAaJZUQ
	jQcZ/2rhDxTT12cJ55KIT0LoHjyUHcxk7cXehZbWul8+mOS6ij42bZTDKc9Hr+nz
	+PWX/kRFdMOGVbYjMsezxNB5THPdLh+28+ezZi8xOWkGjR8kqk3EjcxvofPxtq02
	OuAko0+T1AI6A4gvdh5+rmgGleg4r5wrUCKIXlMUFRkSCHj0auXsn2Cwuqlglk5j
	LOSrXQaY6YHnvb9duE5e3myaZfVgRaGC44rjrylI4Oy8RWOxMP4bMIxjztAVOa5L
	vny8Og==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdyv49m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:56:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4679fb949e8so1738731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734047815; x=1734652615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igkze4eNvMlgvzpqcEPf2X9VDFsvbmDI+1YMKHbfq4A=;
        b=CqJVPKUxoTZFHCujwPEG4H86o9AgwznhSqRXtj1hNB4cjqBogVshINx3x+tIwRJzXi
         Y4GsiT2s0G9q02UoHy0KW4CEPmwg8CkDU4ZXfIEUbalHWYfgXDgzwmd8eZajEC0+SsUk
         OFyORqnrFag5NfVPm5sTgFkzUuAM5DSfBLteu3nWWsfqbddbBb3sw3OJS6ZIRiprP9kL
         YcBgs1jQJHLQuDjn9XlGfDl95w5if1TLOja4jbOJiNtge61cp+Ka0NkCPWSi0oDMrBOQ
         2q7rU1/isK870Txt0jrOmyNvS8ScMeRNuAriOy+5ivu+ZkvIXplWpZ0l/l84hqAXzc4r
         50kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnSCWE5oABBi2kDcyRuCsoVrCs/7VKGFwItGVQcjUo2uoNAY3yU2s2QTbc1mMSGav6B4KwtYgZlgTmWxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjsDh6XKy7R6IKTy1MGhv/vqcLNFCHux6wdF0pNiri+fomSWv
	Uvjzk/ifM40kdCcmot/UTuVj6bYRtCuEVFREe1PMOax5YieWvE7oYjyK7yk1iGN1XKgSW0FvE5L
	YxAmtK5Hz5HzUl2YB6J8XGiwLXbRjOK7K1JPGY9yP/wVOthxTgI1SE0Nc2ZN7ODk=
X-Gm-Gg: ASbGncsvdTKFoQs19res9/EJndXCjjOE+4JhZ2FTcrn9qcMKPT+htBMYBbEVbsyRzqw
	iAK7adWUAMgwEMm8BYZIsUfyPLx/TeiitQnbWEDeuXAYShts8uI8jYCYuxhSChYUQcDbXQZ1gaZ
	P6KilEQj3s0uCZHG88QqmdJ30mSqOXLFX1NQUA5Pkhq+44JiLZSxImP54L6US9wq8BDe9q0LV8i
	Y+tNo8XptB8lj8VrCSaUElqp7a902QCsrPcsPYTQz/ki5d8ykAXD2MMyWnFb5nBpG0arFLkIcL/
	gzRghwdenySc0x07XcB+NbJpPPzaeXHq3gCz
X-Received: by 2002:a05:622a:48f:b0:467:95c2:d8a3 with SMTP id d75a77b69052e-467a575541bmr4033611cf.6.1734047815097;
        Thu, 12 Dec 2024 15:56:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVdy+xBxzqm0XQW/NYiBLzG2Pc2PWxSKMVl5eSX5gu4+DsOJ6TJe0k3mLn1vWEbfRN0MJg9w==
X-Received: by 2002:a05:622a:48f:b0:467:95c2:d8a3 with SMTP id d75a77b69052e-467a575541bmr4033481cf.6.1734047814774;
        Thu, 12 Dec 2024 15:56:54 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm9142689a12.6.2024.12.12.15.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 15:56:54 -0800 (PST)
Message-ID: <553d1727-18bd-4e8f-8e05-80818dc50284@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 00:56:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: ipq5424: Add TRNG node
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241206072057.1508459-1-quic_mdalam@quicinc.com>
 <20241206072057.1508459-2-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241206072057.1508459-2-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: z1y9PEUx6AHQLdM9OiJAMGWvnOZkKdXb
X-Proofpoint-GUID: z1y9PEUx6AHQLdM9OiJAMGWvnOZkKdXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=768 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120173

On 6.12.2024 8:20 AM, Md Sadre Alam wrote:
> add TRNG (Truly Random Number Generator) node for ipq5424
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


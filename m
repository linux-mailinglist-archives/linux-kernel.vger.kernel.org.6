Return-Path: <linux-kernel+bounces-434907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7129E6C96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB24F280C82
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2F1FBE84;
	Fri,  6 Dec 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvyfJFmm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443D1D47A2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482346; cv=none; b=nGyzrge5AtGZklVKbz1G6MYiXR4B5sP0syMzsvuw6XraAu7lB7d2GUmuevZUuGNbm0nmxXCCCJkhzGOpzdPBs7n/48LxvAaf/zbbJwF1Mdweocdvq2hRnwiyR3A5tHI4OaSUcOkvKTKzP78rygFeu+ZTVp2smzNNyYHJG3bMsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482346; c=relaxed/simple;
	bh=wWWEYMAXdlUziSsHRN4HOaanRzO9WAbfjgpE/4Ucb5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR/RznUXtNC3JpGhxBtICJYPLu62Fr2QSs78bUkmFHAyEZfZtQ172Yjd6JZDUOs94n4i8jIvtC6KAwwTzrjtqVtMIKtom5HJEYvAuCR+MJShrtfRExES5DhF9JfqTNrTIIOUAEUyR1ZkxJFRWaBD/pG7DkZRX23xahIq+v92wqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvyfJFmm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B63jx0N006288
	for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2024 10:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l90gIw6r4rYLPrF/dGeEiRIuwwyQmD7LRxJkthT1YZI=; b=YvyfJFmmhgZXxsig
	U9xG+T/ejTym84z+GvRD1puGN0VQiJD06aIwUnerln3WN8My3UfDT322eekjXzSa
	py9dHEz/2dGRuQETUDBTETZ8bw+sfShUH4MDkITyKJgsnFaEhWD2iNChqX/M4hSJ
	2ENoIKnmzovmTvnVNAi+aaWH27q89I480a087vR4wqlVe9D1eUWhp12wKNsP3d9d
	/jeUvtamy58eURlkY2pHviMd9ds7gnQrAWC6j9V828s2QfIQk7/Q57re/aP0FfXB
	0Nvkl2iEictA+HfH2ep7ODwaeZ3aHrqngoLFZr78AZQtfiP06pTd8OFFxFih+x4M
	6LIk/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bsn6s4sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:52:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46698b09335so3622781cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733482341; x=1734087141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l90gIw6r4rYLPrF/dGeEiRIuwwyQmD7LRxJkthT1YZI=;
        b=JTwx7qUF9/Z43BZPoGAMQKj1LQR47VH7lJu7/bzto4Fge3/ayo7XNzAg+Pp+4GKlvU
         ndMZh2ZuFIuLd9n2i38dZzp1f+1pVJ6Kl1M2eSyP0p53smBeXE8N86j29Pa45cy6iU0c
         QuRDfEdSf/W9XodlJkHwctyjKd+M4Evj5Yi7JYtzn+zINht2xl+1Ur2zOvzG+qjmXsA/
         x2IGG3yP1OKe5WWCvyf636wpI/H3vLEXXMe61v4ueuao7iU7Rno5jCnZrpYohNwiog36
         jgp2VweV7FgJPtrd02YorGDVnDqQwk5RIK6N0XyC1VZ64qhZ/KIq5a6DiCdx7DSvtmPy
         KvJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1RPTR1tM6tlfkkn/HUh57dfW5Me9XhM8ZeuhPpJkIMkq4AJZm+olb564M5+dzJ/XhK1SvZAoZN9wCpgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEF93C8PpY5OyrtBSkmX6nk/6pPGz7fzZyaJuYzbLakcYp2QN
	54MGdH3Mpbkwne+2uexdc7xNUjuad6HM+QFJvPxeVNYKg4NG/Bk5iIfgy3QY48Xf2vuG6VB9H7u
	cVeP6hxYteVGgpSATAPUQsyXE8uN1urCihOGLvZhRmL6eBNNYcWuUqXufEYy/xg8=
X-Gm-Gg: ASbGncuWjJC1IpT8gRx52lAH9Z3KWeUOUvX2RE+JuYA21qvgvnzVXn4FVcZU6u1TFQa
	9dO/P8wkQdamDV2BoEDY7B2u7052P7s192E8IhdxgB/sk+JBPHCIx6vau7TQ+zMOTu2pU428Z3j
	DEOBmwUZfY1mLWusRUukC0xCmt1khq9IHYMargNgdMI3N6DwpKkxmIG+5pB40a25Mw7F+hhrSgh
	rUywqnOft7BUPvI69Qcwfpxtp/6gqhp9Tt0x5XgszVqgDSClEnWKqftQODI2Rr1ThSA4C8LvVTp
	1AQ/9ZaEYN0eF7KWQ3OXccIBZmMKle0=
X-Received: by 2002:ac8:580a:0:b0:461:2061:1a5e with SMTP id d75a77b69052e-46734da57cfmr14969971cf.10.1733482341604;
        Fri, 06 Dec 2024 02:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKBLnDP8FPVCBTr6JxxdTZHPOq6zX7gxHnwoB1bahiyFFZcrpKm+8cqSAvxz2zL6/33dM2PA==
X-Received: by 2002:ac8:580a:0:b0:461:2061:1a5e with SMTP id d75a77b69052e-46734da57cfmr14969841cf.10.1733482341258;
        Fri, 06 Dec 2024 02:52:21 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608e0csm1987825a12.41.2024.12.06.02.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 02:52:20 -0800 (PST)
Message-ID: <8709975b-1f1b-42d3-b0aa-762b2b606c77@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 11:52:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm8750: Add CDSP
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
 <20241122-b4-sm8750-cdsp-v1-1-9a69a889d1b7@linaro.org>
 <ba887e6a-7bb2-4170-a957-d4299012ae01@oss.qualcomm.com>
 <8e359b6c-ee68-4606-a485-057df0b27d92@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8e359b6c-ee68-4606-a485-057df0b27d92@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FFScEyeykmc4ktkFNcwwIcZ9Qhm9fGxh
X-Proofpoint-ORIG-GUID: FFScEyeykmc4ktkFNcwwIcZ9Qhm9fGxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=725 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060080

On 6.12.2024 10:10 AM, Krzysztof Kozlowski wrote:
> On 05/12/2024 18:32, Konrad Dybcio wrote:
>> On 22.11.2024 4:26 PM, Krzysztof Kozlowski wrote:
>>> Add nodes for the CDSP and its SMP2P.  These are compatible with earlier
>>> SM8650 with difference in one more interrupt.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> [...]
>>
>>> +
>>> +		remoteproc_cdsp: remoteproc@32300000 {
>>> +			compatible = "qcom,sm8750-cdsp-pas", "qcom,sm8650-cdsp-pas";
>>> +			reg = <0x0 0x32300000 0x0 0x1400000>;
>>
>> The size seems to be 0x100000
> Even 0x10000 (one less 0) according to downstream DTS. 0x100000 would be
> entire touring qdsp6v7 map (1 MB).
> 
> However we always - sm8450, sm8550, sm8650 - map here 20 MB for some
> reason. Any ideas?

No clue. I made this comment based on what the computer told me.
Maybe some Q6 folks would know..

> Let's correct all platforms to 0x100000?

After we figure it out, sure

Konrad


Return-Path: <linux-kernel+bounces-370756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC4D9A31AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B81C231BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D369487AE;
	Fri, 18 Oct 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KhWo4RH7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110873FB3B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729211589; cv=none; b=HxGK0I8aGNktWUcnmLwqs2QNA88yG74MGcEmWO0T55E8lxRGkoFoCkTuhrRlji0QHqs8pB09KD8hDIWOx+yGQkQvzLqdyX2iEKZ0wlY2+g3Nb1cmutSy0NlitzrY49Ke2Pif4GybqmiUlenJJyYjmcAuyIhR22ZBEUcDXpR3TF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729211589; c=relaxed/simple;
	bh=cE3xjhiiZaeaV7oJafobR9KWApU8cMk2n2Fjoanwaag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxDn3S8EeitfgDpRQlZxEUJ8oCBcKvOQKMOJT9TKfaMpeHf6trTaZ5j6ul5TDRQLnMf2Y8D0cpO1dzO0ge2VC8hpe7VaoVKT0SAjME8J8aeTw/81Jb8DTCFqLljBmVFJndi35oRUt5pPmjs6WHFsxYgOmvFMOjGD5FZ6MCZ4bC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KhWo4RH7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HLjjXS013626
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lhWA5ZBIRh/44GpNuOcCNtLkp+17J7refo/uW82cU2M=; b=KhWo4RH7Ff/ZKJM4
	hbiU4a89jLwyn4ZxRDGBjdwN057mzmWZxeQHWzgmWOunFDOQFnam5RSXgxMYG5IT
	xVr8SO/tGLtBAP2r2XZjT4bsAHmL6mBYDGi+s13CBZ0smZkg0MUqBpoWVbbjj12s
	ZIWgloRNoZYJtksZgZlbRzvi64JPMFLMiTaae/fGENRlQ9n8JyyzmT+yE+l3y6+3
	Dch9HhUCTWz2I8W6izSpi+YbfmiuM/d2H+GrTObn5Od3ExgC72tairAvPduONjhD
	wFXTfO1/6IeqLkEuTXkWFaNkDxABBFVRHjro+p1210Adjp42i8fZpEWfoKL30nJd
	Kv5cxg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ar053k5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:33:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe91571easo3120076d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729211586; x=1729816386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhWA5ZBIRh/44GpNuOcCNtLkp+17J7refo/uW82cU2M=;
        b=E4DxLvcTRJp0x5LEtsgcEGKvMvy3/3JG0ZPlAB0QEZcuPPbyeSniCYL5Kyc1da3zMq
         /05WjtUiaNzBigTUPKXRwca7lV7r5JXfj9mUkyxq4tmqGklNsqax1p3M05ftwJmNPbgr
         XmAbhSZqHDLo1FupPfJnmrQ67ugoWqous6KKfx+47PRzFKGBY5apz+OPtVG3d/7Z3vCS
         ff4bFm1Jqr2aiNwP3S+uudAprcn67OGvEhmE8KeihPe6/Mf+Z6kXo4h41EWxxJMDXhGU
         YF7TJ3dIXnCZ4xRSNXkc85GL7ahZv1wA5XxO5ASjvUEK+pUujKa1UP5sumzuvPW62Q2E
         xamA==
X-Forwarded-Encrypted: i=1; AJvYcCXnzxLt2EU3mNt3t6B3g49rxvwGGUVOXftg/jja8pJzc7v+BmvYH3cwp+eECB3OrnHmzuVaMswQlRS/Ivo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv71AwZbowEhTy6rr4pBNZmnnlaaAeq6xXqwgzfT3ypGDwnPet
	N6lvTMtNcpiCgqPeywPgazO3QTTlKaWnsD3yg+RV3XqkNfchidzEecmG4ugCX9ifdeppoPAv1DX
	ecowgY4zzZoqhAplHaZkmBjBCJ5WnoxZMj25XAuWPjAzg7vzcHisAhDFVU1keB0I=
X-Received: by 2002:ad4:5bcc:0:b0:6c3:662f:8e09 with SMTP id 6a1803df08f44-6cde1601fd3mr4324956d6.9.1729211586017;
        Thu, 17 Oct 2024 17:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuIivDn0b6wSNMmBKFBt1Bi69aZZBQA9CrJqqcY0tWSd6fueoLaV368qiR1qoOK9Kt5ZiLOg==
X-Received: by 2002:ad4:5bcc:0:b0:6c3:662f:8e09 with SMTP id 6a1803df08f44-6cde1601fd3mr4324756d6.9.1729211585676;
        Thu, 17 Oct 2024 17:33:05 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf6ef0sm25901166b.179.2024.10.17.17.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 17:33:05 -0700 (PDT)
Message-ID: <0db45f6e-54c0-49f4-a9bb-51f703084a3d@oss.qualcomm.com>
Date: Fri, 18 Oct 2024 02:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arm64: dts: qcom: x1e80100: fix nvme regulator boot
 glitch
To: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241016145112.24785-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241016145112.24785-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bFGpLrBnyShUqZ8U1-QhmlfaLejroJEo
X-Proofpoint-ORIG-GUID: bFGpLrBnyShUqZ8U1-QhmlfaLejroJEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=835
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180002

On 16.10.2024 4:51 PM, Johan Hovold wrote:
> The NVMe regulator has been left enabled by the boot firmware. Mark it
> as such to avoid disabling the regulator temporarily during boot.
> 
> Johan

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


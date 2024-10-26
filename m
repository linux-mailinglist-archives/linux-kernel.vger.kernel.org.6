Return-Path: <linux-kernel+bounces-383068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566379B1707
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC11F22AAF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86491898E8;
	Sat, 26 Oct 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMQ/r5Zc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01B13792B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938493; cv=none; b=KGXDEwAo8YWMpa/6tlOVLrhn9izK9FQobhvT2vNjuCfXf1MBERuAKoBwiUq0ygjx9KwixVyvwo+kn3G9XSu1RsPMpO8KedsUhfZup3Z7PgFud67JOszdZ/ifE0JQuVZRNJAdimVjfYeFezBKXqW/U0w96qznVbMo/W0E27nn57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938493; c=relaxed/simple;
	bh=7ZAm5QtGo8TAgXa+E9WOGdCxBAIqDVbFeTqV5SxCGTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3BFROazB58uBI824/amsCTtjRMytVydKVHLq8GOzZuGJGPNlcMyNJlVn5Qpi5Lti9ODAu76Ml1zdBJX7OYKAtHE+DatXV52E0luoYWxMTxcVjfMDdRbpcUjwda2Ni74mO74jIym8jOG8eQ4U+gbkfx8vt+F/R8+BSYxvfYlKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EMQ/r5Zc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49QAHYe8007881
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h4CKBaqfBb2ArU4IJn9Gp02L0YwUyeac5G6rXHuq+Xg=; b=EMQ/r5Zcs0YMF0lC
	t5m8GYFuampdv+d3a6b5zMb3GdLBKK8oGqhZADD7Xv4rxutmvvNCh6A9Zp345XcH
	0vT6AA0IlsC66cbHpTA2LyzXR+GTrcqHuD9bsjhxyMlqcGHEvjZ1rfVcnKbuzTbw
	/HQx30Q7sYUhvTrvtVr70Gxp8NhieFsEmWIlFhG9PGDWr9RqS7d4jH8D7X+ihql1
	BbR395doabB4wwtfqHdNsIBcrwjdpAB6oUpqf7phY7kf3G/ryuAI1YRjiKmUMzTd
	zjx/rF9TdBnZ1Loi+37eHb9d4LTh7r+EFGLLbrVfdqQ1/xrEussRHmcKHUpRSKLI
	jAccYA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gnsmgx38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:28:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe6e6bcf2so8367206d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729938489; x=1730543289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4CKBaqfBb2ArU4IJn9Gp02L0YwUyeac5G6rXHuq+Xg=;
        b=La01NbGb6jFpMHlgwUE+rF1FwoVX9RP1H3bVJhKMEUOI1pE57NW4YruFXE0FBBCKiU
         LoNtDT2ma3InGsFOSLjbLrPCvHyKjb+mvZ7dvbq9g1ZL1uTxyPfN5Bh8zHYlF/EkmWrJ
         19iecf9LtWf3YopVLvlyeCLkx6LOBd/IsS77OfhhiBGz3gAOWXcQa4P2nk74i68u/bGz
         gqgHZEklOWCytMp0l8vjTskrT9bHRt0Pp/CBdkjEql5yxTEE36+wNRW6jo7Du7SV0wcg
         cXQfq5kdPdG4t253FXZFwauxYK++Eqs4Xe/u+77hdZOUkluvuW8zhQwC8lr1dp9NcLiZ
         FmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW82709kWzVpHo81caJeh1uprfqBkEXILF5qDHu2JnD43ZmIaKAUYaKPz3t5lUATvwPFCof2AXIyJh8Y6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyF0aA7svAWTl0/xNJlC/HHb7fu0c923PkXlB5VdM+Rr5qgZC4
	HbuY/FSsGKs3vXRtBGLnuuT8w7D/L8Be5KL5sKmTXmdiTYhq+7G3oOLbqQnLUyO0L1gERERnsmC
	GmHcX6NRw9kkL2cyMiHEQxVeS/ax/eVKl9nBHJlU4QUrlH9yFYicFhLXEgrQjhls=
X-Received: by 2002:ad4:4ee8:0:b0:6cb:99ff:23d8 with SMTP id 6a1803df08f44-6d1856669bamr15545066d6.2.1729938489588;
        Sat, 26 Oct 2024 03:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXCLXCoV7YP8afBjH8WSHTqbclIpPPNASBb3TBzakQC+aQCnvB/bI1jAnQJapdRnkiOq80uA==
X-Received: by 2002:ad4:4ee8:0:b0:6cb:99ff:23d8 with SMTP id 6a1803df08f44-6d1856669bamr15544926d6.2.1729938489275;
        Sat, 26 Oct 2024 03:28:09 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631a24dsm1423236a12.74.2024.10.26.03.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:28:08 -0700 (PDT)
Message-ID: <19937b9a-b1b9-44d5-b1ca-8da5fc40c9fb@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:28:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-tianma:
 introduce touchscreen support
To: foss@joelselvaraj.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Selvaraj <jo@jsfamily.in>
References: <20241007-pocof1-touchscreen-support-v1-0-db31b21818c5@joelselvaraj.com>
 <20241007-pocof1-touchscreen-support-v1-2-db31b21818c5@joelselvaraj.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241007-pocof1-touchscreen-support-v1-2-db31b21818c5@joelselvaraj.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kotyJ24N4jLT0m3DmnyFwavmCapYqZqz
X-Proofpoint-GUID: kotyJ24N4jLT0m3DmnyFwavmCapYqZqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=605 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260087

On 8.10.2024 4:59 AM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <jo@jsfamily.in>
> 
> Enable the Novatek NT36672A touchscreen controller used in the Poco F1
> (Tianma) panel variant.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


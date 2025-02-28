Return-Path: <linux-kernel+bounces-538611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E4A49AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218131885852
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8726B961;
	Fri, 28 Feb 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WG9WXvGH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC81D555
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750382; cv=none; b=iARv8h/6ckGtGYQpPUWtc+jmtePxNVNI5O9uZICNA/EElIXilAcpI3mu2zPxukBoSCDpu90mpsogyN9oF6EvrpVlMLseLQK0U/qRmIzjChdnlQS6jQCFTNunIS1mnQajmWpvQaSLXnxj26PW1LJrd1OJos/WvP8q7A5mKXKpZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750382; c=relaxed/simple;
	bh=QgqPUh7e3P4mc0BkdQLn17sZPbkFFdNZs/qPJ0pdcVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B79X60wgUx5dmmsOzQTNaSo/ppa1XuC9sDAZEV0idwf2iRjfo12vrPpOV5arH0URj9swpCNN+FeZPDug7j6TGDgFcG4Coqq8Ea0yTfdnqcXIfZmNKv9mWUT/VH+qC5X2Vq1XokopW0bQCay4J6ShXCtkXJmA60efvS3f5+hO9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WG9WXvGH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXG1q031883
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r95R7tzUmkOZqqPt8d9Jdn6qMh6aJzeR3kWmNTHBidI=; b=WG9WXvGHGcttu2js
	DCuqRGAjOgoNRrEHXkchcTJaHmlv5baHp+U+jGwVVve2pYqKca5aR+7K0nYL7fW5
	b0r3XIcLImfHYoqR9uevUu61nzalX4fdXYLQoT+0IUgs6lCLEEanOGJdWNxcWHjK
	dM1sCwYKjdn+8oIQf8TgQEjxfUznmUwY6eL7LdkopGYUzAbTBv7CXJJDEVJhBhm5
	bungXysf8QqBiHN8ER9EdY3EbKF8fzc01ayBdrUxPPIVjqw4Wa3SG0ekkiqyE0Ms
	XFWwkhvqVlLpY3H7EzsrUZ96Qsmb6o798Rowot+EUOG377r/h2HGAWarXsimaoIM
	8zR2gA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prksmq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:46:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8a0dba34eso2173736d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750378; x=1741355178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r95R7tzUmkOZqqPt8d9Jdn6qMh6aJzeR3kWmNTHBidI=;
        b=T239+EabPYjvyLA7uwMX6N+WMZpNbcsVxhhUV0f85e6BKSKLAQIPaBWIEsTsOtnT6k
         F/snaoAdDFAX1MUSgl4qieWFcdpeMSZ7pFLCfnQKCaILGZQ+4+ubRziPQRaSkS6KCGpR
         UO2EMzb60Hd4K8v0M0h2Q7meWb13Mk7PhBbcxiyN6wxFRMEIduENfYE1Ipq8vH764bSL
         IEUG9snoyh9aQdSnRS8Hc6VHnRqYNXDYBlXrM+5iWv7t81SN6eVAORaj1HoU5Bo0gXAX
         tQ0k8iatmH5hbyHSmLRsKyOyvS1CZX3vRBgVVfGgF9j/aY58N/O8mjERL43YKdFbGKmd
         8Kkg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Hyq+kmIHuZquvyryWWPH/f1i0p3AeS3jtt2a9EnLHG/3XDiJXMswwJKVWdGLNi6t85mdWwth1N7yudE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5HLO+G6fyYnhxrwNKFwM88FDXVKrkVMkJAOALUV7j0kStVcBD
	/7g3HuQfnU+v5qzjznWc87ZY4k/yhDlQSMihHxTNWbfDdJn+LGhHBpY3Pd0+paqTyxfD8bdh7kr
	+cAfrEo1h4Xzcc9ZRQFiamzFGDPzFYpFCUrs8Hhz5PEK07WFdqr7ofMBlSUDWhuA=
X-Gm-Gg: ASbGnctOsuxXCjY42Gucspm4ptuyH3UvrL5Og3ALHqsaFprdXIkEpqmQZ+6B27WXZqu
	BJZq2sbE9y+BxBcIqpPCztxHZrnlIx1S3MUbxMW7gtjLqOgG2mKxsnQtSNeRwLnvKh0lVP2qi+M
	GE+ISY1aorJFcwvlt5deF7a5vCXOPtTc86NyDL+Ul4XcuqAOcv04QRR6I/+/Aml791AlG5Y59fR
	GAnew9OuFtuEyYIZsc13eTSOL4fCStNT+VeAM1iFFxXwmFTXdw1rFZv3MCN8ekRtobFrmz+yQDB
	VZsqdkdwrDtNmtGQpDU0d0Jri9TLN2qQLcxR79/BYo40+UEDdiBMbX90vvSnT6q83GWxgQ==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e8a0d6de81mr17037166d6.7.1740750378615;
        Fri, 28 Feb 2025 05:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWmbVtyz5v9qdeTk2Q60/snetUXxtadcfnzHCU2jryscortfPes5qhPNB3YWzaAGxONm8dXQ==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e8a0d6de81mr17037006d6.7.1740750378268;
        Fri, 28 Feb 2025 05:46:18 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a4e26sm2502065a12.66.2025.02.28.05.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 05:46:17 -0800 (PST)
Message-ID: <9208e80e-b7cd-4e7f-86f6-1de264c13e6b@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 14:46:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8937
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
 <20250228-dpu-fix-catalog-v1-1-b05d22fbc2b4@linaro.org>
 <50cf6659-ae08-45a7-869a-2300f4d037da@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <50cf6659-ae08-45a7-869a-2300f4d037da@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: je8NVcSmM4K14QXpfvjxG1mQrIhX_-5Z
X-Proofpoint-ORIG-GUID: je8NVcSmM4K14QXpfvjxG1mQrIhX_-5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=937 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280100

On 28.02.2025 2:43 PM, Konrad Dybcio wrote:
> On 28.02.2025 3:40 AM, Dmitry Baryshkov wrote:
>> The MSM8937 platform doesn't have DSC blocks nor does have it DSC
>> registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
>> from the PINGPONG's feature mask and, as it is the only remaining bit,
>> drop the .features assignment completely.
>>
>> Fixes: c079680bb0fa ("drm/msm/dpu: Add support for MSM8937")
>> Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
> 
> With the commit message fixed:

I like to copy-paste too.. this one needs no fixing

Konrad


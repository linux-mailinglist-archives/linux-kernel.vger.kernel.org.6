Return-Path: <linux-kernel+bounces-373990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08D9A604C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766B22818BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE2198837;
	Mon, 21 Oct 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qshzu1NG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEAD1E32C3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503530; cv=none; b=OZKUFell6k9Dk5y4KArGapKGF4fr+oUUS9phx5LQgxVG6hxiZrUckzjaNq62GRWNQ4AE3A9I+DsvykGMYN+kURHdh8qnFYTMXkgESFqGYIjuvoLYnnTHpb3BXsgfTTjYydQNPJ66PH3SH/XbDWbZ/nlBly4we3W0j0/zhKul7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503530; c=relaxed/simple;
	bh=NhBL1wZH7ZwZciKbpoNjPbtqWf7fDFxHOe8r+ilIxpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoDgQwLRcRpN2bVZpeZrE9bml+kQAMpOf/j8mYCyCsQhb/miMOF3uiivL1ZizUE6IxRw0rgYn1ZGEeTTxXUnaaZYsUpmF168+rczYCiTt5t4/mEbeSY3uuevKuX3kgsX3YZGPp1b/3C1LXTnUo/0X+ec6q+TN7ww+ru1WCTmTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qshzu1NG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8VwJd014493
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gn+gkmOeUyjRBUooDRR+2My5sXvmwkHI88BMxZAlKmE=; b=Qshzu1NGPFV8rsTh
	txIOPB3GFuckqrBScsLkjnrIuuT7jhuJiOz6yvjMOpWyZRN5rKHEvIet1nKtgOxZ
	xRjTgCApXxaGFy5Uspt38X1yhYRPKGdbw5DykooS4TvsXhfT5crN/yTF1rG8WthK
	o/PWB8BUzZUpcpjGci3nE1zaFet6EfRwlt64/kco889eZ/zeYDjKA6vcoaKwJHih
	PbX/R/39BknU39Mxqa1Wu09I1z48fwrNB7LCoTlsfEQ2ambgf+1dyAepy5wDpAgm
	vBTMHBogS3iqAZuJ35s4zfihjB5vgQMoXKc4cOqb9wNNTfkfpVBpyZIP2p2mRejF
	4cI7Dw==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd0937-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:38:46 +0000 (GMT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ab67710b5so43736839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503526; x=1730108326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gn+gkmOeUyjRBUooDRR+2My5sXvmwkHI88BMxZAlKmE=;
        b=ScpeDzMuelnvPoj9E44j8Wt36NgWrQOlFMFAEcAo16UVTJt769kMcdZnXfLwI6h2HN
         NjKZfLIxoFZ3SOqi/GdEidKI2UfOtjGrafsjtLlqgFdyoeQuQNhsNsFRTBPqqJHLKDxD
         LWoYgVIf0fjm4PRLsiOqRZGZzPnvDoGH4OZX7sT2aRyeKGdlieKGcqJSG48L/ytUaUPT
         a/BBw5BGXr7xZPw88ELgrv4VxlxMcNQ4bD6zKFkFmuQXy2AFetWqVFJP1LcbYsOPJY/U
         xw0XSaJpafQvag0juxj60QEZmrxNo5fSj9Y55AyC5mSioVIJGU/c5qYorHBXL8/4qbqg
         XSmg==
X-Forwarded-Encrypted: i=1; AJvYcCU1k7Yv2HHApBEW00pR9NdhMuqGuu2GoSgpLzRdDujH/s7XfLFei/wcU+b2ne0O4C55/90H1G22h7YkWV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4caZQETjwAga+6VC5iYs7trM9j+MQkZi0wjQpdyI+YCpfleBF
	tvD2st3IDYWpJ4Hu/qypzvP5y8B4vWRuK54VCfJ7k1E8KMxLkPR/4bpTT2weLwnHEkqtn+K9eM2
	v1DS875pL8ICWagFa1eioL+3CWorxT6SAr+w6ROIeY4gHxHQOuAcDrWpbqWkk3xk=
X-Received: by 2002:a05:6e02:b2f:b0:3a2:6cd7:3255 with SMTP id e9e14a558f8ab-3a3f40b41afmr29448915ab.6.1729503526132;
        Mon, 21 Oct 2024 02:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/wHHBGM3zQyx0/OSXW35rXmYHrOpG+GrEQovUlYPyc88a/4376jQdZSvI4nY76nZm9i7w0w==
X-Received: by 2002:a05:6e02:b2f:b0:3a2:6cd7:3255 with SMTP id e9e14a558f8ab-3a3f40b41afmr29448885ab.6.1729503525721;
        Mon, 21 Oct 2024 02:38:45 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6225sm185228266b.11.2024.10.21.02.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 02:38:44 -0700 (PDT)
Message-ID: <1543ae2a-76ff-4b36-adae-37076e48b7f8@oss.qualcomm.com>
Date: Mon, 21 Oct 2024 11:38:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] drm/msm/adreno: Add support for ACD
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-1-1e5e91aa95b6@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241012-gpu-acd-v1-1-1e5e91aa95b6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BYILm7P2guZnCx6-_wagUdzXlfDlwI6N
X-Proofpoint-GUID: BYILm7P2guZnCx6-_wagUdzXlfDlwI6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=920
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210069

On 11.10.2024 10:29 PM, Akhil P Oommen wrote:
> ACD a.k.a Adaptive Clock Distribution is a feature which helps to reduce
> the power consumption. In some chipsets, it is also a requirement to
> support higher GPU frequencies. This patch adds support for GPU ACD by
> sending necessary data to GMU and AOSS. The feature support for the
> chipset is detected based on devicetree data.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

[...]

> +
> +	/* Initialize qmp node to talk to AOSS */
> +	gmu->qmp = qmp_get(gmu->dev);
> +	if (IS_ERR(gmu->qmp)) {
> +		cmd->enable_by_level = 0;
> +		return dev_err_probe(gmu->dev, PTR_ERR(gmu->qmp), "Failed to initialize qmp\n");
> +	}

I'm still in favor of keeping qmp_get where it currently is, so that
probe can fail/defer faster

Konrad


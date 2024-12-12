Return-Path: <linux-kernel+bounces-443699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A299EFAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C2A28F722
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5AD22540E;
	Thu, 12 Dec 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0FIywXR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74918785D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027594; cv=none; b=TyhQHgvi9nLI6m+6IgK1xibPTK/HvkoBLGQr297QcCju84D6lm9hT1rmxTGwUnYDMtHZUbigObOgpE7BWVNqM7NbTpqn3gNOewoDzcMCGBPZlEiW2j9c1zUk0jVdzy4V5hVZnzvzZrlztfeynpR/Xy6Pw32GlS/jbu/paC7JOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027594; c=relaxed/simple;
	bh=BC/qpq76CEpIIrHWx2B9eZ+G4AtkyiRIqFqRdOh/W5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZG4d93AxLJ0aWnjpkaI9G5zkp86M7nZXUi9tbKTXpAXH21IKVsDFVPxJlkSQOAcLrLj8rsHXm0Y1rJ2mSyDb+MEV0RVK3IMSA7zCZMecomBR4IbLtVin7ByVlStbOiYGttIm+E5AIL6mDoCMOoO9Mcd4O14f1Rjkq/zaC6MbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0FIywXR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCFka0L019198
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GKtNCOtaL89pHw3G7/FzhB1Ks2fBiwK4pFoXlWgfkeI=; b=o0FIywXR9rpDaZOk
	gN/uFkjNFvMH/YtED0Junfo+qOBJaiHOnU+zjfx0r9K/Nm/AHg9hqGSlhE/07wZw
	b3UiDKFahAYRr4haz68xf9H7oKTD6fWrOZWimF4vLcvgmfDfunIMGKqj1OayLAB8
	AOSKsh1Dl0drIz8tWc2BIbri3DRleQIU5aJqHA5hQ3EeeYHuZUORjvzmKkaaJQV3
	xdIovlDrIpmYz/69pMs9GvuQ/KfUgomznnCEZdbJBQ/wMXaOr0DqV1FO+/R4Oa19
	EX6y/Uek4/YO4L6CDhi96GB1dno6TfP9gESfyp3k+98f8hSfeuN/d9IJzSbrziso
	w3uEZQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdyufbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:19:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467a39f07f8so108541cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027591; x=1734632391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKtNCOtaL89pHw3G7/FzhB1Ks2fBiwK4pFoXlWgfkeI=;
        b=IgawPOIMzgsgIyozg8boTAgToFiP88YevV/9VjWs9VmH7+SG4UHE6buYPFU3mlXGgb
         yttGxZHiliJRmMnfNZy/mVjcUtV6n+cPzGjbXPfxQ53IQC6fr13zWVuB9Q04u573FRV2
         FiQ3iWd95WBiuXrGykPBcQ6Jbrp3br0y/+6MC2692r1D/iuamCmrg+X2G49EpF34S1Hn
         0wBAlQr13Nt2FVSvN3A7mH6mhnQwIllsysmJxsAtay8HPZMKbKlt4lNZufDNOZzDQKIp
         LfUSc7VRtqN/amOXx4BSQXJ1iVEe0Y9PsGMtEBgQGckwWy488AUdsQMAYLe1Jy1hFOZD
         NvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVk2Q/68HwPyvzR5O93PSnRSqXjt+8CwC5I4JW6ts4mVOhW7bLuV0ml37GoAh5kQ4gDxq6paiGI3t71ZVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYKl+iQGXgq9VKcOw33b9JLLDnOjRudr0mOM++Kko39DxlE0l
	OYXgS+O2Us5Mwe3SJThMe+zilbKh9PwvnuLXPrhcHC7jTmHp0wmH4lD20oQhfq+akoQWdnJyk6T
	3c3MNwNTyMfiBRx+KaReVNxHGv9Q18qespzZeSISBqAHxjKo6tAldbCpCzsqgS6w=
X-Gm-Gg: ASbGncuPaqX/fJO5QBJWI8wfbddrWWFypvgD6ajOS1YSO21nllLR9KtDKmzjR9xohLE
	d1n2eLbmqAvz5ZyrfkeH/TA/5IMz0nenHkuyEjGo8OxnOf4w5Y0X4Yel5nSd0Wiv4KWcDqhCkjK
	JlFmxcmqvFdCQX1w91wWHpjRRRYVZ10bEjcggIPFAr1Jj2lkyQ6sru0UazBf3TYEuOmltscm39e
	k2JeQlWyH4vpsCI0kJs+sHibC6Xt/KIZ7fztkU8yUzpsQNXmX8t6uLwmq2wwfB9WFIoCQ+UlmT0
	RBBxNQ6iuPoZx2G+ve9AAotU06BxnWrtLaAdhA==
X-Received: by 2002:a05:622a:1a87:b0:461:4467:14bb with SMTP id d75a77b69052e-467a14cf99fmr7175591cf.2.1734027591058;
        Thu, 12 Dec 2024 10:19:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC6KrQasDLA2/zeHAKapqCU8kql+Ub/Gc2FmOF51LQmMz74nDoscHAYcpWpck4WHEyFhI9xg==
X-Received: by 2002:a05:622a:1a87:b0:461:4467:14bb with SMTP id d75a77b69052e-467a14cf99fmr7175361cf.2.1734027590585;
        Thu, 12 Dec 2024 10:19:50 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67f26cff7sm672205966b.57.2024.12.12.10.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:19:50 -0800 (PST)
Message-ID: <8c60e0dc-531a-47d6-9c40-ea157a24da1b@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:19:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] dt-bindings: arm: Add Coresight TMC Control Unit
 hardware
To: Jie Gan <quic_jiegan@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20241210031545.3468561-1-quic_jiegan@quicinc.com>
 <20241210031545.3468561-4-quic_jiegan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241210031545.3468561-4-quic_jiegan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p8yJF8pRsXZDXgZGyMx6a_2oKbt8mxJF
X-Proofpoint-GUID: p8yJF8pRsXZDXgZGyMx6a_2oKbt8mxJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120132

On 10.12.2024 4:15 AM, Jie Gan wrote:
> Add binding file to specify how to define a Coresight TMC
> Control Unit device in device tree.
> 
> It is responsible for controlling the data filter function
> based on the source device's Trace ID for TMC ETR device.
> The trace data with that Trace id can get into ETR's buffer
> while other trace data gets ignored.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
> ---

[...]

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sa8775p-ctcu

I don't think anyone asked that question.. Is the TMCCU something unique
to Qualcomm platforms?

Konrad


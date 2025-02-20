Return-Path: <linux-kernel+bounces-523882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ABAA3DC75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282F817614F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442E1FCF7C;
	Thu, 20 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n5EZLtut"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF21FBEB4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061051; cv=none; b=Nci82rNObytRF3bpoxdCi7KctZEiNhEfj3HCUU7TsspzVGkdsHD4i1Ym/GbQPnrD1iUkjz28mMnag3z8ZQlQReu6ZFcVI3joCuc15N+7p5vk+4knHPcns6VHNezy2esVB7D7ZNEdskgxPCXaHqhQ8cXJ5xP9dGF9RFF4v/1hZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061051; c=relaxed/simple;
	bh=3EGm9P8kyzCVbkWoFmdV27iox2OfLl7TljwpZhahyf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAJxLzzEFouAcqHyJAkkNirBpXiji/jiuUWvS07zNcZOVfE611S0rrj18KDjfEklwGIL/YL6DZk90zowV2EfvMetYr6q8O/tGW42t70VYIGYr+Hg08n9gcFp5rB/cNM3xj+E9f2HaZLToY5XzzUjxlgil0HGr1NpT829ylHBpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n5EZLtut; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7dQrJ020394
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3EGm9P8kyzCVbkWoFmdV27iox2OfLl7TljwpZhahyf0=; b=n5EZLtutRjhz9TVk
	nVNfdBj3vHd3mh5sb1yu0+ZR14FvY1Jv+vmEM2yBqNV72xw6mcKjdiHh/Zs7OTSu
	O9qBsrxm2xWhyHHBIqnY9aasOAmuaYpPG9lSCB+kxf7kRTOkGL9ECqf6E+RkdFhY
	PxKpKckghEH5j1fPRTeuQJx1Ye0XwV+NJSZix/1+eLaEZiQzzb/NuzNS8xvH+BrZ
	Gt6fpuUE9NEfPkgKO899F7iiDm1oao4i0k+B/K5ZPf6D1U9yAOYdF0Nvv1oRtr2K
	a/Ql4oEFJVfLk66afoAQPNCqR5ojNX6CVH6286K5Zq7La0zSFgOyMiehtHtfyZBw
	kGP4oA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x06t12xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:17:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e662a02f30so3127796d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061048; x=1740665848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EGm9P8kyzCVbkWoFmdV27iox2OfLl7TljwpZhahyf0=;
        b=DFHnUx227PufOe6jwcLsV9Bbyyr02uEXzwEqj9+JsyRFvsX5jLsszn/JjEcTsu39Qy
         YMo3l4zxDlB1/6FOpPHQrD0tibcE0vBkyGsUdxDwtQj+7YqmflPqxGiS14BElttuRzks
         iDYqIfTXET/vslx8x1d47hmylOxBKdhA31hA7XkMM+g+9gPfmfOH8PVuvs17KB5dn7eU
         V5Ikv6gastIvEP0tq5knPGU3CtaDrswXWRxHCngIZ99AhqKLSrxQ9F0hbO0on7D1LzKh
         nujlsQs1ckn03E3m7LqJbw1uOzpYHCbyuk3CLxGw4ILh3JFbXk7UK4lyoHtDgJS+e+X6
         73RA==
X-Forwarded-Encrypted: i=1; AJvYcCU7GbnhgQiOIwHd9eXHN+677AFpQf6TBwBO0v7DHRsjyQB1P5j20jqmj215PuWfSANYoClc149KFs4CnjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwfd90TjPNEDUsSGDPkK+7aO+qujNkU/aPynDpmYrUhlmDwFZ
	KPqi2v3VnciG4e/Xt4em5AoT6noToLfq/hRovhWb3fYxmWVXwQEK6kGPEP7LfoinhJUPh7+1noK
	HvBT9ZcBoYpRp+4uk46gyj99f0/2yTvlm5VNiAkZmq0klFMRShOeg4+FXbt8qjLM=
X-Gm-Gg: ASbGncsfcEeTJcC9wcJa1dWNQEPjMH8DR/YKF5Q5kEtIDuwwK6aQttpnVgI80iPrkF/
	nPnunpVqbB70kZlLzZ1VAdDlCPnFceAzhY5NgtsXeYbiY51R1/GD9udjFSv5czm7vqWcg6NizmH
	hNiE6FLLGoFkOXeLu4j7xyOINCIH3nsO1PX/6w941YPV/nyUqZghCDTd36SXkansqjkaFZ2e9v/
	CfaAUkX4rAG/2zC96QMcE5sEaojtvtyiuqL+TWcjbFJdXm6x6+7C/zkTtt6I1qh6s++4Zae3Nso
	k5yERa52w1PaV7msQWLAtTEA6xcwZWZxpNu4h5VSmYOOZHSjepyVOxwZtSM=
X-Received: by 2002:ad4:5f0a:0:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6e66cd087c8mr103321266d6.7.1740061047779;
        Thu, 20 Feb 2025 06:17:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDkW2kyG3s5oW0jAOFMLLRJCpIAozDV8aRQ9BA7y2aWTC7YO6KQmRn9uS9vaOsEf7hft1g6g==
X-Received: by 2002:ad4:5f0a:0:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6e66cd087c8mr103321046d6.7.1740061047341;
        Thu, 20 Feb 2025 06:17:27 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231fd5sm1461709866b.26.2025.02.20.06.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:17:26 -0800 (PST)
Message-ID: <517f2021-d863-4976-9df3-ae5f64102b8e@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 15:17:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/msm/mdp4: use parent_data for LVDS PLL
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
 <20250220-fd-mdp4-lvds-v2-4-15afe5578a31@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-fd-mdp4-lvds-v2-4-15afe5578a31@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0b6oExJOR824YmwpgofRPZdOv5FdW2_v
X-Proofpoint-GUID: 0b6oExJOR824YmwpgofRPZdOv5FdW2_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=625 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200103

On 20.02.2025 12:14 PM, Dmitry Baryshkov wrote:
> Instead of using .parent_names, use .parent_data, which binds parent
> clocks by using relative names specified in DT rather than using global
> system clock names.

You're not actually dropping that behavior, since you still populate
.name of clock_data.

Konrad


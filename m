Return-Path: <linux-kernel+bounces-538605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D03A49AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC3D3BB643
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D526D5C5;
	Fri, 28 Feb 2025 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jc8yrn4g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA126BDBA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750203; cv=none; b=j41oh+MXgYzLLSCEc5lmib+EhcqBJrKC0s0XGn9RvCIAhIevMLLuOKlcciSt7g1Qak94NkLhHoVN3FOYnVtSqD0yaWxNMAMa8pcp2HZLXnSxjp4OVVNWd4csw3Kxi/38dO+mQjQL4OEIDBUGz2ffvDUIM+2l6EmUv17mPecG7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750203; c=relaxed/simple;
	bh=kdCzsJnxrvZDUpLBfmlo2ylZJm+1Scc5/iJi6oPwejE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hidIkZwI8wSa66uX34qTggFGP3/tiSZbliLtIxHFRtwlLSsBN8JpVPQIejWKbDVq5P0LZ7BokR2/jbhKTWqpMArpbWCXg9WRA2GBZBNc+S5hq6DZmx0pDJseYRrzhp3AE7Yu+lZxx0NCvF2zHEV44V/5WzbZ1BL6czjhoTcD61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jc8yrn4g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXKWb011698
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X8ScGz40JRccpFkf1d+tHM1VpGzuLrp85WFCzzDHaHs=; b=Jc8yrn4g7Mrf1wB6
	ErFhcikirR7ykGAIThDbwgB8j9wqXUUNSukiiucnpQsFWtEguATofNQ490ZWNvak
	w9GpIMhD+dMP2jVXGitR5Ej8uPcOPjZ5kUkcGo46LO0d0Ht5oHSsIEB/3AJDnPER
	CijrCykE0kbtRWWCSysuMMFBgUJGhmT0EvbMXeOlACbh7ElRSiqp5m2uSnKqHVZ6
	eg33pswtF7QyOUVEJUsfVrchYSFT1ve8K8USh+2SuQKWLreD5GG3VpW5IdFWjRn7
	uxzO5wTvPRhZ+a4JgvCny9JcJzSD7JBHp/g+NdRfs2WPA+1SYfW/291OUnFhhmHb
	K6HvbQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4522skykgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:43:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e1b2251f36so3862196d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750200; x=1741355000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8ScGz40JRccpFkf1d+tHM1VpGzuLrp85WFCzzDHaHs=;
        b=hamcU87MqRWQi0hv9vdZcooT5MsGVZ8FoobkBD2wnJHf/bjquLkcIBrNWN/7iKSoQv
         SwqPSaZmdNQ4HpJbQKPYvbXe+aUFuBOe43cVrtMQEGYD87j7BJbtZMga4byq+/ZrSU6B
         L9Jy8JgFMP4FIpVVaxGVKV+Gsj0drAQkKlDljicwYdoAgz8qqOsMStsugGQ06zurmF7D
         3maSd/6ub9fQAQB+ugp9iDSzsiAo2Oi5l4n4x+Nx0BxCJ/12t3L4akadtxgQuXes/8sA
         Yq5S9YakMqu7VWATRz8RgUciT9PO1TaWZEZhenmdU6yAJ0tckzBkjc7eDoQMS413hAp5
         N0kA==
X-Forwarded-Encrypted: i=1; AJvYcCV+9ewDC4C81wgIL7irdatOBiiOJYUi7TpA0YE2UQDsxKmjHvTMVBh096ySDxMeTGylbIGOYGL8sfCziHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycmi974bs9mPKG8kMT5VMr9O6S6970U7bfojCbTU8ImdWOZ7MP
	uJMO7w5dyyxCO0hRVi54lWEoxQ8KLGA73DljpmRmlJE3Ifna8knDWV4GV1hHTHKCQoVMX70lMV1
	8B1eUAYHaW6KlB7RSXFlUlExFf8z4qV3jHxHPHdSRP1acQcbPo8G7sUIiu0VQtvQ=
X-Gm-Gg: ASbGncvfWIud2sPryxFVq4KNwhQ7nhp1XfFGT1gsO4ocWDEjXimK7maRQ8pZBGGun7G
	lMLWehKQq8P9Us/VXEPKlor+SIGH4Xxwgdx0p0MpxWOjhD7FsOs0CWkkItUaE1uD1X0z5zAVqEa
	LThW1k4MILnhVQRtyX6mDXnJGoReclJWAH5DqUwc81VVCtx3O5yMZ6N3z2lEkzhRt7FIQU20nGd
	OTruGVYZCnQAbfiCI5En+Obqhnd7EZISz8UklMCNc+8jXu5AfdSfZ7GEC47h6TOwj1NUGjTF+nF
	N3UQlCKt7UFIzecTL5nDQHW/pqXeU1KsVPeTgBK/AlmU554SmGMYsGiI8aXQ6HMlBOxpNA==
X-Received: by 2002:ad4:5f87:0:b0:6e4:29f8:1e9e with SMTP id 6a1803df08f44-6e8a0acb028mr19315596d6.0.1740750200226;
        Fri, 28 Feb 2025 05:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2BhTFPrGcsBUD3d+js2LSjbjIbSoqrswvT4KyTm/vYvLllJTBt7l/wIo7yhlMbwFAi0+lCQ==
X-Received: by 2002:ad4:5f87:0:b0:6e4:29f8:1e9e with SMTP id 6a1803df08f44-6e8a0acb028mr19315376d6.0.1740750199768;
        Fri, 28 Feb 2025 05:43:19 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0bab1bsm289935166b.28.2025.02.28.05.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 05:43:19 -0800 (PST)
Message-ID: <98a9bedb-cdf9-4865-a089-85a2f411bbd9@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 14:43:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8917
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
 <20250228-dpu-fix-catalog-v1-2-b05d22fbc2b4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250228-dpu-fix-catalog-v1-2-b05d22fbc2b4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AsRBVEniffxJQWiLhU-BmSGDAOXjnhTf
X-Proofpoint-ORIG-GUID: AsRBVEniffxJQWiLhU-BmSGDAOXjnhTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=977
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502280100

On 28.02.2025 3:40 AM, Dmitry Baryshkov wrote:
> The MSM8937 platform doesn't have DSC blocks nor does have it DSC
> registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
> from the PINGPONG's feature mask and, as it is the only remaining bit,
> drop the .features assignment completely.
> 
> Fixes: 62af6e1cb596 ("drm/msm/dpu: Add support for MSM8917")
> Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

With the commit message fixed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


Return-Path: <linux-kernel+bounces-538606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A308A49AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808F03BA3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202326BDBA;
	Fri, 28 Feb 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D74YUx0M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCD26D5DA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750211; cv=none; b=aWj/94jejbnPFAL+1bVYNIH5FtwTTYOGwNZeQBjhafstdep2iV1Clxl1ctx+Yk9G/j/G/TNX5FYFT6PmoVX/3vyig1r9s72qgrvBUnNiSFWfiiOWLmT2lJpIH7yClve34cYfKeTrue3UdbMEW0HU3jcgyO4Yn1xQmtDCCWrySbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750211; c=relaxed/simple;
	bh=6Ao2ETjYwtM7uWplN/nt4iHZuRKbE4CskVi8oZfAN3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDLcqt91eJXTgYU1QVJ9yG/5NhpdejhiNTPSiDzcM8DuyJviKysy2O1NO+rec6++o6AhdIQtoEFMBzJGaNAnNpGiDcOEbGCS9UEZ878EDxpyWYM6jZqgFz7MaOhfzsygeq/3zjeKgsNJTwu2sa+z91SaFd7j7Hq5KH3I+6EI06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D74YUx0M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXHpA001960
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uK7XPFL9iClFWAeim23sLhZiHmmfyDn3gazcoBk2iEs=; b=D74YUx0MGKkLqrsn
	plW6U5fatD9Sbz8W3JEK8uNcX54S7V0YQiMTX8G5pMmVi4cCd16z0b609MWeZ00P
	3nezOn4EIrtoBkaLJD+2lBYeMYUqLneevM8qHRGU0sz6hWrmuiFKZL6YFRWtC5T8
	YrLI6phohOguy3bQjB6jKTafAteWHSzJagG477EWpD/vHNRncNS1ic50tTLlLzYA
	2mkOPSxvXHT1nryaD/b7qjfKeCxwCrlXVyIvHvr91xVjNXJMfWLgBDMseP9OkT1N
	OKjvpxlMMKlTSUb5XYqBeB7wwv4xfudSRUKvETzBmSdTK5cmNMnomkbot0YzKQ8f
	bBwxYA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452ynwte2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:43:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e4546f8c47so5441616d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750208; x=1741355008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uK7XPFL9iClFWAeim23sLhZiHmmfyDn3gazcoBk2iEs=;
        b=RgUbNrmvzEAjaM1i4RgUG69wLDmGSmGaLe1K5EO+NMIGsy4NUsykzpsc21QEafZxDJ
         HXoHyyfbzfK+Rv781An/pesDvRAtCXRqbMp75xGjK/OW6QVBtlrbHCd6JKeCUbpwZiUz
         I6mnGCWbg80tIWBqtyIr+XmNrK7pkIz8lfOVVxoXYrNM67tYSGYQFTZD7A91Bvxn0chC
         IT/zTCOrM09axYlANQ/gcABZrIppL8jLnVlygzQCHnH15B7Hy+Zay12dOPyAQeaN3xEx
         pg1oFywC32u4LGkjfI8AAFWt0mphLgjkgRFuvjdwAFcPHJ4BRkb8uMC0G/SLyWPreLzN
         oC3g==
X-Forwarded-Encrypted: i=1; AJvYcCXgjA0rjhVzwtGpHiPnqSrxCWRoxdufq2JMpBp8/NQjQ0Ljk2Ey2OOMcVBG2W9Ri0skyPWSzZE3DePGB2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJG3DkysJAy07BMfOD2wTULFC8A9VrEvODGpksjr2kCEQabrR
	IsJURshfimx/g64DHnd9jjVAgCeOtkbt/b7/m6GCxMJtWaxMx6CudY5sHi7AjE1mjdouD2VM9gL
	S/ZKQSQ3OZphZEdd3YY3aEGeR3+5X/+D6gaI3ixteuooJ5XUsVeIWio4V8z5SC+0=
X-Gm-Gg: ASbGnct8MF4n1OFlWmzJP+wUGWauSnSG8P8AZNJpzczGW3XqEtd+PjT3xZE+no/m7X7
	VP4i1bPBIs6a2FF9fvK8i4KwXTgnXukq8hXP0AidDabNgSICXrB73giuqTHO6B7iXZbacNMVtK3
	cILJL0EFQvxQ6cjCGdY8tVQ/SotSIM3FkUGzik58elh9yrNceMRi6pgl6QqE5WusIVPu5hzAyML
	pHOF6aj6GActrlPo4D1EfZO/YFEKPZ24iabNx16a5kVJZZqE6HwcXl1zL/39HKlE+BOEuiCBB37
	zY43vJRBSQpMypvtUN0FXtKEifAAdQcQeT+9NiRWy9HKAfZ2QRumyaimrHoXlqWwPjuFzg==
X-Received: by 2002:ad4:4eeb:0:b0:6e8:9c91:227a with SMTP id 6a1803df08f44-6e8a0acfacdmr20127846d6.0.1740750208452;
        Fri, 28 Feb 2025 05:43:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6LsgtGwg0dHHSjda+X6QBa3Lh1LM3XCxwbSPqdc++bbG/PxqnrKamtHXvnvNs9sSIfeIs0Q==
X-Received: by 2002:ad4:4eeb:0:b0:6e8:9c91:227a with SMTP id 6a1803df08f44-6e8a0acfacdmr20127616d6.0.1740750208096;
        Fri, 28 Feb 2025 05:43:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd6ccsm294572366b.57.2025.02.28.05.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 05:43:27 -0800 (PST)
Message-ID: <aca6056f-cb53-4879-81b8-3d9f0913c571@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 14:43:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8953
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
 <20250228-dpu-fix-catalog-v1-3-b05d22fbc2b4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250228-dpu-fix-catalog-v1-3-b05d22fbc2b4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2xNPMczVLIgTgHiawy8P_1C5aF-QKcFR
X-Proofpoint-GUID: 2xNPMczVLIgTgHiawy8P_1C5aF-QKcFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=977 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280100

On 28.02.2025 3:40 AM, Dmitry Baryshkov wrote:
> The MSM8937 platform doesn't have DSC blocks nor does have it DSC
> registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
> from the PINGPONG's feature mask and, as it is the only remaining bit,
> drop the .features assignment completely.
> 
> Fixes: 7a6109ce1c2c ("drm/msm/dpu: Add support for MSM8953")
> Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

With the commit message fixed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


Return-Path: <linux-kernel+bounces-418219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5439D5EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38EE1F237B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AA1DE3AD;
	Fri, 22 Nov 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceTL7KBv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B417BB1E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278111; cv=none; b=TPDYFj4j20OehtvYKlOPtOS/+SKHUdx4JkajcNJnRiSFTLcsDNs0ztwPMpWBsdi1/I09I863xLlxw4Xf9bmwhpQMwPauQV6YszW4tYzsjJtlrr0IZ2SvhkhuPyNhRVTFBhIL1sENiMCi/LHxQZSId7G9c1bn0bzMFG9g4x4AsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278111; c=relaxed/simple;
	bh=4NdMI7i4HthevHg5xPrOBrT7ml56nJWGuXa+q7fy4/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg/RUz3AdBx8Za+4Ntfkw3yoE6yXb7oUjjzMDMQ9ZmVMANGNI43ZWpGZwLIz2QAOQFz8kVignYRRL40Jd+EsLuDzCwcprvGYc75fFjrTmhNWcsKKkDP/B1l6deuBzPh7N6ZrJa5hmXUS2yRuSAnMlTdrGjBSSaDGQ+zXWumR/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ceTL7KBv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM7tgh4002265
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2zyqdqOWon+Bb6KDq9EFahJ8KwOZlSLq3h9cfnJbehE=; b=ceTL7KBvdCZ22zVi
	udzdRY3CYZAS9dHzjhEXUYpMQFNAUEyJJWx0j9AWTrlU1Sv50SUvlGWeV1wBj3ZV
	xGDxL/L6fh9buUgSMMSoZGS2b5L4akX3K/u3qqbXWwWJuVwvF9Zs7E9S8GNSp9+a
	G/idSgVQg/kUfpi8Syq65G0aCwvt/YCBlgQshS8wLWWw3wshLoznkEOghhIv2/q3
	AV1vQs78BgOValB+FPpJW+G4Kw2OUqBrW4b6lBmf12UfSBYMgJoCfM4qmpdcHDkx
	ibuMyzc6hyysA70lfHAv2OaPegJF7bTAYNPFj40x7aiCJwHHVIjtgHDhogLw3nne
	Y1zz4A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432p0d8psf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:21:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d41719160cso4680846d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732278108; x=1732882908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zyqdqOWon+Bb6KDq9EFahJ8KwOZlSLq3h9cfnJbehE=;
        b=aC8P2bT8XlDvCNfwYbSlZVH/W6M6dobKg07iaMpsT32iSnCgX2paYHr/q0zeM/KloI
         DuSI8ZRgcWFfCodDZ8YNdUlaK2EXDlV557bh8XQCkmJlJ3xffS0uYwAOGLnzkV4upvLP
         gc3HViDOmzcEJpwAqntsP6NOVhpO+FfDd1pdBtJ/sMP7HgqTJ/m0ChUdrD6IwZnp/fdU
         V4QCd0iNpYDqp5RhtdXU6PRFK+mXWIm+eXLqq0E4XOUJBvS/b4N5Hy15xZAt7NAfuV3k
         VmUnSZOgPIxLEmFjJFsxmUHwpUWksteft5WE2BbQV4U7vuGPTTOIXv54F23kVD5ojmp0
         uJlg==
X-Forwarded-Encrypted: i=1; AJvYcCXFIejOhyXZzkTeomc16Ch37k+6afT7stnBLtnTlpgeEgSJWxWIGPYPmTzzQ+/fHiFHN2q8bSmX3tAI9MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8T8BOOzPkEqYzkDsnHUI20+4+nYiBWJGLvNfbsfcha5s6ZlmZ
	bYLk/IyVMQeis+lqYdXFWLQmomPH4wYv8hFIURXhLIFFMv8oNweGtEtgd2xoQDQaId8am1y5BTv
	na3MbE7l4YMkYA9TiCw00kc+7HfoOxulQx67mPoTUXVUGh+0+cwrvraw/KMFnzDA=
X-Gm-Gg: ASbGnctaIzC190khCYqmke50e5Lxmr7cp0GXQD3iMLRoxIYviu8o7TWOoV5nKKcwNfs
	dA5kbSzI77kcXD3Z3y/tlxU6FlElGa01A2q13iQrF1EZGJz0NfdAN8zIqZsL31MsGQH4qQ075zi
	vAD06/RpO/K+ujXQAVMj5I/523Fle984z1BwHquUaEdS0d05InZBcPsYc5LpchF5SkfhunrW/WI
	pm91fxmpH94/ugxKGSE6O7tQ7sRAPETbq7mFtM92kRO+yuluZsFFuvBAAHY+4k3VgwzJA1b+KJy
	Kt7Z0qzj2s783cf77bv/F7Xd7nwq5M4=
X-Received: by 2002:a05:620a:1a16:b0:7a9:c0f2:75fc with SMTP id af79cd13be357-7b51457fd82mr154413285a.12.1732278107906;
        Fri, 22 Nov 2024 04:21:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHmLTbwm8pNChveHbGVRdyKfjc2M6rbis5hRH/aHBrK0D9jZQQS3R1hjWKmaZIuM4R3iO+zw==
X-Received: by 2002:a05:620a:1a16:b0:7a9:c0f2:75fc with SMTP id af79cd13be357-7b51457fd82mr154411085a.12.1732278107496;
        Fri, 22 Nov 2024 04:21:47 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57c19esm92298166b.154.2024.11.22.04.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:21:46 -0800 (PST)
Message-ID: <54601d79-4156-41f4-b1b7-250c5c970641@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:21:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: UAPI error reporting
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20241121164858.457921-1-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241121164858.457921-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 34RaFK7-ykgIm2iAWxqmfln5PiZW61tC
X-Proofpoint-GUID: 34RaFK7-ykgIm2iAWxqmfln5PiZW61tC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220105

On 21.11.2024 5:48 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Debugging incorrect UAPI usage tends to be a bit painful, so add a
> helper macro to make it easier to add debug logging which can be enabled
> at runtime via drm.debug.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

[...]

> +/* Helper for returning a UABI error with optional logging which can make
> + * it easier for userspace to understand what it is doing wrong.
> + */
> +#define UERR(err, drm, fmt, ...) \
> +	({ DRM_DEV_DEBUG_DRIVER((drm)->dev, fmt, ##__VA_ARGS__); -(err); })
> +
>  #define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
>  #define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)

I'm generally not a fan of adding driver-specific debug prints..

Maybe that's something that could be pushed to the drm-common layer
or even deeper down the stack?

Konrad


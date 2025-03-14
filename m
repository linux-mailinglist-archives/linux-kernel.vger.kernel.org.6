Return-Path: <linux-kernel+bounces-560741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39AFA608F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951DE3BF967
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0B15FA7B;
	Fri, 14 Mar 2025 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXyRTU/K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4241519B0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932691; cv=none; b=MXAgQE/sRt+5AK74VP+BEFAPsdo+6+cDXpk1iRPvn8AzMVzwdZ41MfHXuAD4xMpEW+7QcdkcKQZKJ6JdUYT8Q1aXSgpXV0LYCkK+LRro8CCGdh9C7fF2EV5FuJcPLFEQ5MF86xD/FLq4qo55Q0CVFdSE2AXnokLFYy7Pl6tG0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932691; c=relaxed/simple;
	bh=lrGYN7jbovnBRsiy0qwZkDhfHsm6h9AUq8L5qgxMF80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK26hsBleoD/774PuNtHwAuizGtVoxmuzw8HKyzY3kHdMHHkm7/ZMo9kFuhZ52urSQZWtkiox5ekfFdll/3SDV1CEltM0WXLzsA7AdcOmvnw2mO07SMooq4mcHld6rc/Rfo3lxnEGJ1lg9zDqPlFKfvbOOoJ67W/+vtTjrxTuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXyRTU/K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DHGtBk019128
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IScPRMJWlAypVVGTG3eAzrrq
	ZqNhSbnrEPn3z5FtHkc=; b=iXyRTU/KjwoMm7sAi2n6/0MoFdyJBjWemiSQIiuz
	9+4o1A0h52Vtt1uwzkVm62tTPwx1p+E6Ix1ZZdhdKzgsIf8jjUlOrUus7eqjFtHA
	LMKpgYLYM3O61kvZTgWqJNUnACPaAqn2dgqp9Hq17OkXQ7XGH0Z4qj8nhZIJ7g5i
	HU/rIBrLqPtn+w44KjNhCPsHp4TlRKHm4LiY/EXUwU25ZjU5Ti9IsUdbgdsOpGNC
	+6KVypEYLvaIH3Cf+Aj68WzdW9r3GIM3K5XPoRiPtkE8n8kEpb+ZfmzHTcCdxDgw
	Jf7TaekIC7TH0cNdEGa3clDdH3MAFJTfWtBd1qP4bvsYXA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bts0k9mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:11:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47689dc0f6dso32454581cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932688; x=1742537488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IScPRMJWlAypVVGTG3eAzrrqZqNhSbnrEPn3z5FtHkc=;
        b=pmyafMs6AH6WCMUPoGTmBv1id1kDxrItOXdjWacekb0kJ7cYnGRqzPLQwGnSwK/MLI
         q+jwUdZZpBtzzvD6IWYL5Ot45l4xRxhad/PjThresX8y7T9nP8qDxSdu3wf3S26Bun6K
         5jCb21AbgSSYOMzvwC9Z9owXCifcu+g7lMh8R3y5adKk83NnwoaG9DLAb/+9L/x8Olr7
         6HOkED+X+5ewDQc6+3EzSLBwdAO+lBxEbtfpItsNeqyj1LPTgsUDTqBjvFegQ2kHhH3w
         nNpaswcVfneYiyUv+Vwae70/H5Sn7m6/xMoy/xzjjuowwg1nFrDB5VnNyf9l9I9PmKKx
         nSHA==
X-Forwarded-Encrypted: i=1; AJvYcCU8vso88PyFjS2tZMP8oWEBhecxrZKU9on9vtrhm0+cGh5aCIydHZx+MClMcZS8uEdQfJ5HXy8hLXHJmUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkNE/CB82TdRweDPQuZEYTlz7fmk66bBr80t5lT8F3hxE5MW3R
	O0ZYVd1VZMI19oy5s37KwvGDqgjqa6yJy7YpzrTaq90Cl2b6SuN1k/UjrhTzX4VBiFbGISITlZp
	//DPU01qq2fOIRZmEVdy9HLpfse95xlg0zl2kcjT/MmTEtvokMMxfBfEJf2KlLGE=
X-Gm-Gg: ASbGnct9GmOCNYDPPl1jH42zzvwsPDV+ALfWYpQh9tXboRzr9DUV4J/p1q9Gyk7JnCo
	vKw0UH/a5LLlDndIT4pNjFuX5aSRgn2z4cG0txLYnD70/+POwLTUMCfLhnk5ebKB2R+k8TsIIsV
	JBe9vBXmpmPe+AVVFvHQj50wxUVmiFFYkD9jfGInYQujF7nErnhsMfwU4suDC4u/v+Q44tqyYoy
	IMSl/6MtSgvdzhcEFDGTwtQEiDgmsCremGkRjTEOtMmqx0ziidd8OikueW8V7fPo/xxsa23Xx//
	6F1oL0Fz/UMo9fn/clltwBkxsnddrzOeP0FPo53U/RnJDNpHjKTDPkoFwBul9HPOGkarzdr2DO4
	+1Co=
X-Received: by 2002:a05:622a:438b:b0:476:b33f:6694 with SMTP id d75a77b69052e-476c815ef7bmr17238371cf.28.1741932688211;
        Thu, 13 Mar 2025 23:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHNONjkAR8RZmnBgw7/nNpbDzwNbQgBnWMqJdks15ZpyrrMTOeZPgm8VR3KSNnTn4CBULsAw==
X-Received: by 2002:a05:622a:438b:b0:476:b33f:6694 with SMTP id d75a77b69052e-476c815ef7bmr17237651cf.28.1741932686118;
        Thu, 13 Mar 2025 23:11:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88577csm415667e87.205.2025.03.13.23.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:11:24 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:11:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Fix error pointers in
 dpu_plane_virtual_atomic_check
Message-ID: <5dhbi7a62mebu6trwr3umjnkiia7nnaru533653z67qmmsc2hb@krmvfeuw5xtn>
References: <20250314011004.663804-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314011004.663804-1-chenyuan0y@gmail.com>
X-Proofpoint-ORIG-GUID: 1Hapnz8iHSD_jOibl77fziAm8Xpx0EqT
X-Authority-Analysis: v=2.4 cv=DNSP4zNb c=1 sm=1 tr=0 ts=67d3c890 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fWY0QR86pWCIX_IcxasA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 1Hapnz8iHSD_jOibl77fziAm8Xpx0EqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=894
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

On Thu, Mar 13, 2025 at 08:10:04PM -0500, Chenyuan Yang wrote:
> The function dpu_plane_virtual_atomic_check was dereferencing pointers
> returned by drm_atomic_get_plane_state without checking for errors. This
> could lead to undefined behavior if the function returns an error pointer.
> 
> This commit adds checks using IS_ERR to ensure that plane_state is
> valid before dereferencing them.
> 
> Similar to commit da29abe71e16
> ("drm/amd/display: Fix error pointers in amdgpu_dm_crtc_mem_type_changed").
> 
> Fixes: 774bcfb73176 ("drm/msm/dpu: add support for virtual planes")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
-- 
With best wishes
Dmitry


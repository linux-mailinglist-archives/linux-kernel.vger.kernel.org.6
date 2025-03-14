Return-Path: <linux-kernel+bounces-561770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A315CA615E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AA9169C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF09202F9E;
	Fri, 14 Mar 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pCULBLvv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A50202C55
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968573; cv=none; b=hFr8q5shkpvGGo4z4k2bbxJQ1bhaaeYctWBPif81+yXHwudNSlQ1M+nzpf93dpfQEwMl4qDqS272W5SK0DuC2ehmtZZQmbjFRmNWsHp5ACYNW0+ajlawFdipL/2fC4OBt7e9l6X61BbE6yzr0DJl9vv/2t+sjXfYEwN9kK9Zx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968573; c=relaxed/simple;
	bh=i+34rY2XWlvh95r6AiE1ixVzUl9QdoxHpcFKTO5zoUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A92eSDVeTFKrHosx3oksun0QHAP2h6Cj2Yey+xXFVHyBmXrLsKcyD7e7n0QeLm+sIPeIZe6b0RCsOr6UU4HqDlQh2RQhTTgx40ei/u9Dah3/sQAUGamPAu+7ueoPfHTvhvSMypUkVim/Ml67dAWdujwFVeM+jECYoOxd9TCf5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pCULBLvv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBZvFk031553
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4bfnZNLncJjN6sD4k19N7fqv
	87YFw/Wyvudwmu2GWLw=; b=pCULBLvvEJ5zlulgOx5Keu1ILqe5T/PE0nPgv8wz
	fgd5lJf0gE69EWhdteWIjjhh4xBK3+BNnON8biUvqP0enCRIt4BqNirWryS/hTeX
	zsJ2SHoOLxxp2Ifx3Y0nRG3f6BEs6hmVBtf4qUFal0jDfltfzrfIaO5oz6i+M+7z
	CTIO6+guaadWjLOLT/2xGge9xKLGwZXvFn3stK+WVm7rbmU3fRQ3JlbapvhL9vwi
	sPtuJzbmlahLsX8DQnrqgSuScrx1saoE9Y0bq1m1vpgliA+AOru9iHrIMk2bDWPa
	FoebxzTzNmZk2XqefExvyGTHGvePt7P9xbRkIiHkZu1Eiw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bx1jm73m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:09:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e905e89798so34911976d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968570; x=1742573370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bfnZNLncJjN6sD4k19N7fqv87YFw/Wyvudwmu2GWLw=;
        b=cgEzN0qigaAjGNux1Odbp3SbOPmhqaGQjdgWHqsb7ILIYojIUL4lZNQKELjbJteQmK
         9asAUjroKLM3N0s58AEcxZ3nx93z6Y4pQpwXJ4QPMklD4kBNfXeizmrpYS15c3lBVesI
         8UKOO3Sc7wAGNjiNj/rnkOMgaQ+KAsvGbKVBllUfv0aWRrN89/sepia48mvLBYIYkwcy
         4a2Pef3rHFHH9Dn02NVHH4cgEbozoxDaRG7zlAAWPU9DlXQhoKVuozehzDxrEufo8Sxs
         MFSPOY4+1xiUgeCtZgSJFI5HMyoGetuZZCk4lk6NgckJicL5WNsXgNY7bnY4jWA/eDqp
         /pYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmVtX1mXG9AaH3Fa2DQ5tyfiGy4pZW6iM7/q1oXB8gZxsH2JSV9OnvL3crGNyQfdbmQZI8MrjPhdRAgy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkzDX/5fM57YRb3zC4m7nuBlKAK7Ddj8LaNQ6KoSm4yp2c0+d
	xkzMddNeZvn3fbdcwJIX6xex7wf0jWw+xqqi7o6ssOFz3nYPlU+AL6xOo09OLm5IbpF5MNCyGP/
	4jI+7D2Yds8X2b2vQrAP790YeKYUGGCaGs+OBY4YOUWwWBLXQrz5hkyAyb1N8H88=
X-Gm-Gg: ASbGnctGm6utmuE3C+ai+joi6BAx5UeS1cuCpx7B2RTRPYlxht4Xotk/es8UnlwpeHm
	/9i/3DhWx3F6T0vjkvKHbT10K4M6K2JZi6oudUhc6ngVgvIuV0lSjbtJu3Y8Q7j8LCQYth2uEcO
	biXjhCV6gscH66k7mFs5CqPuQywoPeTF2a8gIonXhNJEwMmNoxMKzeu/YR0KHlOaB+Sn9/KPh1O
	jGYk7d0BxtFSqfOl9430TVRouXB1GCn1OF562TfpHC8q20oSbgft2TDjG0YlxVih4jhyiWHhRCK
	mUKazRfNAh/U8+pJu2TxNsFqX03oDuZiCrCISeJXYd6qYGzxudlB1Zp5GR9DAGNtw9PgM/ED3Ot
	aVRU=
X-Received: by 2002:a05:6214:226c:b0:6e8:97d2:99a2 with SMTP id 6a1803df08f44-6eaeab371camr48806956d6.39.1741968569765;
        Fri, 14 Mar 2025 09:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2EjdDnqtRenbzdvH5JrG4m54Jxc0lHOH/tkPmuYrU9Psmdz0yG5KOTxSFr5UTWXvBDmjLAw==
X-Received: by 2002:a05:6214:226c:b0:6e8:97d2:99a2 with SMTP id 6a1803df08f44-6eaeab371camr48806386d6.39.1741968569358;
        Fri, 14 Mar 2025 09:09:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d3003sm6297611fa.10.2025.03.14.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:09:27 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:09:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/vc4: use new helper to get ACR values
Message-ID: <5fjxnvt3e7t3qgvyprpsiun3d2xqqoz5ovwcbabdqpptg5zj27@k4jjjshf2ps7>
References: <20250309-drm-hdmi-acr-v1-0-bb9c242f4d4b@linaro.org>
 <20250309-drm-hdmi-acr-v1-3-bb9c242f4d4b@linaro.org>
 <20250310-invisible-married-firefly-945c84@houat>
 <esgb42dyhpjixm62tfk2nfzdiygnfn4bcwq4zn7rhydmt4np2q@7v77p7kveb4e>
 <20250311-intrepid-obedient-lizard-64ad2c@houat>
 <wass63nz24l4h3umszsyptb5bnkny4h2wmnbeunjrdfhyacl4l@w6emq2ipt552>
 <20250314-sassy-illustrious-koala-3ad3dd@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-sassy-illustrious-koala-3ad3dd@houat>
X-Authority-Analysis: v=2.4 cv=CNQqXQrD c=1 sm=1 tr=0 ts=67d454bb cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=JEape1zOPL1jDBVHQqIA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nntY0cN7QGWvaM9C08YBYg1K4G_Z2xUR
X-Proofpoint-GUID: nntY0cN7QGWvaM9C08YBYg1K4G_Z2xUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=699 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140127

On Fri, Mar 14, 2025 at 02:46:09PM +0100, Maxime Ripard wrote:
> On Tue, Mar 11, 2025 at 06:28:50PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Mar 11, 2025 at 09:07:10AM +0100, Maxime Ripard wrote:
> > > On Mon, Mar 10, 2025 at 10:18:04PM +0200, Dmitry Baryshkov wrote:
> > > > On Mon, Mar 10, 2025 at 03:51:53PM +0100, Maxime Ripard wrote:
> > > > > On Sun, Mar 09, 2025 at 10:13:58AM +0200, Dmitry Baryshkov wrote:
> > > > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > 
> > > > > > Use drm_hdmi_acr_get_n_cts() helper instead of calculating N and CTS
> > > > > > values in the VC4 driver.
> > > > > > 
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/vc4/vc4_hdmi.c | 10 +++-------
> > > > > >  drivers/gpu/drm/vc4/vc4_hdmi.h |  7 +++++++
> > > > > >  2 files changed, 10 insertions(+), 7 deletions(-)
> > > > > > 
> > > > 
> > > > > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> > > > > > index e3d989ca302b72533c374dfa3fd0d5bd7fe64a82..0a775dbfe99d45521f3d0a2016555aefa81d7934 100644
> > > > > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> > > > > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> > > > > > @@ -211,6 +211,13 @@ struct vc4_hdmi {
> > > > > >  	 * KMS hooks. Protected by @mutex.
> > > > > >  	 */
> > > > > >  	enum hdmi_colorspace output_format;
> > > > > > +
> > > > > > +	/**
> > > > > > +	 * @tmds_char_rate: Copy of
> > > > > > +	 * @drm_connector_state.hdmi.tmds_char_rate for use outside of
> > > > > > +	 * KMS hooks. Protected by @mutex.
> > > > > > +	 */
> > > > > > +	unsigned long long tmds_char_rate;
> > > > > >  };
> > > > > 
> > > > > This should be in drm_connector_hdmi if it's useful
> > > > 
> > > > That would mean bringing the state to a non-state structure on the
> > > > framework level. Is it fine from your POV?
> > > 
> > > Sorry, I'm changing my mind a little bit, but it's pretty much the same
> > > case than for accessing the infoframes from debugfs: we want to get some
> > > information stored in the state from outside of KMS.
> > > 
> > > What we did for the infoframes is that we're actually just taking the
> > > connection_mutex from the DRM device and access the drm_connector->state
> > > pointer.
> > > 
> > > I guess it would also work for ALSA?
> > 
> > I'd really prefer to follow the drm_connector.infoframes.audio. It makes
> > sense to group all ALSA-related functionality together. Maybe I should
> > refactor it to:
> 
> That's the thing though: the tmds_char_rate has nothing to do with ALSA.
> It's useful to derive the parameters, but KMS controls it, it's part of
> its state, and that's where it belongs.
> 
> Just like any infoframe but the audio one.

Ack, I'll take a look.


-- 
With best wishes
Dmitry


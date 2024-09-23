Return-Path: <linux-kernel+bounces-336269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE0597F15C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34BFB215DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735741A01C5;
	Mon, 23 Sep 2024 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="StLVWPcV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526F19F42D;
	Mon, 23 Sep 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120718; cv=none; b=SFfFg1Atha3RX9nqSoXEJiwhaijkiRu9H+D2ms+TVMrOzDBEx7BdcLHKLr1A9OJdNM30UdxizWYy3sXId23WvvT8ed1rWumAph+zzVNnuAdMFGYbaNS+LcM4Sr5/ZYreNyBeCdbOogQjZvzAiNfIrGI2B4IpElWgiw1ihjcsIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120718; c=relaxed/simple;
	bh=MtnrHYxohBslcjCWbr23r1ewTwEhAjq049XhwHk1I2Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZf4o0NHZJXbZqVm+GH+HlxTlues2N6OhfNk3PbuJFXw9NhtvSxlfnhf3uQghJyMK41qf0PKU1kTNnLhRbl+oCMkzh80cIRQExzKfUlCzRAkO4I4SXpQCWkcHjSU1kLdBU7ezcyCj8beqr1M5Ja984F+IOo+T2Vux2XLI34nAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=StLVWPcV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBh8BC027530;
	Mon, 23 Sep 2024 19:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sSTCginR2ZY0/fIq656s3FWkCzlUlPSAZyfv6HPZPiI=; b=StLVWPcV4BGCg1wi
	kTFWtb51vrGT8RbUB9Efm5H38iDIYWnVId5jxaz+LUSmNFkpPsIoL7YbMpazzqJt
	e0IxUdXObQCElmbZkbDMMA7B9kNpXmUYeeA3ySfEQvR5pdRu7dQWEYCuvS3ynS6g
	pKskExb5+OMY2zr1H8kFBY2b94HITN4CTWRrbTveIOkZqEx/uFu/mtZk4EZ8KGPx
	A1cN6UyzAmcpgiQW730oLz+hPo92jj2zT1nbO3M6dONTazfXqDom5HnE5kAln8P0
	c9Ob4m4wNGM1DEHIt0ArNkVxy7igKlN07eX0sQUg7a2TqaX3aKnJ7Y7CLmj7QIEl
	LY1Xvg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfgx9tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 19:45:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48NJiwQi010816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 19:44:58 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Sep 2024 12:44:53 -0700
Date: Tue, 24 Sep 2024 01:14:49 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: Rob Clark <robdclark@gmail.com>
CC: Antonino Maniscalco <antomani103@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 09/11] drm/msm/A6XX: Add a flag to allow preemption to
 submitqueue_create
Message-ID: <20240923194449.vffhq7ppkzxtx5bl@hu-akhilpo-hyd.qualcomm.com>
References: <20240917-preemption-a750-t-v4-0-95d48012e0ac@gmail.com>
 <20240917-preemption-a750-t-v4-9-95d48012e0ac@gmail.com>
 <20240920165427.wikjsywhbcb2kz7h@hu-akhilpo-hyd.qualcomm.com>
 <CAF6AEGv95t=ioPGYLi6CdEuQzx9GC9ehMaTyG03ucbdVHx3eEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGv95t=ioPGYLi6CdEuQzx9GC9ehMaTyG03ucbdVHx3eEg@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0D3usY9JzrmlcBBvk5tUK_zuVS1BsPmR
X-Proofpoint-GUID: 0D3usY9JzrmlcBBvk5tUK_zuVS1BsPmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230143

On Fri, Sep 20, 2024 at 10:29:44AM -0700, Rob Clark wrote:
> On Fri, Sep 20, 2024 at 9:54 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >
> > On Tue, Sep 17, 2024 at 01:14:19PM +0200, Antonino Maniscalco wrote:
> > > Some userspace changes are necessary so add a flag for userspace to
> > > advertise support for preemption when creating the submitqueue.
> > >
> > > When this flag is not set preemption will not be allowed in the middle
> > > of the submitted IBs therefore mantaining compatibility with older
> > > userspace.
> > >
> > > The flag is rejected if preemption is not supported on the target, this
> > > allows userspace to know whether preemption is supported.
> >
> > Just curious, what is the motivation behind informing userspace about
> > preemption support?
> 
> I think I requested that, as a "just in case" (because it would
> otherwise be awkward if we later needed to know the difference btwn
> drm/sched "preemption" which can only happen before submit is written
> to ring and "real" preemption)

Thanks. That makes sense.

-Akhil

> 
> BR,
> -R
> 
> > -Akhil
> >
> > >
> > > Signed-off-by: Antonino Maniscalco <antomani103@gmail.com>
> > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> > > ---
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++++++----
> > >  drivers/gpu/drm/msm/msm_submitqueue.c |  3 +++
> > >  include/uapi/drm/msm_drm.h            |  5 ++++-
> > >  3 files changed, 15 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > index 736f475d696f..edbcb6d229ba 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > @@ -430,8 +430,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> > >       OUT_PKT7(ring, CP_SET_MARKER, 1);
> > >       OUT_RING(ring, 0x101); /* IFPC disable */
> > >
> > > -     OUT_PKT7(ring, CP_SET_MARKER, 1);
> > > -     OUT_RING(ring, 0x00d); /* IB1LIST start */
> > > +     if (submit->queue->flags & MSM_SUBMITQUEUE_ALLOW_PREEMPT) {
> > > +             OUT_PKT7(ring, CP_SET_MARKER, 1);
> > > +             OUT_RING(ring, 0x00d); /* IB1LIST start */
> > > +     }
> > >
> > >       /* Submit the commands */
> > >       for (i = 0; i < submit->nr_cmds; i++) {
> > > @@ -462,8 +464,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> > >                       update_shadow_rptr(gpu, ring);
> > >       }
> > >
> > > -     OUT_PKT7(ring, CP_SET_MARKER, 1);
> > > -     OUT_RING(ring, 0x00e); /* IB1LIST end */
> > > +     if (submit->queue->flags & MSM_SUBMITQUEUE_ALLOW_PREEMPT) {
> > > +             OUT_PKT7(ring, CP_SET_MARKER, 1);
> > > +             OUT_RING(ring, 0x00e); /* IB1LIST end */
> > > +     }
> > >
> > >       get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
> > >               rbmemptr_stats(ring, index, cpcycles_end));
> > > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> > > index 0e803125a325..9b3ffca3f3b4 100644
> > > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > > @@ -170,6 +170,9 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
> > >       if (!priv->gpu)
> > >               return -ENODEV;
> > >
> > > +     if (flags & MSM_SUBMITQUEUE_ALLOW_PREEMPT && priv->gpu->nr_rings == 1)
> > > +             return -EINVAL;
> > > +
> > >       ret = msm_gpu_convert_priority(priv->gpu, prio, &ring_nr, &sched_prio);
> > >       if (ret)
> > >               return ret;
> > > diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> > > index 3fca72f73861..f37858db34e6 100644
> > > --- a/include/uapi/drm/msm_drm.h
> > > +++ b/include/uapi/drm/msm_drm.h
> > > @@ -345,7 +345,10 @@ struct drm_msm_gem_madvise {
> > >   * backwards compatibility as a "default" submitqueue
> > >   */
> > >
> > > -#define MSM_SUBMITQUEUE_FLAGS (0)
> > > +#define MSM_SUBMITQUEUE_ALLOW_PREEMPT        0x00000001
> > > +#define MSM_SUBMITQUEUE_FLAGS                    ( \
> > > +             MSM_SUBMITQUEUE_ALLOW_PREEMPT | \
> > > +             0)
> > >
> > >  /*
> > >   * The submitqueue priority should be between 0 and MSM_PARAM_PRIORITIES-1,
> > >
> > > --
> > > 2.46.0
> > >


Return-Path: <linux-kernel+bounces-574010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD93A6DF91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458B6188853E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F2263C72;
	Mon, 24 Mar 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mX4uXRUY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6112638B8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833499; cv=none; b=DQX05vH46Ea2gIg4VhvQlH7Z0OdAOsjm8Y4mrEMl708CLHr07WUqI1CvV1I+wD1NAw6GW8tpaTvzTLeTmpy82dBD7m2T9eJPpER3mD6VucBAx6xAfHzrGfmWgIVGaBno6ReZUT9yqhbMrdFZF674oSJsHDW0NKAcCxO3iXGmzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833499; c=relaxed/simple;
	bh=VJLXobn9ia1bRIN7ny53DorGdjpsOZQkTlBQAIuVR8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/OxFWfBZSXfqs2Fc4qQDqhkYjFEevNC6bHdM4+CPzwUNQmTkxTPI+zlegpNzKMICPCfF0z8cNnPCqcQFUDaIXI0Gce44W+FNGo1conLA8g7vuchafyEhpVne7m1KPehUMthHg22bHo/9t77cNmcPSlR5KziAxOfx8jxL1j4Rf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mX4uXRUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PSgr026022
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1AM0Se3LYUFXvOwXu8tjYGZh
	Xl+o6O9g5pUYbt3k7S8=; b=mX4uXRUYceC7UPGYvb2KY6d6Eaqtyc6Mllqc2cXf
	kk2BHnPr0rCvWvxwaMGzpqBTwUu2sgIOxs52L6G1aO71/M/fHQODZMwm7C7+2h3V
	sodbI4no7ARPP567urRc9nN2kmB0r73/EVhlivrkey9MwpamnjZWKwrdoC08RYhJ
	8ZPAyo0+/JGeie9EcWgn/I8rwdRBDZ4EHV1+EVgHmxjXR1ePopcFAZQwmliiMGU2
	ZNd7zso242h7sAWY7Tk/EbB9h1OMUJdOE6WYiIEn7Cxu048pkK2qheGqle0usdqR
	pQTdTDFnpwgBQDtHVh2zWcMH1tejgxuRvrTdkLmyrF/rLQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnn5k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:24:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5d608e6f5so171094385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833493; x=1743438293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AM0Se3LYUFXvOwXu8tjYGZhXl+o6O9g5pUYbt3k7S8=;
        b=wW4g1fTUiSliq6RybIfyTF+W9J1E5/8NaE4HlPYQfpEEa8MPnLUSs1FAtPk8RYrHex
         IwceCUMEixyi/SaNUeRmI3LObD75Tf+3+e8NjKDMY8ripRTU1XyPTvHA0/gjspcR7mX2
         UwlUsnsrmVDL3cKI99CbQAhkunQARv2a0ONBdfYFDCE+A0tsWIRGzPrB/+icAAwClqWm
         zAQnVfVE+7TguZImpPk6MFDs2zkw6NKhKgFxBYrJG4IiDzsnvYUKdV8ZN16LzFugV/Mt
         NKle94YLrg35Vuy3zky5USJub6KfoeAAdoAa98qCRIvzkOIgjrW3wMAlpFfbDOoiSe+Y
         M50Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+7IMonBYBS+qoE47jI1k4HXcvAXt8+zOS1/eSmgcw3reMn//T8gAvW4qfLNNID2auokBaR73cs/0wkBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMr9f/QPZNy1f+ayZzCvOpQ7/CNopSUTsNLLWQHA66W2e7DOz4
	2iDYLrLzJYvX0BKDnNppO+4ELhheyyTri4Tp64dUyXeAhDuFrdpPs3XnEhkFihfBgIItLiMxil9
	/329GADjBwE2eowCKdYahuhrxzdtpQdifehk/O+viLidzAkXrPSh+nbkV0eJI3Ho=
X-Gm-Gg: ASbGncs6PMfX6dbPOkxuKgErE3XeEE6Id+8fniJKTWv1eETTYZMlSmuofvPS8hY58Xf
	p7fZpAkoO0cWki6x+BIEjHP5BCnGBQYsWZvW3cqzU4o2eE6FVP9V5RgXKTMMYfEQHc/LCkdqn2J
	KkBWE03Cn4VxNkuwLanZk+6ayhbbN9uK8Y1mR9Nx/0X8rr+/fkofVbSjjMVeJ7HghdM2c4Wre5a
	iA+4IxHVxK1VB5Rg13ilv8OdROBq2x1QG4W2iEg/BKDpzdbDw/e1P1qVtyCDUtrr93oJnz6Q1NH
	ziV+aomH9SspohESc9BZGktrBcv9ivx3uqPJ+CmY31ct8o54wNpTxM/vER6VNA7ny8d9/ZxKlkc
	+11Y=
X-Received: by 2002:a05:620a:2982:b0:7c5:5800:ddba with SMTP id af79cd13be357-7c5ba15d9e4mr2114804585a.22.1742833493335;
        Mon, 24 Mar 2025 09:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxYkrT0PSiVJNKIxtwPLzi/aVHIvDz4gsdAhPc2l3H7IPz9M3SZ3IZa0XIswYbBnjdeKoDmA==
X-Received: by 2002:a05:620a:2982:b0:7c5:5800:ddba with SMTP id af79cd13be357-7c5ba15d9e4mr2114797785a.22.1742833492771;
        Mon, 24 Mar 2025 09:24:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65037e1sm1188914e87.162.2025.03.24.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:24:50 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:24:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, quic_kuiw@quicinc.com,
        quic_ekangupt@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] misc: fastrpc: add support for gpdsp remoteproc
Message-ID: <zo5sdn5l76noehza5663o5kwoygn6mvargbx2udtxheyctq7dh@elgz36lixmg3>
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-3-quic_lxu5@quicinc.com>
 <30bba296-8e6f-41ee-880e-2d5ecc8fe5a4@linaro.org>
 <5r72xrv5rtw6bemh5onygkroyasroviijlta4hvwgm5c5hzvax@3icylchlufu3>
 <90f2bcab-d89f-40c0-9851-7ff25f2c1eda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f2bcab-d89f-40c0-9851-7ff25f2c1eda@linaro.org>
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e18758 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=bXJdDZvNK-UVdt6kW3wA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RgrJmvUNK5bpaI0fIaCg9SOgychg7c_m
X-Proofpoint-GUID: RgrJmvUNK5bpaI0fIaCg9SOgychg7c_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240118

On Mon, Mar 24, 2025 at 01:29:30PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 21/03/2025 14:07, Dmitry Baryshkov wrote:
> > On Thu, Mar 20, 2025 at 05:11:20PM +0000, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 20/03/2025 09:14, Ling Xu wrote:
> > > > The fastrpc driver has support for 5 types of remoteprocs. There are
> > > > some products which support GPDSP remoteprocs. Add changes to support
> > > > GPDSP remoteprocs.
> > > > 
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> > > > ---
> > > >    drivers/misc/fastrpc.c | 10 ++++++++--
> > > >    1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > > index 7b7a22c91fe4..80aa554b3042 100644
> > > > --- a/drivers/misc/fastrpc.c
> > > > +++ b/drivers/misc/fastrpc.c
> > > > @@ -28,7 +28,9 @@
> > > >    #define SDSP_DOMAIN_ID (2)
> > > >    #define CDSP_DOMAIN_ID (3)
> > > >    #define CDSP1_DOMAIN_ID (4)
> > > > -#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
> > > > +#define GDSP0_DOMAIN_ID (5)
> > > > +#define GDSP1_DOMAIN_ID (6)
> > > 
> > > We have already made the driver look silly here, Lets not add domain ids for
> > > each instance, which is not a scalable.
> > > 
> > > Domain ids are strictly for a domain not each instance.
> > > 
> > > 
> > > > +#define FASTRPC_DEV_MAX		7 /* adsp, mdsp, slpi, cdsp, cdsp1, gdsp0, gdsp1 */
> > > >    #define FASTRPC_MAX_SESSIONS	14
> > > >    #define FASTRPC_MAX_VMIDS	16
> > > >    #define FASTRPC_ALIGN		128
> > > > @@ -107,7 +109,9 @@
> > > >    #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
> > > >    static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
> > > > -						"sdsp", "cdsp", "cdsp1" };
> > > > +						"sdsp", "cdsp",
> > > > +						"cdsp1", "gdsp0",
> > > > +						"gdsp1" };
> > > >    struct fastrpc_phy_page {
> > > >    	u64 addr;		/* physical address */
> > > >    	u64 size;		/* size of contiguous region */
> > > > @@ -2338,6 +2342,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> > > >    		break;
> > > >    	case CDSP_DOMAIN_ID:
> > > >    	case CDSP1_DOMAIN_ID:
> > > > +	case GDSP0_DOMAIN_ID:
> > > > +	case GDSP1_DOMAIN_ID:
> > > >    		data->unsigned_support = true;
> > > >    		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
> > > >    		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
> > > 
> > > 
> > > Can you try this patch: only compile tested.
> > > 
> > > ---------------------------------->cut<---------------------------------------
> > >  From 3f8607557162e16673b26fa253d11cafdc4444cf Mon Sep 17 00:00:00 2001
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > Date: Thu, 20 Mar 2025 17:07:05 +0000
> > > Subject: [PATCH] misc: fastrpc: cleanup the domain names
> > > 
> > > Currently the domain ids are added for each instance of domain, this is
> > > totally not scalable approch.
> > > 
> > > Clean this mess and create domain ids for only domains not its
> > > instances.
> > > This patch also moves the domain ids to uapi header as this is required
> > > for FASTRPC_IOCTL_GET_DSP_INFO ioctl.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   drivers/misc/fastrpc.c      | 45 ++++++++++++++++++++-----------------
> > >   include/uapi/misc/fastrpc.h |  7 ++++++
> > >   2 files changed, 32 insertions(+), 20 deletions(-)
> > > 
> > 
> > 
> > > diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> > > index f33d914d8f46..89516abd258f 100644
> > > --- a/include/uapi/misc/fastrpc.h
> > > +++ b/include/uapi/misc/fastrpc.h
> > > @@ -133,6 +133,13 @@ struct fastrpc_mem_unmap {
> > >   	__s32 reserved[5];
> > >   };
> > > 
> > > +#define ADSP_DOMAIN_ID (0)
> > > +#define MDSP_DOMAIN_ID (1)
> > > +#define SDSP_DOMAIN_ID (2)
> > > +#define CDSP_DOMAIN_ID (3)
> > > +#define GDSP_DOMAIN_ID (4)
> > 
> > Why are you adding these to uAPI? How are they going to be used by the
> > userspace?
> > 
> > > +
> > > +#define FASTRPC_DOMAIN_MAX	4
> > >   struct fastrpc_ioctl_capability {
> > >   	__u32 domain;
> 
> here, in domain value of fastrpc_ioctl_capability.

I see. I'd say, moving those IDs to a header is a separate change. Also
please document that this patch changes the user-visible value for CDSP1
DSP.

> 
> 
> 
> > >   	__u32 attribute_id;
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > > ---------------------------------->cut<---------------------------------------
> > 

-- 
With best wishes
Dmitry


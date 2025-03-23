Return-Path: <linux-kernel+bounces-572818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD6CA6CF19
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA7E1896668
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA5204C30;
	Sun, 23 Mar 2025 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EbrCtBWS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01C1DE4CE
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742731470; cv=none; b=O5CtUt30CJ508iedhd5hBmif5nxEk8IME8DHKy/rYdPBf7Lynx/okNhoYg2mautJDWJnVFNDKZ1+7pWmew9zTbFgszKrKgqQbQa8ndCFAcS81EB+sFWaGEzC/54MEYbQnu6/12wCZhucdz9ed4b+3K2/xtjat6EfRSX8ACGkF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742731470; c=relaxed/simple;
	bh=PxmKJqFUBmzCrGRLWWlomzlMrJaMyoSylmgo2KqWPGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HndMC1/XNMIa7/Jp1SIKXzMvCpbHKr2yA64zHO+fp4LZ6V3DRPZS/Ot52vXNQm0c9pMNhuFLEp4SI9vpmlrKWvJx8KHV6ZeiFpuzWbaDp78TP7FbFlRmX5F80KAuACKZhie6lKDKtkkn53Tg9UhpldrAHF4+WjLLrU2LjUAEqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EbrCtBWS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N85hbw010799
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PtNJp8w8nckej15xutxKhS4k
	OXPplB94JjbMuQAYRRk=; b=EbrCtBWS7hnXnBrUFrZ62PLDHaISMF2xqqUAT+io
	ZrBe/ae/+Jd0PBds9av7K9eZISkptprQzbmj8mM/r1YKvdw6fg8tWQieGEqMMGFY
	8+hXs2sft7Sms46xIa52RJgNZwMBwgkWX5acptv0a9QD0zzx0/c4+yL3MK6i2cpE
	v8i804miy7q1NWYMHXETboVYHErF5cMMdUnK3Rx5ftzgqn38MIWrYKW7+irdBww2
	WJYANu6NThQstUhwJZFuqvQBhLfdIAmp4DlhsyRbNkNF6pGpcxgvcTjn70NydsAe
	x5/BuF5pDWuvAcDoLm+lXESfVreXEEdjtoU99uPQ2airXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm5ut2jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:04:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c53e316734so688008785a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742731467; x=1743336267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtNJp8w8nckej15xutxKhS4kOXPplB94JjbMuQAYRRk=;
        b=Q/k1JIeQvisvcKN0c9SI7BCfDEMZMTYjY9okhLLnLyc6RnKfIUBEH5MExmFhr+Oiyn
         Nf4vYKgd4zoF35Wn/zmFmouhZSfvKOrsRJiWzijJvZtN0oHq6ZJCohuAoPAMDpuQVR1c
         USd98xc07v0O96zNnoOkKHwS66V8NihlV3RwxSQSR4VW+EXU6ionKZKqDmeTcoHq7EBc
         8hLdPRv1EVa7Anxk0yZiZOaQ8Sbhc+GexSpNfY3EKoGNB9fWCdMZzWPnY75ZtpxzIXYB
         NQaXxyiiIvJzNlmGMpNIXddPE2h+fNxKqfsU7PZ748JN11qb/Cd05jGu8D8dRTzrdIGn
         Y6FA==
X-Forwarded-Encrypted: i=1; AJvYcCWIA37EY+KqDffaMgQrr0owvt+QTW8sciNJtCC/CkHARv867SPmsjyHCXRMxBDTEKCJ+uBoM5wurpmkMu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+yFtAGjVL2IQ3Wp2k2e5Bd+cgge9TSLqLVPtgBw4s+oZwn0dL
	eOXYjF3LJbFCBAuuHianoZmwfis++OaODGm/CNzxfZZenZmT1gk7l57JcXgGvN6DE6+DeOcNXGk
	6lmAben/+rGm4YfaNWP2Cfx/DNL0L1ei7ZSCkA2G+htZ2RVeZ0NNRgaAxrIMfnQM=
X-Gm-Gg: ASbGncv8fqAlmrDzZlvshzCqYFkjgZt2TvT2FEBLCc0FIUc2BpYVeUqSMuXOYvi55Su
	cZsSWJzkxk2R65XZr06UTKwqs7q86XTRSZC0MHixxI3b23hEkCB6QjjROkM5j+pOMsqO/2/JtR1
	y1GLleOYUAXPLqMfM3uwpJi71gLtEWKNQcso4w2Z2EXA9yOkXOeq3Q6+6N0oF/NKzBPCDE7W1es
	AZwRE0ZOb6eojG4QicB1XlP5osMTfvk9NQxWHxE8VVmGZXDO8pnSTv5FvlIQuRCtv2HeQe7s9F1
	vKdtDrD/H5yxaTAOcRxffW2rlF5XeQNAafBWacWCD8jXgs5icPhrF37+TyM7+PS1rGutJiO4ivZ
	TNi4=
X-Received: by 2002:a05:620a:3195:b0:7c5:5a51:d2d1 with SMTP id af79cd13be357-7c5ba1f82b6mr1710847485a.55.1742731466559;
        Sun, 23 Mar 2025 05:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2A8oxvXHZ30wz/fnjEGUSilQEaiG/qyUmCAQEVrIcB8cjuiV+eyQPzVEYxJqb5IUczKBSIw==
X-Received: by 2002:a05:620a:3195:b0:7c5:5a51:d2d1 with SMTP id af79cd13be357-7c5ba1f82b6mr1710843785a.55.1742731466265;
        Sun, 23 Mar 2025 05:04:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6511f50sm766696e87.222.2025.03.23.05.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:04:25 -0700 (PDT)
Date: Sun, 23 Mar 2025 14:04:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes Wu <Hermes.wu@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/3] drm/bridge: it6505: modify DP link training
 work
Message-ID: <7ltrwnweqk4dvqicppdpsj7pcbvky5peiwrunnfyvacklwuqia@265ovn3v3ifw>
References: <20250318-fix-link-training-v1-0-19266711142c@ite.com.tw>
 <20250318-fix-link-training-v1-2-19266711142c@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-fix-link-training-v1-2-19266711142c@ite.com.tw>
X-Proofpoint-ORIG-GUID: _m8fut8IcTpn_VSxbb_6CxMA1TThffFU
X-Proofpoint-GUID: _m8fut8IcTpn_VSxbb_6CxMA1TThffFU
X-Authority-Analysis: v=2.4 cv=AJKH5mlP c=1 sm=1 tr=0 ts=67dff8cc cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=Ns9eNvu6AAAA:8 a=tFqG47sHqY_YckTfvRsA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230090

On Tue, Mar 18, 2025 at 04:32:10PM +0800, Hermes Wu wrote:
> The DP link training work include auto training and after
> auto training failed "auto_train_retry" times, it switch to
> step training mode.
> 
> It will more efficiency that finish link auto training,
> include retry, and step training in a work, rather than
> re-schedule train work when each training fail.
> 
> it6505_dump() is remove from link trainig work, it takes too much
> time to read all register area, and is not necessary.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index dc1179c8338e27866f6adda4ef8fb2950336221b..11231a642bbe185c4f36bf5f2a0b115fa056213b 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -666,7 +666,7 @@ static int it6505_get_dpcd(struct it6505 *it6505, int offset, u8 *dpcd, int num)
>  	return 0;
>  }
>  
> -static void it6505_dump(struct it6505 *it6505)
> +static void __maybe_unused it6505_dump(struct it6505 *it6505)
>  {
>  	unsigned int i, j;
>  	u8 regs[16];
> @@ -2472,7 +2472,7 @@ static void it6505_link_training_work(struct work_struct *work)
>  {
>  	struct it6505 *it6505 = container_of(work, struct it6505, link_works);
>  	struct device *dev = it6505->dev;
> -	int ret;
> +	int ret, retry;
>  
>  	DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
>  			     it6505->sink_count);
> @@ -2480,26 +2480,23 @@ static void it6505_link_training_work(struct work_struct *work)
>  	if (!it6505_get_sink_hpd_status(it6505))
>  		return;
>  
> -	it6505_link_training_setup(it6505);
> -	it6505_reset_hdcp(it6505);
> -	it6505_aux_reset(it6505);
> -
> -	if (it6505->auto_train_retry < 1) {
> -		it6505_link_step_train_process(it6505);
> -		return;
> -	}
> +	retry = it6505->auto_train_retry;

Should you also drop auto_train_retry from the structure and assign
AUTO_TRAIN_RETRY here instead?

> +	do {
> +		it6505_link_training_setup(it6505);
> +		it6505_reset_hdcp(it6505);
> +		it6505_aux_reset(it6505);
>  
> -	ret = it6505_link_start_auto_train(it6505);
> -	DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
> +		ret = it6505_link_start_auto_train(it6505);
> +		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
>  			     ret ? "pass" : "failed", it6505->auto_train_retry);
> +		if (ret) {
> +			it6505_link_train_ok(it6505);
> +			return;
> +		}
> +	} while (retry--);
>  
> -	if (ret) {
> -		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
> -		it6505_link_train_ok(it6505);
> -	} else {
> -		it6505->auto_train_retry--;
> -		it6505_dump(it6505);
> -	}
> +	/*After HW auto training fail, try link training step by step*/
> +	it6505_link_step_train_process(it6505);
>  
>  }
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


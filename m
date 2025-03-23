Return-Path: <linux-kernel+bounces-572817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D18A6CF16
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C130D7A41CB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68513204877;
	Sun, 23 Mar 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bD8j4Ox0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1E15ADA6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742731347; cv=none; b=lSSgtvAMsWwB4GsVMe5cfZi1T0e6wo+6oMT+voYq5O6Rx/dg3m5m0uGIbdW1CAdXdCOG+ezZ+ix+1dQGY4LqegbTMhxwauDCqNpWY0WiKLc9ui2+PhRWrrDNGzXzdzCMmshflIgX4Py3i3g8ymDYeIziMmXjA536NmFJG9DLT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742731347; c=relaxed/simple;
	bh=JP4lCgezlv+EMraImLC9zkRZsK+QTJLD4cwhQNWNRo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRnO6oPEYAFH7coOwKY28eC+Ob0xhpi4Fv8oln1c2jKWAg5n3hOPguGEGJcQJjzwz7m8TYWHnmltZBVa601Ri1DgaVzwnf26iidR6/B7TI/fdF5QsgSZsPPfjuOqof6qG0ninX6ptJilkEjq+nlvNNB0Xlq9zf7nMZoPTCjWv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bD8j4Ox0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N8fn4b007997
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=owWWg+3ngfcDMSge8Uta5NLk
	3HmV41FfKzaq3U7rS88=; b=bD8j4Ox0F0GEBtVGZxE/w6Y4tdrbfqhuvGZtHJTs
	ItpdqAEpKcvs0xQnMGbPBFaEQy+PRugpetfauoxadSHrf01vdRSH2g6w8phUxiDR
	zA7AvpIn37YzNCTer6Patl+sd6dOEel2avJYwFd25XlwiMrajnn7xavOZRAPkuRM
	Yt92Zad1Glh29XR9T12qSf+DojjfhaEyqZxGglIn5Hbrh7iLcBri7JLK4znGYg+Z
	aWxR6iMAfhtHcSv6l5H0savt6nlPnR36kedAU2GghD74kB9Hf7nWMnUNTFENr/o2
	a5j1w0hnTiNXJvsSkpXNBgRxZ8bxE97M6cymZpPqgpnEsQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9w9ynm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:02:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0c1025adbso797686385a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742731343; x=1743336143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owWWg+3ngfcDMSge8Uta5NLk3HmV41FfKzaq3U7rS88=;
        b=u43iK+q6I8Hvlmvu2L+TYK+mfO2M2a9hipG7CBW1L7mqgi/R7MVPwCzYmoKfTlJrJZ
         RvUQL8daBbJhaPOGGCww2oFnLnuDj0+kqHYn87+FidbLtnOKfKGpmGwC9bDCWzZXueCZ
         cpGb/q1Yx0MkXdV/F/Udug1ZngBFIKJVycQDodtH3+ziPRQMnqSscWbs7u7Krc1rGCZF
         CtlfVi8pXmBL5Ocr12x7EJ3HionaWkrcuivjBFCwszG/DIZDmtN7hlm86mMFUwqoBUTn
         n1Y3bi0/jkAYBK5Bo5i3Qfx8odWITQ2ty7KIwZtpF/QU1+L2TCKIK9xAvomqMrlk9kYX
         w/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCtJtbydXymwhPXR2ZdZXqHGuT6hcZzDEpyvawL6UkhYrwTfX7AB+2M/n7A1LT9L6KdWaKZV3NYAXFbK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bJZUyU8PJJsUIwxkzT07TnUIEPJCAWG1ymb00FPhJEjaGfpg
	uSBfknU06OX0yM6SJoPKVSZF/ymTz/xHz/+CtX/5bsNurpjoHK8DU5E/xilvG3Xlu/WPa0yqFuw
	DVoPLk2pswhW3hABpFD7XhG6RqH7dZgQaf9Fgu3TQkx470qxVrqE2xbB4sEz2dwM=
X-Gm-Gg: ASbGncu1wB6lMvoIHZ7iPatYKZXET+FBGV22xbEAyC4z1DBxpeMDvlP4CCMKtYLNnXl
	Hk1pt4r7SCXB7PS+GmJ2Sh18VXiiiDgjz1rkDisR96pm08rgPfwkzzyzlaZJfK+zkJB8OuSnle7
	mHrTm+xS/W7G9QIWkrmY9jn0hOPwI6JCVjdpwk3HtgTm4Dx2FeaB634DugVBTRnEXm4+tS3nnub
	7q7A2PGh9/dpWZuVXtbxoHtcYHdbLKI3xJq9BpYB8m6qE+bLPAky8Q1CGnyz0yaWJzCm3eWK8Zb
	NIcaHbm6ThMTTIEoaISCb4ttSjx7QnaCledbzrM1CNrhuH0iL0RjFw7ivJe/3ZIkQtp3UDpPQV8
	dHiw=
X-Received: by 2002:a05:620a:46a5:b0:7c3:c3bb:2538 with SMTP id af79cd13be357-7c5ba15c19cmr998399785a.14.1742731343282;
        Sun, 23 Mar 2025 05:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2sOLr+Y7Ofa4PhKuOWYyWX/dd8bkc4YeS3A8FMOuKvB6oEGo5Yb9r45IMrvOUJipbqPGM7Q==
X-Received: by 2002:a05:620a:46a5:b0:7c3:c3bb:2538 with SMTP id af79cd13be357-7c5ba15c19cmr998394985a.14.1742731342759;
        Sun, 23 Mar 2025 05:02:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6508163sm739052e87.181.2025.03.23.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:02:20 -0700 (PDT)
Date: Sun, 23 Mar 2025 14:02:18 +0200
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
Subject: Re: [PATCH RESEND 1/3] drm/bridge: it6505: modify DP link auto
 training
Message-ID: <vs6hcvwpuvkih3xpcl7ew2x5verz2ddyf4bufmwnqxwl5iu2vi@rpwaqmdobqdl>
References: <20250318-fix-link-training-v1-0-19266711142c@ite.com.tw>
 <20250318-fix-link-training-v1-1-19266711142c@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-fix-link-training-v1-1-19266711142c@ite.com.tw>
X-Proofpoint-GUID: 07F9vs7bNdHzRgyqwddRZwmXnzYid6QS
X-Proofpoint-ORIG-GUID: 07F9vs7bNdHzRgyqwddRZwmXnzYid6QS
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67dff850 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=Ns9eNvu6AAAA:8 a=S_47lyTNMjpC8ibViOYA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230090

On Tue, Mar 18, 2025 at 04:32:09PM +0800, Hermes Wu wrote:
> IT6505 supports HW link training which will write DPCD and check
> training status automatically.
> 
> In the case that driver set link rate at 2.7G and HW fail to training,
> it will change link configuration and try 1.65G. And this will cause
> INT_VID_FIFO_ERROR triggered when link clock is changed.
> 
> When video error occurs, video logic is reset and link training restart,
> this will cause endless auto link training.
> 
> Modify link auto training with disable INT_VID_FIFO_ERROR to avoid loop
> and check INT_LINK_TRAIN_FAIL event to abort wait training done.
> 
> Since INT_LINK_TRAIN_FAIL is checked when auto training, it is remove
> from  it6505_int_threaded_handler()
> 
> In order to reset HW link auto training state,
> bits FORCE_RETRAIN and MANUAL_TRAIN at REG_TRAIN_CTRL1 must be set
> at the same time.

I've been looking at this patch for some time. I think there is too much
going on for a single commit. I'd suggest splitting out the
INT_VID_FIFO_ERROR handling and MANUAL_TRAIN changes to separate
commits. Then dropping of unused BIT_INT_LINK_TRAIN_FAIL will also go to
a separate commit that it deserves.

Basically, if at any point you feel that the commit message starts to
look like 'Perform A. Then drop B. C should be set', this is a
description for three commits, not just one.

> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 61 +++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 88ef76a37fe6accacdd343839ff2569b31b18ceb..dc1179c8338e27866f6adda4ef8fb2950336221b 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -821,7 +821,7 @@ static void it6505_int_mask_enable(struct it6505 *it6505)
>  	it6505_write(it6505, INT_MASK_02, BIT(INT_AUX_CMD_FAIL) |
>  		     BIT(INT_HDCP_KSV_CHECK) | BIT(INT_AUDIO_FIFO_ERROR));
>  
> -	it6505_write(it6505, INT_MASK_03, BIT(INT_LINK_TRAIN_FAIL) |
> +	it6505_write(it6505, INT_MASK_03,
>  		     BIT(INT_VID_FIFO_ERROR) | BIT(INT_IO_LATCH_FIFO_OVERFLOW));
>  }
>  
> @@ -1800,30 +1800,62 @@ static void it6505_link_training_setup(struct it6505 *it6505)
>  
>  static bool it6505_link_start_auto_train(struct it6505 *it6505)
>  {
> -	int timeout = 500, link_training_state;
> +	int link_training_state;
>  	bool state = false;
> +	struct device *dev = it6505->dev;
> +	int int03;
> +	unsigned long timeout;
> +
> +	guard(mutex)(&it6505->aux_lock);
> +	/* Disable FIFO error interrupt trigger  */
> +	/* to prevent training fail loop issue   */
> +	it6505_set_bits(it6505, INT_MASK_03, BIT(INT_VID_FIFO_ERROR), 0);
> +
> +	it6505_write(it6505, INT_STATUS_03,
> +		     BIT(INT_LINK_TRAIN_FAIL) | BIT(INT_VID_FIFO_ERROR));
> +	int03 = it6505_read(it6505, INT_STATUS_03);
>  
> -	mutex_lock(&it6505->aux_lock);
>  	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
>  			FORCE_CR_DONE | FORCE_EQ_DONE, 0x00);
> -	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN);
> +
> +	/* reset link state machine and re start training*/
> +	it6505_write(it6505, REG_TRAIN_CTRL1,
> +		     FORCE_RETRAIN | MANUAL_TRAIN);
>  	it6505_write(it6505, REG_TRAIN_CTRL1, AUTO_TRAIN);
>  
> -	while (timeout > 0) {
> +	timeout = jiffies + msecs_to_jiffies(100) + 1;
> +	for (;;) {
>  		usleep_range(1000, 2000);
>  		link_training_state = it6505_read(it6505, REG_LINK_TRAIN_STS);
> +		int03 = it6505_read(it6505, INT_STATUS_03);
> +		if (int03 & BIT(INT_LINK_TRAIN_FAIL)) {
> +			/* Ignore INT_VID_FIFO_ERROR when auto training fail*/
> +			it6505_write(it6505, INT_STATUS_03,
> +				     BIT(INT_LINK_TRAIN_FAIL) |
> +				     BIT(INT_VID_FIFO_ERROR));
> +
> +			if (int03 & BIT(INT_VID_FIFO_ERROR)) {
> +				DRM_DEV_DEBUG_DRIVER(dev,
> +				"video fifo error when training fail (%x)!",
> +				int03);
> +			}
> +
> +			break;
> +		}
>  
>  		if (link_training_state > 0 &&
>  		    (link_training_state & LINK_STATE_NORP)) {
>  			state = true;
> -			goto unlock;
> +			break;
>  		}
>  
> -		timeout--;
> +		if (time_after(jiffies, timeout))
> +			break;
>  	}
> -unlock:
> -	mutex_unlock(&it6505->aux_lock);
>  
> +	/* recover interrupt trigger*/
> +	it6505_set_bits(it6505, INT_MASK_03,
> +			BIT(INT_VID_FIFO_ERROR), BIT(INT_VID_FIFO_ERROR));
>  	return state;
>  }
>  
> @@ -2377,7 +2409,7 @@ static void it6505_stop_link_train(struct it6505 *it6505)
>  {
>  	it6505->link_state = LINK_IDLE;
>  	cancel_work_sync(&it6505->link_works);
> -	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN);
> +	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN | MANUAL_TRAIN);
>  }
>  
>  static void it6505_link_train_ok(struct it6505 *it6505)
> @@ -2691,14 +2723,6 @@ static void it6505_irq_audio_fifo_error(struct it6505 *it6505)
>  		it6505_enable_audio(it6505);
>  }
>  
> -static void it6505_irq_link_train_fail(struct it6505 *it6505)
> -{
> -	struct device *dev = it6505->dev;
> -
> -	DRM_DEV_DEBUG_DRIVER(dev, "link training fail interrupt");
> -	schedule_work(&it6505->link_works);
> -}
> -
>  static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
>  {
>  	return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
> @@ -2763,7 +2787,6 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
>  		{ BIT_INT_AUX_CMD_FAIL, it6505_irq_aux_cmd_fail },
>  		{ BIT_INT_HDCP_KSV_CHECK, it6505_irq_hdcp_ksv_check },
>  		{ BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error },
> -		{ BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail },
>  	};
>  	int int_status[3], i;
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


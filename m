Return-Path: <linux-kernel+bounces-564021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E92A64C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF967A6A18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194E2356B7;
	Mon, 17 Mar 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hull9x8J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173822CBE3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210316; cv=none; b=l6Z97+y3DUAKS/PTNbzT6seIDdnd9My1fa3lRcz6c/x9N8rdMcYO95+fothR1ZpkU3GnAmSoZMCjK7LQgkaMcmsAkH2iOXIsA3gZWS4ZWbhG7iLoIOxuGL9EoLjm+wav6urNbj3aBKHbkQTS/XymQs8sEJhfAHEoOGeaVWB9u1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210316; c=relaxed/simple;
	bh=jrgw6Gygr4CPrUKfVVlFEZ9x5B2iq8/1oQW8zcdFomw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyXBt4WEHbSekayGNQUNwAV+T5TD6KTP502CY368bsZxmcbpyyW93Avd1Pxo2pHUw48YpwZejBs47e9+oESFEAjm+d9Ektpxa66GEYZowjwuW0zoz+m9BDKLpYzbWIIcAzyTxVWhxGcVrQE58MZhQo0XdyegAJDCMS3BhVPDMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hull9x8J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HA8Djr006169
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T6QOzefVCB1ALDVD4b+E90Zw
	NlbrEyFAiugsTYpAVrY=; b=hull9x8JoHiFgaS3SlgZechUD/CMNKDXKs3KhU67
	uNYO21JvYUPJ0GabzPXvCGjxWgR1VQ5Uf/WmaswT2MMWaUqFxTXq+dDsGqlPlfOf
	m64LXYj4gMAFGNuN1JoSRg47sPuC26MKAmQ3spbnUk8M5vPIsLTuOk9gzptMg4Ja
	ydzYfTDAb0XFz/98pRFCnrJorI4CQjOYeKwR18Lrr31G4OKyFoYXcw+71OFLvV+3
	eDe/vUWX8+7WMO9sAY4WMhQsx5gthKCVgSGahWtUgUwpo4asWQJp8KlGsxhgf8lu
	d/kiIRy9Fb6bKYnHjN3199AnAQTi6PD0Gnu5BcObSC2MlQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1u8chps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:18:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f99a9524so155924956d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210313; x=1742815113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6QOzefVCB1ALDVD4b+E90ZwNlbrEyFAiugsTYpAVrY=;
        b=cXHEiQS6/npSFEesrHTcaT++Xfm9vC9KFiDVr9sEmj7ubfiMKd0eXHzYWhR38Gqmht
         Drzm+kQ1hqMDLhVOepxPLpAVeKGsF3DFdeC495ddFLjQGF+O5L2FPop62PDm19DAH1YH
         LD5WgMz5qrR/djN4JZ/wp6mUx4FeFClay/F7BgAgF1fVkpNXp2xoA+xbHiQ0t0zqoHwH
         FbtQRBztzUVYBr1EbTrq20zfqBFSAj87O0QNSOCfzw3dFT01GYYv6ravqO7tywJGwVYq
         pv38tqy/ECB8zG79CdmmGceajQbE5YadjI9fWEAWLxbrLpd4a/8lt4LSO1XXZVfSpE2l
         pwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpgIiWTw5Yzq00bXqEqichb+HF8NjQBL4BWxAfkgDNNrxnGhUi/ncFmxHlhQG0hisJkZw3qakJmxSRows=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SgbJ46wnlectUbPPU7fE5vceWPLX+Rh041wr4s3x9PpwuhBg
	IHz8wOL2UILFVz++M8xPJlwAIxV8G8tOboTMfQu9Z7Mh6gdYukD3bY1I0iW0TlmaqcWLee0G9yP
	CA80llvENClVHrI7aw0V90QZLe2ggtgWaFgCjcD543r3Q3+JZkweQrXfbdMZLT2Y=
X-Gm-Gg: ASbGncv3Qym5p8w//9U8MATr1vmHO0JYXNqw7iqAmwypgFilGKAfWLRVoetmK/Jt9k7
	NfxQJaTPnbThS7xc5wPr/6CFy4NABywVAlplDkTFA4NIJZPN2GAXxYPAvzryJc/5S1z3PjY/Wz8
	i8TFrZkbLqEz9hV0ifN46OoRBfAW6R+skHscNKXtNPP/V6txzaMF+P5TAEOB0Sd9d/MYvuws3jm
	KsluYoBqBFs97LO8Fe/WSEezo0twlH01UfI2vs6Rwjw6GdIk+n4uqXbu+HB0IDfsf7XbXeUFwj/
	YvSRtGtqLUiWCmJFi4unkJp7MyKZEtIvGlZ4lcOfL9EXT0bOhUlR1THBS+jx6DBWDjp3mrhaD+5
	iwzI=
X-Received: by 2002:ad4:5bac:0:b0:6e8:c713:3220 with SMTP id 6a1803df08f44-6eaeaaeaf05mr223054276d6.36.1742210312970;
        Mon, 17 Mar 2025 04:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRfErhQONfbnUCDF3/m06A/fCJBaed+xYW/LUK+0W0eB9q/0f4vqTLFVHcA8wc0miWiEPlSQ==
X-Received: by 2002:ad4:5bac:0:b0:6e8:c713:3220 with SMTP id 6a1803df08f44-6eaeaaeaf05mr223053646d6.36.1742210312455;
        Mon, 17 Mar 2025 04:18:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e99e0sm15568441fa.34.2025.03.17.04.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:18:30 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:18:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: zhang.enpei@zte.com.cn
Cc: neil.armstrong@linaro.org, andrzej.hajda@intel.com, rfoss@kernel.org,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil-sii8620: Use dev_err_probe()
Message-ID: <7vxbjx3mjeo2a7km5jo3kwguqfip4rkl35mncdgcvhymhe2w6j@7mwshdqfn4id>
References: <202503171404563447jAdJlVvoFXDvBoj0sAx6@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503171404563447jAdJlVvoFXDvBoj0sAx6@zte.com.cn>
X-Proofpoint-GUID: z-0MaqfnSe0FpONLOorVI-nSB9I-pXcc
X-Authority-Analysis: v=2.4 cv=c42rQQ9l c=1 sm=1 tr=0 ts=67d8050a cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=ib6j6c_6DBfqJxPKIQYA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: z-0MaqfnSe0FpONLOorVI-nSB9I-pXcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=848 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170082

On Mon, Mar 17, 2025 at 02:04:56PM +0800, zhang.enpei@zte.com.cn wrote:
> From: ZhangEnpei <zhang.enpei@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: ZhangEnpei <zhang.enpei@zte.com.cn>
> ---
>  drivers/gpu/drm/bridge/sil-sii8620.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry


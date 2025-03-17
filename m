Return-Path: <linux-kernel+bounces-564019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B5A64C21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E387A429C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA34231C8D;
	Mon, 17 Mar 2025 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HYHxUqMP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2322CBE3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210259; cv=none; b=C/ru/nz184AE3PQz5+IgvzKCuz7YZ8casTVLVYdAMmnjjhjcAYr098M07ijtHxwEfayYpJGnH4OJL/J6agHQGdHBvVbQYgDEpzCGbJZ0TicyctptIe4A+N0dbj5xGjynVXOeX+/QOuth2/4BU0Qs7jLaPOKjeI2EogU5fpfGyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210259; c=relaxed/simple;
	bh=MjGaHAxIyKXmVDUqw6iZrWpQY4My0C236pP+phIqMXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2HlvQwTWVmH2MsxgK1o6ttqK0kaQ2vNKlzzYecI4e/UblYz7dIwBfz+pJY9MSSVknRtaAt1SMY1Rog8nYbO7IsroVyohBxGpCABF8TQhv3wvMLyppVPF7F7NDmV5pK1WfarVgzrHJsniIFz7CQdTKB3/KGNivZVVRaOc5QR3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HYHxUqMP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9sQSZ014469
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h74ZuGvGt7Gc4RGJOB1qbK9R
	Ms5B7HunMvfAcbl6nvI=; b=HYHxUqMPrJ3obXGUkn3BioKk6j6uxHLRu7NOjZ6Q
	na2xwlx1XjT+6HHgGhYHgxUu0HyEUuyTIw4tkbu7bVGW4moFV4UW93i1sFXRpgW0
	C+b+xTlN219AHLkDzh4tcROiG7Dng8YcRpKoU8os1A4BeGsWI85bY1d5QTWYvVR9
	mVK9+SHC0mXBWnWtE2KjB5SnL91X+q02dIyuEGOJQ63A/viXrJNynF0ffqW3ekMA
	4uV+/ttvfdmdKGMgKZBIhm7ClX968bawO6/xmsRiK+cZg95wEZIsntqvexcreKnc
	Cfr7Faml7mCCPwX/cYaHRobY+9D4Qdg8QLj01sKWlQcWYg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1rdmj8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:17:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8feea216aso101223336d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210248; x=1742815048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h74ZuGvGt7Gc4RGJOB1qbK9RMs5B7HunMvfAcbl6nvI=;
        b=XiJ6HZ0U3MUpgI9V1Y3SP2QRuFLsnf2YB0+YpNkaUYdbr57XimFQEfxbwWWND6/mlJ
         sVSADF1ToCwcZDIWR9kZOrun4HWDjdLua/5WR7IfCCF/XXhI4fcE97FX7S9b0Da+1Cso
         N2yXkq2aqluujgZjjumTSapcc6MzyPbIKeX93PDMXVuGQUrGNzacJzt8kyBuuv7o2EQy
         bB5O9E7Z39hzob+CpvWflxO/W+4PSIovzSvjhClZY4yuCVFlzjurcg/KfuMigroiPEKu
         l8bZ2+MUtN3LnyGtz5zuRRinDmX+VwlPMBMdPLVTdNPYUbHn3fCij0ej9p4iiGF1RZjN
         dNGg==
X-Forwarded-Encrypted: i=1; AJvYcCVD44RYx1DVWxkCjm5/dCg1W4s2AENTjSiUQ5Ct6JP0II1DAvZKdkS6tNj+jWitHIVP/fuWYuxBLrHshRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcy37zfl5T7CBf+aQp89tfI4MG1IDFJeDUQ1EDZArO4EZjrWtc
	dB0C6Izk9j0DVNSgORW8Vvg0OmK2QtqRMLknYDcFJaBasSB9YX28oePYU86hq3WnnD40yF3Hf+J
	hCcW2M0fvxmy2B0TMUs8xa6HdC5FJ6w5yiIlSCBC0oQlomd3rVytnTsNfgPRFhXA=
X-Gm-Gg: ASbGncs/z/ZAoZtRxSqMNCUEqcS2g/p2cyueWvTk0M7Mq/AkDj9G5jdx7ae2x7NKi5Y
	LRYEevtxX+0W+7//6CH1sDuV3C7U0+2dJW5y6/RB0wyxE6LSr/CkpdQEO7WxqMVIhi+Wpm1j3py
	bEytn8FpLqUVvEqN+XHB0D5SujtcpBIiYZCeGW+RQi6C1ZNO44qjTtRbTSiJrBmmv8S416YYgAr
	Q3H5PKQdyCeBlmX7lGSPiIvcgIt4Iyxk7aWp6I2uvNARZl3QmnL4Ifss5AU0jUdvB+MvCPLrp/Z
	5exoXjcYu2amFYxC3imdnGLlUZ8L21tYEuUv1GJjECr13ccOeJraQ+d5JVR8aTi0jV82tSayK9O
	XSBw=
X-Received: by 2002:a05:6214:5784:b0:6e4:4adb:8c29 with SMTP id 6a1803df08f44-6eaddf4d222mr233455176d6.12.1742210248619;
        Mon, 17 Mar 2025 04:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1cyDl4xkioe3y+ghWS263/60KKZ8OYW8NPmR6GC2f7A41gOXYwaVyUw5mFVJ9O7ml2j/IHQ==
X-Received: by 2002:a05:6214:5784:b0:6e4:4adb:8c29 with SMTP id 6a1803df08f44-6eaddf4d222mr233454916d6.12.1742210248276;
        Mon, 17 Mar 2025 04:17:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864e24sm1302546e87.107.2025.03.17.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:17:26 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:17:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Hermes Wu <Hermes.wu@ite.com.tw>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Robert Foss <rfoss@kernel.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v6 2/4] drm/bridge: add function interface for
 DisplayPort audio implementation
Message-ID: <2wxcuacri3ts24hyuqpvw75cubkhcup2mftrsu7yykrrodulix@fmuzn3unykux>
References: <20250314-dp-hdmi-audio-v6-2-dbd228fa73d7@oss.qualcomm.com>
 <d5b8a7fa506ed3026c19b383edf160d6@kernel.org>
 <otidtln4pjb47azr7zhllxkqmwocdnbdiay6xcg6psphz3436i@fn5hxgaflgv6>
 <20250317-dancing-loyal-malkoha-ad5a36@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-dancing-loyal-malkoha-ad5a36@houat>
X-Authority-Analysis: v=2.4 cv=Fe83xI+6 c=1 sm=1 tr=0 ts=67d804d0 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=dGy_cPlXK_KhQYNS9IIA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 1lywJdweXw2vm-WU8oqRjo3Dw0jhf6iu
X-Proofpoint-GUID: 1lywJdweXw2vm-WU8oqRjo3Dw0jhf6iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=952 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170083

On Mon, Mar 17, 2025 at 10:45:16AM +0100, Maxime Ripard wrote:
> On Fri, Mar 14, 2025 at 08:55:05PM +0200, Dmitry Baryshkov wrote:
> > On Fri, Mar 14, 2025 at 05:54:14PM +0000, Maxime Ripard wrote:
> > > On Fri, 14 Mar 2025 11:36:49 +0200, Dmitry Baryshkov wrote:
> > > > It is common for the DisplayPort bridges to implement audio support. In
> > > > preparation to providing a generic framework for DP audio, add
> > > > corresponding interface to struct drm_bridge. As suggested by Maxime
> > > > for now this is mostly c&p of the corresponding HDMI audio API.
> > > > 
> > > > 
> > > > [ ... ]
> > > 
> > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > 
> > You've sent two r-b's for patch 2. Is there a chance that one of those
> > was for patch 3?
> 
> Did I? Sorry, it was indeed meant for patch 3

Yes, at least mutt and lore show both under patch 2. If/when you have
time, could you please fix that so that the r-b is recorded for future
generations?

-- 
With best wishes
Dmitry


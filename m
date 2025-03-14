Return-Path: <linux-kernel+bounces-561634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D777A61463
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09D93A37F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13FA200132;
	Fri, 14 Mar 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bq0JgtMY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5D17579
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964424; cv=none; b=NkXWROyd8ajSPhomhwHjOGEM02kHh6h9ScSQ8sUB14pj1W/ga3sLCkqfHgin7vYl+4lhGAdxeXOhc3hqCfNooi9zfKN57wDMaztJdRBeTBhh+WT+3sqRF87ZLKyUmLyjFH5w1yfdVBiOcAF14Tn0OcPkRPgeDUhh0m6VOIiHmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964424; c=relaxed/simple;
	bh=x1PLoyIRwWCrKRdFyzASe67Wyr+y7IAO/4CM0PBgJCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkP37RzMFCC6iX3SK4X/J0LW7VbAHmMjuBjc7aTTlgITVrb7tsHULOtjLT7s4cR3CrS+1JDWR3cJuGl/9L5mQ1XSqBx5rqSGs5k+kxWwQu4VQ9VsA3yKdGVvHPbzeqHr5dhchIrN0ba3tYyEwLhHEIn1Rc26u7UMKvtCqXPugSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bq0JgtMY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EA4Hm3027567
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5Q1/t28eBE47VhslKnKzc2xe
	LvFBD34uadwrGYmHEs8=; b=Bq0JgtMYKQTYFkthrwll6D6i7x2kHLEY1SZZOluH
	Jpbxvynhgc2jljLcuBhAY2pJ28v1sMxcrSpBzPZo0DciI/4ER1SjszylH4fcFtT4
	PXOuhysQ8iauOg2KD3qJjakXZSZwltWLuriHyqSgpK8Zt2r5Hq7Kp8wMCYZ0A8er
	VrEsbkiCqk/f3Rwh4HlefbfpW0GwY7++kN2sx3QfFc5m2Lfd2W827042ws7w22j+
	zDqgb/jJIF6mGTCrI3uEHDzbVTHu6UKq8d9uQrMytyKiVIVMErJu0IXx2HRPB6qx
	Izs/yCSnpCVS6VyuNyq4fnA0bsDLuGFyOZ2R3F9N3/mAgA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c6732hvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:00:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e91054ea4eso37901546d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964420; x=1742569220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q1/t28eBE47VhslKnKzc2xeLvFBD34uadwrGYmHEs8=;
        b=O3At3mw+dB8YGdhd1o7IJrAM5a/xjUE8ApI5NgCSpzZ+TuBcwWvFuBtscbZw1IooYi
         RN2bvjFieskxAAli6ezFutZv9Hf3sXOBUFTTrv+huchZNgtXotRFvo1JnfrS2eZf0X+g
         WuwK78YmZb2nNC+h4xQnJ4FQC6EvNHyfn2bqwlB2UtPUE8G+AHuiZ/RL9yVICDlzO5Ts
         q42YJM1YCmQPGODt7w2BgWGcgnGLzfgOOs9WybGzBOf5WgUrSxY7vbACdaPTO0F/sjCs
         Lu5BOfdr2wmnbZXuwNqtCfstqLJus792Wq+2YO+Zd/H3m3nh2yAUK537f5eTeYyCWBYc
         byqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78drMZLYaOhtpJziBC4u34GZDaycHyA3NQy+e6rF2C2dZZgil70HUYQFzqEPuI1gM1pCugV/DgzudIkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxz7jUkIlw7Ou8hyI/oM3MJlFrcUH4YlZnJUCMnNbDSu+lFK9
	lh0pP6qoW8ZdCarmzPXhcfOn0mVGiVm1jW+krkIq3FSs65lOXW24UBCvNC0jdGOPYKYl8CvJE5o
	R8aQXO0ydpilpZexiKVjM94WngTVWChKEsRCeJxjIoCyrwIai0Sk6NQZtnjUrpb969SBpiuQ=
X-Gm-Gg: ASbGnctk4JG1VrN8MEDFZy81d7xPcD7QMrcXILnGwjOM/JQy39D0YF6iA2z+M9+8TfC
	kYQvs+zEKOyx4O4Zq5Gui1XJNwXvcit/nrmq7FTJbEYqXBTEYmLJSFJCc7yDF8vTcKCC8Culylf
	2Um5FgOny5+LqbaIsf7Ik+gWuN8/oRWYE3uSrAYBbe/vahL4Gjjbl7Ilpz0VAwgl87HixyGZYeK
	10vjmn7spSjl0707UfdjnJVmhdhwDqozVaeQqoNwMqp9Prp4qN2r+6X0Qe8ZSyrexh97jUDjCDR
	ouQfq9z8ZibyUkfN4POZ8oa+Tx9N+DUGUzweB9BSrPviBtZfnK66+rfo9kH6DFILqSrfkpCxtN4
	Mzw0=
X-Received: by 2002:a05:6214:c47:b0:6e6:5f08:e77d with SMTP id 6a1803df08f44-6eaeaa64726mr38922716d6.19.1741964418942;
        Fri, 14 Mar 2025 08:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElOf5VcuP4Qfeqk7k77duSbY0HMHuiCaGOzAq7nuu0v/lm1rSxjObW30d/t+f4KOijDX3OSg==
X-Received: by 2002:a05:6214:c47:b0:6e6:5f08:e77d with SMTP id 6a1803df08f44-6eaeaa64726mr38922006d6.19.1741964418512;
        Fri, 14 Mar 2025 08:00:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88536csm537756e87.177.2025.03.14.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:00:16 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:00:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
Message-ID: <zfbamnotz4smuswgzhtp7maqw5o7d5boi5urvqfrqylszbbyok@jtwqtjmji4qr>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-4-fbdb94f02562@collabora.com>
 <20250311-hypersonic-mature-leopard-d3afdc@houat>
 <g25hgb2mocl4sjny26k4nzn2hwpwhlodenqganzcqfzzg6itms@herenniualnw>
 <20250314-airborne-magenta-corgi-afd52c@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-airborne-magenta-corgi-afd52c@houat>
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d44486 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=QX4gbG5DAAAA:8 a=JkxHsKVaOhtT2WVG5y0A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: YKBwKv1RkEUZWITGoJnJiVca8Lmirxyf
X-Proofpoint-ORIG-GUID: YKBwKv1RkEUZWITGoJnJiVca8Lmirxyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140118

On Fri, Mar 14, 2025 at 02:47:53PM +0100, Maxime Ripard wrote:
> On Tue, Mar 11, 2025 at 09:46:39PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Mar 11, 2025 at 04:55:17PM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > I think the first thing we need to address is that we will need to
> > > differentiate between HDMI 1.4 devices and HDMI 2.0.
> > > 
> > > It applies to YUV420, which is HDMI 2.0-only, and I guess your patches
> > > are good enough if you consider YUV420 support only, but scrambler setup
> > > for example is a thing we want to support in that infrastructure
> > > eventually, and is conditioned on HDMI 2.0 as well.
> > > 
> > > On Tue, Mar 11, 2025 at 12:57:36PM +0200, Cristian Ciocaltea wrote:
> > > > Try to make use of YUV420 when computing the best output format and
> > > > RGB cannot be supported for any of the available color depths.
> > > > 
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > > > ---
> > > >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 69 +++++++++++++------------
> > > >  1 file changed, 35 insertions(+), 34 deletions(-)
> > > > 
> > 
> > [...]
> > 
> > > >  	return -EINVAL;
> > > >  }
> > > >  
> > > > +static int
> > > > +hdmi_compute_config(const struct drm_connector *connector,
> > > > +		    struct drm_connector_state *conn_state,
> > > > +		    const struct drm_display_mode *mode)
> > > > +{
> > > > +	unsigned int max_bpc = clamp_t(unsigned int,
> > > > +				       conn_state->max_bpc,
> > > > +				       8, connector->max_bpc);
> > > > +	int ret;
> > > > +
> > > > +	ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
> > > > +			      HDMI_COLORSPACE_RGB);
> > > > +	if (!ret)
> > > > +		return 0;
> > > > +
> > > > +	if (connector->ycbcr_420_allowed)
> > > > +		ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
> > > > +				      HDMI_COLORSPACE_YUV420);
> > > 
> > > I think that's conditioned on a few more things:
> > >   - That the driver supports HDMI 2.0
> > 
> > Isn't that included into connector->ycbcr_420_allowed? I'd expect that
> > HDMI 1.4-only drivers don't set that flag.
> 
> Yeah, I guess that's one way to do it, but we don't have any way to
> express it at the moment

Yes, we do not have a way to specify that the connector is HDMI 1.x or
2.0. However I think the code that we currently have ensures that the
flag is set if and only if the HDMI Host and all the chain after it
actually supports YUV 420, which would imply HDMI 2.0.

I know that drm_bridge_connector has one deficiency wrt. YCbCr 420 flag:
it is impossible to "inject" YUV420 in the middle of the chain (e.g. DSI
host outputs RGB data, but then comes DSI2HDMI bridge which can convert
RGB data to YUV). I kept that in mind, but I'd like to see an actual
usecase first. And anyway, this currently limits YUV support rather than
enabing it in the unwanted cases.

-- 
With best wishes
Dmitry


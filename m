Return-Path: <linux-kernel+bounces-566890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A4A67DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F7318984D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601F211A1E;
	Tue, 18 Mar 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Avxvrd83"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D441DC9B4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329061; cv=none; b=aA3bEYyoLYnfeDiuMQBKMN3sRYJ/R/cS3biOb3IVgafAAJJr/lM40LZtAbLA6VOpdyNpLhRYxIBEPL2mDRIX3VkTc6/UTjTOEgutVBhFQ260CHrZrbyPFuE6gr+ChTGd9Wp1sLRfcuaOLkawst9nUBDVjA3qtXQVFjMZ/qySNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329061; c=relaxed/simple;
	bh=AzXyB5EkAUNruTmZIeiCYJQfJP3zRYcf+iButSPyDQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIIr0/FuRA3IFx1O/IqmGNrCQfwnBWaxrNZNHCjq3IKEWyid59HBGkHB95fmx8+7XK9XvxKZfMtp0ltCZVyr++MWjbXMjHWBlPnPAPS7k73b4uaVSlGIcxeJW/4Hje5JX1d5Hxk1wc8sdO/RjFmC4kiqR+hBco/ezHmUCIPtnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Avxvrd83; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IIBL5q004551
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cdXNdl9Su+hv7nD+r8LRc5/p
	SIzgMjV1CTk+j9RmE18=; b=Avxvrd83SV9pw/zx4cjtu4CAnOFCEPsZU3hEc1k0
	9T4ngkOn3ehk7MArmnKepclT49uAIp0i4dW97tupImkaf7PTG1VPxk0ZOGm1GSrT
	oucO8IrA3hvL1m8I7d5V0l8OisndSVlox2CP7fpIPNESSE6mFZ1bFEED/MOePL8Q
	Leu6g+6PPLNEj98TlBFQw4L6+QvQSMMuHnv1mA8693dU1HEkyRyKZbRGvWj8ZYJD
	4ZhDoh7hPoGEfxXx5rAr/vBqn7JKft+hQSpNtXvaw1yeYyec2CeK3qONcBRp465l
	hjBK3E6grltsqyJ68UNQify1PmIJQnS3wX8nY92ut7LV6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdvxg8wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:17:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0a3568f4eso606543985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742329055; x=1742933855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdXNdl9Su+hv7nD+r8LRc5/pSIzgMjV1CTk+j9RmE18=;
        b=DWNm0cz7+hxid7/5U7DIXnua1Moc3UTapR2GYQiJ6s7OcIRoXocOAizoJN10w9axbM
         5aS2MSPO+HNV5DbwxTXQWe2wCXv6vPB98Rzsysk/yRa9yUFU6tNnvpOXkg0TNNEHfmVm
         eqm5WGtKURWjgeaSHZkTt5lxtCDO0cfcrlgOXXyx/cwozIKB+5r4zUA0JJFE5ympp6r+
         tDV/qcKJEPNX0cet0S7zgx554hzUQRIn5UUPdJdX+WwVFgtYTsJpvzzWJqnaJgSI/nYT
         TgYt1ejM8D1hQkdxaew/LJpCDGb8GkgkL6HOyNk7hGQY0C468k/fV2fH4MBvhUTPM//I
         Q6fg==
X-Forwarded-Encrypted: i=1; AJvYcCVa7yjmnOAbgirPpjGKm+03XvTPrfVaOmnPtcDZTmK375b9Ecx7VVG4DmpPeW8LI25OMtROtcEW8fAQjeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjYEyX95R0ByKb/Eh/Zp6hTo7J8PR1UMSbzJAOIIX3jB/WlaV
	//tDmjDOJKuT3TT0NxNJpFdo3VLg4FbTjtaQjBnDVdQ+cRHcLeehfGmlqfKqgDVYJp0VUUNyRyh
	3zbT80ZFZEkFdgLXPM1uTSTU8wR8utoRhqqJR3C/pTFciG2xlKdBpY3JztveeJMM=
X-Gm-Gg: ASbGncveB1s1CY75Prn57YkCzAz+dAv60dYWnXTNPbJmeDZlfbLfU1vPZ7oWZ/0Kk/v
	BtFtxlIbAwLighvQZ4pU0/fWDA81VqyuWqaXgWZAd4Mkkx4oB7fTPQcJN7lNDTk4oLBiM+qYZYK
	yp6O85FXsjLMHjRn4qrSenQx2O1MuGDCFbxROWkKIpnRvwwm5hpzMFICAJbpVb0faD5wL2ulffy
	Uaa/hSo6+NQx/DRNhC2SkRe9Wf8jClOjix8dEQiEZbOL1pQ1fzT1GvpuWPZPBvC6c0c67Qi5+zY
	mvPAh2nmrIqGQcWplaX5kL3mSnCh/saLp8q2nrK71GE4pZDEogZd2wXOrbhb1DWBY0aqP/wyxxZ
	q5AY=
X-Received: by 2002:a05:620a:2993:b0:7c5:4c49:7697 with SMTP id af79cd13be357-7c5a8398d4amr915285a.6.1742329054535;
        Tue, 18 Mar 2025 13:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlpAT9MDyX/AOO1fzlAD/dqcC58v9HVJREAU1j0mJpT0fm127HCLDdRwmo/02jgbrejl/TrQ==
X-Received: by 2002:a05:620a:2993:b0:7c5:4c49:7697 with SMTP id af79cd13be357-7c5a8398d4amr909785a.6.1742329054105;
        Tue, 18 Mar 2025 13:17:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1dc0dfsm20650791fa.105.2025.03.18.13.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:17:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:17:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, Harikrishna Shenoy <a0512644@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Harikrishna Shenoy <h-shenoy@ti.com>, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jani.nikula@intel.com, j-choudhary@ti.com,
        sui.jingfeng@linux.dev, viro@zeniv.linux.org.uk, r-ravikumar@ti.com,
        sjakhade@cadence.com, yamonkar@cadence.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: drm/bridge: Add no-hpd property
Message-ID: <aaeklc34t36kokghbvmtmhabyxildajbefhhvtevb2xcs36bcp@lnhjyyiqh6pq>
References: <20250205115025.3133487-1-h-shenoy@ti.com>
 <20250205115025.3133487-2-h-shenoy@ti.com>
 <efd89cf8-2f83-44fd-8bdf-aa348d4d9659@kernel.org>
 <h24gpx6cxm4s6gzcunjnswubtvqask5dewi3udulmntsuieklm@w3pw4ig3t7gm>
 <de0cb22d-d251-4b0b-8fc7-e8b5a891a527@ti.com>
 <vfg6hlkzmqahbswgyctzuuzcdm2aend6wmo3uci4qs74jasjtc@3hlox276hazj>
 <673e79bc-53c9-4772-ad18-8c00e4036905@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673e79bc-53c9-4772-ad18-8c00e4036905@ideasonboard.com>
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=67d9d4e0 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=sozttTNsAAAA:8 a=u89mOchh5nwXCBD-QrQA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: FfJ_Nz-Ozce0yj-P3NfhCr_g2U3BAP4R
X-Proofpoint-GUID: FfJ_Nz-Ozce0yj-P3NfhCr_g2U3BAP4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180147

On Tue, Mar 18, 2025 at 05:49:54PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 12/03/2025 14:52, Dmitry Baryshkov wrote:
> > On Wed, Mar 12, 2025 at 11:56:41AM +0530, Harikrishna Shenoy wrote:
> > > 
> > > 
> > > On 05/02/25 19:03, Dmitry Baryshkov wrote:
> > > > On Wed, Feb 05, 2025 at 12:52:52PM +0100, Krzysztof Kozlowski wrote:
> > > > > On 05/02/2025 12:50, Harikrishna Shenoy wrote:
> > > > > > From: Rahul T R <r-ravikumar@ti.com>
> > > > > > 
> > > > > > The mhdp bridge can work without its HPD pin hooked up to the connector,
> > > > > > but the current bridge driver throws an error when hpd line is not
> > > > > > connected to the connector. For such cases, we need an indication for
> > > > > > no-hpd, using which we can bypass the hpd detection and instead use the
> > > > > > auxiliary channels connected to the DP connector to confirm the
> > > > > > connection.
> > > > > > So add no-hpd property to the bindings, to disable hpd when not
> > > > > > connected or unusable due to DP0-HPD not connected to correct HPD
> > > > > > pin on SOC like in case of J721S2.
> > > > > > 
> > > > > > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > > > > 
> > > > > Why are you sending over and over the same? You already got feedback.
> > > > > Then you send v2. You got the same feedback.
> > > > > 
> > > > > Now you send v3?
> > > > > 
> > > > > So the same feedback, but this time: NAK
> > > > 
> > > > Krzysztof's email forced me to take a look at the actual boards that you
> > > > are trying to enable. I couldn't stop by notice that the HPD signal
> > > > _is_ connected to a GPIO pin. Please stop hacking the bridge driver and
> > > > use the tools that are already provided to you: add the HPD pin to the
> > > > dp-controller device node. And then fix any possible issues coming from
> > > > the bridge driver not being able to handle HPD signals being delivered
> > > > by the DRM framework via the .hpd_notify() callback.
> > > > 
> > > > TL;DR: also a NAK from my side, add HPD gpio to dp-controller.
> > > > 
> > > We tried implementing a interrupt based HPD functionality as HPD signal is
> > > connected to GPIO0_18 pin, we were able to get interrupt based HPD working
> > > however to route this signal to SoC we are loosing audio capability due to
> > > MUX conflict. Due to board level limitations to
> > > route the signal to SoC, we will not be able to support interrupt
> > > based HPD and polling seems a possible way without loosing on audio
> > > capability.
> > 
> > Still NAK for the no-hpd property. HPD pin is a requirement for
> > DisplayPort to work, as it is used e.g. for the 'attention' IRQs being
> > sent by the DP sink. I'm not sure what kind of idea you HW engineers had
> > in mind.
> 
> It's true that for normal DP functionality the HPD is required, but afaik DP
> works "fine" without HPD too. This is not the first board that has DP
> connector, but doesn't have HPD, that I have seen or worked on. Polling can
> be used for the IRQs too.

Just out of curiosity, is there a DP host / bridge that provide polling
for short HPD pulses (aka attention)?

> For eDP HPD is optional, and some of the cases I've worked with involved a
> chip intended for eDP, but used with a full DP connector, and no HPD.
> However, in this particular case the DP chip supports full DP, so it's just
> a board design error.

In such a case, if I'm not mistaken, the no-hpd is a part of the panel
interface rather than the eDP source. I see that SN65DSI86 has the
no-hpd property, but if I understood Doug correctly it is used to change
bridge's configuration rather than just skip the HPD processing.

> My question is, is J721s2 EVM something that's used widely? Or is it a rare
> board? If it's a rare one, maybe there's no point in solving this in
> upstream? But if it's widely used, I don't see why we wouldn't support it in
> upstream. The HW is broken, but we need to live with it.
> 
> Another question is, if eDP support is added to the cdns-mhdp driver, and
> used with a panel that doesn't have an HPD, how would that code look like?
> If that would be solved with a "no-hpd" property, identical to the one
> proposed in this series, then... There's even less reason to not support
> this.
> 
> Disclaimer: I didn't study the schematics, and I haven't thought or looked
> at how eDP is implemented in other drm drivers.

I hope that Doug can comment on eDP side. On the schematics side, there
a multi-pin mux, which switches several GPIO pins. One of the positions
of the mux is useful for audio connection. Unfortunately, DP HPD pin
gets connected in a different mux positition.


-- 
With best wishes
Dmitry


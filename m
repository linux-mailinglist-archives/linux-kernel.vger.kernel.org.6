Return-Path: <linux-kernel+bounces-560890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F0A60AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA15017FA3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB018B482;
	Fri, 14 Mar 2025 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wxomz06J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88618A6D7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939190; cv=none; b=sVvHHxRJtLQxclA961dcLsLiQLLxa4kntGTxZdaYJ0wa1aepKHwZMSDaKK+IVowDhF/xPa4PksWEKLaq6DnuUE30Ti5ZBxGFzqNNNx1RnhEc6jFu9BjBUXRFRAC3Z/Chb8hn5WVsED+IuSR1gjsAEcaqyUw8i6KX8LfqFCREHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939190; c=relaxed/simple;
	bh=Vnc+9eqHgg1hXCSFPz0D+FANED1Y0ebhXao407EN1lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaYuYciN+cmY21gWoCjezSgx7NCMS6AR2RADVwypQXkMVfOQvXywHOxWTlp5gpRQuEiL0LvnZiM0H867TzW/EVM3gWVkcP4smDUTzLMcyAqUm56FgrrFW6HD63Ltntdi8zI+w51wrJXQj5UcNah/64bEaBgMWDfcWFVGF3LXKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wxomz06J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E0UcUJ015350
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vvw4eKXJ6wNaHxroz0eN8J6N
	Mv+xNQdmVQhwRTQrNl0=; b=Wxomz06Jec/B5GMIVTlVWWLNmscF7wsk7WYfK49r
	fTlSGzYa9iq7lTuNhPMYbzXNXPPP+XtB5zx9X738XSUy9iHKrCNKEEX0kmui5egP
	rIPZZ3jBrNBDfD4DskRSjjSIERRm4KVbnwstIwCY2BnoE9NRtmQWAm+/KvClY167
	JFpjb4XsZfcbAoKUJpSlpU/bUY777GgeuA1UhlqY5542ZLeu8XBkPZcFGqnZOKfo
	3dsNARhaJd0AKV3ii9llwbWj5ywsOohMh8lSqNpTxQhRxvdUUoynPBy6vUR/Vao+
	Fy3m2J67wowakaFLLETXuWqOLZNPeLvPQUwtfEFpb6gbow==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p0fn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:59:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f184b916so54349616d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939186; x=1742543986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvw4eKXJ6wNaHxroz0eN8J6NMv+xNQdmVQhwRTQrNl0=;
        b=gwbfYXb+2MgZBfBAoL0nAqzc5v67Rk4FV1ZvNepWalPVTvLy+hv7yOrISyAMAC03aD
         K7juyufBLFRz/O0bQGQjT9t8Nn3h/NE9UrNb7FQbxrTG4CxwhZD7LHMbCatZ9ZUQ5kVO
         GyVhjOEAQm/3nVLwz9qG4WFD0YsHmGSyMEAGV46sYnSMy2SwJ+WMlb0wCf0uk1oB/Xyd
         OtExB3tfcg+r8nPHJiLlBLAr1Ot1GoLTR/hCqOa4oMKRUlr8+P2pLwtFWbjZgkLafl2N
         cKyYGidNQM/V3ntepVk6y9MdLNAQZ7X/J89QGWAD+ex6udx4xkx8TptBRAnClNFNDiFj
         ydiA==
X-Forwarded-Encrypted: i=1; AJvYcCX+uLEBZ/uoMQU8hU6aRF8BTyhTdrf8T7SkBSQOvRRuIaDoWCUqI+LjZ1xKMaJMlZoPrFudSWcMrFnJKZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkr4gXezKbBGbz0boZdQ3HckAfTFmmcJzZaqfWuM3GQiDvad/
	txWFjrfbZ+Jz4pKiTqISN9fFvsyP42S91uJw1mIitTEtwuNiSXWVgLtvqUclLJxCtlJfdR/dn2A
	fht7L1Q4RdNlJvUJzZCGQhCiOys2y6FogoNbq7KH0MGZ9qA3bSWukE6sCBRIYn5g=
X-Gm-Gg: ASbGnctpiFCO0qdsL4cqAIf1m9Qh57dGU5ecPdOcft/NHLJx9EDQmPE8MYzIGCucL5p
	AVK+XHb/geE/OY1zzrCEo4MFfvUIbfFEGQYDvXx7gA6WTuQz/yfj9pQ399yNhDQmeT16Wuphq6i
	IRbHtv9mHOf4aNVL019XL5dCkvyY5N03TFHa75DeNFw1MAD7tDpfh0Q9yAAuKbG+x9ES97HbfhX
	tvc9nG5MbDp5IkrDuSJigvnhnZQ73zwjXJ8eQKY1EECJ7otz7BI7jTIQ8M+dCrd/3ngPO5nbJF4
	npuMQ91/tstUb6oQFIwgHgyZqizVZOnAgQNmJvv7sBbHlXtjjThE+T/71QrrGC4SYAOfdWvIYbW
	12PI=
X-Received: by 2002:a05:6214:202b:b0:6e8:fa38:46aa with SMTP id 6a1803df08f44-6eaeaa9d01cmr18356446d6.33.1741939186306;
        Fri, 14 Mar 2025 00:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0YAlRWy8800OjSsrbp32LjdUoPNIM4o/DAoQDnAA2klfsjE8hv60FQ4NOavyJqzR8LMOuhw==
X-Received: by 2002:a05:6214:202b:b0:6e8:fa38:46aa with SMTP id 6a1803df08f44-6eaeaa9d01cmr18354776d6.33.1741939181813;
        Fri, 14 Mar 2025 00:59:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0fff95sm4842241fa.47.2025.03.14.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:59:39 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:59:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andy Yan <andyshrk@163.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Herve Codina <herve.codina@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Simona Vetter <simona.vetter@ffwll.ch>, lumag@kernel.org
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <lf4wu5v3wym3foqgimuulyzz2dmd2jezkj3otn7xm7xp77nast@azqmajrn45lw>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
 <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
 <5180089f.a640.19566290538.Coremail.andyshrk@163.com>
 <608c01c.7716.1958e8d879f.Coremail.andyshrk@163.com>
 <20250313-dazzling-deer-of-ampleness-21db67@houat>
 <6ae1c567.8c6.195922195d6.Coremail.andyshrk@163.com>
 <k2md4q2tgwsdynaeljieqlzjdds677wqqduimfyrgmvyfi732a@vh3dbg7kdaop>
 <20250314-courageous-bison-of-prestige-8b884b@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-courageous-bison-of-prestige-8b884b@houat>
X-Proofpoint-GUID: JmScak6NJxwmYXYTcHKEBWnkjiHJykUF
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d3e1f3 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Byx-y9mGAAAA:8 a=KKAkSRfTAAAA:8 a=mIiqAcDFwn3wS4I_vpsA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JmScak6NJxwmYXYTcHKEBWnkjiHJykUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140062

On Fri, Mar 14, 2025 at 08:45:17AM +0100, Maxime Ripard wrote:
> On Fri, Mar 14, 2025 at 07:52:35AM +0200, Dmitry Baryshkov wrote:
> > On Fri, Mar 14, 2025 at 08:50:29AM +0800, Andy Yan wrote:
> > > 
> > > Hi Maxime and Simona,
> > > 
> > > 
> > > At 2025-03-13 19:55:33, "Maxime Ripard" <mripard@kernel.org> wrote:
> > > >Hi,
> > > >
> > > >On Thu, Mar 13, 2025 at 04:09:54PM +0800, Andy Yan wrote:
> > > >> At 2025-03-05 19:55:19, "Andy Yan" <andyshrk@163.com> wrote:
> > > >> >At 2025-03-04 19:10:47, "Maxime Ripard" <mripard@kernel.org> wrote:
> > > >> >>With the bridges switching over to drm_bridge_connector, the direct
> > > >> >>association between a bridge driver and its connector was lost.
> > > >> >>
> > > >> >>This is mitigated for atomic bridge drivers by the fact you can access
> > > >> >>the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
> > > >> >>drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> > > >> >>
> > > >> >>This was also made easier by providing drm_atomic_state directly to all
> > > >> >>atomic hooks bridges can implement.
> > > >> >>
> > > >> >>However, bridge drivers don't have a way to access drm_atomic_state
> > > >> >>outside of the modeset path, like from the hotplug interrupt path or any
> > > >> >>interrupt handler.
> > > >> >>
> > > >> >>Let's introduce a function to retrieve the connector currently assigned
> > > >> >>to an encoder, without using drm_atomic_state, to make these drivers'
> > > >> >>life easier.
> > > >> >>
> > > >> >>Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > >> >>Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> > > >> >>Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > >> >>---
> > > >> >> drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > > >> >> include/drm/drm_atomic.h     |  3 +++
> > > >> >> 2 files changed, 48 insertions(+)
> > > >> >>
> > > >> >>diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > > >> >>index 9ea2611770f43ce7ccba410406d5f2c528aab022..b926b132590e78f8d41d48eb4da4bccf170ee236 100644
> > > >> >>--- a/drivers/gpu/drm/drm_atomic.c
> > > >> >>+++ b/drivers/gpu/drm/drm_atomic.c
> > > >> >>@@ -985,10 +985,55 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
> > > >> >> 
> > > >> >> 	return NULL;
> > > >> >> }
> > > >> >> EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
> > > >> >> 
> > > >> >>+/**
> > > >> >>+ * drm_atomic_get_connector_for_encoder - Get connector currently assigned to an encoder
> > > >> >>+ * @encoder: The encoder to find the connector of
> > > >> >>+ * @ctx: Modeset locking context
> > > >> >>+ *
> > > >> >>+ * This function finds and returns the connector currently assigned to
> > > >> >>+ * an @encoder.
> > > >> >>+ *
> > > >> >>+ * Returns:
> > > >> >>+ * The connector connected to @encoder, or an error pointer otherwise.
> > > >> >>+ * When the error is EDEADLK, a deadlock has been detected and the
> > > >> >>+ * sequence must be restarted.
> > > >> >>+ */
> > > >> >>+struct drm_connector *
> > > >> >>+drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
> > > >> >>+				     struct drm_modeset_acquire_ctx *ctx)
> > > >> >>+{
> > > >> >>+	struct drm_connector_list_iter conn_iter;
> > > >> >>+	struct drm_connector *out_connector = ERR_PTR(-EINVAL);
> > > >> >>+	struct drm_connector *connector;
> > > >> >>+	struct drm_device *dev = encoder->dev;
> > > >> >>+	int ret;
> > > >> >>+
> > > >> >>+	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> > > >> >>+	if (ret)
> > > >> >>+		return ERR_PTR(ret);
> > > >> >
> > > >> >It seems that this will cause a deadlock when called from a  hotplug handling path,
> > > >> >I have a WIP DP diver[0],  which suggested by Dmitry to use this API from a 
> > > >> >&drm_bridge_funcs.detect callback to get the connector,  as detect is called by drm_helper_probe_detect,
> > > >> >which will hold connection_mutex first, so the deaklock happens:
> > > >> >
> > > >> >
> > > >> >drm_helper_probe_detect(struct drm_connector *connector,
> > > >> >                        struct drm_modeset_acquire_ctx *ctx,
> > > >> >                        bool force)
> > > >> >{
> > > >> >        const struct drm_connector_helper_funcs *funcs = connector->helper_private;
> > > >> >        struct drm_device *dev = connector->dev;
> > > >> >        int ret;
> > > >> >
> > > >> >        if (!ctx)
> > > >> >                return drm_helper_probe_detect_ctx(connector, force);
> > > >> >
> > > >> >        ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> > > >> >        if (ret)
> > > >> >                return ret;
> > > >> >
> > > >> >        if (funcs->detect_ctx)
> > > >> >                ret = funcs->detect_ctx(connector, ctx, force);
> > > >> >        else if (connector->funcs->detect)
> > > >> >                ret = connector->funcs->detect(connector, force);
> > > >> >        else
> > > >> >                ret = connector_status_connected;
> > > >> >
> > > >> >        if (ret != connector->status)
> > > >> >                connector->epoch_counter += 1;
> > > >> >
> > > >> >So I wonder can we let drm_bridge_funcs.detect pass a connector for this case ?
> > > >> >
> > > >> >
> > > >> >
> > > >> >[0]https://lore.kernel.org/linux-rockchip/047EECFC-7E55-44EC-896F-13FE04333E4D@gmail.com/T/#m25bc53b79f5cc7bddfcb7aae5656f68df396f094
> > > >> >>+
> > > >> >>+	drm_connector_list_iter_begin(dev, &conn_iter);
> > > >> >>+	drm_for_each_connector_iter(connector, &conn_iter) {
> > > >> >>+		if (!connector->state)
> > > >> >>+			continue;
> > > >> >>+
> > > >> >>+		if (encoder == connector->state->best_encoder) {
> > > >> >>+			out_connector = connector;
> > > >> 
> > > >> 
> > > >> When try to use this patch in my bridge driver,  I found that the connector->state->best_encoder 
> > > >>  maybe NULL when   drm_bridge_funcs.detect or drm_bridge_funcs.detect_ctx is  called:
> > > >> 
> > > >> [   52.713030] Invalid return value -22 for connector detection
> > > >> [   52.713539] WARNING: CPU: 7 PID: 288 at drivers/gpu/drm/drm_probe_helper.c:602 drm_helper_probe_single_connector_modes+0x5e0/
> > > >> 0x63c
> > > >> [   52.714568] Modules linked in:
> > > >> 
> > > >> [   52.724546] Call trace:
> > > >> [   52.724762]  drm_helper_probe_single_connector_modes+0x5e0/0x63c (P)
> > > >> [   52.725319]  drm_mode_getconnector+0x2a4/0x488
> > > >> [   52.725711]  drm_ioctl_kernel+0xb4/0x11c
> > > >> [   52.726057]  drm_ioctl+0x22c/0x544
> > > >> [   52.726358]  __arm64_sys_ioctl+0xac/0xe0
> > > >> [   52.726706]  invoke_syscall+0x44/0x100
> > > >> [   52.727039]  el0_svc_common.constprop.0+0x3c/0xd4
> > > >> 
> > > >> This is because  best_encoder is set by set_best_encoder, which is called from
> > > >> drm_atomic_helper_check_modeset. When we call drm_mode_getconnector 
> > > >> for the first time, the functions mentioned above have not been called yet,
> > > >> then we can't match the encoder from connector->state->best_encoder for this case.
> > > >
> > > >As far as I'm concerned, it's by design. Encoders and connectors have
> > > >1:N relationship, and only once a connector has been enabled it has an
> > > >encoder.
> > > >
> > > >If the connector is disabled, there's no associated encoder.
> > > 
> > > Does this prove that this API is not suitable for my application scenario: 
> > > Get the connector in the bridge's .detect callback, so this means that I may
> > > still need to modify the bridge's connector callback so that it can pass the connector ?
> > 
> > I'd say, yes, please.
> 
> And I'd say no :)

Fair enough :-)

> There's no reason to deviate from the API other entities have here. It's
> just that the switch to DRM_BRIDGE_ATTACH_NO_CONNECTOR hasn't been
> completely thought through and it's one of the part where it shows.
> 
> We have two alternative solutions: Either the driver creates the
> connector itself, since it doesn't seem to use any downstream bridge
> anyway, or we need a new bridge helper to find the connector on a bridge
> chain.
> 
> We have the iterator already, we just need a new accessor to retrieve
> the (optional) connector of a bridge, and if there's none, go to the
> next bridge and try again.

The problem is that there is no guarantee that the the created connector
is created for or linked to any bridge. For example, for msm driver I'm
waiting for several series to go in, but after that I plan to work on
moving connector creation to the generic code within the msm driver.

In other words, with DRM_BRIDGE_ATTACH_NO_CONNECTOR in place it is
perfectly legit not to have a bridge which has "connector of a bridge".
It is possible to create drm_bridge_connector on the drm_encoder's side
after the drm_bridge_attach() succeeds.

> There's a decent amount of variations that ideally call for tests too,
> but it should be pretty simple overall.

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-434791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E60AC9E6B67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC51884EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67721F8F1F;
	Fri,  6 Dec 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kdgn4Xh5"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015231F6691
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479958; cv=none; b=hANig0WoNWfYm7VniHm7pjjwweqcUt5CKgxr5WwSQFORv5wNoLcK89vI40LS2HImLxZ4JP1y7a7qIdW4xkULqznhFYsVrEJXN/xYl56kGGYm2+LrMuA0EXoUw+HCaD5oD24yAa+whOm9EZOZAkSme9bew+jx2HRjR34ChODdohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479958; c=relaxed/simple;
	bh=js6nm4V8Cp5fzVPi9ySnwrCZFS/ehKB6J0t5QFO1OzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i09FJNI3JDEy2GYp/hrJ1uBo/7m7lgETD3dSx5Ff6yCrMh2PNP94wLErKJ5KfKXnt71bcFm+ktnyoZMlTs00dn4I/fYj3le4csNE2r1m/UCcTz0JDzzTR51vr3/r3ckj7tEcXC63YmfUX6VQYaboAPmCYZ2MFVQyHOKWYayT6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kdgn4Xh5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so15709891fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733479953; x=1734084753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pdQlVUVoYFeHvG7EmBsOjseHHWqsjVKlG64Crc+IonQ=;
        b=Kdgn4Xh5gg2Y9k+k7ncxU4MHykfv7oJrMCsGC0ROlxpHaKDUmWahrIyUAHDhOsY/oD
         qwNItcpYqbjs191O1tvFdz3z/OZX46mXmkgCdEw7yt2S2eZxjR2/Wydsv4K5GeQCyHNN
         hiAXiUzvLqL+WuTwP4Y6EjXZAXlO/HUlFlPTE+WqP5ecs+RpjrIi9ecFNckzRV2G8SUW
         wRTivN/AVHNlNOKPKPZAqGNEE8Xkr4/Wk92B7mxfblr7HgadqJsF8JBnccjqUKv9XvWZ
         tNfV+spHCHwYXyDV2Sm7InXFc1Au1xOLFPTIT6rtsLrglFjtQmISZ/Di+cPyAXhCkqZE
         mJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733479953; x=1734084753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdQlVUVoYFeHvG7EmBsOjseHHWqsjVKlG64Crc+IonQ=;
        b=Ijq5WNN0l8iCg8yN4GHa79pU4KHWPfqD7nKlAQVeLNrG2cZ52WAi6PB/FWdFUaKqpd
         YlDSulNxYD2jxzUDdQcvYBvq2Hf+gUu3MJVcUert6RuAIvdbpY7PdB39/HyNd8dI3CA+
         LBYKiZQKNcyyCZazqJ1m76JUyPnJf7yE8DmlpnH/Ejv2ow98NREtREWS+4IvP+EWAJ/u
         PH/i1tcwjS7dp4Ggi3ERHzf3cLquHitZNWS6qxCMCdY0Ygys3FWmlqPe+6SpLReqotk7
         gFjZth8OU6fBsbzEJKIBC08EH+CVadUK7hHXZ1FzMI8JeFIiGipfH16x0GYugTYjaC2R
         Odsg==
X-Forwarded-Encrypted: i=1; AJvYcCUYk/JCVuIn7ofIMghZLk178PL2ESq5MMdADrNDmLhXxXlg25aAkK0lMIcWfxwdMgZooCnN6A7stjtiFlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIysySC0VZb+Yf2V5kah8D8F9CsDOvbBhiXbHDy/IfEsR0jtI
	hVdMvO2Oz/jhbihFR6aD6Nn3fM2+2tqropgcc2ge9GlGFsjjWuKzNjmRihdzqWQ=
X-Gm-Gg: ASbGncsmqwWRlrOFslKR9d7oetBM/ryOLZAXU2nZvWKP4ps3rpykAF9cmGD0ifi5sDv
	5RkyQPyqar9uTPeH22oF2XNR4ePNTpZaUR8gYc7mGcPwkUBc0lKFkRcrnVnt13N4CqTbQvgtKfV
	6KKn3Q//SmxLBI780vmrJCjIlYYBxOtfMyn9X5iB9v7pNXMtyACTpj8kR7LVsIddihH5RRjgkZt
	yQDdju8zHm2rqiXCFIsH4epMnZQb776KQQkKYGsxFlUpe+8De9urmMGsgMy4oldi5Cnr/FoAdpn
	9UOaaj765n9g5NBrRrl5pDDHFY4/qg==
X-Google-Smtp-Source: AGHT+IEyZSvPL3mzmowHJHRfcFnZqMzovXVw5afrre7v6w1xeHTTmWEyWuLQ4pxK5xrsOcPrkW46Qw==
X-Received: by 2002:a2e:b8c1:0:b0:300:1699:6e9a with SMTP id 38308e7fff4ca-3002fc95ca2mr6843341fa.35.1733479952926;
        Fri, 06 Dec 2024 02:12:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30035db98d9sm691531fa.37.2024.12.06.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 02:12:31 -0800 (PST)
Date: Fri, 6 Dec 2024 12:12:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 31/45] drm/msm/dp: add dp_mst_drm to manage DP MST bridge
 operations
Message-ID: <4unizv5vi7ve7qdpzmcxj6vvxwxrpcppg3y72csi7ga2jqwhrm@5eu74nuopyqf>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-31-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205-dp_mst-v1-31-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:02PM -0800, Abhinav Kumar wrote:
> Add a new file dp_mst_drm to manage the DP MST bridge operations
> similar to the dp_drm file which manages the SST bridge operations.
> Each MST encoder creates one bridge and each bridge is bound to its
> own dp_panel abstraction to manage the operations of its pipeline.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/Makefile        |   3 +-
>  drivers/gpu/drm/msm/dp/dp_display.h |   2 +
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 490 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h | 102 ++++++++
>  4 files changed, 596 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index f274d9430cc311405f890074c1466ffe2ec45ac9..b1e01b3123d9afc4818f059c5d4e7ca70dca3754 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -142,7 +142,8 @@ msm-display-$(CONFIG_DRM_MSM_DP)+= dp/dp_aux.o \
>  	dp/dp_link.o \
>  	dp/dp_panel.o \
>  	dp/dp_audio.o \
> -	dp/dp_utils.o
> +	dp/dp_utils.o \
> +	dp/dp_mst_drm.o
>  
>  msm-display-$(CONFIG_DRM_MSM_HDMI_HDCP) += hdmi/hdmi_hdcp.o
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 6ab14e969bce0fd07b3a550bae17e99652479232..a5d4893f689c6afbbe622c9b7dfa98d23d754831 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -7,6 +7,7 @@
>  #define _DP_DISPLAY_H_
>  
>  #include "dp_panel.h"
> +#include "dp_mst_drm.h"
>  #include <sound/hdmi-codec.h>
>  #include "disp/msm_disp_snapshot.h"
>  
> @@ -26,6 +27,7 @@ struct msm_dp {
>  	bool is_edp;
>  	bool internal_hpd;
>  
> +	struct msm_dp_mst *msm_dp_mst;
>  	hdmi_codec_plugged_cb plugged_cb;
>  
>  	struct msm_dp_audio *msm_dp_audio;
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e66bd1e565aeb4da3d636eb5f4aa75504d60fd40
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/*
> + * Copyright � 2014 Red Hat.
> + *
> + * Permission to use, copy, modify, distribute, and sell this software and its
> + * documentation for any purpose is hereby granted without fee, provided that
> + * the above copyright notice appear in all copies and that both that copyright
> + * notice and this permission notice appear in supporting documentation, and
> + * that the name of the copyright holders not be used in advertising or
> + * publicity pertaining to distribution of the software without specific,
> + * written prior permission.  The copyright holders make no representations
> + * about the suitability of this software for any purpose.  It is provided "as
> + * is" without express or implied warranty.
> + *
> + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
> + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
> + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
> + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
> + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
> + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
> + * OF THIS SOFTWARE.
> + */
> +
> +#include "dp_mst_drm.h"
> +
> +static struct drm_private_state *msm_dp_mst_duplicate_bridge_state(struct drm_private_obj *obj)
> +{
> +	struct msm_dp_mst_bridge_state *state;
> +
> +	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return NULL;
> +
> +	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
> +
> +	return &state->base;
> +}
> +
> +static void msm_dp_mst_destroy_bridge_state(struct drm_private_obj *obj,
> +					    struct drm_private_state *state)
> +{
> +	struct msm_dp_mst_bridge_state *priv_state =
> +		to_msm_dp_mst_bridge_priv_state(state);
> +
> +	kfree(priv_state);
> +}
> +
> +static const struct drm_private_state_funcs msm_dp_mst_bridge_state_funcs = {
> +	.atomic_duplicate_state = msm_dp_mst_duplicate_bridge_state,
> +	.atomic_destroy_state = msm_dp_mst_destroy_bridge_state,
> +};
> +
> +/**
> + * dp_mst_find_vcpi_slots() - Find VCPI slots for this PBN value
> + * @mgr: manager to use
> + * @pbn: payload bandwidth to convert into slots.
> + *
> + * Calculate the number of VCPI slots that will be required for the given PBN
> + * value.
> + *
> + * RETURNS:
> + * The total slots required for this port, or error.
> + */
> +static int msm_dp_mst_find_vcpi_slots(struct drm_dp_mst_topology_mgr *mgr, int pbn)
> +{
> +	int num_slots;
> +	struct drm_dp_mst_topology_state *state;
> +
> +	state = to_drm_dp_mst_topology_state(mgr->base.state);
> +	num_slots = DIV_ROUND_UP(pbn, dfixed_trunc(state->pbn_div));

drm_dp_atomic_find_time_slots() uses slightly different maths here, with
the different precision. Can we use the data that is set by that function
instead (payload->time_slots)?

> +
> +	/* max. time slots - one slot for MTP header */
> +	if (num_slots > 63)
> +		return -ENOSPC;
> +	return num_slots;
> +}
> +
> +static void _msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
> +					 struct msm_dp_mst_bridge *mst_bridge,
> +					 struct drm_dp_mst_port *port)
> +{
> +	int i;
> +	struct msm_dp_mst_bridge *msm_dp_bridge;
> +	struct drm_dp_mst_topology_state *mst_state;
> +	struct drm_dp_mst_atomic_payload *payload;
> +	int prev_start = 0;
> +	int prev_slots = 0;
> +
> +	mst_state = to_drm_dp_mst_topology_state(mst->mst_mgr.base.state);
> +	payload = drm_atomic_get_mst_payload_state(mst_state, port);
> +
> +	if (!payload) {
> +		DRM_ERROR("mst bridge [%d] update_timeslots failed, null payload\n",
> +			  mst_bridge->id);
> +		return;
> +	}
> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		msm_dp_bridge = &mst->mst_bridge[i];
> +		if (mst_bridge == msm_dp_bridge) {
> +			/*
> +			 * When a payload was removed make sure to move any payloads after it
> +			 * to the left so all payloads are aligned to the left.
> +			 */

Please don't. drm_dp_remove_payload_part2() should take care of that for
us. What is the reason for caching the data if we have to manually
handle the cache?

> +			if (payload->vc_start_slot < 0) {
> +				// cache the payload
> +				prev_start = msm_dp_bridge->start_slot;
> +				prev_slots = msm_dp_bridge->num_slots;
> +				msm_dp_bridge->pbn = 0;
> +				msm_dp_bridge->start_slot = 1;
> +				msm_dp_bridge->num_slots = 0;
> +				msm_dp_bridge->vcpi = 0;
> +			} else { //add payload
> +				msm_dp_bridge->pbn = payload->pbn;
> +				msm_dp_bridge->start_slot = payload->vc_start_slot;
> +				msm_dp_bridge->num_slots = payload->time_slots;
> +				msm_dp_bridge->vcpi = payload->vcpi;
> +			}
> +		}
> +	}
> +
> +	// Now commit all the updated payloads
> +	for (i = 0; i < mst->max_streams; i++) {
> +		msm_dp_bridge = &mst->mst_bridge[i];
> +
> +		//Shift payloads to the left if there was a removed payload.
> +		if (payload->vc_start_slot < 0 && msm_dp_bridge->start_slot > prev_start)
> +			msm_dp_bridge->start_slot -= prev_slots;
> +
> +		msm_dp_display_set_stream_info(mst->msm_dp, msm_dp_bridge->msm_dp_panel,
> +					       msm_dp_bridge->id, msm_dp_bridge->start_slot,
> +					       msm_dp_bridge->num_slots,
> +					       msm_dp_bridge->pbn, msm_dp_bridge->vcpi);
> +		drm_dbg_dp(mst->msm_dp->drm_dev,
> +			   "conn:%d vcpi:%d start_slot:%d num_slots:%d, pbn:%d\n",
> +			   DP_MST_CONN_ID(msm_dp_bridge), msm_dp_bridge->vcpi,
> +			   msm_dp_bridge->start_slot,
> +			   msm_dp_bridge->num_slots, msm_dp_bridge->pbn);
> +	}
> +}
> +
> +static int _msm_dp_mst_bridge_pre_enable_part1(struct msm_dp_mst_bridge *dp_bridge,
> +					       struct drm_bridge_state *bridge_state)
> +{
> +	struct msm_dp *msm_dp = dp_bridge->display;
> +	struct msm_dp_mst *mst = msm_dp->msm_dp_mst;
> +	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(dp_bridge->connector);
> +	struct drm_dp_mst_port *port = mst_conn->mst_port;
> +	struct drm_dp_mst_topology_state *mst_state;
> +	struct drm_dp_mst_atomic_payload *payload;
> +	struct msm_dp_panel *dp_panel = mst_conn->dp_panel;
> +	int pbn, slots;
> +	int rc = 0;
> +
> +	mst_state = drm_atomic_get_new_mst_topology_state(bridge_state->base.state,
> +							  &mst->mst_mgr);
> +
> +	pbn = drm_dp_calc_pbn_mode(dp_panel->msm_dp_mode.drm_mode.clock,
> +				   (mst_conn->connector.display_info.bpc * 3) << 4);
> +
> +	slots = msm_dp_mst_find_vcpi_slots(&mst->mst_mgr, pbn);
> +
> +	drm_dbg_dp(msm_dp->drm_dev, "conn:%d pbn:%d, slots:%d\n", DP_MST_CONN_ID(dp_bridge),
> +		   pbn, slots);
> +
> +	payload = drm_atomic_get_mst_payload_state(mst_state, port);
> +	if (!payload || payload->time_slots <= 0) {
> +		DRM_ERROR("time slots not allocated for conn:%d\n", DP_MST_CONN_ID(dp_bridge));
> +		rc = -EINVAL;
> +		return rc;
> +	}
> +
> +	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
> +
> +	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
> +	if (rc) {
> +		DRM_ERROR("payload allocation failure for conn:%d\n", DP_MST_CONN_ID(dp_bridge));
> +		return rc;
> +	}
> +
> +	_msm_dp_mst_update_timeslots(mst, dp_bridge, port);
> +
> +	return rc;
> +}
> +
> +static void _msm_dp_mst_bridge_pre_enable_part2(struct msm_dp_mst_bridge *dp_bridge,
> +						struct drm_bridge_state *bridge_state)
> +{
> +	struct msm_dp *msm_dp = dp_bridge->display;
> +	struct msm_dp_mst *mst = msm_dp->msm_dp_mst;
> +	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(dp_bridge->connector);
> +	struct drm_dp_mst_port *port = mst_conn->mst_port;
> +	struct drm_dp_mst_topology_state *mst_state;
> +	struct drm_dp_mst_atomic_payload *payload;
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);
> +
> +	mst_state = to_drm_dp_mst_topology_state(mst->mst_mgr.base.state);
> +	payload = drm_atomic_get_mst_payload_state(mst_state, port);
> +
> +	if (!payload) {
> +		DRM_ERROR("mst bridge [%d] null payload\n", dp_bridge->id);
> +		return;
> +	}
> +
> +	if (!payload->port) {
> +		DRM_ERROR("mst bridge [%d] null port\n", dp_bridge->id);
> +		return;
> +	}
> +
> +	if (!payload->port->connector) {
> +		DRM_ERROR("mst bridge [%d] part-2 failed, null connector\n",
> +			  dp_bridge->id);
> +		return;
> +	}
> +
> +	if (payload->vc_start_slot == -1) {
> +		DRM_ERROR("mst bridge [%d] part-2 failed, payload alloc part 1 failed\n",
> +			  dp_bridge->id);
> +		return;
> +	}
> +
> +	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
> +
> +	drm_dbg_dp(msm_dp->drm_dev, "mst bridge [%d] _pre enable part-2 complete\n",
> +		   dp_bridge->id);
> +}
> +
> +static void _msm_dp_mst_bridge_pre_disable_part1(struct msm_dp_mst_bridge *dp_bridge,
> +						 struct drm_bridge_state *bridge_state)
> +{
> +	struct msm_dp *msm_dp = dp_bridge->display;
> +	struct msm_dp_mst *mst = msm_dp->msm_dp_mst;
> +	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(dp_bridge->connector);
> +	struct drm_dp_mst_port *port = mst_conn->mst_port;
> +	struct drm_dp_mst_topology_state *old_mst_state;
> +	struct drm_dp_mst_topology_state *new_mst_state;
> +	const struct drm_dp_mst_atomic_payload *old_payload;
> +	struct drm_dp_mst_atomic_payload *new_payload;
> +
> +	old_mst_state = drm_atomic_get_old_mst_topology_state(bridge_state->base.state,
> +							      &mst->mst_mgr);
> +
> +	new_mst_state = drm_atomic_get_new_mst_topology_state(bridge_state->base.state,
> +							      &mst->mst_mgr);
> +
> +	old_payload = drm_atomic_get_mst_payload_state(old_mst_state, port);
> +	new_payload = drm_atomic_get_mst_payload_state(new_mst_state, port);
> +
> +	if (!old_payload || !new_payload) {
> +		DRM_ERROR("mst bridge [%d] _pre disable part-1 failed, null payload\n",
> +			  dp_bridge->id);
> +		return;
> +	}
> +
> +	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
> +	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
> +
> +	_msm_dp_mst_update_timeslots(mst, dp_bridge, port);
> +
> +	drm_dbg_dp(msm_dp->drm_dev, "mst bridge [%d] _pre disable part-1 complete\n",
> +		   dp_bridge->id);
> +}
> +
> +static void _msm_dp_mst_bridge_pre_disable_part2(struct msm_dp_mst_bridge *dp_bridge)
> +{
> +	struct msm_dp *msm_dp = dp_bridge->display;
> +	struct msm_dp_mst *mst = msm_dp->msm_dp_mst;
> +
> +	drm_dp_check_act_status(&mst->mst_mgr);
> +
> +	drm_dbg_dp(msm_dp->drm_dev, "mst bridge [%d] _pre disable part-2 complete\n",
> +		   dp_bridge->id);
> +}
> +
> +static void msm_dp_mst_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
> +						struct drm_bridge_state *old_bridge_state)
> +{
> +	int rc = 0;
> +	struct msm_dp_mst_bridge *bridge;
> +	struct msm_dp *dp;
> +	struct msm_dp_mst_bridge_state *msm_dp_bridge_state;
> +
> +	if (!drm_bridge) {
> +		DRM_ERROR("Invalid params\n");
> +		return;
> +	}
> +
> +	bridge = to_msm_dp_mst_bridge(drm_bridge);
> +	msm_dp_bridge_state = to_msm_dp_mst_bridge_state(bridge);
> +	dp = bridge->display;
> +
> +	/* to cover cases of bridge_disable/bridge_enable without modeset */
> +	bridge->connector = msm_dp_bridge_state->connector;
> +	bridge->msm_dp_panel = msm_dp_bridge_state->msm_dp_panel;
> +
> +	if (!bridge->connector) {
> +		DRM_ERROR("Invalid connector\n");
> +		return;
> +	}
> +
> +	msm_dp_display_atomic_prepare(dp);
> +
> +	rc = _msm_dp_mst_bridge_pre_enable_part1(bridge, old_bridge_state);
> +	if (rc) {
> +		DRM_ERROR("[%d] DP display pre-enable failed, rc=%d\n", bridge->id, rc);
> +		msm_dp_display_unprepare(dp);
> +		return;
> +	}
> +
> +	msm_dp_display_enable_helper(dp, bridge->msm_dp_panel);
> +
> +	_msm_dp_mst_bridge_pre_enable_part2(bridge, old_bridge_state);
> +
> +	drm_dbg_dp(dp->drm_dev, "conn:%d mode:%s fps:%d vcpi:%d slots:%d to %d\n",
> +		   DP_MST_CONN_ID(bridge), bridge->drm_mode.name,
> +		   drm_mode_vrefresh(&bridge->drm_mode),
> +		   bridge->vcpi, bridge->start_slot,
> +		   bridge->start_slot + bridge->num_slots);
> +}
> +
> +static void msm_dp_mst_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> +					     struct drm_bridge_state *old_bridge_state)
> +{
> +	struct msm_dp_mst_bridge *bridge;
> +	struct msm_dp *dp;
> +
> +	if (!drm_bridge) {
> +		DRM_ERROR("Invalid params\n");
> +		return;
> +	}
> +
> +	bridge = to_msm_dp_mst_bridge(drm_bridge);
> +	if (!bridge->connector) {
> +		DRM_ERROR("Invalid connector\n");
> +		return;
> +	}
> +
> +	dp = bridge->display;
> +
> +	_msm_dp_mst_bridge_pre_disable_part1(bridge, old_bridge_state);
> +
> +	msm_dp_display_disable_helper(dp, bridge->msm_dp_panel);
> +
> +	_msm_dp_mst_bridge_pre_disable_part2(bridge);
> +
> +	drm_dbg_dp(dp->drm_dev, "mst bridge:%d conn:%d disable complete\n", bridge->id,
> +		   DP_MST_CONN_ID(bridge));
> +}
> +
> +static void msm_dp_mst_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
> +						  struct drm_bridge_state *old_bridge_state)
> +{
> +	int conn = 0;
> +	struct msm_dp_mst_bridge *bridge;
> +	struct msm_dp *dp;
> +
> +	if (!drm_bridge) {
> +		DRM_ERROR("Invalid params\n");
> +		return;
> +	}
> +
> +	bridge = to_msm_dp_mst_bridge(drm_bridge);
> +	if (!bridge->connector) {
> +		DRM_ERROR("Invalid connector\n");
> +		return;
> +	}
> +
> +	conn = DP_MST_CONN_ID(bridge);
> +
> +	dp = bridge->display;
> +
> +	msm_dp_display_atomic_post_disable_helper(dp, bridge->msm_dp_panel);
> +
> +	if (!dp->mst_active)
> +		msm_dp_display_unprepare(dp);
> +
> +	bridge->connector = NULL;
> +	bridge->msm_dp_panel =  NULL;
> +
> +	drm_dbg_dp(dp->drm_dev, "mst bridge:%d conn:%d post disable complete\n",
> +		   bridge->id, conn);
> +}
> +
> +static void msm_dp_mst_bridge_mode_set(struct drm_bridge *drm_bridge,
> +				       const struct drm_display_mode *mode,
> +				       const struct drm_display_mode *adjusted_mode)
> +{
> +	struct msm_dp_mst_bridge *bridge;
> +	struct msm_dp_mst_bridge_state *dp_bridge_state;
> +	struct msm_dp *dp;
> +	struct msm_dp_panel *msm_dp_panel;
> +
> +	if (!drm_bridge || !mode || !adjusted_mode) {
> +		DRM_ERROR("Invalid params\n");
> +		return;
> +	}
> +
> +	bridge = to_msm_dp_mst_bridge(drm_bridge);
> +
> +	dp_bridge_state = to_msm_dp_mst_bridge_state(bridge);
> +	bridge->connector = dp_bridge_state->connector;
> +	bridge->msm_dp_panel = dp_bridge_state->msm_dp_panel;
> +
> +	msm_dp_panel = bridge->msm_dp_panel;
> +	dp = bridge->display;
> +
> +	memset(&bridge->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
> +	memcpy(&bridge->drm_mode, adjusted_mode, sizeof(bridge->drm_mode));
> +	msm_dp_display_mode_set_helper(dp, mode, adjusted_mode, bridge->msm_dp_panel);
> +	msm_dp_panel->mst_caps.pbn = drm_dp_calc_pbn_mode(msm_dp_panel->msm_dp_mode.drm_mode.clock,
> +							  (msm_dp_panel->msm_dp_mode.bpp << 4));
> +	memcpy(&bridge->msm_dp_mode, &bridge->msm_dp_panel->msm_dp_mode,
> +	       sizeof(struct msm_dp_display_mode));

No, you can't just memcpy the drm_mode struct.

> +	drm_dbg_dp(dp->drm_dev, "mst bridge:%d conn:%d mode set complete %s\n", bridge->id,
> +		   DP_MST_CONN_ID(bridge), mode->name);
> +}
> +
> +/* DP MST Bridge APIs */
> +static const struct drm_bridge_funcs msm_dp_mst_bridge_ops = {
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state   = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset           = drm_atomic_helper_bridge_reset,
> +	.atomic_pre_enable   = msm_dp_mst_bridge_atomic_pre_enable,
> +	.atomic_disable      = msm_dp_mst_bridge_atomic_disable,
> +	.atomic_post_disable = msm_dp_mst_bridge_atomic_post_disable,
> +	.mode_set     = msm_dp_mst_bridge_mode_set,
> +};
> +
> +int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder)
> +{
> +	int rc = 0;
> +	struct msm_dp_mst_bridge *bridge = NULL;
> +	struct msm_dp_mst_bridge_state *state;
> +	struct drm_device *dev;
> +	struct msm_dp_mst *mst = dp->msm_dp_mst;
> +	int i;
> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		if (!mst->mst_bridge[i].in_use) {
> +			bridge = &mst->mst_bridge[i];
> +			bridge->encoder = encoder;
> +			bridge->in_use = true;
> +			bridge->id = i;
> +			break;
> +		}
> +	}
> +
> +	if (i == mst->max_streams) {
> +		DRM_ERROR("mst supports only %d bridges\n", i);
> +		rc = -EACCES;
> +		goto end;
> +	}
> +
> +	dev = dp->drm_dev;
> +	bridge->display = dp;
> +	bridge->base.funcs = &msm_dp_mst_bridge_ops;
> +	bridge->base.encoder = encoder;
> +	bridge->base.type = dp->connector_type;
> +	bridge->base.ops = DRM_BRIDGE_OP_MODES;
> +	drm_bridge_add(&bridge->base);
> +
> +	rc = drm_bridge_attach(encoder, &bridge->base, NULL, 0);
> +	if (rc) {
> +		DRM_ERROR("failed to attach bridge, rc=%d\n", rc);
> +		goto end;
> +	}
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state) {
> +		rc = -ENOMEM;
> +		goto end;
> +	}
> +
> +	drm_atomic_private_obj_init(dev, &bridge->obj,
> +				    &state->base,
> +				    &msm_dp_mst_bridge_state_funcs);
> +
> +	drm_dbg_dp(dp->drm_dev, "mst drm bridge init. bridge id:%d\n", i);
> +
> +	return 0;
> +
> +end:
> +	return rc;
> +}
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..c2a82cd3c6d6e1951a8e5905d3aa39dfc691023b
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + * Permission to use, copy, modify, distribute, and sell this software and its
> + * documentation for any purpose is hereby granted without fee, provided that
> + * the above copyright notice appear in all copies and that both that copyright
> + * notice and this permission notice appear in supporting documentation, and
> + * that the name of the copyright holders not be used in advertising or
> + * publicity pertaining to distribution of the software without specific,
> + * written prior permission.  The copyright holders make no representations
> + * about the suitability of this software for any purpose.  It is provided "as
> + * is" without express or implied warranty.
> + *
> + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
> + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
> + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
> + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
> + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
> + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
> + * OF THIS SOFTWARE.
> + */
> +
> +#ifndef _DP_MST_DRM_H_
> +#define _DP_MST_DRM_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/version.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_fixed.h>
> +#include <drm/drm_connector.h>
> +#include <drm/display/drm_dp_helper.h>
> +#include <drm/display/drm_dp_mst_helper.h>
> +
> +#include "dp_panel.h"
> +#include "dp_display.h"
> +
> +#define DP_MST_CONN_ID(bridge) ((bridge)->connector ? \
> +		(bridge)->connector->base.id : 0)

locking? Also connectors can easily be freed, so you can't just read
into it.

> +
> +struct msm_dp_mst_bridge {
> +	struct drm_bridge base;
> +	struct drm_private_obj obj;
> +	u32 id;
> +
> +	bool in_use;
> +
> +	struct msm_dp *display;
> +	struct drm_encoder *encoder;
> +
> +	struct drm_display_mode drm_mode;

Why? Where is this being set? Why can't you use the state objects instead?

> +	struct msm_dp_display_mode msm_dp_mode;

I don't see this being used. Please drop.

> +	struct drm_connector *connector;

So, you have connector here and a connector in the state. Please drop
one (I'd guess this one).

> +	struct msm_dp_panel *msm_dp_panel;
> +
> +	int vcpi;
> +	int pbn;
> +	int num_slots;
> +	int start_slot;

Which of the fields (including in_use) are long-lived and which are a
part of the current state? Can we move all state ones to bridge's state?

> +};
> +
> +struct msm_dp_mst_bridge_state {
> +	struct drm_private_state base;
> +	struct drm_connector *connector;
> +	struct msm_dp_panel *msm_dp_panel;
> +	int num_slots;
> +};
> +
> +struct msm_dp_mst {
> +	bool mst_initialized;
> +	struct drm_dp_mst_topology_mgr mst_mgr;
> +	struct msm_dp_mst_bridge *mst_bridge;
> +	struct msm_dp *msm_dp;
> +	bool mst_session_hpd_state;
> +	u32 max_streams;
> +};
> +
> +struct msm_dp_mst_connector {
> +	struct drm_connector connector;
> +	struct drm_dp_mst_port *mst_port;
> +	struct msm_dp *msm_dp;
> +	struct msm_dp_panel *dp_panel;
> +};
> +
> +#define to_msm_dp_mst_bridge(x)     container_of((x), struct msm_dp_mst_bridge, base)
> +#define to_msm_dp_mst_bridge_priv(x) \
> +		container_of((x), struct msm_dp_mst_bridge, obj)
> +#define to_msm_dp_mst_bridge_priv_state(x) \
> +		container_of((x), struct msm_dp_mst_bridge_state, base)
> +#define to_msm_dp_mst_bridge_state(x) \
> +		to_msm_dp_mst_bridge_priv_state((x)->obj.state)
> +#define to_msm_dp_mst_connector(x) \
> +		container_of((x), struct msm_dp_mst_connector, connector)
> +int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
> +
> +#endif /* _DP_MST_DRM_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


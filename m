Return-Path: <linux-kernel+bounces-312859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C9969C86
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241551F25B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68F51B985D;
	Tue,  3 Sep 2024 11:56:22 +0000 (UTC)
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F019F41F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364582; cv=none; b=ow6UrtXVzCU/RNho33U7DDxigkp/n8PuEYkybgy655MdPBBhMGmtJHG7F7Y/Fxso22e/Xjy1J0ssM9Ue7k8170fQob0gFxH0FJZSZtKth9vMO4RG1eEBSnnySF+gZXUh/EL8uZVhtG6tVZo+RbAjLFTOpZF01/9P0Lk0DGY+KeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364582; c=relaxed/simple;
	bh=tzr0tMSvLofHsivK4RyE1rSmjxQf2TavoJx1LBG6zIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Proi+d68YGD2ZFAas3k+zqVYQp/3URntxG+HtOu22zL39NlJOcLDLExf2tjhmjE4/arg6XgXceDHM71J85bnk1RwzWz4peVe+Va1R+YPREQc2sYFr3XoQdluhxhq8S/s/UGbJJ9mjGuBOIk07lhZOHXIeWx1HXrLzsxwjAp6hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DE3F61F965;
	Tue,  3 Sep 2024 13:51:01 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:51:00 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 02/21] drm/msm/dsi: fix DSC width for the bonded DSI case
Message-ID: <p6xw4newsbrpog5ftclvgi2mpg3hn3ujfukmtilqewz7kbjhqh@6geosjawh3ul>
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-2-bdb05b4b5a2e@linaro.org>
 <rspuwp3zpnzwfe26hv2yezy5ad5o7wliq7ucpobyaheytvcs3j@qtshf6cewb2f>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rspuwp3zpnzwfe26hv2yezy5ad5o7wliq7ucpobyaheytvcs3j@qtshf6cewb2f>

On 2024-09-03 11:50:36, Marijn Suijten wrote:
> On 2024-08-29 18:17:31, Jun Nie wrote:
> > From: Jonathan Marek <jonathan@marek.ca>
> > 
> > For the bonded DSI case, DSC pic_width and timing calculations should use
> > the width of a single panel instead of the total combined width.
> 
> When this patch was originally proposed we already discussed [1] that this is
> **not** universally true.  On my hardware a single bonded panel always receives
> the full width, at least on downstream kernels, and it works [2].
> 
> [1]: https://lore.kernel.org/linux-arm-msm/eanx45rnasj7lu3r2tfhtg4qkqkcidd6zctsz6ci6jlklu4fgi@3nf73w2ka4li/T/#u
> [2]: https://gitlab.freedesktop.org/drm/msm/-/issues/41
> 
> Can we please figure this out before landing this patch?

For completeness I've picked this patch, together with the following
mis-squashed change from patch 03/21:

	diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
	index 7a4d9c071be5a..5abade8f26b88 100644
	--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
	+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
	@@ -953,7 +953,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
	 			return;
	 		}
 
	-		dsc->pic_width = mode->hdisplay;
	+		dsc->pic_width = hdisplay;
	 		dsc->pic_height = mode->vdisplay;
	 		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);

And this is what it looks like on a bonded DSI CMD-mode display:
https://gitlab.freedesktop.org/drm/msm/-/issues/41#note_2553207
https://gitlab.freedesktop.org/-/project/2206/uploads/dc5c53d09ecb635fdc9f190fbc9b37ac/1000027079.jpg

That's a clear regression :)

- Marijn


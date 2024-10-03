Return-Path: <linux-kernel+bounces-349579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E403C98F89B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7351F217A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660501AD9DA;
	Thu,  3 Oct 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njlj0Ah/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3221A7262
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989828; cv=none; b=VA9ZTYt4RpW4TKZzXKPMuwjCt+xjJY+/CLEzzjK2ZHBWwshviMsJGOQEmL2P/2YV5ByYweSfZ8Zv5F7LADjlgKZ0/4QUfBazPVb7qGokL7TkJBuqN2YPBm4hR015wXi5uAMtShtuFSRnw6xnoUYNfp8hNT5Y6jkBIht1zvfzX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989828; c=relaxed/simple;
	bh=1FA88b8GWYAmlaSKYt8MbXQMv67aDLUKv9Ao95E+gck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViRmUWKan9uM0KUPp0d1udTeA1CkZLjSIMDVMwQ+Fom8uweskjCO1j2YfEKrlMwqiVSeVYpa1gyahPFhssi1hP+I0BDUeRWRTxyypx0/XRV8PezOp8K0LlCaDpgZDsMAuZD8pSSDb6QqRTx8QR/xIiKybuVarbPWYnQ3KpLhOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njlj0Ah/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727989827; x=1759525827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1FA88b8GWYAmlaSKYt8MbXQMv67aDLUKv9Ao95E+gck=;
  b=njlj0Ah/3yV+lGzGggjM7SBiPXqJlrJAMQklGV+h2ygrmtapZFOZWnte
   ZK+zS/biPKfx848bcggyRT+BPz//cVPshMFZxGamCTr4+AmKt/D2BlhQ8
   I1Q/aSYIOWyDvfqhS2w1jl5gpkV6OSw70RNUsX3M4FJxYJsJB6mYC2678
   OYdIRyn5doo1QK/6d4jKNRD3oQlc0dHTxruB9ngNWZAyvAR6hqLcV8N/T
   w00IRu4K4cgqIri7A+WXj/TGxU3qzBnzcXqVyxL4RJDEK0ounMQajqIWR
   l/wqk3XxVEXH68D2FVGWs4qP+29XU0L0eCIRTi/ZeAzZ6InTBoeJv/76K
   Q==;
X-CSE-ConnectionGUID: 2dulphvESVSAMgh7B7hj4w==
X-CSE-MsgGUID: hvaRLv0tQ2K+OEOHqOlocw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37866011"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="37866011"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:10:26 -0700
X-CSE-ConnectionGUID: Qibn512WQTKlCUy6xhSprg==
X-CSE-MsgGUID: RyctnvlIQfq43hSH1gTKoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74602182"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 03 Oct 2024 14:10:22 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 04 Oct 2024 00:10:21 +0300
Date: Fri, 4 Oct 2024 00:10:21 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, thomas.petazzoni@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Remove usage of legacy drm_crtc members
Message-ID: <Zv8IPRKcPqYXgL2B@intel.com>
References: <20241003-remove-legacy-v1-1-0b7db1f1a1a6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003-remove-legacy-v1-1-0b7db1f1a1a6@bootlin.com>
X-Patchwork-Hint: comment

On Thu, Oct 03, 2024 at 05:41:10PM +0200, Louis Chauvet wrote:
> Some members of the drm_crtc structure have been deprecated in favor of
> equivalent members in the drm_crtc_state structure. As reported by Ville
> Syrjala [1], the VKMS driver was still using these deprecated fields. This
> commit updates the VKMS driver to use the new drm_crtc_state fields
> instead.
> 
> Additionally, this commit removes the call to
> `drm_calc_timestamping_constants` in `vkms_enable_vblank` as it is
> redundant. This calculation is already performed in
> `vkms_atomic_commit_tail` by calling
> `drm_atomic_helper_commit_modeset_disables`.

One slight difference here is that
drm_atomic_helper_calc_timestamping_constants() passes in
crtc_state->adjusted_mode instead of crtc_state->mode, but
doesn't look look vkms mangles either in any way so they should
stay identical after drm_atomic_helper_check_modeset()->mode_fixup()
has done the copy.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> [1]:https://lore.kernel.org/all/20241002182200.15363-1-ville.syrjala@linux.intel.com/
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c  | 4 ++--
>  drivers/gpu/drm/vkms/vkms_crtc.c      | 2 --
>  drivers/gpu/drm/vkms/vkms_writeback.c | 4 ++--
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 57a5769fc994..3f0977d746be 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -187,7 +187,7 @@ static void blend(struct vkms_writeback_job *wb,
>  
>  	const struct pixel_argb_u16 background_color = { .a = 0xffff };
>  
> -	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
> +	size_t crtc_y_limit = crtc_state->base.mode.vdisplay;
>  
>  	/*
>  	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
> @@ -270,7 +270,7 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
>  	if (WARN_ON(check_format_funcs(crtc_state, active_wb)))
>  		return -EINVAL;
>  
> -	line_width = crtc_state->base.crtc->mode.hdisplay;
> +	line_width = crtc_state->base.mode.hdisplay;
>  	stage_buffer.n_pixels = line_width;
>  	output_buffer.n_pixels = line_width;
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index a40295c18b48..bbf080d32d2c 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -64,8 +64,6 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
>  
> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> -
>  	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	out->vblank_hrtimer.function = &vkms_vblank_simulate;
>  	out->period_ns = ktime_set(0, vblank->framedur_ns);
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index bc724cbd5e3a..999d5c01ea81 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -131,8 +131,8 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>  	struct drm_connector_state *conn_state = wb_conn->base.state;
>  	struct vkms_crtc_state *crtc_state = output->composer_state;
>  	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
> -	u16 crtc_height = crtc_state->base.crtc->mode.vdisplay;
> -	u16 crtc_width = crtc_state->base.crtc->mode.hdisplay;
> +	u16 crtc_height = crtc_state->base.mode.vdisplay;
> +	u16 crtc_width = crtc_state->base.mode.hdisplay;
>  	struct vkms_writeback_job *active_wb;
>  	struct vkms_frame_info *wb_frame_info;
>  	u32 wb_format = fb->format->format;
> 
> ---
> base-commit: cbc1e8696fbea0010a73bf93534c712f9ad177db
> change-id: 20241003-remove-legacy-a2683a7bbcd5
> 
> Best regards,
> -- 
> Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Ville Syrjälä
Intel


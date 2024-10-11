Return-Path: <linux-kernel+bounces-361030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C428699A295
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C63E28419C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE42141BD;
	Fri, 11 Oct 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrzTv4ZD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730F804
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645550; cv=none; b=CuS5ndlqcYBNFtBnJ7VFjyhyZbEXZun2noziiMB+FBaROlugbp6l3Ucu8koYsN+OO+xC7d2tzg15/bGLvbdB/O28pMh8uhrpNFKBdH19U2Z9A/zGSvV5Efs8+Qub2yEkl76k5EAwKFwYt3cAo4CdcbFYF9wpsx931911LT5LbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645550; c=relaxed/simple;
	bh=tb/AKCZTZ7StZwAXhBpsPd0RFKwWv4rBCAopOKOmgBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DhoeCjLueFCEJIPEIp5SYhR3S43V6SWqVAXwGarXNnKOKg/sWqyTJbfL5Fb9ox8xV0LnvoVZqog30AtWq9FEqU4OkQ5ImO4u6FpOQNi/H4jtKqE4is18OBd/+UhfN6F9dLB4BoYmt/IVLXKFahY4o5NGYamO+edp4TN6rIkHbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrzTv4ZD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728645548; x=1760181548;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tb/AKCZTZ7StZwAXhBpsPd0RFKwWv4rBCAopOKOmgBo=;
  b=mrzTv4ZDhxQK1iprKdT2L8zlPEiVikuiaKgR6DW+n88yspLMUtU30Rbc
   OCZJdYQCBQlwx0fPJzJSLs47f+aGt1ZmM31zPEMbQpK//xOgrvkcbEA87
   WwQN6sOOobfBMlvu/kl8DaRRxtIk8z8qw8qRIVEbgZN4jHTLwLg5LLyJO
   RDc+zZI9GtQbNESXfl2etilDKzHgWb7VJC2UtiS224ZxQiM7IQ6KIyKU7
   /pxLNWWs3rlvNI6BiSUlZWye/j3Yy/TZXt7yGNxL9tJO4ew85DohKhYBO
   2TMCpeaPJIQra9C7zxuBMbvzYGwLf1jaE+sUt1Qb4BvuRrvpl5bTrTcUG
   g==;
X-CSE-ConnectionGUID: Z1cGkT6qTeKEnm9gBEy9Fw==
X-CSE-MsgGUID: tRS2yd+rRp+mvUz8bVCmvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31741952"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31741952"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:19:08 -0700
X-CSE-ConnectionGUID: aXCBuGYqSH2Y0CjWLpogmg==
X-CSE-MsgGUID: LFeuKHMfTYSej422mdVczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81403646"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.178])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:19:03 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v4 7/7] drm/log: Add integer scaling support
In-Reply-To: <20241011105526.615812-8-jfalempe@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241011105526.615812-1-jfalempe@redhat.com>
 <20241011105526.615812-8-jfalempe@redhat.com>
Date: Fri, 11 Oct 2024 14:18:57 +0300
Message-ID: <8734l26g66.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 11 Oct 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> Add a module parameter, to increase the font size for HiDPI screen.
> Even with CONFIG_FONT_TER16x32, it can still be a bit small to read.
> In this case, adding drm_log.scale=2 to your kernel command line will
> double the character size.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_log.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
> index 07d151300146..e44c10819bd0 100644
> --- a/drivers/gpu/drm/drm_log.c
> +++ b/drivers/gpu/drm/drm_log.c
> @@ -25,6 +25,10 @@ MODULE_AUTHOR("Jocelyn Falempe");
>  MODULE_DESCRIPTION("DRM boot logger");
>  MODULE_LICENSE("GPL");
>  
> +static uint scale = 1;

Drive-by nit, please use regular types instead of sysv "uint".

BR,
Jani.

> +module_param(scale, uint, 0444);
> +MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
> +
>  /**
>   * DOC: overview
>   *
> @@ -38,6 +42,8 @@ struct drm_log_scanout {
>  	const struct font_desc *font;
>  	u32 rows;
>  	u32 columns;
> +	u32 scaled_font_h;
> +	u32 scaled_font_w;
>  	u32 line;
>  	u32 format;
>  	u32 px_width;
> @@ -67,7 +73,7 @@ static struct drm_log *console_to_drm_log(struct console *con)
>  
>  static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>  			 const u8 *src, unsigned int src_pitch,
> -			 u32 height, u32 width, u32 scale, u32 px_width, u32 color)
> +			 u32 height, u32 width, u32 px_width, u32 color)
>  {
>  	switch (px_width) {
>  	case 2:
> @@ -87,7 +93,7 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>  static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line)
>  {
>  	struct drm_framebuffer *fb = scanout->buffer->fb;
> -	unsigned long height = scanout->font->height;
> +	unsigned long height = scanout->scaled_font_h;
>  	struct iosys_map map;
>  	struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, height);
>  
> @@ -107,8 +113,8 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>  	size_t font_pitch = DIV_ROUND_UP(font->width, 8);
>  	const u8 *src;
>  	u32 px_width = fb->format->cpp[0];
> -	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * font->height,
> -					  fb->width, (scanout->line + 1) * font->height);
> +	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * scanout->scaled_font_h,
> +					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
>  	u32 i;
>  
>  	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
> @@ -118,9 +124,10 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
>  	for (i = 0; i < len && i < scanout->columns; i++) {
>  		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
>  		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
> -		drm_log_blit(&map, fb->pitches[0], src, font_pitch, font->height, font->width,
> -			     1, px_width, color);
> -		iosys_map_incr(&map, font->width * px_width);
> +		drm_log_blit(&map, fb->pitches[0], src, font_pitch,
> +			     scanout->scaled_font_h, scanout->scaled_font_w,
> +			     px_width, color);
> +		iosys_map_incr(&map, scanout->scaled_font_w * px_width);
>  	}
>  
>  	scanout->line++;
> @@ -205,8 +212,10 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
>  		return -ENOMEM;
>  	}
>  	mode_set->fb = scanout->buffer->fb;
> -	scanout->rows = height / scanout->font->height;
> -	scanout->columns = width / scanout->font->width;
> +	scanout->scaled_font_h = scanout->font->height * scale;
> +	scanout->scaled_font_w = scanout->font->width * scale;
> +	scanout->rows = height / scanout->scaled_font_h;
> +	scanout->columns = width / scanout->scaled_font_w;
>  	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
>  	scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, format);
>  	return 0;

-- 
Jani Nikula, Intel


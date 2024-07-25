Return-Path: <linux-kernel+bounces-261943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4808393BE16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1144B210E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E3185E6E;
	Thu, 25 Jul 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SA3cAUJw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D21741EF;
	Thu, 25 Jul 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896918; cv=none; b=KztbwVvcvo58//hLZECdGchEhBXntfP5MUL8mIc8NxKSnEogri0hNxY4SMw/yybAkD+PaB9qnmxjpu1bOVoqsOtKHe8nrNm1ZCwg/NQIYsVkAx0Ra5o25NdMwY7qrHf7OkkaGX9oy6wZG9u6RXKjExStTT6PN0pw4xanK8nThRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896918; c=relaxed/simple;
	bh=9PXOAk3QrslKghZrt3UgKYDSYc8WcUr0AucgPJXhyyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpgRIMSP9Shoem1HvyIUXLJUqTERfL8gZLAo0pXnUjuGHLJRdJhNE3pHj11c2jf7GIr2YZ4j1Ee4W1F7p6+wDqJQYy8bohDvmAgvBLH5OssPZzu4jQLuMeL8mFqxxXZrKwu/zX8Xy+X2hQUEl3HmqxnsD1B7PbhF8ei6T720c9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SA3cAUJw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721896916; x=1753432916;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9PXOAk3QrslKghZrt3UgKYDSYc8WcUr0AucgPJXhyyk=;
  b=SA3cAUJwfAmvwu946e9uBtY/ei+SCZF51k/fmJHh+bIBDwZ9DXIuaG/F
   Juqe6LdLpoT3qXqUpclXreWQ+Dz25S9b6rmRRDGQgPMJ1EtuU5XJDM++Y
   IAdb6J9pDwQBnwuyXeQ+f62QW4ORdC0vcnDONT+jb0sJjOSRLXu/xBO4D
   SwrvPyUJwSGGict6GKrGJQDorxMDmD915TsHV6rvVAdMzndSJxgn9oYcm
   PKy21/IpnoQ7ok1BT5rjDH/pt4BGQf95eOfjDl8NrbqMzVHlVNzYbAgSB
   lhKoLq2LxngLTABcexGrDtmNYbNbr6jJ63/2wjtiJt2WJvicoodL5YhAb
   Q==;
X-CSE-ConnectionGUID: /xDCyKSRTeGxWPrI9Bf8fQ==
X-CSE-MsgGUID: omsMBrSvSi2nfjQyNN1GWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19745410"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19745410"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 01:41:55 -0700
X-CSE-ConnectionGUID: hVCpyLtISkeCPmULuheJ0Q==
X-CSE-MsgGUID: dAuQGANpRoCCJNBhx6biQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="83461377"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.243])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 01:41:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dianders@chromium.org, hsinyi@google.com,
 airlied@gmail.com, daniel@ffwll.ch, jagan@edgeble.ai
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhaoxiong Lv
 <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v1 1/2] drm/panel: jd9365da: Move the sending location
 of the 11/29 command
In-Reply-To: <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Thu, 25 Jul 2024 11:41:44 +0300
Message-ID: <87o76lzwvr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 25 Jul 2024, Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> Move the 11/29 command from enable() to init() function

OOC, what is the "11/29" command?

BR,
Jani.

>
> As mentioned in the patch:
> https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com/
>
> Our DSI host has different modes in prepare() and enable()
> functions. prepare() is in LP mode and enable() is in HS mode.
> Since the 11/29 command must also be sent in LP mode,
> so we also move 11/29 command to the init() function.
>
> After moving the 11/29 command to the init() function,
> we no longer need additional delay judgment, so we delete
> variables "exit_sleep_to_display_on_delay_ms" and
> "display_on_delay_ms".
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 59 ++++++++++---------
>  1 file changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 04d315d96bff..ce73e8cb1db5 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -31,8 +31,6 @@ struct jadard_panel_desc {
>  	bool reset_before_power_off_vcioo;
>  	unsigned int vcioo_to_lp11_delay_ms;
>  	unsigned int lp11_to_reset_delay_ms;
> -	unsigned int exit_sleep_to_display_on_delay_ms;
> -	unsigned int display_on_delay_ms;
>  	unsigned int backlight_off_to_display_off_delay_ms;
>  	unsigned int display_off_to_enter_sleep_delay_ms;
>  	unsigned int enter_sleep_to_reset_down_delay_ms;
> @@ -66,26 +64,6 @@ static inline struct jadard *panel_to_jadard(struct drm_panel *panel)
>  	return container_of(panel, struct jadard, panel);
>  }
>  
> -static int jadard_enable(struct drm_panel *panel)
> -{
> -	struct jadard *jadard = panel_to_jadard(panel);
> -	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> -
> -	msleep(120);
> -
> -	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> -
> -	if (jadard->desc->exit_sleep_to_display_on_delay_ms)
> -		mipi_dsi_msleep(&dsi_ctx, jadard->desc->exit_sleep_to_display_on_delay_ms);
> -
> -	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> -
> -	if (jadard->desc->display_on_delay_ms)
> -		mipi_dsi_msleep(&dsi_ctx, jadard->desc->display_on_delay_ms);
> -
> -	return dsi_ctx.accum_err;
> -}
> -
>  static int jadard_disable(struct drm_panel *panel)
>  {
>  	struct jadard *jadard = panel_to_jadard(panel);
> @@ -202,7 +180,6 @@ static const struct drm_panel_funcs jadard_funcs = {
>  	.disable = jadard_disable,
>  	.unprepare = jadard_unprepare,
>  	.prepare = jadard_prepare,
> -	.enable = jadard_enable,
>  	.get_modes = jadard_get_modes,
>  	.get_orientation = jadard_panel_get_orientation,
>  };
> @@ -382,6 +359,12 @@ static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
>  
>  	jd9365da_switch_page(&dsi_ctx, 0x00);
>  
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
>  	return dsi_ctx.accum_err;
>  };
>  
> @@ -608,6 +591,12 @@ static int cz101b4001_init_cmds(struct jadard *jadard)
>  	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE6, 0x02);
>  	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE7, 0x0C);
>  
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
>  	return dsi_ctx.accum_err;
>  };
>  
> @@ -831,6 +820,16 @@ static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
>  
>  	jd9365da_switch_page(&dsi_ctx, 0x00);
>  
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
>  	return dsi_ctx.accum_err;
>  };
>  
> @@ -859,8 +858,6 @@ static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
>  	.reset_before_power_off_vcioo = true,
>  	.vcioo_to_lp11_delay_ms = 5,
>  	.lp11_to_reset_delay_ms = 10,
> -	.exit_sleep_to_display_on_delay_ms = 120,
> -	.display_on_delay_ms = 20,
>  	.backlight_off_to_display_off_delay_ms = 100,
>  	.display_off_to_enter_sleep_delay_ms = 50,
>  	.enter_sleep_to_reset_down_delay_ms = 100,
> @@ -1074,6 +1071,16 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
>  	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x02);
>  	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe7, 0x06);
>  
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
>  	return dsi_ctx.accum_err;
>  };
>  
> @@ -1102,8 +1109,6 @@ static const struct jadard_panel_desc melfas_lmfbx101117480_desc = {
>  	.reset_before_power_off_vcioo = true,
>  	.vcioo_to_lp11_delay_ms = 5,
>  	.lp11_to_reset_delay_ms = 10,
> -	.exit_sleep_to_display_on_delay_ms = 120,
> -	.display_on_delay_ms = 20,
>  	.backlight_off_to_display_off_delay_ms = 100,
>  	.display_off_to_enter_sleep_delay_ms = 50,
>  	.enter_sleep_to_reset_down_delay_ms = 100,

-- 
Jani Nikula, Intel


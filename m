Return-Path: <linux-kernel+bounces-556851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43340A5CF78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7908717BCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1EA2641D5;
	Tue, 11 Mar 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6ZF0rBC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCA1EBFFD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721608; cv=none; b=gpPN97IuWQ3pZBymLRoJ+cMpOaIgVwcc+p7X9XwUeJtDqU1W5Sq/A3LMVSa9lgHUrUMIFqVTzDX0KY8PXStfl2mmPeUbEMD/xngiC3vUj4aPN/YHkIJ1rcHFPteEDJwI0zx3XnczALQY6+Xfb6YtqRhJi3qt2qEimH067voJZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721608; c=relaxed/simple;
	bh=0eBZ3mKbc6FbHFU4M90DMSCxTvs8xVQcHIMudr/3iH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1ixVfvqUkjs4KMtKUlC0QekiTCfYmhJZ1S79Ry4ngIe0J3WQiWL4TgwkQe+diBF9cAEyLanvN136KWxQVILOAkoSrraa37hjeKOPEjoZpjv4qy/VxlLR/Y8Gikv7ByisYrz4C5nlGy/OPhW2O0XXsSeSGExrbz7kQXqXC3YPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6ZF0rBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2586C4CEE9;
	Tue, 11 Mar 2025 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721608;
	bh=0eBZ3mKbc6FbHFU4M90DMSCxTvs8xVQcHIMudr/3iH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6ZF0rBC0uON6Bxk4pzSubjG+D7fEz5iFql20/A9fDOLyhhOz/epbP69jyqm0PVuW
	 9Phr2qNIQDIwAmJHFJkhT7JGi54PqDXmdnQ5ync4Lg2z4I+zfI8e3lGS/YLWLk0waS
	 uTzXwxKIOIVWlo0LR71FIrXaD7jKjlPzyc3vTXk4NfGdD2bNLjK9Jnbf5vmVEEO+D2
	 mGqSjzh/KGehZeuwgXZ8xZE260ymuTUymhRAQyCKXLiLuZ/QhdKh044ZevNnv+BUJi
	 3r63Go0jxaCgpNouGrpEz3JbB6QmMnZppk5h0cjGokhzSJveP6xEQtpR0b7EmxIjBE
	 aiTXxBDpHb6MQ==
Date: Tue, 11 Mar 2025 21:33:23 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	lujianhua000@gmail.com, quic_jesszhan@quicinc.com, dianders@chromium.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, asrivats@redhat.com
Subject: Re: [PATCH v3] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
Message-ID: <7q7qdqh3my37uvvgl6ygo6amrw4nf57mbnscmxx6wwu5fsntny@a2uedhwg2a6p>
References: <20250309040355.381386-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309040355.381386-1-tejasvipin76@gmail.com>

On Sun, Mar 09, 2025 at 09:33:55AM +0530, Tejas Vipin wrote:
> Changes the novatek-nt36523 panel to use multi style functions for
> improved error handling.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v3:
>     - Remove mipi_dsi_dual_msleep
>     - Change mipi_dsi_dual_dcs_write_seq_multi to use the same dsi_ctx
>       by swapping the dsi accordingly.
> 
> Link to v2: https://lore.kernel.org/all/20250307091519.245889-1-tejasvipin76@gmail.com/
> 
> Changes in v2:
>     - Uses mipi_dsi_dual_msleep
>     - Changed mipi_dsi_dual_dcs_write_seq_multi to not equate accum_err
>       of either dsi_ctx.
> 
> Link to v1: https://lore.kernel.org/all/20250306134350.139792-1-tejasvipin76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1681 ++++++++---------
>  1 file changed, 821 insertions(+), 860 deletions(-)


[..]

> 
> @@ -1063,18 +1026,16 @@ static int nt36523_prepare(struct drm_panel *panel)
>  static int nt36523_disable(struct drm_panel *panel)
>  {
>  	struct panel_info *pinfo = to_panel_info(panel);
> -	int i, ret;
> +	int i;
>  
>  	for (i = 0; i < DSI_NUM_MIN + pinfo->desc->is_dual_dsi; i++) {
> -		ret = mipi_dsi_dcs_set_display_off(pinfo->dsi[i]);
> -		if (ret < 0)
> -			dev_err(&pinfo->dsi[i]->dev, "failed to set display off: %d\n", ret);
> +		mipi_dsi_dcs_set_display_off_multi(

-:1726: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#1726: FILE: drivers/gpu/drm/panel/panel-novatek-nt36523.c:1032:
+		mipi_dsi_dcs_set_display_off_multi(

> +			&(struct mipi_dsi_multi_context){.dsi = pinfo->dsi[i]});
>  	}
>  
>  	for (i = 0; i < DSI_NUM_MIN + pinfo->desc->is_dual_dsi; i++) {
> -		ret = mipi_dsi_dcs_enter_sleep_mode(pinfo->dsi[i]);
> -		if (ret < 0)
> -			dev_err(&pinfo->dsi[i]->dev, "failed to enter sleep mode: %d\n", ret);
> +		mipi_dsi_dcs_enter_sleep_mode_multi(

Same here. I think it might be cleaner to define a variable of struct
mipi_dsi_multi_context type and pass it here.

> +			&(struct mipi_dsi_multi_context){.dsi = pinfo->dsi[i]});
>  	}
>  
>  	msleep(70);
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry


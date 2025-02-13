Return-Path: <linux-kernel+bounces-513864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CDA34F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382F1189029E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5D2661B4;
	Thu, 13 Feb 2025 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QyWOl391"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617D221720
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479315; cv=none; b=my7tIVt8WVwVmmasptuHyaMKN9HfIHThY0BzuC13/TtoJdnEDcMMbcbQBa1C5rFRtRB1C/re8lBvtfeLQz695/4WIwgmtTd971onQvfA3KVYjOoL77K9azvSHUEEdm/Y/4ybY1oM4WUONq9PLq792K9xzERiqq4Z8Lk/tNl2MNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479315; c=relaxed/simple;
	bh=1+AAiHUmcZ0YGwlI7FBzyZhAxpsavKtjHcxXh5On9+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOc953tkNfodbyuskGbLVuxNNZAVMzLnnmX8OW62QPLspPAK1RGZidGyXAyamiUZjhIn61QdXtMbPDwB654BpsG2a344PQTH6HVV0UU31ee6EQHS78W93nzplQIGvIgdzsDGjHuAZngfMfVa6d0O0wA1Ov0k8oZJ+U2oC7US2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QyWOl391; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BD1D594;
	Thu, 13 Feb 2025 21:40:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739479233;
	bh=1+AAiHUmcZ0YGwlI7FBzyZhAxpsavKtjHcxXh5On9+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyWOl391hTdGPhY0sOHjjkxZJUII2e32RnweKlJ7bD982MVv7Jag0MK+xPA0TcNdX
	 nYmLLvIKzU8DsUDWShycDP9fl95yasHYCYrDDQjBslXrzxiMakxcHHieAHvaepkzsJ
	 QkgfYV4eozq+sO01qewcctSkp5NOXqnD65uUBslQ=
Date: Thu, 13 Feb 2025 22:41:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 01/11] drm/fourcc: Add warning for bad bpp
Message-ID: <20250213204140.GB22998@pendragon.ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-1-90d0fe106995@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212-xilinx-formats-v3-1-90d0fe106995@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Feb 12, 2025 at 04:56:05PM +0200, Tomi Valkeinen wrote:
> drm_format_info_bpp() cannot be used for formats which do not have an
> integer bits-per-pixel in a pixel block.
> 
> E.g. DRM_FORMAT_XV15's (not yet in upstream) plane 0 has three 10-bit
> pixels (Y components), and two padding bits, in a 4 byte block. That is
> 10.666... bits per pixel when considering the whole 4 byte block, which
> is what drm_format_info_bpp() does. Thus a driver that supports such
> formats cannot use drm_format_info_bpp(),
> 
> It is a driver bug if this happens, but so handle wrong calls by
> printing a warning and returning 0.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 3a94ca211f9c..1e9afbf6ef99 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -457,6 +457,13 @@ unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
>  	if (!info || plane < 0 || plane >= info->num_planes)
>  		return 0;
>  
> +	if (info->char_per_block[plane] * 8 %
> +	    (drm_format_info_block_width(info, plane) *
> +	     drm_format_info_block_height(info, plane))) {

Can you cache 

	    drm_format_info_block_width(info, plane) *
	    drm_format_info_block_height(info, plane)

in a local variable to avoid computing it twice ?

> +		pr_warn("unable to return an integer bpp\n");

It would be nice to print the warning in the context of the drm device,
but we don't have the required structure here.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		return 0;
> +	}
> +
>  	return info->char_per_block[plane] * 8 /
>  	       (drm_format_info_block_width(info, plane) *
>  		drm_format_info_block_height(info, plane));

-- 
Regards,

Laurent Pinchart


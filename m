Return-Path: <linux-kernel+bounces-283215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F70394EEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32EAB251F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBE17C7BE;
	Mon, 12 Aug 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Npg2uDff"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF75183CC4;
	Mon, 12 Aug 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470565; cv=none; b=YEqWTVqeFfqt+grUBfjVDjZZVtu4rc2MD9RGRmOIMZRu5Up/imXqYnZaiTiS3a8CC99DDvDD6XvZlWheMdg/n90oDaBgncvwvEAWfkx8omWFcXICheZ5XDPrrbrSvM5y1qfLW2IsdpPofS+FU2/rNtfxfDkH57g6P7Bj/DI0TiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470565; c=relaxed/simple;
	bh=FSNWWOfBczRimX/OeuXzsO1eWAUfUC6SsCaOC3eStWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMC7j9EUpukukJirku3Pck2XzWETVIvQ8vPREBCJbrRtEYnd8MIKQfp8skzKJNh01QqOdthnA24jpei9/nN9A39BQXNaqfNLCki83wuUGgW+Q/K6Fnu6hrg/kXW6ktPz1qPDe2QLnodTAdTFNs4MtQBRf0JQHh1OqVrc1RW40t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Npg2uDff; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723470564; x=1755006564;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FSNWWOfBczRimX/OeuXzsO1eWAUfUC6SsCaOC3eStWg=;
  b=Npg2uDffdN47fkdKLx4gmAt+1S3LPAWnYjUSlnfLJHbHTrOWIbZzj8R6
   vftbRF/jlJNfAIPwnuunwcU1iFgVWfPxCaV7D+cewBAzCidv3hyj1AJAy
   HT++j1oQzuiG30O2Hk9/Ec591rwBo9hXkcuydPhpKUX3F0yiQyq3TSio5
   Vr9xeX/lNwDHSxsTZcXBnEbN+10U95rOX9/7W2CfF+uljVvxR3k/DzyCG
   VCmm7krt8CtQu9KBVyDWsgjM/ecaUD8NgplPGDTfMMe+6gtAneJeSnZnG
   n8RKENfjHUkrVol/9roaueg3MRd1Ycw61BP3bxywHZC4YEEzGnirKNdDQ
   Q==;
X-CSE-ConnectionGUID: B8oe9XTQTZeZ5+Ryw/RyJQ==
X-CSE-MsgGUID: 5q/F8kwoS/2oaFaEinhYDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21439640"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21439640"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:49:23 -0700
X-CSE-ConnectionGUID: GbxiNnPvS7+EFc2K0UIztg==
X-CSE-MsgGUID: 1stcQ3ScQ3yZPV0Li/laiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="81512475"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.117])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:49:16 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bjorn Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, Danilo
 Krummrich <dakr@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v6 2/4] drm/rect: Add drm_rect_overlap()
In-Reply-To: <20240812123147.81356-3-jfalempe@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240812123147.81356-1-jfalempe@redhat.com>
 <20240812123147.81356-3-jfalempe@redhat.com>
Date: Mon, 12 Aug 2024 16:49:13 +0300
Message-ID: <87sev926na.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 12 Aug 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> Check if two rectangles overlap.
> It's a bit similar to drm_rect_intersect() but this won't modify
> the rectangle.
> Simplifies a bit drm_panic.

Based on the name, I'd expect drm_rect_overlap() to return true for
*any* overlap, while this one seems to mean if one rectangle is
completely within another, with no adjacent borders.

I'd expect a drm_rect_overlap() to return true for this:

 +-------+
 |   +---+---+
 |   |       |
 +---+       |
     |       |
     +-------+

While this seems to be required instead:

 +-------+
 | +---+ |
 | |   | |
 | +---+ |
 +-------+


IOW, I find the name misleading.

BR,
Jani.


>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_panic.c |  3 +--
>  include/drm/drm_rect.h      | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 0a047152f88b8..59fba23e5fd7a 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -529,8 +529,7 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>  	/* Fill with the background color, and draw text on top */
>  	drm_panic_fill(sb, &r_screen, bg_color);
>  
> -	if ((r_msg.x1 >= logo_width || r_msg.y1 >= logo_height) &&
> -	    logo_width <= sb->width && logo_height <= sb->height) {
> +	if (!drm_rect_overlap(&r_logo, &r_msg)) {
>  		if (logo_mono)
>  			drm_panic_blit(sb, &r_logo, logo_mono->data, DIV_ROUND_UP(logo_width, 8),
>  				       fg_color);
> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
> index 73fcb899a01da..7bafde747d560 100644
> --- a/include/drm/drm_rect.h
> +++ b/include/drm/drm_rect.h
> @@ -238,6 +238,21 @@ static inline void drm_rect_fp_to_int(struct drm_rect *dst,
>  		      drm_rect_height(src) >> 16);
>  }
>  
> +/**
> + * drm_rect_overlap - Check if two rectangles overlap
> + * @r1: first rectangle
> + * @r2: second rectangle
> + *
> + * RETURNS:
> + * %true if the rectangles overlap, %false otherwise.
> + */
> +static inline bool drm_rect_overlap(const struct drm_rect *r1,
> +				    const struct drm_rect *r2)
> +{
> +	return (r1->x2 > r2->x1 && r2->x2 > r1->x1 &&
> +		r1->y2 > r2->y1 && r2->y2 > r1->y1);
> +}
> +
>  bool drm_rect_intersect(struct drm_rect *r, const struct drm_rect *clip);
>  bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>  			  const struct drm_rect *clip);

-- 
Jani Nikula, Intel


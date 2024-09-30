Return-Path: <linux-kernel+bounces-344010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E107398A28D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994441F237C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B518E041;
	Mon, 30 Sep 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kHSYaaeu"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828561367
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699612; cv=none; b=DHS8lrfMKTwlPMujTSqo/yjOH/newBJBgCK4aSfE56mOarFGimx9TXyeR1KLw5Vq6BW22GeHep3JQn/z77tVZrUBrvoXCwmSkS943iMnqcoZjjIV1X9z/NC4sECniakTu+EWz6x0s6SDU1R0FUNtlqx2fFp5YqEFwEocX4M2eKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699612; c=relaxed/simple;
	bh=hsn6qIHCV8EE898kuj1+46bwDUw4E/pbekYed91CyDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+g+UcrR6A2pU/zi6IC2/9EYTLxdRrfJ3QuHnYOF/yQNZpSIAA7/UFrECoxjTv+iixk0zsU+QhDZ5nIKS1H5D7RbtFHpPBNQSHvNONakAyUAPh69vBcI7MeU+iK8rpeJDAcSZeo0/U6P4i7HR+uxysChzqwPAxHyemwdOs7Mhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kHSYaaeu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=bsjyQJc6rlUDtp6Ad1gt+O9AIpQT/zdHP7sLmtwCgpU=; b=kHSYaaeuva5nyyvn
	+yCz0THwMO7NK/fB7hVCdEe3bgxrKKLYQ9lEAfve2q2AHPhPqR4UizKaMQlqy9Q8A1Y5YtOlrc0i0
	Xp6+2m4FzoQ+Ljktg22Dif53UwoUHV/QCXhIuNmkO73X92kyYhxQkzZgDdEbB08VneHyXahe2WqzZ
	JvOgM9M9e1Twxioe/v77e8LDKfLmlj4hb2Ga0sJBBCI/wHj2U0xucDRvRUkSHnt6mDQccajXmyzPl
	1e0tR5G64wp8OongOAW+zSiZflKfWhWQ6Nsxa9FCdfQ10Pz1ICARHKO9LBF8XxQMZBlMD8pYWOBek
	MepbaiAZVIa14yHBSg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1svFaX-007xkK-23;
	Mon, 30 Sep 2024 12:33:17 +0000
Date: Mon, 30 Sep 2024 12:33:17 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Aradhya Bhatia <aradhya.bhatia@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Intel XE List <intel-xe@lists.freedesktop.org>,
	DRI Devel List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>
Subject: Re: [PATCH] drm/xe/xe2lpg: Add WA 15016589081
Message-ID: <ZvqajY_bLH_eULv5@gallifrey>
References: <20240930120602.1720218-1-aradhya.bhatia@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240930120602.1720218-1-aradhya.bhatia@intel.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:31:20 up 144 days, 23:45,  1 user,  load average: 0.01, 0.04,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Aradhya Bhatia (aradhya.bhatia@intel.com) wrote:
> Add workaround (wa) 15016589081 which applies to Xe2_v3_LPG_MD.

It would be great in this type of patch if you could
briefly say what symptom it fixes;  Some people might not know what
WA 15016589081  does.

Dave

> Xe2_v3_LPG_MD is a Lunar Lake platform with GFX version: 20.04.
> This wa is type: permanent, and hence is applicable on all steppings.
> 
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_wa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
> index 22c148b1e996..2f9cde4b7d45 100644
> --- a/drivers/gpu/drm/xe/xe_wa.c
> +++ b/drivers/gpu/drm/xe/xe_wa.c
> @@ -710,6 +710,10 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
>  			     DIS_PARTIAL_AUTOSTRIP |
>  			     DIS_AUTOSTRIP))
>  	},
> +	{ XE_RTP_NAME("15016589081"),
> +	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
> +	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
> +	},
>  
>  	/* Xe2_HPG */
>  	{ XE_RTP_NAME("15010599737"),
> 
> base-commit: 0c8650b09a365f4a31fca1d1d1e9d99c56071128
> -- 
> 2.34.1
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


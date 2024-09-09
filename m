Return-Path: <linux-kernel+bounces-320766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388D970FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B2C1F227F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4DF1AF4F0;
	Mon,  9 Sep 2024 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeuaEMzW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCB41C79;
	Mon,  9 Sep 2024 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867581; cv=none; b=QnxLZLMG/oSe99K+p9GTExedseG5TMFZVUCA8l0JCfHX+2Cx0UgWzCSZzUW60AsgZSdkltgR8oLJUyNWqldSZ1rZPxP2lm4qWUTQkNL0XtlVNtjscO1er7ldP69luF7kDSi1FPv5xTRsOvsfWtpXeoH3Yd9C+k3k3TeFbnHAJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867581; c=relaxed/simple;
	bh=RiD2W5cm7ORoR6DJBKgPlV0gjZv3FnjVx+Rnl87vOcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhyEIDGCZNkMoWEYOVfJB3XWPSCV1qyXD3wCAkBRiYQae9ohVmaX5JPJxaCq4dnzm4D+SV2qCahB1KGgs8tz91clD14DUc6PNJBMEQgtELA48gGxupY+pkcaUiawV00ICtnuR3T9er9i8U4RH1zOr6sxRXEU2Kt8Bn/7ZsNPGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeuaEMzW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725867578; x=1757403578;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RiD2W5cm7ORoR6DJBKgPlV0gjZv3FnjVx+Rnl87vOcQ=;
  b=FeuaEMzWeOXlZBU0HBZF+Fyl25QiRi535XfBUAM2ykhoZuDWwMWe0+/y
   plQP5gTuqtES9Wgxb2RA17YVBPo+DgTeyeNVQNeEYAFL2sS49tn3RuS2G
   kXUkt7KsGJalfLUKassq08wh8zxYpeLsqQvk7DC6LGZGfeJ1DUrMZGA4R
   O07l76f0+PbGUaU+KV70nzNbg/7lnp6J/m67IsOu08r5Nkxuu1hTW8Ptb
   /3BTPZnGdoFdgF6IKhM1g9iYlwgfzn2F9xDRPxOYj/qOtVTqHbNUpVAlv
   is/jF3PXATKR+RcQxvPYO9yQXWjA859PK1hMusu8PhZlAAgv64qBirwPF
   Q==;
X-CSE-ConnectionGUID: nTJgk/y2T6SMZi8uR6GUTg==
X-CSE-MsgGUID: al3Pq7N5Rn2MMRcKqPPKRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35135407"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35135407"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:39:37 -0700
X-CSE-ConnectionGUID: SsRybWOSQ56/LtMdihn0sA==
X-CSE-MsgGUID: gd9/a/KITH2+Ip6Ta53C5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71377491"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.176])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:39:32 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Philipp Zabel
 <p.zabel@pengutronix.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Simona Vetter
 <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/ipuv3/parallel: Fix an error handling path in
 imx_pd_probe()
In-Reply-To: <1cdd8523443d8850c5531462b30064cb2058924a.1725651992.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1cdd8523443d8850c5531462b30064cb2058924a.1725651992.git.christophe.jaillet@wanadoo.fr>
Date: Mon, 09 Sep 2024 10:39:28 +0300
Message-ID: <87cyldmg27.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 06 Sep 2024, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> If component_add() fails, we need to undo a potential previous
> drm_edid_alloc() call.
>
> Add an error handling path and the missing drm_edid_free(), as already done
> in the reomve function.

See commit fe30fabf229f ("drm/imx: parallel-display: drop edid override
support").

BR,
Jani.


>
> Fixes: 42e08287a318 ("drm/ipuv3/parallel: convert to struct drm_edid")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/imx/ipuv3/parallel-display.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
> index 91d7808a2d8d..6d51203f7f0f 100644
> --- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
> +++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
> @@ -350,7 +350,15 @@ static int imx_pd_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, imxpd);
>  
> -	return component_add(dev, &imx_pd_ops);
> +	ret = component_add(dev, &imx_pd_ops);
> +	if (ret)
> +		goto free_edid;
> +
> +	return 0;
> +
> +free_edid:
> +	drm_edid_free(imxpd->drm_edid);
> +	return ret;
>  }
>  
>  static void imx_pd_remove(struct platform_device *pdev)

-- 
Jani Nikula, Intel


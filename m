Return-Path: <linux-kernel+bounces-182132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50958C86FC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136241C21DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552FC5026A;
	Fri, 17 May 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajKUwR6p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D84CB58
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951556; cv=none; b=PPacnwFrN9QpgtYjEnW3JDQpt+8sMszygRZdTjOO8JhngaDXL0Abwje+4xRAkjQhtiSz5DclS8E+gkwbF1LvP19y+lRNRfRVY73+RjJhXTlp6PEymaFRjqypH+8nEwyNi2r7c4q0XLWOaNQjtj9KATX069vjKcqrrgtq0lNAfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951556; c=relaxed/simple;
	bh=l0WqPcqTQgVaAzmNxD6JX2r5Eh/yljNSAf1J/7nvt1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQAxvawBYiJlAyVyex004Wwkhoc4iuzcw/NH8ersYeDGhrCKVOHWxz0TB+Ce/rDUXTx1cLJKZaxVNolBhhXBj5i6H2lBs+iQuwR6655+OKdp5hdThUkOXATeeqd01lAoQKK1GFLwbYBgcSvGG9WIoGg72lMCRO4ktsabMdFEhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajKUwR6p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715951555; x=1747487555;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=l0WqPcqTQgVaAzmNxD6JX2r5Eh/yljNSAf1J/7nvt1I=;
  b=ajKUwR6pKfujcz1misIbpnp/qZZoxkHSfzMQRjhw62TOYrweyLni3M67
   lbVMDzwIOESVY3mbPQn1XMcgZAKLPvQDgPIumr5TGwrk1mox1hoY3dklH
   Bpf7JreiwiLWeeJrT43qVpjNrVSq0pDvJnQTZlEQaTOVdjJBhCXkESZLZ
   Z0hbaoyEquouTp/Spwf95wRgNtajFzzByaHac1yHQBJEDMBx3j9P7o2CI
   Hh7GIJOvWqtHii17cbvDR2hYdOq5DfMKI7wcvukf4iTw0Z07lDu3Oi9xX
   OJBHpdjdFd8G90k/bM77UDoudCL4mNzI0OVafRt3uHft7yGAVQ1GIbcoa
   A==;
X-CSE-ConnectionGUID: HlPe7u76TA63LzowdKDnQQ==
X-CSE-MsgGUID: wCjBPMXlR221bCoMr8Oh9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15075810"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15075810"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:12:34 -0700
X-CSE-ConnectionGUID: IVmxoqt/SgKVr9xBIY97ow==
X-CSE-MsgGUID: uaZ5srhxQQWZcqEpN/Om1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31778077"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.32])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:12:30 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Michael Walle <mwalle@kernel.org>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH] drm/mediatek/dp: fix spurious kfree()
In-Reply-To: <20240517093024.1702750-1-mwalle@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240517093024.1702750-1-mwalle@kernel.org>
Date: Fri, 17 May 2024 16:12:25 +0300
Message-ID: <87v83ca8g6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 17 May 2024, Michael Walle <mwalle@kernel.org> wrote:
> drm_edid_to_sad() might return an error or just zero. If that is the
> case, we must not free the SADs because there was no allocation in
> the first place.
>
> Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index 536366956447..ada12927bbac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2073,9 +2073,15 @@ static const struct drm_edid *mtk_dp_edid_read(struct drm_bridge *bridge,
>  		 */
>  		const struct edid *edid = drm_edid_raw(drm_edid);
>  		struct cea_sad *sads;

I suppose I would've just initialized sads = NULL; and be done with it.

But *shrug*.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> +		int ret;
>  
> -		audio_caps->sad_count = drm_edid_to_sad(edid, &sads);
> -		kfree(sads);
> +		ret = drm_edid_to_sad(edid, &sads);
> +		/* Ignore any errors */
> +		if (ret < 0)
> +			ret = 0;
> +		if (ret)
> +			kfree(sads);
> +		audio_caps->sad_count = ret;
>  
>  		/*
>  		 * FIXME: This should use connector->display_info.has_audio from

-- 
Jani Nikula, Intel


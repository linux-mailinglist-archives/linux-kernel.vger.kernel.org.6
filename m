Return-Path: <linux-kernel+bounces-194329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6A8D3A49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F261F221A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3617BB2A;
	Wed, 29 May 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKGHdjEO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043951B810
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995262; cv=none; b=DXOvHIirATo1vczDVEMZGc4UGbQnHzVpnzXOLDYib/2A9POViuQXoVRdLC+WBrUXDVUyeRwhmutjPmg6qmWN80E7OImd+rBZVZB20Bcesd0apUA+3aTNUBqMRzHbrN3IUTrfefJmWTNJcJEreyv9P0Cpi60DljdYeFe7Gt8srR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995262; c=relaxed/simple;
	bh=8NCxyuhk/DvRQZs56hKs9VP7H1rlq6S6aGdBa/JK6V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peR9sgEfU6tbh6HfnlUmjLZ4LhmvXvSqYlpmakh47xseaHg5PzzyV5mOqafvBSyP/1galzdUwyQeIKosqpYeC6jlZG1SU2bsJIwB/hmOgkJatdgL8puzzpM7/xNc9+Wn3BjTjS2OdwatKieRbHocFU+vwUv9jAAerfc0gAl3JAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKGHdjEO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716995261; x=1748531261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8NCxyuhk/DvRQZs56hKs9VP7H1rlq6S6aGdBa/JK6V8=;
  b=TKGHdjEOCGZmGqF0C45c9CYO/F+1TeTa93edX8yesrRA2pIP7OqYF8sc
   SwYNwsI6ICsm3NrxP90BeBeRkQOASyXE+OleD/CYXL/O63Tqbxs8wq9bK
   MD78/xiDJ8CWDM/yU5nhMaqYRu81OBZngduP8ar7CNTgyXuHsVe1TnAlH
   ZfVjF/v4rWfMANXfdOjXAymO//RPHugsjDcmJ8WAYo1YzG0PtQTQAclYG
   G1mj7PXI0qj0KdOJQREcV8fTIOKydVAUgzgf8f1UXlE8RrcSBto2l8miM
   xEjpVue3jf0hjXjrFWab9751wNOSV9hQ6GAna8ZlF+HknMtCJGXLHCwvc
   w==;
X-CSE-ConnectionGUID: hnziUOaAR46Sf2QWsW53uw==
X-CSE-MsgGUID: wM68NFaPSQOJow2qqlCYoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24819793"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24819793"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:07:40 -0700
X-CSE-ConnectionGUID: bnXjTNTmR+mDKtjNtmNCeA==
X-CSE-MsgGUID: EkBjuKfeSd+OG1JEkKDtyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="40466931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:07:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sCKtl-0000000Bq8n-3YxA;
	Wed, 29 May 2024 18:07:29 +0300
Date: Wed, 29 May 2024 18:07:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, jaden-yue@ti.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, kevin-lu@ti.com,
	yuhsuan@google.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
	cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
	savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com
Subject: Re: [PATCH v3] ASoc: tas2781: Enable RCA-based playback without DSP
 firmware download
Message-ID: <ZldEsZ7aSFbHOhd_@smile.fi.intel.com>
References: <20240529103543.2089-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529103543.2089-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 29, 2024 at 06:35:41PM +0800, Shenghao Ding wrote:
> In only RCA(Reconfigurable Architecture) binary case, no DSP program will

"...RCA (..."

> be working inside tas2563/tas2781, that is dsp-bypass mode, do not support
> speaker protection, and audio acoustic algorithms in this mode.

Some minor issues below.

..

> -	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
> -		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
> +	/*
> +	 * Only RCA-based Playback can still work with no dsp program running
> +	 * inside the chip?
> +	 */
> +	if (!(tas_priv->fw_state == TASDEVICE_RCA_FW_OK ||

> +		tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK)) {

This line has broken indentation and I already pointed out a few times to
such issues. It makes harder to read the code.

> +		dev_err(tas_priv->dev, "No firmware loaded\n");
>  		return;
>  	}

..

>  	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
>  		tas_priv->dev_name);
> +

Stray change?

>  	ret = tasdevice_dsp_parser(tas_priv);

..

> +	if (tas_priv->fw_state == TASDEVICE_RCA_FW_OK) {
> +		/*If DSP FW fail, DSP kcontrol won't be created */

Mind spaces in the comment.

>  		tasdevice_dsp_remove(tas_priv);
>  	}

..

> -	if (tas_priv->fw_state != TASDEVICE_DSP_FW_ALL_OK) {
> -		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
> -		ret = -EINVAL;
> +	if (!(tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK ||

> +		tas_priv->fw_state == TASDEVICE_RCA_FW_OK)) {

Broken indentation.

> +		dev_err(tas_priv->dev, "Bin file not loaded\n");
> +		return -EINVAL;
>  	}

-- 
With Best Regards,
Andy Shevchenko




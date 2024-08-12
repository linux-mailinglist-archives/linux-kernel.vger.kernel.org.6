Return-Path: <linux-kernel+bounces-283412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5924B94F220
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7092D1C21245
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0AF186E33;
	Mon, 12 Aug 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvwwVvP6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E3185E7A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477926; cv=none; b=QktXCNMvbCUx25bUAMn0atipK/gXF5OCUvsMCgjuxIvrJOusJ5Iam2ZgLHc0rX3w981HDXVvjTuAhgFNjIcUjNJC1i73Mi8m7Mb2b12KpssHp/IRvHUi5CWuoeoAGf/dmIssbbkr8ve7poxisB4ORyWV2mtYSdiBL+OE9ZilPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477926; c=relaxed/simple;
	bh=f6D6KfilWNxqFGG7pta2IfyAR3ZAQv2fXGry/eHPZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivqzaF1qQ9Rqr2/Py6kSK21ImI4DIN9axaYQxtFUvwrPNgARjRxeSau4TXArHfENYQwJ38Zw0PkdkGdAeq4QdjxflG5SHQfn+liPkd2H/0/caa5+OJj20vBBmtMs9oJRrjmth5d0uBjLVG+Jdco23s6nzsCPClskhLsP5PLsBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvwwVvP6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723477925; x=1755013925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6D6KfilWNxqFGG7pta2IfyAR3ZAQv2fXGry/eHPZP8=;
  b=nvwwVvP6JZotufN1a+iYL4AdFSlpyW1CPWjIJ+JIYxCB3ZAzGiD84lJQ
   9OdONTcq90wFGyjmVReUNz08JqAh1zGeXs1mRTVv9Np8UpnQMZhNCWElQ
   ixT2boFBxjYJjvozLiiu9FViMM2SiRiYiRjgVQaW9WtAuxh9QGRMDXvz+
   ik85S8NH9Tmh3WAX0dPpV65O1Ub+pnv+IXJ+9BbqPDRF0zUMDCjaWpIRG
   qMx3DYpHPuweJ1k5EfihFjzI7vkhjKO6HO66aMNft54oK/IRNOUcFIiYZ
   OkkzTJlteZBo1pq3RIjpDl9avp0PBohQ8fQ2yI6YJgyDSwLIojxQiMYw8
   Q==;
X-CSE-ConnectionGUID: PqeubxzfRmuZGcArGVBkUg==
X-CSE-MsgGUID: GLPEAZtTQSu5i3Evcf65Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46998572"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46998572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:52:05 -0700
X-CSE-ConnectionGUID: dF09Li77Si6p46koOzuKYQ==
X-CSE-MsgGUID: 8XzTmcKZRaeu6Y5GuMy37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="62959904"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:51:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdXKr-0000000EOvB-3Jym;
	Mon, 12 Aug 2024 18:51:53 +0300
Date: Mon, 12 Aug 2024 18:51:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, jaden-yue@ti.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, yuhsuan@google.com,
	henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
	cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
	savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com,
	jesse-ji@ti.com, darren.ye@mediatek.com, antheas.dk@gmail.com,
	Jerry2.Huang@lcfuturecenter.com
Subject: Re: [PATCH v1] ASoc: tas2781: Rename dai_driver name to unify the
 name between TAS2563 and TAS2781
Message-ID: <ZrovmRCPN7pc0n40@smile.fi.intel.com>
References: <20240803032717.175-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803032717.175-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 03, 2024 at 11:27:14AM +0800, Shenghao Ding wrote:
> Rename dai_driver name to unify the name between TAS2563 and
> TAS2781, remove unnecessary line feed, strscpy replace scnprintf.

...

> +	strscpy(name, "Speaker Profile Id", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);

> +	strscpy(prog_name, "Speaker Program Id",
> +		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);

> +	strscpy(conf_name, "Speaker Config Id", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);

Why not 2-parameter strscpy()?

-- 
With Best Regards,
Andy Shevchenko




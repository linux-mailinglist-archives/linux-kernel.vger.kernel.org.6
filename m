Return-Path: <linux-kernel+bounces-283497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F694F5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B228329E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DA7187FEE;
	Mon, 12 Aug 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ji8BeUJL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381C18784F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482738; cv=none; b=eD8VvpOuqMGMfpZfW5MsWWY0Qn5QPpVYYQhGfETppTsqfqaZLiThZWag1U5dcY78HLWrm5Q6oPDBQGt39uNqaYD4rWuJiXXYQAwoYy/X2f3ZXy3D5Cqkt1jNmjeUhRrKJwzwbdky0UF89cuxpbsH+1mHzuzF9HUY9LyZGU66m6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482738; c=relaxed/simple;
	bh=aL4DOc2Na+/OPEQw8CVeC4lC8QebtBc1CYlW3Jh60kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF3YxlgXsPGRFPsp4uD4AWV2fCcPT1PEHkUSbE5cpCoycGghYbbuiNWGi7pOVbN+WvTyT6Xlu+18DjG1gd1zeBB4LfmTmXIbgkZweUFwXkyRDcEZiEbWRjYR/YsedKmpuPpbKzgQTbH3IXyhrFhGJFRwCh9T1/7tyK7BrGEQzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ji8BeUJL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723482736; x=1755018736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aL4DOc2Na+/OPEQw8CVeC4lC8QebtBc1CYlW3Jh60kE=;
  b=Ji8BeUJLWFN2LVlQCD8aRYnsgqebe75RP1wN8j/Hgx3rTpyMO0Aj6Tv8
   o7DfN2BtnryqR1Zqnmx3YwQ4DafWYgMpOsmZY1QDKJD9a+IeWLwJNTUb3
   7r1moUadsFugbxhH56H3Rg1mWfH+vW+FSpN0VG9rJM6b8c47GPEVOuMGj
   puLA883mTYkW6fGpQgnJZBbd1pvriIZnGujWHRXsGiYJsYKUmgfmU8AgA
   4k664pS+ix0KXV5mjlTAPUq93AJ44+Np0PNRjTQnZ4GGiI+B9vH/XdpU4
   uB1Z8V1MfBDyroMOBhXpI9NF96xWBvTT+EQ9hSbPvwmokgxd24gDtZL0n
   g==;
X-CSE-ConnectionGUID: AMtq6didRMmvAM2LaSBw6A==
X-CSE-MsgGUID: pRbLxRLORievVBJZWL8U9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21772321"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21772321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:12:15 -0700
X-CSE-ConnectionGUID: 4tHKUzgKQ4O7C28hz8LUuQ==
X-CSE-MsgGUID: DU89H2vBR2i1FPoEZlh9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="81584021"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:12:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdYaT-0000000EQMB-1R2S;
	Mon, 12 Aug 2024 20:12:05 +0300
Date: Mon, 12 Aug 2024 20:12:05 +0300
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
Subject: Re: [PATCH] ASoc: tas2781: Rename dai_driver name to unify the name
 between TAS2563 and TAS2781
Message-ID: <ZrpCZfuNOdBhRMh4@smile.fi.intel.com>
References: <20240806041719.1477-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806041719.1477-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 06, 2024 at 12:17:17PM +0800, Shenghao Ding wrote:
> Rename dai_driver name to unify the name between TAS2563 and
> TAS2781.

I am not sure this is a good change. Theoretically one with the platform that
has a certain codec may connect the other one. How that will be distinguished?

If there is no issue for such configurations, please mention this fact in the
commit message.

-- 
With Best Regards,
Andy Shevchenko




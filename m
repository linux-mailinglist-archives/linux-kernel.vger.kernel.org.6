Return-Path: <linux-kernel+bounces-182158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE08C8774
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8661C219F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DFD54F8A;
	Fri, 17 May 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GV7WNW8F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7A3A1AB
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953835; cv=none; b=aFc/GrM1pH9KyLhPU98JNG1BCUBaCvL0D1X5BRO92UcG8KbZijazIR3HuPoncyxY07Qh4Nq+g7WeJt1BS/KN1E+7POLeitmp6ZKoTg7RmNwWIza7PiVqlQl1Yo2Dbln2a30+XfjUp5bZD/2E82KhN7kNqMJirfiO2OQBmLTwpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953835; c=relaxed/simple;
	bh=ODfwdvTQimudbT6DnhurRFZ2ReFlI+K49ICyTfTAtTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itJoXOGgpcpaUKeNpsR1errHFGq1ExHWDr77gjV5ct0hkzzwPGmYYs1m2kjCjXMGdqDmd1DdQuBcvQTPR8x3wY5h56L7H9fTNUtglR9S8IWB3FrV/jW2LNwNS87a4mP3BXZpMb0lIxCAI/Wjciw3xozaTg/bEn0/f8C+ELwFkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GV7WNW8F; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715953835; x=1747489835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODfwdvTQimudbT6DnhurRFZ2ReFlI+K49ICyTfTAtTU=;
  b=GV7WNW8F570eYsJLh6ZZMvas+Xs2etiUwa9m7Rko18wl7SKF1EkJNN71
   BCtcbLB3iyBriCjmnG1cJk2pTvNS+dmDipxGIrbldK1SfvhOUCzvBTzFi
   MMAP35kaOi3S+TWbvIqcHmTt3toq1S0YsH9BboWVaEjRLqV7Zake0uo9e
   LaWIBI85wwRC4yrG0sbiLz6hy5hw7rXdJOxMe1maim1nJv+6Nk7Zyn+AY
   +zN/sfYP1GFAjYUG0FHlir7Dn49gBRmSxwgnGwBVrRBsBBn5QB9D52YXV
   oGwS8vuIuGox3hr0tRIGM0/RFHkTQ1FuGVv5U2cppe9Zmwfbxsp3fRreR
   A==;
X-CSE-ConnectionGUID: SFDY13u5QsOzLd/Px0DoTQ==
X-CSE-MsgGUID: VKNS8Y86Qqm2FhrIUS42jQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="15958152"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15958152"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:50:34 -0700
X-CSE-ConnectionGUID: 8IW6Wf53RUaEgUUM3Y4NzQ==
X-CSE-MsgGUID: F34PdgxcR02OS8BQVFeGow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="36218183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:50:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7xyc-00000008M0C-0Cny;
	Fri, 17 May 2024 16:50:26 +0300
Date: Fri, 17 May 2024 16:50:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [RESEND PATCH v5 1/3] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Message-ID: <ZkdgocpiPpGKYVMo@smile.fi.intel.com>
References: <20240517092039.688-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092039.688-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 05:20:36PM +0800, Shenghao Ding wrote:
> Remove declaration of unused API which load calibrated data in wrong
> sequence, changed the copyright year and correct file name in license
> header.

> -int tasdevice_prmg_calibdata_load(void *context, int prm_no);

You remove a prototype before removing the function, correct?
You have for all these versions even not _build_ tested your changes.

NAK.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-412619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8229D0B77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CFAB224AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641FC190468;
	Mon, 18 Nov 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCAjbDPY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286618E76B;
	Mon, 18 Nov 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921305; cv=none; b=fq7HmuXPdg/AeVSI4AzZxvrm/fA45MW25F3yvHdf/UYsElq+BpYBGis1gibGPgZsG0nzNzT/N7iJysB/mqaTj7AWNrvEMqX+xlH3lpmbOKM9q2T+jRDcTBThDMsHLYS/uPWk4VVGgYXpzm2kZYVNAPR1G+n35yX+Y1tBOEgKvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921305; c=relaxed/simple;
	bh=hsweLRtdxxlWEJfa0yOmEaDHWMTkfchfXAvVurz+B+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKT3qUwPdFJc0jChQsI5cpJGItmM31G7AY8ypPCEYpCPYAUB76P7TVfLohE1ohBBPtoUfc7Tipw+ckRZDy6uS/ocLje9jrc/L4Z5ps+W53ShGnia5rNE6njFWLnrUjAweghfPn5pOtIl39/wjOadeLMcJPKYcJ6RUDTDSd5Amcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCAjbDPY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731921304; x=1763457304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hsweLRtdxxlWEJfa0yOmEaDHWMTkfchfXAvVurz+B+A=;
  b=eCAjbDPYONekNAi5C7AMRSJycj0l6ULs3ofswaw+Tqbq1oNc9ecK9FYW
   5dU/SF7IgdkH9Fley6RkANqggQ60nJ1WEeibmw2cN1olGGRkn7qnAoTe3
   aB5iGRbAjf3a4HKZKyshEUvWOJPA9A4KW2TqyeeL1dvvOl6lz5agXb5U3
   hCr1C0rssGfLqsZVgegkF/3DV6KWiSwQnvQpQDohFM+JS/n1CNv35ZHol
   p2S2vCH3kvhtGO5I/OZX4pYhGmXUu0qBFvcNH+nerbnbO4WpgsbHtSUin
   UNMv06irkJWENnxbxn9k5bpgDT0U5VWNsH+4M83SRqGr4XMPzkWdvx9x1
   A==;
X-CSE-ConnectionGUID: U0ABX8zgS0Ka6AWxd90ykw==
X-CSE-MsgGUID: dKhAHaJ9RoqOvm9xWb4Ovg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31793109"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="31793109"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:15:03 -0800
X-CSE-ConnectionGUID: ZfxZ5HzjS1q3n7W+maWevw==
X-CSE-MsgGUID: ZuEzSO1ZQdG4Zyh9tzXgmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89596050"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:14:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tCxqS-0000000FwoO-2Ky0;
	Mon, 18 Nov 2024 11:14:56 +0200
Date: Mon, 18 Nov 2024 11:14:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, shenghao-ding@ti.com,
	navada@ti.com, 13916275206@139.com, v-hampiholi@ti.com, v-po@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, antheas.dk@gmail.com, philm@manjaro.org
Subject: Re: [PATCH v5] ALSA: hda/tas2781: Add speaker id check for ASUS
 projects
Message-ID: <ZzsFkBruET6rXpup@smile.fi.intel.com>
References: <20241116075006.11994-1-baojun.xu@ti.com>
 <ZzsFZnWeEAbIjgbN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzsFZnWeEAbIjgbN@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 11:14:15AM +0200, Andy Shevchenko wrote:
> On Sat, Nov 16, 2024 at 03:50:06PM +0800, Baojun Xu wrote:
> > Add speaker id check by gpio in ACPI for ASUS projects.
> > In other vendors, speaker id was checked by BIOS, and was applied in
> > last bit of subsys id, so we can load corresponding firmware binary file
> > for its speaker by subsys id.
> > But in ASUS project, the firmware binary name will be appended an extra
> > number to tell the speakers from different vendors. And this single digit
> > come from gpio level of speaker id in BIOS.

...

> > +	// Speaker id was needed for ASUS projects.
> > +	if (!strncmp(sub, TAS2781_ASUS_ID, strlen(TAS2781_ASUS_ID))) {
> 
> Better approach is

	u16 vid, did;

> 	ret = sscanf(sub, "%04x%04x", &vid, &did);
> 	if (ret == 2 && vid == ASUS_ID) {
> 		... // matched to ASUS_ID
> 	} else {
> 		... // no match
> 	}
> 
> Alternatively it can be
> 
> 	u32 subid;
> 
> 	ret = kstrtou32(sub, 16, &subid);
> 	if (ret || upper_16_bits(subid) != ASUS_ID) {
> 		... // no match (as in previous 'else')
> 	} else {
> 		... // matched to ASUS_ID
> 	}
> 
> With it it will be clearer to see what's going on here.
> 
> With the above you can get rid of the custom constant and
> use PCI_VENDOR_ID_ASUSTEK directly.

-- 
With Best Regards,
Andy Shevchenko




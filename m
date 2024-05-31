Return-Path: <linux-kernel+bounces-197078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00D8D65D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C75B28345
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89678283;
	Fri, 31 May 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljssGUoc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB257CA7
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169568; cv=none; b=NqCtRQxb+fcrkVIs6OWtuiq7dRXd0VUD5q5hm8XGTk+K5OQNyzCqBPh5iep4Zv5SJc82lTk0fzh3f26ZEdVs8/uZhoF+G+gLt5uBPR28NIolOjVlcHQuBEXCftDuTQ2nQnDGuNft0dFhhNaLaeAT6obfSI5lomuhcK5Rp1mOmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169568; c=relaxed/simple;
	bh=3etIn3wD4YKQlTjuROd7Oo6lOSJcR3qD7Jk9Yz8CHEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl+v8JiBrRi/zFVTsQ2zCIKG21mDGQCr9A+lOKd4sHILWMHgpU8WAHDUdKZhbcUfmXQFx9lqGH1e+u8qyq+kQkXOk7UOgZ4GhVWCbunUb81V1EqE+gcE4zjrpW8JN6SK0jJzLfkfTeeBdi8IlT2kHraA5Nj1eEK/FWqhlpMuymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljssGUoc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717169567; x=1748705567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3etIn3wD4YKQlTjuROd7Oo6lOSJcR3qD7Jk9Yz8CHEA=;
  b=ljssGUoc/Z770mVpiAt3gMmVEyzz0Xoaew11Yt1u9wSbI/W+c68pItlq
   cyC9Gi8RV6Ysa3IWiXo+Nw78ARcA4RkuSy/GScr/yhk6s+YUVa2nkvfVn
   fRTs8f0nkW9wAb0tAActhCew7Zi7xsSafYOf1mrj+WW0fhNcrzQnGoTUM
   SvyyZVC7qNRxwCouxPKmsMq+kwvOx0wVo+pP2+Y0OetLS8oYg15mUe3ys
   RJekZtI0iR9PC3FVx9RVpetI6GCwRGv5Ge4za+hnlW+IiuBDpqLxI/7MS
   fXxTZJ3q7mvd3YfPi1KoN0zFGRw2GIkO2Gp3PR2+57P7hkmXpR7jP3DP3
   Q==;
X-CSE-ConnectionGUID: 7WgCMUM0QHy/TcujqGhpCg==
X-CSE-MsgGUID: Gg1oPcMtSquuqALCTztLsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24381268"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24381268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:32:45 -0700
X-CSE-ConnectionGUID: rKba3UEcT8ulk9qB8K/H8g==
X-CSE-MsgGUID: UksFEEPsQ/Or02YNbMKKCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41272597"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:32:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD4FE-0000000CVTM-0kXL;
	Fri, 31 May 2024 18:32:40 +0300
Date: Fri, 31 May 2024 18:32:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com, alexander.deucher@amd.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/resource: optimize find_next_iomem_res
Message-ID: <Zlntl4m8ztZDNGwJ@smile.fi.intel.com>
References: <20240531053704.2009827-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531053704.2009827-1-olvaffe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 30, 2024 at 10:36:57PM -0700, Chia-I Wu wrote:
> We can skip children resources when the parent resource does not cover
> the range.

> This should help vmf_insert_* users on x86, such as several DRM drivers.

vmf_insert_*()

> On my AMD Ryzen 5 7520C, when streaming data from cpu memory into amdgpu
> bo, the throughput goes from 5.1GB/s to 6.6GB/s.  perf report says

Also in the $Subj (and pay attention to the prefix)

"resource: ... find_next_iomem_res()"


-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-546412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A3A4FA62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89E118911D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F5204C1C;
	Wed,  5 Mar 2025 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDn06RqO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482132E3373
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167621; cv=none; b=pBtiTDywPSvjYNb/TlpgD28xlekzTKXodTD+vp4aYDalAtnmANO7jTKJmZmoo9Vbdfqw0HHLGhA26MOAUhOcx/HW0igkG3vZe9+FSHJXIIp0HsMvJ7VqTEVPpaBLXT/TXRzfQa+IZCUhzC0jqndmQ4suhZCcHZ5hjWlV0Plefus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167621; c=relaxed/simple;
	bh=ltIe6+sX2XLfMhxGQRcdRDD02h9C6oTeIcIfHmw2Kmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwPjSN+oSnmgeMtcAbkJzbapCZKfr4uIKfZIJ6YM3dre13yRka7SkeQmpkJlfpe8arWO5ERyJG7b4uoYlp7XS+pjYI4a4vObuOSkOIfl1PQtIoewAwKFNyowzdXC0e3GhW2ifi0k9r1cKcXi4X0yis3elrLWvLcMzhFEHM6/3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDn06RqO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741167619; x=1772703619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltIe6+sX2XLfMhxGQRcdRDD02h9C6oTeIcIfHmw2Kmg=;
  b=iDn06RqO1b6LMEjiwxoNw7N5SRqCqkxBDXqRNk26BOthsJfNCzJMfegC
   tvfn7PB2NJCkDNbJqa92P7s7mOPsrVpe452uCi8mBhy0EREQGRVK8hVLR
   fT66iF8Azp2LOnGaVi5jWBM6Pwup8cM2bZ+0dPaWOy5ir0ZJdp8zsq8mN
   lBbOO9G1EKmggOMcXg+pS3HETqwgyABNRVHCEh29d/yZgqQrQ13wucMCI
   2VQ8qB97IUFDoCSFkfKa8tjaZZHwAC8rEnRzA53BFSVtxibLpiCFV6wAG
   r9oa7rmH7hw3kq78Ev1kxpM2zJytrCb0HU4xzc2u4/0DTWgJSCCrtFoat
   Q==;
X-CSE-ConnectionGUID: MTiFIOOlRYK2IzmE5ofjrA==
X-CSE-MsgGUID: D/trHtsLRxm6OigfEo9lag==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29704414"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="29704414"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 01:40:18 -0800
X-CSE-ConnectionGUID: C6OGLUocTKCwmkM/rtbLmA==
X-CSE-MsgGUID: Lsq9q/FbQ5qX8ptOUc2Urw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149600868"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 01:40:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tplEc-0000000HN5y-1kGx;
	Wed, 05 Mar 2025 11:40:14 +0200
Date: Wed, 5 Mar 2025 11:40:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	"Avizrat, Yaron" <yaron.avizrat@intel.com>,
	"Elbaz, Koby" <koby.elbaz@intel.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v2 1/1] accel/habanalabs: Switch to use %ptTs
Message-ID: <Z8gb_kzQ7COAUqnB@smile.fi.intel.com>
References: <20250206192109.1133364-2-andriy.shevchenko@linux.intel.com>
 <87jz94y5zs.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz94y5zs.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 09:01:59PM +0200, Jani Nikula wrote:
> On Thu, 06 Feb 2025, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > Use %ptTs instead of open-coded variant to print contents of time64_t type
> > in human readable form.

...

> > -	char pq_time_str[64] = "N/A", eq_time_str[64] = "N/A";
> 
> The "N/A" gets replaced with, I presume, "1970-01-01 00:00:00" for 0
> timestamps, which is not the same thing.

It's used only in dev_err() below which is why it's fine to update.
Should I mention this in the commit message?

> But I honestly don't know anything about the driver.

-- 
With Best Regards,
Andy Shevchenko




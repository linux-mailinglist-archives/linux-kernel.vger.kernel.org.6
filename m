Return-Path: <linux-kernel+bounces-544426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFDA4E104
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4535317C2C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7B207A04;
	Tue,  4 Mar 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5DLoMbT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECE205ABF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098561; cv=none; b=Fcydduvl+r+laoiwhbUXn9hrYDX2yaq/x1xgDl6LrO+RCFXUdI9V0c38R4eQDaYAU4sqcYQWDyJ+4IO9UuHYf4Aw7WBUJ3G33fo6PKq+6tbL5Do3v/VL9INj3cWM9zlkI5AGfOm+n36+jV+fyAF50kKM62BeV5Rmn/5Gkyn3AYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098561; c=relaxed/simple;
	bh=3e3sQ96tLZG66aQqbqepGDQz/NVKyHKYzJ7qHtLjkjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSKQM0H1exU99YeJyfTUyJ1BsOlpXwb94lCir7tXP7D0wQkZb13aNoc8lkI2k8vHdayIiIHGHtG5mv+NKObw9RqEf+1IAyC47VP7XXTxjATRWQGP5m/xiCWPYFwyNUGC+qeuF7LFiFeJcEPTpz+GKmSuxstoHtMgIsNVnTr5ztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5DLoMbT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741098559; x=1772634559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3e3sQ96tLZG66aQqbqepGDQz/NVKyHKYzJ7qHtLjkjQ=;
  b=b5DLoMbTY5ELsiuplUIZrG5ZCh+TBOfqaTJ9ts4DtgZ8a2aC0frcl7qf
   iFYtVRyEc5753JrxA+ftKHLY2GPWRZOrzxQcAh2uJf61TAQZwu6pG1rZO
   SoUEWL5mMSqpBZOOUlqUW1RazE4JzcAWUWpBI1ZrhL2LKKdbeCXP9wtdP
   9JjiTw+Hgq8WEXXNLHLdjs9urohFR/bymDkqoqBDdK4QoIP+z4al6VLCw
   /Jw9ymSwK2PWGkitKr/fe0QcJwDRwhHpwgbl9OZknD60wMd/ZatcztE0m
   Zu/kHAhocq3TokpGrWVUdDzjuCWBmxoEbkkHvoSoFyXLLJi66POBtXBxm
   g==;
X-CSE-ConnectionGUID: RvzdX3UiTAy4/hKncS4WQA==
X-CSE-MsgGUID: M0UTP8BaTp6GdXD0hJPtqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52656283"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52656283"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:29:19 -0800
X-CSE-ConnectionGUID: heZkHEkGTi6baM8PhofbKQ==
X-CSE-MsgGUID: mTRWaLoSSVONI4aPfYotQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="141612565"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:29:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpTGl-0000000H9Hl-3YF9;
	Tue, 04 Mar 2025 16:29:15 +0200
Date: Tue, 4 Mar 2025 16:29:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 0/7] auxdisplay: charlcd: Refactor memory allocation
Message-ID: <Z8cOOwXT3SUPpaM_@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <Z8WE42W4WBt4c0qG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8WE42W4WBt4c0qG@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 12:30:59PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 24, 2025 at 07:27:37PM +0200, Andy Shevchenko wrote:
> > The users of charlcd_alloc() call for additional memory allocation.
> > We may do it at the time of the main call as many other APIs do.
> > For this partially revert the change that brought us to the current
> > state of affairs, and refactor the code based on the original implementation.
> 
> Geert, if you are okay with this series, I want to proceed with it today.

Pushed to my review and testing queue, thanks!

P.S. If you think this shouldn't have been done, please tell me.

-- 
With Best Regards,
Andy Shevchenko




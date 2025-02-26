Return-Path: <linux-kernel+bounces-533944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329D1A46099
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F9F3AAD13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D9F258CF1;
	Wed, 26 Feb 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmX1z1PO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB421930E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576082; cv=none; b=APwYtqtzWkn6KM6s7WTz+4P51Ts30oYyWpBKrlfLVpnk6qT7uTjhljqrVbd3hSxfLnshDARqZOjfxjyEMtvZSClzn2tF5hd+cQ5U8gMSkNnnz0tp0pSBSD8chrdJwHEdewl4ZMYUa5YpR2iBafXJWX+GQ0n5R1jVXcUUuygg0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576082; c=relaxed/simple;
	bh=6euHJfox0e0l2tuWVzWUNGuLH97SMFfgyjkGT8aGx1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz0tM8Gv/2ulF+dClXlxzgp5HIY65HP9TprgftZZt77HbCG8MlJ1QbJ5G5jInMX+oqY5zhIVbuXtMK9tlfjQlIHWjiewwdOZ10yxyMmyvBRgmQBiehsppLe38PLBxuWFxh+5pY9sBeBs00H3maM9n9RH+Pb1BsCTUQ9ikM42eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmX1z1PO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740576081; x=1772112081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6euHJfox0e0l2tuWVzWUNGuLH97SMFfgyjkGT8aGx1s=;
  b=MmX1z1POLRopYyB1xQoejdUHIL6QNiCwCY1JwZtjgXHdtTKk2sf4heSj
   FN/Jw8k0oEHepzHK623VWLw++Lj/hZ+UcHrClA/6CfYUrxHf3m/XKv9QY
   1PPQ5ve/0PAVGdap9y8Cfc1JDsfdkl42wbnm79Oe1XNkFdXSB5PJAAe78
   fIRTzUqFZIJPEkDf0V10icdUXK/hi6/eEQh8iGBLR2sepSXmT0SPgCPal
   kMCFl7I/2I9xt20kOrCMJYL+SF31lWKE4Z8L1ATrtG1u7cdEJ1t45aeTl
   yu53RK2GAvyfBG2Km9KOXghaHvfisaR3Sl7beWb5r10BG0JGEWPaGnn2M
   w==;
X-CSE-ConnectionGUID: hsojORCOSqmLSqlJLKmXxw==
X-CSE-MsgGUID: PfE4ScHpQQuhvxd4224npA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41615329"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41615329"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:21:21 -0800
X-CSE-ConnectionGUID: c1uFttXDQzGV1g6bwIamOA==
X-CSE-MsgGUID: p4XYpNa2Qr+7/2Fknb5fQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120810105"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:21:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnHLg-0000000FKhD-2FiA;
	Wed, 26 Feb 2025 15:21:16 +0200
Date: Wed, 26 Feb 2025 15:21:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Introduce Intel Elkhart Lake PSE TIO
Message-ID: <Z78VTGTKdUoQxjjN@smile.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226061527.3031250-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 11:45:23AM +0530, Raag Jadav wrote:
> Intel Elkhart Lake Programmable Service Engine (PSE) includes two PCI
> devices that expose two different capabilities of GPIO and Timed I/O
> as a single PCI function through shared MMIO.
> 
> This series adds MFD driver for them and extends PPS generator driver
> to support initial PSE TIO functionality.

A few comments here and there, after addressing them
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(Nice small driver, thanks!)

-- 
With Best Regards,
Andy Shevchenko




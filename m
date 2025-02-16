Return-Path: <linux-kernel+bounces-516794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027BA37776
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E23B7A37B6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77881A23B9;
	Sun, 16 Feb 2025 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVXiBV3s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81219ABC2;
	Sun, 16 Feb 2025 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739737506; cv=none; b=Z+E8h99/9VyKTNyRM0PAyDXKGP74vB5YH1njat05pfFeryL0UniuvjQb0oserz4XxCEewO7U3w26KR+XfYSKoTuJlxTj79NYta7ViYbfv96yOaa32dCI2xNt/BL9YOrX3HFam/ZAudL7q+xS6hfXkekvxG2MOAd8mrtku5vbMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739737506; c=relaxed/simple;
	bh=i81roCFL6So/zqD17WYXXv/Ly1YSkln3Ezb7GmQSuJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+g6kagaKLS+oeX+C+PU5QBGOOiWgJYKPejwjq04Pjez5yfN1GU2eNAru7RR8/NGmT9OU5t1/j6c55jfGTfqI6mRk0ZwhuUYsAUH3bu51jkAFMkejWxKCgl5IHEPzn5yy68Hv0ImGfjuDQ5j6B5M4iFg21Omz0mj8EyAFwOAIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVXiBV3s; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739737505; x=1771273505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i81roCFL6So/zqD17WYXXv/Ly1YSkln3Ezb7GmQSuJA=;
  b=VVXiBV3svZTRQvksWT4T4aiXGlZmiG5cv9QROFIJrVBFR9wFUx1f3gEL
   My+KNzy0fY5L5Od33TN0wIZ//eU4fEF+5zUcS2UC6DC0D8QPRWf34sT5Z
   sIJGW2pAckiJmLlrs0d/IHtw4wWtQR/DG1TtC8PFDJY3RtQwmIDjmsKYr
   vkASjMHwN1uq665KHOQklm1dgt9+i5rzy7jpegwruSI9z9KkoWDOxtZVu
   /oBVUENhIgGhscKA4e02wjutovwPFfl3bOAnjcD0W0xbTPBYSN6uOpvJZ
   RKab9dauqRLg1ppDtq17qZyIT8s/EDDbnGEzotz5k5vH3d05NcuBk4xgr
   g==;
X-CSE-ConnectionGUID: gMRetDlOQ2O19gwEWLP1Aw==
X-CSE-MsgGUID: g6cFHkkoTjiLaBIwMwLGUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="44074211"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="44074211"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:25:04 -0800
X-CSE-ConnectionGUID: QbLNZGg0R7WQrApl1ECy3A==
X-CSE-MsgGUID: qVbi/pFvRdiVYIJv5Y49og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="118957889"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:25:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tjlCF-0000000CCud-0xEC;
	Sun, 16 Feb 2025 22:24:59 +0200
Date: Sun, 16 Feb 2025 22:24:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Dell.Client.Kernel@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] platform/x86: dell: Use *-y instead of *-objs in Makefile
Message-ID: <Z7JJmrEZgTNPf0h0@smile.fi.intel.com>
References: <20250214214535.4947-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214214535.4947-1-kuurtb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 04:45:35PM -0500, Kurt Borja wrote:
> The `objs` suffix is reserved for user-space tools. Use the `y` suffix
> instead, which is usually used for kernel drivers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-196987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F68D64A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528F528B600
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6D4502D;
	Fri, 31 May 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnTIAWhJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393356B72
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166264; cv=none; b=Bhgx+dhZc4x9QXRwN9xKttLNPdYfTh6brqt8Z6+ltYo1cfggKBFB8RT0NPEgXajaDP3Tb20sPBbat9qksAgENeTUIs+8KGG6XVLirv1GHEknzT65n7K5nKCzEp8NMDM6oVCx7gjmmbo7zUBYRH6iHyqOXdM66zr91hTtSBb6xZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166264; c=relaxed/simple;
	bh=ZDkJWsKuRsIB13066wXBANOEt7AznJtjUIgAa5lPAuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kN2YOv2OfFqwuenTv0lEMo4ZI9V5p3hXEWPH5wS2SXAS6hVB2NjHC+ZfC/fS+qBufNPFlvUtQgfiUgnljmrNnzP/n/8KlGkYPSnqISTN2zZA32dotWtUvjzVZ63p07e05cqDrkL4cgqD2CH3QWQatJVR4NYHKDFbgM9VwM8VQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnTIAWhJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717166263; x=1748702263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZDkJWsKuRsIB13066wXBANOEt7AznJtjUIgAa5lPAuU=;
  b=jnTIAWhJy+VygMXWyHHGnlRwBiv2T10LbdvFwbt2tgHmQh9G09u079qc
   E7EztxD/gU65+GLcLyNkwZc1HZlFjVubC94aO+48Lt2Ye8Halqy+KrJxm
   LwgNfvfnnp6T/r+Ha8BU0SaT9tpKWBubkU/L9X615BTcaHqFsoJwE9KtW
   LHZKTtlWlwVdR07KsnMA5vb72sU5jtj5LvPM0aRb4GX68RR7u3ccuu+oE
   0K3U2AQ4riuHDVc8Kz6SnaB5yZfEIkJaUmmeYzkpja0Z7jtZhxlJB23Xg
   SzzEw7jvg8t9w4mRzA7gXi4wFzg/v1YohFOLN8+d3hokGSlQ1BrwGMf57
   Q==;
X-CSE-ConnectionGUID: iI9HgLBRSRGwXaOjUG4bBA==
X-CSE-MsgGUID: IGlGdiymSRym6xnYKaN96Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24342315"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24342315"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:37:43 -0700
X-CSE-ConnectionGUID: m+dOA3naQiWTFZRcfNCiqw==
X-CSE-MsgGUID: xwusO/uYTtaB5bUkOCNWqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41262097"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:37:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD3Ny-0000000CUge-1w6O;
	Fri, 31 May 2024 17:37:38 +0300
Date: Fri, 31 May 2024 17:37:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mfd: intel-lpss: Rename SPI intel_lpss_platform_info
 structs
Message-ID: <ZlngsrCqPd9PYHqt@smile.fi.intel.com>
References: <20240531142505.1888-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531142505.1888-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 05:25:05PM +0300, Ilpo Järvinen wrote:
> The driver has intel_lpss_platform_info structs for I2C, SPI, and UART.
> The I2C and UART structs are named with "i2c" and "uart" in the variable
> name, whereas SPI ones do not mention "spi".
> 
> Rename the SPI related info structs to include "spi" in their names for
> consistency and to make it obvious in the device ID list what kind of
> device the line relates to.

No objections!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko




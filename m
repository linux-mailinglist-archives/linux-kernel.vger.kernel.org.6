Return-Path: <linux-kernel+bounces-395119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423329BB8CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFFAB22D86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F021B6D14;
	Mon,  4 Nov 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQYyjqz7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5F1531EA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733677; cv=none; b=C+90bibUbI4EXM9DNkeiyiZOL8D9nfACgijla3AfgRsy3Ia2gCOZORWPd4A69QvlSpoqij4leuPh51UIoXc9+PMpZ09PGwLcU+ZXypp/qeLINcGEfYtudjD452VxzWNVilTkSZR6SBwtt1I+hMJJpJd9kopvqNQZTD8LH5TAmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733677; c=relaxed/simple;
	bh=GM3dCT2bf3OfPI0/FvpvuPzWbDGazowsyQIys7EwW3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd9/J96MCsbDdFQNvEHldhLg9N3yI9IEdA/NvO5o/MS9PDaDGg9/BekCqdHzl7osWg+i7ONTs97rxfKiXpMl0IGo7OelxlsxhWwxV3xR58Qnq3xMDeXcHR4tlLqvco6sAGf88Bh0mcO1+SJekSQ+KWT2BowyYdkRMiXPrbkKMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQYyjqz7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730733675; x=1762269675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GM3dCT2bf3OfPI0/FvpvuPzWbDGazowsyQIys7EwW3I=;
  b=DQYyjqz7cIR4AaFd4q3VqMip7y11YiQOpgd314WSuEPly5r3IAmyom4h
   Xj8UJ/L427DIBtxY97jPAu7UpMjF1bJ1hihppJjG9TCoYIJ5jwM7HSeww
   kvGRbn26ZSFXclsJX3bVs8rQzCrbsRYNl+ssgoQhwYcgGMc7iwT//mG3R
   1JxuQrPqRQK0AS1jM9FBBbyXwC6VZsUTxRkCIUIoW7zeYq7pu6+ArIISS
   6PAF0rLCq6bBkrSBm3bxAliHwepYxhHmZ2sYKWc6g5RJekcuL7x1Jk5CW
   IVfK8PLdMoWFRLoa4CGrGFtlbe+huwJA8XTMbFdS2MOfzlrcC2fTQOvZl
   g==;
X-CSE-ConnectionGUID: uaAyYPUZSS+MGXzkytRG7g==
X-CSE-MsgGUID: iG109w01Tw6ibcMHMveRsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30547737"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="30547737"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 07:21:15 -0800
X-CSE-ConnectionGUID: Z7VzWAR4Qde7Z4HCxgVYEQ==
X-CSE-MsgGUID: TsjBf0YTS1W4P/U7Nn9p6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84129573"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 07:21:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7ytD-0000000B6ns-29K3;
	Mon, 04 Nov 2024 17:21:11 +0200
Date: Mon, 4 Nov 2024 17:21:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mfd: intel_soc_pmic_crc: Add support for non ACPI
 instantiated i2c_client
Message-ID: <ZyjmZyPEIMveVMfJ@smile.fi.intel.com>
References: <20241104150655.41402-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104150655.41402-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 04, 2024 at 04:06:53PM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of my series to add support for non ACPI instantiated
> i2c_client-s to intel_soc_pmic_crc.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-399473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0364E9BFF66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7B2284247
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166B19ABB6;
	Thu,  7 Nov 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRAIeBa2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180981993B5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966001; cv=none; b=rGsi76RJRdLK/4Lw4Xo8W+9gNwzh92jmeauT8uMnYj2vzPflzkRvBIRDolPCde0R5ntT6RcY/Ty/TYcH6cUnHlTgwcLWCufF1psky+u202VsQ+/bKm7+kal+SQ4p/JBkTjLa72P0B/1QVIHPDkUDW5dVz1BIBaIG8PBrwTCaktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966001; c=relaxed/simple;
	bh=h12b0NIG+Y+jRjsmo182JrNVERf3zIQ1JvHt74Wvc88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNPfw08beXdGpBP+MEniH3HSWewkuxyuJosgRd21d16XUa6IIII9jS7M7aridoH8QD1xMmPwcc9xXi6bvArEKEFVJAXOAZHfjlExLbW26SQn1guZ94DnSGcqaDGhMaeasM1Gd90GCHXWCapJOy9tFkq9G095N6G9HfLoLwQoHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRAIeBa2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730966000; x=1762502000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h12b0NIG+Y+jRjsmo182JrNVERf3zIQ1JvHt74Wvc88=;
  b=nRAIeBa2V0qmxGsAgoFpayiy4FhSK33W7nZkcnywFOPnhXJi+Be32tlv
   0TtJIUfI0FTR080WVfHi13nhi2ljjDTYFIGtF4FUpjZOSKQHmF6KZbdxe
   llQ8alMIHeOoEkIV9m6I2+L6TEqgR7cHjtTcDX6ORdh8nXoX15nDY7g/A
   z/B4lYqPLSfeNHWiczOjSEpLuEAiRuyT5t5tsty7RQq/4hqdatgxe9xca
   78KziSMKjWwQHfg4wy91nfwkvOdyNxQzMJRC9IdHU0k6iv2NuT32GN3nl
   Oym7G5x7JTI41mnIj5PRELe1KP4ZmrkjiqgovoQ0eqs0Y1a5n+YTgUIIl
   A==;
X-CSE-ConnectionGUID: SRajseVhRYCuj/J2g6Gzew==
X-CSE-MsgGUID: OADNfCL2QvCsDVoMrOdXBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41392186"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="41392186"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 23:53:20 -0800
X-CSE-ConnectionGUID: osPqPrvqRuO3AQv3Ym+Kgw==
X-CSE-MsgGUID: Tbq4Y+MZR2+MGk9zh7EIPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="85388870"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 23:53:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8xKN-0000000CAyv-3kda;
	Thu, 07 Nov 2024 09:53:15 +0200
Date: Thu, 7 Nov 2024 09:53:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: intel_soc_pmic_*: Consistently use filename
 as driver name
Message-ID: <Zyxx6-l_RxbXZnCG@smile.fi.intel.com>
References: <20241104150655.41402-1-hdegoede@redhat.com>
 <20241104150655.41402-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104150655.41402-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 04, 2024 at 04:06:54PM +0100, Hans de Goede wrote:
> Currently the intel_soc_pmic_bxtwc, intel_soc_pmic_chtwc and
> intel_soc_pmic_crc PMIC drivers use more or less free form strings
> for their driver name.
> 
> Where as intel_soc_pmic_chtdc_ti and intel_soc_pmic_mrfld use the driver's
> filename as driver name.
> 
> Update the 3 others to also use the driver's filename to make the naming
> consistent.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko




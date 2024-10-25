Return-Path: <linux-kernel+bounces-381767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7C9B0401
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BD51C2278F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AC7081F;
	Fri, 25 Oct 2024 13:27:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE937212163
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862874; cv=none; b=oc+Sh+SR64Lm/+Lc1joOJsqg9gmLooyEO7XYqc5ljpG8qTuP8PC2622Oo5BlP34J08FOC7A7u2MsZ17FxZnWAwu4fCmTKCb2GDbkWyi9REVjyuLSpo+1qDhoNXdOBH+JyVlKudc9jZCN7OqC+MgaM/HoNcEb32CVIqQy5p1BVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862874; c=relaxed/simple;
	bh=YgmNlNpDv38rSkr31Q2JhEJBCLoRadnU8thJmyMYviQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWYy7uNs2K1LooXQP3pHa/f1bpHUgZdLVfezKjZbErtWxSquhILoEHhwWU0Q8tqEGE6i2jd999+SsTski/eBtPccj9mZiEHPuZdTK1k8aNXcp4UqwDt0S9Wwfu8WnTB5GLO4KL5BEq3KDw6YI0TNGRgpCGlswc1/E4t7uFbnFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 9iz3n2U/TtyegKQwplLfgg==
X-CSE-MsgGUID: 1K6KFXEdT5aAdFN4YlR8wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29701549"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29701549"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:27:52 -0700
X-CSE-ConnectionGUID: Ltc9prMrTo6NHroRe1bz4A==
X-CSE-MsgGUID: +mZeiuhoQMWz40fyJMAHaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80933337"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:27:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t4KM1-00000006vO2-0neg;
	Fri, 25 Oct 2024 16:27:49 +0300
Date: Fri, 25 Oct 2024 16:27:48 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel_soc_pmic_crc: Add support for non ACPI
 instantiated i2c_client
Message-ID: <Zxuc1HWTIiUJ3Rwo@smile.fi.intel.com>
References: <20241025083712.15070-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025083712.15070-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 10:37:12AM +0200, Hans de Goede wrote:
> On some x86 Bay Trail tablets which shipped with Android as factory OS,
> the DSDT is so broken that the PMIC needs to be manually instantiated by
> the special x86-android-tablets.ko "fixup" driver for cases like this.
> 
> Add an i2c_device_id table so that the driver can match on manually
> instantiated i2c_client-s (which lack an ACPI fwnode to match on).

...

> +static const struct i2c_device_id crystal_cove_i2c_match[] = {
> +	{ "intel-crystal-cove" },

Why this can't be "crystal_cove_i2c"?

> +	{ }
> +};

...

>  	.driver = {
>  		.name = "crystal_cove_i2c",
>  		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
>  		.acpi_match_table = crystal_cove_acpi_match,
>  	},

-- 
With Best Regards,
Andy Shevchenko




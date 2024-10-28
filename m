Return-Path: <linux-kernel+bounces-384518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD8F9B2B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A917AB21C60
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CDD192D95;
	Mon, 28 Oct 2024 09:19:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBF190664
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107171; cv=none; b=MQZK4NEhCJ7x9r18ywAMGmcnWUdL3eio7+ccWIF1+Dpzgne40LhLAyXGHzjUiDILfJMksWlWnnavLpijEMRtHJF2CJVEl7J5JIvt9FBTwJP5004ZFDU+ZSRUP5L/sP1m3xpKlPs9Alii/IsrV1Sp1yvTItxQkdCXJCSkIy7JHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107171; c=relaxed/simple;
	bh=HO2QyC5E8I1UKnEURhNQIXPChAFtWZjNruxGCsQpjuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZZ6u/BDi8X9G1baDA4UabRshkeqFow9BOC2A499dMeXOEiuEY9LlMpoq2/XCJ3fh+jobQ6TNZc4VJvL0Tm9+6w9kzAy1OXEY7XCjkelYb5KRS046FsMQ/E6Q5GfmDGYbxHMkpj4R70nxqyi5WzDjbp0nlSt8qJCAZHDWq1Tsbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: eeZiUkFXRmqP7nBVzpfV4A==
X-CSE-MsgGUID: MbyB/4moSxKL7xY5feIMLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="32559584"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="32559584"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:19:18 -0700
X-CSE-ConnectionGUID: baNXZwlXS5Cs8j3RkQsYSQ==
X-CSE-MsgGUID: RjJIwi/lSvyo2oTIAkYJ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86170442"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:19:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t5Lu7-00000007tF9-2J7X;
	Mon, 28 Oct 2024 11:19:15 +0200
Date: Mon, 28 Oct 2024 11:19:15 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel_soc_pmic_crc: Add support for non ACPI
 instantiated i2c_client
Message-ID: <Zx9XE6_xzEYKtnel@smile.fi.intel.com>
References: <20241025083712.15070-1-hdegoede@redhat.com>
 <Zxuc1HWTIiUJ3Rwo@smile.fi.intel.com>
 <56c4e49a-b729-4332-b7d2-d8d51edcbd2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c4e49a-b729-4332-b7d2-d8d51edcbd2e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 26, 2024 at 01:42:36PM +0200, Hans de Goede wrote:
> On 25-Oct-24 3:27 PM, Andy Shevchenko wrote:
> > On Fri, Oct 25, 2024 at 10:37:12AM +0200, Hans de Goede wrote:

...

> >> +static const struct i2c_device_id crystal_cove_i2c_match[] = {
> >> +	{ "intel-crystal-cove" },
> > 
> > Why this can't be "crystal_cove_i2c"?
> 
> It can be any string as long as it is unique. Typically this will
> be vendor-model-name though and having i2c in there is a bit weird
> since this is used for the modalias, which gets prefixed with
> "i2c:" already.
> 
> Therefor I would prefer to keep this as is. But if you have
> a strong preference I can change this for v2.
> 
> Please let me know how you want to proceed with this patch.

I think that I would like to have the same name there and in the .driver below.
If you think we need align these across PMIC MFD drivers, I'm fine with that as
well.

> >> +	{ }
> >> +};

...

> >>  	.driver = {
> >>  		.name = "crystal_cove_i2c",

At least two options based on the existing code:
"Crystal Cove PMIC" or "intel_soc_pmic_crc". I'm also
not against other one as long as it's done for all
PMIC MFD drivers.

> >>  		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
> >>  		.acpi_match_table = crystal_cove_acpi_match,
> >>  	},

-- 
With Best Regards,
Andy Shevchenko




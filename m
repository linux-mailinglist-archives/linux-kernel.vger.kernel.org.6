Return-Path: <linux-kernel+bounces-295788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDC95A18E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1D8B20F36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACC614EC7C;
	Wed, 21 Aug 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zsu73gX6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D00136342
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254751; cv=none; b=RdeJYnyO04jffy5LQKKS4OtH7/BCxf7G2lcVy7V9Ddw5sjMvY4xsMKQWLc+HCuO30I37APMf9Ss2uDOBpkaYqhQk9345iLOyVyT48pzEmqP0QrA09Kk9HhVGRROn3e+Md5mHlWdFCJElMBDsA47sHAK78rZq0wPi9XE45xQ9UKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254751; c=relaxed/simple;
	bh=5HDlGsmUc/rInp0PWhpsW+zXPX4wPe0+sZYPNbXRbNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8j9wNlGPuRrFZ7+6AcOA+rLLrvkN7z2Swyiz2jS3TpYa3VPulSSiYULr8qXI3CZ8OoTc3bPC+tbe2FjEPyX+pfIGIE8inJI4SDhFnYQ2VJi3OetI5TngYyO64oRNljc1R5wKecvE+dDxWpVrxeOHadxvCsqvhpy6X9OVJ52p1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zsu73gX6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724254749; x=1755790749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HDlGsmUc/rInp0PWhpsW+zXPX4wPe0+sZYPNbXRbNo=;
  b=Zsu73gX6zIz7JNapC5+5fXQqLFSg2PnZvCZO0xwZx2nxigIF76MO76ca
   WURZUEQy1mv+QL1A+G984Vft0aotouMR+i3OxIzK/qkw8hmCKFCATOuw9
   DUtHD7EKLRyCFHzZO+SmvutlLQ8Ah0K4fUBOvvlt55qr1OoXS7muGrFFT
   scnIKbDTQuXGeADH1rzTDWoGtjFcbKwzOl1Y0i0AtzBJHD2SiR1aZ6+3c
   0abfzrUCoTbAcpuXaVbxR4CrnRJT8t3W8NCGcSwqliUQF9OYcfuwE9mzD
   Ouf50FnWmxjvR3GFc7/F2AXShQhUIy/QhmEEXWevqeflB2Z4BUE3hDz9e
   Q==;
X-CSE-ConnectionGUID: 3ZyqoNFGQEavRyMNrqsmVQ==
X-CSE-MsgGUID: pxqyWtWCRwanbnciPxANpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13134605"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="13134605"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:39:08 -0700
X-CSE-ConnectionGUID: JSjHD66qTvC/7iLE9OIA3A==
X-CSE-MsgGUID: E+ItOtA9ThCIO0RP0Zbdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61152631"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:39:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgnQO-0000000087U-1T15;
	Wed, 21 Aug 2024 18:39:04 +0300
Date: Wed, 21 Aug 2024 18:39:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the
 I3C Support List
Message-ID: <ZsYKGOLN3_2VU6Ld@smile.fi.intel.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
 <9584ddb0-6e39-4d04-9242-a68eb4b86eba@amd.com>
 <ZsXyHfLJ8SJOW0RF@smile.fi.intel.com>
 <236aa6d9-bb5d-4854-86e3-5473f5ea6337@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236aa6d9-bb5d-4854-86e3-5473f5ea6337@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 08:42:12PM +0530, Shyam Sundar S K wrote:
> On 8/21/2024 19:26, Andy Shevchenko wrote:
> > On Wed, Aug 21, 2024 at 07:07:45PM +0530, Shyam Sundar S K wrote:
> >> On 8/21/2024 19:05, Shyam Sundar S K wrote:

...

> >>> This update adds the AMDI5017 ACPI ID to the list of supported IDs.

s/This update adds/Add/

> > Please, provide a DSDT excerpt to show how it will look like in the ACPI
> > tables.
> 
>     Scope (_SB)
>     {
> 	...
> 
>         Name (HCID, "AMDI5017")
>         Device (I3CA)
>         {
>             Method (_HID, 0, Serialized)  // _HID: Hardware ID
>             {
>                 If ((I30M == Zero))
>                 {
>                     If (CondRefOf (HCIB))
>                     {
>                         Return (HCID) /* \_SB_.HCID */
>                     }
>                     Else
>                     {
>                         Return (I3ID) /* \_SB_.I3ID */

Do I understand correctly that I3ID is the old one (as per another path I have
seen last week or so), i.o.w. *not* a MIPI allocated one?

If it's the case, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
from ACPI ID perspective.

>                     }
>                 }
>                 Else
>                 {
>                     Return (I2ID) /* \_SB_.I2ID */
>                 }
>             }
> 	
> 	...
>     }

-- 
With Best Regards,
Andy Shevchenko




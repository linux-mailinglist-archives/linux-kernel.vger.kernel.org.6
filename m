Return-Path: <linux-kernel+bounces-335777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E6E97EA83
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06F92821CD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD8198838;
	Mon, 23 Sep 2024 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7dP0idm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26477198827;
	Mon, 23 Sep 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089946; cv=none; b=k7KA2kPhXCavFJMf4WQnaiXZ3qDeKb2FoNWtoBHreKtsOwLPbXfPsbWqJZfsaaJn5IlA29tejP03zblIUKENhI8SeyxO10ckBKvgmFsKtpUvfwqaMax3Cyjh4zwIU5MHrDmk+nTl8DsbdCZrmC7UpFSSWWN0ZGxfsEW+qsm5D88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089946; c=relaxed/simple;
	bh=7Uk/BvAzCSlnJH7buOhPPD2FCL4vS4J2C9jomty2e8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRYCTDwYM8KeL6xPMs8XWpFO3z+ZBFNBs3rnlkoelyENFIE3sR+g0WgVw4g92KfmY6dQkhCU+CK645PDefSVqj40tuTWCJGu1RwfCTwBdOCBRfnD58Hast7gLJg+xrXQdtXy1X20haKX+fqfsfHXjzhk2vDkw3sbkWOrBLOVPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7dP0idm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727089945; x=1758625945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Uk/BvAzCSlnJH7buOhPPD2FCL4vS4J2C9jomty2e8k=;
  b=m7dP0idmhMX7ISR2GmgWJpPXtNTUBp3fly0wAohMbZQdi2sPfmHrHFtI
   24x8r+i34rg/9Sjf5ad1XnFiiTKG/rJ++KlRlmOU0WIHHZxepV7024qrO
   00z5JbPiCtBoCs7L6nqC0scMJcTKpgEgVHP3FkDypf6XHoUPiywrIPVMA
   YjEQC62s7q5qBM3WB5Eaq1JciR63Zt7xGOpi+YvkiVqWSRhLJ1DBTck80
   SDKlhOGl7c3SHZolLB1mRtor5yZQe90nv4mY/jjZUVoU8mkvXSGz/0dIR
   VqmY312FAJRFohQPex8FAfWcIJnqNprX1LMU4/6SFed9PFNEESZznlr1T
   w==;
X-CSE-ConnectionGUID: Rm6LYU4OSTe9kilDRnMGjQ==
X-CSE-MsgGUID: fhPjUiahQH273fWMY83Gcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="51448972"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="51448972"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:12:25 -0700
X-CSE-ConnectionGUID: Tw+hnIZHTE6oUkR7QPdYMw==
X-CSE-MsgGUID: /BchHAHfS+WqFegAIgyz1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="75806075"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:12:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ssgzM-0000000Bxsj-0Rdh;
	Mon, 23 Sep 2024 14:12:20 +0300
Date: Mon, 23 Sep 2024 14:12:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: linux@armlinux.org.uk, robh@kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] amba: Add dev_is_amba() function and export it for
 modules
Message-ID: <ZvFNE7pbwFN28ROF@smile.fi.intel.com>
References: <20240923094249.80399-1-chentao@kylinos.cn>
 <20240923094249.80399-2-chentao@kylinos.cn>
 <ZvFM6yC1EQPS5w_s@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvFM6yC1EQPS5w_s@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 02:11:40PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 23, 2024 at 05:42:47PM +0800, Kunwu Chan wrote:
> > Add dev_is_amba() function to determine
> > whether the device is a AMBA device.
> 
> Thanks, but it needs at least a user to show the conversion.
> I think I suggested in the last discussion to convert all
> straightforward cases (which are not the direct users of the
> given bus type).

Okay, I see now, I was only Cc'ed to the first in the series...
Scratch that comment then, sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko




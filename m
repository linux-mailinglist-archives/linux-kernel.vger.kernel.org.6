Return-Path: <linux-kernel+bounces-443467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40989EF255
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D87C189BC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8D22655B;
	Thu, 12 Dec 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThQai3kJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD6225411
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020693; cv=none; b=hNlajM+fFtfB3Khdp1xZEn6DODcsNnR1bMga8+OLIPCg+tyh1JAfEm1O6HoGuHnhZ2caifTIlt2K32xsF1Opt2D7Sd3ppxfzGaWwCzE2aDnI2CEfi/5L2EAJKTzy5FLLFqmY53Hx6IEDiPZ/kzcShbG4X3GP4kfYFC0cuQ2Zmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020693; c=relaxed/simple;
	bh=ybvh2LCs1jiATsTUws2yLPCzIB7crBX5rhe0jzCJ0uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P55FSGbXWNsvvSmiAbZDiapvaWQ/SNogV4DQIY/JwdYTAqkENjlgby9+1Uh7W2qIFykIwL0hyrd7KMwi65SyzzvZ1T/icY9RlL0qEZse+eLzGX0tfY+blfX02VbTpGP817weFQFqxeddHn0K+Pfwsf2F7QdbCwTU0DiYt1ozeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThQai3kJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734020691; x=1765556691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ybvh2LCs1jiATsTUws2yLPCzIB7crBX5rhe0jzCJ0uw=;
  b=ThQai3kJ7YZgRdYjr8hKOAxjzbIjIV/G3Ttz5aOLCtHViRWMthsv6oI2
   Rs7p4RC0gQ88HSTmVEBp44qrmbDtsNzv2agIiokSPWVb017/rI98gKjp8
   dUoOLvWWgdVa1vKD/hyo82hS3qq7FaF26KlE1e7qMqCD3Ahe7qSmsn/gm
   0igTVGjwJDQCevVfYicarwNb3zGFAjdQEifd2T7UJUFmStlpwRqdO+lqQ
   /76sXanQovoCF7KLXab436C8sSrMgEZY56mHS/v2vDV6MiePGuvepz0NI
   qsP8RK9bz2Y5CQ3j8SU/5gYwmFfQcfkWbrIIPcowwpKuat7hkBAwOq+zt
   w==;
X-CSE-ConnectionGUID: ZdZXnMDyROShsx1/YGONew==
X-CSE-MsgGUID: 8oHEoVZ+QwCZ2N4INLkP7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34688802"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34688802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:24:50 -0800
X-CSE-ConnectionGUID: 4l0s1ysIT0KAEIdiF1KARg==
X-CSE-MsgGUID: N33rhWbZTyKgBKZYqknKTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96355689"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:24:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tLlzZ-00000006xwk-39dJ;
	Thu, 12 Dec 2024 18:24:45 +0200
Date: Thu, 12 Dec 2024 18:24:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
Message-ID: <Z1sOTf6UZbruptnl@smile.fi.intel.com>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 03:10:09PM +0100, Christophe Leroy wrote:
> Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
> > Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> > file provides an OF API that's deprecated. There is no agnostic
> > alternatives to it and we have to open code the logic which was
> > hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> > drivers are using their own labeling schemas and resource retrieval
> > that only a few may gain of the code deduplication, so whenever
> > alternative is appear we can move drivers again to use that one.
> > 
> > As a side effect this change fixes a potential memory leak on
> > an error path, if of_mm_gpiochip_add_data() fails.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks, what's next?

-- 
With Best Regards,
Andy Shevchenko




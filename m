Return-Path: <linux-kernel+bounces-198174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93398D7478
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D7B282502
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D62E3EE;
	Sun,  2 Jun 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5EDzmfs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF492D60C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717319174; cv=none; b=NisHXPqac3Ehb53bPtPKy0UE9jsHHUobs52+ZPneqIel5S9rKhx7sjzoHud7ZRSs7U5P1BdBkeQxKyLxUeD65c2TQWpHwzIdXsdcK3Hi71entpTdQ9OzkX6na1kcWObV+z8pVXjQT7SzO/Zrw3LLYBBAV3Db6+o6L6HL0lkvT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717319174; c=relaxed/simple;
	bh=rde+gS+/1SJ6Gr36HkKsuWVC84C5A7IxDaZV55cYZbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJePrJ/kn/cms3aMFIx9yNIYFVjb0hknWBgQvnKFfeyICbXzNiXK3SS9aiZZWLMLpwK50rFW4xLwU7OWvsxUYNUmlmvdl/Ql4x4ARWJ63yE9SMdjaYeUweuqBjBIRMBv9d6Ya7eSdt0WJKN0xOGMpUNQzTyfAibxz0XYjrohR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5EDzmfs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717319173; x=1748855173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rde+gS+/1SJ6Gr36HkKsuWVC84C5A7IxDaZV55cYZbE=;
  b=E5EDzmfs6yyLRLai5U0rFOCL0hazf6S1DTsmcPb0tEYXp3bYY46uQSB+
   OJmOB8NEQoRMMagXrRPwuwkZQshse+MLCqVKIaX7pfk8FdBxKctQm/aiv
   0VA6D20dDA12nIosET3whQkiVETvro5zvF9Yz06IbN3XhqLE88aLviqqX
   8/P0AkHNXHZwEiNOE+YjjLDfLONEiDUYprH+pnqIerO8Y6BZEOWMb+axs
   q494vZRi45+so8FAhyepMLjsBm+eJtJOYfCsygwAj+Qw6pE02NIefqVAZ
   v6MBu/R26N/imlA/RnRVDzniUTrKULoboLn51E9Ll8f8pB/YSFXA8Dp/I
   g==;
X-CSE-ConnectionGUID: cmXy2u5YTC2Vs5+U/Ck8Jg==
X-CSE-MsgGUID: UD+rXYQvT2mLC6KxpAwv7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24942885"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="24942885"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 02:06:12 -0700
X-CSE-ConnectionGUID: jTIoXAiyT9iJV/EfV4/gFQ==
X-CSE-MsgGUID: tUBKbWb3Sd+hRJ9gH/mbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="67780590"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 02:06:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sDhAE-0000000Cyf6-42sP;
	Sun, 02 Jun 2024 12:06:06 +0300
Date: Sun, 2 Jun 2024 12:06:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com, alexander.deucher@amd.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/resource: optimize find_next_iomem_res
Message-ID: <Zlw1_n20oqchAYxH@smile.fi.intel.com>
References: <20240531053704.2009827-1-olvaffe@gmail.com>
 <ZlmQ3_wcL3cgp4Hb@smile.fi.intel.com>
 <CAPaKu7SsD+X7KAO=3vEYU_7YGM_f+7k1fdC9nEK=-NaJw8oYaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPaKu7SsD+X7KAO=3vEYU_7YGM_f+7k1fdC9nEK=-NaJw8oYaA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 02:31:45PM -0700, Chia-I Wu wrote:
> On Fri, May 31, 2024 at 1:57 AM Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 30, 2024 at 10:36:57PM -0700, Chia-I Wu wrote:

...

> > P.S> I'm not so sure about this change. It needs a thoroughly testing, esp.
> > in PCI case. Cc'ing to Ilpo.

> What's special about PCI?

PCI, due to its nature, may rebuild resources either by shrinking or expanding
of the entire subtree after the PCI bridge in question. And this may happen at
run-time due to hotplug support. But I'm not a deep expert in this area, Ilpo
knows much more than me.

-- 
With Best Regards,
Andy Shevchenko




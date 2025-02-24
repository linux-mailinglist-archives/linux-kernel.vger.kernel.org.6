Return-Path: <linux-kernel+bounces-529217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB201A4221D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621393AA2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02805248898;
	Mon, 24 Feb 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMHuPRA0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BF158870
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404796; cv=none; b=O9LuHDNXnLdB/3V4rn40C2ezhdRMXz0VYa2knrm5kyeFo9sFoap/n1j6bWzY7ajZbSuWrG7mpQXidice6JcVuGSTDhpfV8PdJYViZ1OrCwb/hd5l5gwuT9MmJfzq67xgybCeP9LFGxR1wWyFhPsMawT1ll3kQnXdUx8J9uxAJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404796; c=relaxed/simple;
	bh=5zZ8Vo6ASTzITaTVNrpLF1HYI5Y+qFGK0+PACmo/U1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJryldHjnF07iu6tCZd64h8HfConeU77Oa1T0KsMePmczH4uh9JIoqaUJ8dAYnziNu2GyguDwfS3RxzpkRAcAlDzdM7AsZBtXfdazc20tXNt+FtfdxLZUG2NJ9JjKGpmboEHwT9TLjULiqvSxH2mAxSitUW7RwMSf9uLUNar/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMHuPRA0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740404795; x=1771940795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5zZ8Vo6ASTzITaTVNrpLF1HYI5Y+qFGK0+PACmo/U1U=;
  b=ZMHuPRA0kW8QAzUknN+9Y41xv95dOZp9tQMDzpLeg5hUWwm/jHaH0fiP
   eIhoC5u14sXoxvwS8G9T2KFj0SwNSdRu4fUePfWIdqu4Kuc6wqbhc1ROR
   gTakBP4Hz7X2651zJ7Dx6m3wJaqAsrHfUDtt8oWBtLIOEeCf7tqcrPJMB
   FWHcM5DqSah6DoT4RwObSGUPkZdMiVHsQUdRWw+fg8g5BHiPAHVm01iNT
   T5EUPSCKGSvgJfwqZu36Quq52qtCKPpKYFtxOtdbUgC+7EjwUNV7xKcH4
   ZNK4hvMoXCG2IMGEwr4O5twPmpjLjPOuPnA7e1yfjb9PNZYkDGG78EB5u
   w==;
X-CSE-ConnectionGUID: CaKkrL57SRCMlB6/oKjx0g==
X-CSE-MsgGUID: z9GLCaKHRJ6ia3BvysfnRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44935620"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44935620"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:46:35 -0800
X-CSE-ConnectionGUID: 06r2qSdmT2St0J/qFBDeHQ==
X-CSE-MsgGUID: WnGvZYhfQKGsl9HetwUw6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120676821"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:46:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmYn0-0000000Ei4V-1Zga;
	Mon, 24 Feb 2025 15:46:30 +0200
Date: Mon, 24 Feb 2025 15:46:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 1/1] auxdisplay: panel: Fix an API misuse in panel.c
Message-ID: <Z7x4NqYxQ58BoI-d@smile.fi.intel.com>
References: <20250224123625.3816062-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdW8E=+p1YS5c=UEwGtT+4GGgAPN9ej+T4eDv-+MmZ7SjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8E=+p1YS5c=UEwGtT+4GGgAPN9ej+T4eDv-+MmZ7SjA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 02:39:48PM +0100, Geert Uytterhoeven wrote:
> On Mon, 24 Feb 2025 at 13:36, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Variable allocated by charlcd_alloc() should be released
> > by charlcd_free(). The following patch changed kfree() to
> > charlcd_free() to fix an API misuse.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko




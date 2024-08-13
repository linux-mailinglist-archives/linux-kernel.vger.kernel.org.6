Return-Path: <linux-kernel+bounces-284344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B0950019
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CC51F23787
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A613CA99;
	Tue, 13 Aug 2024 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRQOI9tm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0E175D26
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538478; cv=none; b=RBLHhNQcgFuaHCpmhWLQeeAVWuR4xxr8HrnpGTDjKJmh7CRNGkgKajSWq5q7J/G7UWdWKDEvyclc9gNF+V0rD3ZUoVqK5DSQvDvJ8/2XKzqplCamSRP/6cwUFKvywVqBQ4ajyn1Xz1qoxmYr+LdzxP4xpXozrShrZ6/W+gU7NH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538478; c=relaxed/simple;
	bh=PBEQx+yY3OhWhUnu+Qxd/D05zs3Xvom47MnLDK6y4/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr8+KWke6nQ90JiZC8Eg857BeI309V/v8eX+lLBsQRjPSjBhoSIu3F0d4XfgocUba/uitfaotoaXqdfMprz04D34oxvQuwJlWwVJgZ6Z92wvzPsTNt/PZV7jmVzmxIOHG2K709kthzNL6a33EAKDBapQUXi6e2lheSSrJR9P2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRQOI9tm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723538477; x=1755074477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PBEQx+yY3OhWhUnu+Qxd/D05zs3Xvom47MnLDK6y4/g=;
  b=TRQOI9tmGvh53CVTp5y9s2ThvIdO6a+2XdzUG4NI0gpDAEqueGSx67d5
   HvWsRQRhk30LG23ZNv5wARreS7/QtnFllNCJtldiRBYQICYsdybs0Oxx/
   Tlb4OEYdVUPJMM2NLhecaLKb+DApcDNR4h/Uz9oBx4p7u2iGHGLau5AGF
   GbCytARxc31uK0Y0cYlFPp1vz/MwaCL2sTUSSTo8jxsBY2NnmAKtUhpkP
   SWTdyerczHGaV/LhOiYURaFNYd4m0dZmnYGtK938MIo6HCiHh6ng7TdC8
   5FakQHyt4MbNAKCApVOxY+5r4X2YEnHdXBn437ku+mulmTYhKgvAcZWlG
   Q==;
X-CSE-ConnectionGUID: XCtUsfScS22Q+PdqllTaCg==
X-CSE-MsgGUID: 1yvNUgWRTpuXL5BooEiBcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33089163"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="33089163"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:41:16 -0700
X-CSE-ConnectionGUID: IHd6Lx2rSkmJaLyLlQYuqw==
X-CSE-MsgGUID: Uy7beN9nQcCqR4DuX/K5EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58669140"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:41:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdn5b-0000000Ef9e-0weh;
	Tue, 13 Aug 2024 11:41:11 +0300
Date: Tue, 13 Aug 2024 11:41:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm: fixed: Don't use "proxy" headers
Message-ID: <ZrscJvDZqMQNFgR3@smile.fi.intel.com>
References: <20240422143338.2026791-1-andriy.shevchenko@linux.intel.com>
 <87r0exs067.fsf@intel.com>
 <ZiqPAeps9uiG63qD@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiqPAeps9uiG63qD@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 08:12:33PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 22, 2024 at 09:49:04PM +0300, Jani Nikula wrote:
> > On Mon, 22 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > Update header inclusions to follow IWYU (Include What You Use)
> > > principle.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Assuming it builds, and nothing depends on other stuff from kernel.h via
> > drm_fixed.h,
> 
> For the record, I have built-tested this via `make allyesconfig` on x86_64.
> 
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> Thank you!

Who is going to apply this, please?

-- 
With Best Regards,
Andy Shevchenko




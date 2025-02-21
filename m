Return-Path: <linux-kernel+bounces-525600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11028A3F1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4624E18957BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C10204F90;
	Fri, 21 Feb 2025 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah5SMrmq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D465204C23
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133484; cv=none; b=QAQy697pFyKvt5x7It6t6jLjR39Awl+W7OVZAmp7mCYzru7IxR6laZrNnxT8Q9gHNGJMHJTjW66TeL4aGYI1JKYs4UQzMUf4zELtUXFUTL9aUROUaAd0LxFSGDBG4E/dd5SfPQlTCOe0nDytXeYHqO/NLqPavQ1VKsbagYzyjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133484; c=relaxed/simple;
	bh=ak5HhJgea9kjBINxSEsca6JCZ/SZSug8UZ6ylG+W/74=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr7xxjduh3J6sdSS9EJunT/6H/5lajBjIXu+kHtBqHl9AkgxOW2pCepy0vxMgyUdHEXwMojFrLm98FB7/RlAyqmdWGi9UvmI3qLDkaNLpQv0HQc8rV8zVx/uG9bBktaqMAQ5OchdNOIILNH94QBVbnTJwBKwgfem7WbZ7LThkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah5SMrmq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740133482; x=1771669482;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=ak5HhJgea9kjBINxSEsca6JCZ/SZSug8UZ6ylG+W/74=;
  b=ah5SMrmq++rI7SvYvcdNCiZObOapDmCCPHRp0sdWe3ZZbbSLHRDZLn15
   OOuEK2GLzr6IkIoPlBM4nq9pE0mf4RAT3ppvRduhmUZFc4Cj/qSpgmXQA
   Dz9QF9YHQs1UJQUfvmyjXmE9WfASlZkYPY8Yke8cfSh88Aomt3dQeFuv+
   n03lhrN6bXHkqTFW9mThd1gg7DoqGs3ALL8Mph/NTZ+QwDxnSNvWx5jAZ
   ZIhZC029w2EYRuCOCiLSsKzFZYopBbn/+P2R1kuPmpXCPgbofDc9h4zDL
   90CaRX+Tlgrlav6msgdlgI57rLPfHVNoCTHTZSpOFaJ2f6gzLPI2RxfsS
   Q==;
X-CSE-ConnectionGUID: 53Vh6nfuS4y8pSacBYEd7Q==
X-CSE-MsgGUID: mBHaISNgQiaEZ0ioZxSSYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41154396"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41154396"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 02:24:42 -0800
X-CSE-ConnectionGUID: 9XQmhJ4JRW2FqEUCh10x+w==
X-CSE-MsgGUID: 6NWjHjybRA++5n1NIlQ13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="146197544"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 02:24:39 -0800
Date: Fri, 21 Feb 2025 12:24:36 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/draw: include bug.h
Message-ID: <Z7hUZIYhg6ShNJCf@black.fi.intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
 <20250221050804.2764553-3-raag.jadav@intel.com>
 <2025022135-aviation-evident-2518@gregkh>
 <Z7hMPIxFyd6cqbC0@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7hMPIxFyd6cqbC0@phenom.ffwll.local>

On Fri, Feb 21, 2025 at 10:49:48AM +0100, Simona Vetter wrote:
> On Fri, Feb 21, 2025 at 07:05:12AM +0100, Greg KH wrote:
> > On Fri, Feb 21, 2025 at 10:38:04AM +0530, Raag Jadav wrote:
> > > Directly include bug.h for WARN() helpers instead of relying on
> > > intermediate headers.
> > > 
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > ---
> > >  drivers/gpu/drm/drm_draw.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
> > > index cb2ad12bce57..0a0e1eebf481 100644
> > > --- a/drivers/gpu/drm/drm_draw.c
> > > +++ b/drivers/gpu/drm/drm_draw.c
> > > @@ -5,6 +5,7 @@
> > >   */
> > >  
> > >  #include <linux/bits.h>
> > > +#include <linux/bug.h>
> > >  #include <linux/iosys-map.h>
> > >  #include <linux/types.h>
> > >  
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Does patch 1 break this file without this patch so this series is not in
> > order?
> > 
> > I'll be glad to take patch 1 in my tree, but I don't want to break
> > anything else.
> 
> Yeah looks inverted. In case this is all there is I'm happy to land this
> patch through your tree, that seems like the simplest approach.

Yep, I messed up the ordering. Let me send out a v3 since I need to fix
nios2 builds anyway.

> Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

Thank you!

Raag


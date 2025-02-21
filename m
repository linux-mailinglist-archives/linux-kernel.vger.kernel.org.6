Return-Path: <linux-kernel+bounces-526256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A25A3FC48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7531867C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE6204F80;
	Fri, 21 Feb 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gH70Fyua"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE420FAAD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156609; cv=none; b=fIB6Lq4UhYWJqb7P1ddya8ON8DP813hW4iG71pfi2EKywkcyq1CXvT3Cb6pbl1hrhmtiRwRfUayWFRuoIGe2JPhvUrzp2GX2RyHRmIi7CMjk445KYcY+1mASGrHGOdjHvL//V6ZTdmCBIEr7qMqSOzdfL2WjyljynfTKKB/4Meg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156609; c=relaxed/simple;
	bh=1E2TMZF4clchinoXEISFNTFN9Mo1YsiHycNLmSVgkg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRhRomgURwEpcUYnIcsUjPkDAJRK3sCmxyks4FEGSqEia1H4V5icRhQueB55K4XSMLi1muGhR+Abf9IzqvI3/FQmiiOKTH8LyZ5NdtRp7c7u6K+0aX7d/3+Bgk9oMGpkL/NP/PizElfDkmgynFNCAnocQHaA0bN/A/79r+C9tTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gH70Fyua; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156608; x=1771692608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1E2TMZF4clchinoXEISFNTFN9Mo1YsiHycNLmSVgkg4=;
  b=gH70FyuaheAir1K4Ydu6iDUhwFzdqUOA1Db6fg9MCxwOji4zWkykUI8V
   aVLtQALw7zVTyy5L+n3lJlnVQQl7K1RQk91qWrpRMw5UC0B6rhs+jHrbI
   kRMAw9h8rHDhAwbPe6LB4XmBtW5GgRnxJFGix18F/VHmvLRYOmZbwegVA
   YlMNoM77b7u2+Rd4dgQvOJOtHzw24zK+JFhZfQ8rDn7KyiU7Zr0qJYMOw
   6Ep8wOq3y5QSHO92hLMREhpFzwdg3sM/YKUr7fY3FHw8WhzEBwpTDSL2z
   I+5KTAxub7wK1vUgZnHCf75rEcwwvpDpRudxw+/OnB6ic+1ZhU9SL6O+d
   Q==;
X-CSE-ConnectionGUID: ROZfIlDeSNS7CVD+yCPJag==
X-CSE-MsgGUID: lKVSZiP+RAKfEarZZ6wz0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40172912"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40172912"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:50:07 -0800
X-CSE-ConnectionGUID: 1+ARLkzjSXqKZa38w8XD1A==
X-CSE-MsgGUID: 3UttHELwTPKLUBw7EDjpZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="115945958"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:50:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tlWDy-0000000DhAd-2N3z;
	Fri, 21 Feb 2025 18:50:02 +0200
Date: Fri, 21 Feb 2025 18:50:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Raag Jadav <raag.jadav@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Cleanup io.h
Message-ID: <Z7iuulG0Ltoltl8F@smile.fi.intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
 <2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 21, 2025 at 11:15:47AM +0100, Arnd Bergmann wrote:
> On Fri, Feb 21, 2025, at 06:08, Raag Jadav wrote:
> > In a wider effort to improve build speeds, we're attempting to split/cleanup
> > core headers.
> >
> > This series attempts to cleanup io.h with "include what you need" approach.
> >
> > This depends on earlier modifications available in immutable tag[1]. Feel
> > free to carry your subsystem patches with it, or let Andy know if you'd
> > rather let him carry them.
> >
> > [1] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com/
> >
> > v2: Fix drm_draw.c build errors
> 
> Hi Raag,
> 
> I think your patch is to linux/io.h is correct and we should
> eventually apply it, but I think the header file cleanup needs
> to be done in a little more structured way or it ends up causing
> a lot of extra work for very little gain.
> 
> As you already found, removing an old indirect #include that is
> no longer needed usually leads to some files breaking. The more
> impactful your change is in terms of build speed, the more
> things break! I think in this case, removing linux/err.h and
> linux/bug.h made very little difference because they are very
> small files in terms of what else they include.

While this is all true, removing unneeded inclusions rarely can lead to the
"extra work with a little gain". When there is a replacement to the low
level ones, it's also an improvement in my opinion and won't be harmful in
the future. But I agree, that the stuff is way too tangled already and requires
an enormous work to untangle it, even if doing it structurally.

...

Do you have your scripts for the showed statistics being published somewhere?

-- 
With Best Regards,
Andy Shevchenko




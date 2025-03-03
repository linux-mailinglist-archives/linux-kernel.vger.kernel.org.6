Return-Path: <linux-kernel+bounces-541384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B8A4BC50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD8616880C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005B1F2369;
	Mon,  3 Mar 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWDWe0Bq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB61F12E0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997911; cv=none; b=a4dLj+KTY66+DLafa3OV2FOKNqGsPrJXZ8J03AHwPI+L3nrixSIK9NPcxd3vJULpitfcyv8gCVkf72Eix6BGp5UHSN8S0mUEtpZumplIxROCwXzD5vFmIS+TBycw2Rle/S63/gsBixzfpE0DtNI3N60s+JtGLmTNdfgf403b4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997911; c=relaxed/simple;
	bh=x7bNnIH0N9XXrP4dc2Yr5ges+LomEyPKmnx/zRPInOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6TD2HzTHw50d8rQTnnD6U/NpWDxDYrDtn12x9UIvvji4UocCc7ZbtECd4cojGUqw51HXccf+pChu7jM6Pv6ARIFIcGSPFRI5lG2PjHA/L3MMCwcYYyQHTF5TEmelhGUWDrs0otbl93Yne72fSRVQS/lsJ/WWiWA8TZMDfEABZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWDWe0Bq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740997910; x=1772533910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x7bNnIH0N9XXrP4dc2Yr5ges+LomEyPKmnx/zRPInOM=;
  b=dWDWe0BqhC7J30MfEgB4VPN3v31B9pKXoPqdo9CEzgfBGUAf+iUHgz2r
   I0SxnR6QRSpqPuFpC0icRJ54H76yUWqJaqf9b7qy0y9XMuA8jCGeFBs9t
   ow2LBJ/r2bdU3PiHMKUithU7QHLcfHGyVhloN3saTDJtul14XmYx0R8rp
   KD5IJ2sGe1r0jUXx+B1Sx81VRVoq04XKFm3Nflsf29nfY8IymTJOfRIdb
   VPCUjZ9qv7UvbZIpILk/N8FYOsFdjvxCO4/vcK761176z50B5rzqCQ+sI
   To2wo+o+CsmzVh7rIoCXaOAUTguRzGcOpQZKOUcF5DQbYkK0s8DrH2ty8
   A==;
X-CSE-ConnectionGUID: 7RNzfFomRhy1oal3MmZUaQ==
X-CSE-MsgGUID: 9VTX1XfLRkC61k0UTTWVew==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="53256758"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="53256758"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:31:49 -0800
X-CSE-ConnectionGUID: kwoRTYPBSy+dkMbhO+ys1w==
X-CSE-MsgGUID: 6doOexc1T6KsNEMMhJQJ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117996022"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:31:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp35M-0000000GmSA-1Q73;
	Mon, 03 Mar 2025 12:31:44 +0200
Date: Mon, 3 Mar 2025 12:31:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Raag Jadav <raag.jadav@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Cleanup io.h
Message-ID: <Z8WFEC2-kBwSYFDX@smile.fi.intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
 <2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com>
 <Z7iuulG0Ltoltl8F@smile.fi.intel.com>
 <f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 21, 2025 at 06:15:30PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 21, 2025, at 17:50, Andy Shevchenko wrote:
> > On Fri, Feb 21, 2025 at 11:15:47AM +0100, Arnd Bergmann wrote:
> >> As you already found, removing an old indirect #include that is
> >> no longer needed usually leads to some files breaking. The more
> >> impactful your change is in terms of build speed, the more
> >> things break! I think in this case, removing linux/err.h and
> >> linux/bug.h made very little difference because they are very
> >> small files in terms of what else they include.
> >
> > While this is all true, removing unneeded inclusions rarely can lead to the
> > "extra work with a little gain". When there is a replacement to the low
> > level ones, it's also an improvement in my opinion and won't be harmful in
> > the future. But I agree, that the stuff is way too tangled already and requires
> > an enormous work to untangle it, even if doing it structurally.
> 
> The problem I see with prematurely applying small improvements like this
> one is that they always cause build regressions, at least if the change
> is any good. If we can find some more impactful changes like this one,
> we can group them together in a branch and test them a lot better before
> they even reach linux-next.
> 
> I mainly want to avoid people getting angry at Raag for repeatedly
> breaking their subsystems by pushing small patches one at a time.
> 
> > Do you have your scripts for the showed statistics being published somewhere?
> 
> I had a good set of scripts on an older machine and might still
> have some backups of that somewhere, but just hacked up something
> ad-hoc today beased on what I remembered from that time. Here
> are the snippets that you might find useful.

Thank you!

-- 
With Best Regards,
Andy Shevchenko




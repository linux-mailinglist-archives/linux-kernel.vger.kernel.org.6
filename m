Return-Path: <linux-kernel+bounces-435177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0539E73A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2D616CB79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB8C1714DF;
	Fri,  6 Dec 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkpg/LDy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35E53A7;
	Fri,  6 Dec 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498510; cv=none; b=WkWG7TR/TfDkCBGZNc1D0Y21qHaWGzO3cred+oiIEfkMwVtT7wfnd2DfmaNr3Rhcyv5YxWVHqzfkcWluI0L3+/PRbdkzMRmPDflaTM1PGy0V5k0a/q3irLUyqifnKitlRE5SEU5wAq3IVSuiM4T8/PsHVSL53jaRAm5O6OjEu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498510; c=relaxed/simple;
	bh=ofeOQ27/mt+A72+VoyDUfh68mFTvn5RZAaqT1YVw7zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMCA9my+e7ChiZBzfdmj1e01EQL7LZDuA2bhAmvHQniB+rsbTOY4HTVKruEQHgxMIEzVbG+RyqPIWOKghxzo55VQickIuqHrqsl94sxUewosKFTw6HSf7EoX3s/ZDwtxk5aNr95xzyTQpo6nVjaSSg6x8bmZlkwra0q6KqrXFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkpg/LDy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733498509; x=1765034509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ofeOQ27/mt+A72+VoyDUfh68mFTvn5RZAaqT1YVw7zc=;
  b=hkpg/LDypDa8ne9rxmMpFEtSdhkocmds5/n8hdvlCQVwictVWmJEFKfr
   N4eEAolfw+ipwPDin38/ja6NzyGFQh8solf5Wos0Th/rdguV9wcdcNh/V
   W1IlF/Q2y7ub5YJT3I+eyzxonnea4CS2YvBmmsvri+CDNfUVoOukhJV0h
   iTHXCK3C7eOkFp8GC9cnX3xR5bFf0EKKbLQGJNMfTW/BblNSz1ZC0zggB
   9uAwoQ+ba7u0vd0bLfz9C4c6boCn2VIeQ22YCxiOSBPe6ZXXg9hG/Nysf
   iWGIEYGdi1yEs8c6rBK7aPUl7hhl1WDYY6OXLIzYyRmrVzxblbhferVLk
   Q==;
X-CSE-ConnectionGUID: t6l5hpisTfKn78iqxTFZJQ==
X-CSE-MsgGUID: rE20G0AiRZOOL1gX787oPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34093361"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="34093361"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:21:48 -0800
X-CSE-ConnectionGUID: PzlCrjuYQA+MoHUFbo7Fkw==
X-CSE-MsgGUID: VlJ6JTteSS2X7huSp3KUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94289338"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:21:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tJa9I-00000004YAL-28gK;
	Fri, 06 Dec 2024 17:21:44 +0200
Date: Fri, 6 Dec 2024 17:21:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
Message-ID: <Z1MWiBEZEMgL1Iiy@smile.fi.intel.com>
References: <cover.1733305665.git.ukleinek@kernel.org>
 <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
 <Z1FbOrGjaVsGKIXa@smile.fi.intel.com>
 <mfgqf5xpjnyud3qm4hwycbnz23mfik4pzry3h7fi2k6khokbgd@facrmygrrqnh>
 <Z1H5UqN-egUs0GhJ@smile.fi.intel.com>
 <zsqtlottouotiklytvbqapexuopzxlasqod7ynohu4yhtnr7no@j2zqryrst7qc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zsqtlottouotiklytvbqapexuopzxlasqod7ynohu4yhtnr7no@j2zqryrst7qc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 06, 2024 at 03:45:50PM +0100, Uwe Kleine-König wrote:
> On Thu, Dec 05, 2024 at 09:04:50PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 05, 2024 at 11:55:54AM +0100, Uwe Kleine-König wrote:
> > > On Thu, Dec 05, 2024 at 09:50:18AM +0200, Andy Shevchenko wrote:
> > > > On Wed, Dec 04, 2024 at 11:01:10AM +0100, Uwe Kleine-König wrote:

...

> > > > > Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> > > > > literal") the namespace has to be a string. Fix accordingly.

^^^ (1)

...

> > > 	... the namespace as a string constant.
> > 
> > ...a string literal.
> 
> Gcc calls it "string constant":
> https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html#String-Constants
> 
> My C book (https://www.amazon.de/dp/013089592X) also calls it "string
> constant".
> 
> So I tend to keep that name as it seems to be the official term.

Even though we should be more consistent with the de facto usages, no?

(see (1) above, for example).

-- 
With Best Regards,
Andy Shevchenko




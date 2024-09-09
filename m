Return-Path: <linux-kernel+bounces-321704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8C971E54
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B021C233D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C3F4779D;
	Mon,  9 Sep 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1ecd7dS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC61BC39
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896597; cv=none; b=PyI4pnLBwzVAtHrTPrVzyiyVR7w1uXjhgdvl6uXm8YuphfeZ9ezxKQIOWmoUjVi7uj4ghJYBKSy1orL86723752sAmcpQkdHfy3hvq37Pd1B+8pqpqFr1XupQZCqs9uJqBTS/ugFgK3UJ+VCmXQ9Q9sxBGQLbxMmUZhN7iKEWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896597; c=relaxed/simple;
	bh=3jZYt1HJ9TnQchV5YgtJvyqEPqxfwVI2DDnFVPVlXlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWMuzv6RenZnOpxxZ9bR5hsxIToc7k+NnzViRW+76D4oSl7PTLpf7p+uTubEweTApkZz0ID10UQxKxHV67BpsXl/Nkpz2LG8fy7zG78g6QfKP9oNNlTWBwUysA/E36LV/Y11gwNfwWncqaUXUhQRaNdH/wYzQJkIySI9tFJyTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1ecd7dS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725896596; x=1757432596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3jZYt1HJ9TnQchV5YgtJvyqEPqxfwVI2DDnFVPVlXlY=;
  b=a1ecd7dS/K2/BIz8s83gOaXeMTUY9WooYEe6CYuU9ft0cJ5u5taH30PS
   aBujlB7WWf4TGlT+6C2PP0ydnCDSHsl9jhmhYC4jAQaTXBWP+iPMUve6I
   QEtd4lDdrasabEwle/JU0qWf9kj815BG1qQbtgTh8cwq8uMVcCiOSW2Uv
   h9kAaR2EyzWSpwsbOFkeCEAWt987eBpUZVbKni523EYMDjdUjKrrLVdu0
   aJUk4ssTpZiHOcKb2odgLUDTvwGpmCJTh2t6GZo72HJQzWyLscy2kDceX
   x2YkVBkPWTpBMt5LpBi5+N/anVZjXfOfVaaYsAUmWaAxJmzecBe6/a426
   Q==;
X-CSE-ConnectionGUID: KH8kUyCVTMSQAtS/zWLTIw==
X-CSE-MsgGUID: 5mXMZsWWROyzIeBstOt2Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24148844"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24148844"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:43:15 -0700
X-CSE-ConnectionGUID: eztMQyI+TB+hpZltWlWZ+A==
X-CSE-MsgGUID: Cc3guyExTRSw9dCcKpV/lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="104160936"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:43:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sngXi-00000006rJ6-1c1S;
	Mon, 09 Sep 2024 18:43:06 +0300
Date: Mon, 9 Sep 2024 18:43:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 1/1] x86/cpu: Mark flag_is_changeable_p() with
 __maybe_unused
Message-ID: <Zt8XivpWU9J-TyPj@smile.fi.intel.com>
References: <20240905170308.260067-1-andriy.shevchenko@linux.intel.com>
 <e08e8add-7e4b-4a87-adb4-b6f843752bec@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08e8add-7e4b-4a87-adb4-b6f843752bec@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 09, 2024 at 08:35:43AM -0700, Dave Hansen wrote:
> On 9/5/24 10:02, Andy Shevchenko wrote:

...

> > arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
> >   351 | static inline int flag_is_changeable_p(u32 flag)
> >       |                   ^~~~~~~~~~~~~~~~~~~~
> > 
> > Fix this by marking it with __maybe_unused (both cases for the sake of
> > symmetry).
> > 
> > See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > inline functions for W=1 build").
> 
> Maybe something like this:
> 
> 	http://hansen.beer/~dave/intel/onelessifdef.patch

Fine to me as long as the issue is solved :-) Please, submit it formally I may
test it.

-- 
With Best Regards,
Andy Shevchenko




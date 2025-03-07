Return-Path: <linux-kernel+bounces-551607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D1A56E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81543B256B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09C23DEAD;
	Fri,  7 Mar 2025 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0zy3WGk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE21C1F21
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366832; cv=none; b=fahN6OPf1Ufrh3Hswd0IvxC0f2YyXx6NN/6e4IWkQowz9Jl6OfgtmiU5/4wht2NWR2ZLaxN5WbJcg3rr1gf/+skJbEpYeOCbnj+e6G1ovd1rOGFWNdMJMDDgSt6JGmqKP2z0Y4RwZu1AjBqxQOQXxVOLLhqDEH/80vol7fU+ZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366832; c=relaxed/simple;
	bh=9nFCxX/OyE7guvEnsj1E2n484SO3Mw5Et2CDJQKUL+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV2Iu43DydCIDADD22Z4bPs2CkE3IiKMzFNfCKb17xV3XnPgcIcITDcD0fFQ5IgC+kRReMLCOhj7KbffTRel+Pi6eLyhl6rz7QU8pKs1OszyrQ01hnNH9wab5+HRRZMY0p2o8SZfTraQ48H6uIE6ZWSD5p9Gjb9J4dPKMHRwIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0zy3WGk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741366831; x=1772902831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9nFCxX/OyE7guvEnsj1E2n484SO3Mw5Et2CDJQKUL+U=;
  b=I0zy3WGkBFY7ei2LfaHQJOW0Tn7G9upxpi2zicA0WXPQZLKMd+obi6ZO
   hT8GLnes/j0g3T1V9dd50bitTErZHvIwun/1jOYoYl1fDv80GqXe+Nz+D
   nYd0bDH0NOoYiQhILjwxhk5rqBh6LwczeQolRX+kGqapA/Fddgm6KruNF
   o5/Ww11W2Oiqi2yC44z6gcMI10NoaI9bTm45eu1l/iJsIhtGdywhVrt9u
   KDAguiYZ7FR0sPoJb3wekHyM0ZSwYfcJ6km/q1AB3IfbEHLnYAiPrgpnw
   9UfOSp9bZVQw1swVOJopJBcOi25L+r83KfyOGxiReTVJSfh7z73gy8nIO
   Q==;
X-CSE-ConnectionGUID: MNt4/xE9RnWQgwkeHk3OPg==
X-CSE-MsgGUID: RhjxBSQvR/arph7WXch/nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="30002587"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="30002587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:00:30 -0800
X-CSE-ConnectionGUID: Qucppy/uQ9ieKqq3VQ+Jog==
X-CSE-MsgGUID: vBn7MYPjRaGGxI1JCnpW+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="142610717"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:00:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqb3i-00000000SsW-0bVV;
	Fri, 07 Mar 2025 19:00:26 +0200
Date: Fri, 7 Mar 2025 19:00:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 4/7] auxdisplay: hd44780: Make use of
 hd44780_common_free()
Message-ID: <Z8smKUrFkAxnoWlb@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-5-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXEx3tpwOYK3eCRgFyQ=05PLC93Upyasj3Bt29mmhAHrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXEx3tpwOYK3eCRgFyQ=05PLC93Upyasj3Bt29mmhAHrA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 10:05:38AM +0100, Geert Uytterhoeven wrote:
> On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Use the symmetrical API to free the common resources.

> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

> Perhaps fold this into [PATCH v1 3/7]?

I still think they are logically split.

-- 
With Best Regards,
Andy Shevchenko




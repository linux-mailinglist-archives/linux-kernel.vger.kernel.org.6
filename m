Return-Path: <linux-kernel+bounces-553786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E07A58EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8D17A5CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D402236F4;
	Mon, 10 Mar 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCdl537K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A964A02
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597299; cv=none; b=iuCt8aU4vDLkk1ZESNSejXUFFhjJhgcnXzNHsW9pNKxGqaasThyOR4DSxXIfyUH35Yu0cOGTceTH2HpBD4YmXT1RzK6cgROc9ZZKtubYnbShYE4gx5s4liza6mad2MzvVcjmtq9KI1/txpx5Wi/0v1S1+1nkBoO9TfWAOtsyOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597299; c=relaxed/simple;
	bh=vwqS0k5iM7Fry4eN6RAqLAfOv+4LoXLaeNCUJZGiBcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7QDy1pDCieJjuJSJ+5yKdQFCxXYxyZK/s9qYv50+h0vjvEGNGSHVizI1Koq7Mrq45cTZjKr975W79mAOZhIQRju/XYPhHO0we1VGgR6aLG0xKuoKlREiHsyMmuc1mpLpjmDqVB6q9AgN4/WC6v4rmwqeU7B95XFl2ZsXrwDdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCdl537K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741597297; x=1773133297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwqS0k5iM7Fry4eN6RAqLAfOv+4LoXLaeNCUJZGiBcg=;
  b=oCdl537KyLqL4o616tWj/rbtKQt+mFtXLxNI831UmFKeYPVPizuSm/6t
   mRYxatyYY8Dc5sBEd2WCi4dThsY3aCvQY2u0xg/dM2H4NmeiJOGUirfN/
   iwNZIon6UZ7q+yJfxbDnCt5AUD+hHqeeFYmXdOjGKgxzRLznIcBYVgXxh
   7ZA1UauC50wqoRCn3A5PZJ/djRrJEHem6vVCeB1os+T7Q/rjtJr8tWI3e
   EZSkoIASTvMl7iEGW9UzUTYwB5vUaUKHDdqjHTsbm8k4kRs6sA3OapCsu
   PFvUXzGqlUiNqK1TsPz54ezDuVtoOWgtHD0dJ7IbUAqGnpWRq6b+GoSau
   A==;
X-CSE-ConnectionGUID: wFfg7MCGTwaxDoLnBQEO9g==
X-CSE-MsgGUID: 92UM1PKcQCStFC2cZSPhEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42617477"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42617477"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:01:35 -0700
X-CSE-ConnectionGUID: KpqoNK4ZTlmEev5ewdqacA==
X-CSE-MsgGUID: CRTBPGsgTdyiGa5pUL/B8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124926971"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:01:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trZ0s-00000001CJQ-0U7Q;
	Mon, 10 Mar 2025 11:01:30 +0200
Date: Mon, 10 Mar 2025 11:01:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, nnac123@linux.ibm.com,
	horms@kernel.org
Subject: Re: [PATCH next 4/8] test_hexdump: Check for buffer overrun of
 sample output buffer
Message-ID: <Z86qacj2hchPyFGK@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
 <20250308093452.3742-5-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308093452.3742-5-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 09:34:48AM +0000, David Laight wrote:
> While the output generated by test_hexdump_prepare_test() shouldn't
> be longer than the size of the buffer passed, for safety verify that
> the buffer is long enough.
> If too short fill the buffer with an error message - output on
> test failure.

Isn't the function should behave snprintf() alike?
I think this patch is simply wrong because it's based on a wrong assumption.

-- 
With Best Regards,
Andy Shevchenko




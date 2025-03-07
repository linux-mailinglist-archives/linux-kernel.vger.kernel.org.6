Return-Path: <linux-kernel+bounces-550338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08422A55E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056693A8267
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094F18DB01;
	Fri,  7 Mar 2025 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UW7ikr8e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399C29408
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317352; cv=none; b=CHY2p/2bnmWz4bkZkmDB7yf1fWFL4gxXByYJ5QLoKqcSA8iG/+rNRunEH/h+clLcPoeCLMKCBTgiHMCP96bmR5BLpUMNSchoZVqHAK7EFR0CDWbW29MtDM7iXL7NqjYJo41QKNlZwYt9swEDJLV/6VRqjRAIjkvReGwsMrsOEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317352; c=relaxed/simple;
	bh=2rJkWuSBtkISh9ZlfGB8jSMeEWkGzg9DAK79HGQ2coc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyeL0wn/fcRj5lf62bVFAn2SQYo6UYIaRwP49vQ64CwAiTd+fFIxSo1rWZ3W8kfhFFcZq0ul6IPFkvTCsp0HWwCbMwEsuqH2oEoV5XrexFMqFA74prEvlhS+r9seyYB+rxIa1cKX1ULjoieyK2Gjpoz4+tfAhyP0LU5TvKby8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UW7ikr8e; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741317350; x=1772853350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2rJkWuSBtkISh9ZlfGB8jSMeEWkGzg9DAK79HGQ2coc=;
  b=UW7ikr8e+5odZ3AsKsOOZyQcMWpjioLa0En0NFkwqP3Wcpu/8GOC3fzG
   aZ1pyzjh4XEXtdaE5ntpJ0TpfG4ZlJB1uXVbfAUSTTKlxeghCoMv/OGdc
   q/1Uef9Umrhs4kU86wF/5gZLjBEXEEDWPO5kysByXsCgCUkFtWYrQ2yZu
   qJK86fH81klWNhs4P1yn66dUf99w02AZ8ZSMsYTeiGti+B7NM6dwJ1wBo
   +tAlNifeCDXPstFZ1XiLSKtdyWjhzZvdqxeW0pp4g1UMhIKj8/C4742ur
   rQybpnabizmJrgzniLPjy1cnEF+OXW31dzbEX5OlIufa3KpPSfA6tURvp
   Q==;
X-CSE-ConnectionGUID: HATp+tEwQP25N2m4RdPDfg==
X-CSE-MsgGUID: 1l8yI3s6S1m8Ta+2RpQmdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53000951"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53000951"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:15:49 -0800
X-CSE-ConnectionGUID: ygjpXukUTe+ZmrjXgPsK4w==
X-CSE-MsgGUID: 0L/KVubMRWKEvjlXf7/dsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="118943480"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:15:45 -0800
Date: Fri, 7 Mar 2025 11:16:04 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, yi1.lai@intel.com
Subject: Re: [PATCH 04/19] perf: Simplify perf_event_alloc() error path
Message-ID: <Z8pk9BNcEd5kpJFw@ly-workstation>
References: <20241104133909.669111662@infradead.org>
 <20241104135517.967889521@infradead.org>
 <Z8lVchtSX/w/atEU@ly-workstation>
 <Z8lp0z-7nlUr7LyD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8lp0z-7nlUr7LyD@gmail.com>

On Thu, Mar 06, 2025 at 10:24:35AM +0100, Ingo Molnar wrote:
> 
> * Lai, Yi <yi1.lai@linux.intel.com> wrote:
> 
> > Hi Peter Zijlstra ,
> > 
> > Greetings!
> > 
> > I used Syzkaller and found that in linux-next (tag: next-20250303), there are two issues and the first bad commit for both issues is
> > 
> > "
> > 02be310c2d24 perf/core: Simplify the perf_event_alloc() error path
> > "
> 
> We've had a number of fixes in this area, could you please check 
> whether you can reproduce this crash with the latest perf tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> 
Tested the tip tree perf/core branch - HEAD 7a310c644cf571fbdb1d447a1dc39cf048634589:

Above two issues cannot be reproduced.

Regards,
Yi Lai

> Thanks!
> 
> 	Ingo


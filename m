Return-Path: <linux-kernel+bounces-548526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283AA54618
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F681891C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA720897D;
	Thu,  6 Mar 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRXPt4L9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82D1FF7CC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252778; cv=none; b=gxzPQmO3xgBI7MGLzF5iK3f5hQaLGel49zgSP766B9POosZnV9vjgmSDHpVqldMTjxjui1C4SDPt1jnhxIYdG0nFybkh9UL9bxg95FuWtUzbt7CvSJCpS0fkeAYhkkPnMOzkdLFA4bC92IJzwv5ZFdUaHTc81cR6jmlhSNdtDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252778; c=relaxed/simple;
	bh=FSMOwT3FK7ALEK7VomTRlHAoma8aGFyxzCTL2beqkM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv+HZD5ajhexeRvyyWtVtC4R4pdz9Fp2k7ZQT1FW0IUXp3X7GkBurQGz8w8VCQjpuK9orhrV1LPk1nmXF8qPLyniR8lrE3TNMnxWMgwvJaU8Cey0M2tqjEGYQP8tLclnTo0Gzewl+F/MdXD0DKL9iwnjIRj3i0naMdcdsJeLzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRXPt4L9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741252777; x=1772788777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FSMOwT3FK7ALEK7VomTRlHAoma8aGFyxzCTL2beqkM8=;
  b=FRXPt4L94fASbgysAFi4uPKXjXuZaUEgdqS/w3sUqPkjpzQRR2qLAp7k
   cTxbg+ntwWORcQQPakSW3sR+k3t6slv3rqD8kS1IdCigDGjNqvahZDtM5
   OJR0Mo0lW2ex+O0txchya/qhYK/baFcSWDPRwj4J0Q2hpiMPTWBrgJqf5
   i1Lcjh/RNUmNWvwvb4TJ20i1v6s8VYPvcs8Op3Bls1GFOVkEP0mVi3mnC
   jlHyu2rL3GLIdfDagnxu4KdtumQE7ISDVwqQr8UIvr5Icj5gW4HaN2DrM
   M2YtRBtUp2xAj2tPOGmItomrQ9Lmm1l/er5kyZSJNOGghEJhv92N/BBtd
   Q==;
X-CSE-ConnectionGUID: Jk9fcdlESoimLSOU5iZoiQ==
X-CSE-MsgGUID: DnqDTlXhR9itZmhymcDteg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52461590"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="52461590"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:19:36 -0800
X-CSE-ConnectionGUID: 8nIu+zt8TeS+f90FOMhMvw==
X-CSE-MsgGUID: 1c55Cuh1Qe6hnujzuVYNhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123124537"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:19:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tq7O7-000000004Ve-3JwF;
	Thu, 06 Mar 2025 11:19:31 +0200
Date: Thu, 6 Mar 2025 11:19:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	bleung@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <Z8loo-N5byavJLkm@smile.fi.intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
 <Z8kFW13EyR0YXnJd@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8kFW13EyR0YXnJd@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 04:15:55AM +0200, Raag Jadav wrote:
> On Fri, Feb 28, 2025 at 09:22:47PM +0000, Mark Brown wrote:
> > On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> > > This series converts regulator drivers to use the newly introduced[1]
> > > devm_kmemdup_array() helper. This depends on changes available on
> > > immutable tag[2].
> > > 
> > > [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> > > [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > 
> > > [...]
> > 
> > Applied to
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thank you.
> 
> Unless there's a nuance intended in the merge series title that I'm unable
> to understand, it probably seems incomplete.

I believe it's an issue somewhere in the scripts. The long Subject line is
split in the mailbox and that's probably is not supported by the machinery.

You are not the only one who reports this issue.

-- 
With Best Regards,
Andy Shevchenko




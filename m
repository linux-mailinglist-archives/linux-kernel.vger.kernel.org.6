Return-Path: <linux-kernel+bounces-548941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444DCA54B30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4B51727E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE21FCFE6;
	Thu,  6 Mar 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uu3L2VRL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089091FAC45
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265433; cv=none; b=f8pL1D4oodfSh2fXQBTJIEjFfdE8ZIMSCbqDW/g4IFh070g3639AyeZFVb3+OGfuKMjUyq98W9pqXkjf1CJB3G6WBr5VBMs0Iu0cdIf1c0q3/4/GLV2HBanM828mkqrlfQQaV9goqGC8AK1ue1C9hGXdmKtQWLwco+h7csuF8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265433; c=relaxed/simple;
	bh=BtNMsxiok8bjE/Uecuit1I1KeHCfuemYnlxgnIJ8nGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IONeZqmw9WRxIIrBHoRi4nC4DicGGZGgM6Zf96owLLWB2e+vTon/fwJEOn7XQDaSEEWkAGV3KiU5rb3rNZxrLlhgSSQ9qWH6XLdrGcodOYUP4Lt7HMsBc2A68IAotDQXt3Ed/LNuWgN+hHdGOT7DfZcxss8X9maaOYLLl2njV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uu3L2VRL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741265432; x=1772801432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtNMsxiok8bjE/Uecuit1I1KeHCfuemYnlxgnIJ8nGI=;
  b=Uu3L2VRLETsgIrbev16snR698mXLgvNB3QHbnEsFpLRQ97wu5Ta+jYaG
   k/TAkA1uPKIMqzU5ixY9k/x4HbP7+uWjkYfMWtmIm0UsvyqNKoBil1Rcp
   y90Frm9wngMxvnyt5EMHeXY1Q7mU2CFBFRdQwB013OaMWHWGhqdOZeWAH
   q79OmFAtS4ugVODwz5zsue9dhhAiszU3GMqY/EeUF5oBAr7S78CFr4U3d
   pdRFhiXC0CXK2zY70dAOCnubQjZlcVVuFeO5eyeERXuqeGu+BT93tc5N2
   NJ8O1SfzOj9lA6gVQFlBKIwz6hwVOPNKDqSyz5BlvvKbgNP4ZGdIwqP/0
   g==;
X-CSE-ConnectionGUID: XSdsHb6QRAS8XX1rxjzbSg==
X-CSE-MsgGUID: i6ZAcoWaTg6smoLoj1rDMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41978048"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="41978048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:50:29 -0800
X-CSE-ConnectionGUID: InDhsmqWSpus9n+GhZgblQ==
X-CSE-MsgGUID: BkU8VWW0QJO1LHb3Lp9ryQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119021849"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:50:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqAgC-000000007R2-3yOR;
	Thu, 06 Mar 2025 14:50:24 +0200
Date: Thu, 6 Mar 2025 14:50:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	bleung@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <Z8maEKX-4vbwtra3@smile.fi.intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
 <Z8kFW13EyR0YXnJd@black.fi.intel.com>
 <Z8loo-N5byavJLkm@smile.fi.intel.com>
 <Z8l1ozUOMTDNQupC@black.fi.intel.com>
 <Z8mBQEKAJfZd6a7G@smile.fi.intel.com>
 <Z8mHw_W1xT9Mcilt@black.fi.intel.com>
 <Z8mXJUwt4q2NY059@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mXJUwt4q2NY059@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 02:37:57PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 06, 2025 at 01:32:19PM +0200, Raag Jadav wrote:
> > On Thu, Mar 06, 2025 at 01:04:32PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 06, 2025 at 12:14:59PM +0200, Raag Jadav wrote:
> > > > On Thu, Mar 06, 2025 at 11:19:31AM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Mar 06, 2025 at 04:15:55AM +0200, Raag Jadav wrote:
> > > > > > On Fri, Feb 28, 2025 at 09:22:47PM +0000, Mark Brown wrote:
> > > > > > > On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> > > > > > > > This series converts regulator drivers to use the newly introduced[1]
> > > > > > > > devm_kmemdup_array() helper. This depends on changes available on
> > > > > > > > immutable tag[2].
> > > > > > > > 
> > > > > > > > [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> > > > > > > > [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > 
> > > > > > > Applied to
> > > > > > > 
> > > > > > >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> > > > > > 
> > > > > > Thank you.
> > > > > > 
> > > > > > Unless there's a nuance intended in the merge series title that I'm unable
> > > > > > to understand, it probably seems incomplete.
> > > > > 
> > > > > I believe it's an issue somewhere in the scripts. The long Subject line is
> > > > > split in the mailbox and that's probably is not supported by the machinery.
> > > > > 
> > > > > You are not the only one who reports this issue.
> > > > 
> > > > While I'm not well educated on the machinery, I'm also seeing devm_kmemdup_array()
> > > > introduction commit reordered in -next and thinking perhaps it can cause issues
> > > > with bisect, especially after final merge into Linus' tree?
> > > 
> > > I;m not sure what you exactly pointing out here. Mark seems applied only
> > > necessary part of the immutable tag, which have the same effect. The Git merges
> > > only once the stuff as long as it has the same hash.
> > 
> > $ git describe
> > next-20250306
> > 
> > $ git log --oneline --grep raag
> 
> --author="Raag ..."

...

> > 1f4c7f3b3afa Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()"
> > a103b833ac38 devres: Introduce devm_kmemdup_array()
> > b8c38ccb2ca5 input: ipaq-micro-keys: use devm_kmemdup_array()
> > cdcc09a495a4 input: sparse-keymap: use devm_kmemdup_array()
> > a0d78eec8839 iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
> > 86068aca7548 pinctrl: pxa2xx: use devm_kmemdup_array()
> > 91bfcc7a2fdb pinctrl: tangier: use devm_kmemdup_array()
> > d795fb90d6c6 pinctrl: cherryview: use devm_kmemdup_array()
> > f192c8447f4e pinctrl: baytrail: copy communities using devm_kmemdup_array()
> > 753764aa8eb5 pinctrl: intel: copy communities using devm_kmemdup_array()
> > a21cad931276 driver core: Split devres APIs to device/devres.h
> > 18311a766c58 err.h: move IOMEM_ERR_PTR() to err.h
> > 
> > I'm expecting commit a103b833ac38 to be before its users, or perhaps I'm
> > doing something wrong here?
> 
> $ git tag --contains a103b833ac38
> ib-devres-iio-input-pinctrl-v6.15
> next-20250225
> next-20250226
> next-20250227
> next-20250228
> next-20250303
> next-20250304
> next-20250305
> next-20250306

Ah, and this:

$ git cat-file commit 753764aa8eb5
tree 7d99d7bb009118f7c0d8cbac9aa2ae321fc74785
parent a103b833ac3806b816bc993cba77d0b17cf801f1
author Raag Jadav <raag.jadav@intel.com> 1739341506 +0530
committer Andy Shevchenko <andriy.shevchenko@linux.intel.com> 1740391732 +0200

pinctrl: intel: copy communities using devm_kmemdup_array()
...

Most likely it uses the one which was merged earlier by Stephen, who merged
the ASoC before merging my immutable tag.

-- 
With Best Regards,
Andy Shevchenko




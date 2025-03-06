Return-Path: <linux-kernel+bounces-548817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6FA549A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6AE188E7A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE49D20ADD5;
	Thu,  6 Mar 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X55/Srki"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58F20897A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260746; cv=none; b=gEHmAUmgaohMT+kCjvuWMi2+dtLL1GWHS/COEPGscxKzduCZCQ6N1U2GXVux4NE57ZNzW3Fdz6Si+KUlt8urey+ce3a6qESk2A552C/i2Xz/YjmzGUQ39WSF6CuTBgst+iZ2FEAaLECS/2ULpZMB9rDGhPnb6MLb5w/YQc8P6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260746; c=relaxed/simple;
	bh=a2j9RG6bTGyCJunOhRmWkw2ykX0aGhZbgKKK5qS8xUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsKivhJalvvZchXd1J3EkbcjA8GOVBUVm9CvCDmwwKJ74ZPyWbEBK+VzjcagCLVkmDoqlpf5s0IujzOISSyQDsGqTwPhGwJC3Rt0KaAWj+OvOY37XrZJAthFGEUVn9pTj79dIMj0bnQltJMBSWRQRuA/lOPiZOPhEw04cwUK7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X55/Srki; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741260744; x=1772796744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2j9RG6bTGyCJunOhRmWkw2ykX0aGhZbgKKK5qS8xUY=;
  b=X55/SrkiXacy5yLX1pIu5ZcHvIuFWh7NkW7UScTeT/Ob9Nfs4ERXO1uw
   hfvhLk+cTrYH7qOot9NvvWuU0rOCKZvieH32VrRHQMv+YKhLgmeJJcNDQ
   1Y6MTfIGqWxr+D4pP8CFAipszdPk/FIh1z3D/eJ/A8kywqUyd4wd48IPm
   wxqOX++Efv55fM+J5vAY6Kw3Tv5Lv+GFfVRljubcIiqYpEzE3qtB8RriA
   t/8t7hOZe20GaIctGbx5M5oyXgjpisyED2OvCg3q1dBEW7v0Gi1V7T6sf
   zCrlFHuKz2r982BrUivpICwNO5MYTZ0F7iUX3eSS03Vu005acOSJwHZnm
   A==;
X-CSE-ConnectionGUID: GRtHBt5zQ9uHQosNP1T+bQ==
X-CSE-MsgGUID: WQY4A/9hSCm/0ggjNfqm3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42504789"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42504789"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:32:24 -0800
X-CSE-ConnectionGUID: DVhXeTceT0y55ijcMcGxXw==
X-CSE-MsgGUID: 5QapAizbTtG5KKgZ7LMI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="142222283"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:32:22 -0800
Date: Thu, 6 Mar 2025 13:32:19 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	bleung@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <Z8mHw_W1xT9Mcilt@black.fi.intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
 <Z8kFW13EyR0YXnJd@black.fi.intel.com>
 <Z8loo-N5byavJLkm@smile.fi.intel.com>
 <Z8l1ozUOMTDNQupC@black.fi.intel.com>
 <Z8mBQEKAJfZd6a7G@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mBQEKAJfZd6a7G@smile.fi.intel.com>

On Thu, Mar 06, 2025 at 01:04:32PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 06, 2025 at 12:14:59PM +0200, Raag Jadav wrote:
> > On Thu, Mar 06, 2025 at 11:19:31AM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 06, 2025 at 04:15:55AM +0200, Raag Jadav wrote:
> > > > On Fri, Feb 28, 2025 at 09:22:47PM +0000, Mark Brown wrote:
> > > > > On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> > > > > > This series converts regulator drivers to use the newly introduced[1]
> > > > > > devm_kmemdup_array() helper. This depends on changes available on
> > > > > > immutable tag[2].
> > > > > > 
> > > > > > [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> > > > > > [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > > > 
> > > > > > [...]
> > > > > 
> > > > > Applied to
> > > > > 
> > > > >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> > > > 
> > > > Thank you.
> > > > 
> > > > Unless there's a nuance intended in the merge series title that I'm unable
> > > > to understand, it probably seems incomplete.
> > > 
> > > I believe it's an issue somewhere in the scripts. The long Subject line is
> > > split in the mailbox and that's probably is not supported by the machinery.
> > > 
> > > You are not the only one who reports this issue.
> > 
> > While I'm not well educated on the machinery, I'm also seeing devm_kmemdup_array()
> > introduction commit reordered in -next and thinking perhaps it can cause issues
> > with bisect, especially after final merge into Linus' tree?
> 
> I;m not sure what you exactly pointing out here. Mark seems applied only
> necessary part of the immutable tag, which have the same effect. The Git merges
> only once the stuff as long as it has the same hash.

$ git describe
next-20250306

$ git log --oneline --grep raag

...

1f4c7f3b3afa Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()"
a103b833ac38 devres: Introduce devm_kmemdup_array()
b8c38ccb2ca5 input: ipaq-micro-keys: use devm_kmemdup_array()
cdcc09a495a4 input: sparse-keymap: use devm_kmemdup_array()
a0d78eec8839 iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
86068aca7548 pinctrl: pxa2xx: use devm_kmemdup_array()
91bfcc7a2fdb pinctrl: tangier: use devm_kmemdup_array()
d795fb90d6c6 pinctrl: cherryview: use devm_kmemdup_array()
f192c8447f4e pinctrl: baytrail: copy communities using devm_kmemdup_array()
753764aa8eb5 pinctrl: intel: copy communities using devm_kmemdup_array()
a21cad931276 driver core: Split devres APIs to device/devres.h
18311a766c58 err.h: move IOMEM_ERR_PTR() to err.h


I'm expecting commit a103b833ac38 to be before its users, or perhaps I'm
doing something wrong here?

Raag


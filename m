Return-Path: <linux-kernel+bounces-539083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A574A4A0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4387F3B7593
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE5426B0A1;
	Fri, 28 Feb 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeNhZnC6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C621F09BF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764523; cv=none; b=FmsnLljoOUPqFXM+GStwNigVGHRQIyRbd1nm1uGOcD2Ny4KAmMbIyAA5c+NKX1V7tFwFFsMz8ZfKy1YNA1jkXxyLE10bw170xoV+JgLSMajYKL2v6p+O/alOM1T5LJ4j5BdO36OQu1VpFdubMqKpvBoMOSBX3TKsE3hYzckgWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764523; c=relaxed/simple;
	bh=cQP9Tjjpixo0PJZ0ElOw99s5hBvUi8QO1U/639xGd/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi1hBVRLKda+VP6Fup6hyFbUEEVQHTLTG5HkwCi+xk6ZqLGuOcK4VgaalQyJr0ghkzPZrFB9fZsQR4DQN4UotvbyBs/bde6BQyggaQQL+XbT0/9mbbRonTwJQVydiRQlkPCBZkdzz8y2EWZFZvbwpLmA6sQH6KDQZBFr1gTr/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeNhZnC6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740764521; x=1772300521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cQP9Tjjpixo0PJZ0ElOw99s5hBvUi8QO1U/639xGd/c=;
  b=UeNhZnC6gAmk2eFHVXfthRuNFZw7aDMsnUpUpgcoiyZM4F4UcvfADdx8
   sX4fojo2/vHKbi5QJfyhWD1I9Og8lM5a6QlpMrQV9W9oZ+f78EP3+st58
   jLjzRPz1l7tg/VNnhDikLbA3ADBnHhlu2UI7B0bIBzIEhrwypDy5tJled
   I7bOtqu3cYJf7Kn4bQ4j/WqrqIrzeM4k0Ve1g2ry7LorKz7Xf/TMR9mF/
   JMal+D1QK5CoWM3L+/RPjKkdcJjt9Pb2ZepJ6GyMsoSPKijlnOBXa8Rs3
   NUq/qqQ6tV77RUQiXbIb3d353cvXgJnHV1SpmD/5AaPGhWFiJ7RIwfoEi
   w==;
X-CSE-ConnectionGUID: gBmCJSFtSciyv7uefUjbgg==
X-CSE-MsgGUID: 04wz+ZytTfy1ytleg+/ItQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="64163328"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="64163328"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 09:42:00 -0800
X-CSE-ConnectionGUID: yFkVV49TTam7fMsQon5sjA==
X-CSE-MsgGUID: 5KkR00mHQHCdd2ZJaXak5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117153369"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 09:41:59 -0800
Date: Fri, 28 Feb 2025 19:41:55 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Message-ID: <Z8H1Y2_RlFnXeNEa@black.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
 <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
 <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>

On Fri, Feb 28, 2025 at 06:11:16PM +0100, Arnd Bergmann wrote:
> On Thu, Feb 27, 2025, at 16:25, Andy Shevchenko wrote:
> > On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
> >> This series attempts to cleanup io.h with "include what you use" approach.
> >> This depends on changes available on immutable tag[1].
> >> 
> >> Although this series is too trivial in the grand scheme of things, it is
> >> still a tiny step towards untangling core headers. I have success results
> >> from LKP for this series but there can still be corner cases. So perhaps
> >> we can queue this on a temporary branch which we can use to submit fixes
> >> in case of fallout.
> >> 
> >> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
> >> headers.
> >> 
> >> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> >> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
> >> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com
> >
> > I believe Arnd can take it through his tree for headers as DRM part is 
> > Acked already.
> 
> I've applied it yesterday and not seen any regression reports so far.

Probably because the immutable tag is already in -next?

Raag


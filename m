Return-Path: <linux-kernel+bounces-548129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B3A54086
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D152416D55C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D38624B;
	Thu,  6 Mar 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCd7FbWT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B382907
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227365; cv=none; b=DRqFpkj9WkYgT5cFyiCGbCaJFfLTzns5d6YuUlZjGdpdEr0RR74ahsciZC7M8eBiQo68lXyBxCgbkpb90Fpl/+AWVY+smvrYSVMY1RenX8PFf4TPoKxDdn8vF3AYM5z71rY3MKZ5NScxuxDqrEmr7Yy5GUXUijY1gJOV6LtbBn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227365; c=relaxed/simple;
	bh=hre3KWbtLZlJ8gpm3PXcYrFGtKi11s2Z/HO4eIG4T+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoSM5p/p5oM0z/0q9PY45Ya4mICCE2aoZlRopinr+QcMzWbwk+Zc5JV4DdQY51OAhfElAKDfDjKpajsTwe3XNmEUud7T97ZclxUB5zO0VIlqcUzr1nSd6GteQbSVS/FKb6lG0NNKxzRvfOoHhI5liq5F+gJzpWVjnBDu+fitEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCd7FbWT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741227362; x=1772763362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hre3KWbtLZlJ8gpm3PXcYrFGtKi11s2Z/HO4eIG4T+c=;
  b=OCd7FbWTVrgyaUso794s2Nr42V2DhokZB9kYJ1szLzDG8TbEZ4kKz416
   y5tbL7bxPUkzqe5oF7gKHsi9a2Ti7JNVpqq0ATaJcrB3jx7naLS+UPJGb
   USgu8ilTomfoFoHlv9LFlTCv76Q4LeEos8BxxEHZ8St04VZgAuWrVhYQM
   LIWCljXhrLZH4fF42wdbgC+JYas0h0W+IePNpaTJ2ycZsW9x/WLm/Zt5Z
   Ge6JgPsBYBKursSCeB8wkdJH+S9KibS3prncS2DVyO5L8I0FFUfNTpqru
   q2uZ9aDKCZnLQdqtxbOeK/WaPA76N18HLgVtZygc6h9YK4xcD9JUMLbhS
   g==;
X-CSE-ConnectionGUID: Wl/GWrcUQtG3rLcc5fj07Q==
X-CSE-MsgGUID: oC8Nb+j/TpqFsdknK1QrKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59769762"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="59769762"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 18:16:01 -0800
X-CSE-ConnectionGUID: lrdOpHT0SRStUfVZghY6UQ==
X-CSE-MsgGUID: aDQBgjzaQViZoVyZTV+1gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119788478"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 18:15:58 -0800
Date: Thu, 6 Mar 2025 04:15:55 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, bleung@chromium.org, groeck@chromium.org,
	andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <Z8kFW13EyR0YXnJd@black.fi.intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174077776750.602863.5336934105237710269.b4-ty@kernel.org>

On Fri, Feb 28, 2025 at 09:22:47PM +0000, Mark Brown wrote:
> On Fri, 28 Feb 2025 12:50:55 +0530, Raag Jadav wrote:
> > This series converts regulator drivers to use the newly introduced[1]
> > devm_kmemdup_array() helper. This depends on changes available on
> > immutable tag[2].
> > 
> > [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> > [2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thank you.

Unless there's a nuance intended in the merge series title that I'm unable
to understand, it probably seems incomplete.

Raag


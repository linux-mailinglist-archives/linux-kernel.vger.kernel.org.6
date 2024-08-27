Return-Path: <linux-kernel+bounces-303557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108E960E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299C21F23D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AD91C6886;
	Tue, 27 Aug 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+z+YdiB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648251C4ED8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769861; cv=none; b=KqVxfhuKL0MyI5VIpKsPHRNV+YnPALGO0BOyvJpztv+IYHZnLX1xWl3dlEKUKNfT0hfURitbn6OnDuW0sl/a1Lmwxcz/MZpNiGJTY/kPqOEADoUNz9wwtfWIc4XgxnNjeq6hzO5DhkgU8qFO1c++aASExskyaZP3vA5R0TD4ej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769861; c=relaxed/simple;
	bh=xbWAO4bs/u/FAVhGCHrVKwBLVU+BZDi3opmzbqvKbAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klmrOwjHe7sFlUhVbM/Mi9tT0cRFWTxrhjnk8bGipReUaD/qssYw5zbd+k0/yMRbpMYcz0BkWIkOZiAIc64MqsQYdJ+BWcjNuRtuqShIi0yw5M6XlHsj6FLowK4WzH4ugVmFmlM1Pbm7P/vpXZ34eU8jPJd4JuwsK6aAD/0DYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+z+YdiB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724769860; x=1756305860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xbWAO4bs/u/FAVhGCHrVKwBLVU+BZDi3opmzbqvKbAk=;
  b=B+z+YdiBR21alM7ytT8eyvnGaA0hk+qi7826FFOoC1bbiNX68o02t/1/
   So0uZoqFK2WH2su9TV1ifWNu2j4sJxf3tMmo07ZyYIpMOiwSJX5ndk69y
   Xu1pLqGeUaKf2T+ZxK6JvLgMv6YB1z7WUGZNGEebkBLrR7237Q4nj/9qM
   ax6luKXeXuOIBnTA6pYd6AmSjl4qLdXKsw+DjwBhd0QCepHWgKxqy5bsl
   j0hVw2PFIuwSRk4VYHYOVbhCrzsb8IPts9Wcl0rgT5Jixz//2mU7M2mzE
   uQXk5b1S9SabpLOdl8eXbuSOLhOkoB/V8zqCSoRT5prKE/QHPuiLzB5vG
   A==;
X-CSE-ConnectionGUID: H7aOd/jySZum3qvrjfE2CA==
X-CSE-MsgGUID: Up1HS7oaQbWCwfRZLwcFyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23426469"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23426469"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:44:20 -0700
X-CSE-ConnectionGUID: wAnzJwcsRSqZUiylARSCEQ==
X-CSE-MsgGUID: qJ+7mJfESzOLPePFPKQQDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63051838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:44:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sixQd-00000002IXL-499O;
	Tue, 27 Aug 2024 17:44:15 +0300
Date: Tue, 27 Aug 2024 17:44:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] regulator: irq_helpers: Add missing "Return"
 kerneldoc section
Message-ID: <Zs3mP547BolU4MRt@smile.fi.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-9-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827095550.675018-9-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:55:48PM +0800, Chen-Yu Tsai wrote:
> kernel-doc complains about missing "Return" section for the function
> regulator_irq_map_event_simple().
> 
> Add a "Return" section for it based on its behavior.

...

> + * Return: 0

"0."

> + *

I don't think we need this blank line.

> + * Actual regulator error and notification are passed back through @rid.

-- 
With Best Regards,
Andy Shevchenko




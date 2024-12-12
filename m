Return-Path: <linux-kernel+bounces-443205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECA9EE8CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B1F18897E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13B92153DC;
	Thu, 12 Dec 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xqhx2jRi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4A8837
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013733; cv=none; b=GDKeT8u0j6J6bR1SbdreGbtAiw0TX9ZZIgFtgELt9ApKzfYbpO0Ww0SyLJUQYyT3/3Cjj1vyEi4rjVnF5icH+OpQ6MEPNW7xnZZLDpRVgmmLvb8MkcYi3RtwxPL/5rTAsq4+VQTMoDlrV557wZd5Uhk+Ie+WMqZLUmnp0LvnELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013733; c=relaxed/simple;
	bh=NBrOJe97HyWxqbkFWU1zjLsc/TafGY4g/rTx0UOxLrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP7bZBL9ZZWIhjg7hAgbUnBMMSiwb3WIn9PyWEb8R7BTCLXW9HyGaSj+ZrsK3IsH1ySsFDZP8ZJyeNoZ+R/0q2vKrSK9W3ZU779vSDddUa9jt1pycI64Q7eGF/8jab5zGlj7aFqE6mleQhqxZH2XogLlQoBYPKMyvBgA7p8yfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xqhx2jRi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734013732; x=1765549732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NBrOJe97HyWxqbkFWU1zjLsc/TafGY4g/rTx0UOxLrc=;
  b=Xqhx2jRiz7rNLBfZuUbavn0zmT8zSfN3W/OqsEQ4v17BBwrTt7x3tXup
   2x6lplgRkKRMOLUedhgcAEnZlq8JIYxVxaWO84v1rJibNtAQ5fbr5+r88
   YA9yZaCo0tgndNCF+0mbIGiuRJiBsHw6kNtBatuyYmoOG10qouR4syeAe
   yip6LT6yI8eml2jvGZPkdiPgDI0DZQcMoHLQmbgwYCMhcedpZvXLkkHMu
   HkoefCnm7R1tyPHjWrhmTGXS0gc9r+C+alThfJYxKU+YT3F4TvjireFoN
   /ZyRfQr+PcJ3I/mbweA7vrhbm12f/UdCqn7Zvrkp8UPnMHCvTMGU24frQ
   g==;
X-CSE-ConnectionGUID: YYpRLkf2S72l3WjzkWKjyw==
X-CSE-MsgGUID: 9BJwCxwCQGuk2YCj9glVcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45112546"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="45112546"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:28:51 -0800
X-CSE-ConnectionGUID: nPoM7qa0SsC6TdyulO8oLw==
X-CSE-MsgGUID: MaHIQt6QQ4ahIxAJgq7OPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="127045775"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:28:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tLkBK-00000006vC7-46D5;
	Thu, 12 Dec 2024 16:28:46 +0200
Date: Thu, 12 Dec 2024 16:28:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] regmap: Synchronize cache for the page selector
Message-ID: <Z1rzHvJDgPdlfEBK@smile.fi.intel.com>
References: <20241122140357.1337686-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122140357.1337686-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 22, 2024 at 04:03:20PM +0200, Andy Shevchenko wrote:
> If the selector register is represented in each page, its value
> in accordance to the debugfs is stale because it gets synchronized
> only after the real page switch happens. Synchronize cache for
> the page selector.
> 
> Before (offset followed by hexdump, the first byte is selector):
> 
>     // Real registers
>     18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
>     ...
>     // Virtual (per port)
>     40: 05 ff 00 00 e0 e0 00 00 00 00 00 1f
>     50: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
>     60: 01 ff 00 00 ff ff 00 00 00 00 00 00
>     70: 02 ff 00 00 cf f3 00 00 00 00 00 0c
>     80: 03 ff 00 00 00 00 00 00 00 00 00 ff
>     90: 04 ff 00 00 ff 0f 00 00 f0 00 00 00
> 
> After:
> 
>     // Real registers
>     18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
>     ...
>     // Virtual (per port)
>     40: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
>     50: 01 ff 00 00 e0 e0 00 00 00 00 00 1f
>     60: 02 ff 00 00 ff ff 00 00 00 00 00 00
>     70: 03 ff 00 00 cf f3 00 00 00 00 00 0c
>     80: 04 ff 00 00 00 00 00 00 00 00 00 ff
>     90: 05 ff 00 00 ff 0f 00 00 f0 00 00 00

Anything should I do to move this fix forward?

> Fixes: 6863ca622759 ("regmap: Add support for register indirect addressing.")

-- 
With Best Regards,
Andy Shevchenko




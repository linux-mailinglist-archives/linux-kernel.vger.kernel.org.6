Return-Path: <linux-kernel+bounces-529204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B57EA420E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A6718860FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180A244190;
	Mon, 24 Feb 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVXddo2p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDA17C61
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404423; cv=none; b=jRZ+yRiEAWoa8LIjd0qEc7YxhFlgaPim7KQg3xeMUXNO3ClQzybsU01wcgHuzL6OalhkX44AyzB+2eROmdxoBD2ewFgJZbuRrzYv1/cTte8zE1rWd4gbRtK4tifeM5Y2Fvuv9u/g8+kedEvf80HRbHwKsr+KAe+I7kW5uq5xvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404423; c=relaxed/simple;
	bh=3wCxBnsKCAkrS0VfjhZ3YTnmQKMMRZEjmrYBPXEweaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKqKxAq6G+pGTqy1ijOFAiIzHyGzZa75io1fc9aPkY7/RpYtA94CrKBMV7OGAFFdLCt2869FooN9RKQIY1qmqB1qn34ts0kCUhCBkwrX4jAkWUoJk22LJ/ZWYRXrLacrYFoEezGNbZTDeRAqtwFAERnOUN1vVjRRuLrnxFwPiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVXddo2p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740404421; x=1771940421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wCxBnsKCAkrS0VfjhZ3YTnmQKMMRZEjmrYBPXEweaE=;
  b=iVXddo2pK+tWblMlFLkAYqXt6VvuDLFvmglR8U8CzLanc3jv5QQIqqo4
   wCkJYNbM7HSI+JywviXTs4b0QtUTgQBQtN1SfZOVk0tI824mobsrdfdL+
   d7W/BjzsqzEQMfP+d9ABnBZai+ywddks9YfIJ5I0S43W8aqXpIfKlDiyv
   mdW7yTZFli/16LOZpP21wLQBwX4oPygCFl3+N7iwHegc8XvQVQ+G/ePXJ
   qA4qLNiA5SSltC9SjUXQy0Ftp+CgfH1fChiJUFOXELScMTiwTqcNpzS1K
   89n2F6EgA4hz8TfP1dxciz66TE3QVlTi24S19x29bMI9Kb9EK+qX+Lk+n
   g==;
X-CSE-ConnectionGUID: eJq72oayRdydFW5EOERKgQ==
X-CSE-MsgGUID: CflSPn5QQzGXlVsb2WyQVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41275979"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41275979"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:40:21 -0800
X-CSE-ConnectionGUID: 7I7XWYKSToWIWcV8X27InQ==
X-CSE-MsgGUID: D1noMB3vRAi1lacutA5XOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121157836"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:40:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmYgz-0000000Ehz9-1L05;
	Mon, 24 Feb 2025 15:40:17 +0200
Date: Mon, 24 Feb 2025 15:40:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/1] auxdisplay: panel: Fix an API misuse in panel.c
Message-ID: <Z7x2wJIHi8l4J003@smile.fi.intel.com>
References: <20250224123625.3816062-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224123625.3816062-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 02:36:25PM +0200, Andy Shevchenko wrote:
> Variable allocated by charlcd_alloc() should be released
> by charlcd_free(). The following patch changed kfree() to
> charlcd_free() to fix an API misuse.

As discussed with Geert in another similar change this would also need
Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")

-- 
With Best Regards,
Andy Shevchenko




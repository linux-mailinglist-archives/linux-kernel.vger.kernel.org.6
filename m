Return-Path: <linux-kernel+bounces-417066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD19D4E82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1197E1F24B35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EB1D63FD;
	Thu, 21 Nov 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG5YGUd6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101B1D79A7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198637; cv=none; b=LS8+jVN8wXIJmElfHbVL0mFhcf84D9JSHRl3dlWpCMS19gMaX8TAnFkYkhH1F9HPYKXUz+3Lp0qsFGhB6WJO66nVZ5y2obl1fFWAONfMXDXYJLSRrcWDjr2EeSHCQo3z0/pnEYEAeNxJgXAIPBSzXIM0OBoMVnTqCNnBeh2FpQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198637; c=relaxed/simple;
	bh=MBBqV0m/ntImifX5lORyCAqnf/uWBdgaxC5z0Sou1WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/WIRR0QRxdqar7wvXHvTc6xsUQWEiE54LYGfHoozyLD2OwgHBxs0riKEkE15wQ7EMq2pW18MyIDN/c2NUXhc++vWy0QzqHXRW7Y8a97LOSuSvP7QFgM9mvXzupQBAireMStATvFuy27Kow48MSz3OMjQnMnncT+iCS8DazMQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG5YGUd6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732198636; x=1763734636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MBBqV0m/ntImifX5lORyCAqnf/uWBdgaxC5z0Sou1WE=;
  b=iG5YGUd6ioyad2b1RGLFYmCTOD8s+Kp0P9b4fg+sPVILZQ1adf858yay
   jTA0TTIpzHtj0CeNgsnZavNpKgrjOOo8PqyjzIVDmIbcaZ8+YIBplNtOD
   B9v8jk+6S6m18GFWXX29dcXHviqAZ08aQaVjxgFddkm3kAshqwANG2Iz3
   l8OyuIqRNtXgxySADQkxKoPDQXG+J6wK7Jjr/hOELHFY/kpO5BHaMDY8q
   yuW+bEDMPEm2LwKdomtRa23UIIdGWsB+XdzQJ+pDUTW4U+r9pgoNLYXS6
   hcF8OkcxretctkxjZ25PhlAG9kxQd42B4SpdQ8wdPyNAonyS2W+K47WtU
   g==;
X-CSE-ConnectionGUID: YbVusLflSYC5pxMr4KVSCw==
X-CSE-MsgGUID: 1SeJExXGTD6Gpnr7iwtKTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43376187"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43376187"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:17:15 -0800
X-CSE-ConnectionGUID: WAzREU2dTVGKv2M2l999Dw==
X-CSE-MsgGUID: YzY0SPebQeCBN2somvsrPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90242724"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:17:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tE7zb-0000000H5Lm-2bND;
	Thu, 21 Nov 2024 16:17:11 +0200
Date: Thu, 21 Nov 2024 16:17:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2 0/2] kcsan: debugs: Refactor allocation code
Message-ID: <Zz9A59XQdiHJ8oLp@smile.fi.intel.com>
References: <20241121141412.107370-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121141412.107370-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 21, 2024 at 04:12:50PM +0200, Andy Shevchenko wrote:
> Refactor allocation code to be more robust against overflows
> and shorted in terms of LoCs.
> 
> In v2:
> - collected tags (Marco)
> - added patch 2

Okay, it seems I have to check the Linux Next for the current state of
affairs...

-- 
With Best Regards,
Andy Shevchenko




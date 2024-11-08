Return-Path: <linux-kernel+bounces-401347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1C39C191B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32B1283BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370711E0E15;
	Fri,  8 Nov 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ym9NHcVG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8BE1E0B76
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058150; cv=none; b=ZGKhr/5lIwIMqVudX5ANZICgXQyJ8MvjpzKX+gdTtD9IhXgWLNOSi42pq5gNRz1W40XOcEHnxAavVOfDn8q+HI+l05EznPth1hP8DtUTnN2QOPiY04AUg2Ni0xVEc5B/qLmK6Ba7UcwaUFrCKgvFIRzzTzGHZmWIyfgt16E8LVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058150; c=relaxed/simple;
	bh=97ewqBv8krSfrwu5ix6jXk3CMT4PaAit6WPskFBVOwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBqa54qikf4vjdApVt3PHNpUM5pBEAt8i842JkZL3IrB/XQyTcwOUe7SJgRZPSx9TUxnf+/BjYkSq4SlThf6lEgIzH/wbpHnHSnR1jvD1iieKxErVRkTxLpJ0menRelIocUFEnZpt0/4CwnKJ/JANJ5mGLjtDyKW1lZKoOiPkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym9NHcVG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731058149; x=1762594149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=97ewqBv8krSfrwu5ix6jXk3CMT4PaAit6WPskFBVOwQ=;
  b=Ym9NHcVG+sYLMvhG4njj0JAdyFfxvLORECN82/nbYWJEMsNtW8qW6M+g
   58eiiv/aUNwD6K339aPD3bjllp8YzKqM6Mh1xlTnmWGSzxB/O9llUrnji
   dm+HBNRhGvfs4m6tf96wPlpgKX164g+3NZXKWXpb4IXcpWxJmikoDK+Cw
   ea31a7BCRNApFE2Y5f3ItL33NrNh8joaHhe/RZ5bif2JKI0YULIqqo6Pe
   CO7bbbsc3CLznHYA5TqEtF10jqyjEYDWNTA0N4dxv59/osgF8Q/sGcLDX
   2k3Ij3Orj0iWmrTbY4OB3RXHKY4vW+I95lI1Yq2/JYfT09hYk59azfJbs
   g==;
X-CSE-ConnectionGUID: 4tEIqMNrSP+/zCnsWYVQ1w==
X-CSE-MsgGUID: dxBqivnJSvOMMJcpju9m4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42319265"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="42319265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:29:09 -0800
X-CSE-ConnectionGUID: 9gsdFD5ZRQCDlaE3WXTVKg==
X-CSE-MsgGUID: 4KgA/ZCKQTiAe7a+HM9vJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="84999169"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:29:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9LId-0000000CYS2-0AgQ;
	Fri, 08 Nov 2024 11:29:03 +0200
Date: Fri, 8 Nov 2024 11:29:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/1] x86/cpu: Make sure flag_is_changeable_p() is
 always being used
Message-ID: <Zy3Z3kYOOV3PzG8M@smile.fi.intel.com>
References: <20240910084356.1518209-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910084356.1518209-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 10, 2024 at 11:42:42AM +0300, Andy Shevchenko wrote:
> When flag_is_changeable_p() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
>   351 | static inline int flag_is_changeable_p(u32 flag)
>       |                   ^~~~~~~~~~~~~~~~~~~~
> 
> Fix this by moving core around to make sure flag_is_changeable_p() is
> always being used.
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").

Any comments on this? Can it be applied?

-- 
With Best Regards,
Andy Shevchenko




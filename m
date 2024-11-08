Return-Path: <linux-kernel+bounces-401898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1AE9C20CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1302B1F21700
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09FA21A706;
	Fri,  8 Nov 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3ULFLME"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB91E7C26
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080485; cv=none; b=vCQhS6SviQigAyy7HJEalZ0WucCndrHEUh/hCIHHb5HIqh7hS1lxfI5C/g21mRTQklEg67XCmmDiyJeW+z332wSszus4aMP38l3TVdpQF5h+HM0B3TVY9GJPcPOWtxoYOqfWf6WQ9ezmFzF84cC625+v0oMVK8d3qMbcRYkkF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080485; c=relaxed/simple;
	bh=GRg86Iaef91WkJ0kybWunj6c0WPrPzKuN5k/WFprupo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWAoVkJt9CZKJqTSiWvaji66KnRzw3qrZfA+CZr/ze6KMs32MBQ/+zKBHLgEZVxcjx33kdqnSizOsi98MGeI7PEQiK0hYBdyoBgnNk6nVTKeEhRBQUq3Ud0LgM/u5UiYiOp+HIS09zWSs6ropfdlojxRmn353xENT5slaTh6hAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3ULFLME; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731080484; x=1762616484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GRg86Iaef91WkJ0kybWunj6c0WPrPzKuN5k/WFprupo=;
  b=V3ULFLME6+yRjyrPvrYqKkT7KUS155dCE/vGsMESIc5Exd5ecJxgr8nG
   1+g9Yy0fNU3pBUxN4D2Undhhog7GADM3RQv53SPROF73G4eQrWmATjbut
   jK3PZQQLNcZxwiI4u7AIgXPV6uROuObibKVod5ifty/zqK4YvVryrSzFV
   Xi4NSZfKvBN+UAiI3ii0SsF5dfs3DNi+sekBB/RA7t1mWFwc0k4yjV5LM
   tK9O2XAPmsrtwzDd0oET7rGHM5eOaThRqOL6j+GmaUnHMR0Hg2d0suQ9p
   MLfizyUClnP3A89t6TMnF7tRZB0d7VrjBow2ux+XEDCYsJ0uJrjusqxCO
   A==;
X-CSE-ConnectionGUID: YQq0eB1bRjOzK71vF+Ldxg==
X-CSE-MsgGUID: gwwLnyB/RM+dx3kIIPPYpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="31196303"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="31196303"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:41:23 -0800
X-CSE-ConnectionGUID: OqrJGXnsRN+X2rJ3BoGNdA==
X-CSE-MsgGUID: SioWeqffS/+gVljleFESbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="85762889"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:41:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9R6r-0000000Cf8Z-0FPz;
	Fri, 08 Nov 2024 17:41:17 +0200
Date: Fri, 8 Nov 2024 17:41:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v5 1/1] x86/cpu: Make sure flag_is_changeable_p() is
 always being used
Message-ID: <Zy4xHC3MCtAqlSxy@smile.fi.intel.com>
References: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com>
 <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 08, 2024 at 04:35:17PM +0100, H. Peter Anvin wrote:
> On November 8, 2024 4:30:10 PM GMT+01:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> >See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> >inline functions for W=1 build").

^^^ (1)

> Looks good to me:
> 
> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Thank you!

> But another question: why the hell does clang complain about an unused static inline function?!

Does (1) shed a bit of light to this?

-- 
With Best Regards,
Andy Shevchenko




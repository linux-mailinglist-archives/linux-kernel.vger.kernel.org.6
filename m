Return-Path: <linux-kernel+bounces-311070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165B968485
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE11F1C2122C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC817D377;
	Mon,  2 Sep 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrvWrLVI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA98140E3C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272436; cv=none; b=ubxfQmqn7cK3nA5/zlQcQ6rYIQMpJzvBYhcBs+zXEP6mNtxjvp8u/3KeHBcC5XPgonmkdYPvoJS4ggMJhbbbwKj7E589nIM5PW3R+vumgUx59z9y4rOg231FyF2df5/NOUPaCgKhj3Av6kE/SgJlUqqLw0I2UkzGOlgWft9ob3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272436; c=relaxed/simple;
	bh=vAyw3DGRUW2gmpJRcyy957TXVSU43KBF/YFLb11XwAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6e+mNGNy67RZhZJc9KEMFJ9C+oJnMIFHo3nE4b/w71k92l4VkgjpNuCtVEke/nvdY7u1M00x5aA4xe3Oyx6eT7JgSIV9/nsnHTaUdRw33b9Ofbnzc0wDtsEjBB89ETqhr6ddaLB7PUVI3wZ2pzd7Bo69DokcaPx0/J30WCy8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrvWrLVI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272435; x=1756808435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vAyw3DGRUW2gmpJRcyy957TXVSU43KBF/YFLb11XwAs=;
  b=GrvWrLVIX7ELath3BNnFn+nMSNlWbXHgljFEo89cOA5LUjqo4TDqdzF8
   C06sXPRpIlKcKXQMNCn5d7WPslpT4JRkJP9XhWPtPNB8axzWY63wV77nN
   FMvIpbRZ0DoqR+w58FmP2kfLIh8MVFDgxsK9hu/e7qWlGTYrHRCf7J8TE
   Hn8M4/vuUSNG0WLWhfRwQLCl760If/ohBQeOX04z4AJQ1dlx0UXjUDcNR
   GBxExfnUT96sKCDF1AX64ChNq6QCiddBs8DQ+g3nBnTm/NNXXc9LfpNs6
   3clQkC6IKiiCNHNX4oKUbxfXoZkCCnOyYry1GYC1m77qwaohU/VKGmW1j
   w==;
X-CSE-ConnectionGUID: nvqnhHMwRkKHQEboxVmo7Q==
X-CSE-MsgGUID: W0fq24KsR7+KQ17FLmLeeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23360149"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23360149"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:20:34 -0700
X-CSE-ConnectionGUID: JKq8O8QDSIm7GjIdEJwMZQ==
X-CSE-MsgGUID: /q6j8+V8QBKhxdhbT6nl8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64923875"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:20:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl4Ae-00000004Jho-2Owa;
	Mon, 02 Sep 2024 13:20:28 +0300
Date: Mon, 2 Sep 2024 13:20:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
Message-ID: <ZtWRbMAMUxZyq5xz@smile.fi.intel.com>
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
 <87cylrwahb.fsf@intel.com>
 <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
 <ZtC5oXSzUuuIgLiQ@smile.fi.intel.com>
 <20240829182255.GA1468662@thelio-3990X>
 <87a5gvw4y9.fsf@intel.com>
 <87frqiv4s2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frqiv4s2.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 11:27:57AM +0300, Jani Nikula wrote:
> On Thu, 29 Aug 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > The TL;DR is,
> >
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> >
> > on the series.
> 
> Both pushed to drm-intel-next, thanks for the patches and discussion.
> 
> I amended the commit message about clang, config options and commit
> 6863f5643dd7 ("kbuild: allow Clang to find unused static inline
> functions for W=1 build") while pushing.

It all makes sense. Thank you!

-- 
With Best Regards,
Andy Shevchenko




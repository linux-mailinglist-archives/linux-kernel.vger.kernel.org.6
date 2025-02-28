Return-Path: <linux-kernel+bounces-538479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DCA49932
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A13E1899292
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F026AABF;
	Fri, 28 Feb 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb4WxOI+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9326AAAB;
	Fri, 28 Feb 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745621; cv=none; b=hcSzHfeQ4MG7Pgym/zbJ24bmUlx1T1DVxOiWWuA1u2WzX+LiEGJV5nNwwubwP2gIZuu010MIco/Su2aCRfK5f7dGtp8Zlt3jjlYZZi3kyOpYcJwlu6TQqnVvK6/Dza8qQ3p/pxWYZPVZICs5LhujejP3scE0oSz9qhkF4tT941k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745621; c=relaxed/simple;
	bh=XTJ5YcY4zwZRIsaVC73ZiUNIWKHOD1EZR96gfev93xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRdTII3bVnDysd0m17aIZO6zsA5LtJlw8BHRlhzpk/jcB7g4YRsW7c412U0oQ4XarX4YsBjPUdhyIq1pjEhRVMHxSsAVehBz2aVaTFn/OWs4DnOhCxvDhi8vFmPARQpplcSWsPwZYgaFTaQJdy9MOqvlNOuJ4GpPlbJ3Xr8lQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb4WxOI+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740745619; x=1772281619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTJ5YcY4zwZRIsaVC73ZiUNIWKHOD1EZR96gfev93xY=;
  b=fb4WxOI+gnQ3DOypvu3U77fve9hhHO3m/Z63u4eB9I08TaJkAcn+wPcO
   Fv1zkUOABxk1wrl0BOBEN/aSSiMmKg2PSzWTk751nbr+rZDnSuBnwT0YT
   /OWv3R+NefBRCxmn9kQbKKvopK6JIVd4szVxCsxkdvdGyXeox+wPy4Cbs
   pSef2VdQJE/bPy9mkbbcQTwuR827DNcsZyNuyKum4/x3mYZ/z9prflyjo
   tGtHfuaIJEEinOOQLFGUt2s4BsbxqJeulJ7uIfNjLvUZTyk509hIqEdw2
   +APrze7MMGWnSkxfICJg4esYonKGkARlaaiS7PgHhveaRLH8XWqOGoJq6
   A==;
X-CSE-ConnectionGUID: BOEXlkP2TAy06wXjTIPicQ==
X-CSE-MsgGUID: CRJLEOkLTjGVORqjrbuzEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41923250"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41923250"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:26:58 -0800
X-CSE-ConnectionGUID: 9xS020aiSyGbIWM9zSPWCw==
X-CSE-MsgGUID: X4pxYDX/TLi+1cgb9ccxow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118245544"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:26:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzS5-0000000FwX6-1aq9;
	Fri, 28 Feb 2025 14:26:49 +0200
Date: Fri, 28 Feb 2025 14:26:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] Check Rust signatures at compile time
Message-ID: <Z8GriWN4C-e3583T@smile.fi.intel.com>
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-export-macro-v1-0-948775fc37aa@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 05:01:58PM +0000, Alice Ryhl wrote:

This is unfortunate. What does this mean?
Can you, please, provide a meaningful cover letter?

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

-- 
With Best Regards,
Andy Shevchenko




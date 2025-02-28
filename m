Return-Path: <linux-kernel+bounces-538528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869FA499B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D6E172D31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8F26A1DD;
	Fri, 28 Feb 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOBr6WgY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00404690;
	Fri, 28 Feb 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746769; cv=none; b=niF/+3hAuC8D+LPu7tHjwNJ8bxGGBJXuPuQc370DSRzA7AFqE7g/wdDhVcgnxRpuqpEHaPbfBQU6t07AIWQFkze47XiVJyq1kvqGPTBtGqGsle0lMf6j+vxyBI/9d2BUgWFe1jSsjKjX3U2UaXKq18xJbkjUQsx9KmRf/+xuTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746769; c=relaxed/simple;
	bh=4CzUfTOzdBr2io5qs/wvZvi9xQM74P30+0gBffCsVmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYbdzbElrZSlVCP5EmZBOJ0HW2kb3UOxDbR56wSF4RyufPrcYJZF9sEIT0JxoQOzcJTjOY9xKuU+0MNiLBSMf2pJsgOz6xU9Ak+GsWavr2VERywcacAROcwqIXW9XsKxFu+FvEOBMydphAOUI04Uk9BbSMLzZ1XYSyONLQqnYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOBr6WgY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740746764; x=1772282764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4CzUfTOzdBr2io5qs/wvZvi9xQM74P30+0gBffCsVmo=;
  b=QOBr6WgYgtv/q5fHT0r34AN/l0DEoZvRtGQct9B/38g9/AMAFoXjOfSi
   1RlHsfaLwLru89y9iEpOEkZ2YZ0zQspwmCkNvuWDdsBt3dlMR028cGgVT
   fLCHmpf00FvvnDS6Y5wkLhqmengD+uqHzQKSop9RRg3ba3cZe4NYAV6jm
   /Jc6ccg3XvOjrSK3NZCEJzLPERQVF4ASUt/sd/W9T0nqAM++5dgjTq/rH
   h6BKigEpuFV5J3ss2uhIpfQN6JK0M8PwwbIop/yta2AVbVvabH1i+IluL
   2LESvPRSXk2vYOsBNkTAO3sRgdUJ4D7LYWJYE9WiWNU3Sm7XPEB3J6XSJ
   Q==;
X-CSE-ConnectionGUID: rF/kgQ6bSgqyTHHUhk4rGg==
X-CSE-MsgGUID: P3KH+ogiR/efCKlDjD3kfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52317301"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="52317301"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:46:02 -0800
X-CSE-ConnectionGUID: ajGdwdEZQOOrIPjuHjZ3PA==
X-CSE-MsgGUID: 5W+i9JMQQYam4vO3lZCOcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117364013"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:45:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzkW-0000000Fwmo-1iGO;
	Fri, 28 Feb 2025 14:45:52 +0200
Date: Fri, 28 Feb 2025 14:45:52 +0200
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
Subject: Re: [PATCH v2 0/5] Check Rust signatures at compile time
Message-ID: <Z8GwAPDbxpf-WQOM@smile.fi.intel.com>
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 12:39:29PM +0000, Alice Ryhl wrote:
> Rust has two different tools for generating function declarations to
> call across the FFI boundary:
> 
> * bindgen. Generates Rust declarations from a C header.
> * cbindgen. Generates C headers from Rust declarations.
> 
> In the kernel, we only use bindgen. This is because cbindgen assumes a
> cargo-based buildsystem, so it is not compatible with the kernel's build
> system. This means that when C code calls a Rust function by name, its
> signature must be duplicated in both Rust code and a C header, and the
> signature needs to be kept in sync manually.
> 
> To eliminate this manual checking, introduce a new macro that verifies
> at compile time that the two function declarations use the same
> signature. The idea is to run the C declaration through bindgen, and
> then have rustc verify that the function pointers have the same type.
> 
> The main commit of this series is "rust: add #[export] macro". Please
> see its commit message for more details.

Thanks for the cover letter, makes much more sense now!

-- 
With Best Regards,
Andy Shevchenko




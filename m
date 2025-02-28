Return-Path: <linux-kernel+bounces-538834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE361A49D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4734B3A88DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C29187859;
	Fri, 28 Feb 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwIxjS0o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229070814;
	Fri, 28 Feb 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757029; cv=none; b=gfN0Bej0EaxokF9JjGPpoc9EjPrKhPkneJyN76Sb9n+K+j8qZ1CvYHhnBEeS0b82+OHxNpDuFflS08OocTZZPuBBsybc4Bs+x87awUkHFDrjRwJkel+aBYXLbmWLmx2RKWU7+dDxtwyQrwKLx2cODrceUffRKhXvAUIsu/SY8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757029; c=relaxed/simple;
	bh=pYvYZydkvZyDUBQoc2Wqc7vvt3FYWdqgKN6w6ZhbzpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdojTDMrdfCyW/1BSsz6E9eTF9KpHTv4H6n5m3jqk8yfGYmegvJyvpfkCMrD/00eobzBuvtKq8XqgDdEmPIEtRTt3LSva6T5Q1rRr1MlFzreUYXxyLsKbS59GD8KX0tKGQ8sIbfFKoUm3b4qxML1tMlWGRlscXgUDZRJ6vuLmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwIxjS0o; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740757028; x=1772293028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pYvYZydkvZyDUBQoc2Wqc7vvt3FYWdqgKN6w6ZhbzpE=;
  b=nwIxjS0ouzWWWMjCl3rhn0XQs+5YxDWRFaUHQNagg0/5WDc0je8Cp5Qq
   8ChsvNR3Og3NooehCKGi55/9XTzWqOPUhHF6bDpDr5/GEkdCc2zLv99yZ
   st7YfDN8p8FIPCzkyOc1KcbJR27OW64xLQlvb2KBSrCT+8zFUG+xo5tYx
   R47vZ6gJVz6V/bz4Oyy/foV2xyNEG2bZz7MVPO2GVy7sTNNDWQ9E5c4xJ
   UY0KZRFbEnuafUypFNjTsatKcn/mVfWZRW771g4Ec29ztSuUhHxxawWoy
   +1SSiLzrFz1VHQkX7pC6ycumdFoQruBHFCOmbJfSaWEl64kUXbP9cgXTL
   w==;
X-CSE-ConnectionGUID: +otnYLn1SsWa6YNKfkvOxg==
X-CSE-MsgGUID: fqwU0S8uRimj7dFP53ifDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="64151155"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="64151155"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 07:37:07 -0800
X-CSE-ConnectionGUID: eDyQtdH7RxmRehcf50MUtw==
X-CSE-MsgGUID: JLpfhLruRj+5n/rUVyD6yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122375715"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 07:37:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1to2Q5-0000000Fz6n-43o0;
	Fri, 28 Feb 2025 17:36:57 +0200
Date: Fri, 28 Feb 2025 17:36:57 +0200
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
Subject: Re: [PATCH v2 4/5] print: use new #[export] macro for
 rust_fmt_argument
Message-ID: <Z8HYGTewVatzRJ34@smile.fi.intel.com>
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-4-569cc7e8926c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-export-macro-v2-4-569cc7e8926c@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 12:39:33PM +0000, Alice Ryhl wrote:
> This moves the rust_fmt_argument function over to use the new #[export]
> macro, which will verify at compile-time that the function signature
> matches what is in the header file.

...

> I'm not sure which header file to put this in. Any advice?

I believe you found the right place.

-- 
With Best Regards,
Andy Shevchenko




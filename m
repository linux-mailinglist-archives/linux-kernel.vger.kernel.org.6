Return-Path: <linux-kernel+bounces-541302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E86A4BB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31704171207
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDACC1F12F6;
	Mon,  3 Mar 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bie2sbwR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A185C5E;
	Mon,  3 Mar 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995177; cv=none; b=C8Pspc6zrAhVxV2FtY0oH4aNr2KWZxwf5RsCwnL1+ki1MUdZWiOwVxlHigw4g6J91dKRJiLwioUo06aB8Y5MtkfoaUIP0ettCdBb4ky8TuutYpWJQX5+S5M/pTqNbKdf/OSZdXsf4S0aY6WRCHLjWMH19KpkiEOzTdRBKpBHhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995177; c=relaxed/simple;
	bh=sjUNmsBoxg1lTuhhmLZRfysPKGMMkrAdGhjiE+alWPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnjX1Nsbw4Zs01+Y8qeGAGyRMvK/MC+wbq+U6ENETqqVC/pZKitfO4VxApwjsm8aWe49+QhiTOX0iGcJU0OSugz77I7Mz8/vn9oB70wUEq5Fq9rt/rVYujcrKLG8Ug3tI04RnZ2SmcO+RvGaIw60P/Y9AlnhbSnqeQ+U/puBCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bie2sbwR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740995176; x=1772531176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sjUNmsBoxg1lTuhhmLZRfysPKGMMkrAdGhjiE+alWPA=;
  b=bie2sbwRuK5VTMXgwP3eFw3HR+qpjmPpvvRqRMvsgujklXZIxpqVS2JK
   5s8rTX2CgpNNwdhDcy9NEza2u1LRhPp7Nz9Q5wqtsJdjeTxf4W0UL/YuL
   NJui9F+RDSodrGAvo/q9q8UWLMNyyX4Enkx0xPh3CnORfV+RmLn87lfbZ
   12FgKYq11HxYx9tvLY7Q6CHbTijy0xIN64lE6Q6qfUZMLJgL47CLS8vKk
   haVHZX35WOMTMr/d3oU98mhlItqZzl9j/WOCDZo5/lBH0VxZUxqTvKjc8
   Mt8tfgN3ynw3b+5YvY8wjnIFnO//41s9jCRFJbjbDg0P9MBDvvbwR61GL
   Q==;
X-CSE-ConnectionGUID: TzI1hDBpS6eAxT2fWoxVlQ==
X-CSE-MsgGUID: PU6If1rATcyflj0xjpIP9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41774518"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41774518"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 01:46:15 -0800
X-CSE-ConnectionGUID: RWWDyvIoQLmvqfjgWcNLpA==
X-CSE-MsgGUID: 15D++kOTS7Sq6gqbKzvO4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118435744"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 01:46:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp2NB-0000000GlrM-3yzh;
	Mon, 03 Mar 2025 11:46:05 +0200
Date: Mon, 3 Mar 2025 11:46:05 +0200
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
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 4/5] print: use new #[export] macro for
 rust_fmt_argument
Message-ID: <Z8V6XafrTyrB4z8D@smile.fi.intel.com>
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
 <20250303-export-macro-v3-4-41fbad85a27f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-export-macro-v3-4-41fbad85a27f@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 08:45:15AM +0000, Alice Ryhl wrote:
> This moves the rust_fmt_argument function over to use the new #[export]
> macro, which will verify at compile-time that the function signature
> matches what is in the header file.

...

>  extern bool no_hash_pointers;
>  int no_hash_pointers_enable(char *str);
>  
> +/* Used for Rust formatting ('%pA'). */

In case you need a new version, please drop a period at the end as this is the
style used in the sprintf.h already.

> +char *rust_fmt_argument(char *buf, char *end, const void *ptr);

-- 
With Best Regards,
Andy Shevchenko




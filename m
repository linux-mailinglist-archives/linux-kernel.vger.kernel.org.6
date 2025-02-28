Return-Path: <linux-kernel+bounces-538481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD6A49937
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCD6172D31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C426B086;
	Fri, 28 Feb 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDqN4Kh8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01D26A1CD;
	Fri, 28 Feb 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745657; cv=none; b=SbAxwwP/3OYmPfcxsU/cSieQfQEFm8fT+vzlkG+17AY1A2qXsQVwUjPUIKaAwo3pkn25Z5eL4dtrNvrOhpsSWjrojBauggN4MhBNn3nIYJpyTb9uy9HpjRTojayW2B6f+gcNFdQ5rnvyF19SBcTtmsjxTYjf1oA848ioVCrQsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745657; c=relaxed/simple;
	bh=D7zHHQU8x/t+aPG7jNWtRdAX0S65Ib4QP2cl0EV7yWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLJrzxYWW3C1SSciC6prq1v1ykIQ81IF5Rf973OxJ/usRMtz186cKZScHeBJw+GIMEvwd1fsBGZDRQlfmMwAOAlTTd6XZLZ4RaXoAW4sYHdnxpSnVN+kPHf2Cgy4tD311iR+zkCQK+n3Yx+Q3bsJIIbYlDeKLljLfK3oMJLxPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDqN4Kh8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740745656; x=1772281656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D7zHHQU8x/t+aPG7jNWtRdAX0S65Ib4QP2cl0EV7yWk=;
  b=SDqN4Kh8jZJ2qcQoXhscX6mFag+y5WKgvv+16+bDrAeiOn81M0Yefq3C
   fKXMC4iMidqDu0pRHelPGt7v8AG32v4bUc998DX9C6S+K74+VbLkASoSE
   LBUvSIOKoO65cn0vFKoxGolaX2hH2jCZP1JShrQlhr2qlPHa4+/0F4B4E
   KRv2IBMyzMbwcRbAZotck+xGl/DQzOXCfrXh7xepf//NLMJFf9b5KPLEy
   pbK7yRk+wLLpwudVTFNs73i1EmUIUVKLuW8mSpw6Nifs5OWLfGhmaK/eb
   y7Ltf24djhoRqDe6Y41DbCVMr+PG/jfq66VQDtkcRe4gXTESfI7KRwPjH
   Q==;
X-CSE-ConnectionGUID: OM/yv+MBTxG+CqRa4ZUcpw==
X-CSE-MsgGUID: 6x4Sp0V+QF6ql4923I9/zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53082887"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53082887"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:27:35 -0800
X-CSE-ConnectionGUID: 5e0OC6KWQ4WRvAvDygPQkw==
X-CSE-MsgGUID: g4+/gMxaQvq+26wuw/LZfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122273689"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:27:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzSf-0000000FwXh-37W4;
	Fri, 28 Feb 2025 14:27:25 +0200
Date: Fri, 28 Feb 2025 14:27:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Trevor Gross <tmgross@umich.edu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] Check Rust signatures at compile time
Message-ID: <Z8Grrb80WOf99qoX@smile.fi.intel.com>
References: <UXTosjUFv_CKOV-K4oqNGBhMEv64tds9NgXWhHEYdCHuKM2qSPFrpBnTqhFGkcbv5_KXYERykIXhn-sYnEeuUg==@protonmail.internalid>
 <20250227-export-macro-v1-0-948775fc37aa@google.com>
 <877c5apmdi.fsf@kernel.org>
 <CAH5fLgiNs-VKEQduL16eymSPnqA0_6aR8WDRYm68SE8FXGDHRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiNs-VKEQduL16eymSPnqA0_6aR8WDRYm68SE8FXGDHRw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 09:46:32AM +0100, Alice Ryhl wrote:
> On Fri, Feb 28, 2025 at 8:19 AM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >
> > "Alice Ryhl" <aliceryhl@google.com> writes:
> >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >
> > What is going on with the cover letter of this one?
> 
> It's empty.

So, it means nothing to review, sorry.

-- 
With Best Regards,
Andy Shevchenko




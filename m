Return-Path: <linux-kernel+bounces-558339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F0A5E48B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0B43A4CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31626257430;
	Wed, 12 Mar 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APtsJFhf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CA1CA9C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808171; cv=none; b=VkLNMZcBkkJYZ9LuwoBDhb2Zqp92VShG5XJ3IC0lci6wOfmRwpRkCVGBO2VOxjpL9jpekLMVtM1DSxYhR3maIvskDuzfGtGPoHFZ/rDYk93FIjJLYgydGU2p6J+4kLO6GSDTwp5uvPMhLwLH3YkH7Ibt6FxC3ONz0wVcQnJ084E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808171; c=relaxed/simple;
	bh=Kn/3/mhY/0nAp1jqnqOT1py7DRm7JEXgYRey0DGPiWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os2wUIFen7hEIxAshhaSUBzEFeb6rCZLFqVizuGxDtXjoLQZainyZzfuKA3voTCcXnbO7JRTlHIfUuoYCugOpGgoUHa036LM6k352wBF1CJkPfQOkVQK1X/ZG6Y8NZqRReY/o5PhRsH/HOl7gf/pOEhQ1b1/PQl6hjjDRe7iVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APtsJFhf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741808170; x=1773344170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kn/3/mhY/0nAp1jqnqOT1py7DRm7JEXgYRey0DGPiWA=;
  b=APtsJFhfPD9y36CXysFhpmqCfFk2SX0CG6xGUcrcvBRrHsTkkI7zxRBq
   TGK+m4YMMXPzhrvRGlHBKCDccn9PITDaeHfQAFOjHOmRy+Sj5U+ycnp9P
   SKKYW5N9wxadOqGqQ8SZL3lQGDZOkKJHusaDbl4Yh7qkhHW04CV4X42Sq
   rBZ0ywlZWODQhV+lbfRBp8F+1P/XrFjIcNcmgBdOePElwcSQWA8qJPBKs
   gUMNbz+lpwOR50tpNkrluFBrgoglJ+/94UX5lvGizQRQJIPptRyuuDnG7
   LfI9d1u6Fh5//CHpYvZUqItb0tyVVMm0I6Gimb2KcXydoDaQeLZbrZKEO
   w==;
X-CSE-ConnectionGUID: LWuPFvH5QNWRcO9ODPBy/A==
X-CSE-MsgGUID: fKo1he1sSICOLVrZGBRKjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43106904"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43106904"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:36:09 -0700
X-CSE-ConnectionGUID: 4BB7CRVwRt+mab/GVZiqBQ==
X-CSE-MsgGUID: Si3R3YgrRpeab+E0Si8law==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120690839"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:36:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsRs4-00000001xyI-18TV;
	Wed, 12 Mar 2025 21:36:04 +0200
Date: Wed, 12 Mar 2025 21:36:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, nnac123@linux.ibm.com,
	horms@kernel.org
Subject: Re: [PATCH next 2/8] test_hexdump: Create test output data from the
 binary input data buffer
Message-ID: <Z9HiJM8VrXcglC5H@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
 <20250308093452.3742-3-david.laight.linux@gmail.com>
 <Z86jTvOdq0fgvqRO@smile.fi.intel.com>
 <20250312192811.7632a936@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312192811.7632a936@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 12, 2025 at 07:28:11PM +0000, David Laight wrote:
> On Mon, 10 Mar 2025 10:31:10 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Mar 08, 2025 at 09:34:46AM +0000, David Laight wrote:
> > > Using the same data that is passed to hex_dump_to_buffer() lets
> > > the tests be expanded to test different input data bytes.  
> > 
> > Do we really need to kill the static test cases?
> > Are they anyhow harmful?
> 
> I was asked to add some extra tests for other byte values.

Right and thanks for doing that!

> The static result buffers just get in the way.
> 
> They are also not necessary since the tests are comparing the output
> of two (hopefully) different implementations and checking they are
> the same.

Not necessary doesn't mean harmful or working wrong. I would leave them as is
and just add a dynamic test cases on top. Static data is kinda randomised, but
at the same time it's always the same through the test runs. IIRC your dynamic
case generates the expected output and hence uses the code that also needs to
be tested strictly speaking.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-573845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A698A6DD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201941884E95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D325F7B2;
	Mon, 24 Mar 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wf4MTUKn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870725E83E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826788; cv=none; b=betZFy1rvl5UlLYhBhgx3HDjZQOCc7YLYt4mg9GYPSY/lC7JDQjSErtOAysSMA1xosr1ervw/lbQO6liWkrOY0LDy/qYZ06+rHm2c4ZmEw9g16p0/Y7ywrHMu/d7QgLFxa89RB4MJvncdee9NLK36/Yd0VHChhBzeZzbF71c+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826788; c=relaxed/simple;
	bh=VH2tuyab+QykS7q6ZLU70B5b2xpyt97ECrYqMIdjZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qip6j5WhznCWBoV80hrBnpOSjc2MiECkkJW9olwChCnXq8If5NSTfCCo6nLZx4vIvkvHPsAolUnM0BoHcgueBxnLuP2sWGEjTLjsF3cOEc9xWkGuvcd50UV7hAeB3vf4p7v3tYKFNUu9He/6Ea6KchUwt7VXRaayk4+IkSrtCdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wf4MTUKn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742826786; x=1774362786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VH2tuyab+QykS7q6ZLU70B5b2xpyt97ECrYqMIdjZrY=;
  b=Wf4MTUKnvP8UpHWxgCcO6mAVQETKhUqWHHhMsdeK3MGndYSXdjZNF+v5
   u1jo3oBuJz95A2zo8USzlOOrCB3CUul6oVBEdF1w+SU1fBb/Ej5c/r0g6
   Hpp6+1nRfoI9jSBWhEQDtVDVideZ3S1MAPACoWax+my/7CGVpjBT8Gbql
   /m5C9O1lpyipdX02KZUYgbXtsl7soux4Gej5ltavpzyrJzW5qC4e/jSTE
   70fTc0/Fz1L+0NtyDpz7a3Kbgt9ctNfSD4XFwG95qX+WLYfFmFjc0JAcN
   YFMfJrg3u11Mn9EbNVMs4iMKPe4q6sVMdtor35TIOKl/NCNV/NNgw2wa5
   g==;
X-CSE-ConnectionGUID: kq6insjYSxOqqpOZ1bRM6A==
X-CSE-MsgGUID: 2TRbUeRJTGWnjYX9WOoPVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61556083"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="61556083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:33:04 -0700
X-CSE-ConnectionGUID: Nc+1BQxqQY6caLjtA886Qg==
X-CSE-MsgGUID: pzpRK6j1RkGUBCQeVKiV6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="147262484"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:32:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twirD-00000005T9T-0HyN;
	Mon, 24 Mar 2025 16:32:51 +0200
Date: Mon, 24 Mar 2025 16:32:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v7 2/5] bits: introduce fixed-type BIT_U*()
Message-ID: <Z-FtEr31u0jmeSRX@smile.fi.intel.com>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
 <20250322-fixed-type-genmasks-v7-2-da380ff1c5b9@wanadoo.fr>
 <Z-FhHRWtaYgTbILa@smile.fi.intel.com>
 <b7718c92-3934-4ce7-b9a1-0d8ac03dadc3@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7718c92-3934-4ce7-b9a1-0d8ac03dadc3@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 11:16:30PM +0900, Vincent Mailhol wrote:
> On 24/03/2025 at 22:41, Andy Shevchenko wrote:
> > On Sat, Mar 22, 2025 at 06:23:13PM +0900, Vincent Mailhol via B4 Relay wrote:


...

> >> +/*
> >> + * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
> >> + * following examples generate compiler warnings due to shift-count-overflow:
> > 
> > "...due to -Wshift-count-overflow:" ?
> > 
> > Same idea — if you need a new version, since it's just a nit-pick.
> 
> If you want. I staged this change locally, so if there is a v8, it will
> be addressed. I applied the same to the previous patch which also
> mentioned shift-count-overflow without the -W prefix.
> 
> But honestly, I am not convinced of the added value. This is from Lucas
> original patch one year ago, and no one was bothered by this. IMHO, when
> writing:
> 
>   (...) generate compiler warnings due to shift-count-overflow:
> 
> I do not see where the ambiguity is. The sentence clearly say that this
> is a compiler warning, so with or without the -W prefix, the sentence is
> equally understandable.

As I marked, it's a nit-pick, but from my point of view the added value
is immediate: The reader can be sure that we are talking about a compiler
warning and not something else (C standard? some special term?). So it adds
more context and makes it clearer.

-- 
With Best Regards,
Andy Shevchenko




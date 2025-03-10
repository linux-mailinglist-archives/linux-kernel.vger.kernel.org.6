Return-Path: <linux-kernel+bounces-554031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D80AA591FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4505A18907A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAC22A4C9;
	Mon, 10 Mar 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1R9DLCt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6A226551
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604002; cv=none; b=pgHcmYoZ7ga8MX5h7l7oy0m7ihGPCYVO0rKKbsm/tmofya7/OOqSp909N/z4oCqFqihqODoOso5EHTBCHZt4eg1l94DhjG22B2GRxTPrSrh3+6rOT/1v3gCoyOhkABh3l/z3YeWRdb6k5YRPMymhbY8NPqgdp52RBHl4vJWTzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604002; c=relaxed/simple;
	bh=5kkyk5XvVdYv3VMDeqdfonkilqYlRm6ZU2gfaCxZxXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQA1RZs2nnKQH9CfCY9993SUvQnG5w5Hi4/3b0bAQL4SR9G8x5w9m9G1z4OgDQ0VZp+pbiiZRWL6fKr5XldRgNHYrMvd5BSoVL6/pBr928EdvMZuinOtT3+f0YEg4zmvG92Nm0nSa5sA3fbXXaDHbhd9dCZx8UmVVz73N+IiJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1R9DLCt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741604001; x=1773140001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5kkyk5XvVdYv3VMDeqdfonkilqYlRm6ZU2gfaCxZxXw=;
  b=h1R9DLCttcMFUGKhmPBV4X3R+Z5RkSCx4arYnXnrmX3F8f1/zlX/xr+Q
   yXmZ1ivlWKHX+/JTWusq3nvlgQVKGU1t9RjBaLY7C6vbdzfvrLhJB191K
   cYX2/zzQybsWwJxIafSFrUcrwjlkSkUmTz8NanG3ZAN6VpEliXUT1Nirj
   rTSkhTRfeRKzEYRRIp0pXeRnQMn55gp3ffwM7GZbGvtweJrG3Oo5O7sRS
   l8BbKxmFl2DJP/7cbcTDXCRd0FptsC0pFUixtDulG7LM+Dw7P8Ft+mClE
   Nr8QCYOT2tdDzek44IYkViWNYAOsIbaNHjAPqj2bNyeXbN2BCE8IjCED5
   A==;
X-CSE-ConnectionGUID: h3oAaNvIQBCEkZjrP3T5QA==
X-CSE-MsgGUID: PNKp0OgwSmej8+tf4rEiHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="52801990"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="52801990"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 03:53:20 -0700
X-CSE-ConnectionGUID: NukMJJOIQNSiuxPK26madQ==
X-CSE-MsgGUID: IG+m4IAyR8+C69qj8nU4tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="120857954"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 03:53:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tral2-00000001Dxh-26KM;
	Mon, 10 Mar 2025 12:53:16 +0200
Date: Mon, 10 Mar 2025 12:53:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move
 hwidth and bwidth to struct hd44780_common"
Message-ID: <Z87EnICHTDHbyBoO@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
 <Z8slexKyo7VFkSKW@smile.fi.intel.com>
 <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
 <Z8tBnq-j7gKrzlpk@smile.fi.intel.com>
 <CAMuHMdWeFhqf-A-71pCZ+eFMh+ibGudMwiE5hPrdkfCYwVXHCA@mail.gmail.com>
 <Z86e3t8YVoaGsRlF@smile.fi.intel.com>
 <CAMuHMdVA5pAWKXjYDZrLczgzmhvHVOAdpK3kBQC8UGY_TzEW3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVA5pAWKXjYDZrLczgzmhvHVOAdpK3kBQC8UGY_TzEW3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 10, 2025 at 10:39:49AM +0100, Geert Uytterhoeven wrote:
> On Mon, 10 Mar 2025 at 09:12, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Mar 07, 2025 at 08:05:56PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, 7 Mar 2025 at 19:57, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Mar 07, 2025 at 07:14:02PM +0100, Geert Uytterhoeven wrote:
> > > > > On Fri, 7 Mar 2025 at 17:57, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Mar 07, 2025 at 10:03:31AM +0100, Geert Uytterhoeven wrote:
> > > > > > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
> > > > > > >
> > > > > > > s/The commit/Commit/
> > > > > >
> > > > > > Why? We know that we are talking about the very specific commit.
> > > > >
> > > > > You can have a noun with or without an article:
> > > >
> > > > This is not so simple :-), esp. if a noun is a weekday or a toponym.
> > > >
> > > > >   - "a commit": an unspecified commit,
> > > > >   - "the commit": a specific commit, specified by context.
> > > > >   - "commit 1234abcd": a specific commit, specified by what follows.
> > > > >
> > > > > > My English is not native I would appreciate a link to a material to study
> > > > > > the case you pointed out.
> > > > >
> > > > > Neither is mine, but the use of articles is similar in English and Dutch.
> > > > > (I am aware your mother tongue does not have articles ;-)
> > > > >
> > > > > I found plenty of articles explaining cases 1 and 2.
> > > > > Case 3 can be considered equivalent to "Mount Everest" in
> > > > > https://learnenglish.britishcouncil.org/grammar/a1-a2-grammar/articles-the-or-no-article
> > > >
> > > > Okay, so you actually think that the hash and the title can be considered as
> > > > "name of a place". Hmm... I don't think it applies here. It's not a place.
> > > > Moreover some places require "the" article.
> > >
> > > Only if they are a region, not if they are a country (yes, that's
> > > unrelated here).
> > >
> > > > Here https://www.butte.edu/departments/cas/tipsheets/grammar/articles.html,
> > > > for example, the sentence "The 2003 federal budget" sounds to me closer to
> > > > our case. Every year there is a federal budget, but we explicitly point out
> > > > to one and reader knows what is this. The same with the commit.
> > > >
> > > > Sorry, but I am still not convinced.
> > >
> > > In "The 2003 federal budget", both "2003" and "federal" are adjectives.
> > > In "commit 1234abcd", "1234abcd" is a name.
> > >
> > > Cfr. "King Charles".  "The King Charles" would be used only when
> > > putting a very special emphasis on "king".
> >
> > I have talked to the language teacher (okay, her native is not English),
> > and she told me that no article is for the cases of location, person, or
> > character. None of that category the commit falls into.
> >
> > So, still not convinced.
> 
> I have a hard time finding the official rule (git commits did not
> exist when English grammar was written ;-)... Examples are easier to
> find.  E.g. the first sentence on [1] does not start with an article:
> 
>    European route E40 is the longest European route.

I believe this falls to the "location" category.
Can you find something which is not related to geography?

> [1] https://en.wikipedia.org/wiki/European_route_E40

-- 
With Best Regards,
Andy Shevchenko




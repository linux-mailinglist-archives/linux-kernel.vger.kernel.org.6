Return-Path: <linux-kernel+bounces-554546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5ABA599B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611E13A9F23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D322D4D4;
	Mon, 10 Mar 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENodMEer"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7E14A098
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619764; cv=none; b=TnqPpywzpFK8Rfvrhz7GJi6RMJCJ2ur5J1NxDYBWolu0V58DcNU3CMa9ageEsCf622V8AC2PX7D0D16kups9+T41Kz9vVxlxGSZqbjdoDAA1JGjbdocsWWJxttofDDc0XYpX6QRkfCE3dP1dqeLTzSAD0YRrZI1BWFDQHIMlj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619764; c=relaxed/simple;
	bh=8Oin34g00wCaHk8FeIrARHeJ7CFihYZLzJBhDjqaX+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4nwI3gVdtIlCbH+RR+17nbOeJl3yFjf9MJcw8CCJTDW5/oWFH5NaVRoRyW0CX18j6TTSM9ILGgr0jkPSJyAARXSUZTXnnbAoRUpubeCW7MSYOkfu0a2pv0PsSoRVEd0IYlY6k4n7SRjVgMgMufXLsxemv+sVYJ1cL8o4GpKpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENodMEer; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741619763; x=1773155763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Oin34g00wCaHk8FeIrARHeJ7CFihYZLzJBhDjqaX+k=;
  b=ENodMEerr7QK9u9g7AK1S2btUT9AtISNygFnx3bjEVYLY0BwY+kWdDvJ
   O40aGl0DAXl/hll/R9cq9Q3Kg1Pg3WJRviwqlBFTEUmIkveKeJSenpoUf
   NBq6kSyyQSc306+JGS56FyyrYqyunHKdVN4Brig2E1cAYcKIK+kYrYtPU
   1P5+SIdaz/r27O3/tmnb+zT5mx+efFaS3cBSGXOuiK+CqfaOxgEF7n7Ov
   rKLHh9yKB3QiPDp38XwGLtlWieKa6Nz3JluC5Gvby3zzdLwM2LRPG6qhI
   QJjxa08zCDPYwWpIBTgwOfcvuUsr4icAB90g8F3/9/aWhhCtClHvUNPbc
   w==;
X-CSE-ConnectionGUID: PrT2fqjuSlmPU/gIN5RGqQ==
X-CSE-MsgGUID: BnjJwJ3+TjWymEZxG+UJ7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42812445"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42812445"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:16:02 -0700
X-CSE-ConnectionGUID: M3u8CCVSSZSEjbBoSINTFA==
X-CSE-MsgGUID: YgmAbBanR+GtWfWfPwyjnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125033371"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:16:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trerF-00000001Hzj-2uDT;
	Mon, 10 Mar 2025 17:15:57 +0200
Date: Mon, 10 Mar 2025 17:15:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move
 hwidth and bwidth to struct hd44780_common"
Message-ID: <Z88CLcR6ZLMl1OOv@smile.fi.intel.com>
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

Okay, seems AI may help here. It tells that grammatically article is needed,
but in technical texts (like this one) it's the usual case to drop it and
it's considered grammatically correct.

We both are right but from different angles. And yours seems the winner today
:)

I'll update the message accordingly.

> [1] https://en.wikipedia.org/wiki/European_route_E40

-- 
With Best Regards,
Andy Shevchenko




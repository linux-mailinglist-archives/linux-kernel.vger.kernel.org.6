Return-Path: <linux-kernel+bounces-553700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59EDA58DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D1E3A8634
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E1223323;
	Mon, 10 Mar 2025 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSiSIjmI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1301DA614
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594349; cv=none; b=Zv6TaBT2b43LrQQDAXY3nmBVoXaNOZXocB6LXstGxsbNumnqUuxJi+jKMQ/POzj5DsLoOvIUDpH+s9RQTSr/fXLrVaSK/62DNhni2cbQZFUe8Luq/2QAV0CsPLmywDolhTXHacIftgsF968z7VAf16eBtTgh4j3le+xWxI3OIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594349; c=relaxed/simple;
	bh=wEQHsa/gs6+ybS0aObrDCBsxBDfBEKrMUd4PCv31NiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCfpgjUJfVzDkvvA85o1xWk3cx0ihZYXcx0V+kJFXJ60nzSDyXHEA8Lvl2uA7ybbq6wreper9lonIcgrBftOF/dGwRuEN4Fs5fj9up98zSlc20C5LYHoUIigPK5fQsinvF7gvaIqz5H/0Qrl3nD3/kzbZ/U7cOOyyXnlptrOm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSiSIjmI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741594347; x=1773130347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wEQHsa/gs6+ybS0aObrDCBsxBDfBEKrMUd4PCv31NiQ=;
  b=XSiSIjmIDecFSP8KT3nOntpL++vb8CeHhbhRQ8BI68kxbK4ztoOakAqr
   Q8rhrSJacb2uIrc7wGNSBK4HjGp4PKesrYEUCVVeO3/X1CxDCj9GH5UqR
   C12+0EyZ/cjP5HOjMcWcfJ92qiCt/z1VRvpj+Fr5tNXdpQQCHQ+QvGm9B
   hux8qOqs0jsxpFXK0F7uEKYiQ/lJvSxOwjyYEytIAS3bCzbpYQACsbu55
   CuogMhwAKclmm5QlY/fYrHTFguMuzp/EI5Kw16/7OpvZNwCK4AVonueou
   yxJlMTMZg202/paXqHUBglAkCX+5cDG+ga71dc/s2zEEYNlnoG93zQpwP
   g==;
X-CSE-ConnectionGUID: QPM91RjwR9GOUZxytkEcuQ==
X-CSE-MsgGUID: xtMew4K2T6yH76QbJWn9rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="45370189"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="45370189"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:12:19 -0700
X-CSE-ConnectionGUID: fwrL8mePQfqwBk2dzsXnEw==
X-CSE-MsgGUID: dgKyEF8NR3qlvk+Y4TznYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119855264"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:12:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trYFD-00000001BgI-02Yl;
	Mon, 10 Mar 2025 10:12:15 +0200
Date: Mon, 10 Mar 2025 10:12:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move
 hwidth and bwidth to struct hd44780_common"
Message-ID: <Z86e3t8YVoaGsRlF@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
 <Z8slexKyo7VFkSKW@smile.fi.intel.com>
 <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
 <Z8tBnq-j7gKrzlpk@smile.fi.intel.com>
 <CAMuHMdWeFhqf-A-71pCZ+eFMh+ibGudMwiE5hPrdkfCYwVXHCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWeFhqf-A-71pCZ+eFMh+ibGudMwiE5hPrdkfCYwVXHCA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 08:05:56PM +0100, Geert Uytterhoeven wrote:
> On Fri, 7 Mar 2025 at 19:57, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Mar 07, 2025 at 07:14:02PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, 7 Mar 2025 at 17:57, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Mar 07, 2025 at 10:03:31AM +0100, Geert Uytterhoeven wrote:
> > > > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
> > > > >
> > > > > s/The commit/Commit/
> > > >
> > > > Why? We know that we are talking about the very specific commit.
> > >
> > > You can have a noun with or without an article:
> >
> > This is not so simple :-), esp. if a noun is a weekday or a toponym.
> >
> > >   - "a commit": an unspecified commit,
> > >   - "the commit": a specific commit, specified by context.
> > >   - "commit 1234abcd": a specific commit, specified by what follows.
> > >
> > > > My English is not native I would appreciate a link to a material to study
> > > > the case you pointed out.
> > >
> > > Neither is mine, but the use of articles is similar in English and Dutch.
> > > (I am aware your mother tongue does not have articles ;-)
> > >
> > > I found plenty of articles explaining cases 1 and 2.
> > > Case 3 can be considered equivalent to "Mount Everest" in
> > > https://learnenglish.britishcouncil.org/grammar/a1-a2-grammar/articles-the-or-no-article
> >
> > Okay, so you actually think that the hash and the title can be considered as
> > "name of a place". Hmm... I don't think it applies here. It's not a place.
> > Moreover some places require "the" article.
> 
> Only if they are a region, not if they are a country (yes, that's
> unrelated here).
> 
> > Here https://www.butte.edu/departments/cas/tipsheets/grammar/articles.html,
> > for example, the sentence "The 2003 federal budget" sounds to me closer to
> > our case. Every year there is a federal budget, but we explicitly point out
> > to one and reader knows what is this. The same with the commit.
> >
> > Sorry, but I am still not convinced.
> 
> In "The 2003 federal budget", both "2003" and "federal" are adjectives.
> In "commit 1234abcd", "1234abcd" is a name.
> 
> Cfr. "King Charles".  "The King Charles" would be used only when
> putting a very special emphasis on "king".

I have talked to the language teacher (okay, her native is not English),
and she told me that no article is for the cases of location, person, or
character. None of that category the commit falls into.

So, still not convinced.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-551790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08DEA570EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ADD179B54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D222459E5;
	Fri,  7 Mar 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqMjPrBH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93D23F26B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373861; cv=none; b=owbplNASxsZD5Z5pnL4WSUG2GAxSckacAX4zDmYMhf/kgA+kPJ3iGgQLSQHP8kEqkjYPBfv2GsFo+hKzDL23ZPJnpGVSY7y87ojjUl+xasqszbJ1PZlzsD9YHBjrWxYa/288DtT5pywrUjfC4//K8ie1Csb6ErCzihjUu9LSXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373861; c=relaxed/simple;
	bh=djlpcjtTRk0DLJVGOp35DFrJsqRg1pJ63SR+Ubdm3H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAXs20Qrg5hp8hPOfmSb9YSIfkebMioNBQtmy+1/XfteM4Q6yCtt/f0VHS13mLItovvSHpX2XxfY2X0g80Lqf6mdvRvaWFhlHbM3UWT233e7tnIUv8X2B8kff6HpZH2pO3WP6V1vcp991IDcTxnwMgq+vyB6Be0IOSDDtFdr28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqMjPrBH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741373859; x=1772909859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=djlpcjtTRk0DLJVGOp35DFrJsqRg1pJ63SR+Ubdm3H8=;
  b=KqMjPrBHZD+7kig9rHPRBZFeZfgeWwyPQPcikanvVXFRmztUwQaEfiw3
   d3EU/++sG/RiYSQ/1m1R5tNnR3lam9XWlFKV5ACmispEt68t3cyUguVlI
   C+5L3Cr86+sDZKTiFK7GFyrRZ5zun/WLfjOrevjDFwuArZhaCm3AB0tc+
   nafoeUalNnNzYndWES020zPtjuxAln7oMMX2M1MI7Y5M+rYcFxyORoiX0
   PMcPba1XnGiL9zjy1tcIJ7Q5DKnVb6Fx9KUWsMO1nKy1lIYXTeWweL/Xf
   c9mzfXJt6pxslktsEkdDrGVNbkNz6swj9bqLrjCHe4pXyYrUZvIMdCHrK
   Q==;
X-CSE-ConnectionGUID: ddzJFkcISkSFKtgJsG5D6A==
X-CSE-MsgGUID: cFSdqU/xRnmyp4zTSkvi/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42633901"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42633901"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:57:39 -0800
X-CSE-ConnectionGUID: S+jk9AwER/Wn95kHVjUtjg==
X-CSE-MsgGUID: iVUBwHzbTsG4ExGWEwH5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119149973"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:57:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqct5-00000000UkG-0yhz;
	Fri, 07 Mar 2025 20:57:35 +0200
Date: Fri, 7 Mar 2025 20:57:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move
 hwidth and bwidth to struct hd44780_common"
Message-ID: <Z8tBnq-j7gKrzlpk@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
 <Z8slexKyo7VFkSKW@smile.fi.intel.com>
 <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 07:14:02PM +0100, Geert Uytterhoeven wrote:
> On Fri, 7 Mar 2025 at 17:57, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Mar 07, 2025 at 10:03:31AM +0100, Geert Uytterhoeven wrote:
> > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
> > >
> > > s/The commit/Commit/
> >
> > Why? We know that we are talking about the very specific commit.
> 
> You can have a noun with or without an article:

This is not so simple :-), esp. if a noun is a weekday or a toponym.

>   - "a commit": an unspecified commit,
>   - "the commit": a specific commit, specified by context.
>   - "commit 1234abcd": a specific commit, specified by what follows.
> 
> > My English is not native I would appreciate a link to a material to study
> > the case you pointed out.
> 
> Neither is mine, but the use of articles is similar in English and Dutch.
> (I am aware your mother tongue does not have articles ;-)
> 
> I found plenty of articles explaining cases 1 and 2.
> Case 3 can be considered equivalent to "Mount Everest" in
> https://learnenglish.britishcouncil.org/grammar/a1-a2-grammar/articles-the-or-no-article

Okay, so you actually think that the hash and the title can be considered as
"name of a place". Hmm... I don't think it applies here. It's not a place.
Moreover some places require "the" article.

Here https://www.butte.edu/departments/cas/tipsheets/grammar/articles.html,
for example, the sentence "The 2003 federal budget" sounds to me closer to
our case. Every year there is a federal budget, but we explicitly point out
to one and reader knows what is this. The same with the commit.

Sorry, but I am still not convinced.

-- 
With Best Regards,
Andy Shevchenko




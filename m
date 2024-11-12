Return-Path: <linux-kernel+bounces-404964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979FD9C4B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE101F22D25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBB06AAD;
	Tue, 12 Nov 2024 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzohuRvN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27D7494
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371808; cv=none; b=Tq+NjD9uxfuj6lnnrT9aOVqLeqcnsh+HAYPjnPHvGkU9gK/EMT2L/9pOx4kQQEKkPzbrIjmU0hczlugHI8wvYgXqHoqzzFdxeWlK9wHsXnFsCEUOiirAARkTirGOBcZ2m2NaWoUWTsSYUYansuhTCu8CFeIazaUFpK+ZkGBBiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371808; c=relaxed/simple;
	bh=OtK3htmu/A7y+zFudLiRHDcKnEp8O0Xf+Lvc2oAChp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2MZVTrLHtbe6XPEY6b9Xq1FOmAQSk01jH+ywCG+W74CMlJRuTM7RoJmtU/LBy7VxofXRbOL/Sj6ijlnaQWWE2wYSMTKZB0sMrIlQf0j0EOhZTohAstx990zmixcHTUj5XQU58uNPc/wQklt44NJ0oVv54RtuZNRoq3FbtuD5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzohuRvN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731371807; x=1762907807;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OtK3htmu/A7y+zFudLiRHDcKnEp8O0Xf+Lvc2oAChp8=;
  b=KzohuRvNE1mILSkgIIPR4Yk2vzVQgxsxVqzWHCj2exPyrOsmsRR0wf5/
   ZfRG8pIpUaWYI7oSauqvQjz4BuXsW1eITONH5aoEXTg9Z7yLLoI8wHPzO
   1rJA2H+pYG1YPyfff5fzWxPnKvR+pEwJkmKNi/UtLHq0tS8t2ULTlSQgs
   EScmx22T50/o3jfAsDQajkAElxKzAOmFD/MM9aX3oAZsaXn1e5uOaw/Xy
   hH2OnkCuUs9AsYj3Mdd/12Y3+4G9FxnURumK6Ne8iqAKlg1l7aRYJ55km
   bl7WYBAm8yT8Ta7bbcf7HdcoUppGhxzgMufmOtCjwwA6oM8fjQH7GM7U1
   w==;
X-CSE-ConnectionGUID: vKKT2k2HT8meiAaIdVuVfw==
X-CSE-MsgGUID: e2z1ak8mSLKZJFf4Z/TWLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="30598165"
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="30598165"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 16:36:46 -0800
X-CSE-ConnectionGUID: Zn7J473BSWWL85Y8h11nhg==
X-CSE-MsgGUID: 3X2orW8lQZe2QR7JaJDd9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="87085658"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 16:36:44 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  akpm@linux-foundation.org,  david@redhat.com,  nphamcs@gmail.com,
  nehagholkar@meta.com,  abhishekd@meta.com,  Johannes Weiner
 <hannes@cmpxchg.org>,  Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
In-Reply-To: <ZzIT6eYeGXxhyG4g@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Mon, 11 Nov 2024 09:25:45 -0500")
References: <20240803094715.23900-1-gourry@gourry.net>
	<875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
	<87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com>
	<87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zy5R2JvXvhFoJzeY@PC2K9PVX.TheFacebook.com>
	<871pzi5z8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZzIT6eYeGXxhyG4g@PC2K9PVX.TheFacebook.com>
Date: Tue, 12 Nov 2024 08:33:10 +0800
Message-ID: <87ttcdz3y1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Mon, Nov 11, 2024 at 09:35:09AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> >
>> > Exploring and testing this a little further, I brought this up to current
>> > folio work in 6.9 and found this solution to be unstable as-is.
>> >
>> > After some work to fix lock/reference issues, Johannes pointed out that
>> > __filemap_get_folio can be called from an atomic context - which means it
>> > may not be safe to do migrations in this context.
>> 
>> Sorry, I don't understand this, the above patch changes
>> filemap_get_pages() and grab_cache_page_write_begin() instead of
>> __filemap_get_folio().
>>
>
> on newer kernels, grab_cache_page_write_begin is a compat wrapper for
> __filemap_get_folio and folio_file_page.  This chunk of code has changed
> somewhat significantly, actually.
>  
>> > We're back to looking at something like an LRU-esque system, but now we're
>> > thinking about isolating the folios in folio_mark_accessed into a task-local
>> > list, and then process the list on resume.
>> 
>> If necessary, we can use a similar method for above solution too.  And
>> we can filter accessed once folios with folio_mark_accessed() firstly.
>> That is, only promote a page if,
>> 
>> - record the folio access time in folio_mark_accessed() only
>> - when the folio are accessed again, and "access_time - record_time <
>>   threshold", promote the folio.
>> 
>
> yes this was the thought.
>
>> > Basically we're thinking
>> >
>> > 1) hook folio_mark_accessed and use PG_ACTIVE/PG_ACCESSED to determine whether
>> >    the page is a promotion candidate.
>> > 2) if it is, isolate it from the LRU - which is safe because folio_mark_accessed
>> >    already does this elsewhere, and place it onto current->promo_queue
>> > 3) set_notify_resume
>> > 4) add logic to resume_user_mode_work() to run through current->promo_queue and
>> >    either promote the pages accordingly, or do folio_putback_lru on failure.
>> 
>> Use a task_work?
>> 
>
> probably more correct, had a discussion about kernel threads accessing
> file cache and we weren't sure if that situation even existed - so probably

We can ignore kthread when collecting promoting candidates folios.

> going to try task_work first.

--
Best Regards,
Huang, Ying


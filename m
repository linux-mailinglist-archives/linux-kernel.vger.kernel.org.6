Return-Path: <linux-kernel+bounces-254893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830109338EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D05B240DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011F2D61B;
	Wed, 17 Jul 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+1tQJDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91309249F9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204640; cv=none; b=tdjZO2vVHJZ1B2q5CXRoOdOlNnNP1vzDxiIQSXDlE1G/hffgdhBeoFH+UPwzAzPqe60lpJRJCvCo4FEbWvxnfvolAMvNzNwof98BESCt7h272Q6TXl+XkEsfkPOD6kSP7AiBU7I23tFmvLESf0uxK35c7aOWq3upOXgc7pgl2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204640; c=relaxed/simple;
	bh=J93PJ80lwzNfVygKXW1Fko1sjw8RHKIQw4PZi1v3lsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R/goBTnJ75BgV8DDUdlLU6gCvuxMgvDaZSU99nhIWvWckBlZ+eZYNMdaL0OxoOzxZWTl1Rk3jdHe1UOi8SqFKMqkHSCmWdDs0JJAJr+B9rjBeV+6GQmNtE0+tEdr38uogkU1yZyq97U5fgB9DVjP8ehcwLEgYK+EVo+DwEjI7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+1tQJDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A97C32782;
	Wed, 17 Jul 2024 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721204640;
	bh=J93PJ80lwzNfVygKXW1Fko1sjw8RHKIQw4PZi1v3lsk=;
	h=Date:From:To:Cc:Subject:From;
	b=a+1tQJDcq2AgOiaUBC0X9CSC33nitb4TQYxwYnBQvOhBDRwG723kgOT/jiPfUg0kr
	 4gmDDJ6xxUo1E1JRH1HuwuIDxzAxW4nrYYYHOGzMpc0uSz3L3W/bCnqW4wo4x54MdX
	 q0KfA+PGLHe9304WIncpl9eYGqK3J4BW5OXcQM1PUp8XStxsYfBMs44yFD52aonM2g
	 Y6l2U7ha+SUNU5RqChpTzjJfUiEXZKtHzVZxce5Wk7SYk3oAFGS+R8WPM2AreTZUkM
	 sinXdEmTnbB1pSGGYJkeLn/qfsiE6k02fXNhAxAqg+Ir0XZnoXhlL3SupqFrBdTqr5
	 iEay0Z553sNsA==
Date: Wed, 17 Jul 2024 11:23:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: updates for 6.11-rc1
Message-ID: <Zpd_luVnhT7VZz6v@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.11-rc1

for you to fetch changes up to 9364a7e40d54e6858479f0a96e1a04aa1204be16:

  memblock tests: fix implicit declaration of function 'numa_valid_node' (2024-07-05 11:24:47 +0300)

----------------------------------------------------------------
memblock: updates for 6.11-rc1

* reserve_mem command line parameter to allow creation of named memory
  reservation at boot time.
  The driving use-case is to improve the ability of pstore to retain
  ramoops data across reboots.
* cleaunps and small improvements in memblock and mm_init
* new tests cases in memblock test suite

----------------------------------------------------------------
James Gowans (1):
      memblock: Move late alloc warning down to phys alloc

Steven Rostedt (Google) (2):
      mm/memblock: Add "reserve_mem" to reserved named memory at boot up
      pstore/ramoops: Add ramoops.mem_name= command line option

Wei Yang (15):
      mm/memblock: remove empty dummy entry
      memblock tests: add memblock_reserve_all_locations_check()
      memblock tests: add memblock_reserve_many_may_conflict_check()
      mm/memblock: fix comment for memblock_isolate_range()
      memblock tests: add memblock_overlaps_region_checks
      mm/memblock: return true directly on finding overlap region
      mm/memblock: use PAGE_ALIGN_DOWN to get pgend in free_memmap
      mm/mm_init.c: use memblock_region_memory_base_pfn() to get startpfn
      mm/memblock: fix a typo in description of for_each_mem_region()
      mm/mm_init.c: move nr_initialised reset down a bit
      mm/mm_init.c: get the highest zone directly
      mm/mm_init.c: use deferred_init_mem_pfn_range_in_zone() to decide loop condition
      mm/mm_init.c: not always search next deferred_init_pfn from very beginning
      mm/mm_init.c: don't initialize page->lru again
      memblock tests: fix implicit declaration of function 'numa_valid_node'

 Documentation/admin-guide/kernel-parameters.txt |  22 ++
 Documentation/admin-guide/ramoops.rst           |  13 +
 fs/pstore/ram.c                                 |  14 ++
 include/linux/memblock.h                        |  21 +-
 include/linux/mm.h                              |   2 +
 mm/memblock.c                                   | 151 ++++++++++--
 mm/mm_init.c                                    |  69 +++---
 tools/include/linux/mm.h                        |   1 +
 tools/include/linux/numa.h                      |   5 +
 tools/testing/memblock/tests/basic_api.c        | 314 +++++++++++++++++++++++-
 tools/testing/memblock/tests/common.c           |   8 +-
 tools/testing/memblock/tests/common.h           |   4 +
 12 files changed, 542 insertions(+), 82 deletions(-)
-- 
Sincerely yours,
Mike.


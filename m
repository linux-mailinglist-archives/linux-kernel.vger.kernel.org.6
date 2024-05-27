Return-Path: <linux-kernel+bounces-189982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE38CF7FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C625B20E54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89DC2C6;
	Mon, 27 May 2024 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmseSKxX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052ECC121
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779534; cv=none; b=rIHdTlQRFeLmHHv38XG1poQIz6kPvH7bjW9PLPoao0G+nUYhPM+bAiVBk8FtuNODMTJm0Li53cTml0XIq8qtOkImhbPbnmm1YF4t1SVRYJXRQBSJjEx4+ijvn0BIfmHfvZV0KU49gPem/b+d5me22MPKI7tp361r/jV/xutyCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779534; c=relaxed/simple;
	bh=PqFnJjXda4JrJs9kQcuylggEyr0qX+SbbLX07eixydI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqNMCkMQcMoUZY3NxfFnIADUf1csaoFq1Om51elRzQgANZYt3UsGbh1gwiaTx1NarIGnDlwVzhncf+0iYRdxZdTyZfvp7SfaK6g9I896jm34OvQb0jkgkBsfZxr7eG0HNLerNFz9dbA3ERaLns9u2UdMLhzwVdu+cSPXCxnMGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmseSKxX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716779532; x=1748315532;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PqFnJjXda4JrJs9kQcuylggEyr0qX+SbbLX07eixydI=;
  b=lmseSKxXAhb87iunGF6LVrbpTjrEmvF7/BInoFQnh51GQNyTwX7AHbo8
   9ETXt7fCzHljlcV3baCWPj7ukxe7myS1xGNxm4+pSXBnrQJw+gGSJ9rWF
   vlJviZQSyXvV5ogmagT3u0XisY1F3x2lZroYhDfJXdTmiEx/0FiL+CzFX
   g8PYnGeWq8lewznCSYjvxZI/NixDliHaNEaBGFqPMRN/N3YmQ+Fag7E/p
   gwCRHCB7PMhNAzO3i4eW8Intpti27eKZ4Q4Obs8z2OMOOg2fblo7Z42dy
   WxbhWyDIe9727ASndeAYsGxGD/CeF8/fg6nzYwPKRcpwZLKuY7vaDdasT
   A==;
X-CSE-ConnectionGUID: 0Qblo1fQTyKdiekaNzv1yQ==
X-CSE-MsgGUID: 8csznrn7R+qjAMPQe0q2Bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12857597"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="12857597"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 20:12:11 -0700
X-CSE-ConnectionGUID: ZpYjmYHSR9u/mnr/7ahbMg==
X-CSE-MsgGUID: H5t9OQiESRCNuJEFRMB4Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="34510052"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 20:12:07 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Dave Hansen <dave.hansen@intel.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,
  <akpm@linux-foundation.org>,  <vernhao@tencent.com>,
  <mgorman@techsingularity.net>,  <hughd@google.com>,
  <willy@infradead.org>,  <david@redhat.com>,  <peterz@infradead.org>,
  <luto@kernel.org>,  <tglx@linutronix.de>,  <mingo@redhat.com>,
  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,  <rjgolo@gmail.com>
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
In-Reply-To: <20240527015732.GA61604@system.software.com> (Byungchul Park's
	message of "Mon, 27 May 2024 10:57:32 +0900")
References: <20240510065206.76078-1-byungchul@sk.com>
	<982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
	<20240527015732.GA61604@system.software.com>
Date: Mon, 27 May 2024 11:10:15 +0800
Message-ID: <8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Fri, May 24, 2024 at 10:16:39AM -0700, Dave Hansen wrote:
>> On 5/9/24 23:51, Byungchul Park wrote:
>> > To achieve that:
>> > 
>> >    1. For the folios that map only to non-writable tlb entries, prevent
>> >       tlb flush during unmapping but perform it just before the folios
>> >       actually become used, out of buddy or pcp.
>> 
>> Is this just _pure_ unmapping (like MADV_DONTNEED), or does it apply to
>> changing the memory map, like munmap() itself?
>
> I think it can be applied to any unmapping of ro ones but LUF for now is
> working only with unmapping during folio migrion and reclaim.
>
>> >    2. When any non-writable ptes change to writable e.g. through fault
>> >       handler, give up luf mechanism and perform tlb flush required
>> >       right away.
>> > 
>> >    3. When a writable mapping is created e.g. through mmap(), give up
>> >       luf mechanism and perform tlb flush required right away.
>> 
>> Let's say you do this:
>> 
>> 	fd = open("/some/file", O_RDONLY);
>> 	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
>> 	foo1 = *ptr1;
>> 
>> You now have a read-only PTE pointing to the first page of /some/file.
>> Let's say try_to_unmap() comes along and decides it can_luf_folio().
>> The page gets pulled out of the page cache and freed, the PTE is zeroed.
>>  But the TLB is never flushed.
>> 
>> Now, someone does:
>> 
>> 	fd2 = open("/some/other/file", O_RDONLY);
>> 	ptr2 = mmap(ptr1, size, PROT_READ, MAP_FIXED, fd, ...);
>> 	foo2 = *ptr2;
>> 
>> and they overwrite the old VMA.  Does foo2 have the contents of the new
>> "/some/other/file" or the old "/some/file"?  How does the new mmap()
>
> Good point.  It should've give up LUF at the 2nd mmap() in this case.
> I will fix it by introducing a new flag in task_struct indicating if LUF
> has left stale maps for the task so that LUF can give up and flush right
> away in mmap().
>
>> know that there was something to flush?
>> 
>> BTW, the same thing could happen without a new mmap().  Someone could
>> modify the file in the middle, maybe even from another process.
>
> Thank you for the pointing out.  I will fix it too by introducing a new
> flag in inode or something to make LUF aware if updating the file has
> been tried so that LUF can give up and flush right away in the case.
>
> Plus, I will add another give-up at code changing the permission of vma
> to writable.

I guess that you need a framework similar as
"flush_tlb_batched_pending()" to deal with interaction with other TLB
related operations.

--
Best Regards,
Huang, Ying

> Thank you very much.
>
> 	Byungchul
>
>> 	fd = open("/some/file", O_RDONLY);
>> 	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
>> 	foo1 = *ptr1;
>> 	// LUF happens here
>> 	// "/some/file" changes
>> 	foo2 = *ptr1; // Does this see the change?


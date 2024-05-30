Return-Path: <linux-kernel+bounces-194838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19858D42C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E15C2851B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB051078B;
	Thu, 30 May 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFbD/Bos"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC40FBE8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031623; cv=none; b=MMnJuMk5pe1NBfkRqbgeaZ0pvgHc/3OofMFqj8W6uj4cDQ3x0KnQ+wSg+Fyivx/26/RZXpvWhmgtLSSCRNnjCUldwPgteqG09sBZvemZFe28DY0Qt5u1Blz5nVb5dQ8itamYzT7Mb3777x9zpk+jb29Gtq+/b8qnLA9RC+68hE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031623; c=relaxed/simple;
	bh=Xb/f8BPIVFm2prTA2+dSu7ceaxOD559xDuyFlDo1qyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OtizuxnEdDAE9OKUCFmGWF2lq3WlPklZqd8dF1P3f92K0vbZ4BSlZx+LkjLbfyo7O5iKy0ZrUviW8meTJOwe4g60bUKkGwON4kjKzcgVcpnzOGVY0SoMqZgdaYzuCpbEvidxifAMAy4rgJ3p78ne2WaE6Iy9g3knpAwJ5sPDJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFbD/Bos; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717031623; x=1748567623;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Xb/f8BPIVFm2prTA2+dSu7ceaxOD559xDuyFlDo1qyM=;
  b=ZFbD/Bosse/mFJp8RqOdgiQxJwq+M77MRm1q5+ihm/CucbNynEPj0dof
   l5GCISFld48kFm29DYKwDpPavcSA+578CkgxJROZLaTdm2Tc5jtol4w1F
   jYQklMNV5dHP/Vj2R6DAXfD8D17Cx3PThyHqBgG7nuAn6LWCPN7Tufoqi
   DCbjO6nw3O/wdwU12gMdN/i+g02fou6u3oDEREifWgGGC+oGLjSrUKSAq
   2WAJYC7hZb2EpTMzAd4ELHetCSGy60kXV+KSMTBEG7IIKZyYcfOFoTho9
   nGuU19c7Z9LsxjmSRtqajk737a2/bA9xUhbIKkz9Su70XhglQKPOLXuDd
   g==;
X-CSE-ConnectionGUID: xpPiMVdsQSuMw4vjnmf6MA==
X-CSE-MsgGUID: ZmSfEsRQR/i1IXcCgjjPDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13606679"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13606679"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:13:42 -0700
X-CSE-ConnectionGUID: l6BtNFyOTeGtb2h7wudBRA==
X-CSE-MsgGUID: tHIEmQFBS/uxjVreWIwDeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66834201"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:13:37 -0700
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
In-Reply-To: <20240530005026.GA47476@system.software.com> (Byungchul Park's
	message of "Thu, 30 May 2024 09:50:26 +0900")
References: <20240510065206.76078-1-byungchul@sk.com>
	<982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
	<20240527015732.GA61604@system.software.com>
	<8734q46jc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<44e4f2fd-e76e-445d-b618-17a6ec692812@intel.com>
	<20240529050046.GB20307@system.software.com>
	<961f9533-1e0c-416c-b6b0-d46b97127de2@intel.com>
	<20240530005026.GA47476@system.software.com>
Date: Thu, 30 May 2024 09:11:45 +0800
Message-ID: <87a5k814tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Wed, May 29, 2024 at 09:41:22AM -0700, Dave Hansen wrote:
>> On 5/28/24 22:00, Byungchul Park wrote:
>> > All the code updating ptes already performs TLB flush needed in a safe
>> > way if it's inevitable e.g. munmap.  LUF which controls when to flush in
>> > a higer level than arch code, just leaves stale ro tlb entries that are
>> > currently supposed to be in use.  Could you give a scenario that you are
>> > concering?
>> 
>> Let's go back this scenario:
>> 
>>  	fd = open("/some/file", O_RDONLY);
>>  	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
>>  	foo1 = *ptr1;
>> 
>> There's a read-only PTE at 'ptr1'.  Right?  The page being pointed to is
>> eligible for LUF via the try_to_unmap() paths.  In other words, the page
>> might be reclaimed at any time.  If it is reclaimed, the PTE will be
>> cleared.
>> 
>> Then, the user might do:
>> 
>> 	munmap(ptr1, PAGE_SIZE);
>> 
>> Which will _eventually_ wind up in the zap_pte_range() loop.  But that
>> loop will only see pte_none().  It doesn't do _anything_ to the 'struct
>> mmu_gather'.
>> 
>> The munmap() then lands in tlb_flush_mmu_tlbonly() where it looks at the
>> 'struct mmu_gather':
>> 
>>         if (!(tlb->freed_tables || tlb->cleared_ptes ||
>> 	      tlb->cleared_pmds || tlb->cleared_puds ||
>> 	      tlb->cleared_p4ds))
>>                 return;
>> 
>> But since there were no cleared PTEs (or anything else) during the
>> unmap, this just returns and doesn't flush the TLB.
>> 
>> We now have an address space with a stale TLB entry at 'ptr1' and not
>> even a VMA there.  There's nothing to stop a new VMA from going in,
>> installing a *new* PTE, but getting data from the stale TLB entry that
>> still hasn't been flushed.
>
> Thank you for the explanation.  I got you.  I think I could handle the
> case through a new flag in vma or something indicating LUF has deferred
> necessary TLB flush for it during unmapping so that mmu_gather mechanism
> can be aware of it.  Of course, the performance change should be checked
> again.  Thoughts?

I suggest you to start with the simple case.  That is, only support page
reclaiming and migration.  A TLB flushing can be enforced during unmap
with something similar as flush_tlb_batched_pending().

--
Best Regards,
Huang, Ying


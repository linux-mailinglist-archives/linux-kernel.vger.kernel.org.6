Return-Path: <linux-kernel+bounces-345026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23598B13A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE1AB211DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0955E186E33;
	Mon, 30 Sep 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuJUVGjI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5E2C1B4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740488; cv=none; b=HlEhygOWTVt316xXl5gqjoJBhfE64WYznruk/PmGLqGQHGD0b66wHr5hPdQ3Y6Nl0x+rTCgo7QvyoRWbmhnk/TIvGqbfJ7l3RAT5CdNFKHmrQwYlj7Dc3DvBx/s8AZckr/xqQrhF+SMNHbdzWP6DZKx0ZskFDIEmvZeWGUjtb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740488; c=relaxed/simple;
	bh=jnLEbV10e8rDNV6NIwnCNnnDROhh8eyNMS6Se3TBvOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VWQAVa4sGkrq3yDZsL8kZ7Jl6qRB1yeqB8AJOALpNeWGMj1qc7TxBxA1TrFOXHQxXRhNcjgX59jD1tzQyI+Y0+MeOWPDe+VfF9sFZieG1MJjPTk8QmEKqsN/Vr7rynuQCr0E2yE5k3S+gAHKuSQ8YSg6kzHY5UGEI3x5hjcb0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuJUVGjI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727740487; x=1759276487;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jnLEbV10e8rDNV6NIwnCNnnDROhh8eyNMS6Se3TBvOk=;
  b=PuJUVGjIffTU6wpI22B7P1ue1ctfNBwsFbOt8WuTi1kbQbUTqUgNxqXy
   wusrUD+SyipoTXGtLqNJv0brdNuCQ71WRAJCcllW0uvOiyVCDgFi+b/WQ
   0VFs2ebnJklf/7hnXDKJyzk0L8c6n8r8V4G6l7w5hn4R6+3mhjCJ3ZJu4
   KrKX6KlB7eqWa+a5KC67XT1aE0BRcU7mAoxn6FSkFSTzHI/0Fbzx/PnDI
   +rg40iCcqCzvWEh4BMLQBnwU09lBYPCfSy8KeGPdqEnpiOGPs1ihAhQ9k
   M9pklUAC5FDAicZRU1Q2VOMSvg21HXt/3iebmB22wFrc95G2oWPkJSiAW
   g==;
X-CSE-ConnectionGUID: NRSEauRZTCam3rCzaaHUIA==
X-CSE-MsgGUID: Uc/NbOy+QUCw8Wy6lc+gRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37527744"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="37527744"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:54:46 -0700
X-CSE-ConnectionGUID: LuEfMUGrTyqBT1bjMosr1g==
X-CSE-MsgGUID: fdGZ+36IR3So8V9oC2Z4Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73593323"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:54:43 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>,  x86@kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Oscar Salvador <osalvador@suse.de>,
  linux-coco@lists.linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Dan Williams <dan.j.williams@intel.com>,
  Kai Huang <kai.huang@intel.com>,  "H. Peter Anvin" <hpa@zytor.com>,  Andy
 Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory
 range for TDX
In-Reply-To: <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com> (David
	Hildenbrand's message of "Mon, 30 Sep 2024 10:58:09 +0200")
References: <20240930055112.344206-1-ying.huang@intel.com>
	<cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
Date: Tue, 01 Oct 2024 07:51:09 +0800
Message-ID: <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, David,

Thanks a lot for comments!

David Hildenbrand <david@redhat.com> writes:

> On 30.09.24 07:51, Huang Ying wrote:
>> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
>> hot-added must be checked for compatibility by TDX.  This is currently
>> implemented through memory hotplug notifiers for each memory_block.
>> If a memory range which isn't TDX compatible is hot-added, for
>> example, some CXL memory, the command line as follows,
>>    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
>> will report something like,
>>    bash: echo: write error: Operation not permitted
>> If pr_debug() is enabled, the error message like below will be shown
>> in the kernel log,
>>    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
>> Both are too general to root cause the problem.  This will confuse
>> users.  One solution is to print some error messages in the TDX memory
>> hotplug notifier.  However, memory hotplug notifiers are called for
>> each memory block, so this may lead to a large volume of messages in
>> the kernel log if a large number of memory blocks are onlined with a
>> script or automatically.  For example, the typical size of memory
>> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
>> will be logged.
>
> ratelimiting would likely help here a lot, but I agree that it is
> suboptimal.
>
>> Therefore, in this patch, the whole hot-adding memory range is
>> checked
>> for TDX compatibility through a newly added architecture specific
>> function (arch_check_hotplug_memory_range()).  If rejected, the memory
>> hot-adding will be aborted with a proper kernel log message.  Which
>> looks like something as below,
>>    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX
>> for TDX compatibility.
>> > The target use case is to support CXL memory on TDX enabled systems.
>> If the CXL memory isn't compatible with TDX, the whole CXL memory
>> range hot-adding will be rejected.  While the CXL memory can still be
>> used via devdax interface.
>
> I'm curious, why can that memory be used through devdax but not
> through the buddy? I'm probably missing something important :)

Because only TDX compatible memory can be used for TDX guest.  The buddy
is used to allocate memory for TDX guest.  While devdax will not be used
for that.

>> This also makes the original TDX memory hotplug notifier useless, so
>> delete it.
>
> The online-notifier would even be too late when used with the
> memmap-on-memory feature I assume, as we might be touching that memory
> even before being able to call memory online notifiers.

This should be OK.  Because we will not use the memory for TDX guest in
this way.

> One way to handle that would be to switch to the MEM_PREPARE_ONLINE
> notifier, but it's still called per-memory block.
>
> Nothing jumped at me, so
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thank you very much!

--
Best Regards,
Huang, Ying


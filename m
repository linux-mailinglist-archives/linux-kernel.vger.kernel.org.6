Return-Path: <linux-kernel+bounces-176447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3748C3004
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4CB1C213F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946F38F6E;
	Sat, 11 May 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMGcyLe7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA16610B
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715411819; cv=none; b=jWFxQow8d6spSBGfY54sMfzGM4g/9gTxBtMizK3KFawmNpR60wRfIamRH30jXUDO/9w5CBIDiPGtvB9BMkE7tqiVKl2mc5f+YIcsvgWfhG2ONa1/TXexpCn7z0auRQw9lota8wdubGJrp25nm2sw28F/K310Ic5vPjEO0SmX7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715411819; c=relaxed/simple;
	bh=UjfcOdQ7YlJbwrIn5Z1f6LDu4xcSH4SHVETdeCZ97fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdtNOB2texBlrXn3OA/JBZeTOEfftKmqoH9+kjKqrtENZ8NSs7xawA11umVHYJQKNlI3mdZB5JR187V93MoxvC36C9xGTUquIyO4HDldj0ZyoH9ePw+hQswTNn/j1r2U8u0eP6GYHlSB51ZVex7maqXPR/MdOB6tu1u+P57iJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMGcyLe7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715411818; x=1746947818;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UjfcOdQ7YlJbwrIn5Z1f6LDu4xcSH4SHVETdeCZ97fg=;
  b=XMGcyLe7VxCG/7vghUV3scXpMZPqQ6HZVXXhn/QD5HKx+Gvl3NxAluS5
   aBxVvrlaN3NbI/hwT8zSwUR4LXbWiIaO2uo27fWe5i40eM1KsGTChSC/3
   UMCYOEg7aFg1wCHWoNf+MpP+IzmjFiRtLEPthPHfjCOdljvabomJVEj5Z
   bhALj+ZIcH2AnnmxOBqMsz+sqSuSHFSTjtibYC/f5vhJiXpg0cLwpZ4xG
   wYjCQaf/uOGGYm3iUlKP0Aqp5ikB+6331OaRnUZSax6uqPUjwABLI9bnb
   hM00M2k5gYUl8IaH9YuHxN2tsQmljF30uyGVDWDDbV/Q/Sf3mcuMtcFnz
   g==;
X-CSE-ConnectionGUID: hVUr0lRTR5aCZyEd2Pmbcw==
X-CSE-MsgGUID: 5DoTwajiR/ux+OE4QUEt5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11275291"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="11275291"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 00:16:57 -0700
X-CSE-ConnectionGUID: B3atYuulRImHw5DRnz8icA==
X-CSE-MsgGUID: 8qNNcdoaQ/iVPMV/UUScwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="30409213"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 00:16:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kernel_team@skhynix.com>,  <akpm@linux-foundation.org>,
  <vernhao@tencent.com>,  <mgorman@techsingularity.net>,
  <hughd@google.com>,  <willy@infradead.org>,  <david@redhat.com>,
  <peterz@infradead.org>,  <luto@kernel.org>,  <tglx@linutronix.de>,
  <mingo@redhat.com>,  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,
  <rjgolo@gmail.com>
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com> (Byungchul Park's
	message of "Fri, 10 May 2024 15:51:54 +0900")
References: <20240510065206.76078-1-byungchul@sk.com>
Date: Sat, 11 May 2024 15:15:01 +0800
Message-ID: <87eda8g6q2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> Hi everyone,
>
> While I'm working with a tiered memory system e.g. CXL memory, I have
> been facing migration overhead esp. tlb shootdown on promotion or
> demotion between different tiers.  Yeah..  most tlb shootdowns on
> migration through hinting fault can be avoided thanks to Huang Ying's
> work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> is inaccessible").  See the following link for more information:
>
> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/

And, I still have interest of the performance impact of commit
7e12beb8ca2a ("migrate_pages: batch flushing TLB").  In the email above,
you said that the performance of v6.5-rc5 + 7e12beb8ca2a reverted has
better performance than v6.5-rc5.  Can you provide more details?  For
example, the number of TLB flushing IPI for two kernels?

I should have followed up the above email.  Sorry about that.  Anyway,
we should try to fix issue of that commit too.

--
Best Regards,
Huang, Ying

[snip]


Return-Path: <linux-kernel+bounces-320720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B595B970F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E596B20E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7411AED5D;
	Mon,  9 Sep 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bqeej42w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0B1AE05B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866569; cv=none; b=m3Lc+1cbW9KKfCiakLT9iTOf3z0XRqUclf8vih4NI8l5Oste49rVNvcTIkei39BRPkJ5q1ALx13wkN/bQY+0HH3lyuwIRBI3NIPZLkAAhChSL6p2bf86+kU07SFBz/ttlNjKOlDRQVMs/X5vxz4nccqUxHlLMY9ibw3JuOfDLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866569; c=relaxed/simple;
	bh=HHYCMioBl3rZ8NMchmxx02IbaAD4rnswOq1CX26vmWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5MUxPVdlBnubfSBIhuI13uvw97KmCnOiFA2UQNmoCXtMu+k5N+tZLwDwjX4BgAczXwKrRtddzBpjwZkkl7G3SI5uAu/MgYiSzcvdlU2y9pVkmDh0EoAEb3GOChpgn7+xEE0EpjojjSZjyc28rqADgKB5gkHa546Tfpu2BJQPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bqeej42w; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725866568; x=1757402568;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=HHYCMioBl3rZ8NMchmxx02IbaAD4rnswOq1CX26vmWg=;
  b=Bqeej42wc83RUNFFXhW4Wb+QqJJUWPW8lhNI+N9DfCDjINhH+T8L017k
   iE8tyBfd29Kqq56juCmCXDDtglDQXfHovLcmwl1Hmehyy4bNO25nbo3iS
   TbrfcwxnqLGFO0GjLuE735SQup03OhdmJ3r7TMcOaD0+2Y2kW9YS4/blX
   xWq2JHvVYn+/0VOQlNMAy+kMYi1M2xmeszZmeohRivoiU5VQYuKBRLym8
   k2+Y3OCQWDmG2MeQg5eJyC37KPag25vG29vpBdweLKHDlGjRy/iwiJ+UQ
   DoDAgydonuTg3cdDWPrAUWLQ2rMVJlZwpsrgvxH+Rgdn97dkz6IYPLXl4
   A==;
X-CSE-ConnectionGUID: v5i9CYOGTq2rC5aPGh8gmw==
X-CSE-MsgGUID: YwmxQotGSESHHbI/zOp/aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="27466234"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="27466234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:22:47 -0700
X-CSE-ConnectionGUID: VRmB02zvTlmGloW/9qXSHg==
X-CSE-MsgGUID: jr46ujuNR6eZpe1z4xnnBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71524171"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:22:45 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Hugh Dickins <hughd@google.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v5 2/9] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbUp1-BsWgYX0hWDVYT+8Q2w_E-0z5up==af_B5KJ7q=VA@mail.gmail.com>
	(Chris Li's message of "Mon, 26 Aug 2024 14:26:19 -0700")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
	<20240730-swap-allocator-v5-2-cb9c148b9297@kernel.org>
	<87bk23250r.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbX1M8tfqj__nvMwvD0P0abEjbju2gQDEea9BPZ6eUuRuQ@mail.gmail.com>
	<871q2lhr4s.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbUp1-BsWgYX0hWDVYT+8Q2w_E-0z5up==af_B5KJ7q=VA@mail.gmail.com>
Date: Mon, 09 Sep 2024 15:19:11 +0800
Message-ID: <874j6p1ehc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> On Mon, Aug 19, 2024 at 1:11=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>> > BTW, what is your take on my  previous analysis of the current SSD
>> > prefer write new cluster can wear out the SSD faster?
>>
>> No.  I don't agree with you on that.  However, my knowledge on SSD
>> wearing out algorithm is quite limited.
>
> Hi Ying,
>
> Can you please clarify. You said you have limited knowledge on SSD
> wearing internals. Does that mean you have low confidence in your
> verdict?

Yes.

> I would like to understand your reasoning for the disagreement.
> Starting from which part of my analysis you are disagreeing with.
>
> At the same time, we can consult someone who works in the SSD space
> and understand the SSD internal wearing better.

I think that is a good idea.

> I see this is a serious issue for using SSD as swapping for data
> center usage cases. In your laptop usage case, you are not using the
> LLM training 24/7 right? So it still fits the usage model of the
> occasional user of the swap file. It might not be as big a deal. In
> the data center workload, e.g. Google's swap write 24/7. The amount of
> data swapped out is much higher than typical laptop usage as well.
> There the SSD wearing out issue would be much higher because the SSD
> is under constant write and much bigger swap usage.
>
> I am claiming that *some* SSD would have a higher internal write
> amplification factor if doing random 4K write all over the drive, than
> random 4K write to a small area of the drive.
> I do believe having a different swap out policy controlling preferring
> old vs new clusters is beneficial to the data center SSD swap usage
> case.
> It come downs to:
> 1) SSD are slow to erase. So most of the SSD performance erases at a
> huge erase block size.
> 2) SSD remaps the logical block address to the internal erase block.
> Most of the new data rewritten, regardless of the logical block
> address of the SSD drive, grouped together and written to the erase
> block.
> 3) When new data is overridden to the old logical data address, SSD
> firmware marks those over-written data as obsolete. The discard
> command has the similar effect without introducing new data.
> 4) When the SSD driver runs out of new erase block, it would need to
> GC the old fragmented erased block and pertectial write out of old
> data to make room for new erase block. Where the discard command can
> be beneficial. It tells the SSD firmware which part of the old data
> the GC process can just ignore and skip rewriting.
>
> GC of the obsolete logical blocks is a general hard problem for the SSD.
>
> I am not claiming every SSD has this kind of behavior, but it is
> common enough to be worth providing an option.
>
>> > I think it might be useful to provide users an option to choose to
>> > write a non full list first. The trade off is more friendly to SSD
>> > wear out than preferring to write new blocks. If you keep doing the
>> > swap long enough, there will be no new free cluster anyway.
>>
>> It depends on workloads.  Some workloads may demonstrate better spatial
>> locality.
>
> Yes, agree that it may happen or may not happen depending on the
> workload . The random distribution swap entry is a common pattern we
> need to consider as well. The odds are against us. As in the quoted
> email where I did the calculation, the odds of getting the whole
> cluster free in the random model is very low, 4.4E10-15 even if we are
> only using 1/16 swap entries in the swapfile.

Do you have real workloads?  For example, some trace?

--
Best Regards,
Huang, Ying


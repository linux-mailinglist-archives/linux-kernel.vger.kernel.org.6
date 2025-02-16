Return-Path: <linux-kernel+bounces-516481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB65DA3724D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B4A16DD9D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06F414830F;
	Sun, 16 Feb 2025 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AWqIcDF4"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB24748D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739688608; cv=none; b=qbfiUmZJLEYX9Eq/VNTABZP0pmjn32WnSkbHUWYZI8o5dmmXCq+JX8kgGivihDfw0TU1+YiGTamU4mzFJSr8t0VGMHdaq3rWqb01e21GR51zIntChwOEUsBjlo06BqeK4KwTOtktM8Abymqntv0m1/BO59E0YRX2OfZ2tO1Inkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739688608; c=relaxed/simple;
	bh=h6QnH1MmtkzBR4KPzRKDT/nAdN+/Ff5Wf+BqxP1Sww0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VImoXfU4eJTW6JWt6EFmkjVhg+TOiBF+EE4ICZhHaHrMSSRrDlvlVYgCYRRw1cPi4I4XIadZODV9YEyhPaLUe/NmohF01F1/NXGX2gUsyTpGPDx3pn14oRtM4WGE3xNVvueROgqQFyOD1KocSseo4ycj8A8qcbAoTve8bmrKUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AWqIcDF4; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739688596; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=A4i12Hq2xcwxxA1hyCxMdNiAIgNeSCHhJ94p41qg+Yc=;
	b=AWqIcDF4U2MUoQNgWx9XFspghPzW8ychyx1J/bBBQ0JsIePFjhRLqY/tNCs5vT5FSo6EXrH01mtT1EHdW/rApNXsBTPnltv1J1Jsz/zs04xJyt2zx4iOu+PRR/s5C3R46URZ1jW/Rp7OMBtflXrezUh0deiibhl9hJfTJo4PVIs=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WPVzX6N_1739688591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Feb 2025 14:49:53 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Raghavendra K T <raghavendra.kt@amd.com>,  <linux-mm@kvack.org>,
  <akpm@linux-foundation.org>,  <lsf-pc@lists.linux-foundation.org>,
  <bharata@amd.com>,  <gourry@gourry.net>,  <nehagholkar@meta.com>,
  <abhishekd@meta.com>,  <nphamcs@gmail.com>,  <hannes@cmpxchg.org>,
  <feng.tang@intel.com>,  <kbusch@meta.com>,  <Hasan.Maruf@amd.com>,
  <sj@kernel.org>,  <david@redhat.com>,  <willy@infradead.org>,
  <k.shutemov@gmail.com>,  <mgorman@techsingularity.net>,
  <vbabka@suse.cz>,  <hughd@google.com>,  <rientjes@google.com>,
  <shy828301@gmail.com>,  <liam.howlett@oracle.com>,
  <peterz@infradead.org>,  <mingo@redhat.com>,  <nadav.amit@gmail.com>,
  <shivankg@amd.com>,  <ziy@nvidia.com>,  <jhubbard@nvidia.com>,
  <AneeshKumar.KizhakeVeetil@arm.com>,  <linux-kernel@vger.kernel.org>,
  <jon.grimm@amd.com>,  <santosh.shukla@amd.com>,  <Michael.Day@amd.com>,
  <riel@surriel.com>,  <weixugc@google.com>,  <leesuyeon0506@gmail.com>,
  <honggyu.kim@sk.com>,  <leillc@google.com>,  <kmanaouil.dev@gmail.com>,
  <rppt@kernel.org>,  <dave.hansen@intel.com>
Subject: Re: [LSF/MM/BPF TOPIC] Unifying sources of page temperature
 information - what info is actually wanted?
In-Reply-To: <20250131130901.00000dd1@huawei.com> (Jonathan Cameron's message
	of "Fri, 31 Jan 2025 13:09:01 +0000")
References: <20250123105721.424117-1-raghavendra.kt@amd.com>
	<20250131122803.000031aa@huawei.com>
	<20250131130901.00000dd1@huawei.com>
Date: Sun, 16 Feb 2025 14:49:50 +0800
Message-ID: <87h64u2xkh.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Jonathan,

Sorry for late reply.

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Fri, 31 Jan 2025 12:28:03 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> > Here is the list of potential discussion points:  
>> ...
>> 
>> > 2. Possibility of maintaining single source of truth for page hotness that would
>> > maintain hot page information from multiple sources and let other sub-systems
>> > use that info.  
>> Hi,
>> 
>> I was thinking of proposing a separate topic on a single source of hotness,
>> but this question covers it so I'll add some thoughts here instead.
>> I think we are very early, but sharing some experience and thoughts in a
>> session may be useful.
>
> Thinking more on this over lunch, I think it is worth calling this out as a
> potential session topic in it's own right rather than trying to find
> time within other sessions.  Hence the title change.
>
> I think a session would start with a brief listing of the temperature sources
> we have and those on the horizon to motivate what we are unifying, then
> discussion to focus on need for such a unification + requirements 
> (maybe with a straw man).
>
>> 
>> What do the other subsystems that want to use a single source of page hotness
>> want to be able to find out? (subject to filters like memory range, process etc)
>> 
>> A) How hot is page X?  
>> - Is this useful, or too much data? What would use it?
>>   * Application optimization maybe. Very handy for developing algorithms
>>     to do the rest of the options here as an Oracle!
>> - Provides both the cold and hot end of the scale, but maybe measurement
>>   techniques vary and can not be easily combined. Hard in general to combine
>>   multiple sources of truth if aiming for an absolute number.
>> 
>> B) Which pages are super hot?
>> - Probably these that make the most difference if they are in a slower memory tier.
>> 
>> C) Some pages are hot enough to consider moving?
>> - This may be good enough to get the key data into the fast memory over time.
>> - Can combine sources of info as being able to compare precise numbers doesn't matter.
>> 
>> D) Which pages are fairly cold?
>> - Likewise maybe good enough over time.
>> 
>> E) Which pages are very cold?
>> - Ideal case for tiering. Swap these with the super hot ones.
>> - Maybe extra signal for swap / zswap etc
>> 
>> F) Did these hot pages remain hot (and same for cold)
>> - This is needed to know when to back off doing things as we have unstable
>>   hotness (two phase applications are a pain for this), sampling a few
>>   pages may be fine.
>> 
>> Messy corners:
>> 
>> Temporal aspects.
>> - If only providing lists of hottest / coldest in last second, very hard
>>   to find those that are of a stable temperature. We end up moving
>>   very hot data (which is disruptive) and it doesn't stay hot.
>> - Can reduce that affect by long sampling windows on some measurement approaches
>>   (on hardware trackers that can trash accuracy due to resource exhaustion
>>    and other subtle effects).
>> - bistable / phase based applications are a pain but perhaps up to higher
>>   levels to back off.
>> 
>> My main interest is migrating in tiered systems but good to look at what
>> else would use a common layer.
>> 
>> Mostly I want to know something that is useful to move, and assume convergence
>> over the long term with the best things to move so to me the ideal layer has
>> following interface (strawman so shoot holes in it!):
>> 
>> 1) Give me up to X hotish pages from a slow tier (greater than a specific measure
>> of temperature)

Because the hot pages may be available upon page accessing (such PROT_NONE
page fault), the interface may be "push" style instead of "pull" style,
e.g.,

int register_hot_page_handler(void (*handler)(struct page *hot_page, int temperature));

>> 2) Give me X coldish pages a faster tier.
>> 3) I expect to ask again in X seconds so please have some info ready for me!
>> 4) (a path to get an idea of 'unhelpful moves' from earlier iterations - this
>>     is bleeding the tiering application into a shared interface though).

In addition to get a list hot/cold pages, it's also useful to get
hot/cold statistics of a memory device (NUMA node), e.g., something like
below,

Access frequency        percent
   > 1000 HZ            10%
 600-1000 HZ            20%
 200- 600 HZ            50%
   1- 200 HZ            15%
      < 1 HZ             5%

Compared with hot/cold pages list, this may be gotten with lower
overhead and can be useful to tune the promotion/demotion alrogithm.  At
the same time, a sampled (incomplete) list of hot/cold page list may be
available too.

>> If we have multiple subsystems using the data we will need to resolve their
>> conflicting demands to generate good enough data with appropriate overhead.
>> 
>> I'd also like a virtualized solution for case of hardware PA trackers (what
>> I have with CXL Hotness Monitoring Units) and classic memory pool / stranding
>> avoidance case where the VM is the right entity to make migration decisions.
>> Making that interface convey what the kernel is going to use would be an
>> efficient option. I'd like to hide how the sausage was made from the VM.

---
Best Regards,
Huang, Ying


Return-Path: <linux-kernel+bounces-516485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551ACA37256
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E53318879CE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2114C5B0;
	Sun, 16 Feb 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YTYxVF1g"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05BA14387B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739689500; cv=none; b=BFnC3+jA+gv8bw12iSJie9/4bswGutXVoi2rIBUAr3Z2tkIes/FwvqaGUwgZLdc8FkANQeE3CyolTkA9v9S7PHr51wy9aoZhojcnV4zfCRpYfhnHSPq1iY6/xW8YwoD9ygKqZ5qgPD7s/Oi36R+P5SSXSi2+NeN2joefndfdL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739689500; c=relaxed/simple;
	bh=gg3jH31zGAHJiHekNhoUqb9X9KejcHabojVZg2sXCCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QvH9h8X96UwDgA+3exyyza3U6jziIMtAjgircparWzPyweVbDM3SR61gh3TmqZ3PQTrIfSCYPR4CbzBAVd+DcTldElPTBXZxOyrhM1tmSBRYjqMsGxS6TGgVHhgv2f8yU0S71eMhoK1RSED+IKfLZNm6EtRHSmivsoORjyLIkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YTYxVF1g; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739689494; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=lBJ47s5NRlrS0cb6wfv64d5UsTFv+6Rba2Bz4U5pMfc=;
	b=YTYxVF1gtf3u8hkoxPa5C6nZ7hmGx2ovTNFb5oeDlPl1nT4IWdwUFDI5cu14PipCchAq/zMK7zVKU0C3PF2EWLbzNfZ68fzAHDUHh76K9fIJEARq886LJ3pbUCQcFyxFNuTqma9EUSxMF/q2bzVmIb0ffV6J0anmYvxkzfagRPg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WPVxozs_1739689489 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Feb 2025 15:04:51 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Bharata B Rao <bharata@amd.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Raghavendra K T
 <raghavendra.kt@amd.com>,  linux-mm@kvack.org,  akpm@linux-foundation.org,
  lsf-pc@lists.linux-foundation.org,  gourry@gourry.net,
  nehagholkar@meta.com,  abhishekd@meta.com,  nphamcs@gmail.com,
  hannes@cmpxchg.org,  feng.tang@intel.com,  kbusch@meta.com,
  Hasan.Maruf@amd.com,  sj@kernel.org,  david@redhat.com,
  willy@infradead.org,  k.shutemov@gmail.com,  mgorman@techsingularity.net,
  vbabka@suse.cz,  hughd@google.com,  rientjes@google.com,
  shy828301@gmail.com,  liam.howlett@oracle.com,  peterz@infradead.org,
  mingo@redhat.com,  nadav.amit@gmail.com,  shivankg@amd.com,
  ziy@nvidia.com,  jhubbard@nvidia.com,  AneeshKumar.KizhakeVeetil@arm.com,
  linux-kernel@vger.kernel.org,  jon.grimm@amd.com,
  santosh.shukla@amd.com,  Michael.Day@amd.com,  riel@surriel.com,
  weixugc@google.com,  leesuyeon0506@gmail.com,  honggyu.kim@sk.com,
  leillc@google.com,  kmanaouil.dev@gmail.com,  rppt@kernel.org,
  dave.hansen@intel.com, yuanchu@google.com
Subject: Re: [LSF/MM/BPF TOPIC] Unifying sources of page temperature
 information - what info is actually wanted?
In-Reply-To: <de31971e-98fc-4baf-8f4f-09d153902e2e@amd.com> (Bharata B. Rao's
	message of "Wed, 5 Feb 2025 11:54:05 +0530")
References: <20250123105721.424117-1-raghavendra.kt@amd.com>
	<20250131122803.000031aa@huawei.com>
	<20250131130901.00000dd1@huawei.com>
	<de31971e-98fc-4baf-8f4f-09d153902e2e@amd.com>
Date: Sun, 16 Feb 2025 15:04:48 +0800
Message-ID: <87bjv22wvj.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Bharata,

Bharata B Rao <bharata@amd.com> writes:

> On 31-Jan-25 6:39 PM, Jonathan Cameron wrote:
>> On Fri, 31 Jan 2025 12:28:03 +0000
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>> 
>>>> Here is the list of potential discussion points:
>>> ...
>>>
>>>> 2. Possibility of maintaining single source of truth for page hotness that would
>>>> maintain hot page information from multiple sources and let other sub-systems
>>>> use that info.
>>> Hi,
>>>
>>> I was thinking of proposing a separate topic on a single source of hotness,
>>> but this question covers it so I'll add some thoughts here instead.
>>> I think we are very early, but sharing some experience and thoughts in a
>>> session may be useful.
>> Thinking more on this over lunch, I think it is worth calling this
>> out as a
>> potential session topic in it's own right rather than trying to find
>> time within other sessions.  Hence the title change.
>> I think a session would start with a brief listing of the
>> temperature sources
>> we have and those on the horizon to motivate what we are unifying, then
>> discussion to focus on need for such a unification + requirements
>> (maybe with a straw man).
>
> Here is a compilation of available temperature sources and how the
> hot/access data is consumed by different subsystems:

Thanks for your information!

> PA-Physical address available
> VA-Virtual address available
> AA-Access time available
> NA-accessing Node info available
>
> I have left the slot blank for those which I am not sure about.
> ==================================================
> Temperature		PA	VA	AA	NA
> source
> ==================================================
> PROT_NONE faults	Y	Y	Y	Y
> --------------------------------------------------
> folio_mark_accessed()	Y		Y	Y
> --------------------------------------------------
> PTE A bit		Y	Y	N	N

We can get some coarse-grained AA from PTE A bit scanning.  That is, the
page is accessed at least once between two rounds of scanning.  The AA
is less the scanning interval.  IIUC, the similar information is
available in Yuanchu's MGLRU periodic aging series [1].

[1] https://lore.kernel.org/all/20221214225123.2770216-1-yuanchu@google.com/

> --------------------------------------------------
> Platform hints		Y	Y	Y	Y
> (AMD IBS)
> --------------------------------------------------
> Device hints		Y
> (CXL HMU)
> ==================================================
>
> And here is an attempt to compile how different subsystems
> use the above data:
> ==============================================================
> Source			Subsystem		Consumption
> ==============================================================
> PROT_NONE faults	NUMAB		NUMAB=1 locality based
> via process pgtable			balancing
> walk					NUMAB=2 hot page
> 					promotion
> ==============================================================
> folio_mark_accessed()	FS/filemap/GUP	LRU list activation

IIUC, Gregory is working on a patchset to promote unmapped file cache
pages via folio_mark_accessed().

> ==============================================================
> PTE A bit via		Reclaim:LRU	LRU list activation,	
> rmap walk				deactivation/demotion
> ==============================================================
> PTE A bit via		Reclaim:MGLRU	LRU list activation,	
> rmap walk and process			deactivation/demotion
> pgtable walk
> ==============================================================
> PTE A bit via		DAMON		LRU activation,
> rmap walk				hot page promotion,
> 					demotion etc
> ==============================================================
> Platform hints		NUMAB		NUMAB=1 Locality based
> (AMD IBS)				balancing and
> 					NUMAB=2 hot page
> 					promotion
> ==============================================================
> Device hints		NUMAB		NUMAB=2 hot page
> 					promotion
> ==============================================================
> The last two are listed as possibilities.
>
> Feel free to correct/clarify and add more.

---
Best Regards,
Huang, Ying


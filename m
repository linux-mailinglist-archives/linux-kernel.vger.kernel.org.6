Return-Path: <linux-kernel+bounces-198634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396228D7B7F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C51C20B48
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2936AF2;
	Mon,  3 Jun 2024 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8RO5Hhw"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73588282ED
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395591; cv=none; b=SfxaUemQkU7JU2t1EttACPBPmrdQmN8BubpHI1heoOF0MjSsOJUfBIF7Pi5CJC6JHTi9ddqMPBgicaUbl1XMxi8C7Nb0HS781h48S8cK0iaFdDtbyHODKjB0z/UTvf24rxizwsowGLozsnVZHZmgLTAWEjPo/i35cMSyFuUlKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395591; c=relaxed/simple;
	bh=Ekm6NYStvaLChzM1LSjnCHNJo+i0mvZjDH0A6+mmR1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9XRZG6agjUrmjxWGvlvKUd+1/4YOdOlOHfyRbAWbZC6j2uDRzE7MFNwHHLYJYCnyewOMsXwXrQoHPrb/7QLFTsl/bi+miQk99/xwDl1w//0jEZSc2n0tJH584W27PgyOiOs5i/KUO5y+ruIxQETcd7m3/c/zDW+dtCpA6o2kWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8RO5Hhw; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717395587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3PaakJPuHRQHe3+zIiR5vamoIk168HLWLkXlrYdn70=;
	b=R8RO5HhwU/Uftl4Qyp7mi6KWYUl8eIBjW8t26ie7X7eu9H7429ID+7bZKuQDsMocndid3p
	I57Jfwsb20tC2z7R/E5LJD0oEuPsQCZxk7tUyQP44pkeklTKqRN40hJH3jBrML0CvmN2v8
	a3ifNxVjcxAF+Lh1dStgVburb01w5f4=
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: david@redhat.com
X-Envelope-To: 21cnbao@gmail.com
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: kasong@tencent.com
Message-ID: <9de0ce63-3815-4c1a-91a2-11cb3d526672@linux.dev>
Date: Mon, 3 Jun 2024 14:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] mm: zswap: trivial folio conversions
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Kairui Song <kasong@tencent.com>
References: <20240524033819.1953587-1-yosryahmed@google.com>
 <ZlAQo0P4Z-dgVHn6@casper.infradead.org>
 <CAJD7tkaVFa24Yty=8J01OKkaFB-TDiKq1tj0GuOD2_TbU+13SQ@mail.gmail.com>
 <CAJD7tkaQQAje_jGLwnPp3xAaYcvXiXQBLHC19h=xbZwgSeVrQA@mail.gmail.com>
 <CAKEwX=NFsLA67p1+Eev9SdeTpM8yycM44N21gFzYjjEZuMyhvA@mail.gmail.com>
 <CAJD7tkYz1-nsoDrjLfNoYaKp5R5QShpzPirKWrY-PSqRtXswtg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkYz1-nsoDrjLfNoYaKp5R5QShpzPirKWrY-PSqRtXswtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/29 03:32, Yosry Ahmed wrote:
> On Tue, May 28, 2024 at 12:08 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> On Fri, May 24, 2024 at 4:13 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>
>>> On Fri, May 24, 2024 at 12:53 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>
>>>> On Thu, May 23, 2024 at 8:59 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>>>
>>>>> On Fri, May 24, 2024 at 03:38:15AM +0000, Yosry Ahmed wrote:
>>>>>> Some trivial folio conversions in zswap code.
>>>>>
>>>>> The three patches themselves look good.
>>>>>
>>>>>> The mean reason I included a cover letter is that I wanted to get
>>>>>> feedback on what other trivial conversions can/should be done in
>>>>>> mm/zswap.c (keeping in mind that only order-0 folios are supported
>>>>>> anyway).  These are the things I came across while searching for 'page'
>>>>>> in mm/zswap.c, and chose not to do anything about for now:
>>>>>
>>>>> I think there's a deeper question to answer before answering these
>>>>> questions, which is what we intend to do with large folios and zswap in
>>>>> the future.  Do we intend to split them?  Compress them as a large
>>>>> folio?  Compress each page in a large folio separately?  I can see an
>>>>> argument for choices 2 and 3, but I think choice 1 is going to be
>>>>> increasingly untenable.
>>>>
>>>> Yeah I was kinda getting the small things out of the way so that zswap
>>>> is fully folio-ized, before we think about large folios. I haven't
>>>> given it a lot of thought, but here's what I have in mind.
>>>>
>>>> Right now, I think most configs enable zswap will disable
>>>> CONFIG_THP_SWAP (otherwise all THPs will go straight to disk), so
>>>> let's assume that today we are splitting large folios before they go
>>>> to zswap (i.e. choice 1).
>>>>
>>>> What we do next depends on how the core swap intends to deal with
>>>> large folios. My understanding based on recent developments is that we
>>>> intend to swapout large folios as a whole, but I saw some discussions
>>>> about splitting all large folios before swapping them out, or leaving
>>>> them whole but swapping them out in order-0 chunks.
>>>>
>>>> I assume the rationale is that there is little benefit to keeping the
>>>> folios whole because they will most likely be freed soon anyway, but I
>>>> understand not wanting to spend time on splitting them, so swapping
>>>> them out in order-0 chunks makes some sense to me. It also dodges the
>>>> whole fragmentation issue.
>>>>
>>>> If we do either of these things in the core swap code, then I think
>>>> zswap doesn't need to do anything to support large folios. If not,
>>>> then we need to make a choice between 2 (compress large folios) &
>>>> choice 3 (compress each page separately) as you mentioned.
>>>>
>>>> Compressing large folios as a whole means that we need to decompress
>>>> them as a whole to read a single page, which I think could be very
>>>> inefficient in some cases or force us to swapin large folios. Unless
>>>> of course we end up in a world where we mostly swapin the same large
>>>> folios that we swapped out. Although there can be additional
>>>> compression savings from compressing large folios as a whole.
>>>>
>>>> Hence, I think choice 3 is the most reasonable one, at least for the
>>>> short-term. I also think this is what zram does, but I haven't
>>>> checked. Even if we all agree on this, there are still questions that
>>>> we need to answer. For example, do we allocate zswap_entry's for each
>>>> order-0 chunk right away, or do we allocate a single zswap_entry for
>>>> the entire folio, and then "split" it during swapin if we only need to
>>>> read part of the folio?
>>>>
>>>> Wondering what others think here.
>>>
>>> More thoughts that came to mind here:
>>>
>>> - Whether we go with choice 2 or 3, we may face a latency issue. Zswap
>>> compression happens synchronously in the context of reclaim, so if we
>>> start handling large folios in zswap, it may be more efficient to do
>>> it asynchronously like swap to disk.
>>
>> We've been discussing this in private as well :)
>>
>> It doesn't have to be these two extremes right? I'm perfectly happy
>> with starting with compressing each subpage separately, but perhaps we
>> can consider managing larger folios in bigger chunks (say 64KB). That
>> way, on swap-in, we just have to bring a whole chunk in, not the
>> entire folio, and still take advantage of compression efficiencies on
>> bigger-than-one-page chunks. I'd also check with other filesystems
>> that leverage compression, to see what's their unit of compression is.
> 
> Right. But I think it will be a clearer win to start with compressing
> each subpage separately, and it avoids splitting folios during reclaim
> to zswap. It also doesn't depend on the zsmalloc work.
> 
> Once we have that, we can experiment with compressing folios in larger
> chunks. The tradeoffs become less clear at that point, and the number
> of variables you can tune goes up :)

Agree, it's a good approach! And it hasn't any decompression amplification
problem.

Thanks.


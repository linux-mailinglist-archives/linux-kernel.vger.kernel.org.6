Return-Path: <linux-kernel+bounces-245339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A392B174
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF462844E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00B145A08;
	Tue,  9 Jul 2024 07:47:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69A13212D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511246; cv=none; b=MpmYg2cTbFFe9+2HidkFSsYBuCfM8ZB6cG744KiLRkXh2IKpz/8BbzDRv8GNN+kv/gJwlFfZIRMsmDsGuRIxlS3D+muAeP/Xg68/4VRzblPToCYAipnCRfu4sAnbi5/ptydePxbasbOxYTnhPRgMwvve97goz1uQlVzSiOBVL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511246; c=relaxed/simple;
	bh=LmVuBgaERFy9n8JZ3ZixfJtczNvGOM7o+N60sxo5tI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFDU9BsV8aKgfJRIP4eYkMLeM7ERrPO52qZ4JBjqsdLUIzf9v8JSUYerJxp3wGdNzdmavcSOfSR/qiasHO4+MAnuQ+yBO0p1st9aYzjSxbXaQo13042Tn+6m7nL5XbJnN9BGmq1CWFf3ChYqcUuSxe2+Evb8Bh0BNFtLglBqjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 816251042;
	Tue,  9 Jul 2024 00:47:47 -0700 (PDT)
Received: from [10.57.76.194] (unknown [10.57.76.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3FD3F641;
	Tue,  9 Jul 2024 00:47:20 -0700 (PDT)
Message-ID: <0240add9-4c56-4f66-b761-494cc2cf8fb5@arm.com>
Date: Tue, 9 Jul 2024 08:47:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
 <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
 <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
 <10b201b1-53d3-4f62-be8e-996aa95d2b99@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <10b201b1-53d3-4f62-be8e-996aa95d2b99@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/07/2024 21:50, David Hildenbrand wrote:
> On 08.07.24 14:29, Ryan Roberts wrote:
>> On 08/07/2024 12:36, Barry Song wrote:
>>> On Mon, Jul 8, 2024 at 11:24 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> The legacy PMD-sized THP counters at /proc/vmstat include
>>>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
>>>> rather confusingly refer to shmem THP and do not include any other types
>>>> of file pages. This is inconsistent since in most other places in the
>>>> kernel, THP counters are explicitly separated for anon, shmem and file
>>>> flavours. However, we are stuck with it since it constitutes a user ABI.
>>>>
>>>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
>>>> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
>>>> same "file_" prefix in the names. But in future, we may want to add
>>>> extra stats to cover actual file pages, at which point, it would all
>>>> become very confusing.
>>>>
>>>> So let's take the opportunity to rename these new counters "shmem_"
>>>> before the change makes it upstream and the ABI becomes immutable.
>>>
>>> Personally, I think this approach is much clearer. However, I recall
>>> we discussed this
>>> before [1], and it seems that inconsistency is a concern?
>>
>> Embarrassingly, I don't recall that converstation at all :-| but at least what I
>> said then is consistent with what I've done in this patch.
>>
>> I think David's conclusion from that thread was to call them FILE_, and add both
>> shmem and pagecache counts to those counters, meaning we can keep the same name
>> as legacy THP counters. But those legacy THP counters only count shmem, and I
>> don't think we would get away with adding pagecache counts to those at this
>> point? (argument: they have been around for long time and there is a risk that
>> user space relies on them and if they were to dramatically increase due to
>> pagecache addition now that could break things). In that case, there is still
>> inconsistency, but its worse; the names are consistent but the semantics are
>> inconsistent.
>>
>> So my vote is to change to SHMEM_ as per this patch :)
> 
> I also forgot most of the discussion, but these 3 legacy counters are really
> only (currently) incremented for shmem. I think my idea was to keep everything
> as FILE_ for now, maybe at some point make the pagecache also use them, and then
> maybe have separate FILE_ + SHMEM_.
> 
> But yeah, likely it's best to only have "shmem" here for now, because who knows
> what we can actually change about the legacy counters. But it's always though
> messing with legacy stuff that is clearly suboptimal ...

Sorry David, I've read your response a bunch of times and am still not
completely sure what you are advocating for.

To make my proposal crystal clear, I think we should leave the legacy counters
alone - neither change their name nor what they count (which is _only_ shmem). I
think we should rename the new mTHP counters to "shmem" and have them continue
to only count shmem. Then additionally, I think we should introduce new "file"
mTHP counters that count the page cache allocations (that's a future set of
patches, which I'm working on together with user controls to determine which
mTHP sizes can be used by page cache).

As suggested by Barry, I propose to also improve the documentation for the
legacy counters to make it clear that dispite their name being "file" they are
actually counting "shmem". I'll do this for v2.

David, would you support this approach? If so, I'd like to push this forwards
asap so that it gets into v6.11 to avoid ever exposing the mthp counters with
the "file" name.

Thanks,
Ryan





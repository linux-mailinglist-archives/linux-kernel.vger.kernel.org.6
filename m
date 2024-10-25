Return-Path: <linux-kernel+bounces-380875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5D9AF72D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A0B282FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FFE2C853;
	Fri, 25 Oct 2024 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VZYyhKog"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84B10A0E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729821373; cv=none; b=FXtn9Gwn5u5m+z8UIK411n4GH0uxO7wGCX1n3WLHZsSy29wqly4mjnV1dHn8omoK0axtXm+r/mbuF/PE2bOwq6kB5Mnlz7NfJm5D0p6afiZVM4VJzCnj1Fxm1P6oUZ0gDi6zMS71gV0zgtkWejqvkC1xaySXKktxblBfr2IBS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729821373; c=relaxed/simple;
	bh=r/MFzY3Xt1bwzG6T1Oi1IB0Snx1YQ+BS4dc4k4LV+yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRcZctpE+uNwPkoVR2GPqVUnEzYduEtY3sGrHAJvSDffm1VfvSTbvjSeTKaHTYzZ4frJpZA5XpBQZwv+gni9rNRGCkmaaQE5PjeJXWlVBTPhpVxoMFzLXY1/n+lbaK5YFu+t611cf0lxTmGWJnHeBxGLVJdHaBSJ1FcSTSmm5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VZYyhKog; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729821368; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JXc4Oh+KXKinub95ckQcMbW8B7vWBlit/eXWPuy9/uk=;
	b=VZYyhKogmTVTv1YUC2846j3WPb7CSW38Q30ayuUwvIaRF2DecNnYwFxsXQ4UT3Oz8O+3FZQJ6RJExWmVmKYZcoRUKmyM4HHzOj0/ORG2B/sbPcZVowBsejm2RdekFrxNHzt7p1yBqsZDtjOFf63BwKqWuOJ6FLBbRBTx/yZqS50=
Received: from 30.74.144.130(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHqcrzD_1729821365 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 09:56:06 +0800
Message-ID: <8c77c582-262a-4419-be9e-45ad76bfd36d@linux.alibaba.com>
Date: Fri, 25 Oct 2024 09:56:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/24 12:10, Hugh Dickins wrote:
> Recent changes are putting more pressure on THP deferred split queues:
> under load revealing long-standing races, causing list_del corruptions,
> "Bad page state"s and worse (I keep BUGs in both of those, so usually
> don't get to see how badly they end up without).  The relevant recent
> changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> improved swap allocation, and underused THP splitting.
> 
> The new unlocked list_del_init() in deferred_split_scan() is buggy.
> I gave bad advice, it looks plausible since that's a local on-stack
> list, but the fact is that it can race with a third party freeing or
> migrating the preceding folio (properly unqueueing it with refcount 0
> while holding split_queue_lock), thereby corrupting the list linkage.
> 
> The obvious answer would be to take split_queue_lock there: but it has
> a long history of contention, so I'm reluctant to add to that. Instead,
> make sure that there is always one safe (raised refcount) folio before,
> by delaying its folio_put().  (And of course I was wrong to suggest
> updating split_queue_len without the lock: leave that until the splice.)
> 
> And remove two over-eager partially_mapped checks, restoring those tests
> to how they were before: if uncharge_folio() or free_tail_page_prepare()
> finds _deferred_list non-empty, it's in trouble whether or not that folio
> is partially_mapped (and the flag was already cleared in the latter case).
> 
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


Return-Path: <linux-kernel+bounces-438742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA59EA500
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A1D188C1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652821AB6EB;
	Tue, 10 Dec 2024 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tYWVnQ9C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE121946DA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796822; cv=none; b=Cc+oWdWJCgzrXCzol2/yPMcHePm7nNQRtiGINmJmP2IyhGh3s1HJX6lAw43mV/B3LT3jx0GFOR3WEExMdKQAfnSiymsXYFRpAojhCIbMqv/kCOyI3XOHGH6/ESGWvJlpF6JuGC5NbQz3mNA4XV0S1So1Ojzv2E9ZtLxZhK4Vnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796822; c=relaxed/simple;
	bh=s8TsEXLk5GYzWiDhxeyW9VxsXHL8Vz6xHCPfgyYaH4k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CA370H2sUvi48ie3LoIRVpOObaXnQDoEz2SWRQApU26QXSH2Mmg+bZ3s1NG1rinE9TqXM8+1Tt9RvfPYbbaAjGnBkbXJNOFJDUIyj341X2gsLu51IKD14sUQ19YRwxmJqlgFkmqbri98e1gcu1vUojsXRWffkzzzWCYtwp8qdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tYWVnQ9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD679C4CED1;
	Tue, 10 Dec 2024 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733796822;
	bh=s8TsEXLk5GYzWiDhxeyW9VxsXHL8Vz6xHCPfgyYaH4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYWVnQ9CHiMw/bDqgGakrnStNwtUnKGUuYPE13lVl8ZXk6jP4NHEXjuIyV2N5zSmG
	 JlesNqkEktuba8vuFgxMLGnZFSoQf7QYJChXjyYxZbGrEJCrpMonb5hjqEYP/yAe/p
	 /g3h7k24dCdvD8vcvyApC8eGvJRpRWMrr//8A7M8=
Date: Mon, 9 Dec 2024 18:13:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mhocko@suse.com, hannes@cmpxchg.org, yosryahmed@google.com,
 yuzhao@google.com, david@redhat.com, willy@infradead.org,
 ryan.roberts@arm.com, baohua@kernel.org, 21cnbao@gmail.com,
 wangkefeng.wang@huawei.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com, xieym_ict@hotmail.com
Subject: Re: [PATCH v4 0/1] mm: vmascan: retry folios written back while
 isolated for traditional LRU
Message-Id: <20241209181341.fb579d7c0f9d76ae7854c4fa@linux-foundation.org>
In-Reply-To: <20241209083618.2889145-1-chenridong@huaweicloud.com>
References: <20241209083618.2889145-1-chenridong@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 08:36:17 +0000 Chen Ridong <chenridong@huaweicloud.com> wrote:

> The commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back
> while isolated") only fixed the issue for mglru. However, this issue
> also exists in the traditional active/inactive LRU. Fix this issue
> in the same way for active/inactive lru.
> 
> What is fixed:
> The page reclaim isolates a batch of folios from the tail of one of the
> LRU lists and works on those folios one by one.  For a suitable
> swap-backed folio, if the swap device is async, it queues that folio for
> writeback.  After the page reclaim finishes an entire batch, it puts back
> the folios it queued for writeback to the head of the original LRU list.
> 
> In the meantime, the page writeback flushes the queued folios also by
> batches.  Its batching logic is independent from that of the page reclaim.
> For each of the folios it writes back, the page writeback calls
> folio_rotate_reclaimable() which tries to rotate a folio to the tail.
> 
> folio_rotate_reclaimable() only works for a folio after the page reclaim
> has put it back.  If an async swap device is fast enough, the page
> writeback can finish with that folio while the page reclaim is still
> working on the rest of the batch containing it.  In this case, that folio
> will remain at the head and the page reclaim will not retry it before
> reaching there.

For a single patch series I think it's best to just make it a single
patch!  No need for a [0/n]: just put all the info into the patch's
changelog.

The patch doesn't apply to current development kernels.  Please check
the mm-unstable branch of
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/, or
linux-next.

Please replace vmascan with vmscan in the title.


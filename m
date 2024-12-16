Return-Path: <linux-kernel+bounces-446859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA019F2A37
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A22E164CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D71C5480;
	Mon, 16 Dec 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0HwM1quH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023DF9D6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330944; cv=none; b=gzTdMldJPCjVXRSLysT+pYbL3J+PXxB1IEHW9/4lwRp5jG6O6oanvewI55HjJrUhP04qWNN2wjszPvGZLiQlP0z/HLwolgdv5NlD8ahCc1OSTHijGnJxEfh/P5RdSALLx5FteqJAK2VLv6b8tNMjVwD9qcxMiSzZMzUSlwaG73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330944; c=relaxed/simple;
	bh=Lbq/tIiJrkI229WkLrQBi+b5QleLmlBhzxRfSpG84qY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PAozMNmD624MDwXXAD7E0bO2r2c/8qNa1vxlQ6Do4xmByqc1hR0BaO89n2pjFRdz8D7xxiV8CIWWewzb29/mqH5JAB8Lwd3m4Wi1kRSFGOh6oQ+SnRKe7PQ+wfJHSFeVCUcBc8fSVcUzWzwzT9XzZ9aRcgoQDyoZe1dCsYEmnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0HwM1quH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04956C4CED0;
	Mon, 16 Dec 2024 06:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734330943;
	bh=Lbq/tIiJrkI229WkLrQBi+b5QleLmlBhzxRfSpG84qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0HwM1quHf0A5fUdjqjlnqbvUrcOwBwwHb6nk7e5wXsfoRDcimJWjxuaLZZ//sl8PE
	 QSnk1+UKFCHvQpKGL3GL3+l4fKTFyUKL8XzJ+RM9Q6yQa2nRu0BsTDJsBX4TmbZs69
	 hHKsGpfWBZVhnxACrueF9qINd9E5ZPm1mSkciTE8=
Date: Sun, 15 Dec 2024 22:35:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Yu Zhao <yuzhao@google.com>, peterz@infradead.org, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] Revert "mm: pgtable: make ptlock be freed by RCU"
Message-Id: <20241215223542.2b8e45a7d68f6ebc71b5ce3a@linux-foundation.org>
In-Reply-To: <eef6abd4-327b-4f7c-8b3f-b2552fa78952@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
	<1fdb3ee32e6958ad82229941b2213ef76b7c4705.1734164094.git.zhengqi.arch@bytedance.com>
	<CAOUHufaKRXJA=vZucoJMmgQw264LSxWuTtNcFQMLD7UNz_6wyw@mail.gmail.com>
	<18bc52f4-ab02-495f-8f8f-87f69ea5b914@bytedance.com>
	<20241215221015.a567dbf38c9a98d672aecd3e@linux-foundation.org>
	<eef6abd4-327b-4f7c-8b3f-b2552fa78952@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 14:15:35 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Hi Andrew,
> 
> On 2024/12/16 14:10, Andrew Morton wrote:
> > On Sun, 15 Dec 2024 14:29:38 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > 
> >>>
> >>> Acked-by: Yu Zhao <yuzhao@google.com>
> >>
> >> Thanks! Once the review of this patch series is completed, we can simply
> >> drop "mm: pgtable: make ptlock be freed by RCU" from mm tree.
> > 
> > Can we drop it now and does the remainder of the series "synchronously
> > scan and reclaim empty user PTE pages v4" remain valid and useful?
> 
> The "mm: pgtable: make ptlock be freed by RCU" fixes the UAF issue [1]
> reported by syzbot. If it is dropped now and this patch series is not
> merged, the UAF issue will reappear.
> 
> [1]. 
> https://lore.kernel.org/lkml/67548279.050a0220.a30f1.015b.GAE@google.com/

OK, so as I understand it,

- the series "synchronously scan and reclaim empty user PTE pages v4"
  exposes a use-after-free bug, and fixes that bug with the patch "mm:
  pgtable: make ptlock be freed by RCU".

- The series "move pagetable_*_dtor() to __tlb_remove_table()" fixes
  that bug in a more desirable way.

- So when the series "move pagetable_*_dtor() to
  __tlb_remove_table()" is merged into mm-unstable, I drop the patch
  "mm: pgtable: make ptlock be freed by RCU".

Correct?


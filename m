Return-Path: <linux-kernel+bounces-398968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98B89BF8A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C9CB21755
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601320CCEF;
	Wed,  6 Nov 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nqfTyFvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D01CF2A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929487; cv=none; b=loMYgdBPoDj3hkFuQcbsQ6XzqkFDYYwRg0XXLGpr3if9G/SFz5/tsNNR7f1BvjNodORyNT+1db9dz5/bC1ZmUzkq7R0C6zXiHRAdrZ9hO5Xm7tq6rGhw3Dnlmef9tM6qn3bUYT/ywTgjrEbr5BKrKJh+LqH+ry/I2wN3he6QEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929487; c=relaxed/simple;
	bh=Jk69uuIZIlC/VrdhdkQeZ8y3KBI1zh2bkeTXN/BasrU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tXMk+xAGqXjAJ00q17QupUvqNMe0H4tndiLbw6xAa5IPFHAeoPbQUHnSwkm+gsdWu+LEzH3VOnw4k9bpdpmd99t+madnf96vlFWitYfoi4zXn0ScT1KU5JaJ1dgjRZaF2+eQiWyKXJmKd+rPBJV5FleoaQX94t9osmQAoWkDBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nqfTyFvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC17C4CEC6;
	Wed,  6 Nov 2024 21:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730929487;
	bh=Jk69uuIZIlC/VrdhdkQeZ8y3KBI1zh2bkeTXN/BasrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nqfTyFvbYj+uzZfPFM2Cisv6TcVZpdYOz5ZJadwlmDUJ/gmnS8oMYmvdMuiNSxbtE
	 N18nPXuopDhCf+uMWzzzdMQ/KBJp9aVUUnit0UFXzbGQpt+kz4fTdTxRlg5oQ3RkzX
	 eA/jxXxWnaHwF1J8U+oQptp3tYCu7xAdRnbCJCVE=
Date: Wed, 6 Nov 2024 13:44:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Nhat Pham
 <nphamcs@gmail.com>, Usama Arif <usamaarif642@gmail.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, Hailong
 Liu <hailong.liu@oppo.com>, David Hildenbrand <david@redhat.com>, Hugh
 Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Shakeel
 Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and
 swapin
Message-Id: <20241106134446.aaadc57a2a88c9efe899c838@linux-foundation.org>
In-Reply-To: <CAGsJ_4xoHbg+6CtGhC7dPePPC44OMH8azQsOWMEJnXpCQs=bDQ@mail.gmail.com>
References: <20241105211934.5083-1-21cnbao@gmail.com>
	<20241106150631.GA1172372@cmpxchg.org>
	<CAGsJ_4zYiRzG6mBnW-2wh7YCo_PJQc7u1syd05DNdic7MaE7Zw@mail.gmail.com>
	<20241106124225.632b42c3680cae0b940d2871@linux-foundation.org>
	<CAGsJ_4xoHbg+6CtGhC7dPePPC44OMH8azQsOWMEJnXpCQs=bDQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 7 Nov 2024 10:00:47 +1300 Barry Song <21cnbao@gmail.com> wrote:

> On Thu, Nov 7, 2024 at 9:42 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 7 Nov 2024 09:01:14 +1300 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > Oops, it seems that it depends on Kanchana's 'mm: change count_objcg_event() to
> > > count_objcg_events() for batch event updates,' which also isn't present in 6.12.
> > >
> > > Otherwise, it won't build, as reported here:
> > > https://lore.kernel.org/linux-mm/CAGsJ_4whD31+Lk0m2uq-o=ygvkRsw1uXcPeqxBONV-RUXkeEzg@mail.gmail.com/
> >
> > argh.
> >
> 
> Apologies for the inconvenience.
> 
> > > Hi Andrew,
> > > What’s the best approach here? Should we include Kanchana's patch that extends
> > > the nr argument for count_objcg_events() in 6.12-rc as well?
> >
> > Let's do the right thing here.  I'll drop this patch from mm-hotfixes.
> > Please send a v4 against Linus mainline fairly soon then I'll redo
> > Kanchana's series around that.
> 
> Alright. The question is whether we should integrate Kanchana's 'mm:
> change count_objcg_event() to count_objcg_events() for batch event
> updates' into 'mm: count zeromap read and set for swapout and swapin,'
> or keep it as a separate patch as patch 1/2?
> 
> I guess integration would be better, as hotfixes may not be ideal for a patch
> series?

I don't fully understand what you're asking here.

I'm suggesting that you prepare a minimal patch that fixes the bug in
Linus's kernel.  Then we figure out what to do with Kanchana's 6.13-rc1
material after the bugfix is sorted out.



Return-Path: <linux-kernel+bounces-299451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D5895D4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15010284596
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65781922C9;
	Fri, 23 Aug 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RzIKVp2l"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74B191F7D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435815; cv=none; b=F1dkAR1ggAfR5DIpjzXUMUpcRH5eM3X/cSWGDppCmYNUsNOil5Rnq7rWt2M7NELa3RbDDGIyZ0owJ6BbdWK26iKen/B3luDB1aVl4wEpL8m+tPSD20I7tbSSJtKzxcSo3WM05FwccxjxgLVfUzCnzA2+NGXNhnPhyZ4oOcMgkhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435815; c=relaxed/simple;
	bh=VBzVAwuKH3+gjLqgTGuBToxhf5P7iitEPvAXj/30XTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp/2svKwEY9PH2HKGV062FPW4U97ZGOOiPn0XxSWRoncOBeuIaetUB+5EUGDH5poT9O0uKsc9H6fQ+qZzYRQu+Liu+s2sLqer2P1ouSXHUTo8mSRZPy6g5c2uxEdcJzjJLopyQxGqXAHLDCgYBdKLrZBCrZ3f37ltFd1TmYqk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RzIKVp2l; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 Aug 2024 10:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724435810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=un5k90vrbN5RPrqbHK8kokOeMqPyoW5VK7qLx4GdDLA=;
	b=RzIKVp2lSda6MKYMug//blydJHWrCxPVCiU1LWPBGEJ92gxsN6wp82o9lw4SBRfN3JlW8P
	Zxnl/ADb0DfX+2Gfr5m9BICh4TKpC2WchF0QEtrTZ9y3gbFON2/dNiUpUnou3B7cw0lrav
	8icY6fHth+MNPBkAEm3R4DlYAVO7gEU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Barry Song <21cnbao@gmail.com>
Cc: hanchuanhua@oppo.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, 
	ryan.roberts@arm.com, senozhatsky@chromium.org, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, hch@infradead.org, ryncsn@gmail.com
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
Message-ID: <i6jki2zocqzsjcjgraf6lyl7m3cjzv5lnsuluq5xnvznw7bsge@4easx2ucpxml>
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
 <20240821074541.516249-3-hanchuanhua@oppo.com>
 <qim6ug5d3ibrn6mgrk7oybml7qatgw654y2t6wlc25pnpddr2i@yniwf64alx23>
 <CAGsJ_4wgC+yaCYinv8FYm9RHJfT5wiFxHMn_WTGysdpiH0HS7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wgC+yaCYinv8FYm9RHJfT5wiFxHMn_WTGysdpiH0HS7g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Barry,

On Thu, Aug 22, 2024 at 05:13:06AM GMT, Barry Song wrote:
> On Thu, Aug 22, 2024 at 1:31 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, Aug 21, 2024 at 03:45:40PM GMT, hanchuanhua@oppo.com wrote:
> > > From: Chuanhua Han <hanchuanhua@oppo.com>
> > >
> > >
> > > 3. With both mTHP swap-out and swap-in supported, we offer the option to enable
> > >    zsmalloc compression/decompression with larger granularity[2]. The upcoming
> > >    optimization in zsmalloc will significantly increase swap speed and improve
> > >    compression efficiency. Tested by running 100 iterations of swapping 100MiB
> > >    of anon memory, the swap speed improved dramatically:
> > >                 time consumption of swapin(ms)   time consumption of swapout(ms)
> > >      lz4 4k                  45274                    90540
> > >      lz4 64k                 22942                    55667
> > >      zstdn 4k                85035                    186585
> > >      zstdn 64k               46558                    118533
> >
> > Are the above number with the patch series at [2] or without? Also can
> > you explain your experiment setup or how can someone reproduce these?
> 
> Hi Shakeel,
> 
> The data was recorded after applying both this patch (swap-in mTHP) and
> patch [2] (compressing/decompressing mTHP instead of page). However,
> without the swap-in series, patch [2] becomes useless because:
> 
> If we have a large object, such as 16 pages in zsmalloc:
> do_swap_page will happen 16 times:
> 1. decompress the whole large object and copy one page;
> 2. decompress the whole large object and copy one page;
> 3. decompress the whole large object and copy one page;
> ....
> 16.  decompress the whole large object and copy one page;
> 
> So, patchset [2] will actually degrade performance rather than
> enhance it if we don't have this swap-in series. This swap-in
> series is a prerequisite for the zsmalloc/zram series.

Thanks for the explanation.

> 
> We reproduced the data through the following simple steps:
> 1. Collected anonymous pages from a running phone and saved them to a file.
> 2. Used a small program to open and read the file into a mapped anonymous
> memory.
> 3.  Do the belows in the small program:
> swapout_start_time
> madv_pageout()
> swapout_end_time
> 
> swapin_start_time
> read_data()
> swapin_end_time
> 
> We calculate the throughput of swapout and swapin using the difference between
> end_time and start_time. Additionally, we record the memory usage of zram after
> the swapout is complete.
> 

Please correct me if I am wrong but you are saying in your experiment,
100 MiB took 90540 ms to compress/swapout and 45274 ms to
decompress/swapin if backed by 4k pages but took 55667 ms and 22942 ms
if backed by 64k pages. Basically the table shows total time to compress
or decomress 100 MiB of memory, right?

> >
> > > [2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/
> >
> 
> Thanks
> Barry


Return-Path: <linux-kernel+bounces-266012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF893F92F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69B928332B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B5156665;
	Mon, 29 Jul 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CnIwwmfG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD81487D6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266031; cv=none; b=WWIXuG2GJ/2HeavJ4bea/S7y3MqEDMmguUoeUYSOFJIQL5aK3X7VQjbymL8cUFbZENKowMUubhSXBDBqlrDmoTS3620WVj7fyunT8K9QSqfMeGvrzqyqGI3tdDPyMvCyvmeByH1MJw6/zCLWrx7mt8xDwchq7oLqqUpQ0usLLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266031; c=relaxed/simple;
	bh=rcVkKiJ/fJw5qPqS96CmmskeuFIgVhHTX6kafHdKMnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2QkUadDeTiYdB11kOJia0DNxeWtgOW+Jmbh2X0BWehSBvRupf1GdIwEBMkOq1paL9in4qVkXXXE/1Ye6SrgYvh4zfsrl+HKOA7nuu1Nj9IWIHBUS8sIpB1rjgC2Son5oL1Y4KCD4Gesh7jNPIDmMashWw0PGbRmaC9ub2QrYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CnIwwmfG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OfSA4+9/J6ynfT9ZfDkV87nJ93qqwf5Oh6tfXnWAcpY=; b=CnIwwmfG5LggerkaIWlhBj959l
	WhcYzovUSNzfIc8144IbeWoDghRSwlF2BfN37UP2mH1phbwyFbsBbszTY7MocEts6cNgPbXRez/fy
	1+FdGowgrrW3KhxuYwG2/EMsa0QQXgkoWl2oJ0ViItbP28ckR7FyXyk7n9DuyXI2dc5sTGQQLsgQk
	Qf8TL0/UATYFv12+IJ+tnZxWrieH0h27TqGmI0tqzeCNZq6PqI5Ol/s2oyDAnfR5QWBO16+SvUh4+
	mzUvV4o78rPjE1zEaMVGO+xF7epvtlDccTKHzF98ogqwBt/mvzBzWUX3lGv2sJh5XPhA+8zUfLBPZ
	yO15UZ+A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYS40-0000000DheT-3lMm;
	Mon, 29 Jul 2024 15:13:28 +0000
Date: Mon, 29 Jul 2024 16:13:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, yosryahmed@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
Message-ID: <ZqexmNIc00Xlwy2c@casper.infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org>
 <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
 <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com>
 <ZqePwtX4b18wiubO@casper.infradead.org>
 <CAGsJ_4zXfYT4KxBnLx1F8tpK-5s6PX3PQ7wf7tteuzEyKS+ZPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zXfYT4KxBnLx1F8tpK-5s6PX3PQ7wf7tteuzEyKS+ZPQ@mail.gmail.com>

On Tue, Jul 30, 2024 at 01:11:31AM +1200, Barry Song wrote:
> for this zRAM case, it is a new allocated large folio, only
> while all conditions are met, we will allocate and map
> the whole folio. you can check can_swapin_thp() and
> thp_swap_suitable_orders().

YOU ARE DOING THIS WRONGLY!

All of you anonymous memory people are utterly fixated on TLBs AND THIS
IS WRONG.  Yes, TLB performance is important, particularly with crappy
ARM designs, which I know a lot of you are paid to work on.  But you
seem to think this is the only consideration, and you're making bad
design choices as a result.  It's overly complicated, and you're leaving
performance on the table.

Look back at the results Ryan showed in the early days of working on
large anonymous folios.  Half of the performance win on his system came
from using larger TLBs.  But the other half came from _reduced software
overhead_.  The LRU lock is a huge problem, and using large folios cuts
the length of the LRU list, hence LRU lock hold time.

Your _own_ data on how hard it is to get hold of a large folio due to
fragmentation should be enough to convince you that the more large folios
in the system, the better the whole system runs.  We should not decline to
allocate large folios just because they can't be mapped with a single TLB!



Return-Path: <linux-kernel+bounces-264901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845F993E9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302B6B20FEA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4A67711E;
	Sun, 28 Jul 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GpegNqVG"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734C3EA9B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206140; cv=none; b=hjCF/3mcrJaVMT4DNrSBk+OIONndLG5P3IouBrU1ieLmYYBicBdMJ5cu9TRkH5ugHahtT/4THo8Wwsa4AWFBoo21Xk8OPQ66201AdwuXd13PEtfIf09SwZZgpz/XWgwq88o+ZQ6bWJdLKDD2y4FgsR0vxWO0YCFB/Cq1YuqvHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206140; c=relaxed/simple;
	bh=ZK0uMwfu0ast25eit37JCIGf7oqJLdGPXD7DBQTF/VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phk5YdF9ZEiTfw0JG2onBvQHfhYX1+llz97kPgwY4StrX2mtogjxhYRu6B2WkaGy6hGPlqy3H9wfdOVEDjlssyKmhj2xXOvVG8h/Riz3Bh7pH87YywSo0VjuIvMvTeXcgsdR2jIEdcBuUWi9kLpiZnRClukQbWfBDbGzhCWfVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GpegNqVG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722206130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P9/Y+mej2So4jx4de2w01BkC1NpRz5XlWcJk7/0wxTY=;
	b=GpegNqVGoWyWaMwjMaX6jIB2lpGMxARlrZAxLDPZKCs6KUqnzcGFsFCtJYNom3dJ5lEeZat3Q6ErtM99J+kEhYEQ5MsSr7nfsQYpL5DPlIlf85FrvyQ15FdpQmBi6/oJG2W4eWyXTgbi4S+5uAqSlgZJ3q5VIwte48ubX0wORQQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WBSCAoQ_1722206126;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBSCAoQ_1722206126)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 06:35:29 +0800
Message-ID: <47dd353a-754c-4ded-a9bb-11f8400ac3fe@linux.alibaba.com>
Date: Mon, 29 Jul 2024 06:35:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
To: Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <20240728125005.c1171fa2d1beb6c1fe867d48@linux-foundation.org>
 <Zqa1ZZrrlp5jHElW@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Zqa1ZZrrlp5jHElW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/7/29 05:17, Matthew Wilcox wrote:
> On Sun, Jul 28, 2024 at 12:50:05PM -0700, Andrew Morton wrote:
>> On Sun, 28 Jul 2024 23:49:13 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>> Currently, migrate_pages_batch() can lock multiple locked folios
>>> with an arbitrary order.  Although folio_trylock() is used to avoid
>>> deadlock as commit 2ef7dbb26990 ("migrate_pages: try migrate in batch
>>> asynchronously firstly") mentioned, it seems try_split_folio() is
>>> still missing.
>>
>> Am I correct in believing that folio_lock() doesn't have lockdep coverage?
> 
> Yes.  It can't; it is taken in process context and released by whatever
> context the read completion happens in (could be hard/soft irq, could be
> a workqueue, could be J. Random kthread, depending on the device driver)
> So it doesn't match the lockdep model at all.
> 
>>> It was found by compaction stress test when I explicitly enable EROFS
>>> compressed files to use large folios, which case I cannot reproduce with
>>> the same workload if large folio support is off (current mainline).
>>> Typically, filesystem reads (with locked file-backed folios) could use
>>> another bdev/meta inode to load some other I/Os (e.g. inode extent
>>> metadata or caching compressed data), so the locking order will be:
>>
>> Which kernels need fixing.  Do we expect that any code paths in 6.10 or
>> earlier are vulnerable to this?
> 
> I would suggest it goes back to the introduction of large folios, but
> that's just a gut feeling based on absolutely no reading of code or
> inspection of git history.

According to 5dfab109d519 ("migrate_pages: batch _unmap and _move"),
I think it's v6.3+.

Yet I don't have more time to look info all history of batching
migration, hoping Huang, Ying could give more hints on this.

Thanks,
Gao Xiang



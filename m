Return-Path: <linux-kernel+bounces-417010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5409E9D4D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1461F215C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089551D5ADE;
	Thu, 21 Nov 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dzgLQKAD"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02781369B4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732195094; cv=none; b=GCycB1klEe3Mm8HamIPLmcZ6J16QvX5NIZ3uo6OvuRJ5iZB95XHnh0JplqM2G5mhO1bQG/fOd95n554nIV2n2jvZO8le1bcvPoUy+/Q1bFj8LuIZ0Reo2YLmLrxEkdYzurgOZnzVomKZc68mDpP7VPbeoXq4TOPhKxxwgCXKXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732195094; c=relaxed/simple;
	bh=15i1WktIl2KSpKfkj8m8R2HteoZW8sYnp0iJQN5NkTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYuKUSj42cCYIGNXo85siTQDNcEGjSa3ClvwU9GrirjKsO8ThHU1cGEAffZKpIZ7LoqEZDIiNVglAenjfCjkoNckwoQ/1GCeFG2yeLFSL/pFKLoyoD0mbE805p5mWqn3Ga/QL/+SnwgmehQM2iKoMtTYaCTtmIeemJzagKr9jWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dzgLQKAD; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732195083; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4/4L/e3c2lZHi8VYGOvKz5ppJseHg1VEkeDC1yE+jks=;
	b=dzgLQKADr5UtwyVYkX8Yu9r5H1uv5h/GZA4M+ZT103OaG8b6xIto0yURhM+orZz8VuEf5R+J2OsOX/zLc4P40rsPmq2zXvLB45fk1HvBZF3vwX6VaU843BwuJVSFE/g4IAMcaGI+fqGaMaxIM7hDKox8tcEAdpDuDa+Sfji7Byo=
Received: from 30.244.109.101(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJxBgwA_1732195081 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Nov 2024 21:18:02 +0800
Message-ID: <b8681f80-f2c5-44a0-b306-9f566dad65a6@linux.alibaba.com>
Date: Thu, 21 Nov 2024 21:18:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>, Christoph Hellwig <hch@lst.de>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
 <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
 <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com>
 <CAJuCfpEBs3R8C910eiaXcSMPPrtbMjFLNYzYdPGJG+gw4WHM8A@mail.gmail.com>
 <20241121045109.GA20615@lst.de>
 <CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=+cbUBP2tZO-kEcyoMA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=+cbUBP2tZO-kEcyoMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Max!

On 2024/11/21 16:43, Max Kellermann wrote:
> On Thu, Nov 21, 2024 at 5:51 AM Christoph Hellwig <hch@lst.de> wrote:
>> Something seems to be going wrong here, though, but the trace below
>> doesn't really tell me anything about the workload or file system
>> used, and if this is even calling into readahead.
> 
> In case you were asking :-) these are web servers (shared webhosting),
> running PHP most of the time. The host itself runs on an ext4, but I
> don't think the ext4 system partition has anything to do with this.
> PHP runs in containers that are erofs, the PHP sources plus
> memory-mapped opcache files are in btrfs (read-only snapshot) and the
> runtime data is on NFS or Ceph (there have been stalls on both server
> types).
> My limited experience with Linux MM suggests that this happens during
> the page fault of a memory mapped file. PHP processes usually mmap
> only files from erofs and btrfs.
> The servers are always somewhat under memory pressure; our container
> manager keeps as many containers alive as possible and only shuts them
> down when the server reaches the memory limit. At any given time,
> there are thousands of containers.

Just saw this. I guess your _recent_ 6.11.9 bug is actually
related to EROFS since EROFS uses readahead_expand().  I think
your recent report was introduced by a recent backport fix
commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.11.9&id=9cfa199bcbbbba31cbf97b2786f44f4464f3f29a

bio can be NULL after this patch and causes
unbalanced psi_memstall_{enter,leave}().  It can be fixed as
(the diff below could be damaged due to my email client):

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 01f147505487..19ef4ff2a134 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1792,9 +1792,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
                         erofs_fscache_submit_bio(bio);
                 else
                         submit_bio(bio);
-               if (memstall)
-                       psi_memstall_leave(&pflags);
         }
+       if (memstall)
+               psi_memstall_leave(&pflags);

         /*
          * although background is preferred, no one is pending for submission.

But your original report is without the very recent
commit 9e2f9d34dd12, before this commit bio cannot
be NULL so I don't think they are the same issue.

I will submit a formal fix for the recent bug later,
thanks!

Thanks,
Gao Xiang



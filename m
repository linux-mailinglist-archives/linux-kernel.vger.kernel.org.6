Return-Path: <linux-kernel+bounces-188331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81168CE095
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18960B221E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B35FB8A;
	Fri, 24 May 2024 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="mUKc34Uw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80C39FD0
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528276; cv=none; b=uz0Dxvm7DKzhikSi7Dc/90LoO2aCfkgw59wpi8YUzCM1GWiQ+F0lNQpPHJq6KURU2u5Av8GPhmJxBy48pWAJE4r9iInlkqB63hAgX1iWMzNZLGxipWTfda4jDa8xF/OA/G6xknilzSv9q8vTDydthjrkotWI1zA+ALX8XJG84oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528276; c=relaxed/simple;
	bh=WNvFZcVJoZwOnhGCpX6HD7eYMpDa41RHwTdkoBeiEzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7XA6sUF7i5WR7vxpFhAGSd6UpIMvRf3hg6Ci+b1i370Cppu6woG2BYnn7Ayj16zwGIeIz5reACRUeo5s6XWeHbrS5x1QfnYMylUlABixgum3tsVpXvP139BxF2xAhKMZhSEjhNKNn+pfCvuS3RI7xOUmGJYgY5DrTKX4ozL/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=mUKc34Uw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-663d2e6a3d7so2151462a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716528273; x=1717133073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dIV5RE5g4iad/Y9kEiDw/i3UIuirpCFKtvdMSetkisA=;
        b=mUKc34UwniTPd5RsehlGNMiULcSZ2TgHy3eO2NLWT2m7mj9slJSR3HeBWbl16qzbmO
         dFJXW+iN/ZfnTzKzXo912OilBDxmukpTGihaerLGqsVKHpbRT1TPKY6kMbBdL7MtKZen
         NNwbVjVKtm2JmXJY+1EE2feuLCFnlSwktiPWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716528273; x=1717133073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIV5RE5g4iad/Y9kEiDw/i3UIuirpCFKtvdMSetkisA=;
        b=tuS2K2BNXk+6WlB4kmZfKluoQ0L/P9mlZLGWRM3zGEyXkDexgVStaUt6SDFV5lj9T2
         3bmypwm/+I29BVJszrDeGSJWORmOHZR8BxHSqV5YzAsueKlIjfIzHpO79etbYNDfFhe6
         zGfugdAwkdJb0erfeN2RilSILlaqcK+KACG0NH2TRLNYxwHCS2BAnk+0P9pzNrSK9R+s
         6UdkWCuLwAJa79mWxCNNfa9eXoGfFjTexllblwObJwRrsbDOn+Pfr8QJmDs1BHen6Cj0
         oa1cLi+d49GLvcnrYWjNz8PgvOXWp8TnkDcoql3qsWvnTvR/tEtOL161WFQ2hAiCY4eU
         in4g==
X-Forwarded-Encrypted: i=1; AJvYcCVvspeOXBmp13rRS5z7fPXvqS5qqvj8daPWyRD88F/6QNWzbwGYCwvmJ5HKuVx+bzaWm48Oc2QJ1UyLflQSPRLnsfWYLpxUhnt7DhMc
X-Gm-Message-State: AOJu0YzI3uUPiLO4FRvttW4oWsBZ7ZOv4usHWsRm7YKObGnQRPYTPn0Q
	wt9yuhC2OD+Vl9hBD2jq/VM35NhH8du/L5EHzyisRsFdU7hL0SRf2T3r3exbvx3yKWbgaIR09hw
	ChP4=
X-Google-Smtp-Source: AGHT+IGC0OeejHOahOcls4+0SSq+j0qs0QDYYujqimaD7K7PmQNUXYf5rNmSGHvF6o4treKv5WkUvQ==
X-Received: by 2002:a17:902:d4c4:b0:1f4:5072:e094 with SMTP id d9443c01a7336-1f45072e339mr7589545ad.9.1716528272832;
        Thu, 23 May 2024 22:24:32 -0700 (PDT)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9b87b4sm5121745ad.264.2024.05.23.22.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 22:24:32 -0700 (PDT)
Date: Fri, 24 May 2024 14:24:28 +0900
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] Add NUMA-aware DAMOS watermarks
Message-ID: <20240524052428.GA368050@swarm08>
References: <20240520143038.189061-1-tome01@ajou.ac.kr>
 <20240522010034.79165-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522010034.79165-1-sj@kernel.org>

On Tue, May 21, 2024 at 06:00:34PM -0700, SeongJae Park wrote:
> Hi Jonghyeon,
> 

Hi, SeongJae

> On Mon, 20 May 2024 14:30:35 +0000 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:
> 
> > Current DAMOS schemes are not considered with multiple NUMA memory nodes.
> > For example, If we want to proactively reclaim memory of a one NUMA node,
> > DAMON_RECLAIM has to wake up kdamond before kswapd does reclaim memory.
> > However, since the DAMON watermarks are based on not a one NUMA memory
> > node but total system free memory, kdamond is not waked up before invoking
> > memory reclamation from kswapd of the target node.
> > 
> > These patches allow for DAMON to select monitoring target either total
> > memory or a specific NUMA memory node.
> 
> I feel such usage could exist, but my humble brain is not clearly imagining
> such realistic usage.  If you could further clarify the exampected usage, it
> would be very helpful for me to better understand the intention and pros/cons
> of this patchset.  Especially, I'm wondering why they would want to use the
> watermark feature, rather than manually checking the metric and turning DAMON
> on/off, or feeding the metric as a quota tuning goal.
> 

The goal of this patchset is to manage each NUMA memory node
individually through DAMON. Also, the main target scheme is memory
reclaim (or demotion in tiered memory). By allowing DAMON to be managed
by each NUMA node, I expect that users can easily set up memory reclaim
for each node.

Additionally, I think that a watermark for each node is an appropriate
metric for activating DAMON_RECLAIM, because the kswapd reclaim logic
also follows a watermark of free memory for each node.

There are two use cases. Let's assume two NUMA nodes are constructed of
32GB (node0) and 16GB (node1), respectively.

The first case is when using DAMON module. If users do not specify a
monitoring region, DAMON's module finds the biggest size of the two NUMA
memory nodes and designates it as the monitoring region (node0, 32GB).
Even if we want to enable DAMON_RECLAIM to node0, it does not work
proactively because the watermark works based on the total system memory
(48GB).

Similarly, if the users want to enable DAMON_RECLAIM to node1, users have
to manually designate the monitoring region as the address of node1.
Nonetheless, since DAMON still follows the default watermark
(total memory, 48GB), proactive reclaim will not work properly.

Below is an example.

# echo Y > /sys/module/damon_reclaim/parameters/enabled
# cat /sys/module/damon_reclaim/parameters/monitor_region_start
4294967296 # 0x100000000
# cat /sys/module/damon_reclaim/parameters/monitor_region_end
36507222015 # 0x87fffffff

# dmesg | grep node
..
[0.012812] Early memory node ranges
[0.012813]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[0.012815]   node   0: [mem 0x0000000000100000-0x000000005e22dfff]
[0.012817]   node   0: [mem 0x000000005e62c000-0x0000000069835fff]
[0.012818]   node   0: [mem 0x000000006f2d3000-0x000000006f7fffff] 
[0.012819]   node   0: [mem 0x0000000100000000-0x000000087fffffff] < target 
[0.012825]   node   1: [mem 0x0000002800000000-0x0000002bffffffff] 
..

When we use DAMON_RECLAIM by default, DAMON_RECLAIM targets node0
memory (32GB). However, DAMON runs differently from the initial goal
because the watermark works based on the combined node0 and node1(48GB).
DAMON_LRU_SORT also faces the same situation.

The second case is when we apply DAMON to a process. If a process
allocates memory that exceeds a single NUMA node(node0), some users
could want to reclaim the cold memory of the process in that node. In my
humble opinion, the reclaim scheme(DAMOS_PAGEOUT) is effective in this
case.  Unlike the DAMON module, since DAMON monitors process memory
using a virtual address, it is hard to decide whether to enable a
DAMOS_PAGEOUT due to a lack of node memory stats. Even though we use
watermarks for DAMOS_PAGEOUT, it works the same with the above module
case (thresholds based on total memory, 48GB). To overcome this problem,
I think the dedicated watermark (for node0) can be an answer. 

> > 
> > ---
> > Changes from RFC PATCH v1
> > (https://lore.kernel.org/all/20220218102611.31895-1-tome01@ajou.ac.kr)
> > - Add new metric type for NUMA node, DAMOS_WMARK_NODE_FREE_MEM_RATE
> > - Drop commit about damon_start()
> > - Support DAMON_LRU_SORT
> > 
> > Jonghyeon Kim (3):
> >   mm/damon: Add new metric type and target node for watermark
> >   mm/damon: add module parameters for NUMA system
> >   mm/damon: add NUMA-awareness to DAMON modules
> 
> Following up to the above question, why they would want to use DAMON modules
> rather than manually controlling DAMON via DAMON sysfs interface?

IMHO, some users want to use DAMON feature without mannualy
configurating via DAMON sysfs due to complexity.  Since this patchset
can be adopted to sysfs interface, I will update supporting NUMA-aware
watermarks for sysfs interface in the next version.

Best Regards,
Jonghyeon

> 
> 
> Thanks,
> SJ
> 
> > 
> >  include/linux/damon.h     | 11 +++++++++--
> >  mm/damon/core.c           | 11 ++++++++---
> >  mm/damon/lru_sort.c       | 14 ++++++++++++++
> >  mm/damon/modules-common.h |  4 +++-
> >  mm/damon/reclaim.c        | 14 ++++++++++++++
> >  mm/damon/sysfs-schemes.c  | 35 +++++++++++++++++++++++++++++++++--
> >  6 files changed, 81 insertions(+), 8 deletions(-)
> > 
> > -- 
> > 2.34.1


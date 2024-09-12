Return-Path: <linux-kernel+bounces-325845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8110975EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D6DB23931
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38B548E0;
	Thu, 12 Sep 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O1EXxiv2"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A423A1DB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108120; cv=none; b=CZbiU1mKKugYuUC3OxncH5eytPXfrBKEqSl2LfsAdqMHllSIzTCG5tDTfM1eTVd6AiUmqOCKB9PiC7ji7nneF/aG1EzKqv2mTF7QvdJIiD53CtP9wJpr2jZsLkuc6xUSPjANIDMbUNO9PEBUV7Cm9dekUfkYyCDX5qDD7I9Lexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108120; c=relaxed/simple;
	bh=AY7t6yh868IjzJ2oFBCco6lFuCwlNNAtA3zqeFTqSOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FH0nBxSve/5f/0JxblVLA8pFLTkns3ABjHBIG7+rMeCLYmNpT1wmvHhjwY+L4BKRGEggBYpZYN9i57NwxbMyiW8nHjVx3B5U08sY78QIxk/YZSKSWMDDHpqJR6csS1bmZhzCQlphaWrGwnn5Q5XlzYbujCd47oa6UmcAOwv4ULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O1EXxiv2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=e6zkEQS3wj7QBN8oFubOcQpIMuqjGBx3aY/1Y2uIOJ4=;
	b=O1EXxiv2N3lrqcjQDxMSvhjLojapEp02LOpeNjauBi9izNpWci/dujuu5XoJPP
	7k3G/GFRqMxIKjhmDbmIwYoACRIdZpnxdYnpkxp4Yvr2fy05ILtoKQoG+T8yVYS0
	Z10wP6y2Q2FekPJfpwVjZQfW9drzmrDzh8pswYHHd5u00=
Received: from localhost.localdomain (unknown [111.35.191.143])
	by gzsmtp4 (Coremail) with SMTP id sygvCgBXJzacUeJmJglwBg--.45767S4;
	Thu, 12 Sep 2024 10:28:03 +0800 (CST)
From: David Wang <00107082@163.com>
To: kent.overstreet@linux.dev,
	surenb@google.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] Add accumulated call counter for memory allocation profiling
Date: Thu, 12 Sep 2024 10:27:40 +0800
Message-Id: <20240912022740.6125-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <koa5yyc2opu23giistqjaw3eo47gjcxpx56ekrbsbhltk74wzz@pvym4ollouzu>
References: <koa5yyc2opu23giistqjaw3eo47gjcxpx56ekrbsbhltk74wzz@pvym4ollouzu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sygvCgBXJzacUeJmJglwBg--.45767S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFW3uFWrCF17XFy8Aw1rCrg_yoW5XF1xpa
	yrt3ZrKFsxXr1ktwnIq347GFyrGw4xGr15JFsYqry7uwnxWr1Igr17tr4ruFZ2krn7JFyj
	q3yjva4293Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhYFtUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxVYqmXAnzbDTQAAsW

At 2024-07-02 05:58:50, "Kent Overstreet" <kent.overstreet@linux.dev> wrote:
>On Mon, Jul 01, 2024 at 10:23:32AM GMT, David Wang wrote:
>> HI Suren, 
>> 
>> At 2024-07-01 03:33:14, "Suren Baghdasaryan" <surenb@google.com> wrote:
>> >On Mon, Jun 17, 2024 at 8:33 AM David Wang <00107082@163.com> wrote:
>> >>
>> >> Accumulated call counter can be used to evaluate rate
>> >> of memory allocation via delta(counters)/delta(time).
>> >> This metrics can help analysis performance behaviours,
>> >> e.g. tuning cache size, etc.
>> >
>> >Sorry for the delay, David.
>> >IIUC with this counter you can identify the number of allocations ever
>> >made from a specific code location. Could you please clarify the usage
>> >a bit more? Is the goal to see which locations are the most active and
>> >the rate at which allocations are made there? How will that
>> >information be used?
>>  
>> Cumulative counters can be sampled with timestamp,  say at T1, a monitoring tool got a sample value V1,
>> then after sampling interval, at T2,  got a sample value V2. Then the average rate of allocation can be evaluated
>> via (V2-V1)/(T2-T1). (The accuracy depends on sampling interval)
>> 
>> This information "may" help identify where the memory allocation is unnecessary frequent,  
>> and  gain some  better performance by making less memory allocation .
>> The performance "gain" is just a guess, I do not have a valid example.
>
>Easier to just run perf...

Hi, 

To Kent:
It is strangely odd to reply to this when I was trying to debug a performance issue for bcachefs :)

Yes it is true that performance bottleneck could be identified by perf tools, but normally perf
is not continously running (well, there are some continous profiling projects out there).
And also, memory allocation normally is not the biggest bottleneck,
 its impact may not easily picked up by perf. 

Well, in the case of https://lore.kernel.org/lkml/20240906154354.61915-1-00107082@163.com/,
the memory allocation is picked up by perf tools though. 
But with this patch, it is easier to spot that memory allocations behavior are quite different:
When performance were bad, the average rate for 
"fs/bcachefs/io_write.c:113 func:__bio_alloc_page_pool" was 400k/s,
while when performance were good, rate was only less than 200/s.

(I have a sample tool collecting /proc/allocinfo, and the data is stored in prometheus,
the rate is calculated and plot via prometheus statement:
irate(mem_profiling_count_total{file=~"fs/bcachefs.*", func="__bio_alloc_page_pool"}[5m]))

Hope this could be a valid example demonstrating the usefulness of accumulative counters
of memory allocation for performance issues.


Thanks
David

 



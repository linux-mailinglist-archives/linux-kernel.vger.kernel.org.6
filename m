Return-Path: <linux-kernel+bounces-329632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C902A9793D8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 02:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF78B22766
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7526FDC;
	Sun, 15 Sep 2024 00:31:25 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547A4C80
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726360285; cv=none; b=AVufsps5P7IPvFTHH3adw6SI4tarbuQJBn4zubpyQKIiVY6kvVTO7IMbCH4FiJ+bnxw6Lir/9rZFOEfUjuxiuirghuqfVMHxDlypnbAJyp29NtytIypOFHgBdnIkwye1A3ZUOM7okqHDGb0gsj77O69OxFAT0Z48WgejVdAXYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726360285; c=relaxed/simple;
	bh=+aoQmbXSPoscZctWEF7wy7BJpxM5SxuSyuQszjJ1q68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObZf7XJbXQcsRCPwjYUj3WntX9NhvQ9dzy0FiVB8b57PpyYMMyZ5LMBHrop2/5xdjm5tKqmCykTfTmNgrhFRyuwRjiuqbjEPhWHt3oXDezwNLnwgFlbPcWnL5s/jWR8F9HuLkY9HDgePFleUkrnunufXsdOyBZdOI7tE2jAOX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.223])
	by sina.com (10.185.250.24) with ESMTP
	id 66E62ACC00002FE8; Sun, 15 Sep 2024 08:31:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 63931610748365
X-SMAIL-UIID: C4817436ADED4F4E96A5E582EAA9C455-20240915-083110-1
From: Hillf Danton <hdanton@sina.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Sun, 15 Sep 2024 08:30:58 +0800
Message-Id: <20240915003058.478-1-hdanton@sina.com>
In-Reply-To: <ZuEIzngSx36Gx8l/@tpad>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Sep 2024 00:04:46 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> On Fri, Sep 06, 2024 at 06:19:08AM +0800, Hillf Danton wrote:
> > On Tue, 23 Jul 2024 14:14:34 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > > On Sat, Jun 22, 2024 at 12:58:08AM -0300, Leonardo Bras wrote:
> > > > The problem:
> > > > Some places in the kernel implement a parallel programming strategy
> > > > consisting on local_locks() for most of the work, and some rare remote
> > > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > > kernels, even though the very few remote operations will be expensive due
> > > > to scheduling overhead.
> > > > 
> > > > On the other hand, for RT workloads this can represent a problem: getting
> > > > an important workload scheduled out to deal with remote requests is
> > > > sure to introduce unexpected deadline misses.
> > > 
> > > Another hang with a busy polling workload (kernel update hangs on
> > > grub2-probe):
> > > 
> > > [342431.665417] INFO: task grub2-probe:24484 blocked for more than 622 seconds.
> > > [342431.665458]       Tainted: G        W      X  -------  ---  5.14.0-438.el9s.x86_64+rt #1
> > > [342431.665488] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [342431.665515] task:grub2-probe     state:D stack:0     pid:24484 ppid:24455  flags:0x00004002
> > > [342431.665523] Call Trace:
> > > [342431.665525]  <TASK>
> > > [342431.665527]  __schedule+0x22a/0x580
> > > [342431.665537]  schedule+0x30/0x80
> > > [342431.665539]  schedule_timeout+0x153/0x190
> > > [342431.665543]  ? preempt_schedule_thunk+0x16/0x30
> > > [342431.665548]  ? preempt_count_add+0x70/0xa0
> > > [342431.665554]  __wait_for_common+0x8b/0x1c0
> > > [342431.665557]  ? __pfx_schedule_timeout+0x10/0x10
> > > [342431.665560]  __flush_work.isra.0+0x15b/0x220
> > 
> > The fresh new flush_percpu_work() is nop with CONFIG_PREEMPT_RT enabled, why
> > are you testing it with 5.14.0-438.el9s.x86_64+rt instead of mainline? Or what
> > are you testing?
> 
> I am demonstrating a type of bug that can happen without Leo's patch.
> 
> > BTW the hang fails to show the unexpected deadline misses.
> 
> Yes, because in this case the realtime app with FIFO priority never
> stops running, therefore grub2-probe hangs and is unable to execute:
> 
Thanks, I see why it is a type of bug that can happen without Leo's patch.
Because linux kernel is never the pill to kill all pains in the field, I
prefer to think instead it represents no real idea of 5.14-xxx-rt at product
designing stage - what is kernel reaction to 600s cpu hog for instance?.
More interesting, what would you comment if task hang is replaced with oom?

Given locality cut by this patchset, lock contention follows up and opens
the window for priority inversion, right?

> > > [342431.665417] INFO: task grub2-probe:24484 blocked for more than 622 seconds
> > 
> > > [342431.665565]  ? __pfx_wq_barrier_func+0x10/0x10
> > > [342431.665570]  __lru_add_drain_all+0x17d/0x220
> > > [342431.665576]  invalidate_bdev+0x28/0x40
> > > [342431.665583]  blkdev_common_ioctl+0x714/0xa30
> > > [342431.665588]  ? bucket_table_alloc.isra.0+0x1/0x150
> > > [342431.665593]  ? cp_new_stat+0xbb/0x180
> > > [342431.665599]  blkdev_ioctl+0x112/0x270
> > > [342431.665603]  ? security_file_ioctl+0x2f/0x50
> > > [342431.665609]  __x64_sys_ioctl+0x87/0xc0


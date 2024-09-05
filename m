Return-Path: <linux-kernel+bounces-317935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D496E5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4466B2867D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298E5197A68;
	Thu,  5 Sep 2024 22:19:37 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845015532A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574776; cv=none; b=FLSTgv0Crb4DT2rKMzeLNV0qmxsK0wPLxFDabpxFlF9WuobWMK7xZkZ12bXqtcUudaWse4nTe9W9OJngAuq9wX9JQs0H4QU1sBH9lSfifxOY4dazwjfy8j/QUUOHsVaKj+lp5baAW6Bj3u1R2vt45mKQ93xwKF4IoubV1julz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574776; c=relaxed/simple;
	bh=e4K+Zlryo+5KBQIm/k+5JPDSXD3T3Xmfk84F57SgRWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mwc/EBSusRIYWC/og+PJjaN2opT3ZtPXzzlfcUfyLuN1GTNXfl9Brw6VyUvOywgIIBuwaVizLmYrBHIQZtCAZp87S99Pj5MJ8+Ze4WbkoeaBLSdHPqnnVlGv+GcKfaA/vENXUWfUxPTMKaPReONNsCvoJ7Q1DVv5Gi5tQNTHJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.67])
	by sina.com (10.185.250.21) with ESMTP
	id 66DA2E65000011A1; Thu, 6 Sep 2024 06:19:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8518303408330
X-SMAIL-UIID: AC4A801E363B48AE88BEE6DFBA4036CA-20240906-061919-1
From: Hillf Danton <hdanton@sina.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Fri,  6 Sep 2024 06:19:08 +0800
Message-Id: <20240905221908.1960-1-hdanton@sina.com>
In-Reply-To: <Zp/k+rJuVV+EcXqL@tpad>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Jul 2024 14:14:34 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> On Sat, Jun 22, 2024 at 12:58:08AM -0300, Leonardo Bras wrote:
> > The problem:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with remote requests is
> > sure to introduce unexpected deadline misses.
> 
> Another hang with a busy polling workload (kernel update hangs on
> grub2-probe):
> 
> [342431.665417] INFO: task grub2-probe:24484 blocked for more than 622 seconds.
> [342431.665458]       Tainted: G        W      X  -------  ---  5.14.0-438.el9s.x86_64+rt #1
> [342431.665488] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [342431.665515] task:grub2-probe     state:D stack:0     pid:24484 ppid:24455  flags:0x00004002
> [342431.665523] Call Trace:
> [342431.665525]  <TASK>
> [342431.665527]  __schedule+0x22a/0x580
> [342431.665537]  schedule+0x30/0x80
> [342431.665539]  schedule_timeout+0x153/0x190
> [342431.665543]  ? preempt_schedule_thunk+0x16/0x30
> [342431.665548]  ? preempt_count_add+0x70/0xa0
> [342431.665554]  __wait_for_common+0x8b/0x1c0
> [342431.665557]  ? __pfx_schedule_timeout+0x10/0x10
> [342431.665560]  __flush_work.isra.0+0x15b/0x220

The fresh new flush_percpu_work() is nop with CONFIG_PREEMPT_RT enabled, why
are you testing it with 5.14.0-438.el9s.x86_64+rt instead of mainline? Or what
are you testing?

BTW the hang fails to show the unexpected deadline misses.

> [342431.665565]  ? __pfx_wq_barrier_func+0x10/0x10
> [342431.665570]  __lru_add_drain_all+0x17d/0x220
> [342431.665576]  invalidate_bdev+0x28/0x40
> [342431.665583]  blkdev_common_ioctl+0x714/0xa30
> [342431.665588]  ? bucket_table_alloc.isra.0+0x1/0x150
> [342431.665593]  ? cp_new_stat+0xbb/0x180
> [342431.665599]  blkdev_ioctl+0x112/0x270
> [342431.665603]  ? security_file_ioctl+0x2f/0x50
> [342431.665609]  __x64_sys_ioctl+0x87/0xc0


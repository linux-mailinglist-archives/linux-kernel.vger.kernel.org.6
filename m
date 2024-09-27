Return-Path: <linux-kernel+bounces-341667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0719988347
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C96F281E26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0D189901;
	Fri, 27 Sep 2024 11:26:11 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503B54738
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436370; cv=none; b=utXCoEi+zotFyDxuTBYmOwxfP2Y7ak8dFqopCkd120ZEzkxmuv9KHuRdy+euJUGsHzCwkKTx/MN0nEJ7HvpQOeFDlAKCJ/ZAqhF56KSjNpMjp3a3fD78JVro/5nYMlw9Ia9ncC6HMc81BbxfdE/YlQiMBoAWCV7khvgSamEeajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436370; c=relaxed/simple;
	bh=3Nlggbn+a3sWcQx3giHR3u+G1LcMdJHSqsAd74CVCOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqRLA93aipiaizwtSBpkxAu0UJ6NtJl15xsCNgc22FDXRiWTi9zYSpSBfM5yIKBOChhQp9ep/Bb7Ddn5B/zGabnZ8l22MMS630WyD5bHYvYL9ndhIuXe/nTU5zjQVi34xDPX7dPk9tOBQmow81MHWVhbp3IXvNOv2pkz0Ni+MzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.54])
	by sina.com (10.185.250.22) with ESMTP
	id 66F6962300005DF6; Fri, 27 Sep 2024 19:25:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1556157602641
X-SMAIL-UIID: E6BEB0D0A78B4CD2BAA73B20F7122752-20240927-192526-1
From: Hillf Danton <hdanton@sina.com>
To: Michal Koutny <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>,
	tj@kernel.org,
	cgroups@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Fri, 27 Sep 2024 19:25:16 +0800
Message-Id: <20240927112516.1136-1-hdanton@sina.com>
In-Reply-To: <4fee4fydxuxzee5cb5ehiil7g7bnhxp5cmxxgg3zszc4vx4qyc@6t2qmltutcrh>
References: <20240817093334.6062-1-chenridong@huawei.com> <20240817093334.6062-2-chenridong@huawei.com> <20240911111542.2781-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 14:53:46 +0200 Michal Koutny <mkoutny@suse.com>
> On Wed, Sep 11, 2024 at 07:15:42PM GMT, Hillf Danton <hdanton@sina.com> wrote:
> > > However, there is no ordering between (I) and (II) so they can also happen
> > > in opposite
> > > 
> > > 	thread T					system_wq worker
> > > 
> > > 	down(cpu_hotplug_lock.read)
> > > 	smp_call_on_cpu
> > > 	  queue_work_on(cpu, system_wq, scss) (I)
> > > 	  						lock(cgroup_mutex)  (II)
> > > 							...
> > > 							unlock(cgroup_mutex)
> > > 							scss.func
> > > 	  wait_for_completion(scss)
> > > 	up(cpu_hotplug_lock.read)
> > > 
> > > And here the thread T + system_wq worker effectively call
> > > cpu_hotplug_lock and cgroup_mutex in the wrong order. (And since they're
> > > two threads, it won't be caught by lockdep.)
> > > 
> > Given no workqueue work executed without being dequeued, any queued work,
> > regardless if they are more than 2048, that acquires cgroup_mutex could not
> > prevent the work queued by thread-T from being executed, so thread-T can
> > make safe forward progress, therefore with no chance left for the ABBA 
> > deadlock you spotted where lockdep fails to work.
> 
> Is there a forgotten negation and did you intend to write: "any queued
> work ... that acquired cgroup_mutex could prevent"?
> 
No I did not.

> Or if the negation is correct, why do you mean that processed work item
> is _not_ preventing thread T from running (in the case I left quoted
> above)?
>
If N (N > 1) cgroup work items are queued before one cpu hotplug work, then
1) workqueue worker1 dequeues cgroup work1 and executes it,
2) worker1 goes off cpu and falls in nap because of failure of acquiring
cgroup_mutex,
3) worker2 starts processing cgroup work2 and repeats 1) and 2),
4) after N sleepers, workerN+1 dequeus the hotplug work and executes it
and completes finally.

Clear lad?


Return-Path: <linux-kernel+bounces-393067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED29B9B83
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FC51C21240
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C239461;
	Sat,  2 Nov 2024 00:12:45 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F943EC5
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506364; cv=none; b=b/nap6R9SG9AR7hcUvi81qsq3tpJLqh7LWZ0YiXMQ1GUqixufm/23MfcjY0a0Tj6BH6wHl4pAJK7vMrHfznTDuJzY/LfCNhNJdxJzZoA63iy9bF0xd2psRtewwBH84In95EmX0v+95AKT+PTYZqUXoCOyz55LEYWGScG+V6C8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506364; c=relaxed/simple;
	bh=iiV1+9wAEjKZEDaz1gxJYnh5dJ4ftswfkEQqOnsxRHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QpeQW6g5m392BBBWPV7NbXPAfk37yBROn20rY/r3hA/fS0KCn2EQDiWm+rwIrJ8zsjyTshXXfpSWWsJr4o5A4dwgsuf4Wmg/EQwgGCQV+YT6A+e/x2nFkj6RIICi6Zq9HIRwq2rhfynk2cge2v5Ma8pJFKj/PxuH+Fm/+6wjdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.22])
	by sina.com (10.185.250.22) with ESMTP
	id 67256E6F000079BA; Sat, 2 Nov 2024 08:12:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8057817602841
X-SMAIL-UIID: BEB4F1313C68490E8849C1F0E5126FD9-20241102-081235-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com
Subject: Re: [BUG] -next lockdep invalid wait context
Date: Sat,  2 Nov 2024 08:12:24 +0800
Message-Id: <20241102001224.2789-1-hdanton@sina.com>
In-Reply-To: <20241031072136.JxDEfP5V@linutronix.de>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop> <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz> <ZyK0YPgtWExT4deh@elver.google.com> <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Oct 2024 08:21:36 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> On 2024-10-30 16:10:58 [-0700], Paul E. McKenney wrote:
> > 
> > So I need to avoid calling kfree() within an smp_call_function() handler?
> 
> Yes. No kmalloc()/ kfree() in IRQ context.
> 
Another splat [1] with no link to kmalloc()/ kfree(). 

[ BUG: Invalid wait context ]
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
-----------------------------
strace-static-x/5846 is trying to lock:
ffffffff8eac8698 (kernfs_rename_lock){....}-{3:3}, at: kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229
other info that might help us debug this:
context-{5:5}
3 locks held by strace-static-x/5846:
 #0: ffff8880b873e598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2381
 #2: ffff88802f7129e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:208 [inline]
 #2: ffff88802f7129e0 (&mm->mmap_lock){++++}-{4:4}, at: stack_map_get_build_id_offset+0x431/0x870 kernel/bpf/stackmap.c:157

[1] Subject: [syzbot] [kernfs?] WARNING: locking bug in kernfs_path_from_node
https://lore.kernel.org/lkml/67251dc6.050a0220.529b6.015e.GAE@google.com/


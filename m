Return-Path: <linux-kernel+bounces-300479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10895E42C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F151F213C3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D716F26F;
	Sun, 25 Aug 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXQhOgiA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEA16F0C1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724600643; cv=none; b=fPS7L91JVYcacfbfb/1hFFYbV95tqYWcMeziYGJphMWRilc7WQeuZWwsy8j5lGkdVwmswf9vOk++IlQ0QvIVRXM/WM8Nh2QqoYu4jWY4KUGQ0rlEdb8ybH7WiC9EZCl07H+H2UXyAKkxdjDQEO8VpIL7worjcg0/t+f8om5Izkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724600643; c=relaxed/simple;
	bh=PMqkgfMED2cbYHsOh+PA0bTcKNWj/Y4TCuMqoGdQJiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bJxNjs7TCcAoJdK55JSLQGJDBpmACBgFVv6Btrg+PsP1AwLJK3kldsx1y3CjxShPXtwOKoHyUsxduvkpBAe8p8PO0o94/ICQl0T1Mk/1PCIHPsw2IWAPCnDPVCKxL9u+nWJ8Up2lMBrT3e5YEvWzxCnbT5VOczQCaW2fdiiyyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXQhOgiA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724600640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVA4B0Wcr6frtgKcn6pu8aOxrbB/zpCqcj9AKkx9YQs=;
	b=IXQhOgiAP/9wmgaTcyKtJO5Dq3d4iT9pw2FAtykNziMwJDT34m3PKp2UfkZzIMcW6cpi07
	mN+GlfngLB9KmNhIN55rlZAHVOAt1j39yC3ltmA7NvZPKgfWyWVZXQybRQIgOTv2LIbcMK
	tpSj4ytwDdqTeTGmz73S8C8IIRRhsug=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-yKW2J1JpPWiOR6uyWyw3WA-1; Sun,
 25 Aug 2024 11:43:58 -0400
X-MC-Unique: yKW2J1JpPWiOR6uyWyw3WA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C4AA1955F65;
	Sun, 25 Aug 2024 15:43:57 +0000 (UTC)
Received: from [10.2.16.7] (unknown [10.2.16.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF1E719560AE;
	Sun, 25 Aug 2024 15:43:55 +0000 (UTC)
Message-ID: <067963b0-17be-4c4d-8485-a49cfe9da5fb@redhat.com>
Date: Sun, 25 Aug 2024 11:43:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: general protection fault in kernfs_remove_by_name_ns
To: Xingyu Li <xli399@ucr.edu>, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <CALAgD-6=bRtF++chjMwgTyMssCqyPzhXyY=zjB6w5SorVxuCcw@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CALAgD-6=bRtF++chjMwgTyMssCqyPzhXyY=zjB6w5SorVxuCcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 8/25/24 00:53, Xingyu Li wrote:
> Hi,
>
> We found a bug in linux 6.10. It is probably a null pointer dereference bug.
> The bug report is as follows, but unfortunately there is no generated
> syzkaller reproducer.
>
> netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2
> family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2
> family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2
> family 0 port 6081 - 0
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000029: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
> CPU: 0 PID: 10054 Comm: kworker/u4:29 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: netns cleanup_net
> RIP: 0010:__lock_acquire+0x106/0x8050 kernel/locking/lockdep.c:5005
> Code: 85 5d 20 00 00 83 3d 14 d2 b5 0d 00 48 89 9c 24 18 01 00 00 0f
> 84 00 10 00 00 83 3d 33 3a 31 0c 00 74 31 48 89 d0 48 c1 e8 03 <42> 80
> 3c 00 00 74 17 48 89 d7 e8 fb 9c 85 00 48 8b 54 24 10 49 b8
> RSP: 0018:ffffc9000a0bf540 EFLAGS: 00010002
> RAX: 0000000000000029 RBX: 1ffff92001417ecc RCX: 0000000000000000
> RDX: 0000000000000148 RSI: 0000000000000000 RDI: 0000000000000148
> RBP: ffffc9000a0bf808 R08: dffffc0000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801fc31e00
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc6fba84cd0 CR3: 0000000020224000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
>   down_write+0x36/0x50 kernel/locking/rwsem.c:1579
>   kernfs_remove_by_name_ns+0x76/0x150 fs/kernfs/dir.c:1689
>   del_nbp+0xa6/0xb50 net/bridge/br_if.c:338
>   br_dev_delete+0x76/0x110 net/bridge/br_if.c:386
>   br_net_exit_batch_rtnl+0xee/0x1a0 net/bridge/br.c:369
>   cleanup_net+0x712/0xcd0 net/core/net_namespace.c:633
>   process_one_work kernel/workqueue.c:3248 [inline]
>   process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
>   worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
>   kthread+0x2eb/0x380 kernel/kthread.c:389
>   ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>   </TASK>

I don't believe it is a bug in the locking code.

> RIP: 0010:__lock_acquire+0x106/0x8050 kernel/locking/lockdep.c:5005

5005         if (!prove_locking || lock->key == &__lockdep_no_validate__)

This crash is likely caused by passing in an incorrect rw_semaphore pointer.

> kernfs_remove_by_name_ns+0x76/0x150 fs/kernfs/dir.c:1689

1676 int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char 
*name,
1677                              const void *ns)
1678 {
   :
1688         root = kernfs_root(parent);
1689         down_write(&root->kernfs_rwsem);

> del_nbp+0xa6/0xb50 net/bridge/br_if.c:338

333 static void del_nbp(struct net_bridge_port *p)
334 {
335         struct net_bridge *br = p->br;
336         struct net_device *dev = p->dev;
337

338         sysfs_remove_link(br->ifobj, p->dev->name);

ETHERNET BRIDGE
M:      Roopa Prabhu <roopa@nvidia.com>
M:      Nikolay Aleksandrov <razor@blackwall.org>
L:      bridge@lists.linux.dev
L:      netdev@vger.kernel.org
S:      Maintained
W:      http://www.linuxfoundation.org/en/Net:Bridge
F:      include/linux/netfilter_bridge/
F:      net/bridge/

I would suggest you report this issue to the maintainers to the ethernet 
bridge component first.

Cheers,
Longman




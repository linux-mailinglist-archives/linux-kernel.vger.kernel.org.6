Return-Path: <linux-kernel+bounces-342963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9982989532
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511F2B2286E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B9714F13E;
	Sun, 29 Sep 2024 11:46:28 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946403C00
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727610388; cv=none; b=IE6/c+hhlUBBHo26F9Zbv5m0Lscy8V0XVuSTelKYGCatUnbGipWIjLSXEoOnCAyhL3EQRnwT6k9CrP4PkT4GvAjo9a7uF2ah7OmA18hAUxWZVL8/UHtDuPl6K1fjhvZ+VCH7y+E8sQiN4Go61u84lIUu/pMtWPGW/QoySkSkq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727610388; c=relaxed/simple;
	bh=Lws+eowf/tzTNG6urWd/LBgP4Qy7OF+1BFqhhFUD5Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=si9yMAfgtHnDnWNjh3nhb2fXp8yIKJ8lAROSSj6SlmMkOQitk1SubE51kkWM/8EUg20CfPZ0r6ZV0kKvI1MpAlKn1HVonGeHSIeY3wjs9Fmxbi+am9QWZw8AO3TeCyO9oQulV1OThbHWpXsCBRDHAIusY898Br5eUs70HM+tMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.162])
	by sina.com (10.185.250.22) with ESMTP
	id 66F93E0200007CE5; Sun, 29 Sep 2024 19:46:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8993327602666
X-SMAIL-UIID: 58B3E161AA5F4C4E93B714895E90C0E3-20240929-194613-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Denis Kirjanov <dkirjanov@suse.de>,
	syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Date: Sun, 29 Sep 2024 19:46:01 +0800
Message-Id: <20240929114601.1584-1-hdanton@sina.com>
In-Reply-To: <20240928122112.1412-1-hdanton@sina.com>
References: <000000000000657ecd0614456af8@google.com> <3483096f-4782-4ca1-bd8a-25a045646026@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 28 Sep 2024 20:21:12 +0800 Hillf Danton <hdanton@sina.com>
> On Mon, 25 Mar 2024 14:08:36 +0100 Eric Dumazet <edumazet@google.com>
> > On Mon, Mar 25, 2024 at 1:10 PM Denis Kirjanov <dkirjanov@suse.de> wrote:
> > >
> > > Hmm, report says that we have a net_device freed even that we have a dev_hold()
> > > before __ethtool_get_link_ksettings()
> > 
> > dev_hold(dev) might be done too late, the device is already being dismantled.
> > 
> > ib_device_get_netdev() should probably be done under RTNL locking,
> > otherwise the final part is racy :
> > 
> > if (res && res->reg_state != NETREG_REGISTERED) {
> >      dev_put(res);
> >      return NULL;
> > }
> 
> Given paranoia in netdev_run_todo(),
> 
> 		/* paranoia */
> 		BUG_ON(netdev_refcnt_read(dev) != 1);
> 
> the claim that dev_hold(dev) might be done too late could not explain
> the success of checking NETREG_REGISTERED, because of checking 
> NETREG_UNREGISTERING after rcu barrier.
> 
> 	/* Wait for rcu callbacks to finish before next phase */
> 	if (!list_empty(&list))
> 		rcu_barrier();
> 
> 	list_for_each_entry_safe(dev, tmp, &list, todo_list) {
> 		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
> 			netdev_WARN(dev, "run_todo but not unregistering\n");
> 			list_del(&dev->todo_list);
> 			continue;
> 		}
> 
As simply bumping kref up could survive the syzbot reproducer [1], Eric's reclaim
is incorrect.

--- l/drivers/infiniband/core/verbs.c
+++ v/drivers/infiniband/core/verbs.c
@@ -1979,6 +1979,7 @@ int ib_get_eth_speed(struct ib_device *d
 	netdev = ib_device_get_netdev(dev, port_num);
 	if (!netdev)
 		return -ENODEV;
+	dev_hold(netdev);
 
 	rtnl_lock();
 	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
@@ -1995,6 +1996,7 @@ int ib_get_eth_speed(struct ib_device *d
 				netdev->name, netdev_speed);
 	}
 
+	dev_put(netdev);
 	ib_get_width_and_speed(netdev_speed, lksettings.lanes,
 			       speed, width);
 
--
syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

[1] https://lore.kernel.org/lkml/66f9372f.050a0220.aab67.001a.GAE@google.com/


Return-Path: <linux-kernel+bounces-256278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96E934BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2124F1F23E98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113312D1FA;
	Thu, 18 Jul 2024 10:53:09 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319351B86FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299988; cv=none; b=Y4YBjmfFu5h/jNUT9sG/EQEY6xn0Nmk5pgi9lkdu0OGf2xEVH60oVUU0WmZCjnMdHcgGYaOZeB9mgM+CFj7St57r1MVdpGmJQGxb2g5D0lqrhyIeuyNeMgYV4xN485j2TpqmYrQYF13RiULJ7211nj+2yZHUyUh8WmjFNziotRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299988; c=relaxed/simple;
	bh=tHKrLtovADsfcDwZ714TZLnNp3nG+96PlQVnPoteZck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZ2Sg9nPa06yuRr0YlfJFwgCkwMTVzaTKhh9sMGbCqRqxyFNluz4CeIkvqBykfBisEAerV6BDc7hSf83/fGwdVPOma9Bhja0BLhQOJV3NIHP72u5sW+58iboSDV6PRxc5EcrHwQevaUk2Tsd2bIfSxlSVzcdreQrNvaewCxNlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.47])
	by sina.com (10.185.250.22) with ESMTP
	id 6698F40900004832; Thu, 18 Jul 2024 18:52:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2058687602654
X-SMAIL-UIID: 6AF591B3D38E4FC3A1734554B97F3E8F-20240718-185259-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ca9ad1d31885c81155b6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in dev_deactivate_queue
Date: Thu, 18 Jul 2024 18:52:48 +0800
Message-Id: <20240718105248.1380-1-hdanton@sina.com>
In-Reply-To: <000000000000c2f7f2061d7bfb12@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jul 2024 19:03:22 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170b4f31980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  523b23f0bee3

--- x/net/ethtool/ioctl.c
+++ y/net/ethtool/ioctl.c
@@ -58,10 +58,11 @@ static struct devlink *netdev_to_devlink
 
 u32 ethtool_op_get_link(struct net_device *dev)
 {
-	/* Synchronize carrier state with link watch, see also rtnl_getlink() */
-	linkwatch_sync_dev(dev);
+	u32 rc = netif_carrier_ok(dev) ? 1 : 0;
 
-	return netif_carrier_ok(dev) ? 1 : 0;
+	linkwatch_fire_event(NULL);
+
+	return rc;
 }
 EXPORT_SYMBOL(ethtool_op_get_link);
 
--- x/net/core/link_watch.c
+++ y/net/core/link_watch.c
@@ -286,13 +286,17 @@ static void linkwatch_event(struct work_
 
 void linkwatch_fire_event(struct net_device *dev)
 {
-	bool urgent = linkwatch_urgent_event(dev);
+	bool urgent = true;
 
+	if (!dev)
+		goto sched;
+	urgent = linkwatch_urgent_event(dev);
 	if (!test_and_set_bit(__LINK_STATE_LINKWATCH_PENDING, &dev->state)) {
 		linkwatch_add_event(dev);
 	} else if (!urgent)
 		return;
 
+sched:
 	linkwatch_schedule_work(urgent);
 }
 EXPORT_SYMBOL(linkwatch_fire_event);
--


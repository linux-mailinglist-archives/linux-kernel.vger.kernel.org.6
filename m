Return-Path: <linux-kernel+bounces-251280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B69302F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EE3282C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB01C2ED;
	Sat, 13 Jul 2024 01:13:41 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413D125B9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833221; cv=none; b=sHSyIqg116EsEQ5ND6wsYda0qo3hR1pw69IZt8lGNRPGj2xoufFBd3KfrxyYRmDbsl75MY+0EgLVvJ1rsaAcWgX7o7v7fMhbiMXzQJx4djChJW/dGz2udu27Gszp+VLSpv3Q25uQUlnQR3Ba2sL8zxTn+Rbd1Eqb8hos5N3yUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833221; c=relaxed/simple;
	bh=FrubflaZxQSXyWySAYzCPehHJyUf4Ch2cJ1xMvRrBng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9U+QaKYRQzPrqzt2owqJefzrMIZvdXWYgAyMO9ygWO+s57SeNaStT4QYrXoIEEod2BsTCYuNL7pZMOTiuFGMie6zRlhgF09isbV3bEVc+8WLbC/u9PBHrkXvMVhrG7fx/Uil8cnt9ImvAlc0OndH/XPtCI05IHCNb9bJHFQuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.52])
	by sina.com (10.185.250.22) with ESMTP
	id 6691D4B2000039E0; Sat, 13 Jul 2024 09:13:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6405967602719
X-SMAIL-UIID: 754B919205AA4046897CFBFB2BE76082-20240713-091325-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid context in synchronize_net
Date: Sat, 13 Jul 2024 09:13:17 +0800
Message-Id: <20240713011317.1220-1-hdanton@sina.com>
In-Reply-To: <000000000000e1d1a2061cff308e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Jul 2024 14:10:22 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    523b23f0bee3 Add linux-next specific files for 20240710
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ec9585980000

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


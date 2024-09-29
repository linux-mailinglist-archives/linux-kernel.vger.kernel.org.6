Return-Path: <linux-kernel+bounces-342921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBCE9894D4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB5285346
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A210B14D6E6;
	Sun, 29 Sep 2024 10:39:24 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6B3C00
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606364; cv=none; b=SpGaWg50hdy0Fifge7ZIJopWiWAzW9JB5HNLOkzQfG2xIGy5i9LS4Fk1uTa1U3Xz5YLOQ2velvaWk1atSKqIAbao+XM4i2GjTem9zjzeJV1yk+GIGWnzH8JfZM6ClJ9mWeGbjqjTNvLeD7xrEBZHovsQgSSDZUY4+L3O9FiDZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606364; c=relaxed/simple;
	bh=7QLs4ejVMMFYwJ0WSGzKseOdF7jW2d6W0HtngJRS+hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxN/lboEGpoaF9t062eDe+m6qtuAsEZ97PcsCbzYdEe4sWwQsRAriJEzpAZIaD/5jCblq5Tuhf+3APrqj1hhkGNu6Cj2Wa93q1L6zgnVKJvAVpY8SKPk1t2lG7z6RNj4P/Vc7WUMufuMwY3UQxbN8pqv9fILN39M/HLWsdE+jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.162])
	by sina.com (10.185.250.22) with ESMTP
	id 66F92E4C000002DC; Sun, 29 Sep 2024 18:39:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8510587602596
X-SMAIL-UIID: 887A95ECC3F44926B14EABBDAE40EBAF-20240929-183910-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Date: Sun, 29 Sep 2024 18:38:59 +0800
Message-Id: <20240929103859.1528-1-hdanton@sina.com>
In-Reply-To: <000000000000657ecd0614456af8@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    d505d3593b52 net: wwan: qcom_bam_dmux: Fix missing pm_runt..
> git tree:       net
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150d959f980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  61387b8dcf1d

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


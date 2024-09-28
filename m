Return-Path: <linux-kernel+bounces-342396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D01988E72
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F423D282464
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F219DFB6;
	Sat, 28 Sep 2024 08:22:26 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400919DF65
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727511746; cv=none; b=NAC5G5Oh/DA4rSJTKYmSr47grvuXGnQLRA7n4D7Q9BLPMuNj/T98cGBlYqD50s1U2z7X3DLTv5Aoq9WLvpb52Zk67VBBGLV8zYRR5QB3+M6CC3TiUo9MHVdD5nUDrkcGAEFPi0nhlh2iUPxhcq6tr21K0/q2lo87+bj4JV3s8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727511746; c=relaxed/simple;
	bh=V0oqGIf81HD5LX9IrNfZKhsSY22PcKnvRJaQa1Xo0UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KILYkPdG5LtHOIx7dc1/7dFkq0yL10AR3h5TvjgL5asauMnxU0fiyPRxRe5VYrdSrchV989WyIUEKk5iljHKctnzIo+lZSI161sP1h6aXT/BUCqwnTAtq9UWd/vshjiYDK2kGQv8b1Utu/SMYf9chR2oLeq51IiTaT4/q3LM2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.191])
	by sina.com (10.185.250.22) with ESMTP
	id 66F7BCB700002088; Sat, 28 Sep 2024 16:22:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8411537602715
X-SMAIL-UIID: 92AAA7E1638141FF8D8842BA6F41D6C0-20240928-162217-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Date: Sat, 28 Sep 2024 16:22:05 +0800
Message-Id: <20240928082205.1318-1-hdanton@sina.com>
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
@@ -1976,15 +1976,14 @@ int ib_get_eth_speed(struct ib_device *d
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
 		return -EINVAL;
 
-	netdev = ib_device_get_netdev(dev, port_num);
-	if (!netdev)
-		return -ENODEV;
-
 	rtnl_lock();
-	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
+	netdev = ib_device_get_netdev(dev, port_num);
+	if (netdev)
+		rc = __ethtool_get_link_ksettings(netdev, &lksettings);
 	rtnl_unlock();
 
-	dev_put(netdev);
+	if (!netdev)
+		return -ENODEV;
 
 	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
 		netdev_speed = lksettings.base.speed;
@@ -1995,6 +1994,7 @@ int ib_get_eth_speed(struct ib_device *d
 				netdev->name, netdev_speed);
 	}
 
+	dev_put(netdev);
 	ib_get_width_and_speed(netdev_speed, lksettings.lanes,
 			       speed, width);
 
--


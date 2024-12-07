Return-Path: <linux-kernel+bounces-435864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A139E7E0E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB841885CE4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603625761;
	Sat,  7 Dec 2024 02:58:29 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83317C7C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733540309; cv=none; b=WqpIT5jIBotVP6UTDnCzMCy+A6wqs2OWNJvSChOFDc3Om1MF9WNgH/o0gk1K9+UWD/bFhLmC7eBKelFLbOPp2pzRZ8tApk8YOwN184oemX8wCVpdwVqC/0usdYZnVlqJrlgn6qaXSngzyr8DQ4e0ozTOBt8KPE1oag0V4rt2VJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733540309; c=relaxed/simple;
	bh=IWXMfSsAQROgby9PavwNdXKBVFv2rjzEvtJg0xSqHmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAlEmUnumNoou9XpYKpk2fL9V98e/Vz/iyP/rLyRS2FJho+OUrnuPd2mPGMLp4GINMip22DJfBkNpO7i+RstuzTKO0k5xJ0GzqhYyLFa4oI2VOhFyKTFjDbgrRu1h9du0pGT4+LE2QJIKWzRZo5XK706FbK6lazXfwn6bnHkJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.203])
	by sina.com (10.185.250.23) with ESMTP
	id 6753B9A400007599; Sat, 7 Dec 2024 10:57:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3805188913405
X-SMAIL-UIID: D4D419DF1B4145FEBC92897F81EE059A-20241207-105745-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev
Date: Sat,  7 Dec 2024 10:57:31 +0800
Message-Id: <20241207025731.839-1-hdanton@sina.com>
In-Reply-To: <67531f5d.050a0220.2477f.0006.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 06 Dec 2024 07:59:25 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    896d8946da97 Merge tag 'net-6.13-rc2' of git://git.kernel...
> git tree:       net
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10de5330580000

#syz test

--- x/net/smc/smc_core.c
+++ y/net/smc/smc_core.c
@@ -1893,10 +1893,22 @@ int smc_vlan_by_tcpsk(struct socket *clc
 		ini->vlan_id = vlan_dev_vlan_id(ndev);
 		goto out_rel;
 	}
+	rcu_read_lock();
+	if (ndev->reg_state == NETREG_UNREGISTERING || ndev->reg_state == NETREG_UNREGISTERED) {
+		rcu_read_unlock();
+		rc = -ENODEV;
+		goto out_rel;
+	}
+	rcu_read_unlock();
 
 	priv.data = (void *)&ini->vlan_id;
 	rtnl_lock();
-	netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
+	rcu_read_lock();
+	if (ndev->reg_state == NETREG_UNREGISTERING || ndev->reg_state == NETREG_UNREGISTERED)
+		rc = -ENODEV;
+	else
+		netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
+	rcu_read_unlock();
 	rtnl_unlock();
 
 out_rel:
--


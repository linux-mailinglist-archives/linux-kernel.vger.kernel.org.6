Return-Path: <linux-kernel+bounces-435809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C09E7D47
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4169E28244E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F37139B;
	Sat,  7 Dec 2024 00:10:55 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF7196
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733530255; cv=none; b=Vore4pKZHHbLm3cvYXgNp1MjeL7n0Uv5LmzbIpZeAmHi78vs8Z4cl4yX6p4G32YL4DGaHp3H1LrP7EGG6zsBs3f8l1/gxJ/3GYkP9fLXM55tCa2HNm+Z4er4a0UcNT+dtAoW793s97om45uxts5A3xuzcOmhBiKSm8PKemkcKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733530255; c=relaxed/simple;
	bh=cyX2KMEOws6GIiD4mwBWj+STXCVX5S81kBdlljRS90k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uNf5EKRwp9DY00HLFX0SLZTv4TnIBW4WDWQdSVvU2oY7zqcKK3vAV4zKaFaOqbTtXW8Tf7ool/PuXqwp6N8FzVYgt6pfXTm8zKx8GCUN+Xd1G9TgSGLetLX1q2T8XZo62hXTvzg2sCmaEMu5DCJmVHlXAuAurzGk/GN3I53eAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.203])
	by sina.com (10.185.250.22) with ESMTP
	id 6753913C00002248; Sat, 7 Dec 2024 08:05:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6978697602722
X-SMAIL-UIID: 26B55BE698D5405C81E72A9D01EF5BA1-20241207-080521-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev
Date: Sat,  7 Dec 2024 08:05:07 +0800
Message-Id: <20241207000507.724-1-hdanton@sina.com>
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
@@ -1896,7 +1896,7 @@ int smc_vlan_by_tcpsk(struct socket *clc
 
 	priv.data = (void *)&ini->vlan_id;
 	rtnl_lock();
-	netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
+	netdev_walk_all_lower_dev_rcu(ndev, smc_vlan_by_tcpsk_walk, &priv);
 	rtnl_unlock();
 
 out_rel:
--


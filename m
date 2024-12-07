Return-Path: <linux-kernel+bounces-435835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF29E7DC3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497E328658D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65EC8FF;
	Sat,  7 Dec 2024 01:38:41 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B02BCF5
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535521; cv=none; b=rBX4U5jKGDC6bSZf36P3JDXx0P1pSt8bBZLia8WSqrbxze9lnOTIV4hB+vo2FG4PL96DdH5DyWpv/SAQ8yoebCfDcN7MBvKZCS4uh6W+9myFlE3qmP7xvWO3t8sjO2AZ2tj5pyI3OxIiLsd+1yFIeW+0ycJKGWTWuSVAMU3RWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535521; c=relaxed/simple;
	bh=GJHhE+C4To8nQ7emTFZtyy14U07UsWHedkCTr0UoH5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OE74LN4FQqdS63hcZAmUuHgGbfEtT0Z7nBIF0HiMpQNgKJMS/Ymt8QTquUO8O0FDdIY+DiMIUEyrr2cF3NC4Fe6HwJv8vSgFk+r9qIqWtZ5YhsHaWDwxbE7793daQjJEzFmq+9wGuD7di+MiUBQqeT+KSSEmjI7nFBPNZGri1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.203])
	by sina.com (10.185.250.23) with ESMTP
	id 6753A70E00000564; Sat, 7 Dec 2024 09:38:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2482978913239
X-SMAIL-UIID: BE8080519555448094550566EDCEBB1A-20241207-093827-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev
Date: Sat,  7 Dec 2024 09:38:13 +0800
Message-Id: <20241207013813.782-1-hdanton@sina.com>
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
@@ -1896,7 +1896,9 @@ int smc_vlan_by_tcpsk(struct socket *clc
 
 	priv.data = (void *)&ini->vlan_id;
 	rtnl_lock();
+	rcu_read_lock();
 	netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
+	rcu_read_unlock();
 	rtnl_unlock();
 
 out_rel:
--


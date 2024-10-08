Return-Path: <linux-kernel+bounces-355130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FFB9947C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D270F1C24FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90D51DD54F;
	Tue,  8 Oct 2024 11:51:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0C1D7E50
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388293; cv=none; b=RWOKzx+Pj8Y3xObla5sO+Ero6mvLU4+vZOeWibRUId/2FFn6ui7Aq39ozaZrX4e0k/op3v2C1fYUD8KdYrt50OQ5oNfU+dk9IF/bG5OWIrZwVSXqs29K4rbsNolqVvZJ4PaYgfxn3ogp+JuviOfB2m7m3ncK7g4iRXTq6Bb3KPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388293; c=relaxed/simple;
	bh=nSJQXKojb11FRD7CjZoS0RHG2kV4sHEUr0oJZCAZxuo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N6dqVVtBa6coU1b+HgDP3JD/TVzj386o0Lpb+rH9B9kjQ4NjtIGXzvhn1+5wVtc8Nh5fv0phh20wzzesK5BslFyxKXOuwWsjshxPZJVEgvNoDTUx55/PIGApJKufLqbrb3x7PcUce1Rc0ieVtomCMaiDUP/RfzClyyzZi5taXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf28c74efso652992339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 04:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728388291; x=1728993091;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFsP843Ovwu3dUFXwHHSKedyHO1oIz1Y6/uLi2CAMGA=;
        b=J09omvNojlR52ZlMvMQ50+mkwlblqf1MQtrLAlCuS84hUW2+9TJ2nuAxH0VwJ8hgvk
         B3RFJDKvnbWCTvrNqBnOtU4iVOwPP4FXhQ3ziCiWTHq6zAA/JMJCm/78OWVJdd5fQ0vl
         het+HXoAf7uPOALwq5okKSZyt+A6IGrHY+GynUwrX8LEr+J7u6n2y7MhMHE4bLIk2m1y
         v8rwFKyR+fDzTxUrMGER/yz1UaAR2jQ3DgaS0S5mpRCFSQE34G60NKmgkQvoIpxehWtp
         NOr/kSWyWXFtoZ1JxXS6kiuTbdjic4Iapx9Xumly1e/hTuKbpOAmFKCLzRtvKlwTKRU9
         9DRQ==
X-Gm-Message-State: AOJu0YwOwWljLwO3MtbxEmYNCD6bSN4zUHg+b2J4bmnXN7WB+mrQB+fe
	Pvs4+/6VrC3gaanIzsF4poz5A/qRPKg1IsWPIou70mvLM7a1v1ZoEveEH96j6dzyYO9MWInBwnK
	cdNug2RYdc3BPdchFIwmg0qKV8Oc0PUfQKxW2ez9Wl8rJVnjfOzx9Zow=
X-Google-Smtp-Source: AGHT+IECwLY6Ybq2fg7N/YFdl7sOUiaJ7wmCSMQRo5cHIyCmAWBBCWND5pAJk/rP7oH/UAgTrmH/P86dpvuaZQKnH7p+c/LiZ7T+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c9:b0:3a2:6ce9:19c6 with SMTP id
 e9e14a558f8ab-3a375be2ec4mr115963205ab.25.1728388290860; Tue, 08 Oct 2024
 04:51:30 -0700 (PDT)
Date: Tue, 08 Oct 2024 04:51:30 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67051cc2.050a0220.840ef.0001.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: leon@kernel.org

On Mon, Oct 07, 2024 at 06:44:02PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 5f8ca04fdd3c66a322ea318b5f1cb684dd56e5b2
> Author: Chiara Meiohas <cmeiohas@nvidia.com>
> Date:   Mon Sep 9 17:30:22 2024 +0000
> 
>     RDMA/device: Remove optimization in ib_device_get_netdev()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16db2327980000
> start commit:   c4a14f6d9d17 ipv4: ip_gre: Fix drops of small packets in i..
> git tree:       net
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15db2327980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11db2327980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eca3d0580000
> 
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: 5f8ca04fdd3c ("RDMA/device: Remove optimization in ib_device_get_netdev()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e029401b5680..0b7e5245ffbc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2061,19 +2061,14 @@ void ib_dispatch_event_clients(struct ib_event *event)
 	up_read(&event->device->event_handler_rwsem);
 }
 
-static int iw_query_port(struct ib_device *device,
-			   u32 port_num,
-			   struct ib_port_attr *port_attr)
+static int iw_query_port(struct ib_device *device, u32 port_num,
+			 struct ib_port_attr *port_attr,
+			 struct net_device *netdev)
 {
 	struct in_device *inetdev;
-	struct net_device *netdev;
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
-	netdev = ib_device_get_netdev(device, port_num);
-	if (!netdev)
-		return -ENODEV;
-
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
 
@@ -2096,7 +2091,6 @@ static int iw_query_port(struct ib_device *device,
 		rcu_read_unlock();
 	}
 
-	dev_put(netdev);
 	return device->ops.query_port(device, port_num, port_attr);
 }
 
@@ -2134,13 +2128,27 @@ int ib_query_port(struct ib_device *device,
 		  u32 port_num,
 		  struct ib_port_attr *port_attr)
 {
+	struct net_device *netdev = NULL;
+	int ret;
+
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
+	if (rdma_protocol_iwarp(device, port_num) ||
+	    rdma_protocol_roce(device, port_num)) {
+		netdev = ib_device_get_netdev(device, port_num);
+		if (!netdev)
+			return -ENODEV;
+	}
+
 	if (rdma_protocol_iwarp(device, port_num))
-		return iw_query_port(device, port_num, port_attr);
+		ret = iw_query_port(device, port_num, port_attr, netdev);
 	else
-		return __ib_query_port(device, port_num, port_attr);
+		ret = __ib_query_port(device, port_num, port_attr);
+	if (netdev)
+		dev_put(netdev);
+	return ret;
+
 }
 EXPORT_SYMBOL(ib_query_port);
 


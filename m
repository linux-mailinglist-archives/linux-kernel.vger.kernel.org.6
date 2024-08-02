Return-Path: <linux-kernel+bounces-272644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78681945F50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC471F23746
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705520010E;
	Fri,  2 Aug 2024 14:21:01 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA11EA0D2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608461; cv=none; b=Mf9oGZ6UH9hGJ72CboEPKRjQdhvomC8QyrgqYGDFo461JO5fPb5gO7ClH71Vee7w3FkIbBTPulcGUHEzjGm8JTMxb4S9JMTIo1ewG26LIgNIZ5LAm9v3qcANYFNOwsJXlq2Bt4EiCefJr3DNgpUbRHnIG4mqvSOxCW3wm8h5XYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608461; c=relaxed/simple;
	bh=qE8nkTcXopjtyUqV8qFOoFaBj31ZkanLJ6kmwkCM9k0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oI1gQyY20S6zXBMaTIoh+z/759QBaPkbA6JBnx2kWUZ/PEaxIE89BBW2zOMMxaRrxhPCrmZ2mrPKU9ujV7RTF61dRgmuUlHphzpxrhnSrbQjYMV0uzmIpWlLUtP9UtFLBg8TDiEF79YSg9sUWd21CQPlcteTmJFftueCHhIohy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so1095063339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 07:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722608458; x=1723213258;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVonvjowj6OGLbfTxTzl0Y3DZRsHGW5dU//cc5NfVvg=;
        b=khoOaYGxqf0IoktQD1jbRAx8SCSESIF7rHLXNDFbYaHzHU0Dp2SuWZJpWE6QvCQpl/
         Gpfzzc3JWaDnvAGUp/qqfAqnpK6DCb+tTY4UR9+Q4oc4LYZDZBgYDZlzuY7poVXanzBM
         PHLomjYfl8/pp79wc6yixuo7OoEysenMXsmoS+UUvqt8+q4YPMqrf+kkpjYLzKzYDW9U
         /tM4QV3QIgTXHp0vnci6mV9oQ37iVQOrOysIdw3h5JfAmYRLckbtaulMwC/5PDo8ciOV
         6BgOfmv7POCDzVl3Jhs6V+8y3t0k8DuM/+M07j3GzUqCPg1qIkyfjnsuDT2krLRceoh4
         ov1g==
X-Gm-Message-State: AOJu0Yzbx2Yjsl0PJa1fah7XLMt9E1ELdfgku929W889BFO7OAvOC1p0
	WVTtaSH3J9UYZle2IYXuUTKHqRmfyiMqmM7J8x9WCWjdc3NrQY02E3niXXvfrH6ZKNv6HqkpIOG
	8cntQ1bX+emusG6wo3Ne++vm2KdPjjK6Wv3PWjmqieoQBtx3hGYsd8MQ=
X-Google-Smtp-Source: AGHT+IFSFg4CbO77DB06XcZ5w0gZ6epkQjBcgYnWuKWaCabLqRzp4GZpDxQonpzbQ8OmpUwOcDI1z8GU0qhknPZAKwUkBeBUd2rg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8717:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4c8d56b0085mr136187173.5.1722608458474; Fri, 02 Aug 2024
 07:20:58 -0700 (PDT)
Date: Fri, 02 Aug 2024 07:20:58 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000413882061eb4096f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in
 team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/team/team_core.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..f7bab2d2a281 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1668,7 +1668,6 @@ static void team_uninit(struct net_device *dev)
 	struct team_port *port;
 	struct team_port *tmp;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
 		team_port_del(team, port->dev);
 
@@ -1677,7 +1676,6 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	mutex_unlock(&team->lock);
 	netdev_change_features(dev);
 	lockdep_unregister_key(&team->team_lock_key);
 }
@@ -1818,7 +1816,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
 	team->port_mtu_change_allowed = true;
 	list_for_each_entry(port, &team->port_list, list) {
 		err = dev_set_mtu(port->dev, new_mtu);
@@ -1829,7 +1826,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 		}
 	}
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	WRITE_ONCE(dev->mtu, new_mtu);
 
@@ -1839,7 +1835,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		dev_set_mtu(port->dev, dev->mtu);
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1893,20 +1888,17 @@ static int team_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = vlan_vid_add(port->dev, proto, vid);
 		if (err)
 			goto unwind;
 	}
-	mutex_unlock(&team->lock);
 
 	return 0;
 
 unwind:
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1916,10 +1908,8 @@ static int team_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return 0;
 }
@@ -1941,9 +1931,7 @@ static void team_netpoll_cleanup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 
-	mutex_lock(&team->lock);
 	__team_netpoll_cleanup(team);
-	mutex_unlock(&team->lock);
 }
 
 static int team_netpoll_setup(struct net_device *dev,
@@ -1953,7 +1941,6 @@ static int team_netpoll_setup(struct net_device *dev,
 	struct team_port *port;
 	int err = 0;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = __team_port_enable_netpoll(port);
 		if (err) {
@@ -1961,7 +1948,6 @@ static int team_netpoll_setup(struct net_device *dev,
 			break;
 		}
 	}
-	mutex_unlock(&team->lock);
 	return err;
 }
 #endif
@@ -1972,9 +1958,7 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
 	err = team_port_add(team, port_dev, extack);
-	mutex_unlock(&team->lock);
 
 	if (!err)
 		netdev_change_features(dev);
@@ -1987,9 +1971,7 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
 	err = team_port_del(team, port_dev);
-	mutex_unlock(&team->lock);
 
 	if (err)
 		return err;
@@ -2945,11 +2927,7 @@ static void __team_port_change_port_removed(struct team_port *port)
 
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
-	struct team *team = port->team;
-
-	mutex_lock(&team->lock);
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
 }
 
 
--


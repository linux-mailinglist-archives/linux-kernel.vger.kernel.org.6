Return-Path: <linux-kernel+bounces-240894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59B927445
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B60280FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52DA1AB90F;
	Thu,  4 Jul 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U912boR7"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593118C38
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089950; cv=none; b=je9HuagbMKUOHWvziynhQjWt2Kfko1I3OsuK2UkeJy/EpibnbRCJ5wL/LHBkSo08LmnU75Kgi9lz/MJENSKz+xXn0dC0asirW0pxcfeHod4vwY+Qg9UoAbJW7ytfIioiwJmaipxilwa4HrH/6at9TtrLBVnwwVLcvI07BM9vM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089950; c=relaxed/simple;
	bh=ObDcv/ZSJvLJ4hheDJ5Nlpqh9Xkt2Tgo5Fq9H18So5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcOVrKwPZ0A4vKWLFO0i4kpORmIZSaIN4pdnwA1/61Zdx5/K5OOZd9+ZHmGC8Wxmd1ZL3g8Oq1E6ug3h3guVkhj6/8JrhyPwIKtxKx8+V7Ii9kXRN2963YBFm4P+w020FhQs8pVYWQs5P9jmYKhIAK+nu32OTxSry3GEaBg1rOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U912boR7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b03ffbb3aso210134b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720089948; x=1720694748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FacgwX4vPYpR6tRiLZR5V79R8RLHVbDfs0jupOopL8=;
        b=U912boR7WrRE103bBkeVns3dy2bhkWFxQemGws5rMJkHsxIK0r4pTwbQvfSpzMpSxo
         6g/zVaCAOX66nmyhwhi4U39o+XcFd4Vlf2yhRECHQJuxhVDK9wnVDrOG76mVflMo10Pe
         t5JAw2Nch+1WTSOHCUUXJr+mHY4yZ8Ymuc/HNuVpF3YT2nKNdLniVHQQ1HjxfavqtCyx
         KL3COe5ZdwgbM+I4laWKAXP5Uf5tOino/Awxu5wxKpMPrEr7dFn2Ua137VH0k2A1NYEo
         SZrH/HIuDQiKuP0TXR2UUWUpWHMUzKvTv+c6c5kyRNLVfZIwaekBfioTg3hRvsWBWWdg
         Yesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720089948; x=1720694748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FacgwX4vPYpR6tRiLZR5V79R8RLHVbDfs0jupOopL8=;
        b=A/yGyDspdbJKehYF9hlSEDbzLiYnLVA4jw3kFjmtFHyuDMLg2Wq8KsPHj7yFQF52w0
         vp139Ijd30jzP2q/rL5rvFSVYseQyPJy+m9jM+gK+Iachx55eUSS9ZcnS7icMZWYyDnu
         g8u3y65w3caT6zPnzbOEnDI9ype64UKi0vSlkU2O8cknTSv5xQr6ex7CQ7/1wPeKOnXB
         QOxBpB7jWBXddeG9HErlDCc7IzrDSxyhbEg/SGI1JrQK6B/kPGvHfcPxiofgbZVrq1gD
         p2mX2JLziNezgrRYLceWBujdGVaHJ0A4nTCr9LrFfOvLR1Nb/OmZOAW+rPkFOLmMnRNH
         N0pQ==
X-Gm-Message-State: AOJu0Yx1AOSMVwfMLy3tomyb713CFzjxFamXkUHhX1qrOG1j5lQpdpdc
	h3QiyeplmrLPJZrHIWiD7nLGGrr4nH8djYcpXZoeuBuz6MXtEQxk
X-Google-Smtp-Source: AGHT+IEqSqevFfz0Yd54Ca2tP8hpeXaB1QdlK99b/AYfrgsyk8uA6boymwV3QZjC0LAmf3dT8GiNug==
X-Received: by 2002:a05:6a00:182a:b0:706:750c:8dda with SMTP id d2e1a72fcca58-70b00a648bemr1349484b3a.6.1720089948080;
        Thu, 04 Jul 2024 03:45:48 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802565b3asm11900022b3a.53.2024.07.04.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:45:47 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Thu,  4 Jul 2024 19:45:44 +0900
Message-Id: <20240704104544.91031-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: <000000000000ffc5d80616fea23d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/team/team_core.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..a12366fd420c 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1142,31 +1142,37 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	char *portname = port_dev->name;
 	int err;
 
+	rtnl_lock();
+
 	if (port_dev->flags & IFF_LOOPBACK) {
 		NL_SET_ERR_MSG(extack, "Loopback device can't be added as a team port");
 		netdev_err(dev, "Device %s is loopback device. Loopback devices can't be added as a team port\n",
 			   portname);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_out;
 	}
 
 	if (netif_is_team_port(port_dev)) {
 		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
 		netdev_err(dev, "Device %s is already a port "
 				"of a team device\n", portname);
-		return -EBUSY;
+		err = -EBUSY;
+		goto err_out;
 	}
 
 	if (dev == port_dev) {
 		NL_SET_ERR_MSG(extack, "Cannot enslave team device to itself");
 		netdev_err(dev, "Cannot enslave team device to itself\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_out;
 	}
 
 	if (netdev_has_upper_dev(dev, port_dev)) {
 		NL_SET_ERR_MSG(extack, "Device is already an upper device of the team interface");
 		netdev_err(dev, "Device %s is already an upper device of the team interface\n",
 			   portname);
-		return -EBUSY;
+		err = -EBUSY;
+		goto err_out;
 	}
 
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
@@ -1174,7 +1180,8 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		NL_SET_ERR_MSG(extack, "Device is VLAN challenged and team device has VLAN set up");
 		netdev_err(dev, "Device %s is VLAN challenged and team device has VLAN set up\n",
 			   portname);
-		return -EPERM;
+		err = -EPERM;
+		goto err_out;
 	}
 
 	err = team_dev_type_check_change(dev, port_dev);
@@ -1185,13 +1192,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
 			   portname);
-		return -EBUSY;
+		err = -EBUSY;
+		goto err_out;
 	}
 
 	port = kzalloc(sizeof(struct team_port) + team->mode->port_priv_size,
 		       GFP_KERNEL);
-	if (!port)
-		return -ENOMEM;
+	if (!port) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
 	port->dev = port_dev;
 	port->team = team;
@@ -1213,7 +1223,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_port_enter;
 	}
 
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
@@ -1292,6 +1304,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 	netdev_info(dev, "Port device %s added\n", portname);
 
+	rtnl_unlock();
 	return 0;
 
 err_set_slave_promisc:
@@ -1321,7 +1334,8 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 err_set_mtu:
 	kfree(port);
-
+err_out:
+	rtnl_unlock();
 	return err;
 }
 
--


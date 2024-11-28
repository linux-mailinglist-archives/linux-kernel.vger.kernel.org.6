Return-Path: <linux-kernel+bounces-424597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662709DB685
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDEA164389
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920AF198E6F;
	Thu, 28 Nov 2024 11:30:19 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A31494B0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793419; cv=none; b=fvjH1Pl+MlNOUplJbMmxSXxhjJMkY5BFXXGDPe+TWpHYIePmCHRYPS1OOBIfi25D3BtOeDe/dJl6kqLFX1ZFSKDM7mkfzzs7+/sE0ovX3AW0IlVo84uIMhgA7wqn8suVRzJSmWn3VQHBHHwBpQatE80cAgkQPt7ZMCxWJUi4+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793419; c=relaxed/simple;
	bh=cftuCfELt6s3XCJlGXm3hKUgHzv58mMw6Vs8ixvliEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbSaqUs/7IHD5jj9Av+gIy9rH7/4PRwk51AKldqJOHLPmm/K520ygAfSSwYvfCpWP9rwFDADNqY/b7XXJjxpVjk3lz938+0BYJzqsxn0DVDLaImWvDcj/xPYZ9PHggEe8GN0hDWEGcQoPi+toJt86aD5DaNjgVxWkE+5Wioea1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.49])
	by sina.com (10.185.250.22) with ESMTP
	id 6748543600007B94; Thu, 28 Nov 2024 19:30:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3732707602656
X-SMAIL-UIID: 3AE0D72C139F4BB6BEE5E94B1A5EE656-20241128-193002-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9f9ccb1c9235f3d44d53@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __timer_delete
Date: Thu, 28 Nov 2024 19:29:48 +0800
Message-Id: <20241128112948.1850-1-hdanton@sina.com>
In-Reply-To: <67476c0d.050a0220.253251.005d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Nov 2024 10:59:25 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    2c22dc1ee3a1 Merge tag 'mailbox-v6.13' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16143778580000

#syz test

--- x/net/bluetooth/sco.c
+++ y/net/bluetooth/sco.c
@@ -192,7 +192,6 @@ static struct sco_conn *sco_conn_add(str
 			conn->hcon = hcon;
 			sco_conn_unlock(conn);
 		}
-		sco_conn_put(conn);
 		return conn;
 	}
 
@@ -201,6 +200,7 @@ static struct sco_conn *sco_conn_add(str
 		return NULL;
 
 	kref_init(&conn->ref);
+	kref_get(&conn->ref);
 	spin_lock_init(&conn->lock);
 	INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
 
--


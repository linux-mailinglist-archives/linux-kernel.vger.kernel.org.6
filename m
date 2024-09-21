Return-Path: <linux-kernel+bounces-334801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F597DC5C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA1E1C20FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7771E15442D;
	Sat, 21 Sep 2024 09:28:33 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DF35894
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726910913; cv=none; b=RXfh12L/GNNiZ/HCeJMuhVrZhJ+KiUfOYt/1Xut4+J/Kr1PKsCYf3BTlZcY4fcJPuEUWLEGJXZvZfze6bTFzi0C0GILVLoQ3UWO8Fu6Kmd6/7fcFpKjGgTKyZGimwL+o+nKn4ToyN4kMseie2AJYRPVOkvArAR9wgLXcysrpD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726910913; c=relaxed/simple;
	bh=v2/D/qWL/Fy6xBUsdry4ij/zb39ZtojPe+58ZteWF9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvDxGLeUdd4gttUqHwL1pvxpyk+Fbdz8RQduRG2+csua65bWA3UGdyrPb9lVaiBn0MyUDQQqL0OUECZoEkSVSmoN37EDXCM1wiYkY/9DMqUwfdV6E0VUrs/pw5ec39S7G9TVlNIJTc6jMYROTc6KdAWagKn6O0gX0enacowmV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.129])
	by sina.com (10.185.250.24) with ESMTP
	id 66EE912500000FE7; Sat, 21 Sep 2024 17:25:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 33017010748321
X-SMAIL-UIID: 127C7DAEA48942A785141E5665963551-20240921-172559-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
Date: Sat, 21 Sep 2024 17:25:47 +0800
Message-Id: <20240921092547.968-1-hdanton@sina.com>
In-Reply-To: <66ed861a.050a0220.2abe4d.0015.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Sep 2024 07:26:34 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7d69f980000

#syz test

--- x/fs/netfs/write_collect.c
+++ y/fs/netfs/write_collect.c
@@ -548,7 +548,9 @@ void netfs_write_collection_worker(struc
 		return;
 	}
 
+	mutex_lock(&ictx->wb_lock);
 	netfs_collect_write_results(wreq);
+	mutex_unlock(&ictx->wb_lock);
 
 	/* We're done when the app thread has finished posting subreqs and all
 	 * the queues in all the streams are empty.
--- l/net/9p/client.c
+++ c/net/9p/client.c
@@ -979,6 +979,7 @@ struct p9_client *p9_client_create(const
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	static int fcc = 0;
 
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
@@ -991,6 +992,11 @@ struct p9_client *p9_client_create(const
 	client_id = utsname()->nodename;
 	memcpy(clnt->name, client_id, strlen(client_id) + 1);
 
+	clnt->name[__NEW_UTS_LEN] = 0;
+	if (__NEW_UTS_LEN <= snprintf(clnt->name, __NEW_UTS_LEN, "9pfcc%d", ++fcc)) {
+		kfree(clnt);
+		return ERR_PTR(-ENOMEM);
+	}
 	spin_lock_init(&clnt->lock);
 	idr_init(&clnt->fids);
 	idr_init(&clnt->reqs);
@@ -1039,7 +1045,7 @@ struct p9_client *p9_client_create(const
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(clnt->name, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
--


Return-Path: <linux-kernel+bounces-334781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7897DC14
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976791F21B73
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29815098F;
	Sat, 21 Sep 2024 08:10:09 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CC8C07
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906208; cv=none; b=mK7BAYrHwwDjwgcwuSH5O5a6D9oRz933BcO+ygx8wE+BM105Hz9S9JNt+SxrIvEshFvVhaTXFcQTQlLQalKKozM2ldfzc6XDjvjLBw89A+hfTdPAJLjiOMBs3q5Ie2f4GuUVWDLutMInHOFhEnZAY1tzhB0gQooY3V8lC0I8TEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906208; c=relaxed/simple;
	bh=arS2scEpmG3WHoLm1tUusLwiaZoyGo7kBMor/6i6NHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRc7YXa3f8LLTL9irvYQGx9niOUG479yJiqVhbci/VypRqzCQFc6ljTnndVgju5MlPSgLIF5NRBNjXAF99gWMWyGggqX9G5mC6e7SqtvxbBxoPMyom4RCsjqyGouk+elYraHTcl4T3lWSNwKFkD3KVZbX1BBKXMMlLAbckmVwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.129])
	by sina.com (10.185.250.22) with ESMTP
	id 66EE7F5400007027; Sat, 21 Sep 2024 16:09:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8354357602640
X-SMAIL-UIID: 7934C01215794E4ABA2455DBA7E680FC-20240921-160958-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
Date: Sat, 21 Sep 2024 16:09:49 +0800
Message-Id: <20240921080949.909-1-hdanton@sina.com>
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
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/sprintf.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -979,6 +980,7 @@ struct p9_client *p9_client_create(const
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	static int fcc = 0;
 
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
@@ -991,6 +993,11 @@ struct p9_client *p9_client_create(const
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
@@ -1039,7 +1046,7 @@ struct p9_client *p9_client_create(const
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(clnt->name, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
--


Return-Path: <linux-kernel+bounces-200139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB7A8FABA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A71F22AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A7140396;
	Tue,  4 Jun 2024 07:15:06 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1631384BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485306; cv=none; b=AIHjUEtjuYuwohkMTavKMueyANTZ4GmJrT/sQPqYI04+wG1nFEecFNlt1K0YmPiYFAC3v/SBRkru+NRBDWU7GKvNN98uRb8tdvFYIsOf/o4fnBBHYWjbOmXGK/G8cto6Fhfmqtu/zWZplXG1KKl0jRwn/hLH4xX7gBkAbD/kvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485306; c=relaxed/simple;
	bh=BjJkIKcRhJcMNwuFbWpxRrGm5KJOyUquFeQv4/eVuSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNCMZIXtPkWJApJcMEjjdHETCj2g4hux4OHdoWNmADOKf45EnjkH9APzIQRQBvRWNlpDLvjEYoUlTbeKtFVU/OhBuzdowm51TxIKaj2Ws/ChEe589+cQHpUjis+au6rVIuRd0DI5AdNjW86sRLPnqx1mtpACKV9GhlUtB53fPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VthZy5HZBzxRV8;
	Tue,  4 Jun 2024 15:11:06 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E031180AA7;
	Tue,  4 Jun 2024 15:15:02 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 15:13:31 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <dhowells@redhat.com>, <steved@redhat.com>, <Trond.Myklebust@netapp.com>,
	<viro@zeniv.linux.org.uk>
CC: <netfs@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] cachefiles: modify inappropriate error return value in cachefiles_daemon_secctx
Date: Tue, 4 Jun 2024 15:13:34 +0800
Message-ID: <20240604071334.3982185-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

In cachefiles_daemon_secctx(), if it is detected that secctx has been
written to the cache, the error code returned is -EINVAL, which is
inappropriate and does not distinguish the situation well.

Like cachefiles_daemon_dir(), fix this issue by return -EEXIST to the user
if it has already been defined once.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 6465e2574230..1b14849804f3 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -586,7 +586,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 
 	if (cache->secctx) {
 		pr_err("Second security context specified\n");
-		return -EINVAL;
+		return -EEXIST;
 	}
 
 	secctx = kstrdup(args, GFP_KERNEL);
-- 
2.39.2



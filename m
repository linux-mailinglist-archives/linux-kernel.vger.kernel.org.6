Return-Path: <linux-kernel+bounces-182707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A528C8EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEE11C2136A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE681411EA;
	Fri, 17 May 2024 23:59:51 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701C140E3C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990391; cv=none; b=nVSX51gT5/8GF08mAjG3lmu8wb3luQNdM3slX7vJohxls+cg6x3O1/5UyvxdLX5ZMcI+gROK3My6ALgotdF7AocymtyArE6B96TQBN093Ccy+m+7Z5NB6R4dCoz6g6TFYShXpLEYHjVRkN+n91DNSNc5+ocVtbgXWzchnH8A3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990391; c=relaxed/simple;
	bh=JavnvCI8sZH3JJUZaufeeDczIyadgCutUWPYg3S94P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoYLR/K3gapNoMNscrK3zXn8Vimvx7ONj+l6VvaX3RcHcC6rOTJ7suW8r2ssBKM/ELEXBBmdxIF8KK3pHuhJOqdu+xASfR8RtxFwK2BhmdctcBAb8JqI62AQwwm0+LolUNegeXDGYwq5j7JycC1RJ8/KAF6tZ5E/7Kvluem/LQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.249])
	by sina.com (172.16.235.24) with ESMTP
	id 6647EF660000543F; Fri, 18 May 2024 07:59:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 74210945089248
X-SMAIL-UIID: FEA98C363AFA40AEBF25AA2E182484D2-20240518-075936-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
Date: Sat, 18 May 2024 07:59:25 +0800
Message-Id: <20240517235925.1584-1-hdanton@sina.com>
In-Reply-To: <00000000000049897e0618a4b1ff@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 May 2024 04:31:28 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ea5f6ad9ad96 Merge tag 'platform-drivers-x86-v6.10-1' of g..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11df3084980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  ea5f6ad9ad96

--- x/include/net/9p/client.h
+++ y/include/net/9p/client.h
@@ -11,6 +11,7 @@
 
 #include <linux/utsname.h>
 #include <linux/idr.h>
+#include <linux/mutex.h>
 #include <linux/tracepoint-defs.h>
 
 /* Number of requests per row */
@@ -122,6 +123,7 @@ struct p9_client {
 
 	struct idr fids;
 	struct idr reqs;
+	struct mutex destroy_mutex;
 
 	char name[__NEW_UTS_LEN + 1];
 };
--- x/net/9p/client.c
+++ y/net/9p/client.c
@@ -1041,6 +1041,7 @@ struct p9_client *p9_client_create(const
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
+	mutex_init(&clnt->destroy_mutex);
 
 	return clnt;
 
@@ -1065,11 +1066,13 @@ void p9_client_destroy(struct p9_client
 		clnt->trans_mod->close(clnt);
 
 	v9fs_put_trans(clnt->trans_mod);
+	mutex_lock(&clnt->destroy_mutex);
 
 	idr_for_each_entry(&clnt->fids, fid, id) {
 		pr_info("Found fid %d not clunked\n", fid->fid);
 		p9_fid_destroy(fid);
 	}
+	mutex_unlock(&clnt->destroy_mutex);
 
 	p9_tag_cleanup(clnt);
 
@@ -1454,7 +1457,10 @@ error:
 		if (retries++ == 0)
 			goto again;
 	} else {
-		p9_fid_destroy(fid);
+		if (mutex_trylock(&clnt->destroy_mutex)) {
+			p9_fid_destroy(fid);
+			mutex_unlock(&clnt->destroy_mutex);
+		}
 	}
 	return err;
 }
--


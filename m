Return-Path: <linux-kernel+bounces-182738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC228C8F36
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63211F221F5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325629A2;
	Sat, 18 May 2024 01:34:09 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0C1FBA
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715996049; cv=none; b=JRphs2n4AKFP45nbkIE2jU9wKDYL4iI1f8pxr5UGxNOfcX6IzWnmcX6ng96lgBsCC/hJKjXGl+6oK6cPgmNH7uMtqNF9Wh1dcZX4Z0mL5DOvk2v8jmLKRgtrurRqrDQyEMeVjyiyfrNdmX7V/RFNKL2n7bJdwMo/D7P0FXfHmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715996049; c=relaxed/simple;
	bh=ifsj8+EQBQy+H/Y8chZd2hRoJRviiAySy67SIqorXqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqZONVFKVtcUCaQfaVQjIxJEz2RERQaFcyMadLORwzBp7YF4rB0joMyCbVdhyeuS3mmjNCvCUxi0P8v6e6V7+48ByXgipWnmc91knqWVlmFKIyaGrV2MyA4Guk7DlmB4axIJQ8Dm7Kjh6+AgYx6ump3SH1W8RTolhns3trvdQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.249])
	by sina.com (10.75.12.45) with ESMTP
	id 6648057E00000BCE; Sat, 18 May 2024 09:33:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 85541931457862
X-SMAIL-UIID: 9697284FBA05422AA631F1BF6CC9C35B-20240518-093352-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
Date: Sat, 18 May 2024 09:33:41 +0800
Message-Id: <20240518013341.1649-1-hdanton@sina.com>
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
 
@@ -1058,6 +1059,7 @@ void p9_client_destroy(struct p9_client
 {
 	struct p9_fid *fid;
 	int id;
+	int clean;
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
 
@@ -1066,9 +1068,18 @@ void p9_client_destroy(struct p9_client
 
 	v9fs_put_trans(clnt->trans_mod);
 
+again:
+	clean = 1;
+	mutex_lock(&clnt->destroy_mutex);
 	idr_for_each_entry(&clnt->fids, fid, id) {
 		pr_info("Found fid %d not clunked\n", fid->fid);
-		p9_fid_destroy(fid);
+		clean = 0;
+		break;
+	}
+	mutex_unlock(&clnt->destroy_mutex);
+	if (!clean) {
+		schedule_timeout_idle(2);
+		goto again;
 	}
 
 	p9_tag_cleanup(clnt);
@@ -1454,7 +1465,9 @@ error:
 		if (retries++ == 0)
 			goto again;
 	} else {
+		mutex_lock(&clnt->destroy_mutex);
 		p9_fid_destroy(fid);
+		mutex_unlock(&clnt->destroy_mutex);
 	}
 	return err;
 }
--


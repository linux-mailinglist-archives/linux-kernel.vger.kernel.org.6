Return-Path: <linux-kernel+bounces-183005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418278C931C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 02:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394181C20AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39664400;
	Sun, 19 May 2024 00:15:20 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B58139D
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716077720; cv=none; b=WDE5z3MZWDNAbbO8tMDRIXjL2KRRzI8A47f92Pa1UfUZOTo9rzaM2wlorqp6Kx1WvCmleyrbCKq3c4MsChClhubsihUR7EggukP/U1PVE6RWtAuFNdfez+glPeHoKV5J2bWgGt6EwiGqNqNOAxECuUkvts+8VxQeGGa4SGG3Y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716077720; c=relaxed/simple;
	bh=5GI1vE82fgk4KunoBf/cZxPVZLmg10tihueEXuEtR9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cw47gXAJHK1lvlbbA19iWFDJL5fQXXJ9/QzU3plFaNo2/jx3bjRyvZoKyC8COeOvgd0nsQ4VmexrQva4xhHKQGLhz3vzcvk9tFl4s0gq537bo3vszGbozhR/6IgY3WHaeNO7KgyvY2SdhItNp31kgIKPNAX0HNckaDq7DJH9lO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.153])
	by sina.com (172.16.235.24) with ESMTP
	id 6649448500007E55; Sun, 19 May 2024 08:15:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 36285645089234
X-SMAIL-UIID: C1C3CBE640624C1381315FCF22950B60-20240519-081503-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
Date: Sun, 19 May 2024 08:14:52 +0800
Message-Id: <20240519001452.1982-1-hdanton@sina.com>
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

--- x/net/9p/client.c
+++ y/net/9p/client.c
@@ -426,9 +426,6 @@ static void p9_tag_cleanup(struct p9_cli
 	rcu_read_lock();
 	idr_for_each_entry(&c->reqs, req, id) {
 		pr_info("Tag %d still in use\n", id);
-		if (p9_req_put(c, req) == 0)
-			pr_warn("Packet with tag %d has still references",
-				req->tc.tag);
 	}
 	rcu_read_unlock();
 }
@@ -879,15 +876,19 @@ static void p9_fid_destroy(struct p9_fid
 {
 	struct p9_client *clnt;
 	unsigned long flags;
+	bool empty;
 
 	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
 	trace_9p_fid_ref(fid, P9_FID_REF_DESTROY);
 	clnt = fid->clnt;
 	spin_lock_irqsave(&clnt->lock, flags);
 	idr_remove(&clnt->fids, fid->fid);
+	empty = idr_is_empty(&clnt->fids) && clnt->status == Hung + 1;
 	spin_unlock_irqrestore(&clnt->lock, flags);
 	kfree(fid->rdir);
 	kfree(fid);
+	if (empty)
+		kfree(clnt);
 }
 
 /* We also need to export tracepoint symbols for tracepoint_enabled() */
@@ -1057,6 +1058,8 @@ EXPORT_SYMBOL(p9_client_create);
 void p9_client_destroy(struct p9_client *clnt)
 {
 	struct p9_fid *fid;
+	unsigned long flags;
+	bool empty;
 	int id;
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
@@ -1068,13 +1071,17 @@ void p9_client_destroy(struct p9_client
 
 	idr_for_each_entry(&clnt->fids, fid, id) {
 		pr_info("Found fid %d not clunked\n", fid->fid);
-		p9_fid_destroy(fid);
 	}
 
 	p9_tag_cleanup(clnt);
 
 	kmem_cache_destroy(clnt->fcall_cache);
-	kfree(clnt);
+	spin_lock_irqsave(&clnt->lock, flags);
+	clnt->status = Hung + 1;
+	empty = idr_is_empty(&clnt->fids);
+	spin_unlock_irqrestore(&clnt->lock, flags);
+	if (empty)
+		kfree(clnt);
 }
 EXPORT_SYMBOL(p9_client_destroy);
 
--


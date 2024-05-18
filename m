Return-Path: <linux-kernel+bounces-182834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B48C90AE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 13:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61691C213FD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 11:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680BDDC1;
	Sat, 18 May 2024 11:41:31 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBC2E62B
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716032491; cv=none; b=e0gDZalqNaJCNueTf6P+KwKqYsf/Qtqf/gwIL2HWWg3jWkd5cYB/xUuK9LelbA7n3gcNOhKYlf07EOY2YdVUyB4UvKvRy+pTu6d/5AzPHyLJxtQzdpzU4AH2fPAEnPjCJdnrnngvclshk06SrRwyuWO/5Z8QBe7k9O/CCvShJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716032491; c=relaxed/simple;
	bh=FT9g0mVJkaULAbLCz6DFh6+4/pfYztHg6RKsLSGzaKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNnppgZWLtKzzcwUtpKm7XWhW4U9/0zqwr1a5Uo7bbZCrIAyhpcalvJGU66v2hYtvwXDAzQ06lWqLNKQxvqOr5gM5DqXYtuk5Or94TNhmI9FdVntAaE6siBnYLnpAOv8i9sBcokQJgnxgmKZd8VcQNTJ6BW9muT5o/m4p9FIEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.249])
	by sina.com (10.75.12.45) with ESMTP
	id 664893DA000080FD; Sat, 18 May 2024 19:41:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 21449531457749
X-SMAIL-UIID: BA5C5DCC219A4AD89BC009DD1F383FB1-20240518-194117-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
Date: Sat, 18 May 2024 19:41:05 +0800
Message-Id: <20240518114105.1730-1-hdanton@sina.com>
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
@@ -879,15 +879,19 @@ static void p9_fid_destroy(struct p9_fid
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
@@ -1057,6 +1061,8 @@ EXPORT_SYMBOL(p9_client_create);
 void p9_client_destroy(struct p9_client *clnt)
 {
 	struct p9_fid *fid;
+	unsigned long flags;
+	bool empty;
 	int id;
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
@@ -1068,13 +1074,18 @@ void p9_client_destroy(struct p9_client
 
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
+
+	if (empty)
+		kfree(clnt);
 }
 EXPORT_SYMBOL(p9_client_destroy);
 
--


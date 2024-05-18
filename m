Return-Path: <linux-kernel+bounces-182996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077638C9303
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94419B20BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162C6BFDC;
	Sat, 18 May 2024 23:08:31 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D7199B8
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716073711; cv=none; b=t9qb6Vaj0ra3ZukTEXizzE/UgrdTTvFVaSkP6fYuA1Lhn/Ic88ELx1PkAgWroJ07fbt6gB1DUk4jtjOkrLcW9PVjRX33s8wP7PUrxeGCdCRUOBX+2UOTaSQ19OC7AjuoHLvOK85dQX/Y+jH9J089j6JCxnI+KVV/ZrLCpvc+2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716073711; c=relaxed/simple;
	bh=d4Ql+Ho6vCaWnS1SZOYb7n/dJDAq9g7Fh+yMZ3TnUjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JTCn7bPpumZPdChGk9a9ErACZPpb4I0Nbq9EWVblbuB3w3J+QZgoOkkubiWl5zf6DfScVqgAo1YRBtVEweniO0/0JuT2VaF7XvMQuW/+qq9/suKEmwSBvO1hFJgJkPvpnrsmLj5gr5cXSani7w5H/Ao/FEAKEGfEjs3g+j4o3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.153])
	by sina.com (172.16.235.24) with ESMTP
	id 664934E400005E16; Sat, 19 May 2024 07:08:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 11123245089265
X-SMAIL-UIID: B98C54D594ED441EA473FEB14445DC52-20240519-070822-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
Date: Sun, 19 May 2024 07:08:11 +0800
Message-Id: <20240518230811.1915-1-hdanton@sina.com>
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
@@ -703,8 +703,6 @@ p9_client_rpc(struct p9_client *c, int8_
 
 	err = c->trans_mod->request(c, req);
 	if (err < 0) {
-		/* write won't happen */
-		p9_req_put(c, req);
 		if (err != -ERESTARTSYS && err != -EFAULT)
 			c->status = Disconnected;
 		goto recalc_sigpending;
@@ -755,8 +753,8 @@ recalc_sigpending:
 	trace_9p_client_res(c, type, req->rc.tag, err);
 	if (!err)
 		return req;
-reterr:
 	p9_req_put(c, req);
+reterr:
 	return ERR_PTR(safe_errno(err));
 }
 
@@ -879,15 +877,19 @@ static void p9_fid_destroy(struct p9_fid
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
@@ -1057,6 +1059,8 @@ EXPORT_SYMBOL(p9_client_create);
 void p9_client_destroy(struct p9_client *clnt)
 {
 	struct p9_fid *fid;
+	unsigned long flags;
+	bool empty;
 	int id;
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
@@ -1068,13 +1072,18 @@ void p9_client_destroy(struct p9_client
 
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


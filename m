Return-Path: <linux-kernel+bounces-186806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72388CC986
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFBB2822C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72814885A;
	Wed, 22 May 2024 23:20:13 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2CB7D3E8
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420012; cv=none; b=kqiuQCYZP1iByt9wB/2WVww6bP9o5Tr/0fTrJl/nIo0TYERpFteoBHrYEau3SOBXKSJipwOSwAD+v26QgEPCUICOlHf79uZ91+fOwebkcERB4lkXtzQGnnO19p1n3UeLgUIPUqcjqP7LHmwt3ZipExKot+KWSbImz7Q+wyFCsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420012; c=relaxed/simple;
	bh=dXd2mhPWPnx04YwdigGHId8KzI8B9j/ucx3cNebLfAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWqiibkXYfCq4W9J3KjCHYVy0Oyb2AOWMRvGQACpZNe2CLuI8T/SkXTV/UBCfWkSf9TT08Gm2kjCANWYFciyW8IggxrTOQa0eXYmFxK0cweKzGj9P+PUwBdRNzPHCNub/aX0djA7jVs84YcjaFKidt/lLAU6qPd5lDqurRMwHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.155])
	by sina.com (10.75.12.45) with ESMTP
	id 664E7D9A00003401; Wed, 23 May 2024 07:19:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 85407631457758
X-SMAIL-UIID: B4A62CD5E4EC40B0AFA8BA6BCEBBFBCC-20240523-071956-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	David Howells <dhowells@redhat.com>,
	asmadeus@codewreck.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
Date: Thu, 23 May 2024 07:19:44 +0800
Message-Id: <20240522231944.2312-1-hdanton@sina.com>
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

Test David's patch [1]
[1] https://lore.kernel.org/lkml/463668.1716412143@warthog.procyon.org.uk/

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  ea5f6ad9ad96

--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,6 +353,7 @@ void v9fs_evict_inode(struct inode *inod
 		version = cpu_to_le32(v9inode->qid.version);
 		netfs_clear_inode_writeback(inode, &version);
 
+		netfs_wait_for_outstanding_io(inode);
 		clear_inode(inode);
 		filemap_fdatawrite(&inode->i_data);
 
@@ -360,8 +361,10 @@ void v9fs_evict_inode(struct inode *inod
 		if (v9fs_inode_cookie(v9inode))
 			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
-	} else
+	} else {
+		netfs_wait_for_outstanding_io(inode);
 		clear_inode(inode);
+	}
 }
 
 struct inode *
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -652,6 +652,7 @@ void afs_evict_inode(struct inode *inode
 
 	afs_set_cache_aux(vnode, &aux);
 	netfs_clear_inode_writeback(inode, &aux);
+	netfs_wait_for_outstanding_io(inode);
 	clear_inode(inode);
 
 	while (!list_empty(&vnode->wb_keys)) {
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -72,6 +72,7 @@ struct netfs_io_request *netfs_alloc_req
 		}
 	}
 
+	atomic_inc(&ctx->io_count);
 	trace_netfs_rreq_ref(rreq->debug_id, 1, netfs_rreq_trace_new);
 	netfs_proc_add_rreq(rreq);
 	netfs_stat(&netfs_n_rh_rreq);
@@ -124,6 +125,7 @@ static void netfs_free_request(struct wo
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
+	struct netfs_inode *ictx = netfs_inode(rreq->inode);
 	unsigned int i;
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
@@ -142,6 +144,9 @@ static void netfs_free_request(struct wo
 		}
 		kvfree(rreq->direct_bv);
 	}
+
+	if (atomic_dec_and_test(&ictx->io_count))
+		wake_up_var(&ictx->io_count);
 	call_rcu(&rreq->rcu, netfs_free_request_rcu);
 }
 
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -435,6 +435,7 @@ cifs_evict_inode(struct inode *inode)
 	if (inode->i_state & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
 	cifs_fscache_release_inode_cookie(inode);
+	netfs_wait_for_outstanding_io(inode);
 	clear_inode(inode);
 }
 
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -68,6 +68,7 @@ struct netfs_inode {
 	loff_t			remote_i_size;	/* Size of the remote file */
 	loff_t			zero_point;	/* Size after which we assume there's no data
 						 * on the server */
+	atomic_t		io_count;	/* Number of outstanding reqs */
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
@@ -472,6 +473,7 @@ static inline void netfs_inode_init(stru
 	ctx->remote_i_size = i_size_read(&ctx->inode);
 	ctx->zero_point = LLONG_MAX;
 	ctx->flags = 0;
+	atomic_set(&ctx->io_count, 0);
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif
@@ -515,4 +517,20 @@ static inline struct fscache_cookie *net
 #endif
 }
 
+/**
+ * netfs_wait_for_outstanding_io - Wait for outstanding I/O to complete
+ * @ctx: The netfs inode to wait on
+ *
+ * Wait for outstanding I/O requests of any type to complete.  This is intended
+ * to be called from inode eviction routines.  This makes sure that any
+ * resources held by those requests are cleaned up before we let the inode get
+ * cleaned up.
+ */
+static inline void netfs_wait_for_outstanding_io(struct inode *inode)
+{
+	struct netfs_inode *ictx = netfs_inode(inode);
+
+	wait_var_event(&ictx->io_count, atomic_read(&ictx->io_count) == 0);
+}
+
 #endif /* _LINUX_NETFS_H */
--


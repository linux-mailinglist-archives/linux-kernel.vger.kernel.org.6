Return-Path: <linux-kernel+bounces-187799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECD8CD8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6C21F229EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B981865B;
	Thu, 23 May 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FrKCnitC"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05597111A8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482807; cv=none; b=ZeSWpzZ4Z0t/6CVzjYtBKR1Its9mPACJ6qXF+XhgL6UJsl+zK8zc1rw6yjcmb9wPowS3Pt5dCsO1ruUdcai810IJAnioLtx16YDOYrpY8Lf8Ugw8b0xlFmdy7WILkYTs6PjdxAAx83oO3YsgaPQEc3CRFx+0bS129MP31lvd+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482807; c=relaxed/simple;
	bh=I5i5zGWNMuOn7J0ifnx4MX+hfaa783FB4e5FYDh8VpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7KEKxk9C4HTvrQ9dpP4ZNlanv/U3IAPJvGWIUY2Cf+FKJNXKbu1PJ1sNJN8QBQNo/40oX+MRNUk1QgOIAZo08tfizvKAK/44bSss3PvDY4+7aYWU6LMkMw84xmGmauTxYuIi1Widpf9DOs2c121F3MLLIsEJ4uVKkSmdZHXxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FrKCnitC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id E12CA14C2DB;
	Thu, 23 May 2024 18:46:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716482801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvEPhPj2os2isBRCT9aAq8KPK2HYIqjnLtKO1iVZGac=;
	b=FrKCnitCbwWOQTRH+bsW+6nQoWETt+Aoyn7FIG1jfij0hIXut0Q8ZmaIJZRS0pKdx0W2cI
	em6FitXMbPNjQM/DFeB8f61tzkCkFA6qDzjstiYHflEuULbG+dLdthcw7B5683npjsAyPs
	0vs2qAo72JqKgoJIuoFW2sP4yTFTBbUs36AQfEaPJDsPJuDKONtvutLfZ/n06SfSGK2cPM
	KzcxRwpQE+6UBJ3hNqBP76OxEAFVwIUXa5vF3ITJB81n9X2ZLlMY8BZERjldRXMpYbUOhy
	vpkGMI92BJIEiqLyURgsvYH4Iy+tO7P0QY+LqVY9ZHxvCSE3fjsv9SDtMOayjA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id bff7c78c;
	Thu, 23 May 2024 16:46:34 +0000 (UTC)
Date: Fri, 24 May 2024 01:46:19 +0900
From: asmadeus@codewreck.org
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>,
	brauner@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in
 p9_fid_destroy
Message-ID: <Zk9y21FktxyLGqDJ@codewreck.org>
References: <00000000000092914806191382ac@google.com>
 <580959.1716475058@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <580959.1716475058@warthog.procyon.org.uk>

David Howells wrote on Thu, May 23, 2024 at 03:37:38PM +0100:
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> netfs, 9p: Fix race between umount and async request completion [v2]
> 
> There's a problem in 9p's interaction with netfslib whereby a crash occurs
> because the 9p_fid structs get forcibly destroyed during client teardown
> (without paying attention to their refcounts) before netfslib has finished
> with them.  However, it's not a simple case of deferring the clunking that
> p9_fid_put() does as that requires the client.

"as that requires the client" doesn't parse

> The problem is that netfslib has to unlock pages and clear the IN_PROGRESS
> flag before destroying the objects involved - including the pid - and, in

s/pid/fid/

> any case, nothing checks to see if writeback completed barring looking at
> the page flags.
> 
> Fix this by keeping a count of outstanding I/O requests (of any type) and
> waiting for it to quiesce during inode eviction.
> 
> Reported-by: syzbot+df038d463cca332e8414@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/0000000000005be0aa061846f8d6@google.com/
> Reported-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000b86c5e06130da9c6@google.com/
> Reported-by: syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000041f960618206d7e@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>

With these two nitpicks in commit message addressed, looks good to me,
thanks!

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Hillf Danton <hdanton@sina.com>
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> 
> Notes:
>     Changes
>     =======
>     ver #2)
>      - Wait for outstanding I/O before clobbering the pagecache.
> 
> ---
>  fs/9p/vfs_inode.c      |    1 +
>  fs/afs/inode.c         |    1 +
>  fs/netfs/objects.c     |    5 +++++
>  fs/smb/client/cifsfs.c |    1 +
>  include/linux/netfs.h  |   18 ++++++++++++++++++
>  5 files changed, 26 insertions(+)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 8c9a896d691e..effb3aa1f3ed 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -349,6 +349,7 @@ void v9fs_evict_inode(struct inode *inode)
>  	__le32 __maybe_unused version;
>  
>  	if (!is_bad_inode(inode)) {
> +		netfs_wait_for_outstanding_io(inode);
>  		truncate_inode_pages_final(&inode->i_data);
>  
>  		version = cpu_to_le32(v9inode->qid.version);
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 94fc049aff58..15bb7989c387 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -648,6 +648,7 @@ void afs_evict_inode(struct inode *inode)
>  
>  	ASSERTCMP(inode->i_ino, ==, vnode->fid.vnode);
>  
> +	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
>  
>  	afs_set_cache_aux(vnode, &aux);
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index c90d482b1650..f4a642727479 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -72,6 +72,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
>  		}
>  	}
>  
> +	atomic_inc(&ctx->io_count);
>  	trace_netfs_rreq_ref(rreq->debug_id, 1, netfs_rreq_trace_new);
>  	netfs_proc_add_rreq(rreq);
>  	netfs_stat(&netfs_n_rh_rreq);
> @@ -124,6 +125,7 @@ static void netfs_free_request(struct work_struct *work)
>  {
>  	struct netfs_io_request *rreq =
>  		container_of(work, struct netfs_io_request, work);
> +	struct netfs_inode *ictx = netfs_inode(rreq->inode);
>  	unsigned int i;
>  
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
> @@ -142,6 +144,9 @@ static void netfs_free_request(struct work_struct *work)
>  		}
>  		kvfree(rreq->direct_bv);
>  	}
> +
> +	if (atomic_dec_and_test(&ictx->io_count))
> +		wake_up_var(&ictx->io_count);
>  	call_rcu(&rreq->rcu, netfs_free_request_rcu);
>  }
>  
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index ec5b639f421a..14810ffd15c8 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -431,6 +431,7 @@ cifs_free_inode(struct inode *inode)
>  static void
>  cifs_evict_inode(struct inode *inode)
>  {
> +	netfs_wait_for_outstanding_io(inode);
>  	truncate_inode_pages_final(&inode->i_data);
>  	if (inode->i_state & I_PINNING_NETFS_WB)
>  		cifs_fscache_unuse_inode_cookie(inode, true);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index d2d291a9cdad..3ca3906bb8da 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -68,6 +68,7 @@ struct netfs_inode {
>  	loff_t			remote_i_size;	/* Size of the remote file */
>  	loff_t			zero_point;	/* Size after which we assume there's no data
>  						 * on the server */
> +	atomic_t		io_count;	/* Number of outstanding reqs */
>  	unsigned long		flags;
>  #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
>  #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
> @@ -474,6 +475,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
>  	ctx->remote_i_size = i_size_read(&ctx->inode);
>  	ctx->zero_point = LLONG_MAX;
>  	ctx->flags = 0;
> +	atomic_set(&ctx->io_count, 0);
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	ctx->cache = NULL;
>  #endif
> @@ -517,4 +519,20 @@ static inline struct fscache_cookie *netfs_i_cookie(struct netfs_inode *ctx)
>  #endif
>  }
>  
> +/**
> + * netfs_wait_for_outstanding_io - Wait for outstanding I/O to complete
> + * @ctx: The netfs inode to wait on
> + *
> + * Wait for outstanding I/O requests of any type to complete.  This is intended
> + * to be called from inode eviction routines.  This makes sure that any
> + * resources held by those requests are cleaned up before we let the inode get
> + * cleaned up.
> + */
> +static inline void netfs_wait_for_outstanding_io(struct inode *inode)
> +{
> +	struct netfs_inode *ictx = netfs_inode(inode);
> +
> +	wait_var_event(&ictx->io_count, atomic_read(&ictx->io_count) == 0);
> +}
> +
>  #endif /* _LINUX_NETFS_H */
> 

-- 
Dominique Martinet | Asmadeus


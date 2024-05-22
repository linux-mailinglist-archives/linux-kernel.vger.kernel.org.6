Return-Path: <linux-kernel+bounces-186719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD5B8CC7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7051C20E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E21146D4E;
	Wed, 22 May 2024 21:09:18 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA97146A6F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412157; cv=none; b=RlFvh8mw0g/JyiPLBHnGLmViKupbFM7kDQ3LmEos4a4a45NqXipy5NY94A9qU/haaCqp3mqMfscp282oVRV4dOoI4ZnqtKOxHSvY6AcQ8dLCppUd/+eSBT1vVcIHK3luqOtPwyD5lUwrG58JgECCxzhHotXrqYy5+BpuotKupdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412157; c=relaxed/simple;
	bh=aXxds2gS8M6g8+0jbtaEsKDlYla8S/tUCwUza+959xA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WCwUsY/ZBzCB8V3fNccOn3/Usdx17z8oYtkkrdCpfRouYaYejFZFD8FdlDhbJpVCMf7XqhInZtxHxKxxKm+/mT4XSvD5PPodJB64WxCMMrcdlBOnD5j55xBLRHPYWjPDRy4jdxpREnRb2dnP0qs8oxlbujZALUAKsaHF3xLNsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1d3928fd4so84752439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412154; x=1717016954;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58r0grKkGQMG2BdWLBCqIftRrEEgAxNVyp/0nd1EmWw=;
        b=MxKdJYLTAsioqILue2iqO53P3wqC79aaZEhx8BkzybsvTJ11Hl9cGmF19OiDfpeQpU
         uKTUYLm6s1742yuKZITPYnM3oqF+36TiFZZKyd23TJOUxYLP1wRIu3ntvsgnj5LW/2gk
         kw9W3wY0cs18njNZGBvdSQezvekxsSyrQPKWdoHuhoCCLa+9WYuqsRMcSrSUzbK5fCyQ
         JdnjmjbcX2SECij0GbsTKYQbQR67Rxp7ljgmhVFTdFbRjB+yVzg0LVZiL0loI9nD/Bwo
         oLwp/in+QTXrhqfXH68kuYwj2WUVwOXfF9xbRC8yqnDTfbcTCVwLInEQFKjB/JuOv4RC
         2svA==
X-Forwarded-Encrypted: i=1; AJvYcCWZm5aaXYNApbM46xiv0vtDSVIzp3+V9hjl4RVMozcp3Gb+EBzQeKuGTLrBQ1vdfF26qxjPzs2lkb8n5Hkbqbuvu8yvU+Hgo76fVsMc
X-Gm-Message-State: AOJu0Yxcmf3B58Pdh63n89jz4Jr2/9Ia+YN0lKf+MqTrDLeki3JDK9NQ
	6CN6rwlUlZGos7+rAapvjHI/FRjbKctvQJrRjE0mW9eRIiWRjMuFDiXq3ZlvoLBOPROyTpB4Smg
	8+CZieIl61RPl9gSftxIqWayRsfJDQFCZoHCjSU7ZM2ZjveHyoUQgc3g=
X-Google-Smtp-Source: AGHT+IEb1lSYbYBvp2xeYfjpqu0mMSv7jZ8ZiO2TKW6leY0sHrF95m/jVoTqyq+KSywbluzIka1TygdqIF79vPp16l9Lp8yHA9tq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:b0:36c:4c5b:ce1 with SMTP id
 e9e14a558f8ab-371fb92092dmr2126305ab.5.1716412154315; Wed, 22 May 2024
 14:09:14 -0700 (PDT)
Date: Wed, 22 May 2024 14:09:14 -0700
In-Reply-To: <463668.1716412143@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf1a9806191158b5@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Write in v9fs_free_request
From: syzbot <syzbot+df038d463cca332e8414@syzkaller.appspotmail.com>
To: dhowells@redhat.com
Cc: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, jlayton@kernel.org, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, netfs@lists.linux.dev, 
	sfrench@samba.org, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
> netfs, 9p: Fix race between umount and async request completion
>
> There's a problem in 9p's interaction with netfslib whereby a crash occurs
> because the 9p_fid structs get forcibly destroyed during client teardown
> (without paying attention to their refcounts) before netfslib has finished
> with them.  However, it's not a simple case of deferring the clunking that
> p9_fid_put() does as that requires the client.
>
> The problem is that netfslib has to unlock pages and clear the IN_PROGRESS
> flag before destroying the objects involved - including the pid - and, in
> any case, nothing checks to see if writeback completed barring looking at
> the page flags.
>
> Fix this by keeping a count of outstanding I/O requests (of any type) and
> waiting for it to quiesce during inode eviction.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/9p/vfs_inode.c      |    5 ++++-
>  fs/afs/inode.c         |    1 +
>  fs/netfs/objects.c     |    5 +++++
>  fs/smb/client/cifsfs.c |    1 +
>  include/linux/netfs.h  |   18 ++++++++++++++++++
>  5 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 8c9a896d691e..57cfa9f65046 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -354,6 +354,7 @@ void v9fs_evict_inode(struct inode *inode)
>  		version = cpu_to_le32(v9inode->qid.version);
>  		netfs_clear_inode_writeback(inode, &version);
>  
> +		netfs_wait_for_outstanding_io(inode);
>  		clear_inode(inode);
>  		filemap_fdatawrite(&inode->i_data);
>  
> @@ -361,8 +362,10 @@ void v9fs_evict_inode(struct inode *inode)
>  		if (v9fs_inode_cookie(v9inode))
>  			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
>  #endif
> -	} else
> +	} else {
> +		netfs_wait_for_outstanding_io(inode);
>  		clear_inode(inode);
> +	}
>  }
>  
>  struct inode *
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 94fc049aff58..c831e711a4ac 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -652,6 +652,7 @@ void afs_evict_inode(struct inode *inode)
>  
>  	afs_set_cache_aux(vnode, &aux);
>  	netfs_clear_inode_writeback(inode, &aux);
> +	netfs_wait_for_outstanding_io(inode);
>  	clear_inode(inode);
>  
>  	while (!list_empty(&vnode->wb_keys)) {
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
> index ec5b639f421a..21c9e173ea9a 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -435,6 +435,7 @@ cifs_evict_inode(struct inode *inode)
>  	if (inode->i_state & I_PINNING_NETFS_WB)
>  		cifs_fscache_unuse_inode_cookie(inode, true);
>  	cifs_fscache_release_inode_cookie(inode);
> +	netfs_wait_for_outstanding_io(inode);
>  	clear_inode(inode);
>  }
>  
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


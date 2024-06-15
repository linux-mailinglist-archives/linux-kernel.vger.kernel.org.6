Return-Path: <linux-kernel+bounces-216062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFD909AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8B81F21AF2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD461FD1;
	Sat, 15 Jun 2024 23:53:03 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C638DDB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718495583; cv=none; b=H/GgmVG9GxtpaJP9qYFpdz2otgADL0ub8C0Bq644icMR861SA0CFsDhlXuqCMzylP+N7PuL9sPhBwpB30yJR8QI9GByvLnpnQI80Dq1tPrWOoFfhrbmpx5djVCTZKoC4/e3wdyrwkIjdJ2MXnnypHXa0au6ejqwuWKXlekLgUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718495583; c=relaxed/simple;
	bh=vN6PP7hBwU0zBLnBaoXnkxipyRBOgrc17LMmBVxavN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOJ3S9+eCuYqkgyDb1aTG6aZzRHXSpG/O6T4ro+H05I55agOGrlMccIZcWN3OK/IlN3EGuY50g+w1xysGml05v11KCEXHPLY4ZIlYsZAyEChvjeFNOAuwNLUh3J8Fwtax5WivkOu7pbXec1SUGFNwZhvPsZs6BMJDP/1PePkXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.2])
	by sina.com (172.16.235.25) with ESMTP
	id 666E294D00005E62; Sat, 16 Jun 2024 07:52:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 89047434210117
X-SMAIL-UIID: B5F68BFFE1BC4398B8FF78159B84E9A2-20240616-075247-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: Re: [RFC PATCH] mm: truncate: flush lru cache for evicted inode
Date: Sun, 16 Jun 2024 07:52:38 +0800
Message-Id: <20240615235238.1079-1-hdanton@sina.com>
In-Reply-To: <Zm39RkZMjHdui8nh@casper.infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 15 Jun 2024 21:44:54 +0100 Matthew Wilcox wrote:
> On Sat, Jun 15, 2024 at 07:59:53AM +0800, Hillf Danton wrote:
> > On Fri, 14 Jun 2024 14:42:20 +0100 Matthew Wilcox wrote:
> > > On Fri, Jun 14, 2024 at 09:18:56PM +0800, Hillf Danton wrote:
> > > > Flush lru cache to avoid folio->mapping uaf in case of inode teardown.
> > > 
> > > What?  inodes are supposed to have all their folios removed before
> > > being freed.  Part of removing a folio sets the folio->mapping to NULL.
> > > Where is the report?
> > >
> > Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
> > https://lore.kernel.org/lkml/000000000000cae276061aa12d5e@google.com/
> 
> Thanks.  This fix is wrong.  Of course syzbot says it fixes the problem,
> but you're just avoiding putting the folios into the situation where we
> have debug that would detect the problem.
> 
> I suspect this would trigger:
> 
Happy to test your idea.

> +++ b/fs/inode.c
> @@ -282,6 +282,7 @@ static struct inode *alloc_inode(struct super_block *sb)
>  void __destroy_inode(struct inode *inode)
>  {
>         BUG_ON(inode_has_buffers(inode));
> +       BUG_ON(inode->i_data.nrpages);
>         inode_detach_wb(inode);
>         security_inode_free(inode);
>         fsnotify_inode_delete(inode);
> 
> and what a real fix would look like would be calling clear_inode()
> before calling iput() in nilfs_put_root().  But I'm not an expert

Hm...given I_FREEING checked in clear_inode(), fix like this one could be
tried in midle 2026.

> in this layer of the VFS, so I might well be wrong.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  83a7eefedc9b

--- x/mm/truncate.c
+++ y/mm/truncate.c
@@ -419,6 +419,9 @@ void truncate_inode_pages_range(struct a
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		folio_batch_release(&fbatch);
 	}
+
+	if (mapping_exiting(mapping))
+		lru_add_drain_all();
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
--- x/fs/inode.c
+++ y/fs/inode.c
@@ -282,6 +282,7 @@ static struct inode *alloc_inode(struct
 void __destroy_inode(struct inode *inode)
 {
 	BUG_ON(inode_has_buffers(inode));
+	BUG_ON(inode->i_data.nrpages);
 	inode_detach_wb(inode);
 	security_inode_free(inode);
 	fsnotify_inode_delete(inode);
--


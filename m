Return-Path: <linux-kernel+bounces-512937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C3A33F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C79188A4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0E221715;
	Thu, 13 Feb 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnWP/P4t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13021D3FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450952; cv=none; b=lAIGBAAE2WDAjyZywqPVVnsV/Su9ZQ2826+02ROikEAP7h6Zzb6zltYDleQ4nsNUw/dLnPhJ+YIPCsuOFLUI+/c4PRBhuy7luRZHIDk0y+XhH7pkoSR1x4Ferd+xi+oQz+ePEdRS3fEpKwpMhyuHOJgMsby6XvQo23PZ+kME0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450952; c=relaxed/simple;
	bh=O8SPh+bndCb8RRfZPPh0hvV608yyo8x2VYnQVt6Kws0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuhWFfX3+WYe+leQ7LzPzSZuXLMyIfOo2cCmI0x0I7B+yn8e8JxCl71OHoo7Yhjm9Q9mC63h/rJwHHIq/46KWB4tJlk783/02VtNJ2IY4pDWpoGQ60fG23ZVt2DOTQPOArBpN3tLGwXbmHNVueUHyOpESzq3iPu5gNKNQeYBZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnWP/P4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739450948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oGHBEhaSV/0FuKCxXcabrcQZRyi9d0okvwW5iagFBfg=;
	b=SnWP/P4twtr9BdrkatRAwkJwScFqFQMXTGKuNznTDxU8QqYpHJRf54oXBtGA9GUZLU9No4
	sexl4hkiFfF8+0HZXzZbchdkRh+Mu56tMWWYq8O7Y6EJb0LwH4ljHD1nYOEiXDISfSOgsW
	crxVMHLGwqQoeqUs9V0iSbKoWEVM2pg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-D1pxYgtgOImg-i8E71vjSQ-1; Thu,
 13 Feb 2025 07:49:05 -0500
X-MC-Unique: D1pxYgtgOImg-i8E71vjSQ-1
X-Mimecast-MFC-AGG-ID: D1pxYgtgOImg-i8E71vjSQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEECE19039C6;
	Thu, 13 Feb 2025 12:49:02 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5824C1955DCE;
	Thu, 13 Feb 2025 12:48:59 +0000 (UTC)
Date: Thu, 13 Feb 2025 07:51:25 -0500
From: Brian Foster <bfoster@redhat.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
Message-ID: <Z63qzaDONxM9fRVl@bfoster>
References: <20250213112247.3168709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213112247.3168709-1-libaokun@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Feb 13, 2025 at 07:22:47PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
> happen because filemap_invalidate_unlock() isn't called to unlock
> mapping->invalidate_lock. Like this:
> 
> EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
> INFO: task fsstress:374 blocked for more than 122 seconds.
>       Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
>                                   task_flags:0x440140 flags:0x00000000
> Call Trace:
>  <TASK>
>  __schedule+0x2c9/0x7f0
>  schedule+0x27/0xa0
>  schedule_preempt_disabled+0x15/0x30
>  rwsem_down_read_slowpath+0x278/0x4c0
>  down_read+0x59/0xb0
>  page_cache_ra_unbounded+0x65/0x1b0
>  filemap_get_pages+0x124/0x3e0
>  filemap_read+0x114/0x3d0
>  vfs_read+0x297/0x360
>  ksys_read+0x6c/0xe0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---

First off, thank you for catching this. :)

>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3cc8da6357aa..04ffd802dbde 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5452,7 +5452,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  			    oldsize & (inode->i_sb->s_blocksize - 1)) {
>  				error = ext4_inode_attach_jinode(inode);
>  				if (error)
> -					goto err_out;
> +					goto out_mmap_sem;
>  			}

This looks reasonable to me, but I notice that the immediate previous
error check looks like this:

		...
                rc = ext4_break_layouts(inode);
                if (rc) {
                        filemap_invalidate_unlock(inode->i_mapping);
                        goto err_out;
                }
		...

... and then the following after the broken logic uses out_mmap_sem.
Could we be a little more consistent here one way or the other? The
change looks functionally correct to me either way:

Reviewed-by: Brian Foster <bfoster@redhat.com>

Brian

>  
>  			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
> -- 
> 2.39.2
> 
> 



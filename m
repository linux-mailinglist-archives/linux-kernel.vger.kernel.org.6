Return-Path: <linux-kernel+bounces-229868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030AB917559
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B201C217BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC728F47;
	Wed, 26 Jun 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d4a38QBM"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52017F5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363085; cv=none; b=Cd+ZcPYXKoGG2sPZzGiGOK3BDmIdC1EnRpJRSEK2Mxj2fw67wZZHY4HDxiEVcpStYzNNWU4a3pjcsmng4nBqHX+MEynllx8UFcCMIlCejtISOvCgcA9Hp5GKjQ5Gw4lt7Fh0m3+CPvd7tsrbemR6rtKIMxqOy+oIYfo+T4EOPb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363085; c=relaxed/simple;
	bh=M2tTBeeMC3JEA1lCKPRJZZLiUCcNyQkaTcUVYnHWHn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTVfxH/nkHf3jCx8fIKabW7RkGlrjVAvl/vgsc7SD3CScbn14S5D/zLJDELMT7JN0bYmUPAG1dokO1laXMLma43P/0X73vmxVThScNcT4BCnK148b68CJUPDrd0wd/HpVCsCd3SgxPdq/ky1mMaeSaKeX7S/XxM6h9tRoaDkApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d4a38QBM; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: peili.dev@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719363070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJh6mZInsrSkIexxcMGrQd90IxJJkNWdd5tzdioRZzY=;
	b=d4a38QBMWQJNKG57sfzEtJXUCG+/eb9xFqTqlWg+OroIfc8W0f1bvfj2HeRTKLJ+rNLww6
	CQY8rtFn/cGdH1Vn81tk6MeCH45GNO1vs+J9j248MYZiTPrrkHcF6QLBsO0FeSiuAI4va+
	9gaun2eiMN7RwE6xf4rnZLcNSSb5kco=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: skhan@linuxfoundation.org
X-Envelope-To: linux-kernel-mentees@lists.linuxfoundation.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
X-Envelope-To: syzbot+770e99b65e26fa023ab1@syzkaller.appspotmail.com
Date: Tue, 25 Jun 2024 20:51:04 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pei Li <peili.dev@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
	syzbot+770e99b65e26fa023ab1@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: Fix kmalloc bug in __snapshot_t_mut
Message-ID: <goqpw7dkw4zadoutq3ekp3cd3ve2y4ufci5etap3lmwh7rbbxp@v4vsiz6p3dcg>
References: <20240625-bug3-v1-1-366d4884ab71@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-bug3-v1-1-366d4884ab71@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 25, 2024 at 05:39:56PM -0700, Pei Li wrote:
> When allocating too huge a snapshot table, we should fail gracefully
> in __snapshot_t_mut() instead of fail in kmalloc().
> 
> Reported-by: syzbot+770e99b65e26fa023ab1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=770e99b65e26fa023ab1
> Tested-by: syzbot+770e99b65e26fa023ab1@syzkaller.appspotmail.com
> Signed-off-by: Pei Li <peili.dev@gmail.com>
> ---
> Syzbot reported the following warning in kmalloc().
> 
> bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=crc64,data_checksum=xxhash,compression=gzip,str_hash=crc64,nojournal_transaction_names
> bcachefs (loop0): recovering from clean shutdown, journal seq 7
> bcachefs (loop0): alloc_read... done
> bcachefs (loop0): stripes_read... done
> bcachefs (loop0): snapshots_read...
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5078 at mm/util.c:649 kvmalloc_node_noprof+0x17a/0x190 mm/util.c:649
> 
> We are passing a huge new_bytes (greater than INT_MAX) to kmalloc().
> 
> This is likely caused by either we run out of snapshot entries when
> calculating the size of snapshot table, or an invalid bkey was read.
> 
> Instead of failing at kmalloc(), handle this error when a large size of
> memory is going to be requested and return NULL directly.
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> any issue.
> 
> Tested on:
> 
> commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f3a389980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf5def5af476d39a
> dashboard link: https://syzkaller.appspot.com/bug?extid=770e99b65e26fa023ab1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=170174c1980000
> 
> Note: testing is done by a robot and is best-effort only.

Thanks, nice fix - applied

> ---
>  fs/bcachefs/snapshot.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
> index 629900a5e641..e3303aea8b29 100644
> --- a/fs/bcachefs/snapshot.c
> +++ b/fs/bcachefs/snapshot.c
> @@ -168,6 +168,9 @@ static noinline struct snapshot_t *__snapshot_t_mut(struct bch_fs *c, u32 id)
>  	size_t new_bytes = kmalloc_size_roundup(struct_size(new, s, idx + 1));
>  	size_t new_size = (new_bytes - sizeof(*new)) / sizeof(new->s[0]);
>  
> +	if (unlikely(new_bytes > INT_MAX))
> +		return NULL;
> +
>  	new = kvzalloc(new_bytes, GFP_KERNEL);
>  	if (!new)
>  		return NULL;
> 
> ---
> base-commit: c13320499ba0efd93174ef6462ae8a7a2933f6e7
> change-id: 20240625-bug3-9660c6b76f20
> 
> Best regards,
> -- 
> Pei Li <peili.dev@gmail.com>
> 


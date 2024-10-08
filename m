Return-Path: <linux-kernel+bounces-355660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F244799556E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB588288B03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803C1E132F;
	Tue,  8 Oct 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IytfFEAY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313221E0DD0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407702; cv=none; b=rQ6Z6RU85v2YpbxkbbxOvtQaJtkOPh9BvMARs5WTxRBVlCvlcd1mCIjElHrrsRwqbyIvRgJip+BqVekkF3ZsJPWwSlYh+kKMfh8YfouQzZdMy7s1jfhsI8C8nu31sNDRyJF1XxhePRlAhosoMRG9ENuZfUKlbHW83VD+Pk8ZTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407702; c=relaxed/simple;
	bh=BqYIVnVHWaVlhucZPqBW3PZHUCAWnqu27LsaubLws+A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig4umwDpY266YezqECQRBlQQBPYWWljmha6/pwevAV7Xwx9S7vLsGeeVlXiq0hSmb9MeQuCb/mAp5Jj6sEJxgs9gn2ZO/uJt6YXoq2VOujW4a2i+w+9SnlFEKaAXUpoisxl7HkWReUx37AKMnzC39XqMcnYGFXjyQAMrEsZzUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IytfFEAY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53997328633so7856532e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728407698; x=1729012498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SX0pbnsdILfbcGrVukreqn4EPvlqj/XdQnKrLpVXVz0=;
        b=IytfFEAYX9ApTbjrI70VMWKMFYyWU3RlPtLh2tffKJEMqS7v3uTLya28aPmRqAZrnM
         nk0ZBYqPgfqqaiEzq710a2ibtJ97KYC/gP/Jv+CGVAlvozpA8onXAgCkzB6/sIi5/ZM2
         c4LMY0wJSxYSPqF7puptGKpmBIHQojsu2p1eWXTACwWeJMHJsMin4xKJN2A95Vo+0KTv
         +OWVKHG8LiizM8Fkjxp405LC+RhJbv7pyQFUAJnDHQvhuF/kky/39+tIfuM1AyEBESu0
         H7jUg8Jya4chVsHLXwFOVzOIli/rs8dofb34BeeWp3SH7gP/MxgxEHSeJWVhDnTG85Ra
         MyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728407698; x=1729012498;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX0pbnsdILfbcGrVukreqn4EPvlqj/XdQnKrLpVXVz0=;
        b=H3wQAkBD8aHSSIVEipREpNFdk2zVWiIY5muvCrq/lEirh8hIqKTNGDDOr68iDL/C3S
         E3oQKXeJ3GIdew6CXv8I4jSd7ncrhY2yLJZGX3NRwL21icfhCLhnZ/nOVU+Ih3ckZfZ9
         K9nVJa7Y3TupGobN9JPBu0APwPnRFdCrShW9EyT1XVgCAvliGgECvn3zKoTmqFRGbm7Q
         O9yLlgFxtZlCfy+De0CipH0e8DQSV08nUFxuxMwVT/GqBopFHdIHl8gwKVRwIpP+dQfx
         ZyVVqzNjGak48BkgmEo++igMMPGjPJ0FGuGil3Vr3FG7X6LYcZsye+ssJRh+CdATh9Ah
         dVMw==
X-Gm-Message-State: AOJu0Yzt60vteIXScVVtBDk78FeC1hYvwRRUwasUIgkrMUSKb0t8zVoQ
	w4douC4NicinEyipUnp0eT22Lnm1qjcsvG1o9XNz968Z+gipmWnw
X-Google-Smtp-Source: AGHT+IGUBbeBO0MQmpOV3pSTn/zx8lrPAYrmH10752tqoUPVSxPuBACxMyq0s36VJT20UCoLY0E18A==
X-Received: by 2002:a05:6512:b29:b0:530:ab68:25c5 with SMTP id 2adb3069b0e04-539ab84e022mr10753172e87.2.1728407697962;
        Tue, 08 Oct 2024 10:14:57 -0700 (PDT)
Received: from akanner-r14. ([62.4.55.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9958fee567sm265566866b.158.2024.10.08.10.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:14:57 -0700 (PDT)
Message-ID: <67056891.170a0220.69783.b192@mx.google.com>
X-Google-Original-Message-ID: <ZwVkaqM23G3Kv3Wz@akanner-r14.>
Date: Tue, 8 Oct 2024 18:57:14 +0200
From: Andrew Kanner <andrew.kanner@gmail.com>
To: aivazian.tigran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/bfs: fix possible NULL pointer dereference caused by
 empty i_op/i_fop
References: <20240930090153.505-1-andrew.kanner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930090153.505-1-andrew.kanner@gmail.com>

On Mon, Sep 30, 2024 at 11:01:54AM +0200, Andrew Kanner wrote:
> Syzkaller reported and reproduced the following issue:
> 
> loop0: detected capacity change from 0 to 64
> overlayfs: fs on './file0' does not support file handles, \
>            falling back to index=off,nfs_export=off.
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> [...]
> Comm: syz-executor169 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
> [...]
> Call Trace:
>  <TASK>
>  __lookup_slow+0x28c/0x3f0 fs/namei.c:1718
>  lookup_slow fs/namei.c:1735 [inline]
>  lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2898
>  ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
>  ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
>  ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
>  ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
>  lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
>  filename_create+0x297/0x540 fs/namei.c:3980
>  do_mknodat+0x18b/0x5b0 fs/namei.c:4125
>  __do_sys_mknod fs/namei.c:4171 [inline]
>  __se_sys_mknod fs/namei.c:4169 [inline]
>  __x64_sys_mknod+0x8c/0xa0 fs/namei.c:4169
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc4b42b2839
> 
> However, the actual root cause is not related to overlayfs:
>   (gdb) p lower.dentry->d_inode->i_op
>   $6 = (const struct inode_operations *) 0xffffffff8242fcc0 <empty_iops>
>   (gdb) p lower.dentry->d_inode->i_op->lookup
>   $7 = (struct dentry *(*) \
>        (struct inode *, struct dentry *, unsigned int)) 0x0
> 
> The inode, which is passed to ovl_lookup(), has an empty i_op,
> so the following __lookup_slow() hit NULL doing it's job:
>   old = inode->i_op->lookup(inode, dentry, flags);
> 
> bfs_fill_super()->bfs_iget() are skipping i_op/i_fop initialization
> if vnode type is not BFS_VDIR or BFS_VREG (e.g. corrupted fs).
> Adding extra error handling fixes the issue and syzkaller repro
> doesn't trigger anything bad anymore.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000003d5bc30617238b6d@google.com/T/
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>  fs/bfs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index db81570c9637..e590b231ad20 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -70,6 +70,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
>  		inode->i_op = &bfs_file_inops;
>  		inode->i_fop = &bfs_file_operations;
>  		inode->i_mapping->a_ops = &bfs_aops;
> +	} else {
> +		pr_err("Bad i_vtype for inode %s:%08lx\n", inode->i_sb->s_id, ino);
> +		brelse(bh);
> +		goto error;
>  	}
>  
>  	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
> -- 
> 2.39.3
> 

I sent it when merge window was closing.
Any objections against it now?

It seems to be introduced long time ago, but affects
kernel builds with CONFIG_BFS_FS=y or =m only.

-- 
Andrew Kanner


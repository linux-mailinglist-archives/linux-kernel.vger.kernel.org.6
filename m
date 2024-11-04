Return-Path: <linux-kernel+bounces-394059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED2B9BAA19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7ACC2812E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39017DA6C;
	Mon,  4 Nov 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W8YGY93I"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E026AF6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730682962; cv=none; b=X0Nlt3FUV9/QNGpX5Nez8MJDuxGi5qLxasV+n0GbB8+UY5ghu7mfreqnKDUhDZxx2laW8/3i3/4QUfAg0c9R7TCUfR2o1QWWvVohM2sana+Iqd0httc1dNnKLTelh/GuW5KaupqFe5bThvpURwxDsZIACUVeM10QJAS1VG4wXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730682962; c=relaxed/simple;
	bh=WNs+UH3SpsEIYRPFhnWPBSZQBvS7lYt80V6GL8k2VzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUHonulCkQfGRoMLuipVB31L1KyPsTIf3n7y4Wtm4mjy5Zsnd34YNLDffz4O2LEQ2pZ+R+fEpL3b45AhKuKqBbtdTSME9Oc3KXScF4CfuOjPKaqoQhDnG6HslMVuNe3x8KUhJPzxIbCkaS5jF5+8VpDpe2LvM/r/Nz9pDAW2rJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W8YGY93I; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730682950; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YKwzODTGntxvRaGSa0E2AfCTO5CCgMMH1hNGzM2whho=;
	b=W8YGY93Isxv4zUfGLdJk/f+efjjR0blrMscHcp4kUwOSlE5sbw0BhTvzu9lthZpyiWMdQF+zt1ZXSQRgB7rRsZNBgK+FHaRCfw90UNqkugyeXjY7pg0Yl0O+j5eY99XlVl9bAeaW8CjLhVkl89YYr1TaJqXp0xHZiDOtJxrEvy0=
Received: from 30.221.129.11(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WIZbQlw_1730682948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 09:15:49 +0800
Message-ID: <9d41cff9-2474-4425-bb52-5f7489669abd@linux.alibaba.com>
Date: Mon, 4 Nov 2024 09:15:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: remove entry once instead of
 null-ptr-dereference in ocfs2_xa_remove()
To: Andrew Kanner <andrew.kanner@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
References: <20241103193845.2940988-1-andrew.kanner@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241103193845.2940988-1-andrew.kanner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/24 3:38 AM, Andrew Kanner wrote:
> Syzkaller is able to provoke null-ptr-dereference in ocfs2_xa_remove():
> 
> [   57.319872] (a.out,1161,7):ocfs2_xa_remove:2028 ERROR: status = -12
> [   57.320420] (a.out,1161,7):ocfs2_xa_cleanup_value_truncate:1999 ERROR: Partial truncate while removing xattr overlay.upper.  Leaking 1 clusters and removing the entry
> [   57.321727] BUG: kernel NULL pointer dereference, address: 0000000000000004
> [...]
> [   57.325727] RIP: 0010:ocfs2_xa_block_wipe_namevalue+0x2a/0xc0
> [...]
> [   57.331328] Call Trace:
> [   57.331477]  <TASK>
> [...]
> [   57.333511]  ? do_user_addr_fault+0x3e5/0x740
> [   57.333778]  ? exc_page_fault+0x70/0x170
> [   57.334016]  ? asm_exc_page_fault+0x2b/0x30
> [   57.334263]  ? __pfx_ocfs2_xa_block_wipe_namevalue+0x10/0x10
> [   57.334596]  ? ocfs2_xa_block_wipe_namevalue+0x2a/0xc0
> [   57.334913]  ocfs2_xa_remove_entry+0x23/0xc0
> [   57.335164]  ocfs2_xa_set+0x704/0xcf0
> [   57.335381]  ? _raw_spin_unlock+0x1a/0x40
> [   57.335620]  ? ocfs2_inode_cache_unlock+0x16/0x20
> [   57.335915]  ? trace_preempt_on+0x1e/0x70
> [   57.336153]  ? start_this_handle+0x16c/0x500
> [   57.336410]  ? preempt_count_sub+0x50/0x80
> [   57.336656]  ? _raw_read_unlock+0x20/0x40
> [   57.336906]  ? start_this_handle+0x16c/0x500
> [   57.337162]  ocfs2_xattr_block_set+0xa6/0x1e0
> [   57.337424]  __ocfs2_xattr_set_handle+0x1fd/0x5d0
> [   57.337706]  ? ocfs2_start_trans+0x13d/0x290
> [   57.337971]  ocfs2_xattr_set+0xb13/0xfb0
> [   57.338207]  ? dput+0x46/0x1c0
> [   57.338393]  ocfs2_xattr_trusted_set+0x28/0x30
> [   57.338665]  ? ocfs2_xattr_trusted_set+0x28/0x30
> [   57.338948]  __vfs_removexattr+0x92/0xc0
> [   57.339182]  __vfs_removexattr_locked+0xd5/0x190
> [   57.339456]  ? preempt_count_sub+0x50/0x80
> [   57.339705]  vfs_removexattr+0x5f/0x100
> [...]
> 
> Reproducer uses faultinject facility to fail ocfs2_xa_remove() ->
> ocfs2_xa_value_truncate() with -ENOMEM.
> 
> In this case the comment mentions that we can return 0 if
> ocfs2_xa_cleanup_value_truncate() is going to wipe the entry
> anyway. But the following 'rc' check is wrong and execution flow do
> 'ocfs2_xa_remove_entry(loc);' twice:
> * 1st: in ocfs2_xa_cleanup_value_truncate();
> * 2nd: returning back to ocfs2_xa_remove() instead of going to 'out'.
> 
> Fix this by skipping the 2nd removal of the same entry and making
> syzkaller repro happy.
> 
> Cc: stable@vger.kernel.org
> Fixes: 399ff3a748cf ("ocfs2: Handle errors while setting external xattr values.")
> Reported-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/671e13ab.050a0220.2b8c0f.01d0.GAE@google.com/T/
> Tested-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> 
> Notes (akanner):
>     v2: remove rc check completely, suggested by Joseph Qi <joseph.qi@linux.alibaba.com>
>     v1: https://lore.kernel.org/all/20241029224304.2169092-2-andrew.kanner@gmail.com/T/
> 
>  fs/ocfs2/xattr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index dd0a05365e79..73a6f6fd8a8e 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -2036,8 +2036,7 @@ static int ocfs2_xa_remove(struct ocfs2_xa_loc *loc,
>  				rc = 0;
>  			ocfs2_xa_cleanup_value_truncate(loc, "removing",
>  							orig_clusters);
> -			if (rc)
> -				goto out;
> +			goto out;
>  		}
>  	}
>  



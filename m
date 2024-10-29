Return-Path: <linux-kernel+bounces-386254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E479B4106
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070BD1C220C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F51F472C;
	Tue, 29 Oct 2024 03:28:57 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890FBFC0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172537; cv=none; b=Giz7x+me+gWLC+lVYlKKFDejiJDORbBOkBYorN7+g5hBtmzDlTThVwHLzixPvXRQeu1UcQWu5tVnSxvayTJm7t3aCOjFoe2n5WLzVMVN76ryIlWFcQb90xpnpdjd2f1PTilY8KC4doNmkVZTWdf1SYLOIBqHfCklYBOlwbFJumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172537; c=relaxed/simple;
	bh=gpb3wBQ9W+bhlPqUQXfepHMHvKvtNT/rMxlBwXrVV/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZCM9sx7Lupl0pPjqyz5LpbzANqAqArCorB13h5DV2XuOJuo/eNX5t8a8M6leXLvKzYVrF3HUKmAm1aQkdL329AaASG/5j9aqmmV5nw2BJ1IWIgL3nffmNSF27NRTLYIM1EH5eaLG1Zsfi3CNH/cbc27sXRUhGZqRQrATWKPYbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 71BD9265C747;
	Tue, 29 Oct 2024 12:21:12 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 49T3LBdQ183774
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:21:12 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 49T3LB9A1410944
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:21:11 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 49T3LBEf1410943;
	Tue, 29 Oct 2024 12:21:11 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: linux-kernel@vger.kernel.org (open list),
        syzbot+3999cae1c2d59c2cc8b9@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix BUG: KCSAN: data-race in fat16_ent_get / fat16_ent_put
In-Reply-To: <20241028202645.412589-1-danielyangkang@gmail.com> (Daniel Yang's
	message of "Mon, 28 Oct 2024 13:26:44 -0700")
References: <20241028202645.412589-1-danielyangkang@gmail.com>
Date: Tue, 29 Oct 2024 12:21:11 +0900
Message-ID: <874j4v1tnc.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Yang <danielyangkang@gmail.com> writes:

> Issue is that fat_free() calls fat_get_cluster() and fat_free_clusters()
> at the same time. If the same fatent gets modified, it can lead to a
> race condition where fat16_ent_put() and fat16_ent_get() will read/write
> conflict on fatent->u.ent16_p.
>
> To fix: add critical sections in fat_free() on the offending function
> calls so that they can't both be running at the same time. Since the
> critical sections are short, a spinlock is used since the overhead is
> not that high.

Which case can read and write a same entry on FAT table with it except
corrupted image?  And if corrupted image, I think reading invalid data
is ok if it didn't become the cause of crash.

Thanks.

> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+3999cae1c2d59c2cc8b9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3999cae1c2d59c2cc8b9
> ---
>  fs/fat/file.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index e887e9ab7..d7ae152a9 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -7,6 +7,7 @@
>   *  regular file handling primitives for fat-based filesystems
>   */
>  
> +#include "linux/spinlock.h"
>  #include <linux/capability.h>
>  #include <linux/module.h>
>  #include <linux/compat.h>
> @@ -306,6 +307,9 @@ static long fat_fallocate(struct file *file, int mode,
>  	return err;
>  }
>  
> +/* Prevent data race in fat_free. */
> +static DEFINE_SPINLOCK(cluster_lock);
> +
>  /* Free all clusters after the skip'th cluster. */
>  static int fat_free(struct inode *inode, int skip)
>  {
> @@ -343,7 +347,10 @@ static int fat_free(struct inode *inode, int skip)
>  		struct fat_entry fatent;
>  		int ret, fclus, dclus;
>  
> +		/* Ensure fat_get_cluster isn't called while freeing. */
> +		spin_lock(&cluster_lock);
>  		ret = fat_get_cluster(inode, skip - 1, &fclus, &dclus);
> +		spin_unlock(&cluster_lock);
>  		if (ret < 0)
>  			return ret;
>  		else if (ret == FAT_ENT_EOF)
> @@ -373,7 +380,12 @@ static int fat_free(struct inode *inode, int skip)
>  	inode->i_blocks = skip << (MSDOS_SB(sb)->cluster_bits - 9);
>  
>  	/* Freeing the remained cluster chain */
> -	return fat_free_clusters(inode, free_start);
> +	int ret;
> +
> +	spin_lock(&cluster_lock);
> +	ret = fat_free_clusters(inode, free_start);
> +	spin_unlock(&cluster_lock);
> +	return ret;
>  }
>  
>  void fat_truncate_blocks(struct inode *inode, loff_t offset)

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


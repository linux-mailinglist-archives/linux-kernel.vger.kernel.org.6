Return-Path: <linux-kernel+bounces-576727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C1A713A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB5016A3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659481A707A;
	Wed, 26 Mar 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGFQqUJl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE615161310
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981182; cv=none; b=CuGcU2FXUlBNAdfBmB503BA+yE/mKPDBDnAN5Mctk5kwJ7WgBcc6TkE2XR/BkBvM1WTenU8UDhgclwZT5JR6a5/bVvTOovh0g5GFAt25/oxMV9dkF2z+SkOj0BqhH5X9cxfeuGieLkZ4rdsoRE6i0GEeXzh0ygdxJBiXXkTMmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981182; c=relaxed/simple;
	bh=1ud3vRRXqS1I2uDnOUgws83uw4pDL84Krm3xaR/sLdo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fhrLAtXoKPiyH70W8vGHgalg4ib8x5mErKM2zzijYI2p5v+kU84rY/YcvgbP80cOc9iXIhcnHw9qFknMejChDY6aIpqhdecfRI22uUHMOUE47+E9P8szjc7ZU0eV2yX4pPv2GVLFWn6grsMO8wUX2Q9gOL1k6Nq9ZZWSl742vYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGFQqUJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A72C4CEE2;
	Wed, 26 Mar 2025 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742981182;
	bh=1ud3vRRXqS1I2uDnOUgws83uw4pDL84Krm3xaR/sLdo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YGFQqUJlHJr+GggPvwrpWnZ3irOGWe8S9rr2aZlsFwWilypQ9hoSSuX48gO96QzTC
	 kZwU6aTEqr0GWBigPAa2ZhxybpJ7lwa7Zz0KhZ3q0ayFpbOifMuGm6JZmKyQ09ieEX
	 9jg6DAQiDzv4WJ+6euRzMon/xuWcQeAxhBvvAbgdI2HKXVydyov17JpbSWKE8sBrGL
	 +Ej0/yMz0M5OO6X+dnXJLNkGACc1xo7yV/WztiV3V2KimN007erRBhnij9meIOO4Dk
	 60bdtSg98IgeeS/ajGz3Z5EsDW4xLt3iYtoMSsHQD2MQB4FqBd0FCa9D4D9iRcmaJB
	 rbqOaPiKB8/Pw==
Message-ID: <e4fb11ea-a97b-4ba0-aa28-f6f93e5a6134@kernel.org>
Date: Wed, 26 Mar 2025 17:26:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
Subject: Re: [RFC PATCH] f2fs: remove some redundant flow about
 FI_ATOMIC_DIRTIED
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, daehojeong@google.com,
 jaegeuk@kernel.org
References: <1742978761-16264-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1742978761-16264-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 16:46, Zhiguo Niu wrote:
> Commit fccaa81de87e ("f2fs: prevent atomic file from being dirtied before commit")
> adds the processing of FI_ATOMIC_DIRTIED in the following two positions,
> [1]
> f2fs_commit_atomic_write
>  - __f2fs_commit_atomic_write
>   - sbi->committed_atomic_block += fi->atomic_write_cnt;
>   - set_inode_flag(inode, FI_ATOMIC_COMMITTED);
>   - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
>   -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
>   -    f2fs_mark_inode_dirty_sync(inode, true);
>   - }
> [2]
> f2fs_abort_atomic_write
>   - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
>   -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
>   -    f2fs_mark_inode_dirty_sync(inode, true);
>   - }
> 
> but [1] seems to be redundant:
> The atomic file flag FI_ATOMIC_FILE is still set here, so f2fs_mark_inode_dirty_sync
> still does not set the dirty state to vfs. If FI_ATOMIC_DIRTIED was originally set
> when atomic file is committing, then FI_ATOMIC_DIRTIED is just cleared here, and
> then do the repeating action of setting FI_ATOMIC_DIRTIED?
> So is it enough to do this only in [2]?

Hi Zhiguo,

I checked the code again, finally, I got this, could you please take
a look?

Ping Daeho as well.

Subject: [PATCH] f2fs: fix to set atomic write status more clear

1. After we start atomic write in a database file, before committing
all data, we'd better not set inode w/ vfs dirty status to avoid
redundant updates, instead, we only set inode w/ atomic dirty status.

2. After we commit all data, before committing metadata, we need to
clear atomic dirty status, and set vfs dirty status to allow vfs flush
dirty inode.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c   |  4 +++-
 fs/f2fs/segment.c | 10 ++++++----
 fs/f2fs/super.c   |  4 +++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 5c8634eaef7b..f5991e8751b9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -34,7 +34,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;

-	if (f2fs_is_atomic_file(inode))
+	/* only atomic file w/ FI_ATOMIC_COMMITTED can be set vfs dirty */
+	if (f2fs_is_atomic_file(inode) &&
+			!is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
 		return;

 	mark_inode_dirty_sync(inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dc360b4b0569..28659a71891a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -376,10 +376,12 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	} else {
 		sbi->committed_atomic_block += fi->atomic_write_cnt;
 		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
-		if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
-			clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
-			f2fs_mark_inode_dirty_sync(inode, true);
-		}
+
+		f2fs_bug_on(sbi, !is_inode_flag_set(inode, FI_ATOMIC_DIRTIED));
+
+		/* clear atomic dirty status and set vfs dirty status */
+		clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
+		f2fs_mark_inode_dirty_sync(inode, true);
 	}

 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9a42a1323f42..a5cc9f6ee16a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1532,7 +1532,9 @@ int f2fs_inode_dirtied(struct inode *inode, bool sync)
 	}
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);

-	if (!ret && f2fs_is_atomic_file(inode))
+	/* if atomic write is not committed, set inode w/ atomic dirty */
+	if (!ret && f2fs_is_atomic_file(inode) &&
+			!is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
 		set_inode_flag(inode, FI_ATOMIC_DIRTIED);

 	return ret;
-- 
2.48.1


> 
> Cc: Daeho Jeong <daehojeong@google.com>
> Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied before commit")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/segment.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 396ef71..d4ea3af 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -376,10 +376,6 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>  	} else {
>  		sbi->committed_atomic_block += fi->atomic_write_cnt;
>  		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
> -		if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
> -			clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
> -			f2fs_mark_inode_dirty_sync(inode, true);
> -		}
>  	}
>  
>  	__complete_revoke_list(inode, &revoke_list, ret ? true : false);



Return-Path: <linux-kernel+bounces-356204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647C995DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A555B24E75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044B2A1C9;
	Wed,  9 Oct 2024 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9XIHB99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D341A84
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728441156; cv=none; b=sm0I6WptgYP1f8Snig+HRHJrlzUEibLotl4RQd7MR9evxF2KUph0sJyROMnRBnmTR0itKuesDIFDBSdVYPMLYrsamRGek9l4Vm/4p+Z1Etl3tf54+v0hsWXFSN2ILu3sI37xFKCWh8PwzWNL+vl2lqegj583o6ArqRvZ6d9g6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728441156; c=relaxed/simple;
	bh=IXQoNicX38coNLWQHjkrNmqSpNRxLZQTT6BkS0TFfgQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WpeFO75TIAXGBGN0BiP8hKTFFyrDbYKfIyeMMWPdF+msDNawnLX1RnSdGFCteo+vV0veWxUBP2Jz6GUmxyWMAEbuC5P6aRx1kLuQ4c2m1WfJKi1iuKYdJ6vWVB6Sbg97yIhfZzXTN5kDhOL7Bw5p5ZJOtTrer1OLs36AWP9Zhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9XIHB99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C08C4CEC7;
	Wed,  9 Oct 2024 02:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728441155;
	bh=IXQoNicX38coNLWQHjkrNmqSpNRxLZQTT6BkS0TFfgQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Y9XIHB99Ba72WLo4UuH1314K3SizB1YNOFXPPmnpMUQ/TthEjCbVa6R5Qqgyd9jIT
	 80Bv5CR7UWO+pu2kmY0n4umrFUaR7xgEwk6jvxlA7Wou20bxkkGtkuQnkDqp0D/txx
	 WpDe8a7DJdRNPX0QNmIhliDmFrqpK1SpZtOuQ3FyVZMnkUw4SUE3iJdhjb0MONWbQq
	 Qgk04vN3biZ2FAsBiWpFMGrpUEa7HjXgAw8TmKtn29Cyl0kA7QS0W5o7hClcPUaPLG
	 bi6EYWuvjxl2q5tyyAc2/fCB/3UUtkPD80xN9jez0byR0PXuMic24bE6AAIcW6xlz3
	 yFG6zms5FiOCg==
Message-ID: <ed77a5ab-d572-42d7-b9db-b5f13717e083@kernel.org>
Date: Wed, 9 Oct 2024 10:32:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v4] f2fs: introduce device aliasing file
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20241008180515.3198262-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241008180515.3198262-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/9 2:05, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> F2FS should understand how the device aliasing file works and support
> deleting the file after use. A device aliasing file can be created by
> mkfs.f2fs tool and it can map the whole device with an extrent, not
> using node blocks. The file space should be pinned and normally used for
> read-only usages.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4: added file pinning check in sanity check
> v3: merged Chao's extent cache sanity check.
>      prevented device aliasing support with noextent mount option
> v2: changed the position of f2fs_destroy_extent_tree() only for device
>      aliasing files
> ---
>   fs/f2fs/data.c         |  5 +++++
>   fs/f2fs/extent_cache.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>   fs/f2fs/f2fs.h         |  5 +++++
>   fs/f2fs/file.c         | 36 +++++++++++++++++++++++++++++----
>   fs/f2fs/inode.c        | 19 +++++++++++++++++-
>   fs/f2fs/super.c        |  4 ++++
>   fs/f2fs/sysfs.c        |  2 ++
>   7 files changed, 110 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b94cf6eea2f9..385b46e62ede 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3441,6 +3441,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   
>   	if (!f2fs_lookup_read_extent_cache_block(inode, index,
>   						 &dn.data_blkaddr)) {
> +		if (IS_DEVICE_ALIASING(inode)) {
> +			err = -ENODATA;
> +			goto out;
> +		}
> +
>   		if (locked) {
>   			err = f2fs_reserve_block(&dn, index);
>   			goto out;
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 62ac440d9416..019c1f7b7fa5 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -24,6 +24,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
>   	struct extent_info ei;
> +	int devi;
>   
>   	get_read_extent_info(&ei, i_ext);
>   
> @@ -38,7 +39,36 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
>   			  ei.blk, ei.fofs, ei.len);
>   		return false;
>   	}
> -	return true;
> +
> +	if (!IS_DEVICE_ALIASING(inode))
> +		return true;
> +
> +	for (devi = 0; devi < sbi->s_ndevs; devi++) {
> +		if (FDEV(devi).start_blk != ei.blk ||
> +				FDEV(devi).end_blk != ei.blk + ei.len - 1)
> +			continue;
> +
> +		if (devi == 0) {
> +			f2fs_warn(sbi,
> +			    "%s: inode (ino=%lx) is an alias of meta device",
> +			    __func__, inode->i_ino);
> +			return false;
> +		}
> +
> +		if (bdev_is_zoned(FDEV(devi).bdev)) {
> +			f2fs_warn(sbi,
> +			    "%s: device alias inode (ino=%lx)'s extent info "
> +			    "[%u, %u, %u] maps to zoned block device",
> +			    __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
> +			return false;
> +		}
> +		return true;
> +	}
> +
> +	f2fs_warn(sbi, "%s: device alias inode (ino=%lx)'s extent info "
> +			"[%u, %u, %u] is inconsistent w/ any devices",
> +			__func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
> +	return false;
>   }
>   
>   static void __set_extent_info(struct extent_info *ei,
> @@ -76,6 +106,9 @@ static bool __init_may_extent_tree(struct inode *inode, enum extent_type type)
>   
>   static bool __may_extent_tree(struct inode *inode, enum extent_type type)
>   {
> +	if (IS_DEVICE_ALIASING(inode) && type == EX_READ)
> +		return true;
> +
>   	/*
>   	 * for recovered files during mount do not create extents
>   	 * if shrinker is not registered.
> @@ -401,6 +434,11 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
>   	if (atomic_read(&et->node_cnt) || !ei.len)
>   		goto skip;
>   
> +	if (IS_DEVICE_ALIASING(inode)) {
> +		et->largest = ei;
> +		goto skip;
> +	}
> +
>   	en = __attach_extent_node(sbi, et, &ei, NULL,
>   				&et->root.rb_root.rb_node, true);
>   	if (en) {
> @@ -463,6 +501,11 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
>   		goto out;
>   	}
>   
> +	if (IS_DEVICE_ALIASING(inode)) {
> +		ret = false;
> +		goto out;
> +	}
> +
>   	en = __lookup_extent_node(&et->root, et->cached_en, pgofs);
>   	if (!en)
>   		goto out;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 33f5449dc22d..b6ba22a1da47 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -213,6 +213,7 @@ struct f2fs_mount_info {
>   #define F2FS_FEATURE_CASEFOLD			0x00001000
>   #define F2FS_FEATURE_COMPRESSION		0x00002000
>   #define F2FS_FEATURE_RO				0x00004000
> +#define F2FS_FEATURE_DEVICE_ALIAS		0x00008000
>   
>   #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>   	((raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -3046,6 +3047,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>   #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
>   #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
>   #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
> +#define F2FS_DEVICE_ALIAS_FL		0x80000000 /* File for aliasing a device */

Is there any way to know which inode is device-alias one? maybe
we can export this flag to userspace via .fileattr_get? or via
newly introduced ioctl interface?

>   
>   #define F2FS_QUOTA_DEFAULT_FL		(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
>   
> @@ -3061,6 +3063,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>   /* Flags that are appropriate for non-directories/regular files. */
>   #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
>   
> +#define IS_DEVICE_ALIASING(inode)	(F2FS_I(inode)->i_flags & F2FS_DEVICE_ALIAS_FL)
> +
>   static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
>   {
>   	if (S_ISDIR(mode))
> @@ -4510,6 +4514,7 @@ F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>   F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
>   F2FS_FEATURE_FUNCS(compression, COMPRESSION);
>   F2FS_FEATURE_FUNCS(readonly, RO);
> +F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
>   static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 99903eafa7fe..f2d2d84d025b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -725,6 +725,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>   
>   	trace_f2fs_truncate_blocks_enter(inode, from);
>   
> +	if (IS_DEVICE_ALIASING(inode) && from) {
> +		err = -EINVAL;
> +		goto out_err;
> +	}
> +
>   	free_from = (pgoff_t)F2FS_BLK_ALIGN(from);
>   
>   	if (free_from >= max_file_blocks(inode))
> @@ -739,6 +744,21 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>   		goto out;
>   	}
>   
> +	if (IS_DEVICE_ALIASING(inode)) {
> +		struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
> +		struct extent_info ei = et->largest;
> +		unsigned int i;
> +
> +		for (i = 0; i < ei.len; i++)
> +			f2fs_invalidate_blocks(sbi, ei.blk + i);
> +
> +		dec_valid_block_count(sbi, inode, ei.len);
> +		f2fs_update_time(sbi, REQ_TIME);
> +
> +		f2fs_put_page(ipage, 1);
> +		goto out;
> +	}
> +
>   	if (f2fs_has_inline_data(inode)) {
>   		f2fs_truncate_inline_inode(inode, ipage, from);
>   		f2fs_put_page(ipage, 1);
> @@ -774,7 +794,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>   	/* lastly zero out the first data page */
>   	if (!err)
>   		err = truncate_partial_data_page(inode, from, truncate_page);
> -
> +out_err:
>   	trace_f2fs_truncate_blocks_exit(inode, err);
>   	return err;
>   }
> @@ -992,7 +1012,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   		return -EPERM;
>   
>   	if ((attr->ia_valid & ATTR_SIZE)) {
> -		if (!f2fs_is_compress_backend_ready(inode))
> +		if (!f2fs_is_compress_backend_ready(inode) ||
> +				IS_DEVICE_ALIASING(inode))
>   			return -EOPNOTSUPP;
>   		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
>   			!IS_ALIGNED(attr->ia_size,
> @@ -1860,7 +1881,7 @@ static long f2fs_fallocate(struct file *file, int mode,
>   		return -EIO;
>   	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
>   		return -ENOSPC;
> -	if (!f2fs_is_compress_backend_ready(inode))
> +	if (!f2fs_is_compress_backend_ready(inode) || IS_DEVICE_ALIASING(inode))
>   		return -EOPNOTSUPP;
>   
>   	/* f2fs only support ->fallocate for regular file */
> @@ -3296,6 +3317,9 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
>   	struct f2fs_inode_info *fi = F2FS_I(inode);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   
> +	if (IS_DEVICE_ALIASING(inode))
> +		return -EINVAL;
> +
>   	if (fi->i_gc_failures >= sbi->gc_pin_file_threshold) {
>   		f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
>   			  __func__, inode->i_ino, fi->i_gc_failures);
> @@ -3326,6 +3350,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>   	if (f2fs_readonly(sbi->sb))
>   		return -EROFS;
>   
> +	if (!pin && IS_DEVICE_ALIASING(inode))
> +		return -EOPNOTSUPP;
> +
>   	ret = mnt_want_write_file(filp);
>   	if (ret)
>   		return ret;
> @@ -4764,7 +4791,8 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>   	else
>   		return 0;
>   
> -	map.m_may_create = true;
> +	if (!IS_DEVICE_ALIASING(inode))
> +		map.m_may_create = true;
>   	if (dio) {
>   		map.m_seg_type = f2fs_rw_hint_to_seg_type(sbi,
>   						inode->i_write_hint);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 1ed86df343a5..e2d30fc79644 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -372,6 +372,19 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   		return false;
>   	}
>   
> +	if (fi->i_flags & F2FS_DEVICE_ALIAS_FL) {

Trivial cleanup.

IS_DEVICE_ALIASING(inode)

Thanks,

> +		if (!f2fs_sb_has_device_alias(sbi)) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but the feature is off",
> +				  __func__, inode->i_ino);
> +			return false;
> +		}
> +		if (!f2fs_is_pinned_file(inode)) {
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but is not pinned",
> +				  __func__, inode->i_ino);
> +			return false;
> +		}
> +	}
> +
>   	return true;
>   }
>   
> @@ -823,7 +836,8 @@ void f2fs_evict_inode(struct inode *inode)
>   	f2fs_bug_on(sbi, get_dirty_pages(inode));
>   	f2fs_remove_dirty_inode(inode);
>   
> -	f2fs_destroy_extent_tree(inode);
> +	if (!IS_DEVICE_ALIASING(inode))
> +		f2fs_destroy_extent_tree(inode);
>   
>   	if (inode->i_nlink || is_bad_inode(inode))
>   		goto no_delete;
> @@ -879,6 +893,9 @@ void f2fs_evict_inode(struct inode *inode)
>   		goto retry;
>   	}
>   
> +	if (IS_DEVICE_ALIASING(inode))
> +		f2fs_destroy_extent_tree(inode);
> +
>   	if (err) {
>   		f2fs_update_inode_page(inode);
>   		if (dquot_initialize_needed(inode))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc2c586c7619..95097498b544 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -834,6 +834,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   			set_opt(sbi, READ_EXTENT_CACHE);
>   			break;
>   		case Opt_noextent_cache:
> +			if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_DEVICE_ALIAS)) {
> +				f2fs_err(sbi, "device aliasing requires extent cache");
> +				return -EINVAL;
> +			}
>   			clear_opt(sbi, READ_EXTENT_CACHE);
>   			break;
>   		case Opt_noinline_data:
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index c56e8c873935..e51304bc65ea 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1313,6 +1313,7 @@ F2FS_SB_FEATURE_RO_ATTR(sb_checksum, SB_CHKSUM);
>   F2FS_SB_FEATURE_RO_ATTR(casefold, CASEFOLD);
>   F2FS_SB_FEATURE_RO_ATTR(compression, COMPRESSION);
>   F2FS_SB_FEATURE_RO_ATTR(readonly, RO);
> +F2FS_SB_FEATURE_RO_ATTR(device_alias, DEVICE_ALIAS);
>   
>   static struct attribute *f2fs_sb_feat_attrs[] = {
>   	ATTR_LIST(sb_encryption),
> @@ -1329,6 +1330,7 @@ static struct attribute *f2fs_sb_feat_attrs[] = {
>   	ATTR_LIST(sb_casefold),
>   	ATTR_LIST(sb_compression),
>   	ATTR_LIST(sb_readonly),
> +	ATTR_LIST(sb_device_alias),
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(f2fs_sb_feat);



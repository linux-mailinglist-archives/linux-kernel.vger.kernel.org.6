Return-Path: <linux-kernel+bounces-354418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5792993D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C822281A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5D2AE8C;
	Tue,  8 Oct 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiadXSMT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211C25779
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356657; cv=none; b=sLsl2VaCEs8wSMjAk+D15/k+um4UnM3i9xTajrmXHt6hI+vAkf3Rzm69Q5W9rOCLjoNfFWWVdyLkP16Bqjo+JMDCw5w0UnhLGO4BpujcQgfFOPQ2qCrboV0837p5DApPnZLUVe9QUzQwNgeOzjLDj0GxnTb994v+CXiacbzcoq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356657; c=relaxed/simple;
	bh=P9u3Et+3TLvKSO3sQ8MfLgWgAZD2sd6VVWGwIZpfbRM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P31/tL76AsAOVCL4guT2Yuyjr+RgKP+HY6yRB3jrt0+SCVzYVa6FkuEmjIMoCOBOqV6q/nvUCEYeplAXQilZE7QplPGxhozw7bWZOBlxsJ9UBP/RoYpN2+kebyHQVxFFQCMHzhdyusTrU1xgcHs1d5aL54WpQyHO2kyDQKuVJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiadXSMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB31C4CECC;
	Tue,  8 Oct 2024 03:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728356656;
	bh=P9u3Et+3TLvKSO3sQ8MfLgWgAZD2sd6VVWGwIZpfbRM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fiadXSMTB69dUuvHB18AkPe+tLNzK6qX6184p2al0eSBy/rf3q4ghw/C2BRsNcp5i
	 y0xX0iXFtL8kRo8NN7CkvfcRyvoDa6eyvViUbUsvR8sXY+PWEv6dfOEf6ievwEMYzl
	 YiwBl8JN7CJ3u8auXT8kFRWNsVCKY0i3HA74jXr8V6uijktiBGXXOaTaJbnwFHblFk
	 DqEn4qcUkj3jV0qCoWVwDxbKPBeiNyLnHqxGx4+3354mFDIj9TWlOCvspzz4C6ochD
	 lRH2jzNIlxA8B4FhhqR5qLxhbfH3ajaQB6JvKrsKYZ9UvYy4ZMkYOHNFbuG+SS3YGN
	 tDkX6Ddoi15Wg==
Message-ID: <7d94a3d0-d7e5-45f8-814c-16219a1d5c04@kernel.org>
Date: Tue, 8 Oct 2024 11:04:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3] f2fs: introduce device aliasing file
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240925215221.3045262-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240925215221.3045262-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/26 5:52, Daeho Jeong wrote:
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
> v3: merged Chao's extent cache sanity check.
>      prevented device aliasing support with noextent mount option
> v2: changed the position of f2fs_destroy_extent_tree() only for device
>      aliasing files
> ---
>   fs/f2fs/data.c         |  5 +++++
>   fs/f2fs/extent_cache.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>   fs/f2fs/f2fs.h         |  5 +++++
>   fs/f2fs/file.c         | 36 +++++++++++++++++++++++++++++----
>   fs/f2fs/inode.c        | 12 ++++++++++-
>   fs/f2fs/super.c        |  4 ++++
>   fs/f2fs/sysfs.c        |  2 ++
>   7 files changed, 103 insertions(+), 6 deletions(-)
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
> index 1ed86df343a5..25f66a0ed831 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -372,6 +372,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   		return false;
>   	}
>   
> +	if ((fi->i_flags & F2FS_DEVICE_ALIAS_FL) && !f2fs_sb_has_device_alias(sbi)) {
> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but the feature is off",
> +			  __func__, inode->i_ino);
> +		return false;
> +	}

Device alias inode should be pinned, so we need to add below sanity check?

if ((fi->i_flags & F2FS_DEVICE_ALIAS_FL) && !f2fs_is_pinned_file(inode)) {
	f2fs_warn(...);
	return false;
}

Thanks,

> +
>   	return true;
>   }
>   
> @@ -823,7 +829,8 @@ void f2fs_evict_inode(struct inode *inode)
>   	f2fs_bug_on(sbi, get_dirty_pages(inode));
>   	f2fs_remove_dirty_inode(inode);
>   
> -	f2fs_destroy_extent_tree(inode);
> +	if (!IS_DEVICE_ALIASING(inode))
> +		f2fs_destroy_extent_tree(inode);
>   
>   	if (inode->i_nlink || is_bad_inode(inode))
>   		goto no_delete;
> @@ -879,6 +886,9 @@ void f2fs_evict_inode(struct inode *inode)
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



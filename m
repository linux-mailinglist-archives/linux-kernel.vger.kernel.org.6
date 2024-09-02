Return-Path: <linux-kernel+bounces-310806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDB96816F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E5BB20DC7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2A183063;
	Mon,  2 Sep 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jDV5/DOl"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67917E017
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264758; cv=none; b=jkVWGJFBX+Z2mjeUzbUTojGx6hDjrJcNxFzR1xpGYX/X3ZX7d9Gf3XNuebFCzL0oME/6jkTkyvChalYt+JOFubdYYIXNiLuus9VRQoKSO16hawZhFd9o/xy+hao5MBhvi9MBl/7Lb2oxTyExUajc8G2ZBLz5lV8ACQHyvQdmjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264758; c=relaxed/simple;
	bh=fxhCWO8fUlJrh16aMq5P1RWgCKLjcWvNI78QjbdB2K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYm8xG5vR/p5kFt9gAGXmj/952vGbpiAb/yVgSLl3BvqqLebhxw9pNyUrcJ+SfITdPxSI+k0aqgh8FHbPkTasIdB++XdSpj7WTYMfQyBMcJWm69Ypvic+i8NhC8Kf9qnih1W0/eGp+0Ee8cvcP+ky1Z8djExh13EiwbM4L6CRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jDV5/DOl; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725264753; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WglYCIUr3NX2INCwojGLNAEGnpm6JJ3QCQgOuMdnpEA=;
	b=jDV5/DOlsqrddwMQAM1FWIoiW0OjJWVV6WJlZfPX/edu3zKtHjKA9ke4W720KLFpG0kXU84FpuYY8futx2H5idfVs1l5E165kEXklyrwd+oaWbpm8sMoN40+dHxfuaAvFf6he2TBarbzFVQncff/nHDYENdxHyCaRuXwrSlzRvg=
Received: from 30.221.132.251(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE5XxyB_1725264752)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 16:12:32 +0800
Message-ID: <1cbbd501-bd81-4df8-a887-8c07e0469ae1@linux.alibaba.com>
Date: Mon, 2 Sep 2024 16:12:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] erofs: refactor read_inode calling convention
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
 <20240902080417.427993-3-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902080417.427993-3-toolmanp@tlmp.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/2 16:04, Yiyang Wu wrote:
> Refactor out the iop binding behavior out of the erofs_fill_symlink
> and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
> can only deal with inode operation bindings and can be decoupled from
> metabuf operations. This results in better calling conventions.
> 
> Note that after this patch, we do not need erofs_buf and ofs as
> parameters any more when calling erofs_read_inode as
> all the data operations are now included in itself.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>   fs/erofs/inode.c | 120 +++++++++++++++++++++++------------------------
>   1 file changed, 58 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 40d3f4921d81..e9712af9a730 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -8,8 +8,33 @@
>   
>   #include <trace/events/erofs.h>
>   
> -static void *erofs_read_inode(struct erofs_buf *buf,
> -			      struct inode *inode, unsigned int *ofs)
> +static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> +			      unsigned int m_pofs)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	unsigned int bsz = i_blocksize(inode);
> +
> +	/* if it cannot be handled with fast symlink scheme */
> +	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> +	    inode->i_size >= bsz || inode->i_size < 0) {
> +		return 0;
> +	}
> +
> +	m_pofs += vi->xattr_isize;
> +	/* inline symlink data shouldn't cross block boundary */
> +	if (m_pofs + inode->i_size > bsz) {
> +		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
> +			  vi->nid);
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> +
> +	return inode->i_link ? 0 : -ENOMEM;
> +}
> +
> +static int erofs_read_inode(struct inode *inode)
>   {
>   	struct super_block *sb = inode->i_sb;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> @@ -20,20 +45,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	struct erofs_inode_compact *dic;
>   	struct erofs_inode_extended *die, *copied = NULL;
>   	union erofs_inode_i_u iu;
> -	unsigned int ifmt;
> -	int err;
> +	struct erofs_buf buf;

Should be
	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;

Otherwise buf itself will be left uninitialized.

> +	unsigned int ifmt, ofs;
> +	int err = 0;
>   
>   	blkaddr = erofs_blknr(sb, inode_loc);
> -	*ofs = erofs_blkoff(sb, inode_loc);
> +	ofs = erofs_blkoff(sb, inode_loc);
>   
> -	kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
>   	if (IS_ERR(kaddr)) {
>   		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
>   			  vi->nid, PTR_ERR(kaddr));
> -		return kaddr;
> +		return PTR_ERR(kaddr);
>   	}
>   
> -	dic = kaddr + *ofs;
> +	dic = kaddr + ofs;
>   	ifmt = le16_to_cpu(dic->i_format);
>   	if (ifmt & ~EROFS_I_ALL) {
>   		erofs_err(sb, "unsupported i_format %u of nid %llu",
> @@ -54,11 +80,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	case EROFS_INODE_LAYOUT_EXTENDED:
>   		vi->inode_isize = sizeof(struct erofs_inode_extended);
>   		/* check if the extended inode acrosses block boundary */
> -		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
> -			*ofs += vi->inode_isize;
> +		if (ofs + vi->inode_isize <= sb->s_blocksize) {
> +			ofs += vi->inode_isize;
>   			die = (struct erofs_inode_extended *)dic;
>   		} else {
> -			const unsigned int gotten = sb->s_blocksize - *ofs;
> +			const unsigned int gotten = sb->s_blocksize - ofs;
>   
>   			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
>   			if (!copied) {
> @@ -66,16 +92,16 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   				goto err_out;
>   			}
>   			memcpy(copied, dic, gotten);
> -			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
> +			kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr + 1),
>   						   EROFS_KMAP);
>   			if (IS_ERR(kaddr)) {
>   				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
>   					  vi->nid, PTR_ERR(kaddr));
>   				kfree(copied);
> -				return kaddr;
> +				return PTR_ERR(kaddr);
>   			}
> -			*ofs = vi->inode_isize - gotten;
> -			memcpy((u8 *)copied + gotten, kaddr, *ofs);
> +			ofs = vi->inode_isize - gotten;
> +			memcpy((u8 *)copied + gotten, kaddr, ofs);
>   			die = copied;
>   		}
>   		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
> @@ -91,11 +117,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   
>   		inode->i_size = le64_to_cpu(die->i_size);
>   		kfree(copied);
> -		copied = NULL;
>   		break;
>   	case EROFS_INODE_LAYOUT_COMPACT:
>   		vi->inode_isize = sizeof(struct erofs_inode_compact);
> -		*ofs += vi->inode_isize;
> +		ofs += vi->inode_isize;
>   		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
>   
>   		inode->i_mode = le16_to_cpu(dic->i_mode);
> @@ -119,6 +144,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	case S_IFREG:
>   	case S_IFDIR:
>   	case S_IFLNK:
> +		if(S_ISLNK(inode->i_mode)) {
> +			err = erofs_fill_symlink(inode, kaddr, ofs);
> +			if (err)
> +				goto err_out;
> +		}
>   		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
>   		break;
>   	case S_IFCHR:
> @@ -165,59 +195,24 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
>   	else
>   		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
> -	return kaddr;
>   
>   err_out:
> -	DBG_BUGON(1);
> -	kfree(copied);
> -	erofs_put_metabuf(buf);
> -	return ERR_PTR(err);
> -}
> -
> -static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> -			      unsigned int m_pofs)
> -{
> -	struct erofs_inode *vi = EROFS_I(inode);
> -	unsigned int bsz = i_blocksize(inode);
> -
> -	/* if it cannot be handled with fast symlink scheme */
> -	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= bsz || inode->i_size < 0) {
> -		inode->i_op = &erofs_symlink_iops;
> -		return 0;
> -	}
> -
> -	m_pofs += vi->xattr_isize;
> -	/* inline symlink data shouldn't cross block boundary */
> -	if (m_pofs + inode->i_size > bsz) {
> -		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
> -			  vi->nid);
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> -	}
> -	
> -	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> -	if (!inode->i_link)
> -		return -ENOMEM;
> -
> -	inode->i_op = &erofs_fast_symlink_iops;
> -	return 0;
> +	DBG_BUGON(err);
> +	erofs_put_metabuf(&buf);
> +	return err;
>   }
>   
>   static int erofs_fill_inode(struct inode *inode)
>   {
>   	struct erofs_inode *vi = EROFS_I(inode);
> -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> -	void *kaddr;
> -	unsigned int ofs;
>   	int err = 0;
>   
>   	trace_erofs_fill_inode(inode);
>   
>   	/* read inode base data from disk */
> -	kaddr = erofs_read_inode(&buf, inode, &ofs);
> -	if (IS_ERR(kaddr))
> -		return PTR_ERR(kaddr);
> +	err = erofs_read_inode(inode);
> +	if (err)
> +		return err;
>   
>   	/* setup the new inode */
>   	switch (inode->i_mode & S_IFMT) {
> @@ -234,9 +229,11 @@ static int erofs_fill_inode(struct inode *inode)
>   		inode_nohighmem(inode);
>   		break;
>   	case S_IFLNK:
> -		err = erofs_fill_symlink(inode, kaddr, ofs);
> -		if (err)
> -			goto out_unlock;
> +		if (inode->i_link)
> +			inode->i_op = &erofs_fast_symlink_iops;
> +		else
> +			inode->i_op = &erofs_symlink_iops;
> +
>   		inode_nohighmem(inode);
>   		break;
>   	case S_IFCHR:
> @@ -269,7 +266,6 @@ static int erofs_fill_inode(struct inode *inode)
>   #endif
>   	}
>   out_unlock:

I mean since `return err` is the only useful statement for
label `out_unlock`.

You could just remove it entirely and replace all
`goto out_unlock` to `return err`;

the name `out_unlock` itself is also meaningless due to
this patch.

Thanks,
Gao Xiang

> -	erofs_put_metabuf(&buf);
>   	return err;
>   }
>   



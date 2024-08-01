Return-Path: <linux-kernel+bounces-271177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E3944A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31685281635
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9E18454B;
	Thu,  1 Aug 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a49SNatk"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA417406D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511918; cv=none; b=MXhPkvJFz/NZALf8/F5KrWSDrmfHdxOcHEi7iyMVCaytsqPNiLkFui3bg4EN/tFOGG8F8kLjHy78e7JIUDvrkLhOrRSQqxZysAYLAYL+huEZgWlH/QTqHyK3lNEVn7TZfN/9/AM+rYkssYiTsUvVt6iDrNq7/Op8MJ+UugEQtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511918; c=relaxed/simple;
	bh=k8ONnkSlld3HaZxRW334a7ePUXlbx7K4HPoWJSXhyq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jS3rSPshuL0iUCVEai8dDB4uv90s9XDNigznw3LWF2mxsBVsDFSa/nrP4fnyvM4na+2VfobbUuK3GHF57JySUU+dhUdwXRMl17PLbb54vs7rketqR5YZBcBffzjkUzMLHVIPmAeE/VNs9eWdjoP+tsQj6dMbBauNinfTltNQdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a49SNatk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722511908; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oMvfutHFMr1ffJ2e0ja61Uj7PJwIKNC7uJu9hEsf6ok=;
	b=a49SNatkUvHYuVLZmM5IGj0tkzPjGKpNrP2I0kjVx4qudaygq2qwI8uW1E8uslCu0vwzjWR4JJ2naiFzTVXOBqFTe1xHfsAma+ZBcvIdqUAyy0nYtf5N+ubEyWV0Sgfu4Wf+3IaWUUeEZD6Elj3rfnNiz5AcNXKCFb+khy5YLHY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBsQXy1_1722511906;
Received: from 30.97.48.193(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBsQXy1_1722511906)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 19:31:47 +0800
Message-ID: <6c91643e-f55b-4998-b2b2-8eaa3ad747f3@linux.alibaba.com>
Date: Thu, 1 Aug 2024 19:31:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify readdir operation
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20240801112622.2164029-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240801112622.2164029-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/1 19:26, Hongzhen Luo wrote:
>   - Use i_size instead of i_size_read() due to immutable fses;
> 
>   - Get rid of an unneeded goto since erofs_fill_dentries() also works;
> 
>   - Remove unnecessary lines.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---

What's the difference from the previous version? why not marking
it as v2?

Thanks,
Gao Xiang

>   fs/erofs/dir.c      | 35 ++++++++++++-----------------------
>   fs/erofs/internal.h |  2 +-
>   2 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 2193a6710c8f..c3b90abdee37 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -8,19 +8,15 @@
>   
>   static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   			       void *dentry_blk, struct erofs_dirent *de,
> -			       unsigned int nameoff, unsigned int maxsize)
> +			       unsigned int nameoff0, unsigned int maxsize)
>   {
> -	const struct erofs_dirent *end = dentry_blk + nameoff;
> +	const struct erofs_dirent *end = dentry_blk + nameoff0;
>   
>   	while (de < end) {
> -		const char *de_name;
> +		unsigned char d_type = fs_ftype_to_dtype(de->file_type);
> +		unsigned int nameoff = le16_to_cpu(de->nameoff);
> +		const char *de_name = (char *)dentry_blk + nameoff;
>   		unsigned int de_namelen;
> -		unsigned char d_type;
> -
> -		d_type = fs_ftype_to_dtype(de->file_type);
> -
> -		nameoff = le16_to_cpu(de->nameoff);
> -		de_name = (char *)dentry_blk + nameoff;
>   
>   		/* the last dirent in the block? */
>   		if (de + 1 >= end)
> @@ -52,21 +48,20 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct super_block *sb = dir->i_sb;
>   	unsigned long bsz = sb->s_blocksize;
> -	const size_t dirsize = i_size_read(dir);
> -	unsigned int i = erofs_blknr(sb, ctx->pos);
>   	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>   	int err = 0;
>   	bool initial = true;
>   
>   	buf.mapping = dir->i_mapping;
> -	while (ctx->pos < dirsize) {
> +	while (ctx->pos < dir->i_size) {
> +		erofs_off_t dbstart = ctx->pos - ofs;
>   		struct erofs_dirent *de;
>   		unsigned int nameoff, maxsize;
>   
> -		de = erofs_bread(&buf, erofs_pos(sb, i), EROFS_KMAP);
> +		de = erofs_bread(&buf, dbstart, EROFS_KMAP);
>   		if (IS_ERR(de)) {
>   			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
> -				  i, EROFS_I(dir)->nid);
> +				  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
>   			err = PTR_ERR(de);
>   			break;
>   		}
> @@ -79,25 +74,19 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			break;
>   		}
>   
> -		maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
> -
> +		maxsize = min_t(unsigned int, dir->i_size - dbstart, bsz);
>   		/* search dirents at the arbitrary position */
>   		if (initial) {
>   			initial = false;
> -
>   			ofs = roundup(ofs, sizeof(struct erofs_dirent));
> -			ctx->pos = erofs_pos(sb, i) + ofs;
> -			if (ofs >= nameoff)
> -				goto skip_this;
> +			ctx->pos = dbstart + ofs;
>   		}
>   
>   		err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
>   					  nameoff, maxsize);
>   		if (err)
>   			break;
> -skip_this:
> -		ctx->pos = erofs_pos(sb, i) + maxsize;
> -		++i;
> +		ctx->pos = dbstart + maxsize;
>   		ofs = 0;
>   	}
>   	erofs_put_metabuf(&buf);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 736607675396..45dc15ebd870 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -220,7 +220,7 @@ struct erofs_buf {
>   };
>   #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
>   
> -#define erofs_blknr(sb, addr)	((addr) >> (sb)->s_blocksize_bits)
> +#define erofs_blknr(sb, addr)	((erofs_blk_t)((addr) >> (sb)->s_blocksize_bits))
>   #define erofs_blkoff(sb, addr)	((addr) & ((sb)->s_blocksize - 1))
>   #define erofs_pos(sb, blk)	((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
>   #define erofs_iblks(i)	(round_up((i)->i_size, i_blocksize(i)) >> (i)->i_blkbits)


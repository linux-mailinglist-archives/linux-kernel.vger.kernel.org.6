Return-Path: <linux-kernel+bounces-271031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0219448B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6E0B22ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56A170A15;
	Thu,  1 Aug 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IakteuaK"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636A163A9B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505304; cv=none; b=VAKznzzhMPROAZZ36BTGC6brIwU1pn1lNoSi6ULlCRgbXkiW8XCvJ3PnVXBdH0h7cT1UlmNAuVednXM89yunMM+16cmuZ88TSHwueuHlI7WsYEqTXas369LnmQ/+KGEgX4nvgHv4Ry+Yg19TPlPF4yxUrtCDtmRvDTyrFFUNHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505304; c=relaxed/simple;
	bh=v0AVe0r+dwhCKEy6pQ2jOBWb4fsIeIajF8UDcc12wiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SxcrP+43ArDdA2ZRrCckiZ/pxOUxmO0Go2xLUhbp/oxKgAKs8X7mTvcm/+KU0bblXEpPkRbFZR+EsxarNI6gHJ/es7H6g8nixBDh+qP1T/eVxxeOEMoAsuEpIqO7SVF2vD+OdwZ9Yyt7XLy1oyEkZTCU3WBGBXi/CIdk2AVE7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IakteuaK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722505298; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ut2mlJa3eT5yCkT86Q9XqP5YYx53IhPFa+rrSTzSnLI=;
	b=IakteuaKRs5DBUzvO1RUi//xmoAof9+nQAsAVqV48zB4Dtv8xr0wYdfV4JE9KF4Na1MjruYdX8Ux8NAPBbrj4Kul2N0apqssfDxEWBa+zM6o8VVZ4r9Gq8v4uhL+ar0Z8ITatxzVRjCe3hLrC+QQlQ+wQr1x5XQISDSFflRnrq0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBrP6oh_1722505296;
Received: from 30.97.48.193(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBrP6oh_1722505296)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 17:41:38 +0800
Message-ID: <2efe4f60-5d4d-4a89-8fbf-5001e013298d@linux.alibaba.com>
Date: Thu, 1 Aug 2024 17:41:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify readdir operation
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20cbea9c-3b3f-40f7-be01-bd9de52e3134@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20cbea9c-3b3f-40f7-be01-bd9de52e3134@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/1 11:02, Hongzhen Luo wrote:
>   - Use i_size instead of i_size_read() due to immutable fses;
> 
>   - Get rid of an unneeded goto since erofs_fill_dentries() also works;
> 
>   - Remove unnecessary lines.
> 
> Signed-off-by: Hongzhen Luo<hongzhen@linux.alibaba.com>
> ---


BTW, can you send any "kernel" patch to LKML <linux-kernel@vger.kernel.org>
too?  Also you'd better to use "scripts/get_maintainers.pl".


>   fs/erofs/dir.c      | 35 ++++++++++++-----------------------
>   fs/erofs/internal.h |  2 +-
>   2 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 2193a6710c8f..c3b90abdee37 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -8,19 +8,15 @@
> 
>   static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>                      void *dentry_blk, struct erofs_dirent *de,
> -                   unsigned int nameoff, unsigned int maxsize)
> +                   unsigned int nameoff0, unsigned int maxsize)
>   {
> -    const struct erofs_dirent *end = dentry_blk + nameoff;
> +    const struct erofs_dirent *end = dentry_blk + nameoff0;
> 
>       while (de < end) {
> -        const char *de_name;
> +        unsigned char d_type = fs_ftype_to_dtype(de->file_type);
> +        unsigned int nameoff = le16_to_cpu(de->nameoff);
> +        const char *de_name = (char *)dentry_blk + nameoff;
>           unsigned int de_namelen;
> -        unsigned char d_type;
> -
> -        d_type = fs_ftype_to_dtype(de->file_type);
> -
> -        nameoff = le16_to_cpu(de->nameoff);
> -        de_name = (char *)dentry_blk + nameoff;
> 
>           /* the last dirent in the block? */
>           if (de + 1 >= end)
> @@ -52,21 +48,20 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>       struct super_block *sb = dir->i_sb;
>       unsigned long bsz = sb->s_blocksize;
> -    const size_t dirsize = i_size_read(dir);
> -    unsigned int i = erofs_blknr(sb, ctx->pos);
>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>       int err = 0;
>       bool initial = true;
> 
>       buf.mapping = dir->i_mapping;
> -    while (ctx->pos < dirsize) {
> +    while (ctx->pos < dir->i_size) {
> +        erofs_off_t dbstart = ctx->pos - ofs;
>           struct erofs_dirent *de;
>           unsigned int nameoff, maxsize;
> 
> -        de = erofs_bread(&buf, erofs_pos(sb, i), EROFS_KMAP);
> +        de = erofs_bread(&buf, dbstart, EROFS_KMAP);
>           if (IS_ERR(de)) {
>               erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
> -                  i, EROFS_I(dir)->nid);
> +                  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
>               err = PTR_ERR(de);
>               break;
>           }
> @@ -79,25 +74,19 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>               break;
>           }
> 
> -        maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
> -
> +        maxsize = min_t(unsigned int, dir->i_size - dbstart, bsz);
>           /* search dirents at the arbitrary position */
>           if (initial) {
>               initial = false;
> -
>               ofs = roundup(ofs, sizeof(struct erofs_dirent));
> -            ctx->pos = erofs_pos(sb, i) + ofs;
> -            if (ofs >= nameoff)
> -                goto skip_this;
> +            ctx->pos = dbstart + ofs;
>           }
> 
>           err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
>                         nameoff, maxsize);
>           if (err)
>               break;
> -skip_this:
> -        ctx->pos = erofs_pos(sb, i) + maxsize;
> -        ++i;
> +        ctx->pos = dbstart + maxsize;
>           ofs = 0;
>       }
>       erofs_put_metabuf(&buf);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 736607675396..45dc15ebd870 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -220,7 +220,7 @@ struct erofs_buf {
>   };
>   #define __EROFS_BUF_INITIALIZER    ((struct erofs_buf){ .page = NULL })
> 
> -#define erofs_blknr(sb, addr)    ((addr) >> (sb)->s_blocksize_bits)
> +#define erofs_blknr(sb, addr)    ((erofs_blk_t)((addr) >> (sb)->s_blocksize_bits))
>   #define erofs_blkoff(sb, addr)    ((addr) & ((sb)->s_blocksize - 1))
>   #define erofs_pos(sb, blk)    ((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
>   #define erofs_iblks(i)    (round_up((i)->i_size, i_blocksize(i)) >> (i)->i_blkbits)
> -- 2.43.5


Return-Path: <linux-kernel+bounces-271183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B2944A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AA51C2545F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B9218E04D;
	Thu,  1 Aug 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FHRHOdGZ"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9718E03B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512147; cv=none; b=YfjKqhM0iMcA0GJdHU3/qq2UJ7+/lo41yphOiE/N8ACytICNt3M/9lj2ngbmKLoDvPVDNXwQEYjy5hnEkhDm08i6QANW6K06fHUW4Iam4SM5R2ynyhaUrSnSTDLmuebmPWx5n6M+NoqtT1tanJ98d4SX6r8Wf9FtT+MkHsrVxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512147; c=relaxed/simple;
	bh=d/VvdUhxDppDVauYxah6czaEzq90f+a/YDmt6AEWgi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvk+DZCAyYnF8zp5zVc2A4EpStUfpoaC8Oa0qOBdUoeM6sIU/pW1sI7x1tqD21yhW4OXgs2w2Zs2Cax4qIK3dcSBPUnVhC2/YMiN3eXQ+tOIVKzSOZ/FQqIUB71LdAcQOqfsAiJlhtGJF88G2NjRWrbm3Po2S7FRwYPHb61K+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FHRHOdGZ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722512142; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G/YsuSle6DMFGCtRQo7viufzsspiEbdDHRyz4kG9u3s=;
	b=FHRHOdGZGmDZpWIB3z4MnYKbK/CCErIlKTQgYtFuM0yMUD0i4cufUWElp7PSIb5Qv8meIuckn1CQ/CCyAdLuw+Ww2UMDWPgMYytDQgHpyFyHwCep5JA9K0ycs2CjxpVWzVHJ8olZw+BTOk9OlpuGnrh+uXIX/JRhEVseQ+kV5uY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBsdoCk_1722512141;
Received: from 30.221.131.84(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBsdoCk_1722512141)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 19:35:41 +0800
Message-ID: <0f83044e-5024-4c99-a7f8-323cc2b2abe0@linux.alibaba.com>
Date: Thu, 1 Aug 2024 19:35:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify readdir operation
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20240801112622.2164029-1-hongzhen@linux.alibaba.com>
 <6c91643e-f55b-4998-b2b2-8eaa3ad747f3@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <6c91643e-f55b-4998-b2b2-8eaa3ad747f3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/8/1 19:31, Gao Xiang wrote:
>
>
> On 2024/8/1 19:26, Hongzhen Luo wrote:
>>   - Use i_size instead of i_size_read() due to immutable fses;
>>
>>   - Get rid of an unneeded goto since erofs_fill_dentries() also works;
>>
>>   - Remove unnecessary lines.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>
> What's the difference from the previous version? why not marking
> it as v2?
>
> Thanks,
> Gao Xiang
>
The previous version was corrupted and couldn't apply the patch using 
`git am`. Sorry, I didn't write a changelog. I will provide a version 
with the changelog added...

Thanks,
Hongzhen Luo

>>   fs/erofs/dir.c      | 35 ++++++++++++-----------------------
>>   fs/erofs/internal.h |  2 +-
>>   2 files changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 2193a6710c8f..c3b90abdee37 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -8,19 +8,15 @@
>>     static int erofs_fill_dentries(struct inode *dir, struct 
>> dir_context *ctx,
>>                      void *dentry_blk, struct erofs_dirent *de,
>> -                   unsigned int nameoff, unsigned int maxsize)
>> +                   unsigned int nameoff0, unsigned int maxsize)
>>   {
>> -    const struct erofs_dirent *end = dentry_blk + nameoff;
>> +    const struct erofs_dirent *end = dentry_blk + nameoff0;
>>         while (de < end) {
>> -        const char *de_name;
>> +        unsigned char d_type = fs_ftype_to_dtype(de->file_type);
>> +        unsigned int nameoff = le16_to_cpu(de->nameoff);
>> +        const char *de_name = (char *)dentry_blk + nameoff;
>>           unsigned int de_namelen;
>> -        unsigned char d_type;
>> -
>> -        d_type = fs_ftype_to_dtype(de->file_type);
>> -
>> -        nameoff = le16_to_cpu(de->nameoff);
>> -        de_name = (char *)dentry_blk + nameoff;
>>             /* the last dirent in the block? */
>>           if (de + 1 >= end)
>> @@ -52,21 +48,20 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>>       unsigned long bsz = sb->s_blocksize;
>> -    const size_t dirsize = i_size_read(dir);
>> -    unsigned int i = erofs_blknr(sb, ctx->pos);
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>       int err = 0;
>>       bool initial = true;
>>         buf.mapping = dir->i_mapping;
>> -    while (ctx->pos < dirsize) {
>> +    while (ctx->pos < dir->i_size) {
>> +        erofs_off_t dbstart = ctx->pos - ofs;
>>           struct erofs_dirent *de;
>>           unsigned int nameoff, maxsize;
>>   -        de = erofs_bread(&buf, erofs_pos(sb, i), EROFS_KMAP);
>> +        de = erofs_bread(&buf, dbstart, EROFS_KMAP);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "fail to readdir of logical block %u of 
>> nid %llu",
>> -                  i, EROFS_I(dir)->nid);
>> +                  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
>>               err = PTR_ERR(de);
>>               break;
>>           }
>> @@ -79,25 +74,19 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>               break;
>>           }
>>   -        maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
>> -
>> +        maxsize = min_t(unsigned int, dir->i_size - dbstart, bsz);
>>           /* search dirents at the arbitrary position */
>>           if (initial) {
>>               initial = false;
>> -
>>               ofs = roundup(ofs, sizeof(struct erofs_dirent));
>> -            ctx->pos = erofs_pos(sb, i) + ofs;
>> -            if (ofs >= nameoff)
>> -                goto skip_this;
>> +            ctx->pos = dbstart + ofs;
>>           }
>>             err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
>>                         nameoff, maxsize);
>>           if (err)
>>               break;
>> -skip_this:
>> -        ctx->pos = erofs_pos(sb, i) + maxsize;
>> -        ++i;
>> +        ctx->pos = dbstart + maxsize;
>>           ofs = 0;
>>       }
>>       erofs_put_metabuf(&buf);
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 736607675396..45dc15ebd870 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -220,7 +220,7 @@ struct erofs_buf {
>>   };
>>   #define __EROFS_BUF_INITIALIZER    ((struct erofs_buf){ .page = 
>> NULL })
>>   -#define erofs_blknr(sb, addr)    ((addr) >> (sb)->s_blocksize_bits)
>> +#define erofs_blknr(sb, addr)    ((erofs_blk_t)((addr) >> 
>> (sb)->s_blocksize_bits))
>>   #define erofs_blkoff(sb, addr)    ((addr) & ((sb)->s_blocksize - 1))
>>   #define erofs_pos(sb, blk)    ((erofs_off_t)(blk) << 
>> (sb)->s_blocksize_bits)
>>   #define erofs_iblks(i)    (round_up((i)->i_size, i_blocksize(i)) >> 
>> (i)->i_blkbits)


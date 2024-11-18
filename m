Return-Path: <linux-kernel+bounces-412688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B2D9D0DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9684B25EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C9192B6F;
	Mon, 18 Nov 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsLECLzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26252149E0E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924510; cv=none; b=T96wSc5vcvpCo6EQMSxs6DlOEmA0NBKh612SGqNCdgoluA1PXiz0JRRl9srhYiPIQpZONKofb5P4WLKV+gkiL7zgs4R/HSOMTsZ85igDq3u6ot8XUBEWMEc0f8FwBb9fNmSgQwAFGN9Nj9KSajsUPptVTFgfK7v3MJJGSAil0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924510; c=relaxed/simple;
	bh=ElbV7+y46xOwExqz+QF3XktAt+Sx1IHP9XxevAPamFU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VQWJCvnhPoEUjcuYuv7658L+56K3UYsOvweCEYnFa9R/C2E0pcb51+d/dxUQUDE29PMGu8f5O5y1airHI/ni84MDAItsguAOK6NziASA2Ze7PfdwUiD/L5RrnlZhgJRUT7V8LAnZgmnXz8jZEUn2iROeBTn+v5BvCQhG9ysF2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsLECLzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D2C4CED6;
	Mon, 18 Nov 2024 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731924509;
	bh=ElbV7+y46xOwExqz+QF3XktAt+Sx1IHP9XxevAPamFU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hsLECLzJWeIvPpsAAHBOOIrZ/skFjRU9YqYuQPERDT9sVHEH4Uz28A+QOOn8R10t5
	 btkC9J4Op652G/F6H3Gz9T2g6OcSwA1YyxhSQ7kVVNrq5OMN+Bm+Lkd4psL4eKMCT8
	 jp3PjFpzVUu84uOdbJDicysdDAU33IY9hpsZUp6Y9SscWS6UWEZS9cRTCB/V7TNnri
	 AO7pH4eztBpR6Brw9opORCgv2sGBdsySleTmctnZQub2hNh23g/gdEOY3Io8129SZg
	 UVtU7JeXwMfMBmM6O4FaRylTQ92z277I0GkDRRnAJsSQ20HgaX7NzzTljvRPnBuozp
	 +8MNrkTuC/yrQ==
Message-ID: <4dfbb8ba-f141-42d4-aedb-c6d98e8c930a@kernel.org>
Date: Mon, 18 Nov 2024 18:08:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Chunhai Guo <guochunhai@vivo.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
 <bda19625-e43e-4ebe-82f5-dad860782e6d@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <bda19625-e43e-4ebe-82f5-dad860782e6d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/11 10:12, Gao Xiang wrote:
> Hi Chao,
> 
> On 2024/11/7 11:09, Chao Yu wrote:
>> On 2024/10/21 11:53, Gao Xiang wrote:
>>> Just fold them into the only two callers since
>>> they are simple enough.
>>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>> v1: https://lore.kernel.org/r/20241017115705.877515-1-hsiangkao@linux.alibaba.com
>>> change since v1:
>>>   - !grp case should be handled properly mentioned by Chunhai;
>>>
>>>   fs/erofs/internal.h |  5 +----
>>>   fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
>>>   fs/erofs/zutil.c    | 50 +--------------------------------------------
>>>   3 files changed, 30 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 4efd578d7c62..8081ee43cd83 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
>>>   #ifdef CONFIG_EROFS_FS_ZIP
>>>   void erofs_workgroup_put(struct erofs_workgroup *grp);
>>> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>>> -                         pgoff_t index);
>>> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>>> -                           struct erofs_workgroup *grp);
>>> +bool erofs_workgroup_get(struct erofs_workgroup *grp);
>>>   void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
>>>   void erofs_shrinker_register(struct super_block *sb);
>>>   void erofs_shrinker_unregister(struct super_block *sb);
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>> index a569ff9dfd04..bb1b73d99d07 100644
>>> --- a/fs/erofs/zdata.c
>>> +++ b/fs/erofs/zdata.c
>>> @@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>>   {
>>>       struct erofs_map_blocks *map = &fe->map;
>>>       struct super_block *sb = fe->inode->i_sb;
>>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>>>       bool ztailpacking = map->m_flags & EROFS_MAP_META;
>>>       struct z_erofs_pcluster *pcl;
>>> -    struct erofs_workgroup *grp;
>>> +    struct erofs_workgroup *grp, *pre;
>>>       int err;
>>>       if (!(map->m_flags & EROFS_MAP_ENCODED) ||
>>> @@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>>           pcl->obj.index = 0;    /* which indicates ztailpacking */
>>>       } else {
>>>           pcl->obj.index = erofs_blknr(sb, map->m_pa);
>>> -
>>> -        grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
>>> -        if (IS_ERR(grp)) {
>>> -            err = PTR_ERR(grp);
>>> -            goto err_out;
>>> +        while (1) {
>>> +            xa_lock(&sbi->managed_pslots);
>>> +            pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
>>> +                       NULL, grp, GFP_KERNEL);
>>> +            if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
>>> +                xa_unlock(&sbi->managed_pslots);
>>> +                break;
>>> +            }
>>> +            /* try to legitimize the current in-tree one */
>>> +            xa_unlock(&sbi->managed_pslots);
>>> +            cond_resched();
>>>           }
>>> -
>>> -        if (grp != &pcl->obj) {
>>
>> Do we need to keep this logic?
> 
> Thanks for the review.  I think
> 
>          if (grp != &pcl->obj)
> 
> equals to (pre && erofs_workgroup_get(pre)) here, so
> 
>          } else if (pre) {
>              fe->pcl = container_of(pre,
>                  struct z_erofs_pcluster, obj);
>              err = -EEXIST;
>              goto err_out;
>          }
> 
> Handles this case.

Xiang, thanks for your explanation.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang



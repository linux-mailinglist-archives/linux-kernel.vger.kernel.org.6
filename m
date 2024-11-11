Return-Path: <linux-kernel+bounces-403492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342BA9C366D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73471283734
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F0433B3;
	Mon, 11 Nov 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GyCESk3f"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100318E2A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731291142; cv=none; b=P6VYpgnVT87Pv05bCHDIltZ0qnYRxJNKxmlm//GW2YA4lvUdfiFrH2fUxdEYSJdP+DAcYHe6xuM8K2zZGWOwPE00o3XFYFqEAA6JcUXPTuzNytPLHSYmCx4OTgyR+6m+GEoRuonkKo/wDulA3NXKZXM2uelcZZ+zVCdTBCj6wpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731291142; c=relaxed/simple;
	bh=9i+Zm+SHVHfVUy4FUtz9eeM5Fw+2zvF/lIBDEQq6Dto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsoRuzCEJq2YIzTGCD8Vr+sBUrWil0pkNXlRCJepLeYujZ8SiIP/RFVBpidJ6XTDFZ+JkXzc5Q2KzwxWAIs1NejVZ/O/EPLvteapAo25H/2OK4HmribucZx4ymGjm728WWoQbr89TtFtbKdpeh4tJmWkkl4CmwUcxE1CMQFtn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GyCESk3f; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731291130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kPhZpfwim8Tr8MRzViTRwXJRChpSgC6ZbMn8DI4K++I=;
	b=GyCESk3f5GUIPwYNVTASF92LQtlcAeiPByVlUv7ptrC6KwjTASKkkndze4Rb+pG6IOeq1tGFBLydW0Pp7W8qOPLhm0LbY9/66cBccGCzU4Fkiykma4UuAmJqioI2pOZ3G/QtLVd9w49GvWtTOc6cYaO6t4lrkPIXE3CgRgro5HQ=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ3sJBC_1731291129 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:12:10 +0800
Message-ID: <bda19625-e43e-4ebe-82f5-dad860782e6d@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:12:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chao,

On 2024/11/7 11:09, Chao Yu wrote:
> On 2024/10/21 11:53, Gao Xiang wrote:
>> Just fold them into the only two callers since
>> they are simple enough.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v1: https://lore.kernel.org/r/20241017115705.877515-1-hsiangkao@linux.alibaba.com
>> change since v1:
>>   - !grp case should be handled properly mentioned by Chunhai;
>>
>>   fs/erofs/internal.h |  5 +----
>>   fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
>>   fs/erofs/zutil.c    | 50 +--------------------------------------------
>>   3 files changed, 30 insertions(+), 63 deletions(-)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 4efd578d7c62..8081ee43cd83 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
>>   #ifdef CONFIG_EROFS_FS_ZIP
>>   void erofs_workgroup_put(struct erofs_workgroup *grp);
>> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>> -                         pgoff_t index);
>> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>> -                           struct erofs_workgroup *grp);
>> +bool erofs_workgroup_get(struct erofs_workgroup *grp);
>>   void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
>>   void erofs_shrinker_register(struct super_block *sb);
>>   void erofs_shrinker_unregister(struct super_block *sb);
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index a569ff9dfd04..bb1b73d99d07 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>   {
>>       struct erofs_map_blocks *map = &fe->map;
>>       struct super_block *sb = fe->inode->i_sb;
>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>>       bool ztailpacking = map->m_flags & EROFS_MAP_META;
>>       struct z_erofs_pcluster *pcl;
>> -    struct erofs_workgroup *grp;
>> +    struct erofs_workgroup *grp, *pre;
>>       int err;
>>       if (!(map->m_flags & EROFS_MAP_ENCODED) ||
>> @@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>           pcl->obj.index = 0;    /* which indicates ztailpacking */
>>       } else {
>>           pcl->obj.index = erofs_blknr(sb, map->m_pa);
>> -
>> -        grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
>> -        if (IS_ERR(grp)) {
>> -            err = PTR_ERR(grp);
>> -            goto err_out;
>> +        while (1) {
>> +            xa_lock(&sbi->managed_pslots);
>> +            pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
>> +                       NULL, grp, GFP_KERNEL);
>> +            if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
>> +                xa_unlock(&sbi->managed_pslots);
>> +                break;
>> +            }
>> +            /* try to legitimize the current in-tree one */
>> +            xa_unlock(&sbi->managed_pslots);
>> +            cond_resched();
>>           }
>> -
>> -        if (grp != &pcl->obj) {
> 
> Do we need to keep this logic?

Thanks for the review.  I think

		if (grp != &pcl->obj)

equals to (pre && erofs_workgroup_get(pre)) here, so

		} else if (pre) {
			fe->pcl = container_of(pre,
				struct z_erofs_pcluster, obj);
			err = -EEXIST;
			goto err_out;
		}

Handles this case.

Thanks,
Gao Xiang


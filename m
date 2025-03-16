Return-Path: <linux-kernel+bounces-563078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01EA636BD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2623A5971
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DC11B4132;
	Sun, 16 Mar 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I8tZ6FN9"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392814293
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145440; cv=none; b=av5pCH1UhMW3xxn0IoluXso2pVQ150Rg5oLyfvJBbWzHxxRQ4RBieBecuaTNDcRixLRHgWTUkct8jiMVD0JXEtCnENldePHbvD7Ef+v1qI41Wyq1W8Yl9F9pTKd4Vq2QCwWYg2YgG8YZKYrNgIAKSUKys+9nLOXnhYWbMHroKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145440; c=relaxed/simple;
	bh=B6N2SFabrAGmiF2sPKOi9I3I0BbdESWJFUVqVAMXZ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFlSpDwLo5mTtTCUI24+psmf5WelCN1KYRZ41bRqp2FyA25/S0MrMGj9CJEjmXy8BKy0WUkb7o9FJBgTr+V/2lVKL/65K44hfybG0GPMiPSLrfp/9MTGIIzddRbxzgspP1/zJwGu+RIbyHIOcZQKTtSRKg/MVgNc39yptR92AZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I8tZ6FN9; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742145428; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UUeB2FUt0HAuaRZxXLaie80QjepErNYtIn4MOft9MmI=;
	b=I8tZ6FN9tjp3oJDmrgsUAh8RcmlULvJHrmAnAZjPs3jh1Zu1eTDqeHOZ4FZ+ihCguGiQX4axVrG0xSkvBDOe5GboXqLcLciur6BNclVOaLrKXzC4EIdq9odlLiDANAC02tJcSabsaitZgW5YNQWOB1dc9hvM/L+Ca1Sxfw9LX94=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRVc8sJ_1742145427 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 01:17:08 +0800
Message-ID: <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Date: Mon, 17 Mar 2025 01:17:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chao,

On 2025/3/16 10:36, Chao Yu wrote:
> On 2025/2/10 11:29, Hongzhen Luo wrote:
>> There's no need to enumerate each type.  No logic changes.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Looks good to me, feel free to add:
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> And one minor comment below.
> 
>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>> index 689437e99a5a..d278ebd60281 100644
>> --- a/fs/erofs/zmap.c
>> +++ b/fs/erofs/zmap.c
>> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>>           if (err)
>>               return err;
>> -        switch (m->type) {
>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> +                  m->type, lcn, vi->nid);
>> +            DBG_BUGON(1);
>> +            return -EOPNOTSUPP;
>  > +        } else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {>               lookback_distance = m->delta[0];
>>               if (!lookback_distance)
>> -                goto err_bogus;
>> +                break;
>>               continue;
>> -        case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>> +        } else {
>>               m->headtype = m->type;
>>               m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>>               return 0;
>> -        default:
>> -            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>> -                  m->type, lcn, vi->nid);
>> -            DBG_BUGON(1);
>> -            return -EOPNOTSUPP;
> 
> Should return EFSCORRUPTED here? is m->type >= Z_EROFS_LCLUSTER_TYPE_MAX a possible
> case?

It's impossible by the latest on-disk definition, see:
#define Z_EROFS_LI_LCLUSTER_TYPE_MASK	(Z_EROFS_LCLUSTER_TYPE_MAX - 1)

Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
introduced, but the `default:` case is already deadcode now.

> 
> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
> then we can treat m->type as reliable variable later.
> 
>      advise = le16_to_cpu(di->di_advise);
>      m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>      if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {

It's always false here.

Thanks,
Gao Xiang


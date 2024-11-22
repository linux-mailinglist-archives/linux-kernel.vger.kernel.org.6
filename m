Return-Path: <linux-kernel+bounces-417805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209709D5946
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9187D1F23413
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846115853D;
	Fri, 22 Nov 2024 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9GSjYsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FA230982
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256229; cv=none; b=b431YpuHJ8Tl/m0rgwXNj4FFi2rzsoi05/9ES3ePKzFmf4sOJu1XmKFjjKXXbC5t62lDc91KO7mGaHFK+mXDxVpB1kbe13fT2LqN807iUcCSW8ltbsEF+tBPW6ANshaXMJCum5gTy9RxmuRCkILbNCnXO3ZFvr6X29EcRwM9eJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256229; c=relaxed/simple;
	bh=X09WMcDwbp9QmZT9rmMDKK8+T0zkPB2uDKF3CHx4Szk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VbXtoF+YBsYxPxLPv9XJj+5IM6JDGwaPn0XzMVDFh2+VoKIBPg2iT45J1TSJnqpWKdYgTdB6dA5VGCsetEy2GnbEcsltE/L33/6U9CgKYFHvU/1N8KIz9bhVvkhs0UyeUY+18Xo8Eya+dnYt6hWBVemTiRktd+VKH5tH3ipOLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9GSjYsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A71CC4CECE;
	Fri, 22 Nov 2024 06:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732256228;
	bh=X09WMcDwbp9QmZT9rmMDKK8+T0zkPB2uDKF3CHx4Szk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=a9GSjYsnCY6a2fgDTy+TvXK8VsyxC+JFuTZCXFIhPGQMvhZD5l56VfXXTM1kxeR4s
	 63lcWiGZUkXHsbIFPvs20QmSuHSMpMbCJilJBBMj19QflbX0/NsCkMTkSVD6FcRk73
	 j4ZzWWhtVkgZQr5sUJUZ/EMh4SmQgszZLQphaCHwc26ZUxqQ/esMLknjLzdNNPhIuJ
	 h0grHcL1g4J5XDEtw+d7wOxqj44DyfXnV3urnoHf/WxHvtVuYWj8BBrexQxlSiCIXi
	 m5JcaklEUCDqQqc63W+RvQmYnA9tV+x8VLay+w7oB3nwu/vHod+z4jIlvxmYvd3jZL
	 DL9K/y86mtfJg==
Message-ID: <c144fed9-89f6-48c3-9365-bb24260a661d@kernel.org>
Date: Fri, 22 Nov 2024 14:17:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
 Xiuhong Wang <xiuhong.wang@unisoc.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add a sysfs node to limit max read
 extent count per-inode
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20241121015751.2300234-1-chao@kernel.org>
 <20241121015751.2300234-2-chao@kernel.org>
 <CAHJ8P3LhPzmzf-tgiwSh+a+W+EC7pFE9+=RqkHL1543cHMag2w@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LhPzmzf-tgiwSh+a+W+EC7pFE9+=RqkHL1543cHMag2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/22 13:23, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2024年11月21日周四 10:01写道：
>>
>> Quoted:
>> "at this time, there are still 1086911 extent nodes in this zombie
>> extent tree that need to be cleaned up.
>>
>> crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
>>    node_cnt = {
>>      counter = 1086911
>>    },
>> "
>>
>> As reported by Xiuhong, there will be a huge number of extent nodes
>> in extent tree, it may potentially cause:
>> - slab memory fragments
>> - extreme long time shrink on extent tree
>> - low mapping efficiency
>>
>> Let's add a sysfs node to limit max read extent count for each inode,
>> by default, value of this threshold is 10240, it can be updated
>> according to user's requirement.
>>
>> Reported-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
>> Closes: https://lore.kernel.org/linux-f2fs-devel/20241112110627.1314632-1-xiuhong.wang@unisoc.com/
>> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>>   fs/f2fs/extent_cache.c                  | 5 ++++-
>>   fs/f2fs/f2fs.h                          | 4 ++++
>>   fs/f2fs/sysfs.c                         | 7 +++++++
>>   4 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 513296bb6f29..3e1630c70d8a 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -822,3 +822,9 @@ Description:        It controls the valid block ratio threshold not to trigger excessiv
>>                  for zoned deivces. The initial value of it is 95(%). F2FS will stop the
>>                  background GC thread from intiating GC for sections having valid blocks
>>                  exceeding the ratio.
>> +
>> +What:          /sys/fs/f2fs/<disk>/max_read_extent_count
>> +Date:          November 2024
>> +Contact:       "Chao Yu" <chao@kernel.org>
>> +Description:   It controls max read extent count for per-inode, the value of threshold
>> +               is 10240 by default.
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index b7a6817b44b0..347b3b647834 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -717,7 +717,9 @@ static void __update_extent_tree_range(struct inode *inode,
>>                  }
>>
>>                  if (end < org_end && (type != EX_READ ||
>> -                               org_end - end >= F2FS_MIN_EXTENT_LEN)) {
>> +                       (org_end - end >= F2FS_MIN_EXTENT_LEN &&
>> +                       atomic_read(&et->node_cnt) <
>> +                                       sbi->max_read_extent_count))) {
>>                          if (parts) {
>>                                  __set_extent_info(&ei,
>>                                          end, org_end - end,
>> @@ -1212,6 +1214,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
>>          sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
>>          sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
>>          sbi->last_age_weight = LAST_AGE_WEIGHT;
>> +       sbi->max_read_extent_count = DEF_MAX_READ_EXTENT_COUNT;
>>   }
>>
>>   int __init f2fs_create_extent_cache(void)
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index b65b023a588a..6f2cbf4c5740 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -635,6 +635,9 @@ enum {
>>   #define DEF_HOT_DATA_AGE_THRESHOLD     262144
>>   #define DEF_WARM_DATA_AGE_THRESHOLD    2621440
>>
>> +/* default max read extent count per inode */
>> +#define DEF_MAX_READ_EXTENT_COUNT      10240
>> +
>>   /* extent cache type */
>>   enum extent_type {
>>          EX_READ,
>> @@ -1619,6 +1622,7 @@ struct f2fs_sb_info {
>>          /* for extent tree cache */
>>          struct extent_tree_info extent_tree[NR_EXTENT_CACHES];
>>          atomic64_t allocated_data_blocks;       /* for block age extent_cache */
>> +       unsigned int max_read_extent_count;     /* max read extent count per inode */
>>
>>          /* The threshold used for hot and warm data seperation*/
>>          unsigned int hot_data_age_threshold;
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index bdbf24db667b..d1356c656cac 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -787,6 +787,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>                  return count;
>>          }
>>
>> +       if (!strcmp(a->attr.name, "max_read_extent_count")) {
>> +               if (t > UINT_MAX)
>> +                       return -EINVAL;
>> +               *ui = (unsigned int)t;
>> +               return count;
>> +       }
>> +
> Hi Chao,
> from Xiuhong remider, it seems miss codes of adding sysfs node
> "max_read_extent_count"?
> F2FS_SBI_GENERAL_RW_ATTR(max_read_extent_count);
> ATTR_LIST(max_read_extent_count);

Oops, let me fix this soon.

Thanks,

> thanks！
>>          if (!strcmp(a->attr.name, "ipu_policy")) {
>>                  if (t >= BIT(F2FS_IPU_MAX))
>>                          return -EINVAL;
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



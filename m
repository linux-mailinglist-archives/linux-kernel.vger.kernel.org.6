Return-Path: <linux-kernel+bounces-563381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FFA64093
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31283AA2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA59215047;
	Mon, 17 Mar 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT59GHJl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5C2E3373
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191414; cv=none; b=VHDOjpQVyL/h6Rk9N4PkL7G1/yi9cQaMBfnjs9JDauovNriBHOUSA34cPw7dsNDLwk8/FpVw35YZuqBkxHBYiuejASIAGEryNfyqqJQtDG0PeEr6l+UBFXB0s2PDceG55a+uX2M7qB0K1hXSv76WFE87tTe5zeYHRnwsScV3VMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191414; c=relaxed/simple;
	bh=9GuJYZNYYI8a++OQNnQqfYWr0hu/Ni006bEAgzjYOk4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kole2/akJPrvouP68YOvdJPYE/8YfR62ciHdsKcfSIGOYx1JnVXLxVTYePOT0WGd4Yv/1St6EnzdO3zVx6smiaQfEOEtQX0BVxpkUXfONsr7ZH/wO/uLXC0KATwRV5wrepyCZJQtxIr2f3t1LKW8E+8InQ60rbir+ia62EP5BpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT59GHJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0586C4CEE3;
	Mon, 17 Mar 2025 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742191413;
	bh=9GuJYZNYYI8a++OQNnQqfYWr0hu/Ni006bEAgzjYOk4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RT59GHJld+0mf/54D79lBO7EzTph/n9ZtqLsXyJUw6nxnKDLZi1shV1/+JJheYT2s
	 ilR/GHkvuK20xHoddW+xX5eGkvseEHWHJjFQ3DxGy3TOyNsELtTaT7UPLfLVlFvRj6
	 y1vm9fpZe86I+8qzbCYsBUnWd+G6tdtcix577CF0hWh81f5p1LuQ89tTrdmoZWy56H
	 arCb05nMlK+79yoJf2DKuYF1ZbAgfjsjN/A06tCP4M0msYDs7CPlWWPHPYE+4T83a7
	 9KDjhfQF2pozZnwk9wykLMpIOR174BJlaNSxuyjBneDmpQbJahgQPCE0vcZeb0y0Q8
	 oXVgiopNNJhAw==
Message-ID: <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
Date: Mon, 17 Mar 2025 14:03:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/17/25 01:17, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/3/16 10:36, Chao Yu wrote:
>> On 2025/2/10 11:29, Hongzhen Luo wrote:
>>> There's no need to enumerate each type.  No logic changes.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Looks good to me, feel free to add:
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
>> And one minor comment below.
>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 689437e99a5a..d278ebd60281 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>>>           if (err)
>>>               return err;
>>> -        switch (m->type) {
>>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>>> +                  m->type, lcn, vi->nid);
>>> +            DBG_BUGON(1);
>>> +            return -EOPNOTSUPP;
>>  > +        } else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {>               lookback_distance = m->delta[0];
>>>               if (!lookback_distance)
>>> -                goto err_bogus;
>>> +                break;
>>>               continue;
>>> -        case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>>> -        case Z_EROFS_LCLUSTER_TYPE_HEAD2:
>>> +        } else {
>>>               m->headtype = m->type;
>>>               m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>>>               return 0;
>>> -        default:
>>> -            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>>> -                  m->type, lcn, vi->nid);
>>> -            DBG_BUGON(1);
>>> -            return -EOPNOTSUPP;
>>
>> Should return EFSCORRUPTED here? is m->type >= Z_EROFS_LCLUSTER_TYPE_MAX a possible
>> case?
> 
> It's impossible by the latest on-disk definition, see:
> #define Z_EROFS_LI_LCLUSTER_TYPE_MASK    (Z_EROFS_LCLUSTER_TYPE_MAX - 1)
> 
> Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
> introduced, but the `default:` case is already deadcode now.

Xiang, thanks for the explanation.

So seems it can happen when mounting last image w/ old kernel which can not
support newly introduced Z_EROFS_LCLUSTER_TYPE_* type, then it makes sense to
return EOPNOTSUPP.

> 
>>
>> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
>> then we can treat m->type as reliable variable later.
>>
>>      advise = le16_to_cpu(di->di_advise);
>>      m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>>      if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> 
> It's always false here.

So, what do you think of this?

From af584b2eacd468f145e9ee31ccdeedb7355d5afd Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 17 Mar 2025 13:57:55 +0800
Subject: [PATCH] erofs: remove dead codes for cleanup

z_erofs_extent_lookback() and z_erofs_get_extent_decompressedlen() tries
to do sanity check on m->type, however their caller z_erofs_map_blocks_fo()
has already checked that, so let's remove those dead codes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/zmap.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 8de50df05dfe..4d883ec212d7 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -265,17 +265,12 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;

-		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
-		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
 			if (!lookback_distance)
 				break;
 			continue;
-		} else {
+		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
@@ -379,11 +374,6 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			if (lcn != headlcn)
 				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
-		} else {
-			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 		lcn += m->delta[1];
 	}
-- 
2.48.1

> 
> Thanks,
> Gao Xiang
> 



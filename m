Return-Path: <linux-kernel+bounces-240585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428EE926F59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB71C1F23F57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4249B1A01DE;
	Thu,  4 Jul 2024 06:12:13 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E9FC0A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073532; cv=none; b=daKXEs26Sx6DaoEc0QG0mvwyisWCfsdLwyG+iAXp46rjjGRfAEs0VDcWEC+iaNSdtG/KPrKGA0DhK5UI/MnSBo5+Sjsty/YOSNdCTY9dKcUHelp014/xcSslRpCP1+1diGz5Yxh5Zk4kSBjhSezkcxh8Xjgroc4W1zwP2S4sSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073532; c=relaxed/simple;
	bh=E28hKvKAnhDP3fyUZsqXxT9ZZJqXqUBizStsc+VhHoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L50zotp+icLF9YzqmJckr7DRyLYu+04FVUGL701x9R+vLCMpApdXcE6DR4QKoAFVBI73xGrh5ZsHsySCyyQz6sq2ktKqjcODjjWmFiHrzvVohTwmf6VWtcV02cXvokOfknM1LESfbXFftdBfi7cDN2pqKKYAgEkL7Sg04lH00BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WF5q42SdSzdg8G;
	Thu,  4 Jul 2024 14:10:24 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id DA67D140157;
	Thu,  4 Jul 2024 14:12:01 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jul 2024 14:12:01 +0800
Message-ID: <7b7f2eb7-953a-4aa0-acb0-1ab32c7cc1bf@huawei.com>
Date: Thu, 4 Jul 2024 14:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Content-Language: en-US
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham
	<nphamcs@gmail.com>, Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
 <20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org>
 <825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/4 11:21, Hugh Dickins wrote:
> On Wed, 3 Jul 2024, Andrew Morton wrote:
>> On Tue, 2 Jul 2024 00:40:55 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
>>
...
> 
> And perhaps a conflict with another one of Kefeng's, which deletes a hunk
> in mm/migrate.c just above where I add a hunk: and that's indeed how it
> should end up, hunk deleted by Kefeng, hunk added by me.
> 
>>
>> --- mm/memcontrol.c~mm-refactor-folio_undo_large_rmappable
>> +++ mm/memcontrol.c
>> @@ -7832,8 +7832,7 @@ void mem_cgroup_migrate(struct folio *ol
>>   	 * In addition, the old folio is about to be freed after migration, so
>>   	 * removing from the split queue a bit earlier seems reasonable.
>>   	 */
>> -	if (folio_test_large(old) && folio_test_large_rmappable(old))
>> -		folio_undo_large_rmappable(old);
>> +	folio_undo_large_rmappable(old);
>>   	old->memcg_data = 0;
>>   }
>>
>> I'm resolving this by simply dropping the above hunk.  So Kefeng's
>> patch is now as below.  Please check.
> 
> Checked, and that is correct, thank you Andrew.  Correct, but not quite
> complete: because I'm sure that if Kefeng had written his patch after
> mine, he would have made the equivalent change in mm/migrate.c:
> 

Yes,

> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -443,8 +443,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>   	}
>   
>   	/* Take off deferred split queue while frozen and memcg set */
> -	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
> -		folio_undo_large_rmappable(folio);
> +	folio_undo_large_rmappable(folio);
>   
>   	/*
>   	 * Now we know that no one else is looking at the folio:
> 
> But there's no harm done if you push out a tree without that additional
> mod: we can add it as a fixup afterwards, it's no more than a cleanup.
> 
Maybe we could convert to __folio_undo_large_rmappable() for !maping 
part, which will avoid unnecessary freeze/unfreeze for empty deferred
list.

diff --git a/mm/migrate.c b/mm/migrate.c
index ca65f03acb31..e6af9c25c25b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -412,10 +412,11 @@ static int __folio_migrate_mapping(struct 
address_space *mapping,
         if (!mapping) {
                 /* Take off deferred split queue while frozen and memcg 
set */
                 if (folio_test_large(folio) &&
-                   folio_test_large_rmappable(folio)) {
+                   folio_test_large_rmappable(folio) &&
+                   !data_race(list_empty(&folio->_deferred_list))) {
                         if (!folio_ref_freeze(folio, expected_count))
                                 return -EAGAIN;
-                       folio_undo_large_rmappable(folio);
+                       __folio_undo_large_rmappable(folio);
                         folio_ref_unfreeze(folio, expected_count);
                 }


> (I'm on the lookout for an mm.git update, hope to give it a try when it
> appears.)
> 
> Thanks,
> Hugh
> 


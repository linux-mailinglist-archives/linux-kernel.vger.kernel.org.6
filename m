Return-Path: <linux-kernel+bounces-528022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F67A41295
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4983B1045
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A32629F;
	Mon, 24 Feb 2025 01:19:19 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088828F1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740359959; cv=none; b=hZeTBmwLkPvJJr4YSi0pfAEAqLyK7eptpDb1ZXoJTiwORLOgx8areKAFVsVKxRPau2JIFt0UvE9y5QpLnswds+AWUGRZa83UHCJXgn7re8xHymg7kkBDcKZF0xV0DzSb+WMIeNIq+qFwGW1vJNkBpxUpsksEGFJEBetFN+y+sXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740359959; c=relaxed/simple;
	bh=H+9A0VE2QeyHRrBytWf66i6/Qipgc3EEC1DoBddOhrg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uDk90aPhm3B8SNhPds7lDnBYeMBuv/RTzju0FCMkETEQO0+J30D69oHR66/+VOScKhbDmaNFTNHgtvoH3N3rum+ULSsTPXYVq7s1YB7CPG7aKISf77feKU1RQ7iEFXJMfM3dVGUs4jEAs26QwjG02RLOR6Tu6eWMSdkcMpXl5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z1ND22TV7z4f3kvt
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:18:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 85ADC1A169E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:19:05 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgBnB8IJybtnlgKiEg--.53879S2;
	Mon, 24 Feb 2025 09:19:05 +0800 (CST)
Subject: Re: [PATCH 1/6] mm: swap: avoid losting cluster in
 swap_reclaim_full_clusters()
To: Kairui Song <ryncsn@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250222160850.505274-1-shikemeng@huaweicloud.com>
 <20250222160850.505274-2-shikemeng@huaweicloud.com>
 <CAMgjq7Axk-rh+3hMpSisxKRU6W1tApgVA1H5zswC7z0q-t0-eg@mail.gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c745e8a1-5c94-4510-56fe-f1528295575c@huaweicloud.com>
Date: Mon, 24 Feb 2025 09:17:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMgjq7Axk-rh+3hMpSisxKRU6W1tApgVA1H5zswC7z0q-t0-eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnB8IJybtnlgKiEg--.53879S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4kKF4Uur1fJF1kCFW8tFb_yoW8Ww1xpF
	93K3WDCFs5tryDKF12vwnFg34Y9r48KFy5JrWaqw1Skr98ur1SkrZrKr4rZayDur1kt34D
	ZF1qg3W7urs0va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/23/2025 1:19 AM, Kairui Song wrote:
> On Sat, Feb 22, 2025 at 3:12 PM Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>> If no swap cache is reclaimed, cluster taken off from full_clusters list
>> will not be put in any list and may not be reused. Do relocate_cluster
>> for such cluster to fix the issue.
>>
>> Fixes: 3b644773eefda ("mm, swap: reduce contention on device lock")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  mm/swapfile.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 34baefb000b5..e5f58ab86329 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -861,6 +861,10 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
>>                         offset++;
>>                 }
>>
>> +               /* in case no swap cache is reclaimed */
>> +               if (ci->flags == CLUSTER_FLAG_NONE)
>> +                       relocate_cluster(si, ci);
>> +
>>                 unlock_cluster(ci);
>>                 if (to_scan <= 0)
>>                         break;
>> --
>> 2.30.0
> 
> Thanks. A little nick pick, "losting" is not a word, I think you mean "leaking".
> 
> And BTW maybe it's better to describe the result of this leak in a bit
> more details, "cluster leaking from lists" and "will not be reused"
> looked a bit scary at a glance to me. But realizing it's full
> clusters, they will be moved back to a list if any slots on them are
> freed, so the worst result is inefficiently reclaiming of HAS_CACHE
> slots, we didn't really lose these clusters.
> 
> We do need to fix it though. So other than the commit summary and
> message nitpick:
Thanks for feedback, I will improve commit summary and message in next
verstion.
> 
> Reviewed-by: Kairui Song <kasong@tencent.com>
> 



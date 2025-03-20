Return-Path: <linux-kernel+bounces-569012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A89A69D68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F246161C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC5190674;
	Thu, 20 Mar 2025 01:05:59 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F6364BA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742432759; cv=none; b=m0lIFo8OFRbcN9vFfLJCLDWuj4Rh8nft4cH7A3TF4gIyUPMx0CaRlUns+TcFz5K31u18SkWg0oVCKdN6M/WN3Q42bmHU/Wn4XYqo9Qb+v5ckabi5w3K9FjJsffqbuM85D1+iz3COC9Jo9+SoZ2EDtHhYb6LR4jVy2ek1BscodgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742432759; c=relaxed/simple;
	bh=LJaLXiz3XkXvh6NiHdaGlDdF70one7iQSl3w/oKbulE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=imr9gH8GE+zyjlxNw5rjkjq12NASv65tlZ00bHokVWs6heNwUlC0vwBYCH/jz4Mo/34ZAUaPEcSaVUfznHuSNPzOBHITwooOVXBDS9BMQxqlb+UMc/xOSEHw8izKRM1EIF7rteK4uVaUiJ2HlHBAoN47zmSWg5KCD6N92lzINvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZJ6nc3sTRz4f3mJq
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:05:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3A60B1A06DC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:05:47 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgCHj2LpadtndvXZGw--.28489S2;
	Thu, 20 Mar 2025 09:05:47 +0800 (CST)
Subject: Re: [PATCH v2 3/8] mm: swap: use swap_entries_free() to free swap
 entry in swap_entry_put_locked()
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250318150614.6415-1-shikemeng@huaweicloud.com>
 <20250318150614.6415-4-shikemeng@huaweicloud.com>
 <CAMgjq7CXxpG0doC9iXAXkq_ozvN43gBbG7UsNk8_PYMvpLABHA@mail.gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <cc20b08d-a43e-87ad-490d-12714602cd39@huaweicloud.com>
Date: Thu, 20 Mar 2025 09:05:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMgjq7CXxpG0doC9iXAXkq_ozvN43gBbG7UsNk8_PYMvpLABHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHj2LpadtndvXZGw--.28489S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr15Kr13XF18JFyUAw15CFg_yoW5uw43pF
	sIgFs8KFs7Ar17Kr45Zws8Zw40vw4xKw12gF9rG3W5ZasxXryFgFyqyrWagFyUAwn5CasY
	v3WUtr9ruFs8tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/19/2025 2:08 AM, Kairui Song wrote:
> On Tue, Mar 18, 2025 at 2:10 PM Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>> In swap_entry_put_locked(), we will set slot to SWAP_HAS_CACHE before
>> using swap_entries_free() to do actual swap entry freeing. This
>> introduce an unnecessary intermediate state.
>> By using swap_entries_free() in swap_entry_put_locked(), we can
>> eliminate the need to set slot to SWAP_HAS_CACHE.
>> This change would make the behavior of swap_entry_put_locked() more
>> consistent with other put() operations which will do actual free work
>> after put last reference.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>  mm/swapfile.c | 23 ++++++++++-------------
>>  1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 0aa7ce82c013..40e41e514813 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1348,9 +1348,11 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
>>  }
>>
>>  static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
>> -                                          unsigned long offset,
>> +                                          struct swap_cluster_info *ci,
>> +                                          swp_entry_t entry,
>>                                            unsigned char usage)
>>  {
>> +       unsigned long offset = swp_offset(entry);
>>         unsigned char count;
>>         unsigned char has_cache;
>>
>> @@ -1382,7 +1384,7 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
>>         if (usage)
>>                 WRITE_ONCE(si->swap_map[offset], usage);
>>         else
>> -               WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
>> +               swap_entries_free(si, ci, entry, 1);
>>
>>         return usage;
>>  }
>> @@ -1461,9 +1463,7 @@ static unsigned char swap_entry_put(struct swap_info_struct *si,
>>         unsigned char usage;
>>
>>         ci = lock_cluster(si, offset);
>> -       usage = swap_entry_put_locked(si, offset, 1);
>> -       if (!usage)
>> -               swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
>> +       usage = swap_entry_put_locked(si, ci, entry, 1);
>>         unlock_cluster(ci);
>>
>>         return usage;
>> @@ -1551,8 +1551,8 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
>>
>>         ci = lock_cluster(si, offset);
>>         do {
>> -               if (!swap_entry_put_locked(si, offset, usage))
>> -                       swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
>> +               swap_entry_put_locked(si, ci, swp_entry(si->type, offset),
>> +                                     usage);
>>         } while (++offset < end);
>>         unlock_cluster(ci);
>>  }
>> @@ -1596,12 +1596,9 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>>         ci = lock_cluster(si, offset);
>>         if (swap_only_has_cache(si, offset, size))
>>                 swap_entries_free(si, ci, entry, size);
>> -       else {
>> -               for (int i = 0; i < size; i++, entry.val++) {
>> -                       if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
>> -                               swap_entries_free(si, ci, entry, 1);
>> -               }
>> -       }
>> +       else
>> +               for (int i = 0; i < size; i++, entry.val++)
>> +                       swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
> 
> I'd prefer you keep the bracket here for more readability, and maybe
> add bracket for the whole if statement, just a tiny nitpick so still:
Thanks for review. Both ways are acceptable to me. I will keep the
bracket in next version.

Thanks,
Kemeng
> 
> Reviewed-by: Kairui Song <kasong@tencent.com>
> 
>>         unlock_cluster(ci);
>>  }
> 
>>
>> --
>> 2.30.0
>>
> 



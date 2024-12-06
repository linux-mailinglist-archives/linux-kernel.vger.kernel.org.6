Return-Path: <linux-kernel+bounces-434478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305139E675A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE0A1882BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBA1DA61D;
	Fri,  6 Dec 2024 06:41:03 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332361D7E35;
	Fri,  6 Dec 2024 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467263; cv=none; b=MB7VpBsKVq73S7bcDgwOZgeC7K1HMox6ls+4dk1k7kKSTvI81WQ6BhqCXA5ch9bYBWB93GYWLltAQgdoSqBPpcyAxNaIHDSTvfUc7wejMf3qEYWu2KpNSENumEVdp1pGA4lehWcinxTRUi9cQ7BfLt70qLi85lJEIy9f7TkjRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467263; c=relaxed/simple;
	bh=66+PVLJ+QChN/bHTgdHcuh9hc8K19AZ0ZHwK+EOPX7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQT2uBugRpv2QFxLU891Ojgd5g48Jrd0YNTH44SmqmRXejjNePoPRREUf9oIZQumKHNycSzJShjxRe0HijR8aWfmmuCybo+Wz7sSs/RM9uMB8aHQ+qI0MEGMkHrCG/6k1YoaCDaWq2z84NYbYTwZav0mz6w0siqh6rF9JguUiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4M8L4L8Xz4f3lVM;
	Fri,  6 Dec 2024 14:40:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A8E281A0196;
	Fri,  6 Dec 2024 14:40:54 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgA35uJ1nFJnECUdDw--.53652S2;
	Fri, 06 Dec 2024 14:40:54 +0800 (CST)
Message-ID: <897b04c9-dba3-44ae-8113-145ca3457cb3@huaweicloud.com>
Date: Fri, 6 Dec 2024 14:40:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size
 function
To: Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-4-chenridong@huaweicloud.com>
 <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA35uJ1nFJnECUdDw--.53652S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4rCryrGw48XFW8Ar43Wrg_yoW8ZF15pF
	W7CFyFy3WkArW7u3s7twsaq3y2krs5JFWUXF9xX34fJw1j9FyIkF4UtrWYqrW7AFn5Cw43
	trZxWr1vyFZ0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/6 13:33, Yu Zhao wrote:
> On Thu, Dec 5, 2024 at 6:45 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> In the `mem_cgroup_update_lru_size` function, the `lru_size` should be
>> updated by adding `nr_pages` regardless of whether `nr_pages` is greater
>> than 0 or less than 0. To simplify this function, add a check for
>> `nr_pages` == 0. When `nr_pages` is not equal to 0, perform the same
>> actions.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> NAK.
> 
> The commit that added that clearly explains why it was done that way.

Thank you for your reply.

I have read the commit message for ca707239e8a7 ("mm: update_lru_size
warn and reset bad lru_size") before sending my patch. However, I did
not quite understand why we need to deal with the difference between
'nr_pages > 0' and 'nr_pages < 0'.


The 'lru_zone_size' can only be modified in the
'mem_cgroup_update_lru_size' function. Only subtracting 'nr_pages' or
adding 'nr_pages' in a way that causes an overflow can make the size < 0.

For case 1, subtracting 'nr_pages', we should issue a warning if the
size goes below 0. For case 2, when adding 'nr_pages' results in an
overflow, there will be no warning and the size won't be reset to 0 the
first time it occurs . It might be that a warning will be issued the
next time 'mem_cgroup_update_lru_size' is called to modify the
'lru_zone_size'. However, as the commit message said, "the first
occurrence is the most informative," and it seems we have missed that
first occurrence.

As the commit message said: "and then the vast unsigned long size draws
page reclaim into a loop of repeatedly", I think that a warning should
be issued and 'lru_zone_size' should be reset whenever 'size < 0' occurs
for the first time, whether from subtracting or adding 'nr_pages'.

I am be grateful if you can explain more details, it has confused me for
a while. Thank you very much.

Best regards,
Ridong



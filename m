Return-Path: <linux-kernel+bounces-367986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B679A091C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100A1B24477
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28DB208205;
	Wed, 16 Oct 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlupUrHu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rICVpDPP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlupUrHu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rICVpDPP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C772206E71
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080824; cv=none; b=I+yvs2qakRIYxjk0rsbaHDj0LD/kTa2w3Pv8xTe7tAKTJAhSPyEpU41QJlF/GIzMSsmJHa0441xjBo/8ew2eGBX05J/TA0pd7DZgz/Y7hnFNVMd2ESuBso2cV76uDye1nqUDoSEHWFp3K25qRfK4oXT0wHTtIxWXUL2VB6tq7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080824; c=relaxed/simple;
	bh=1q4yEcJFxZRHtqiK0sql/hXShW5iki8lFBMnyaKMa/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqBBuf4lsS/fjVc1sTZOSSdr3WRmdtnJusaVJuz75k0ZpH54Hi95+UXSQ2aQi24zvO3rpLhJf7elj0O4FyE4NZFJWUf5Tdrfoq+nPhAwvWlPfbVTmp5dA0rjq+l0arMvrFyZYsKxZ+JgGp7lXCQM2drdau4hLE+9fUxEHJaQ1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlupUrHu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rICVpDPP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlupUrHu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rICVpDPP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60D1521B58;
	Wed, 16 Oct 2024 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729080820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk42CWZOANsqQxbXzgz8My19rRwDUHEJZtFu8XOqV3g=;
	b=rlupUrHuRXpN+GSHy77ojANHeFIMf3pdlQk69VCrQSkldUyPKn1nBlhPM1lgPVbA7FmyOa
	j4kCvsJ1JS0hDiqxKhjYHvXGHOnN7JixBnbI/SI6OFB7oUy4gYqSkiC8W+aZWgw/nPo4qi
	4amM/IS3sQxcIN7KXs5kpDfaYuMw+LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729080820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk42CWZOANsqQxbXzgz8My19rRwDUHEJZtFu8XOqV3g=;
	b=rICVpDPPYjlz9GViKfD06PJsJwqcVNR1wG71TDzu4iExrydDyqwAmZ+nxYlWDb/R2BkenX
	eHvuzwzarVzlQRDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rlupUrHu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rICVpDPP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729080820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk42CWZOANsqQxbXzgz8My19rRwDUHEJZtFu8XOqV3g=;
	b=rlupUrHuRXpN+GSHy77ojANHeFIMf3pdlQk69VCrQSkldUyPKn1nBlhPM1lgPVbA7FmyOa
	j4kCvsJ1JS0hDiqxKhjYHvXGHOnN7JixBnbI/SI6OFB7oUy4gYqSkiC8W+aZWgw/nPo4qi
	4amM/IS3sQxcIN7KXs5kpDfaYuMw+LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729080820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk42CWZOANsqQxbXzgz8My19rRwDUHEJZtFu8XOqV3g=;
	b=rICVpDPPYjlz9GViKfD06PJsJwqcVNR1wG71TDzu4iExrydDyqwAmZ+nxYlWDb/R2BkenX
	eHvuzwzarVzlQRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4403E13433;
	Wed, 16 Oct 2024 12:13:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R5f5D/StD2ekbwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Oct 2024 12:13:40 +0000
Message-ID: <270ca4d5-b35f-4533-87c9-dc15e7b00f6f@suse.cz>
Date: Wed, 16 Oct 2024 14:13:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>, chenridong <chenridong@huawei.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <c34b962b-8b9a-41e5-a54e-364b826c5e2a@arm.com>
 <178A7AC8-0BDA-42CA-86B2-E1C13F3E1E8B@linux.dev>
 <1dc9acbd-351f-4755-8c56-d3d77aaccfb2@huawei.com>
 <F8EBBED0-6D7D-4A23-AC8C-3E395EA1BF12@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <F8EBBED0-6D7D-4A23-AC8C-3E395EA1BF12@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 60D1521B58
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/14/24 11:20, Muchun Song wrote:
> 
> 
>> On Oct 14, 2024, at 17:04, chenridong <chenridong@huawei.com> wrote:
>> 
>> 
>> 
>> On 2024/10/14 16:43, Muchun Song wrote:
>>>> On Oct 14, 2024, at 16:13, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>> 
>>>> 
>>>> 
>>>> On 10/14/24 08:53, Chen Ridong wrote:
>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>> 
>>>>> A memleak was found as bellow:
>>>>> 
>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>>  comm "mkdir", pid 1559, jiffies 4294932666
>>>>>  hex dump (first 32 bytes):
>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>>>  backtrace (crc 2e7ef6fa):
>>>>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>> 
>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>>>> err, the info won't be freed. Just fix it.
>>>>> 
>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>> ---
>>>>> mm/shrinker.c | 1 +
>>>>> 1 file changed, 1 insertion(+)
>>>>> 
>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>>> --- a/mm/shrinker.c
>>>>> +++ b/mm/shrinker.c
>>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>> 
>>>>> err:
>>>>> mutex_unlock(&shrinker_mutex);
>>>>> + kvfree(info);
>>>>> free_shrinker_info(memcg);
>>>>> return -ENOMEM;
>>>>> }
>>>> 
>>>> There are two scenarios when "goto err:" gets called
>>>> 
>>>> - When shrinker_info allocations fails, no kvfree() is required
>>>> - but after this change kvfree() would be called even
>>>>  when the allocation had failed originally, which does
>>>>    not sound right
>>> Yes. In this case, @info is NULL and kvfree could handle NULL.
>>> It seems strange but the final behaviour correct.
>>>> 
>>>> - shrinker_unit_alloc() fails, kvfree() is actually required
>>>> 
>>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>>> fails but before calling into "goto err".
>>> We could do it like this, which avoids ambiguity (if someone ignores
>>> that kvfree could handle NULL). Something like:
>>> --- a/mm/shrinker.c
>>> +++ b/mm/shrinker.c
>>> @@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>                         goto err;
>>>                 info->map_nr_max = shrinker_nr_max;
>>>                 if (shrinker_unit_alloc(info, NULL, nid))
>>> -                       goto err;
>>> +                       goto free;
>>>                 rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>         }
>>>         mutex_unlock(&shrinker_mutex);
>>>         return ret;
>>> -
>>> +free:
>>> +       kvfree(info);
>>>  err:
>>>         mutex_unlock(&shrinker_mutex);
>>>         free_shrinker_info(memcg);
>>> Thanks.
>>>> 
>>>> But curious, should not both kvzalloc_node()/kvfree() be avoided
>>>> while inside mutex lock to avoid possible lockdep issues ?
>> How about:
>> 
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index dc5d2a6fcfc4..7baee7f00497 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -87,9 +87,9 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>                 if (!info)
>>                         goto err;
>>                 info->map_nr_max = shrinker_nr_max;
>> +               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>                 if (shrinker_unit_alloc(info, NULL, nid))
>>                         goto err;
>> -               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>         }
>>         mutex_unlock(&shrinker_mutex);
> 
> No. We should make sure the @info is fully initialized before others
> could see it. That's why rcu_assign_pointer is used here.

If the info is immediately visible, is the failure cleanup
free_shrinker_info() safe? It uses kvfree(info) and not kvfree_rcu(), and
shrinker_unit_free() is also doing kfree().

>> 
>> I think this is concise.
>> 
>> Best regards,
>> Ridong
> 
> 



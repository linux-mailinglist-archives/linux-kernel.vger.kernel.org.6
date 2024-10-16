Return-Path: <linux-kernel+bounces-368477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D19A1040
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394CF1C21432
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867918A928;
	Wed, 16 Oct 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUxGi6DD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEF5krdu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUxGi6DD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEF5krdu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E6143744
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098147; cv=none; b=Jy05CmRelc7yhBFdp2FG12RrxGXEMaw4nFPA4UTJEMEF8gcFU1tJ56Io33SutiDtJc6FVXqB5CkAjdXbIwFvyCs8taDfngv+XEnuBJxZf2kPC7TzScLHITeUn6gYuyb1X4N2AgI76cnUwC0wlQn+MW/Xjh2KId0Cjvf6+ufzfDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098147; c=relaxed/simple;
	bh=aw+JqN6++qOWWAvkAJpVWFJ8aHiY+1KDmWB5u5YA8Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMbUh2FByl8dv2W6OYQ6gcV6JDpmxTXSHG9MxV628tRiM3WIcsp3vTTSQ1ZMEHiyy6107PDT5RPwQZbjuISfM3CQD5EMOMtKpC3D+qfZOl92kT8FqHrmFfGq6QMfxcadFo7SUZVSnr4VhbjTZou9dzR0ymxVNnQfLCE5ZxWwr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUxGi6DD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEF5krdu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUxGi6DD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEF5krdu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74AF921ED2;
	Wed, 16 Oct 2024 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729098143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/q/Uv6qWezncSwuZ+eugisRocLDwMwtqjAd1EYzt6G4=;
	b=nUxGi6DDsTv+Ho30H1l7v5BD8icSPi52yfQH78Yj3XLDIN50tcMdRVU8NiwVFPE3nz0c52
	f7XhQBUOEwG9TnW0TgSHlZ09D/hVlnk8bOfS9nobWqLQoWEO1r0pXvkjNaHCdQvn24JaoH
	FS5BovJFAGkjnuDktHgTACGuN6leHYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729098143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/q/Uv6qWezncSwuZ+eugisRocLDwMwtqjAd1EYzt6G4=;
	b=MEF5krduLFOKIYgx/iZSJ/ax5VY0H5WtWw0wIo4XGcxom4xE3PDaHTmwveR1T0AQAZu5vy
	YHCs+DYVgmAea3Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729098143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/q/Uv6qWezncSwuZ+eugisRocLDwMwtqjAd1EYzt6G4=;
	b=nUxGi6DDsTv+Ho30H1l7v5BD8icSPi52yfQH78Yj3XLDIN50tcMdRVU8NiwVFPE3nz0c52
	f7XhQBUOEwG9TnW0TgSHlZ09D/hVlnk8bOfS9nobWqLQoWEO1r0pXvkjNaHCdQvn24JaoH
	FS5BovJFAGkjnuDktHgTACGuN6leHYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729098143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/q/Uv6qWezncSwuZ+eugisRocLDwMwtqjAd1EYzt6G4=;
	b=MEF5krduLFOKIYgx/iZSJ/ax5VY0H5WtWw0wIo4XGcxom4xE3PDaHTmwveR1T0AQAZu5vy
	YHCs+DYVgmAea3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A4CD13433;
	Wed, 16 Oct 2024 17:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nKSxFZ/xD2cjTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Oct 2024 17:02:23 +0000
Message-ID: <0b883f9e-451f-41c2-805f-7f5bc7eebee2@suse.cz>
Date: Wed, 16 Oct 2024 19:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: chenridong <chenridong@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <fff87be9-fdc8-4c27-8335-17b0c7e16413@suse.cz>
 <1BD74B20-879A-4159-B957-1223553217C1@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <1BD74B20-879A-4159-B957-1223553217C1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/16/24 16:08, Muchun Song wrote:
> 
> 
>> On Oct 16, 2024, at 19:43, Vlastimil Babka <vbabka@suse.cz> wrote:
>> ﻿On 10/16/24 04:21, Muchun Song wrote:
>>> 
>>> 
>>>> On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
>>>> On 2024/10/15 14:55, Anshuman Khandual wrote:
>>>>> On 10/14/24 16:59, Kirill A. Shutemov wrote:
>>>>>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
>>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>> A memleak was found as bellow:
>>>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>>>>  comm "mkdir", pid 1559, jiffies 4294932666
>>>>>>>  hex dump (first 32 bytes):
>>>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>>>>>  backtrace (crc 2e7ef6fa):
>>>>>>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>>>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>>>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>>>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>>>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>>>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>>>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>>>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>>>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>>>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>>>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>>>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>>>>>> err, the info won't be freed. Just fix it.
>>>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>>> ---
>>>>>>> mm/shrinker.c | 1 +
>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>>>>> --- a/mm/shrinker.c
>>>>>>> +++ b/mm/shrinker.c
>>>>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>>>   err:
>>>>>>>  mutex_unlock(&shrinker_mutex);
>>>>>>> + kvfree(info);
>>>>>>>  free_shrinker_info(memcg);
>>>>>>>  return -ENOMEM;
>>>>>>> }
>>>>>> NAK. If in the future there going to one more error case after
>>>>>> rcu_assign_pointer() we will end up with double free.
>>>>>> This should be safer:
>>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>>> index dc5d2a6fcfc4..763fd556bc7d 100644
>>>>>> --- a/mm/shrinker.c
>>>>>> +++ b/mm/shrinker.c
>>>>>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>>  if (!info)
>>>>>>  goto err;
>>>>>>  info->map_nr_max = shrinker_nr_max;
>>>>>> - if (shrinker_unit_alloc(info, NULL, nid))
>>>>>> + if (shrinker_unit_alloc(info, NULL, nid)) {
>>>>>> + kvfree(info);
>>>>>>  goto err;
>>>>>> + }
>>>>>>  rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>>>>  }
>>>>>>  mutex_unlock(&shrinker_mutex);
>>>>> Agreed, this is what I mentioned earlier as well.
>>>>> ------------------------------------------------------------------
>>>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>>>> fails but before calling into "goto err"
>>>>> ------------------------------------------------------------------
>>>> After discussion, it seems that v1 is acceptable.
>>>> Hi, Muchun, do you have any other opinions?
>>> 
>>> I insist on my opinion, not mixing two different approaches
>>> to do release resources.
>> 
>> So instead we mix the cleanup of the whole function with the cleanup of what
>> is effectively a per-iteration temporary variable?
>> 
>> The fact there was already a confusion in this thread about whether it's
>> safe and relies on kvfree(NULL) to be a no-op, should be a hint.
> 
> Yes. I think someone is confused about my opinion.
> I don’t care about whether we should apply this hit.
> If we think the hint is tricky, we could add another
> label to fix it like I suggested previously. Because
> we already use goto-based approaches to
> cleanup the resources, why not keeping
> consistent?

I think we're rather pragmatic than striving to be consistent for the sake
of consistency. goto is not the nicest thing in the world, but we (unlike
other projects) use it where it makes sense to avoid if/else nesting
explosion. Here for the info it's not the most pragmatic option.

> It will be easier for us to add a new
> "if" statement and handle the failure case in the future.

Let's not overengineer things for hypothetical future.

> For example, if we use his v1 proposal, we should do
> the cleanups again for info. But for goto-based
> version, we just add another label to do the
> cleanups and go to the new label for failure case. goto-based fix is what I insisted on. I copied my previous suggested fix here to clarify my opinion.

Again, info is a loop-iteration-local variable, v1 fix making it truly local
is the way to go. If there are further cleanups added in the loop itself in
the future, they could hopefully keep being local to the loop as well.
Cleanup of info outside the loop iteration is breaking its real scope.

> 
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>                       goto err;
>               info->map_nr_max = shrinker_nr_max;
>               if (shrinker_unit_alloc(info, NULL, nid))
> -                       goto err;
> +                       goto free;
>               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>       }
>       mutex_unlock(&shrinker_mutex);
> 
>       return ret;
> -
> +free:
> +       kvfree(info);
> err:
>       mutex_unlock(&shrinker_mutex);
>       free_shrinker_info(memcg);
> 
> Muchun,
> Thanks.
> 
>> 
>> So no, I a gree with Kirill and others. Ideally the fix would also move the
>> declaration of info into the for loop to make its scope more obvious.
>> 
>>> Thanks.
>>> 
>>>> Best regards,
>>>> Ridong



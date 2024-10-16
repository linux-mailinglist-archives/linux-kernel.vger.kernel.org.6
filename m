Return-Path: <linux-kernel+bounces-367936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F6C9A0898
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871E01C22F28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8137206979;
	Wed, 16 Oct 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RojoMyQi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="shRhXQK/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RojoMyQi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="shRhXQK/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA915C147
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079015; cv=none; b=lgibhj8HbC3gwny8IUq39RKjjKhimPyGQRSwc5gxEb1PHKnxY7fV2pfG++MZTNYVXnA5XIo5UKJ/kV2MU/hFZi4xxP/omVA6p5jHFlYMOkGu48X+Lk3xdz6zl3nNOVguuDRld2AF+UixvcG7HkQInZ0yqOyewV1UrGXBEhgtWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079015; c=relaxed/simple;
	bh=Z9572QtoiwDVcCEYwGsA3lKugACXFq/29hfzhjPpVbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Av5y8xoKiFyRmOtNZulZlnrzgMPY4KvPdL5+4/VLZSj0R1+hRO+cmwQKWrqY13jrZti2e3iKnNVB0QvYvGjUADT+oKCpp3a0huv6r6qv68ZwGbKSdfGajOGG9sddGshhAn8+h92DbV0piWrWe4mKWK1U8E3cLWqSMpL9GUfcXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RojoMyQi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=shRhXQK/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RojoMyQi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=shRhXQK/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EA5E21DCF;
	Wed, 16 Oct 2024 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729079011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3CfdPYkhCLzx0ji2WFxvD1fuKUNA+OHA1fpR9DcWvc=;
	b=RojoMyQi3/fVOIxvM9D9uxs8noyj/p7XAM50bHjih9IYyYEz6CY5q6YVPqFFbdmpFjZ9R2
	j5GJF4tFIIQq7Pq+1CJjW2QijIniSc7SCr5kSWC9G/21KOoSq7Jn0yfuHsRwtG/bfXq4h2
	o2xQ1/Irx9ra6tU3yx1te+2/BIHL7HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729079011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3CfdPYkhCLzx0ji2WFxvD1fuKUNA+OHA1fpR9DcWvc=;
	b=shRhXQK/VBtPXB3wggtARJWOt7kyLgnU9+wYN+yd7yFRW0x1oLCcAMoMJ3fRWadQLBMjm2
	xDenq09ZE4j7y6Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729079011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3CfdPYkhCLzx0ji2WFxvD1fuKUNA+OHA1fpR9DcWvc=;
	b=RojoMyQi3/fVOIxvM9D9uxs8noyj/p7XAM50bHjih9IYyYEz6CY5q6YVPqFFbdmpFjZ9R2
	j5GJF4tFIIQq7Pq+1CJjW2QijIniSc7SCr5kSWC9G/21KOoSq7Jn0yfuHsRwtG/bfXq4h2
	o2xQ1/Irx9ra6tU3yx1te+2/BIHL7HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729079011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3CfdPYkhCLzx0ji2WFxvD1fuKUNA+OHA1fpR9DcWvc=;
	b=shRhXQK/VBtPXB3wggtARJWOt7kyLgnU9+wYN+yd7yFRW0x1oLCcAMoMJ3fRWadQLBMjm2
	xDenq09ZE4j7y6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12F4F1376C;
	Wed, 16 Oct 2024 11:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cj1JBOOmD2d3ZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Oct 2024 11:43:31 +0000
Message-ID: <fff87be9-fdc8-4c27-8335-17b0c7e16413@suse.cz>
Date: Wed, 16 Oct 2024 13:43:30 +0200
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
 "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <20241014032336.482088-1-chenridong@huaweicloud.com>
 <m3cjozicivz4ydv6ovzkupuzpcvc7uptlhjd3bndpsak3z7ill@6txhj7tpejir>
 <cbf8475d-5c79-4fa4-b2a1-f553166b0afd@arm.com>
 <4a18e997-3a94-4248-8923-c3764d12b0d6@huawei.com>
 <FD2AA126-5885-41C7-ACFD-85C764170B9E@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <FD2AA126-5885-41C7-ACFD-85C764170B9E@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/16/24 04:21, Muchun Song wrote:
> 
> 
>> On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
>> 
>> 
>> 
>> On 2024/10/15 14:55, Anshuman Khandual wrote:
>>> On 10/14/24 16:59, Kirill A. Shutemov wrote:
>>>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>> 
>>>>> A memleak was found as bellow:
>>>>> 
>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>>   comm "mkdir", pid 1559, jiffies 4294932666
>>>>>   hex dump (first 32 bytes):
>>>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>>>   backtrace (crc 2e7ef6fa):
>>>>>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>>     [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>> 
>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>>>> err, the info won't be freed. Just fix it.
>>>>> 
>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>> ---
>>>>>  mm/shrinker.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>> 
>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>>> --- a/mm/shrinker.c
>>>>> +++ b/mm/shrinker.c
>>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>    err:
>>>>>   mutex_unlock(&shrinker_mutex);
>>>>> + kvfree(info);
>>>>>   free_shrinker_info(memcg);
>>>>>   return -ENOMEM;
>>>>>  }
>>>> 
>>>> NAK. If in the future there going to one more error case after
>>>> rcu_assign_pointer() we will end up with double free.
>>>> 
>>>> This should be safer:
>>>> 
>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>> index dc5d2a6fcfc4..763fd556bc7d 100644
>>>> --- a/mm/shrinker.c
>>>> +++ b/mm/shrinker.c
>>>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>   if (!info)
>>>>   goto err;
>>>>   info->map_nr_max = shrinker_nr_max;
>>>> - if (shrinker_unit_alloc(info, NULL, nid))
>>>> + if (shrinker_unit_alloc(info, NULL, nid)) {
>>>> + kvfree(info);
>>>>   goto err;
>>>> + }
>>>>   rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>>   }
>>>>   mutex_unlock(&shrinker_mutex);
>>> Agreed, this is what I mentioned earlier as well.
>>> ------------------------------------------------------------------
>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>> fails but before calling into "goto err"
>>> ------------------------------------------------------------------
>> 
>> After discussion, it seems that v1 is acceptable.
>> Hi, Muchun, do you have any other opinions?
> 
> I insist on my opinion, not mixing two different approaches
> to do release resources.

So instead we mix the cleanup of the whole function with the cleanup of what
is effectively a per-iteration temporary variable?

The fact there was already a confusion in this thread about whether it's
safe and relies on kvfree(NULL) to be a no-op, should be a hint.

So no, I a gree with Kirill and others. Ideally the fix would also move the
declaration of info into the for loop to make its scope more obvious.

> Thanks.
> 
>> 
>> Best regards,
>> Ridong
> 
> 



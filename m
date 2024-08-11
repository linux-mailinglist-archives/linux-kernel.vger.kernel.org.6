Return-Path: <linux-kernel+bounces-282123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718294DFD1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDAE1F2151F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00DE57D;
	Sun, 11 Aug 2024 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAK6T5gr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D12F2A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723347193; cv=none; b=T4O8wBRHwiXJRrXtJO/bTvpgpo34hSSKevRInycopTsQliDu3sZRgJ2CxUechMjmaP4eAb+pf7F7k0ZC0tB64oVo3KflsiNZmXmaM7W864qJ/T7b5H+IodTI6lVOcdN2EMC7cX2bTwb05zrKV0RRIPJGqBtYwrw/stuQrvQQr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723347193; c=relaxed/simple;
	bh=RXSGsS5nRAU3Mxx6h5fdvjzbqyKm0z85Q4yvcUy6f1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKP1eOtjUBDTD/73+zBVbdU73vlHfVDPD60KHaqKh7bsVnd0aHwjY+g2osPgdzuNmoSWSGv4/YYBiNR8Qe94Y5E41ZRqlWWa/DNXqdW2+XguFA71oQe6Le/6a4p6GOW2yJwCBNGZHSzSZuaNUaSDIKiICbjHGvSPKEgypXaEALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAK6T5gr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723347190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWNClqGeRNafoYy78wwBYXSlMYcDTGBQ8Qtwon24Sxs=;
	b=UAK6T5grZpn3XbWa8L8jjY7YCPYNHp6kiyeyt7Ca0gfZ8eKiLrTRd9PeZCS+WBnfLZm03P
	RoeI9iosogYWX7X/BcL0dIE812ewl2t23uqRSSZINfsfgbWNAHnv+AjFwUillwSrzVLW1f
	n/CWFiB8j7qUuSvuq34oBqXoBmlOWYM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-uy0K6KpzOrmGiyWptNtyeg-1; Sat,
 10 Aug 2024 23:33:08 -0400
X-MC-Unique: uy0K6KpzOrmGiyWptNtyeg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A028A1955F43;
	Sun, 11 Aug 2024 03:33:06 +0000 (UTC)
Received: from [10.2.16.6] (unknown [10.2.16.6])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0226A19560A3;
	Sun, 11 Aug 2024 03:33:04 +0000 (UTC)
Message-ID: <70e28278-d9cf-4158-b296-cabe7786e4a7@redhat.com>
Date: Sat, 10 Aug 2024 23:33:03 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] padata: Fix possible divide-by-0 panic in
 padata_mt_helper()
To: Kamlesh Gurudasani <kamlesh@ti.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806174647.1050398-1-longman@redhat.com>
 <87jzgonug5.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87jzgonug5.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 8/10/24 13:44, Kamlesh Gurudasani wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> We are hit with a not easily reproducible divide-by-0 panic in padata.c
>> at bootup time.
>>
>>    [   10.017908] Oops: divide error: 0000 1 PREEMPT SMP NOPTI
>>    [   10.017908] CPU: 26 PID: 2627 Comm: kworker/u1666:1 Not tainted 6.10.0-15.el10.x86_64 #1
>>    [   10.017908] Hardware name: Lenovo ThinkSystem SR950 [7X12CTO1WW]/[7X12CTO1WW], BIOS [PSE140J-2.30] 07/20/2021
>>    [   10.017908] Workqueue: events_unbound padata_mt_helper
>>    [   10.017908] RIP: 0010:padata_mt_helper+0x39/0xb0
>>      :
>>    [   10.017963] Call Trace:
>>    [   10.017968]  <TASK>
>>    [   10.018004]  ? padata_mt_helper+0x39/0xb0
>>    [   10.018084]  process_one_work+0x174/0x330
>>    [   10.018093]  worker_thread+0x266/0x3a0
>>    [   10.018111]  kthread+0xcf/0x100
>>    [   10.018124]  ret_from_fork+0x31/0x50
>>    [   10.018138]  ret_from_fork_asm+0x1a/0x30
>>    [   10.018147]  </TASK>
>>
>> Looking at the padata_mt_helper() function, the only way a divide-by-0
>> panic can happen is when ps->chunk_size is 0. The way that chunk_size is
>> initialized in padata_do_multithreaded(), chunk_size can be 0 when the
>> min_chunk in the passed-in padata_mt_job structure is 0.
>>
>> Fix this divide-by-0 panic by making sure that chunk_size will be at
>> least 1 no matter what the input parameters are.
>>
>> Fixes: 004ed42638f4 ("padata: add basic support for multithreaded jobs")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/padata.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/padata.c b/kernel/padata.c
>> index 53f4bc912712..0fa6c2895460 100644
>> --- a/kernel/padata.c
>> +++ b/kernel/padata.c
>> @@ -517,6 +517,13 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>>   	ps.chunk_size = max(ps.chunk_size, job->min_chunk);
>>   	ps.chunk_size = roundup(ps.chunk_size, job->align);
>>   
>> +	/*
>> +	 * chunk_size can be 0 if the caller sets min_chunk to 0. So force it
>> +	 * to at least 1 to prevent divide-by-0 panic in padata_mt_helper().`
>> +	 */
> Thanks for the patch and detailed comment.
>> +	if (!ps.chunk_size)
>> +		ps.chunk_size = 1U;
>> +
> could it be
>          ps.chunk_size = max(ps.chunk_size, 1U);
>          
> or can be merged with earlier max()
>    	ps.chunk_size = max(ps.chunk_size, max(job->min_chunk, 1U));
>    	ps.chunk_size = roundup(ps.chunk_size, job->align);
>
> sits well with how entire file is written and compiler is optimizing
> them to same level.

I had actually thought about doing that as an alternative. I used the 
current patch to avoid putting too many max() calls there. I can go this 
route if you guys prefer this.

Cheers,
Longman



Return-Path: <linux-kernel+bounces-266203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C2193FC60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737D11F228F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A515F3EA;
	Mon, 29 Jul 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw4u57GD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E65028C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273755; cv=none; b=KVG1A7knqXtmFMpjAjdhJLvWvROSNpPbvf+NXJfGdCPUO+4uMYyhrqCXg3JcY4xSlXrsUJmf5i9OOR7jfteAgM2n6a3CDBny0+X3zQdx1lA/nx2spooKjfYqyM1LorM2z7/aIfo4XfhMgICXvGDsn7aeD53b7TC7DZ6DAX/wQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273755; c=relaxed/simple;
	bh=H3jZuJ7l26FGD1L3Ta4V9xw48SpcuXJsWmaSUmljt+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPFZVpDVA8Ei/9B+D+Oqs/j+OGU4ZVrAktxbAPakQxjdrj5KVUCtVVAAlQiCu5dTdXpvDsDrJALtywVvGLqpR7TxMcsyURgTfxNQ5PNIBfp2BlFaVD6qtzL71y/Lll8/mzbgUeZw9Wse+G0hGavRYqc9Ck5ftrbmyQCt6YrXcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw4u57GD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722273752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVMN9GtOLgXku8n83Z5zLiYjiZTYppqVPat7mUMDTgg=;
	b=Bw4u57GDjBNjmA0va2dT4jRqkLLN+rpuDIlfbDNMj3u/Ri23oiedjpqTtQ4y9IstCdIS2B
	vncQ2Hhf6HB1kln+HGDf2h/SH0QvWjGQqPnXnMOhNxCdi9WaY7OPsjMt//MABARgyfGmSl
	1tXUUgZa3myPtEvnrffiZaOHRZggDZo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-2eooKGJRNoKMmCzYdgzCcQ-1; Mon,
 29 Jul 2024 13:22:29 -0400
X-MC-Unique: 2eooKGJRNoKMmCzYdgzCcQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4E401955D4F;
	Mon, 29 Jul 2024 17:22:27 +0000 (UTC)
Received: from [10.2.16.113] (unknown [10.2.16.113])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FD3119560B2;
	Mon, 29 Jul 2024 17:22:26 +0000 (UTC)
Message-ID: <706a4fd7-e0b0-4ada-b269-04978b0a5265@redhat.com>
Date: Mon, 29 Jul 2024 13:22:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: suggest the fix for "lockdep bfs error:-1" on
 print_bfs_bug
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <ZqKdZZp7TI69DWRE@uudg.org> <ZqQUDI3Ai9GP9hUO@boqun-archlinux>
 <ZqfJDTn9rCQ1eVnz@uudg.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZqfJDTn9rCQ1eVnz@uudg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 7/29/24 12:53, Luis Claudio R. Goncalves wrote:
> On Fri, Jul 26, 2024 at 02:24:28PM -0700, Boqun Feng wrote:
>> On Thu, Jul 25, 2024 at 03:45:57PM -0300, Luis Claudio R. Goncalves wrote:
>>> When lockdep fails while performing the Breadth-first-search operation
>>> due to lack of memory, hint that increasing the value of the configuration
>>> switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.
>>>
>>> Preface the scary bactrace with the suggestion:
>>>
>>>      [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:
>>>      [  163.849248] ------------[ cut here ]------------
>>>      [  163.849250] lockdep bfs error:-1
>>>      [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c:2091 print_bfs_bug+0x27/0x40
>>>      ...
>>>
>>> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
>>> ---
>>>   kernel/locking/lockdep.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index 58c88220a478a..1cf6d9fdddc9c 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -2067,6 +2067,9 @@ static noinline void print_bfs_bug(int ret)
>>>   	/*
>>>   	 * Breadth-first-search failed, graph got corrupted?
>>>   	 */
>>> +	if (ret  == BFS_EQUEUEFULL)
>> This line has an extra space after "ret", but otherwise it looks fine.
> Should I send a v2 of the patch with the extra whitespace removed?
>
> Luis

Yes, you should. Other than the extra space, the patch looks good to me too.

Reviewed-by: Waiman Long <longman@redhat.com>

You can also add our review-by tags in your v2 patch.

Cheers,
Longman

>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>
>> Regards,
>> Boqun
>>
>>> +		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n");
>>> +
>>>   	WARN(1, "lockdep bfs error:%d\n", ret);
>>>   }
>>>   
>>> -- 
>>> 2.45.2
>>>
> ---end quoted text---
>



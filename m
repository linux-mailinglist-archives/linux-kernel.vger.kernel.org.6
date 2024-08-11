Return-Path: <linux-kernel+bounces-282119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E994DFC9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6018E1F216B5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 03:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6052EAD5;
	Sun, 11 Aug 2024 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoVVKHbt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A166C8D1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723345880; cv=none; b=MxnvZ04HU2U84a0ZVxQ+hdNLnhT62gP2JcN/H2/zzXnbPIpwaZg07VJeGhyD+V5XOozJnmf3Xh5/7rL7RFL/fSLZDhBKmoU8MTA+WhY8UApWk+Jo44GJVm49qcb9l+PSCvkeeWviPSlro8Q0MkrRWt0x/GOohzmJa2CtGVdBozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723345880; c=relaxed/simple;
	bh=/G2X0KVHKCb2F1W5MziUJ4mQFUVjpdxrMDCq9SveJcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0gG1hFmFlR+LE9v23URnOWTAKvKPya+bkUavqAUaDW7rWrHQ5QOPN96Y8lOMNQp6Npx25pEzzZ7G181khILW5qMQxRJNq+bPqxg8nbnd85XZr3/4L4xCcjWldEuTe0b4cR35eQ1aUIDosOG5oFvdxSVnkH5a0mcx07ZYspJ6vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoVVKHbt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723345878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBsmRUYN3Kblrpj2OxJHU6UiLbl9J52YuHCBfW+hIZ0=;
	b=FoVVKHbtF90zeTdy7mPol6Cywe9gQEIH9sA/18S4KzyU8jUM2ig0lgNvAwlgdiZ+qgVPh5
	lXFsRyVRKFktuENxSvOwAIShYbAEPrhloE6M8AT+zUlWhS1ZYkv5EeCrdEUoqlB68RH84V
	a/pmj+m+DPuyvU70nDZX/mOGKicLqUg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-2yCTxcNZPUGeu7DMYC_pJw-1; Sat,
 10 Aug 2024 23:11:12 -0400
X-MC-Unique: 2yCTxcNZPUGeu7DMYC_pJw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1AA11956080;
	Sun, 11 Aug 2024 03:11:10 +0000 (UTC)
Received: from [10.2.16.6] (unknown [10.2.16.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE7011955F22;
	Sun, 11 Aug 2024 03:11:08 +0000 (UTC)
Message-ID: <91d29649-ca88-4f6c-bf1d-19e49c9555df@redhat.com>
Date: Sat, 10 Aug 2024 23:11:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] padata: Fix possible divide-by-0 panic in
 padata_mt_helper()
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
 akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Zrbm--AxRXgfHUek@gondor.apana.org.au>
 <e752f094-adb4-4448-8bc8-e2460330eaec@redhat.com>
 <ZrgXtLI1R5zJ9GFG@gondor.apana.org.au>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZrgXtLI1R5zJ9GFG@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 8/10/24 21:45, Herbert Xu wrote:
> On Sat, Aug 10, 2024 at 09:30:25PM -0400, Waiman Long wrote:
>> On 8/10/24 00:05, Herbert Xu wrote:
>>> Waiman Long <longman@redhat.com> wrote:
>>>> diff --git a/kernel/padata.c b/kernel/padata.c
>>>> index 53f4bc912712..0fa6c2895460 100644
>>>> --- a/kernel/padata.c
>>>> +++ b/kernel/padata.c
>>>> @@ -517,6 +517,13 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>>>>          ps.chunk_size = max(ps.chunk_size, job->min_chunk);
>>>>          ps.chunk_size = roundup(ps.chunk_size, job->align);
>>>>
>>>> +       /*
>>>> +        * chunk_size can be 0 if the caller sets min_chunk to 0. So force it
>>>> +        * to at least 1 to prevent divide-by-0 panic in padata_mt_helper().`
>>>> +        */
>>>> +       if (!ps.chunk_size)
>>>> +               ps.chunk_size = 1U;
>>> Perhaps change the first ps.chunk_size assignment to use DIV_ROUND_UP
>>> instead?
>> I think DIV_ROUND_UP() will exactly the same problem that if chunk_size is
>> 0, you still got a 0 result. round_up() only if the 2nd argument is a power
>> of 2 while with DIV_ROUND_UP(), the second argument can be any number except
>> 0.
> Unless I'm missing something chunk_size cannot be zero before the
> division because that's the first thing we check upon entry into
> this function.

chunk_size is initialized as

ps.chunk_size = job->size / (ps.nworks * load_balance_factor);

chunk_size will be 0 if job->size < (ps.nworks * load_balance_factor). 
If min_chunk is 0, chunk_size will remain 0.

After looking at the dump file when the crash happen at 
padata_mt_helper(). I had determined that ps->chunk_size was indeed 0 
which caused the divide-by-0 panic. I actually got 2 different bug 
reports of this div-by-0 panic, one with a debug and another one with a 
non-debug kernel.

Cheers,
Longman




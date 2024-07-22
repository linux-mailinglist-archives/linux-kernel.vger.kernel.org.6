Return-Path: <linux-kernel+bounces-258691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3B938BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FE21F216E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C2166313;
	Mon, 22 Jul 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oAVcmYyQ"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F5523A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639211; cv=none; b=Zks8VjxtlxK/KZcbuhvnLkMLCXTvx2ws5soy3y+kuHEMa4IqTm2ZXXeztkcp3pLnHYPuIGspNQ3ZUwCPq2lQeTxG3ux4J1kdjg9K7c28bPLVUEn9fbbLRPeiTSRPrTAZlTZoJoZdDV1BejX2z9Burp1ROwcFz57vI+e8akHyOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639211; c=relaxed/simple;
	bh=6G5bMEzcbSZGUf0rxwJ716RLr0ED+C9ZduoP4oB+Lhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsJoXmFzBIFR7oQXC6tKDYVVNIO/FY/1fyyNnVsAcKmySIamHa1iWnzCiiNaTmk5cZr8meRRyYn58NHMDWwDvxOhDGnykymnmjvZmt3ky8Yv+ibE5HcbAug1kPMMP+0iSbD2vrxr7tOeVixQqd3C3flG7XkiIBgYu0Aa0BMr3oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=oAVcmYyQ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 40A5814C1E1;
	Mon, 22 Jul 2024 11:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721639204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b6ji23ojz05eF35yF+0f6k4PXpmGZQOUUr56sBX+JZA=;
	b=oAVcmYyQz8QTmTKTqXsS/pE8opvM+SpO7+vYnhWKKOFM31vU54i32Lz1iqsvNQcRXnWlQY
	zNQ2ldChWOMAoCdHpqNs9tbpoAnvAQFK0qe4tO/T72C1JxG/uCZ7T6ntke5pFoojpkFZHt
	lGaxbjMfl5C6G0xR4faXqHjmjKNQ6siQ/3IEtzbHwUP5j/CiggK+sBP1ztJ3ZxsGmMb7ox
	YTcV8/2+B/zXJx0TgFrxtQhUwF7nNFJkxbUInxu4+WOAYmJRb2LvwtalUFWk0L7JqYA2Wn
	DKWFi7AWsX5Njcii+Ue+aEtrPmEhpTG38XTCPaXpHOF4sXs0kYa3/+ovUtm5tw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 05485a21;
	Mon, 22 Jul 2024 09:06:40 +0000 (UTC)
Date: Mon, 22 Jul 2024 18:06:25 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH] net/9p: Fix uaf / refcnt underflow for req object in
 virtio
Message-ID: <Zp4hEX0Mlyu6p5a4@codewreck.org>
References: <20240709162904.226952-1-void@manifault.com>
 <Zp4DSeHdOU0U1PZC@codewreck.org>
 <2328041.KKODgcftPW@silver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2328041.KKODgcftPW@silver>

Christian Schoenebeck wrote on Mon, Jul 22, 2024 at 10:03:11AM +0200:
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 5cd94721d974..51ce3bd4aece 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -616,9 +616,10 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
>>         if (READ_ONCE(oldreq->status) == REQ_STATUS_SENT) {
>>                 if (c->trans_mod->cancelled)
>>                         c->trans_mod->cancelled(c, oldreq);
>> +               /* reply won't come anymore, drop the "receive" ref */
>> +               p9_req_put(client, req);

That was meant to be oldreq, not req (factoring out the dropping ref
part out of the callback)

>>         }
>> 
>> -       p9_req_put(c, req);

That one is a different req that needs to be dropped alright; this
should stay.

(note to self: don't try to think about 9p refcounting during lunch
break)

>>         return 0;
>>  }
>
> [...]
>
> So a Tflush request by client is immediately answered by a Rflush response and 
> in this case no answer is sent to the original request being flushed.
> 
> There are also QEMU test cases guarding the expected Tflush behaviour:
> https://github.com/qemu/qemu/blob/a7ddb48b/tests/qtest/virtio-9p-test.c#L403
> and
> https://github.com/qemu/qemu/blob/a7ddb48b/tests/qtest/virtio-9p-test.c#L444
> 
> The 2nd test case handles the behaviour when the Tflush request arrived too 
> late, after the original request already completed successfully that is. So in 
> this case client first receives a success response to the original request, 
> then followed by Rflush response.

Oh, I was convinced the flush was just queued after the original
response to follow the spec, but that there was no mechanism to cancel
the IO in flight so the 'cancelled' path was never exerced.

If you're doing cancels (not sending the original response if the flush
timing was early enough), then the third drop actually probably was that
callback:
 - one for the error code in p9_virtio_zc_request
 - one for cancelled
 - one at the end of p9_client_zc_rpc

I agree p9_virtio_zc_request shouldn't drop the ref if we're going to
cancel it, so dropping that put makes sense.
We should actually also just drop that put altogether and make the code
closer to what we do in p9_client_rpc (non-zc version) where we put the
ref on error immediately after ->request(), because that code knows
about the ERESTARTSYS logic, and it's not something each transport
should have to worry about.

(At which point we can also drop the ref in ERESTARTSYS for the flush
request itself then as pointed out..)

So I'll update the patch to drop p9_req_put() altogether from
p9_virtio_zc_request and call it in p9_client_zc_rpc() more
appropriately, and send the cancelled thing as follow up instead.

Hopefully didn't get it wrong too much this time, tests will tell...
-- 
Dominique Martinet | Asmadeus


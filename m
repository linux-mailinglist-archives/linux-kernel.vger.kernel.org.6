Return-Path: <linux-kernel+bounces-205525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B58FFD12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E666D1F21265
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4815382A;
	Fri,  7 Jun 2024 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UOM50Iwh"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B72DDD9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745264; cv=none; b=Jbxs5SpJUopotgB9n/AOFqrG1n80ogu1x0u7WAkEL04+CeA618dShTY8Qp9x8+dtIHKQ/kQBcPZk1FrHoaBVvL/TA/7ENxzf0ex1e/fNyTOvBzTh33tPOvt1GbnGZka6LiMIPXchE3hD1KtrmYSXCHeCIUbdYgh9SP+R6PA+9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745264; c=relaxed/simple;
	bh=qzMe1iYAod/bcIq4XiyzKdjBhHpWZ1NslnzI6+M46Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n51drBWVPtAnAXTNYla7qzCq8Xxf43GY03VNH4v39ZxmUNbGtJOxfBfk/fFadv54kGbW9UwLrqdVoX99/UYY/25gqwxBO5AiQe7gbH1uDe/YlELdHvc+d+AR+GKea+7kfj+EGX0uJBJeOPRNUF0YJp7xjblux2dlA6Ilg04urrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UOM50Iwh; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717745259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmIHSLn/WvaJPUCX1Y8vqiV6qDdzhglScQrwFE+kVPs=;
	b=UOM50Iwh2l1RuKUYUI3XZ8BTN4lzNFetHtCLig3C2tmvfdz/GJoBR+YE+bt1ThDI/irx2P
	9sMcu9AaZA4y5SP7GoBS//xnF5LpiiESOog8FLdGWoa1RCqQ4BXI0gTdn21oxq4293Rel/
	ty9UTtboEF7wLJDFHmzhMIei3FlPvmo=
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <96f13b3c-ec74-4f87-be37-fbf796fe51eb@linux.dev>
Date: Fri, 7 Jun 2024 15:26:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] slab: make check_object() more consistent
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
 <20240605-b4-slab-debug-v2-1-c535b9cd361c@linux.dev>
 <ef24c2be-d6bb-49ec-a72f-7228f284e524@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ef24c2be-d6bb-49ec-a72f-7228f284e524@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/6 16:28, Vlastimil Babka wrote:
> On 6/5/24 9:13 AM, Chengming Zhou wrote:
>> Now check_object() calls check_bytes_and_report() multiple times to
>> check every section of the object it cares about, like left and right
>> redzones, object poison, paddings poison and freepointer. It will
>> abort the checking process and return 0 once it finds an error.
>>
[...]
>> -	/* Check free pointer validity */
>> -	if (!check_valid_pointer(s, slab, get_freepointer(s, p))) {
>> +	/*
>> +	 * Cannot check freepointer while object is allocated if
>> +	 * object and freepointer overlap.
>> +	 */
>> +	if (!freeptr_outside_object(s) && val == SLUB_RED_ACTIVE &&
> 
> Seems this condition should have been logically flipped?

Ah, right, will fix.

> 
>> +	    !check_valid_pointer(s, slab, get_freepointer(s, p))) {
>>  		object_err(s, slab, p, "Freepointer corrupt");
>>  		/*
>>  		 * No choice but to zap it and thus lose the remainder
>> @@ -1370,9 +1368,14 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>>  		 * another error because the object count is now wrong.
>>  		 */
>>  		set_freepointer(s, p, NULL);
>> -		return 0;
> 
> Should set ret = 0 here?

Yes.

> 
>>  	}
>> -	return 1;
>> +
>> +	if (!ret && !slab_add_kunit_errors()) {
> 
> Also 5/6 of slub_kunit tests now fail as we increased the number of recorded

My bad, I didn't test with slub_kunit, will test later.

> errors vs expected. Either the slab_add_kunit_errors() test above should
> have a variant (parameter?) so it will only detect we are in slab-kunit test
> (to suppress the printing and taint) but doesn't increase slab_errors (we

I think this way is simpler for me, only suppress the printing but doesn't
increase slab_errors, will take this way and test again.

Thanks!

> increased them for the individual issues already), or simply raise the
> expectations of the tests so it matches the new implementation.
> 



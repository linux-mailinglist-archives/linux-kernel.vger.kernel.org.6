Return-Path: <linux-kernel+bounces-203630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED38FDE65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD911C22950
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B695147A53;
	Thu,  6 Jun 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iwKwqsfj"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD145BE3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653383; cv=none; b=Wan04Nr2yXHMarp1yyScq/IjaVdD2NU5RRJk+DYArkatcvwmwnKU9uLnTL63TGhhlJe0Aqxijn5T2MSCMmDsEeVse/vd375p4Nn83DKU6HpU0m0nLtFhnkacMV63zc38dqraRB8NXSzKAtmRCAZopV1IBPNpJ73oyqXbk79BNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653383; c=relaxed/simple;
	bh=Rn6MIgAHXThpOou1fRNGm5w62PA8fwoF6VJ/NPzgQgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsvZjO6WPzVYUNu2f+JakQfTJttegN4AYTfXanvEBKrbq79Pqjmgu8I2QfPjalIy1Dg0IRKiiomvwK5zvan3EQBGt0CaJzCyzJYpeyQpk14qnAXwaAtUTCAUYOQNFc32kbX+nd7550zehbDcbtnFKyZimn8NUdt/p4l3GICAXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iwKwqsfj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717653378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8Z5XmpUE3zx1Y8cy7cbU/CoYCfPRTM2B2i5o3MFz18=;
	b=iwKwqsfjoGXVgQe/po1O8i4bOhN+NhoK5vwBxCPBRqhvuJO6LC62WtY9E5l6kKozckGXAN
	ENQD0kw1r5cy9frpP4esDYHVVJkYEgPMeRbsQqoP8S+NpNI4S+mRQgCBad5qPF4uRF7Akg
	A+vmKupx/CjWu2gH98ucZkabpnMTcQs=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: erhard_f@mailbox.org
X-Envelope-To: yuzhao@google.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: minchan@kernel.org
X-Envelope-To: vbabka@kernel.org
Message-ID: <f92e6d70-32e3-4f45-8fe8-0b7af7a14bc6@linux.dev>
Date: Thu, 6 Jun 2024 13:55:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Erhard Furtner
 <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Minchan Kim <minchan@kernel.org>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
References: <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea>
 <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
 <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev>
 <20240606043156.GC11718@google.com>
 <6335c05d-9493-4b03-85a7-f2dd91db9451@linux.dev>
 <20240606054334.GD11718@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240606054334.GD11718@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/6 13:43, Sergey Senozhatsky wrote:
> On (24/06/06 12:46), Chengming Zhou wrote:
>>>> Agree, I think we should try to improve locking scalability of zsmalloc.
>>>> I have some thoughts to share, no code or test data yet:
>>>>
>>>> 1. First, we can change the pool global lock to per-class lock, which
>>>>    is more fine-grained.
>>>
>>> Commit c0547d0b6a4b6 "zsmalloc: consolidate zs_pool's migrate_lock
>>> and size_class's locks" [1] claimed no significant difference
>>> between class->lock and pool->lock.
>>
>> Ok, I haven't looked into the history much, that seems preparation of trying
>> to introduce reclaim in the zsmalloc? Not sure. But now with the reclaim code
>> in zsmalloc has gone, should we change back to the per-class lock? Which is
> 
> Well, the point that commit made was that Nhat (and Johannes?) were
> unable to detect any impact of pool->lock on a variety of cases.  So
> we went on with code simplification.

Right, the code is simpler.

> 
>> obviously more fine-grained than the pool lock. Actually, I have just done it,
>> will test to get some data later.
> 
> Thanks, we'll need data on this.  I'm happy to take the patch, but
> jumping back and forth between class->lock and pool->lock merely
> "for obvious reasons" is not what I'm extremely excited about.

Yeah, agree, we need test data.


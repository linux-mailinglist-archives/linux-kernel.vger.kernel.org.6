Return-Path: <linux-kernel+bounces-204742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951068FF303
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB731C2037E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25AE198A3E;
	Thu,  6 Jun 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSQS1HFl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8669224D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692823; cv=none; b=WWs7tdaykU/ObKSfo4XMJZvHarHpHw44hlKdwseTi7VZsyDhSSRQZBzDZHEv+5L8NJEex9+nQDrU0Gs1CtYP7Q1qV7aSbAD6V8xkGOAPl7aETUwJK5+ei4zzJDQEYIdA90jRT8rZK201uEEwwSQxI3y94mwiKZCG7N22893odS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692823; c=relaxed/simple;
	bh=UfPRa8N1NpQXy0hUsyfCoV9/IzKPawQ3WxpkEv4gwoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXUouGT4gJDWE2ZwXkVBNZQ+jYNEU/1DNBZlo3FMsS4zw4IMwsj/lrKiF5fj0h6AJQJvwGnF6+cli/yi0AanUIO6I2izqN4iu+m2K84hXiK/9Qo/HopLcjZ/vIcBHLlZCVafNguIuxos/1dUXV5emEjti9WweVIEMpsrg1yGVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSQS1HFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0919AC2BD10;
	Thu,  6 Jun 2024 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717692822;
	bh=UfPRa8N1NpQXy0hUsyfCoV9/IzKPawQ3WxpkEv4gwoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DSQS1HFlpBRZ83O1xKUSI5diJtuOlVYBr2LgczQEvleXWNd6HpjbexSOBzjkR5WbY
	 BSqiVya+7Z5Bxpd4p20MoH6QOAgx/Yz2qeT8KVm2+c702w87lV+lvfZKQtx/IHYQBm
	 9SXDanaV5WWdi9qzuEQcE+lIZWxbw3xOX44VoXmhi7nWvpqr+DTOSjMf7gkEHSIHGR
	 KTWPQ+OvIoPA48E78fLk923VjkKy2Oi09ajoH1Hs9dRIYbCMCpdyOhVxh7Bbkx9rWV
	 dcJHbFamIVno+gXC6hCG/CPK3BIgvvhxAsmR4o9jYW5ToB/sh5wGsfDcMSSReJG8FP
	 +54Rq6Ik/+LXg==
Message-ID: <e1b78d49-72ef-4c9e-be1c-919a72940b1b@kernel.org>
Date: Thu, 6 Jun 2024 18:53:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Content-Language: en-US
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@kernel.org>
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea>
 <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea>
 <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
 <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <fd7fafb9-09be-48b1-ba52-57e52c6d973a@kernel.org>
 <20240606153210.18ef5299@yea>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240606153210.18ef5299@yea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 3:32 PM, Erhard Furtner wrote:
> On Thu, 6 Jun 2024 09:24:56 +0200
> "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
>> Besides the zpool commit which might have just pushed the machine over the
>> edge, but it was probably close to it already. I've noticed a more general
>> problem that there are GFP_KERNEL allocations failing from kswapd. Those
>> could probably use be __GFP_NOMEMALLOC (or scoped variant, is there one?)
>> since it's the case of "allocating memory to free memory". Or use mempools
>> if the progress (success will lead to freeing memory) is really guaranteed.
>> 
>> Another interesting data point could be to see if traditional reclaim
>> behaves any better on this machine than MGLRU. I saw in the config:
>> 
>> CONFIG_LRU_GEN=y
>> CONFIG_LRU_GEN_ENABLED=y
>> 
>> So disabling at least the second one would revert to the traditional reclaim
>> and we could see if it handles such a constrained system better or not.
> 
> I set RANDOM_KMALLOC_CACHES=n and LRU_GEN_ENABLED=n but still hit the issue.
> 
> dmesg looks a bit different (unpatched v6.10-rc2).

What caught my eye, but it's also in some of the previous dmesg with MGRLU,
is that in one case there's:

DMA free:0kB

That means many allocations went through that are allowed to just ignore all
reserves, and depleted everything. That would mean __GFP_MEMALLOC or
PF_MEMALLOC, which I suggested earlier for the GFP_KERNEL failure, is being
used somewhere, but not leading to the expected memory freeing.

> Regards,
> Erhard



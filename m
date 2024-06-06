Return-Path: <linux-kernel+bounces-203727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166C8FDF83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C6D1C247D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE3F13AD1D;
	Thu,  6 Jun 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyz90bN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7B38DE0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658703; cv=none; b=GVwrNBMN+gkfA4wcSopoK7B8OcFIOC890OHOp3+dn7987nqcCGaYb2bIMX1RdnTq2j0QmPCCopAoMPd4o9fB4CB98WWioYL29v+tj1IzpZjEgd6qmSUMkDghg3xZmTkTNjdqRaOIxA7/Y+Thvi7ClUaJJnJhMyIXOXnbSv2f6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658703; c=relaxed/simple;
	bh=6ArXguUdE1tEHqkTMArHl/jywTYi8V4U84K1ePj0AoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkIdHAs8PoLd66bYbSZko2H3JaWeBc0LdWp+xeWr0Ya1S1wJ9uj07idJhM3cuXtWQHctEb6dhj3sipO/d5mUQ4nMLOYjn+xe1eOsHcX0nyXe5hFBjorCO+En5qpZ681rCrQHj2/PL1c9EMgt7cGOpUt7AbxCHGwbXre+rC+LXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyz90bN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15335C2BD10;
	Thu,  6 Jun 2024 07:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717658702;
	bh=6ArXguUdE1tEHqkTMArHl/jywTYi8V4U84K1ePj0AoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eyz90bN/icwoyAAxZFaUXkgseagaj2+gtayVvlpSEO85FPkYRqDSaed7AKTltqH1P
	 Gnx4K273UguPCqIpoIGhVPhu93b4OwT1dENhWnEBqJkGXXHCn+feY5bujIXE0dC8hZ
	 cutWHUYG3O/eEQ5TsOiWO/9/K3YBctwGgDMXp4SW3Pqow5dCGg8kGuu83Fm9lT5oQD
	 +diJGGWlE2oX9IPx1XfRecSCr1sJkDOR0x/ZvHdbaCD+8Bq1w1ozRjrpfSEaRBFpjq
	 4MMgKh9Ubu5JJt1tHLXFcVY0Gx3b0Y7aFuGCCuGK6Lp+STOdppusIoXuNTojDozxoL
	 5LYs9ZPnUKn2g==
Message-ID: <fd7fafb9-09be-48b1-ba52-57e52c6d973a@kernel.org>
Date: Thu, 6 Jun 2024 09:24:56 +0200
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
To: Yosry Ahmed <yosryahmed@google.com>, Erhard Furtner <erhard_f@mailbox.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
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
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/6/24 1:41 AM, Yosry Ahmed wrote:
> On Wed, Jun 5, 2024 at 4:04 PM Erhard Furtner <erhard_f@mailbox.org> wrote:
> 
> I am personally leaning toward (c), but I want to hear the opinions of
> other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?

Besides the zpool commit which might have just pushed the machine over the
edge, but it was probably close to it already. I've noticed a more general
problem that there are GFP_KERNEL allocations failing from kswapd. Those
could probably use be __GFP_NOMEMALLOC (or scoped variant, is there one?)
since it's the case of "allocating memory to free memory". Or use mempools
if the progress (success will lead to freeing memory) is really guaranteed.

Another interesting data point could be to see if traditional reclaim
behaves any better on this machine than MGLRU. I saw in the config:

CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y

So disabling at least the second one would revert to the traditional reclaim
and we could see if it handles such a constrained system better or not.

> In the long-term, I think we may want to address the lock contention
> in zsmalloc itself instead of zswap spawning multiple zpools.
> 
>>
>> The patch did not apply cleanly on v6.9.3 so I applied it on v6.10-rc2. dmesg of the current v6.10-rc2 run attached.
>>
>> Regards,
>> Erhard
> 



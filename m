Return-Path: <linux-kernel+bounces-201374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA5D8FBDAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996CA282C5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57E14BFA2;
	Tue,  4 Jun 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6SZkmnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93612D215
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534831; cv=none; b=JwY+/9l9Yis04e9v+zrTbSZGgId6kqIxbhqrr80XFHqscVkI5kuEsUUKqzt+Txs6fxrIwJLcUxdig0adPXkys40HRLJYco/rLQ0KHUGF11kKVECbcxMa/PDkpVAAvIp2ihrUJLZFsk7PcybmNA7b+S7FLjBT4U2DDnp/muXBI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534831; c=relaxed/simple;
	bh=y2QXvMKu+toawTwirI1umsvW2EK6ZKNHpsp7PVAKxNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0NKH0jyBlssEIhQDHsHpX+h6Ch/yQZlOw/ct1RwZJSdKVkY7w3OXpW8ChVz2PBFfbxTEGSLtjwCmhXOkE7SY3LeMl/xtYXuruJiwxq/3gPDUiJHGuFf/6xogVuSfpJtAc7xUAd5c5aidfLDW+G0dh9iyiyehmb7KTrUbn8Ml2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6SZkmnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02085C2BBFC;
	Tue,  4 Jun 2024 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534831;
	bh=y2QXvMKu+toawTwirI1umsvW2EK6ZKNHpsp7PVAKxNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X6SZkmnfZNgOG3Y3weWs3ETi/VO+/8FSLGaEoUwWuqLXTY+QWWASCFl7GDG8ZuDYY
	 WUGo/nq/1yyD6/1E9RZwQ0gQNaw7wvYTOxdctLnUUvGc8e8UBk70GAHvtAtllUogFZ
	 8w8QyXtLYb6/U3wSGLRWhHL6h6bXtvRpsKtHn6uAZTsmwIBmjp3dJqYF0ntVRjq5OP
	 Q0PXMqPXX4Bm3KwVcHMW9SIf4aL+HFzr/sMZIy0N4mn43ZTCOpKn8j3qdcbmOH25eJ
	 QfIKgwYun7772uIhfxPV5HsYtwifcSZ6P8JqKO8hMiS6sGhhFnQkOGCJ0uDa0U8ZJJ
	 UdLaDsEIykCJg==
Message-ID: <f1f527d6-2866-4a64-8018-453c468c88ab@kernel.org>
Date: Tue, 4 Jun 2024 23:00:27 +0200
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
To: Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>
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
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/24 8:01 PM, Yosry Ahmed wrote:
> On Tue, Jun 4, 2024 at 10:54 AM Yu Zhao <yuzhao@google.com> wrote:
>> There was a lot of user memory in the DMA zone. So at a point the
>> highmem zone was full and allocation fallback happened.
>>
>> The problem with zone fallback is that recent allocations go into
>> lower zones, meaning they are further back on the LRU list. This
>> applies to both user memory and zsmalloc memory -- the latter has a
>> writeback LRU. On top of this, neither the zswap shrinker nor the
>> zsmalloc shrinker (compaction) is zone aware. So page reclaim might
>> have trouble hitting the right target zone.
> 
> I see what you mean. In this case, yeah I think the internal
> fragmentation in the zsmalloc pools may be the reason behind the
> problem.
> 
> How many CPUs does this machine have? I am wondering if 32 can be an
> overkill for small machines, perhaps the number of pools should be
> max(nr_cpus, 32)?
> 
> Alternatively, the number of pools should scale with the memory size
> in some way, such that we only increase fragmentation when it's
> tolerable.

Sounds like a good idea to me, maybe a combination of both. No point in
trying to scale if there's no benefit and only downside of more memory
consumption.


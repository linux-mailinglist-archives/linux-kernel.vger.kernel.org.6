Return-Path: <linux-kernel+bounces-362063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABE299B073
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA71D1C21314
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D24642D;
	Sat, 12 Oct 2024 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jtv7DbvR"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059B14F90
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728704012; cv=none; b=aodA6zHcmw4PwbUU2tQWZX2HRczfNL9GYUxpOUYvNkb73xJHGU6SY24xJ+JWlNi55V1wHQa8vYuqCQ6J47J3UpIP6X8mBhQH05kdxgpyxeUGuQx53W0GBahHKRI8Dg5pgHBagpmZsqP8fRIHLw0dS6VlqRwY5EO9/5X3aqPRhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728704012; c=relaxed/simple;
	bh=o+SXVGu7T3aZxaL4LDpthmUL469hx9heGIUwCttQ+x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6N7N6K37Aekfh0xPmrk9lfZtCC4KLVF2eszjFm4dkk+QtTqr0uEobl2eODt5yJt0rSsvTHWw1LuudeUOkDBD5ehKk4RnpnMrivbFhkwtAP0UUy1C+s0FpsRRRp9wGki6MTKjoxw0JH6Pio6MBMCpUhrkCet8XykOxAL2cpVpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jtv7DbvR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5fa01666-51d4-4ccb-bcd4-3b3620dd2e2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728704007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o81ePbu8o7fPin68TehE+eOoRAm92NK36NqF94NSOw=;
	b=jtv7DbvRM5F36XrUR/X3xquqMv0NN2DQ/WXCOrLff6JzXHvEbu2XYngbkDYjX1KuXjQkeX
	0WuvB5vq5AyXn1z3+edejD/7no+cZ/2jt7MvYdMVBpOUBPtjYtLfpCzeTw3rcc9ePNa3ZE
	vb3IyatJNWzs+XXIY75XIwQJSfpN7Tw=
Date: Sat, 12 Oct 2024 11:33:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zswap: avoid touching XArray for unnecessary
 invalidation
To: Kairui Song <ryncsn@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
 "Huang, Ying" <ying.huang@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20241011171950.62684-1-ryncsn@gmail.com>
 <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>
 <20241011182831.GC351101@cmpxchg.org>
 <CAMgjq7Ajen_XQHGznNp3hFWOes+K=fn6HssW3-SUL8i4xDebhQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAMgjq7Ajen_XQHGznNp3hFWOes+K=fn6HssW3-SUL8i4xDebhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/10/12 11:04, Kairui Song wrote:
> Johannes Weiner <hannes@cmpxchg.org> 于 2024年10月12日周六 02:28写道：
>>
>> On Fri, Oct 11, 2024 at 10:53:31AM -0700, Yosry Ahmed wrote:
>>> On Fri, Oct 11, 2024 at 10:20 AM Kairui Song <ryncsn@gmail.com> wrote:
>>>>
>>>> From: Kairui Song <kasong@tencent.com>
>>>>
>>>> zswap_invalidation simply calls xa_erase, which acquires the Xarray
>>>> lock first, then does a look up. This has a higher overhead even if
>>>> zswap is not used or the tree is empty.
>>>>
>>>> So instead, do a very lightweight xa_empty check first, if there is
>>>> nothing to erase, don't touch the lock or the tree.
>>
>> Great idea!
>>
>>> XA_STATE(xas, ..);
>>>
>>> rcu_read_lock();
>>> entry = xas_load(&xas);
>>> if (entry) {
>>>      xas_lock(&xas);
>>>      WARN_ON_ONCE(xas_reload(&xas) != entry);
>>>      xas_store(&xas, NULL);
>>>      xas_unlock(&xas);
>>> }
>>> rcu_read_unlock():
>>
>> This does the optimization more reliably, and I think we should go
>> with this version.
> 
> Hi Yosry and Johannes,
> 
> This is a good idea. But xa_empty is just much lighweighter, it's just
> a inlined ( == NULL ) check, so unsurprising it has better performance
> than xas_load.
> 
> And surprisingly it's faster than zswap_never_enabled. So I think it

Do you have CONFIG_ZSWAP_DEFAULT_ON enabled? In your case, CPU will go 
to the unlikely branch of static_key every time, which maybe the cause.

> could be doable to introduce something like zswap_may_have_swpentry as
> Yosry suggested.
> 
> So how about a combined version with xas_load and xa_empty? Check
> xa_empty first as a faster path, then xas_load, then xas_store.

Yeah, I also think this combined version is better.

Thanks.

> 
> Here is the benchmark result (time of swapin 2G zero pages in us):
> 
> Before:   1908944 1905870 1905322 1905627 1901667
> xa_empty: 1835343 1827367 1828402 1831841 1832719
> z.._enabled: 1838428 1831162 1838205 1837287 1840980
> xas_load: 1874606 1878971 1870182 1875852 1873403
> combined: 1845309 1832919 1831904 1836455 1842570
> 
> `combined` is xa_empty + xas_load.


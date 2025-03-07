Return-Path: <linux-kernel+bounces-550329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCBA55E00
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1833F3B3044
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6361632D9;
	Fri,  7 Mar 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FVhC0c9s"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA521F94C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316797; cv=none; b=T0MdQ1HMQkP5eXw1oPoTadMQpu+PBXHT2v08yfn4oCLUa18ZcE9R4dZMAcz1ZrW4cOt149iiprH4d9YLM9BBidet9xdaBhOHCYufdYvAJWJCoZuWP6Gi61ASVVdjUW1q3llJeYLPPJHFshcTspBxGyD6KOpxg3gFDzB0iIHBqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316797; c=relaxed/simple;
	bh=afpeUZzo6IYtXlCVPBgtuM6vJEO9Em8MFprIZ/2Id70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/kimqFUC8gsvHLtQ1Nna9UCelWmz70oTxJPKnLh+5hfA/RSWc+zoLlHfYZfC+Unx6RSsU0fw6NfAYaWTo+H/GRpW2Nc9mrR30k3UVfNwUXb5UpzmLyRFx5BfShOZverof5lnaewCQpGtkUVmc9i2/dah5gBD0Fq6EXG66YMEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FVhC0c9s; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a7c9ef6-2511-404e-b9c2-117765c90d95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741316792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzbprMV/OZKTdRrqS+bnLZbpGK4ksEtI/ebz1jE8B40=;
	b=FVhC0c9sGprYOiv6EJpEGTtXi1vYAz/wO3ugz6oEyGzzKmUKFTX9zJtXxjRK5k2qkMgzwi
	+Ch/+3BPiMaSYrSl3SKbLHDSKljc6M6Cc7gpwROMd6Z3a9CHaTWNNJXTbGXBBIRL9vVFdN
	hK/MxephVOltyad+DQxgRMbxCicUY2c=
Date: Fri, 7 Mar 2025 11:06:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] page_io: zswap: do not crash the kernel on
 decompression failure
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, yosry.ahmed@linux.dev,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20250306205011.784787-1-nphamcs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250306205011.784787-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/7 04:50, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback.
> 
> See [1] for a recent upstream discussion about this.
> 
> The zswap writeback case is relatively straightforward to fix. For the
> zswap_load() case, we change the return behavior:
> 
> * Return 0 on success.
> * Return -ENOENT (with the folio locked) if zswap does not own the
>    swapped out content.
> * Return -EIO if zswap owns the swapped out content, but encounters a
>    decompression failure for some reasons. The folio will be unlocked,
>    but not be marked up-to-date, which will eventually cause the process
>    requesting the page to SIGBUS (see the handling of not-up-to-date
>    folio in do_swap_page() in mm/memory.c), without crashing the kernel.
> * Return -EINVAL if we encounter a large folio, as large folio should
>    not be swapped in while zswap is being used. Similar to the -EIO case,
>    we also unlock the folio but do not mark it as up-to-date to SIGBUS
>    the faulting process.
> 
> As a side effect, we require one extra zswap tree traversal in the load
> and writeback paths. Quick benchmarking on a kernel build test shows no
> performance difference:
> 
> With the new scheme:
> real: mean: 125.1s, stdev: 0.12s
> user: mean: 3265.23s, stdev: 9.62s
> sys: mean: 2156.41s, stdev: 13.98s
> 
> The old scheme:
> real: mean: 125.78s, stdev: 0.45s
> user: mean: 3287.18s, stdev: 5.95s
> sys: mean: 2177.08s, stdev: 26.52s
> 
> [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!


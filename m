Return-Path: <linux-kernel+bounces-277791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD594A68C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8392824EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C471DF699;
	Wed,  7 Aug 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="koepf3Vo"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D91C9DC9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028627; cv=none; b=e8H/98/Ew6WAZ8emrue6lNJUUWEykdelWYcTDQPmTID+aVEFppr7rhY5mOleBk26BHG46q1NRX1tn7QiMgDq9ucfC50AeZryCn8T3snRxZ+AaSpc5wyPy6DXEx/VxeisKfZwgfDn5YTrPddlRYZR+UNiphRHVcvbGeoCvVLRiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028627; c=relaxed/simple;
	bh=cuUrR157zpyMmPBZH/u917m24UqzzDOS+LC5Nw8qcFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUSR3Mf8LTGjLjmYcz3VN76Thwt0mqrkARv2N6u/caruIGd7s+eevQLsd/FDo6uk3AyypkkcaqFuJ5211/0bbg6q4ESMcI/Hpy+7xYig9jVs937pg9fxgTtbOTiryDu5wxbe7Q0PaP+9LPc72d9N7wnwIM1/rLNQakt8457KVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=koepf3Vo; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bb5a4668faso8589266d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1723028623; x=1723633423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gN5cEn529JPwU3lFLqshcVWf854tpVZo4bfi6+q2Cm8=;
        b=koepf3Vo6pjY2r9sFq9tj6XOS/Wy1AWAQkK3GF4sz5typo/KZIlndaZP57jLHhOy19
         dB6vWb5X16Ygg8/7qKniYGXbfOQ2CBs9AFsQKujCn8bU7wu0eOXL7a0jD6/1ztwFrCUF
         7Xp0Wg6n/zs1+fqexVUzgaFEweHb2xNMDHGHJn1vPE8x/a1kkN5nkOORmy+Y3+Tqb/VN
         LKm7iuoUpIKQyS1fVLDAl5fmaru1AXE61Id67HOd37Xjzu1yTGFQOriaHbNlN45HAbl4
         HzwHbQY92RePMkPAA9ITD7qiBAmpwC6h+Ug6Ue+Jj1t19jmA67Ni3YZjXyPKvbrLZADA
         1N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723028623; x=1723633423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN5cEn529JPwU3lFLqshcVWf854tpVZo4bfi6+q2Cm8=;
        b=KuvbbH7jx+RBpeey2KSi2ZbaLOENJItvwm9XLb7TfnCw4wM8tvJaZSc9Pi7UuPeyTN
         e3CZ9VD5w/MFaA/zwVxQbLaLOSGk9rdRMsTLMHwP96UooQuQhVhtael15cqJ5eF+36q9
         xoEXGtEDN+B82xaNCQJ28P5uB0sJGbKLvyB2V+oP05lIY1xJMtmcDSsFEAOpcBBxQfC/
         zoiZyyOvGUr2kSnGjso5GhvQnHDw3Qd8iRgpS1mlLduNkas39+ot3WrOD/4B2d3wJsoZ
         5rl72RQvYO72O7arqXgSMRZoXLVv8xmqYX6Dk3MrL8hwMmY/FCJRM1G8M2+mzOLCBvfS
         yAUw==
X-Forwarded-Encrypted: i=1; AJvYcCX3iVyWcptVxkqIOUv1JhvxFWeqhrXU7IHKQ2YDLdFIdi1Tlie/UGHmjLfzdJZuYJAzAW9HfqQsJuS7fWmoLfbXtW0l4+4SCZBg4UcF
X-Gm-Message-State: AOJu0Yy2wHxiO8FDzYSIUWMChzJQeWZO8F9dDpuzP9to0OD6XKBG5v//
	5hA9u5DrzFl4EN7amLDHWoG1eKGTTv2qr5RsYDp6clzxb2TV4UJ9N7Bk0e45id0=
X-Google-Smtp-Source: AGHT+IHYthDgCqzBoNmQ6FJxrW7oAkL2AAZ4AwPIlpdqz27iAkWQZavNy28ABx0q/yK19HGUsv+b7Q==
X-Received: by 2002:a05:6214:4989:b0:6b5:434:cc86 with SMTP id 6a1803df08f44-6bb9833d83amr261545796d6.10.1723028622728;
        Wed, 07 Aug 2024 04:03:42 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797dbdsm55177716d6.52.2024.08.07.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:03:42 -0700 (PDT)
Date: Wed, 7 Aug 2024 07:03:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, yosryahmed@google.com,
	shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: Re: [PATCH v3 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
Message-ID: <20240807110341.GA1726375@cmpxchg.org>
References: <20240805232243.2896283-1-nphamcs@gmail.com>
 <20240805232243.2896283-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805232243.2896283-2-nphamcs@gmail.com>

On Mon, Aug 05, 2024 at 04:22:42PM -0700, Nhat Pham wrote:
> Current zswap shrinker's heuristics to prevent overshrinking is brittle
> and inaccurate, specifically in the way we decay the protection size
> (i.e making pages in the zswap LRU eligible for reclaim).
> 
> We currently decay protection aggressively in zswap_lru_add() calls.
> This leads to the following unfortunate effect: when a new batch of
> pages enter zswap, the protection size rapidly decays to below 25% of
> the zswap LRU size, which is way too low.
> 
> We have observed this effect in production, when experimenting with the
> zswap shrinker: the rate of shrinking shoots up massively right after a
> new batch of zswap stores. This is somewhat the opposite of what we want
> originally - when new pages enter zswap, we want to protect both these
> new pages AND the pages that are already protected in the zswap LRU.
> 
> Replace existing heuristics with a second chance algorithm
> 
> 1. When a new zswap entry is stored in the zswap pool, its referenced
>    bit is set.
> 2. When the zswap shrinker encounters a zswap entry with the referenced
>    bit set, give it a second chance - only flips the referenced bit and
>    rotate it in the LRU.
> 3. If the shrinker encounters the entry again, this time with its
>    referenced bit unset, then it can reclaim the entry.
> 
> In this manner, the aging of the pages in the zswap LRUs are decoupled
> from zswap stores, and picks up the pace with increasing memory pressure
> (which is what we want).
> 
> The second chance scheme allows us to modulate the writeback rate based
> on recent pool activities. Entries that recently entered the pool will
> be protected, so if the pool is dominated by such entries the writeback
> rate will reduce proportionally, protecting the workload's workingset.On
> the other hand, stale entries will be written back quickly, which
> increases the effective writeback rate.
> 
> The referenced bit is added at the hole after the `length` field of
> struct zswap_entry, so there is no extra space overhead for this
> algorithm.
> 
> We will still maintain the count of swapins, which is consumed and
> subtracted from the lru size in zswap_shrinker_count(), to further
> penalize past overshrinking that led to disk swapins. The idea is that
> had we considered this many more pages in the LRU active/protected, they
> would not have been written back and we would not have had to swapped
> them in.
> 
> To test this new heuristics, I built the kernel under a cgroup with
> memory.max set to 2G, on a host with 36 cores:
> 
> With the old shrinker:
> 
> real: 263.89s
> user: 4318.11s
> sys: 673.29s
> swapins: 227300.5
> 
> With the second chance algorithm:
> 
> real: 244.85s
> user: 4327.22s
> sys: 664.39s
> swapins: 94663
> 
> (average over 5 runs)
> 
> We observe an 1.3% reduction in kernel CPU usage, and around 7.2%
> reduction in real time. Note that the number of swapped in pages
> dropped by 58%.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


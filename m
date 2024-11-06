Return-Path: <linux-kernel+bounces-398431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2E9BF12E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3084D281A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35921F9ABC;
	Wed,  6 Nov 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="E3//7gmX"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF107190470
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905601; cv=none; b=PQ94zO8fknDgvS+NkoU+DkxXhIv85Li/Sk2zAlLDNcUQ4uJXKxkUdInB0gclMoBRsaXe0iw2h+6kPQSRvVE70hLU7kVGwJgScWhlokeu9k0aQyttc88uCsLZyKfY3YtOrKQhXb9UAw6yDX3BbNtNravNS1rQbqNw7RVT2uzDHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905601; c=relaxed/simple;
	bh=b1up6vIkM23WSom0mGKIcrqpueAyjYij77mZ20FHqcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcTketGoYMQh+DlNATfTMSS/iuhirGua3H20/Ge80/k+o2eA8pdVpplIQocamAI1dj72SL5T91VYQCYMT/fmyuRyWwTwGPDB7F3yhzb+Ov4coRx+ZFgxgJIQd7c0MUuVD3sqA45vO18BZ3f2GDzPx6nej9MNNkH/xoh5irtGbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=E3//7gmX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so49309356d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730905596; x=1731510396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RKSO4lUtMQl4Y5LRJdMnzIr2/DYRxLVMU8drEAtphZ8=;
        b=E3//7gmXSHCmnTtLvvognkWS5a4LzqSeZyvQsSPijnXmOjMo04XzIpCdYOvwYHZZcm
         7zJ57L9M3gItJnGlRB6j52STqkIcIThuMafLRsWeguR8Zew35ZR3zvWEQXyrfcNJQlI+
         CaLrVHLfhd6Ib7UzLpy6uh+uZuMKjP+mtpMwBOv7FmhFeBAZk0zGgYV1Tx/z0dWUuHZ1
         jKRzi0K54lkVUCM90brdo0ghCReGwfdmjNpka+6Ihq4pfAbe1CQb+ZVgJ5Vw4rjsT/eZ
         0OiYYM/JT+x3kqp9/jzr6eaFsprEXdhCPVxCseq1rxIvMAMNEsvyI/mo+YvUOrp8BGtY
         l0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905596; x=1731510396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKSO4lUtMQl4Y5LRJdMnzIr2/DYRxLVMU8drEAtphZ8=;
        b=P75ivEfMOLLYreIxOv851+vUoJ5qMNRTTVOhJZ/5x5AmQDig1qfJexfQrfBoiwsKnO
         zmRBTJAdz4AG+Jjiyf5ORLDvhNnGYJ9CORm2s0gv2HIgl23yKBA8QMbvPkAOpCRpCXdP
         m4p4xrbS/LYVDIGSTpLJa1UopzBODuJBQWVKVa9vHYKj0ZZb9Ns9IFUpg4DZNcOZYiWw
         NX8NQNAG7WwxOOmKvm1oy2GW4eyHF7ByF0ns3r5Fgt5eb2ygpa9DddMWNZ7cKrnNBfgV
         gPOqCR/C2f+pQF+GeRclhz+i+Slh2WyN+7TBAQiFLhC5BoKfd9aP5VdJJCUA8K4leuUn
         fimQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk+QZWimD+e54RXNxnTplncTR7BSj58VCVQ2D3GKfELAzhUuwr/3TXij9gdhZQf03LmUwteFNihJlCjPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/zo7BUesyEmTOcf0y0lSdHiWNju2lWTZmMobDVZIxeHQ6ZOD
	IFT2A8gLQxzTdq5Tt4IGue+lTsWaimxMPmggmXnSi6gyk16Ok2nkGVW7b2lh3hQ=
X-Google-Smtp-Source: AGHT+IEnTA+3Pm5zFU2s+8Nc6MKNep1IYwxKPkBsZx1q5uHLuvMKwOML7P3MUMkRXZwnjOmhxDW/Cg==
X-Received: by 2002:a05:6214:2f82:b0:6d1:8346:9dbf with SMTP id 6a1803df08f44-6d35c19a037mr311901416d6.42.1730905596209;
        Wed, 06 Nov 2024 07:06:36 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc636asm73086316d6.51.2024.11.06.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:06:35 -0800 (PST)
Date: Wed, 6 Nov 2024 10:06:31 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Nhat Pham <nphamcs@gmail.com>, Usama Arif <usamaarif642@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Hailong Liu <hailong.liu@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and swapin
Message-ID: <20241106150631.GA1172372@cmpxchg.org>
References: <20241105211934.5083-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105211934.5083-1-21cnbao@gmail.com>

On Wed, Nov 06, 2024 at 10:19:34AM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When the proportion of folios from the zeromap is small, missing their
> accounting may not significantly impact profiling. However, it’s easy
> to construct a scenario where this becomes an issue—for example,
> allocating 1 GB of memory, writing zeros from userspace, followed by
> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> and swap-in counts seem to vanish into a black hole, potentially
> causing semantic ambiguity.
> 
> On the other hand, Usama reported that zero-filled pages can exceed 10% in
> workloads utilizing zswap, while Hailong noted that some app in Android
> have more than 6% zero-filled pages. Before commit 0ca0c24e3211 ("mm: store
> zero pages to be swapped out in a bitmap"), both zswap and zRAM implemented
> similar optimizations, leading to these optimized-out pages being counted
> in either zswap or zRAM counters (with pswpin/pswpout also increasing for
> zRAM). With zeromap functioning prior to both zswap and zRAM, userspace
> will no longer detect these swap-out and swap-in actions.
> 
> We have three ways to address this:
> 
> 1. Introduce a dedicated counter specifically for the zeromap.
> 2. Use pswpin/pswpout accounting, treating the zero map as a standard
> backend. This approach aligns with zRAM's current handling of
> same-page fills at the device level. However, it would mean losing
> the optimized-out page counters previously available in zRAM and
> would not align with systems using zswap. Additionally, as noted by
> Nhat Pham, pswpin/pswpout counters apply only to I/O done directly
> to the backend device.
> 3. Count zeromap pages under zswap, aligning with system behavior when
> zswap is enabled. However, this would not be consistent with zRAM,
> nor would it align with systems lacking both zswap and zRAM.
> 
> Given the complications with options 2 and 3, this patch selects
> option 1.
> 
> We can find these counters from /proc/vmstat (counters for the whole
> system) and memcg's memory.stat (counters for the interested memcg).
> 
> For example:
> 
> $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
> swpin_zero 1648
> swpout_zero 33536
> 
> $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
> swpin_zero 3905
> swpout_zero 3985
> 
> This patch does not address any specific zeromap bug, but the missing
> swpout and swpin counts for zero-filled pages can be highly confusing
> and may mislead user-space agents that rely on changes in these counters
> as indicators. Therefore, we add a Fixes tag to encourage the inclusion
> of this counter in any kernel versions with zeromap.
> 
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Hailong Liu <hailong.liu@oppo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


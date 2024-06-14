Return-Path: <linux-kernel+bounces-214334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70F9082DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D71F22DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCCB146A62;
	Fri, 14 Jun 2024 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK7UISCw"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FB26AF1;
	Fri, 14 Jun 2024 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338171; cv=none; b=VL0J9AJCleKBeJdZKtFjKsbbb2cckVf3ylt+lwKR92CNIyP0ulVjm3+umHU/gcy0GrslunkRyYkzq4iFLt1Yzrehepou+0DcmHYZa5IKrLx94JzJ8F/0Q89NitB7Tq0uOnkkdiiBpHe73v/gOp5WoKV8IGdByasUjIo5JBSq4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338171; c=relaxed/simple;
	bh=POoCvNScEn7uvRtPbXAQQxMPU1qNK7rBg/b98obT5bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maAVGcOsumPaDxOezOo6jNWbE4/oRACVXg8qBPuf+Rd5Abw5OKXnc3dRKCv6ug3zJQbmSxH1yl63pSRxhbjDI+vK+Xz5ZiQFKDNjTfj8ccVU2hfqRnWPYaa4b+f+2tmL1BSJeF85CzR4noQ5To8lI1J4ZGxU+LZV10QykJITIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK7UISCw; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df481bf6680so1982754276.3;
        Thu, 13 Jun 2024 21:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718338169; x=1718942969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POoCvNScEn7uvRtPbXAQQxMPU1qNK7rBg/b98obT5bo=;
        b=dK7UISCwT/SVq8NBLW50StWiH1GhlbqoozDSvQubJDQehrOjv//muBduPMmFgrB/B4
         814nEY+nKBCeyQayr42HfdVFiACUNDxn9L+lJM0TRGGVd8jOdoJyuElKQa9/Geb/Dexc
         WucAC4+oy7M0yBq0i8YZ7+J1/60eAtjDZon1wblYRq9zqW/anFHlDU0YH3GAdq7JYQG6
         OgQvSMucdQXznM+Lae2ciER6Rikkb/Vy9MUSL2A4CMNrlP8a4hBi3i0oofYU7i0rAoi3
         yF3V8LVz9JfK6BYwHCg/golpHvFQ4jP539dBEb1aIol8CuIfQruxIhWZ+xXwUWCWXbQm
         k1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718338169; x=1718942969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POoCvNScEn7uvRtPbXAQQxMPU1qNK7rBg/b98obT5bo=;
        b=fWoJOQ1rbUBq1FZs4rbAof6EHVvcwjR5utEM5ii4cd/IR3LzKGcCG6MJCU2hhstbhS
         9/aCP/4YCw/4u7WjO1er1lfGfe44SKKtLk2Gle/8NlBmaBA90W3RIeTCjQVv/u2y9ErJ
         BL8wr5bXszeTkUPzLCwBuUM3lHD5oMrcSoOYHu9vT0lopl1+G/0HVaNUCU+9246Z8mmD
         5zarbGcFdUvjtLIwUs+guTJx97SEE2e+aplT0RHm4q5hccGAa3Mh8pdHwJkzOSMA85aB
         NkWVmks6qTBCMnB2Z4K4ysqCsOGIgcUVtFCStm10O/c5KFBIWGsFnoWDOYbNnZjUmqDl
         JVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnna7XSxunt3NqfKsgss0qzxHdm62IjLaPP6+kUnljgUywAAzg9RsLo8py8/yIK6eecDCzcEd5yAX7u9QFIfybB5wbqnWxlRgq1uD15XbXvBi/oHY5ja9tN6N6sDiyDG+hD6q6T7+P
X-Gm-Message-State: AOJu0YwgU8f5odSyrbsku/pd1zhtUw9pZFhFRBnBpd1PAv6eAM7cRhR5
	i/SCFFUGfGXZ0EaqCVhn2jxQOnTiSP3GPR8nGf81i2gG5uiZJJ8s/eLRhHnWlupbCplNCcRwx8Y
	rsvIuNVJUn28y5X/6neC3DLEmk/c=
X-Google-Smtp-Source: AGHT+IGoC87N1rv3FOus3VP01cyHvXpUOzqyU4Vw+jNvBJpFIY32fE1ic9hLLfpXpWxripiKdm8/L1pV2HCZrUMyyas=
X-Received: by 2002:a25:cecd:0:b0:de4:738b:c2e4 with SMTP id
 3f1490d57ef6-dff153ac241mr1260762276.28.1718338168895; Thu, 13 Jun 2024
 21:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
In-Reply-To: <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Fri, 14 Jun 2024 13:09:18 +0900
Message-ID: <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8814=E6=97=A5(=E9=87=91) 0:22 Nhat Pham <nphamcs@gmail=
.com>:
>
> Taking a step back from the correctness conversation, could you
> include in the changelog of the patches and cover letter a realistic
> scenario, along with user space-visible metrics that show (ideally all
> 4, but at least some of the following):
>
> 1. A user problem (that affects performance, or usability, etc.) is happe=
ning.
>
> 2. The root cause is what we are trying to fix (for e.g in patch 1, we
> are skipping over memcgs unnecessarily in the global shrinker loop).
>
> 3. The fix alleviates the root cause in b)
>
> 4. The userspace-visible problem goes away or is less serious.
>

Thank you for your suggestions.
For quick response before submitting v2,

1.
The visible issue is that pageout/in operations from active processes
are slow when zswap is near its max pool size. This is particularly
significant on small memory systems, where total swap usage exceeds
what zswap can store. This means that old pages occupy most of the
zswap pool space, and recent pages use swap disk directly.

2.
This issue is caused by zswap keeping the pool size near 100%. Since
the shrinker fails to shrink the pool to accept_thr_percent and zswap
rejects incoming pages, rejection occurs more frequently than it
should. The rejected pages are directly written to disk while zswap
protects old pages from eviction, leading to slow pageout/in
performance for recent pages on the swap disk.

3.
If the pool size were shrunk proactively, rejection by pool limit hits
would be less likely. New incoming pages could be accepted as the pool
gains some space in advance, while older pages are written back in the
background. zswap would then be filled with recent pages, as expected
in the LRU logic.

Patch 1 and 2 make the shrinker reduce the pool to accept_thr_percent.
Patch 3 makes zswap_store trigger the shrinker before reaching the max
pool size. With this series, zswap will prepare some space to reduce
the probability of problematic pool_limit_hit situation, thus reducing
slow reclaim and the page priority inversion against LRU.

4.
Once proactive shrinking reduces the pool size, pageouts complete
instantly as long as the space prepared by shrinking can store the
direct reclaim. If an admin sees a large pool_limit_hit, lowering
accept_threshold_percent will improve active process performance.


> I have already hinted in a previous response, but global shrinker is
> rarely triggered in production. There are lots of factors that would
> prevent this from triggering:
>
> 1. Max zswap pool size 20% of memory by default, which is a lot.
>
> 2. Swapfile size also limits the size of the amount of data storable
> in the zswap pool.
>
> 3. Other cgroup constraints (memory.max, memory.zswap.max,
> memory.swap.max) also limit a cgroup's zswap usage.
>
> I do agree that patch 1 at least is fixing a problem, and probably
> patch 2 too but please justify why we are investing in the extra
> complexity to fix this problem in the first place.

Regarding the production workload, I believe we are facing different situat=
ions.

My intended workload is low-activity services distributed on small
system like t2.nano, with 0.5G to 1G of RAM. There are a significant
number of pool_limit_hits and the zswap pool usage sometimes stays
near 100% filled by background service processes.

When I evaluated zswap and zramswap, zswap performed well. I suppose
this was because of its LRU. Once old pages occupied zramswap, there
was no way to move pages from zramswap to the swap disk. zswap could
adapt to this situation by writing back old pages in LRU order. We
could benefit from compressed swap storing recent pages and also
utilize overcommit backed by a large swap on disk.

I think if a system has never seen a pool limit hit, there is no need
to manage the costly LRU. In such cases, I will try zramswap.

I am developing these patches by testing with artificially allocating
large memory to fill the zswap pool (emulating background services),
and then invoking another allocation to trigger direct reclaim
(emulating short-live active process).
On real devices, seeing much less pool_limit_hit by lower
accept_thr_percent=3D50 and higher max_pool_percent=3D25.
Note that before patch 3, zswap_store() did not count some of the
rejection as pool_limit_hit properly (underestimated). we cannot
compare the counter directly.

I will try to create a more reproducible realistic benchmark, but it
might not be realistic for your workload.


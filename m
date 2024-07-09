Return-Path: <linux-kernel+bounces-245033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D421F92AD42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524381F222C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29538382;
	Tue,  9 Jul 2024 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxLXFXD2"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F0374CC;
	Tue,  9 Jul 2024 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486429; cv=none; b=iVHB64ribf6nnYArWc905+TtZOGXfTeKFTmDe1VVu+YuovqMYGUBuj7lchLitYYt53j5AGxTOy/Vr+dmEVnNomSUtm34151nx6t+yZcNfhTV1k3fQw7oAFZDR/DyKdL/FC56Nj9Xnxw/qkDmLcTxXUkNTW+Ty63WwSgtqZs4zbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486429; c=relaxed/simple;
	bh=NnywyARqUgF3HMX96va5rp2PkBbO6S9CU+xsjNvVucQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcvG/BiX2L5ueoKx+u1IV7V+sVhP1L1ntoiMiRxsCE885A1rrH3ILrRCqiv4eFBVAwoi0A6CAoRHgYq+kbFbB4D+f5tiiVspQFUQY/aYVe6fAFGRxK3l/cGrI5I8vFd6XP1WUackRM4wI02KyZpN1ZZWtTonsB6CoevJGcFCJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxLXFXD2; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfab4779d95so4858904276.0;
        Mon, 08 Jul 2024 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720486426; x=1721091226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxUewbS9CHNfJzvJo7a2g8V9O8ZPqq3ROM3y+MnW49k=;
        b=dxLXFXD2RpPvIwpRMGd0wqv3k1yEyx40TTDQiwlOSYLR08fCQry3P0oDygWfQETZ8g
         ehE1xBLcZXU6e5oGsbz7BfaHIL/d7Un6vCLtHuAJMgCm0suzVvDTvixh8D3q4hocrckT
         G5j74AAfx+/bbvHkTqjGUHMhK/sUDYLuyLVDQvsVIkvajUmgd+G1MhDtttbxKCtcp+Tc
         wNH7Y63yxhGn2bmbd2+yA1US4QyS4GTTd2Vi4xZmOeDV/b8v4VnnquMTFnaw1Is6wDrq
         /Uryow99RvXtFYH9baRRpKbiq2VYyrq36F+Hc+gXzYMC0MQb4sXEfQ1/Svr7tm/jUi4S
         XgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720486426; x=1721091226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxUewbS9CHNfJzvJo7a2g8V9O8ZPqq3ROM3y+MnW49k=;
        b=vQjNU6gYsCPkG1Ow8CI6hyYkvigqabJcEB+zMx8Q6nEsMyod15YHR50a7ktiL8M1KD
         FeLSYTewCRk4r0XsuSDi4HP9iNZ+edxOuFY/tGXrrfuZWvaUCdw6tyPHwcVEjAlcDZcw
         RQBlis4VKAYegVrduSxhtnWuRgiVEh8iDTI/v8xWExOkNc+HXfhDfqgA7uQ14Fyf+wUi
         LK46PVazrHj6lGxOu99VaO45tREYhgkBf0f9au5TYkhF25yMTM5dd6cK2AI8luBnc2+l
         vuSshB/wf0rZ85hAWjFYV/ev5yl0FpHj/9bl0TFu/wdAvYbWRYM95Z6YXhpgi1h962wU
         2Krg==
X-Forwarded-Encrypted: i=1; AJvYcCX8BxjbBan3NoThzHSRSXA8oBvLW1pwX18O42kLfBfxP0RCGwSLfSH8WsIq73PCWYh7KkXy08JRKnOdqvvLiMBOPIcRZaZugH/Z27dUKdUI74Ui/p5b3JdCXZgiDEQ8yReukLipf1vQ
X-Gm-Message-State: AOJu0YyCrNRc+wamy2Os6gIz0q/CHapxBWbl7v07uSHNCLYaSjxsJ3N6
	gmyqpGnynRCkGl+0SG5AsWSEqwTfQLw6BMhvkRsiWNVX/372O8o7VIkWKbTUg7fu3tKYEL3Xcoe
	e91YUMcqelTIDFzq2+84sTOYPjrQ=
X-Google-Smtp-Source: AGHT+IHXiWsau9JPn2ls9GoEdNvbqKjBaLXu+xKi9eBrGLKMZtfZmdFEZFw1ZBab9RxCU+60Rc5TxW9YcW0zTeo8fsQ=
X-Received: by 2002:a25:9386:0:b0:de5:4cd0:8da4 with SMTP id
 3f1490d57ef6-e041b078252mr1702340276.33.1720486426111; Mon, 08 Jul 2024
 17:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
In-Reply-To: <20240706022523.1104080-1-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 8 Jul 2024 17:53:33 -0700
Message-ID: <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:25=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
>

Woah, thanks for the copious of details :)

> This series addresses some issues and introduces a minor improvement in
> the zswap global shrinker.
>
> This version addresses issues discovered during the review of v1:
> https://lore.kernel.org/linux-mm/20240608155316.451600-1-flintglass@gmail=
.com/
> and includes three additional patches to fix another issue uncovered by
> applying v1.
>
> Changes in v2:
> - Added 3 patches to reduce resource contention.
> mm: zswap: fix global shrinker memcg iteration:
> - Change the loop style (Yosry, Nhat, Shakeel)
> - To not skip online memcg, save zswap_last_shrink to detect cursor chang=
e by cleaner.  (Yosry, Nhat, Shakeel)
> mm: zswap: fix global shrinker error handling logic:
> - Change error code for no-writeback memcg. (Yosry)
> - Use nr_scanned to check if lru is empty. (Yosry)
>
> Changes in v1:
> mm: zswap: fix global shrinker memcg iteration:
> - Drop and reacquire spinlock before skipping a memcg.
> - Add some comment to clarify the locking mechanism.
> mm: zswap: proactive shrinking before pool size limit is hit:
> - Remove unneeded check before scheduling work.
> - Change shrink start threshold to accept_thr_percent + 1%.
>
>
> Patches
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> 1. Fix the memcg iteration logic that abort iteration on offline memcgs.
> 2. Fix the error path that aborts on expected error codes.
> 3. Add proactive shrinking at accept threshold + 1%.
> 4. Drop the global shrinker workqueue WQ_MEM_RECLAIM flag to not block
>    pageout.
> 5. Store incompressible pages as-is to accept all pages.
> 6. Interrupt the shrinker to avoid blocking page-in/out.
>
> Patches 1 to 3 should be applied in this order to avoid potential loops
> caused by the first issue. Patch 3 and later can be applied
> independently, but the first two issues must be resolved to ensure the
> shrinker can evict pages. Patches 4 to 6 address resource contention
> issues in the current shrinker uncovered by applying patch 3.
>
> With this series applied, the shrinker will continue to evict pages
> until the accept_threshold_percent proactively, as documented in patch
> 3. As a side effect of changes in the hysteresis logic, zswap will no
> longer reject pages under the max pool limit.
>
> The series is rebased on mainline 6.10-rc6.
>
>
> The counters below are from vmstat and zswap debugfs stats. The times
> are average seconds using /usr/bin/time -v.
>
> pre-patch, 6.10-rc4
> |                    | Start       | End         | Delta      |
> |--------------------|-------------|-------------|------------|
> | pool_limit_hit     | 845         | 845         | 0          |
> | pool_total_size    | 201539584   | 201539584   | 0          |
> | stored_pages       | 63138       | 63138       | 0          |
> | written_back_pages | 12          | 12          | 0          |
> | pswpin             | 387         | 32412       | 32025      |
> | pswpout            | 153078      | 197138      | 44060      |
> | zswpin             | 0           | 0           | 0          |
> | zswpout            | 63150       | 63150       | 0          |
> | zswpwb             | 12          | 12          | 0          |
>
> | Time              |              |
> |-------------------|--------------|
> | elapsed           | 8.473        |
> | user              | 1.881        |
> | system            | 0.814        |
>
> post-patch, 6.10-rc4 with patch 1 to 5

You mean 1 to 6? There are 6 patches, no?

Just out of pure curiosity, could you include the stats from patch 1-3 only=
?

> |                    | Start       | End         | Delta      |
> |--------------------|-------------|-------------|------------|
> | pool_limit_hit     | 81861       | 81861       | 0          |
> | pool_total_size    | 75001856    | 87117824    | 12115968   |
> | reject_reclaim_fail| 0           | 32          | 32         |
> | same_filled_pages  | 135         | 135         | 0          |
> | stored_pages       | 23919       | 27549       | 3630       |
> | written_back_pages | 97665       | 106994      | 10329      |
> | pswpin             | 4981        | 8223        | 3242       |
> | pswpout            | 179554      | 188883      | 9329       |

The pswpin delta actually decreases. Nice :)

> | zswpin             | 293863      | 590014      | 296151     |
> | zswpout            | 455338      | 764882      | 309544     |
> | zswpwb             | 97665       | 106994      | 10329      |
>
> | Time              |              |
> |-------------------|--------------|
> | elapsed           | 4.525        |
> | user              | 1.839        |
> | system            | 1.467        |
>
> Although the pool_limit_hit is not increased in both cases,
> zswap_store() rejected pages before this patch. Note that, before this
> series, zswap_store() did not increment pool_limit_hit on rejection by
> limit hit hysteresis (only the first few hits were counted).

Yeah hysteresis + the broken global shrinker puts the system in a very
bad state. Thanks for showing this.

>
> From the pre-patch result, the existing zswap global shrinker cannot
> write back effectively and locks the old pages in the pool. The
> pswpin/out indicates the active process uses the swap device directly.
>
> From the post-patch result, zswpin/out/wb are increased as expected,
> indicating the active process uses zswap and the old pages of the
> background services are evicted from the pool. pswpin/out are
> significantly reduced from pre-patch results.

Lovely :)

>
>
> System responsiveness issue (patch 4 to 6)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> After applying patches 1 to 3, I encountered severe responsiveness
> degradation while zswap global shrinker is running under heavy memory
> pressure.
>
> Visible issue to resolve
> -------------------------------
> The visible issue happens with patches 1 to 3 applied when a large
> amount of memory allocation happens and zswap cannot store the incoming
> pages.
> While global shrinker is writing back pages, system stops responding as
> if under heavy memory thrashing.
>
> This issue is less likely to happen without patches 1 to 3 or zswap is
> disabled. I believe this is because the global shrinker could not write
> back a meaningful amount of pages, as described in patch 2.
>
> Root cause and changes to resolve the issue
> -------------------------------
> It seems that zswap shrinker blocking IO for memory reclaim and faults
> is the root cause of this responsiveness issue. I introduced three
> patches to reduce possible blocking in the following problematic
> situations:
>
> 1. Contention on workqueue thread pools by shrink_worker() using
> WQ_MEM_RECLAIM unnecessarily.
>
> Although the shrinker runs simultaneously with memory reclaim, shrinking
> is not required to reclaim memory since zswap_store() can reject pages
> without interfering with memory reclaim progress. shrink_worker() should
> not use WQ_MEM_RECLAIM and should be delayed when another work in
> WQ_MEM_RECLAIM is reclaiming memory. The existing code requires
> allocating memory inside shrink_worker(), potentially blocking other
> latency-sensitive reclaim work.
>
> 2. Contention on swap IO.
>
> Since zswap_writeback_entry() performs write IO in 4KB pages, it
> consumes a lot of IOPS, increasing the IO latency of swapout/in. We
> should not perform IO for background shrinking while zswap_store() is
> rejecting pages or zswap_load() is failing to find stored pages. This
> series implements two mitigation logics to reduce the IO contention:
>
> 2-a. Do not reject pages in zswap_store().
> This is mostly achieved by patch 3. With patch 3, zswap can prepare
> space proactively and accept pages while the global shrinker is running.
>
> To avoid rejection further, patch 5 (store incompressible pages) is
> added. This reduces rejection by storing incompressible pages. When
> zsmalloc is used, we can accept incompressible pages with small memory
> overhead. It is a minor optimization, but I think it is worth
> implementing. This does not improve performance on current zbud but does
> not incur a performance penalty.
>
> 2-b. Interrupt writeback while pagein/out.
> Once zswap runs out of prepared space, we cannot accept incoming pages,
> incurring direct writes to the swap disk. At this moment, the shrinker
> is proactively evicting pages, leading to IO contention with memory
> reclaim.
>
> Performing low-priority IO is straightforward but requires
> reimplementing a low-priority version of __swap_writepage(). Instead, in
> patch 6, I implemented a heuristic, delaying the next zswap writeback
> based on the elapsed time since zswap_store() rejected a page.
>
> When zswap_store() hits the max pool size and rejects pages,
> swap_writepage() immediately performs the writeback to disk. The time
> jiffies is saved to tell shrink_worker() to sleep up to
> ZSWAP_GLOBAL_SHRINK_DELAY msec.
>
> The same logic applied to zswap_load(). When zswap cannot find a page in
> the stored pool, pagein requires read IO from the swap device. The
> global shrinker should be interrupted here.
>
> This patch proposes a constant delay of 500 milliseconds, aligning with
> the mq-deadline target latency.
>
> Visible change
> -------------------------------
> With patches 4 to 6, the global shrinker pauses the writeback while
> pagein/out operations are using the swap device. This change reduces
> resource contention and makes memory reclaim/faults complete faster,
> thereby reducing system responsiveness degradation.

Ah this is interesting. Did you actually see improvement in your real
deployment (i.e not the benchmark) with patch 4-6 in?

>
> Intended scenario for memory reclaim:
> 1. zswap pool < accept_threshold as the initial state. This is achieved
>    by patch 3, proactive shrinking.
> 2. Active processes start allocating pages. Pageout is buffered by zswap
>    without IO.
> 3. zswap reaches shrink_start_threshold. zswap continues to buffer
>    incoming pages and starts writeback immediately in the background.
> 4. zswap reaches max pool size. zswap interrupts the global shrinker and
>    starts rejecting pages. Write IO for the rejected page will consume
>    all IO resources.

This sounds like the proactive shrinker is still not aggressive
enough, and/or there are some sort of misspecifications of the zswap
setting... Correct me if I'm wrong, but the new proactive global
shrinker begins 1% after the acceptance threshold, and shrinks down to
acceptance threshold, right? How are we still hitting the pool
limit...

My concern is that we are knowingly (and perhaps unnecessarily)
creating an LRU inversion here - preferring swapping out the rejected
pages over the colder pages in the zswap pool. Shouldn't it be the
other way around? For instance, can we spiral into the following
scenario:

1. zswap pool becomes full.
2. Memory is still tight, so anonymous memory will be reclaimed. zswap
keeps rejecting incoming pages, and putting a hold on the global
shrinker.
3. The pages that are swapped out are warmer than the ones stored in
the zswap pool, so they will be more likely to be swapped in (which,
IIUC, will also further delay the global shrinker).

and the cycle keeps going on and on?

Have you experimented with synchronous reclaim in the case the pool is
full? All the way to the acceptance threshold is too aggressive of
course - you might need to find something in between :)

> 5. Active processes stop allocating pages. After the delay, the shrinker
>    resumes writeback until the accept threshold.
>
> Benchmark
> -------------------------------
> To demonstrate that the shrinker writeback is not interfering with
> pagein/out operations, I measured the elapsed time of allocating 2GB of
> 3/4 compressible data by a Python script, averaged over 10 runs:
>
> |                      | elapsed| user  | sys   |
> |----------------------|--------|-------|-------|
> | With patches 1 to 3  | 13.10  | 0.183 | 2.049 |
> | With all patches     | 11.17  | 0.116 | 1.490 |
> | zswap off (baseline) | 11.81  | 0.149 | 1.381 |
>
> Although this test cannot distinguish responsiveness issues caused by
> zswap writeback from normal memory thrashing between plain pagein/out,
> the difference from the baseline indicates that the patches reduced
> performance degradation on pageout caused by zswap writeback.
>

I wonder if this contention would show up in PSI metrics
(/proc/pressure/io, or the cgroup variants if you use them ). Maybe
correlate reclaim counters (pgscan, zswpout, pswpout, zswpwb etc.)
with IO pressure to show the pattern, i.e the contention problem was
there before, and is now resolved? :)


Return-Path: <linux-kernel+bounces-275501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84216948690
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104C11F235EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86415D1;
	Tue,  6 Aug 2024 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vs0DB24p"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55FA32
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903335; cv=none; b=bsriIL+HELesMethZiPtPGz7tkzeM2XU7RZ1j8kEr1IM5jPSFFUaKCkzpmkSgAvOuW1+mvWWXGKc1LNp4UgRoNXw6uWeIYRgG+qyK5ombm2z1fMFZ3LvAtcLaD+aSjkmb+fhuw5BSP9TB6+nUto6f0z/7wNcTWkHzr9QUv+aFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903335; c=relaxed/simple;
	bh=9SOWLpNxJBZdQ4mRADJ71TCV1Km8WKgrI2zKvFov/jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZGlukldMLpnD4w1IgT8N1r/0GM5M2JXqeNbzoaySN4DaXkirTXw864TQpboC5yWdhphd0W9vL2EXyM9mMEOcmCexpkuTsEcgM+ughccp6c7D0GbZwKwCxtuXYdfRA6GEHdAvGOpbRTI9mWNsRwCZF393QynT5il0TUh9aFZGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vs0DB24p; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so13669787a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722903332; x=1723508132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFetdo8Zo6q+vO4LJcQlpMZdBEcbEQLecTzEJMei5c0=;
        b=Vs0DB24pH60dqcxCQEk/bRVzEGxJ2ju7DLZyImpwvobtskVZZi/R0UIw1cZuAKMa25
         bxJERGCR7XWJuy6RuGdedc+LmjT0dN2bAbMTG8yQxkZng3UT5zylaJ8dVfwBLGPPx/Oi
         ne7xXY9OzKUHYfx4IrWGuIyU3LBxaEM7cCUC4Z7zPAT7BdDhGml7s7WcwpzuetQiG9va
         s5qDwi3QvTkBP8jjkNPU/AdQy9xBR+URPPjPPlcPnG7xgd/C46XMKPuXVIR6eawzfhY2
         UYuZcNciMP7vhhLY1hPF9yzqXvzeQdVfkcnnf/TvG4iOzBuWYpO1Oq3r7zIdWiqx0fYm
         YJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903332; x=1723508132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFetdo8Zo6q+vO4LJcQlpMZdBEcbEQLecTzEJMei5c0=;
        b=wk044kCrFQLga9izQ1+LsITfZqUQc34qZLvjHxKqkx6McYMtU3FRPZXTBnl5gToKS4
         Ij5Q7nuvojAo15MG5HF0tUK8ENauNlVEN3aubElVRDztMsuMkhjKOPkFSiRAkYounbix
         T0VmtQrhOhDWkk/PWFLR08j5WoWSMIti2RO3hTWPDK+OqDOtVnOPGDoe0i/lRHd13bua
         18vzldLuPmEaYsqMLQKLvkeV6dXajuQCx8eicJ5EyABLaV0/hWB2Fax+wNVLkgHChX6o
         CSuatUeaKPPt5Bcll3Y9xRvO0dXZu2kjky6dYdDFudn8oqNqCqXxdj6ep3bHZArdVOl4
         259g==
X-Forwarded-Encrypted: i=1; AJvYcCVN86WEG/xKt4p9EZtlzR8Y7C2jWDImJbBYb0JDprkHE9uItMZWQE2oCpyo2T/ypDcsQbaa+j4kBzjsDSZkYVXyO8kQOzYjt7d3S0Nd
X-Gm-Message-State: AOJu0YzK/M1nwAUXXJrm+POrxTtcL7hVlUgNJOAQNyBxofUCfykDlgdM
	XipHm9khWBc5qpGBvIwbSYNTfIM8xNM7Ke2frflja0T5TldD3F1JepSlDTsCjZoQU1kB1yEiyPD
	eaGMXAdUChozbccK6JYWyoQ/Mq6Dov887l+sY
X-Google-Smtp-Source: AGHT+IH3TDIpNCaYMTQZlOi85LYjn+dvBlxPFGo5G1vYUeXdPfkUltL8KE3MmqhV51gK1ANwsFmTXaFiSRhSZg4EXVY=
X-Received: by 2002:a17:906:4789:b0:a7a:9447:3e91 with SMTP id
 a640c23a62f3a-a7dc4e9b1c4mr944137566b.39.1722903331492; Mon, 05 Aug 2024
 17:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805232243.2896283-1-nphamcs@gmail.com> <20240805232243.2896283-3-nphamcs@gmail.com>
In-Reply-To: <20240805232243.2896283-3-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 5 Aug 2024 17:14:55 -0700
Message-ID: <CAJD7tkaWyGWOArSEEUOLS4EQwdVycNrbvfHK-2rkixBQ8-h+3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] zswap: track swapins from disk more accurately
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:22=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Currently, there are a couple of issues with our disk swapin tracking
> for dynamic zswap shrinker heuristics:
>
> 1. We only increment the swapin counter on pivot pages. This means we
>    are not taking into account pages that also need to be swapped in,
>    but are already taken care of as part of the readahead window.
>
> 2. We are also incrementing when the pages are read from the zswap pool,
>    which is inaccurate.
>
> This patch rectifies these issues by incrementing the counter whenever
> we need to perform a non-zswap read. Note that we are slightly
> overcounting, as a page might be read into memory by the readahead
> algorithm even though it will not be neeeded by users - however, this is

needed*

> an acceptable inaccuracy, as the readahead logic itself will adapt to
> these kind of scenarios.
>
> To test this change, I built the kernel under a cgroup with its
> memory.max set to 2 GB:
>
> real: 236.66s
> user: 4286.06s
> sys: 652.86s
> swapins: 81552
>
> For comparison, with just the new second chance algorithm, the build
> time is as follows:
>
> real: 244.85s
> user: 4327.22s
> sys: 664.39s
> swapins: 94663
>
> Without neither:
>
> real: 263.89s
> user: 4318.11s
> sys: 673.29s
> swapins: 227300.5
>
> (average over 5 runs)
>
> With this change, the kernel CPU time reduces by a further 1.7%, and
> the real time is reduced by another 3.3%, compared to just the second
> chance algorithm by itself. The swapins count also reduces by another
> 13.85%.
>
> Combinng the two changes, we reduce the real time by 10.32%, kernel CPU

Combining*

> time by 3%, and number of swapins by 64.12%.
>
> To gauge the new scheme's ability to offload cold data, I ran another
> benchmark, in which the kernel was built under a cgroup with memory.max
> set to 3 GB, but with 0.5 GB worth of cold data allocated before each
> build (in a shmem file).
>
> Under the old scheme:
>
> real: 197.18s
> user: 4365.08s
> sys: 289.02s
> zswpwb: 72115.2
>
> Under the new scheme:
>
> real: 195.8s
> user: 4362.25s
> sys: 290.14s
> zswpwb: 87277.8
>
> (average over 5 runs)
>
> Notice that we actually observe a 21% increase in the number of written
> back pages - so the new scheme is just as good, if not better at
> offloading pages from the zswap pool when they are cold. Build time
> reduces by around 0.7% as a result.
>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/page_io.c    | 11 ++++++++++-
>  mm/swap_state.c |  8 ++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index ff8c99ee3af7..0004c9fbf7e8 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -521,7 +521,15 @@ void swap_read_folio(struct folio *folio, struct swa=
p_iocb **plug)
>
>         if (zswap_load(folio)) {
>                 folio_unlock(folio);
> -       } else if (data_race(sis->flags & SWP_FS_OPS)) {
> +               goto finish;
> +       }
> +
> +       /*
> +        * We have to read the page from slower devices. Increase zswap p=
rotection.
> +        */

Can we fit this on a single line?

Anyway, LGTM:
Acked-by: Yosry Ahmed <yosryahmed@google.com>


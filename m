Return-Path: <linux-kernel+bounces-215620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F2909502
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9537FB20CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCD1FB4;
	Sat, 15 Jun 2024 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCo2qrEM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476C10F7
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718410806; cv=none; b=M3hatZj5rqR01pppG3opSt9X/gDVonLHNC4oQuDgRvL9ZOdMK76hPU76LLNLm49LeljqWfiFOX+jui65bhsu/srxdy++O4SBg8FqvsfufPa+/qqPreG+9O0eA5VWcs048pilyvEAY18k78qZtdH+fEpCuR5zliICyUCzewtgack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718410806; c=relaxed/simple;
	bh=RygvKJoxEF8JAtJ3lLlWfUVRrpUQj262assGYwQV07M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws6anHzcUNmVUU18/K36XK/Ns2wMVcom3btNTlhkmu430ne10g+t2RnKVRqx8/oU/S3S6hcR28lhN1QEkam3YGejOmXlQY7QSJps7NoSOXFyDdXmPenC9Wi7L9K5TXJ/1relziihn4L0Ixids5TUvnGOeIWy7IIwBjAQtQTCeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCo2qrEM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f1dc06298so341142466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718410803; x=1719015603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RygvKJoxEF8JAtJ3lLlWfUVRrpUQj262assGYwQV07M=;
        b=jCo2qrEM8sxbI9/Qf9em6yggCYhxooik1wdp68q2ZBnMi2Mmpo61OYL0MxhWIJ0lo6
         thiX+AH/6lZaL635KBNKKkPOg71ZshFlAHLJxho4OVDpAAOoqgkximaxPgZe/DYxJU9s
         b90y7NUjO7yXBuVGYgiGBj3S8VqHjr7QraaR+iwN2u1OHxESZMDMficUrm4QBuZ3YzwA
         2YrGfFj7Mha9lEQtQD0mvMFXGQ9X6Bwyee2ssaOZwujd05m6GgRsugxKZSKCZ5mI3U3y
         qUWWYsjGodVTSwdgesKmMkOD3Fw6bLr0BPsJZl85CtSFb5U/0POB+cGZRJb45j+Cv9E6
         p5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718410803; x=1719015603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RygvKJoxEF8JAtJ3lLlWfUVRrpUQj262assGYwQV07M=;
        b=I2soj0ek7e0w5DxKcy/1mB6aE8Os0XDVD3i42vzf6T1yzvPnQqRq2YqursFe/a+JOt
         9F1Ut7nPn8FplDPeI7mOvT6DQymAsIt+vAipkySAHA3r8X46Sj4S8RqkEMBso1MtpRn/
         qSrJ0s3mJHIh0aeukoUL2ygqvZi1+gq/v3ZHH2fTNx407hA06WSS+HtSNdWBoiR7mANL
         R+tOGYwQVV/twZh+Nz+k15O92tkqBWfmLcYXnYU9b7brU6jQMwnD5Zfn8q3gzyqYGusd
         SZK28OuFPKMx5Vy0oymsw9W9RWBPj25np6DOgLYK5E8llBkYQcI87y91x4vB/tZvsoDy
         9qog==
X-Forwarded-Encrypted: i=1; AJvYcCXXsQg8F2bh5yFhENoAR0OYr7TJjcHooF+vo+rjGlKbufvrj/HtRTPUylzRwXAfpF4ltdImcpT49htlvIPVQ/2wnW0cJfb7WxIHQ19x
X-Gm-Message-State: AOJu0Yy/1Og5VQ8hgq1Oc5T8pLS4fUGsaE/5Nim+oYt/LUe/Grn8g7v8
	JTuVVp5a1BcgkqqPNMCyqRx/6YkOmcI5y16/MOMP/lPb65RJVVJOujaHT/PRxmcd2hiYwotF6cx
	c7w5581rYFNvbTOU4p3bHXV4E8h2Q0rQQjI/z
X-Google-Smtp-Source: AGHT+IGzB5bijriy81AjYjCOAZe0BYsEgAEUKweu6L/T1lvt83MgTMVDacATN9iudJmEjqDpPJSX3NXIKUbXAAiBfAk=
X-Received: by 2002:a17:906:6a02:b0:a6f:5f5d:e924 with SMTP id
 a640c23a62f3a-a6f60cef67cmr330348466b.6.1718410802786; Fri, 14 Jun 2024
 17:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
 <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
In-Reply-To: <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 14 Jun 2024 17:19:24 -0700
Message-ID: <CAJD7tkYD+y54-KYEotWspRdNL_AC0SxE147tR+dSLvY-=9jJyg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:09=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B46=E6=9C=8814=E6=97=A5(=E9=87=91) 0:22 Nhat Pham <nphamcs@gma=
il.com>:
> >
> > Taking a step back from the correctness conversation, could you
> > include in the changelog of the patches and cover letter a realistic
> > scenario, along with user space-visible metrics that show (ideally all
> > 4, but at least some of the following):
> >
> > 1. A user problem (that affects performance, or usability, etc.) is hap=
pening.
> >
> > 2. The root cause is what we are trying to fix (for e.g in patch 1, we
> > are skipping over memcgs unnecessarily in the global shrinker loop).
> >
> > 3. The fix alleviates the root cause in b)
> >
> > 4. The userspace-visible problem goes away or is less serious.
> >
>
> Thank you for your suggestions.
> For quick response before submitting v2,

Thanks for all the info, this should be in the cover letter or commit
messages in some shape or form.

>
> 1.
> The visible issue is that pageout/in operations from active processes
> are slow when zswap is near its max pool size. This is particularly
> significant on small memory systems, where total swap usage exceeds
> what zswap can store. This means that old pages occupy most of the
> zswap pool space, and recent pages use swap disk directly.

This should be a transient state though, right? Once the shrinker
kicks in it should writeback the old pages and make space for the hot
ones. Which takes us to our next point.

>
> 2.
> This issue is caused by zswap keeping the pool size near 100%. Since
> the shrinker fails to shrink the pool to accept_thr_percent and zswap
> rejects incoming pages, rejection occurs more frequently than it
> should. The rejected pages are directly written to disk while zswap
> protects old pages from eviction, leading to slow pageout/in
> performance for recent pages on the swap disk.

Why is the shrinker failing? IIUC the first two patches fixes two
cases where the shrinker stumbles upon offline memcgs, or memcgs with
no zswapped pages. Are these cases common enough in your use case that
every single time the shrinker runs it hits MAX_RECLAIM_RETRIES before
putting the zswap usage below accept_thr_percent?

This would be surprising given that we should be restarting the
shrinker with every swapout attempt until we can accept pages again.

I guess one could construct a malicious case where there are some
sticky offline memcgs, and all the memcgs that actually have zswap
pages come after it in the iteration order.

Could you shed more light about this? What does the setup look like?
How many memcgs there are, how many of them use zswap, and how many
offline memcgs are you observing?

I am not saying we shouldn't fix these problems anyway, I am just
trying to understand how we got into this situation to begin with.

>
> 3.
> If the pool size were shrunk proactively, rejection by pool limit hits
> would be less likely. New incoming pages could be accepted as the pool
> gains some space in advance, while older pages are written back in the
> background. zswap would then be filled with recent pages, as expected
> in the LRU logic.

I suspect if patches 1 and 2 fix your problem, the shrinker invoked
from reclaim should be doing this sort of "proactive shrinking".

I agree that the current hysteresis around accept_thr_percent is not
good enough, but I am surprised you are hitting the pool limit if the
shrinker is being run during reclaim.

>
> Patch 1 and 2 make the shrinker reduce the pool to accept_thr_percent.
> Patch 3 makes zswap_store trigger the shrinker before reaching the max
> pool size. With this series, zswap will prepare some space to reduce
> the probability of problematic pool_limit_hit situation, thus reducing
> slow reclaim and the page priority inversion against LRU.
>
> 4.
> Once proactive shrinking reduces the pool size, pageouts complete
> instantly as long as the space prepared by shrinking can store the
> direct reclaim. If an admin sees a large pool_limit_hit, lowering
> accept_threshold_percent will improve active process performance.

I agree that proactive shrinking is preferable to waiting until we hit
pool limit, then stop taking in pages until the acceptance threshold.
I am just trying to understand whether such a proactive shrinking
mechanism will be needed if the reclaim shrinker for zswap is being
used, how the two would work together.


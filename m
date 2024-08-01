Return-Path: <linux-kernel+bounces-270671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CA94434A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D31B23974
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3501158549;
	Thu,  1 Aug 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pcT7KdP"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D761157E61
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492596; cv=none; b=IyOi48vCcdI9R1oug9+Q+xE+bs6idtoqNXw4MD3+BzAVGQ0OgNUR5E1J1s2qV8XdEdogPdKEs3OHry/87CpTpG6t/S9cr78C4BoS1C+b0dJh3cg8zZKWi8iYsoXoP8iCt6STX5bYLfH+hB/+ctkBFv0cql6de8g2AFG5l78s8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492596; c=relaxed/simple;
	bh=ZCYaZhNbPHUD/W095CYn/P5jjJNjV38dOibRmdw/NEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etD6ciTCz6zdMoXVXjJ1cR9jUuUFH3QcnUiA0MX3nuto/eLGYPZrZ4qOnVYDTJxaQzHXwIcpBPQhy9ojp8uORTGKgkSTrRyJ5DTuKvGb+Ce6/rzV0M+caZczcKNqMTRIteKccLYLbLEyXeRyATftAH2hqb+MxlQbU90RM2dK+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pcT7KdP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fdc70e695so752871cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722492594; x=1723097394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Eg+RUP9iU4Lo9A3KNo9HLoGW6thPDnN1L6pmuhPpEY=;
        b=1pcT7KdPBROCQz8t4WQ0TOWuAu/ISGbGJzSGLpPdTtk6LR09Py3Zk50lJXGW5i08LE
         NVZx/9BUyAAQhBVR4WLo8fhO/0SamYeKRaDv9xlbxpuyBt0CJo3MUKwLsrrCKXpKLWFz
         1fnjtMDviaZd+1wOKs16C+9PO3dIvWefOT2lZ8pzewRfmKiP1B5Wa+JR2+FdctDtx76a
         yNvJIoJdjy4SS8gRKfeEkjNNdQKHuZyuAE63V4EuhaVyOvao64zxds23LMo+PpyREvj1
         sl8qU2UQZhHxxq1Rd1p14wheVYUQwG+DsbT3C2eJn9U/v3xTQXf7sE6zCuLqI1Rn+8vg
         o9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492594; x=1723097394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Eg+RUP9iU4Lo9A3KNo9HLoGW6thPDnN1L6pmuhPpEY=;
        b=IybiVLbaCoe8G+rBkmItX2FCx5GXCE0/WqcI+LUmze3pdsB5MAuImqP6Jv0XzKSpsx
         VSSnlQPn6j7ShqWj14rxnU2sh98TngGv+qaqIWy2N0gbgkgr5vNza4lUHRuq/YlB54WN
         5ooYA7lTycueZZ7v5loJ32JdqDp2dRXfBiFiDSwpGq4eEqjPif11VM8L7YMm57KJjjL1
         PXYNGv921eZbJ3cIC9HGqlXV7w3h1P9zzreezNW7fHZcvRLw/yy1cBzP1nGg5lzUqCnc
         Sj+HIeTMYZbmfuWBMV0jH887lgt6pV4WxSFMBVEQsP+8IRm3fIFoZxEXglD4EtqYDaVk
         8O5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyRtTskZhCr/SMWANTIKnoFxtvLdvChtPZJNnQCK0r5ZH92Q+Xt+z18rkSCOJp/Tf8z5crcGQkqxPvOgujDJ34uWRNYqWeVpzp1K19
X-Gm-Message-State: AOJu0YwZ5Bx6Rk9+GGYt6RKtHEr16EHOPlH5trsFT1MoxRgl4xcVeBKI
	pZnpJBsQwIB12WAFWTX5tuf4SJeeSSgpwEwsAuXi082lmKO2G70IV4bjDjupzssg0nG7jH0aVky
	96nWmyJiqS14b3EmyuBjh5ewB56Pf7kD0ccor
X-Google-Smtp-Source: AGHT+IE32QTSyXkgVRiA98YySoDS2GugHQvPGGCTz+jLkfFLBYvzI9l2JDRt7v8P/NPfxMKkZ2qSPwQZMxJetASvTrQ=
X-Received: by 2002:a05:622a:1a9e:b0:447:ed90:7396 with SMTP id
 d75a77b69052e-45180b4b862mr1352661cf.24.1722492593997; Wed, 31 Jul 2024
 23:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
In-Reply-To: <20240730125346.1580150-1-usamaarif642@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 1 Aug 2024 00:09:16 -0600
Message-ID: <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:54=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> The current upstream default policy for THP is always. However, Meta
> uses madvise in production as the current THP=3Dalways policy vastly
> overprovisions THPs in sparsely accessed memory areas, resulting in
> excessive memory pressure and premature OOM killing.
> Using madvise + relying on khugepaged has certain drawbacks over
> THP=3Dalways. Using madvise hints mean THPs aren't "transparent" and
> require userspace changes. Waiting for khugepaged to scan memory and
> collapse pages into THP can be slow and unpredictable in terms of perform=
ance
> (i.e. you dont know when the collapse will happen), while production
> environments require predictable performance. If there is enough memory
> available, its better for both performance and predictability to have
> a THP from fault time, i.e. THP=3Dalways rather than wait for khugepaged
> to collapse it, and deal with sparsely populated THPs when the system is
> running out of memory.
>
> This patch-series is an attempt to mitigate the issue of running out of
> memory when THP is always enabled. During runtime whenever a THP is being
> faulted in or collapsed by khugepaged, the THP is added to a list.
> Whenever memory reclaim happens, the kernel runs the deferred_split
> shrinker which goes through the list and checks if the THP was underutili=
zed,
> i.e. how many of the base 4K pages of the entire THP were zero-filled.
> If this number goes above a certain threshold, the shrinker will attempt
> to split that THP. Then at remap time, the pages that were zero-filled ar=
e
> not remapped, hence saving memory. This method avoids the downside of
> wasting memory in areas where THP is sparsely filled when THP is always
> enabled, while still providing the upside THPs like reduced TLB misses wi=
thout
> having to use madvise.
>
> Meta production workloads that were CPU bound (>99% CPU utilzation) were
> tested with THP shrinker. The results after 2 hours are as follows:
>
>                             | THP=3Dmadvise |  THP=3Dalways   | THP=3Dalw=
ays
>                             |             |               | + shrinker se=
ries
>                             |             |               | + max_ptes_no=
ne=3D409
> -------------------------------------------------------------------------=
----
> Performance improvement     |      -      |    +1.8%      |     +1.7%
> (over THP=3Dmadvise)          |             |               |
> -------------------------------------------------------------------------=
----
> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4=
%)
> -------------------------------------------------------------------------=
----
> max_ptes_none=3D409 means that any THP that has more than 409 out of 512
> (80%) zero filled filled pages will be split.
>
> To test out the patches, the below commands without the shrinker will
> invoke OOM killer immediately and kill stress, but will not fail with
> the shrinker:
>
> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
> mkdir /sys/fs/cgroup/test
> echo $$ > /sys/fs/cgroup/test/cgroup.procs
> echo 20M > /sys/fs/cgroup/test/memory.max
> echo 0 > /sys/fs/cgroup/test/memory.swap.max
> # allocate twice memory.max for each stress worker and touch 40/512 of
> # each THP, i.e. vm-stride 50K.
> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
> # killer.
> # Without the shrinker, OOM killer is invoked immediately irrespective
> # of max_ptes_none value and kill stress.
> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>
> Patches 1-2 add back helper functions that were previously removed
> to operate on page lists (needed by patch 3).
> Patch 3 is an optimization to free zapped tail pages rather than
> waiting for page reclaim or migration.
> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
> subpages when splitting THP.
> Patches 6 adds support for THP shrinker.
>
> (This patch-series restarts the work on having a THP shrinker in kernel
> originally done in
> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
> The THP shrinker in this series is significantly different than the
> original one, hence its labelled v1 (although the prerequisite to not
> remap clean subpages is the same).)
>
> Alexander Zhu (1):
>   mm: add selftests to split_huge_page() to verify unmap/zap of zero
>     pages
>
> Usama Arif (3):
>   Revert "memcg: remove mem_cgroup_uncharge_list()"
>   Revert "mm: remove free_unref_page_list()"
>   mm: split underutilized THPs
>
> Yu Zhao (2):
>   mm: free zapped tail pages when splitting isolated thp
>   mm: don't remap unused subpages when splitting isolated thp

 I would recommend shatter [1] instead of splitting so that
1) whoever underutilized their THPs get punished for the overhead;
2) underutilized THPs are kept intact and can be reused by others.

[1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/


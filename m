Return-Path: <linux-kernel+bounces-274041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3321D9471C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD96A281078
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90B13B59B;
	Sun,  4 Aug 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCpsn69Z"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808681ABED7
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814372; cv=none; b=HRE3jRY4nnrfHdHFUiC+XttN5QpMYEnEC9dCXIzWgPLqgCzJT02B5pg0EioNjZtH9TY/bHUiTQtsiRUEitaFesU2bvPha2QyzmxrPlgpxixrVdzoeoaMT7jga8ih+T5rU9V84NlyWSPhtuUAzUJq0dJPy5Csk2FhPTn8D2bYv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814372; c=relaxed/simple;
	bh=4LsECHc/bktRLSi/DL22ioxom+yXcnQxd04edAID2s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JL7ZmH9SbSArlkD53wrMF8aOwSDge6TJ0KnE06HcXPsMOMTug3mQEKR03/5ilLyFEGhQSrvp8aiZSOplKZu3tMjWSBG7/mpEe+fLlCbxLbwNhEegbTEbTr5kgKrhUihjLq/VqMFRmWf2iuKn1GRuBgdSXIjERST4ARaIvzTx7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCpsn69Z; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45029af1408so206551cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722814369; x=1723419169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSWV9wI/F0Nu15VWZNLks89MmE9d/uq9S3n4nyNsYwA=;
        b=jCpsn69ZznwsIMXKjUMNPa5xK6odNxMKwCXMIzytkKUV+FrYvryvgcSfOuo3t4dd+Y
         NMnBIwNau/2Dtv/qMG/R6yyqLL0w5PF91N+BUIK16S9Vqmc6Kl7HOtiEIwPeZqaTQJo9
         l6oCXcEPf+1CipNSknqn53JSdQS3DbEZjguTUKSQgGeqvx4CHYRhEJA6v+ijufGmLFgo
         nAOgzc0y1pQkNFtA5EH1PvOLYNlcC/g6CQEAlfujjDqBH3pj794JmEJ/TnziXSZ//Cgc
         zVtiQLmi4doEpBcboJmsmG2GNTgZDnmVE6wuiSoCyn7B98gZTf4Aeu2i466Bv0fBTqA5
         MNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722814369; x=1723419169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSWV9wI/F0Nu15VWZNLks89MmE9d/uq9S3n4nyNsYwA=;
        b=fiZA6oNrGigTY0uNSRenMARRi1xo3luWS3Gkj0KSwt/42GuCVWNjp3P5sElM08cQ5w
         ofcU3cnu0GuDK3pZ+l116j2UEa3uiF/hDjCKcvWk6H3qdQjQcv5t6blFxQCBZZOvrPu7
         NIvNv1oicMtR1ZmKkSNFWRgKRs3H1830vndYE5b8VtrX++jF3srq1WltLZg63xU3bz7E
         0OTO+fkfiyGPMSmaEC7dYobLTUtKBaT0/kp6/LvQycsAUD2511Q9mGf1LSbvCEeW4Caa
         hJC5k22MNchav1ZJhg8/id+zFvg0f8cxhTAiZhabpa5C9Hc5nx3DGG5p64E+gL7g+QQv
         32zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJtQJGxcmPrnmcVbzd44g4pM0X9RpfJ94PfIa/OjI8LIIp8PRIkDhzfJAfczC6e2dIsFhlS8DX5kWIuTQqOl2fh5Revfq9vsHbN/iy
X-Gm-Message-State: AOJu0YwgITnpqWDQ3jPSzxWNB/kwBFC9C1KfqhLqkxJePfrc8j0Wkc2c
	BJHJxuvDLZ54i7GBhQ6FrL+qYhtcODzvg2ggkBTX2MwH2GPB+XFNEV9b1UnW17WPiLKLrs9HLnj
	BWrk/d3/zoJObwxE8Oocwp6Cy17/pUdJZcZDd
X-Google-Smtp-Source: AGHT+IEKdwDaVjjqnObnyYMP24sqgkjO6Jq8MKGY9wblctbckt6KWnjz0IRuV6kc/xAQ9GsHiF+mdFc3dQgN0OWF/nI=
X-Received: by 2002:a05:622a:18a2:b0:447:e0a6:9163 with SMTP id
 d75a77b69052e-4519ad1cf8bmr3137471cf.14.1722814369217; Sun, 04 Aug 2024
 16:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
 <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com> <524fb638-73b2-45e7-ae2c-7445d394ed50@redhat.com>
In-Reply-To: <524fb638-73b2-45e7-ae2c-7445d394ed50@redhat.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 4 Aug 2024 17:32:12 -0600
Message-ID: <CAOUHufZHpoeuMQ95-RPvtyHZ_4WQj6Sn2quv=gN5emtD1e3MmA@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, baohua@kernel.org, ryan.roberts@arm.com, 
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:27=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 01.08.24 18:22, Usama Arif wrote:
> >
> >
> > On 01/08/2024 07:09, Yu Zhao wrote:
> >> On Tue, Jul 30, 2024 at 6:54=E2=80=AFAM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>>
> >>> The current upstream default policy for THP is always. However, Meta
> >>> uses madvise in production as the current THP=3Dalways policy vastly
> >>> overprovisions THPs in sparsely accessed memory areas, resulting in
> >>> excessive memory pressure and premature OOM killing.
> >>> Using madvise + relying on khugepaged has certain drawbacks over
> >>> THP=3Dalways. Using madvise hints mean THPs aren't "transparent" and
> >>> require userspace changes. Waiting for khugepaged to scan memory and
> >>> collapse pages into THP can be slow and unpredictable in terms of per=
formance
> >>> (i.e. you dont know when the collapse will happen), while production
> >>> environments require predictable performance. If there is enough memo=
ry
> >>> available, its better for both performance and predictability to have
> >>> a THP from fault time, i.e. THP=3Dalways rather than wait for khugepa=
ged
> >>> to collapse it, and deal with sparsely populated THPs when the system=
 is
> >>> running out of memory.
> >>>
> >>> This patch-series is an attempt to mitigate the issue of running out =
of
> >>> memory when THP is always enabled. During runtime whenever a THP is b=
eing
> >>> faulted in or collapsed by khugepaged, the THP is added to a list.
> >>> Whenever memory reclaim happens, the kernel runs the deferred_split
> >>> shrinker which goes through the list and checks if the THP was underu=
tilized,
> >>> i.e. how many of the base 4K pages of the entire THP were zero-filled=
.
> >>> If this number goes above a certain threshold, the shrinker will atte=
mpt
> >>> to split that THP. Then at remap time, the pages that were zero-fille=
d are
> >>> not remapped, hence saving memory. This method avoids the downside of
> >>> wasting memory in areas where THP is sparsely filled when THP is alwa=
ys
> >>> enabled, while still providing the upside THPs like reduced TLB misse=
s without
> >>> having to use madvise.
> >>>
> >>> Meta production workloads that were CPU bound (>99% CPU utilzation) w=
ere
> >>> tested with THP shrinker. The results after 2 hours are as follows:
> >>>
> >>>                              | THP=3Dmadvise |  THP=3Dalways   | THP=
=3Dalways
> >>>                              |             |               | + shrink=
er series
> >>>                              |             |               | + max_pt=
es_none=3D409
> >>> ---------------------------------------------------------------------=
--------
> >>> Performance improvement     |      -      |    +1.8%      |     +1.7%
> >>> (over THP=3Dmadvise)          |             |               |
> >>> ---------------------------------------------------------------------=
--------
> >>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (=
+2.4%)
> >>> ---------------------------------------------------------------------=
--------
> >>> max_ptes_none=3D409 means that any THP that has more than 409 out of =
512
> >>> (80%) zero filled filled pages will be split.
> >>>
> >>> To test out the patches, the below commands without the shrinker will
> >>> invoke OOM killer immediately and kill stress, but will not fail with
> >>> the shrinker:
> >>>
> >>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_no=
ne
> >>> mkdir /sys/fs/cgroup/test
> >>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
> >>> echo 20M > /sys/fs/cgroup/test/memory.max
> >>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
> >>> # allocate twice memory.max for each stress worker and touch 40/512 o=
f
> >>> # each THP, i.e. vm-stride 50K.
> >>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
> >>> # killer.
> >>> # Without the shrinker, OOM killer is invoked immediately irrespectiv=
e
> >>> # of max_ptes_none value and kill stress.
> >>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
> >>>
> >>> Patches 1-2 add back helper functions that were previously removed
> >>> to operate on page lists (needed by patch 3).
> >>> Patch 3 is an optimization to free zapped tail pages rather than
> >>> waiting for page reclaim or migration.
> >>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
> >>> subpages when splitting THP.
> >>> Patches 6 adds support for THP shrinker.
> >>>
> >>> (This patch-series restarts the work on having a THP shrinker in kern=
el
> >>> originally done in
> >>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
> >>> The THP shrinker in this series is significantly different than the
> >>> original one, hence its labelled v1 (although the prerequisite to not
> >>> remap clean subpages is the same).)
> >>>
> >>> Alexander Zhu (1):
> >>>    mm: add selftests to split_huge_page() to verify unmap/zap of zero
> >>>      pages
> >>>
> >>> Usama Arif (3):
> >>>    Revert "memcg: remove mem_cgroup_uncharge_list()"
> >>>    Revert "mm: remove free_unref_page_list()"
> >>>    mm: split underutilized THPs
> >>>
> >>> Yu Zhao (2):
> >>>    mm: free zapped tail pages when splitting isolated thp
> >>>    mm: don't remap unused subpages when splitting isolated thp
> >>
> >>   I would recommend shatter [1] instead of splitting so that
> >> 1) whoever underutilized their THPs get punished for the overhead;
> >> 2) underutilized THPs are kept intact and can be reused by others.
> >>
> >> [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com=
/
> >
> > The objective of this series is to reduce memory usage, while trying to=
 keep the performance benefits you get of using THP=3Dalways. Punishing any=
 applications performance is the opposite of what I am trying to do here.
> > For e.g. if there is only one main application running in production, a=
nd its using majority of the THPs, then reducing its performance doesn't ma=
ke sense.
> >
>
> I'm not sure if there would really be a performance degradation
> regarding the THP, after all we zap PTEs either way.
>
> Shattering will take longer because real migration is involved IIUC.

Correct, and that's by design. Also using it in the THP shrinker path
isn't a problem.

> > Also, just going through the commit, and found the line "The advantage =
of shattering is that it keeps the original THP intact" a bit confusing. I =
am guessing the THP is freed? i.e. if a 2M THP has 10 non-zero filled base =
pages and the rest are zero-filled, then after shattering we will have 10*4=
K memory and not 2M+10*4K? Is it the case the THP is reused at next fault?
>
> The idea is (as I understand it) to free the full THP abck to the buddy,
> replacing the individual pieces that are kept to freshly allocated
> order-0 pages from the buddy.

Correct, and this is essential to our problem: we are under memory
pressure with THP=3Dalways. Under this condition, we need to compare
shatter with split + compaction, not with split alone.

To summarize, the ideal use cases are:
1. split for THP=3Dalways with unlimited memory.
2. shatter for THP=3Dalways under memory pressure.


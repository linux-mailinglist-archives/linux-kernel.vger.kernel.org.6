Return-Path: <linux-kernel+bounces-213919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ABA907C92
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9832867A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09A14C5A7;
	Thu, 13 Jun 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR9UE3c8"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EC14B064
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306843; cv=none; b=ikKhilDvadFygrZU8D/4ZVstqlJWyP56gKY/o9N+R3YUptB4mmeO4TiRHMlaqqBX+RngVxDr342CGdyD0ZXsAf0ittAoJa7SWMURsZlTLIV0rpw6Z8zkgVp8QnCgth3l3qmYTky2QQNNpahm/YIVQm6IrsKSqOrucTEi4VEVMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306843; c=relaxed/simple;
	bh=aWiMV0maMST9mAtcuABqe98mSv6TTyx4EbJhK7U/dVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIZ4aH96+uru6gzNI2k7B9dFkWu/y2hpil/xE+T6lJCapWnt+oICh32PqRDmkeCk/LgOE7ZfT6tprKSf4CMVsxcs7KzkMZEzX/LG2PTiMKM/lrhoXMs45JhYKCyhO+6UEEb25FcCVve25oW0d4ASDrPDodTJQ3aNOnjLkaQWXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AR9UE3c8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c8342af5eso1574702e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718306840; x=1718911640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9orlxNKn/9JVZXU5e2lmdZ8oEkBOmdjYH2JldRLXf8=;
        b=AR9UE3c8XbXj2nC0MkClzj+yF+BTNkmtHZvXPo+ZbLkCRiy9165wtBG3QVM5IlCGwZ
         Vas1iaM3xXPxPU0grt/G2eVujRrDBLd6VzZbn2tLZ47WNI5SZngLrgJK/gxMV4dDoHi7
         cpCsvMepgC4ku+Hop39PotA7v0J+Gy1r80JtRx4mJHnV3B9YwiNgvtHo0GFfCsDMkBl0
         bAXCbupO4SkF+SrbpXZnts3xp5sFNAImlvxwRkXXQehbL0XYoUks2pKjnFrMVo6MW5Tq
         6nud7NX2IXIdKGWBVpJGfuWo0vFakT5j+7oCkS2RpnD9LSJtKFhb1xJn28OnWkKzs00J
         akHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306840; x=1718911640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9orlxNKn/9JVZXU5e2lmdZ8oEkBOmdjYH2JldRLXf8=;
        b=HVkkZjr86ad7nZqIyeANu7NMI56j0ybYTH3sFpsLCj0KI5T506CFFU0YaYkVqHsOA5
         96fSv7HiDjgQ6nNqzVwsApkmZG9zcC0iJ0E1YCagl0w+7CkV2Yx7PhLdST8KPZY8qWOM
         hSYEpfhGkwh3o663UMT0WJ6pgJ5JjVDqK+U2JuUkBAfnqUnCKqgjynVl11OhUw000cjR
         hU3M45lqjjoZJ3oQXvzkw7BVND25lAr91WIWLt6BjoFdmqqCLhOS7x19Z0cMXxd15QzR
         ruhAtCF0X1NPPePGb3TAkGyxcfRZJ+ucT8fYRH+w29uszm3jEc+epxezoB3f4TdWoexh
         40wA==
X-Forwarded-Encrypted: i=1; AJvYcCWXDiNWpjJK9tVVCTNIAEKGEmHLDk10KTTdqnoyDsxZD2SD/x0vGtFNJ+5dY+fQOc/NBSVywRqKdZlodUCPUIwZss0UF6Su3GDEyzoD
X-Gm-Message-State: AOJu0YyYVLZpmAgH6Fx1Bi0eNLQI6dRaCybHsPLSlZC+hGgPvO8tHKo3
	0Ql6hMzEaHduboITsOBq0PcMZd3BqL1BcvMe32mak4YzYJcdTLq0xT5O6HApXoyaNjFBtGgqlrn
	EDxg7TnnF4KUepaZwFik0Q8dG1REiTHagbT1o
X-Google-Smtp-Source: AGHT+IGzN6TmSH1p6vXFvV8Km9FazTBEXlJalb8xYy/AJ+qb/Mo1wKanhXT9P+WqKg+UjLbGK6D2OeLnBXEtlJDXYHQ=
X-Received: by 2002:a05:6512:130e:b0:52c:8f4a:9200 with SMTP id
 2adb3069b0e04-52ca6e9897emr543765e87.65.1718306839832; Thu, 13 Jun 2024
 12:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-1-usamaarif642@gmail.com>
 <20240612124750.2220726-2-usamaarif642@gmail.com> <ZmoBf6RPJzC2RaqM@google.com>
 <85804484-9973-41a1-a05d-000833285f39@gmail.com> <CAJD7tkYBxN4uAHLacAx=m2+B9zPidz0V5pGP030yvNYLTnk=VQ@mail.gmail.com>
 <0572d8b1-3b17-45a8-bf75-f66e19216d38@gmail.com>
In-Reply-To: <0572d8b1-3b17-45a8-bf75-f66e19216d38@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 13 Jun 2024 12:26:42 -0700
Message-ID: <CAJD7tkYGFsYbbbHp3+MMHTuxNcG_Z+i-5TCo3wieVArcra5wmA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[..]
> >>>> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
> >>>>               __free_cluster(si, idx);
> >>>>               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >>>>                               0, SWAPFILE_CLUSTER);
> >>>> +            for (i = 0; i < SWAPFILE_CLUSTER; i++)
> >>>> +                    clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> >>> Same here. I didn't look into the specific code paths, but shouldn't the
> >>> cluster be unused (and hence its zeromap bits already cleared?).
> >>>
> >> I think this one is needed (or atleast very good to have). There are 2
> >> paths:
> >>
> >> 1) swap_cluster_schedule_discard (clears zeromap) -> swap_discard_work
> >> -> swap_do_scheduled_discard (clears zeromap)
> >>
> >> Path 1 doesnt need it as swap_cluster_schedule_discard already clears it.
> >>
> >> 2) scan_swap_map_slots -> scan_swap_map_try_ssd_cluster ->
> >> swap_do_scheduled_discard (clears zeromap)
> >>
> >> Path 2 might need it as zeromap isnt cleared earlier I believe
> >> (eventhough I think it might already be 0).
> > Aren't the clusters in the discard list free by definition? It seems
> > like we add a cluster there from swap_cluster_schedule_discard(),
> > which we establish above that it gets called on a free cluster, right?
>
> You mean for path 2? Its not from swap_cluster_schedule_discard. The
> whole call path is
>
> get_swap_pages -> scan_swap_map_slots -> scan_swap_map_try_ssd_cluster
> -> swap_do_scheduled_discard. Nowhere up until swap_do_scheduled_discard
> was the zeromap cleared, which is why I think we should add it here.

swap_do_scheduled_discard() iterates over clusters from
si->discard_clusters. Clusters are added to that list from
swap_cluster_schedule_discard().

IOW, swap_cluster_schedule_discard() schedules freed clusters to be
discarded, and swap_do_scheduled_discard() later does the actual
discarding, whether it's through si->discard_work scheduled by
swap_cluster_schedule_discard(), or when looking for a free cluster
through scan_swap_map_try_ssd_cluster().

Did I miss anything?


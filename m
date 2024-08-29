Return-Path: <linux-kernel+bounces-306684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4849964216
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2431F255F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C428F18D622;
	Thu, 29 Aug 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CWKcahTS"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B418C03D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927842; cv=none; b=BupvZwIxXsViitiWMJ762tAiMgBAEQkjPLIvAVN73leqBhjZe3MRJSAneeXx8gDJITFc/VvMQYlonHyUs1hrD3N9zdFWKFcwCpBa7KcGib4DEB8jwVCJ8h1HQtG9ZOgGY8rDyDQTXoKB1pLc+0DH4CVG12U8OdP+oeIKQUcsXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927842; c=relaxed/simple;
	bh=GXWXD2pdtb5gilgQbRoPiB3RjJo9P9fNyjbYYg1ldxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRNz1/C7vf4S6irknZVyGtbbjEjdPR6BrUvtFSd8r3s3lAzMg3Sul8TflAP1cviq4jPSaOMLW1sSsHp+XkjnEG/b/dxJ6Mx91H6LK6gM3fpIs/4vlIbRb9YMU7ih3Lu69nc58QSIv3YiYINtAdhyDAIR/xqsLHHljOjxO32KxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CWKcahTS; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d311d8091so1401205ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724927839; x=1725532639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6dBWYjdhc8JKZrKU+HUoYifjEEos8EjaEuP88HTkb4=;
        b=CWKcahTSQwItBENVuHHNZjRKrTCC7xEYuX7imo6tXndJxFEBPWzltr9ItWNgonCrhK
         Voe3+SgsiBeo72GRkRdafKmsA6PTKX0bZ5xclT2vwomt5TkHQuOPxGJBFF8H+0YrT1UU
         HqCf1dK/XTKRxrvLnvdfLmFNf/DXNrCz8eYZJbC1PefHzIkCDBjf3xXjO8liMU+x9Nk1
         F2ZHh0fDn8PLR75DZhY5776EsUV0Bk1lWFI9k0D86+opNjYVZEOgwAoTRuqkrBiLPumo
         RRtGOYb0aOmrLNcF44bD7rvTPoDLw00UzBt8WSMhGqC22yhlAeO594PNa0A7x9YZGJHx
         yzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927839; x=1725532639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6dBWYjdhc8JKZrKU+HUoYifjEEos8EjaEuP88HTkb4=;
        b=hp97kDFOwOC5uq0+TdN1SFQl+3yMKc5UjLb22GjCMVd6ZpO6y/Lu7puYzIjL0sfb77
         Ozkqr27LbqJ44y/LJ1FTIYIpBQJ8wtX1yDKERHo8m4tSJOpsk4tq4uHAXGAfnXhwZd06
         mhREf3QWlE90qKIscfgclKiyxJ+s1LTfKo2d5NxhWHsq/fhMRu4A00Awkmu+vczyLm5v
         OSCf/jUBT5RCZspuxcZM+lWOIRLZgORPDnZlGCBjWTanBc4rJmyfLlAl/U5cv+EuQ0K3
         wR2rvQQjxwtYxIjDf4DtBSuzjspXd9bwvswCAUxQo120QjvBWwsPhGlRY10X5j3HKDWu
         Tcvw==
X-Forwarded-Encrypted: i=1; AJvYcCXQOFQXHtX+tc564p5+ElTpkhSytQQr1p0AOY8LSUskKn0tBmlfSt8nykw31cyrGQwIPeDuaku4pOKFCQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmmWLiL91sW0krsXYLpA0T4S/jzkxauwgEgzOHocMOsc4DXhz
	GZUMeuxLWuTtiGTWpibQODwZ3Z7Uza73skFv9NPKuXFSU8yoxnKLSxjks/ITuIICajQiNfVFlef
	gyVymtXc02Yd3Ep7WiMVQJj7u/Q1FOb+/efgh7A==
X-Google-Smtp-Source: AGHT+IGb/XrPLIB/LK0JZNhCqY5B5RcuS43kJMkiB5TSE+YYLuclD7Q5v88w7T+ANquLVGQBCNYWtdASS4S3joslXGg=
X-Received: by 2002:a05:6e02:1d17:b0:39d:2e35:4d8a with SMTP id
 e9e14a558f8ab-39f377ea4a0mr30427015ab.10.1724927839442; Thu, 29 Aug 2024
 03:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com> <ZtBMO1owCU3XmagV@tiehlicka>
In-Reply-To: <ZtBMO1owCU3XmagV@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 29 Aug 2024 18:37:07 +0800
Message-ID: <CACSyD1Ok62n-SF8fGrDQq_JC4SUSvFb-6QjgjnkD9=JacCJiYg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/2] Add disable_unmap_file arg to memory.reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, lizefan.x@bytedance.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:24=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 29-08-24 18:19:16, Zhongkun He wrote:
> > This patch proposes augmenting the memory.reclaim interface with a
> > disable_unmap_file argument that will skip the mapped pages in
> > that reclaim attempt.
> >
> > For example:
> >
> > echo "2M disable_unmap_file" > /sys/fs/cgroup/test/memory.reclaim
> >
> > will perform reclaim on the test cgroup with no mapped file page.
> >
> > The memory.reclaim is a useful interface. We can carry out proactive
> > memory reclaim in the user space, which can increase the utilization
> > rate of memory.
> >
> > In the actual usage scenarios, we found that when there are sufficient
> > anonymous pages, mapped file pages with a relatively small proportion
> > would still be reclaimed. This is likely to cause an increase in
> > refaults and an increase in task delay, because mapped file pages
> > usually include important executable codes, data, and shared libraries,
> > etc. According to the verified situation, if we can skip this part of
> > the memory, the task delay will be reduced.
>
> Do you have examples of workloads where this is demonstrably helps and
> cannot be tuned via swappiness?

Sorry, I put the test workload in the second patch. Please have a look.

Even if there are sufficient anonymous pages and a small number of
page cache and mapped file pages, mapped file pages will still be reclaimed=
.
Here is an example of anonymous pages being sufficient but mapped
file pages still being reclaimed:

Swappiness has been set to the maximum value.

cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 3406462976
file 332967936
file_mapped 300302336

echo 1g > memory.reclaim swappiness=3D200 > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 2613276672
file 52523008
file_mapped 30982144

echo 1g > memory.reclaim swappiness=3D200 > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 1552130048
file 39759872
file_mapped 20299776

With this patch, the file_mapped pages will be skipped.

echo 1g > memory.reclaim swappiness=3D200 disable_unmap_file  > memory.recl=
aim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 480059392
file 37978112
file_mapped 20299776



> --
> Michal Hocko
> SUSE Labs


Return-Path: <linux-kernel+bounces-206636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8746900C2D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB27B1C20A4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAEE1514F9;
	Fri,  7 Jun 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQU4aeez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4B14F13C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786640; cv=none; b=kF+BzdlurioEnS/KkolYtKGgvXNZf0ssYF+dc/YMN1VuYj6+XYXZleSPud789XI2hYtESi034UH60+3lv74s8+iBNWuJbHFoCytRcurQFjc9STH3T3zpMgPbrgKcYqZRM1V+tYIhyPSU9hF0xBDg8j3R48l8UxkPamSKO96diEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786640; c=relaxed/simple;
	bh=vCffEC+1ruz2xo3j/grqIKpXf5Rl3QUpvDmpiZ3G/NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZJxQJOQS4uNX7PjXEYR8wFQOri/nFgZFbmlEuan19Y35jcXh35BlyFZEZVzmFKpfcB4EHnP1bC9cESmOlrvCRbf+cPcrVjUDg55/8+Lj3SJTaqU+cg39KiaFcYsSimUQoj419zgXrxuHewSkolyecrHz1ml9CscMn2algkzwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQU4aeez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE25C32781
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717786640;
	bh=vCffEC+1ruz2xo3j/grqIKpXf5Rl3QUpvDmpiZ3G/NA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KQU4aeezHDUG6VjvFdMnzRL5XyBRjuLRB3oct4w8tA/uN2FJCkwM9g2dAOan9Mzc0
	 8oEFcNHCicDvGcy3SAyRk7i9Y3w43+EJJsZTXrJYQiiMh8tNFknf54Tmas7qwsCKMr
	 Is6TUFJQnLk2fpOR01jtZP869kYjPsrAn2Awlecgz+FT5cQa+0pAmgg6qU3chdGHuU
	 eigk+B5vU+UyXO3anaTFTPgFIDj0hszzEA0oKyzUvB53HS8P2bGvXaP8ZLHH8f6vOp
	 atULVyYtivxYfTr0oIIKPJE+OSffvIj9JXiOUQbMvKJDDFqONyT/nicnRfksQR4HhS
	 cgUuJAKGX9oUw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebd421a931so361871fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:57:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQgGQduJkANFrbIIQotnE6GrMhDA8p0g+osZNIo0/MnlfS8DbqoBscYhv/WnzDXXHmq3KM9iJdGu1wjszfWGHxt6KF/0Nlx/6tz/9B
X-Gm-Message-State: AOJu0Yzu5+dhbAtecCYQxouKBq1ZyE26fMn5XAwmzgr35o7QsuatvD7Q
	WroNyndvvM8io8h7wG8QXsiwn0DgfDyLgcqwLbfuRZaa/yHS+hvF0MwI7nv3T65ul9Xejz+mpKp
	z8nMPt/Bv1dYgcKM7GCa8nfCstQ==
X-Google-Smtp-Source: AGHT+IEQKSS2CPmzfTdd5Yf2gPBipJrOg/ZCeZ/GmQQOmd9WZEutosiOURdu6va53khJz8qsGR7qZIQYO4YfnJZ9BP0=
X-Received: by 2002:a2e:8705:0:b0:2ea:f719:317b with SMTP id
 38308e7fff4ca-2eaf7287c04mr7026531fa.3.1717786638880; Fri, 07 Jun 2024
 11:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <CAGsJ_4y1L5uA6twjjJSs3bYhFc-Urr1oUWb0Q8f3cczgbqyBMA@mail.gmail.com> <ffafe1b9-352c-4115-9e2d-c91ba93c9cb8@arm.com>
In-Reply-To: <ffafe1b9-352c-4115-9e2d-c91ba93c9cb8@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 7 Jun 2024 11:57:05 -0700
X-Gmail-Original-Message-ID: <CANeU7QkDOK_yzsQ3+NA5yd41CD030W5QLD4w4_ok3SptQdK23Q@mail.gmail.com>
Message-ID: <CANeU7QkDOK_yzsQ3+NA5yd41CD030W5QLD4w4_ok3SptQdK23Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 3:49=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 30/05/2024 08:49, Barry Song wrote:
> > On Wed, May 29, 2024 at 9:04=E2=80=AFAM Chris Li <chrisl@kernel.org> wr=
ote:
> >>
> >> I am spinning a new version for this series to address two issues
> >> found in this series:
> >>
> >> 1) Oppo discovered a bug in the following line:
> >> +               ci =3D si->cluster_info + tmp;
> >> Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
> >> That is a serious bug but trivial to fix.
> >>
> >> 2) order 0 allocation currently blindly scans swap_map disregarding
> >> the cluster->order. Given enough order 0 swap allocations(close to the
> >> swap file size) the order 0 allocation head will eventually sweep
> >> across the whole swapfile and destroy other cluster order allocations.
> >>
> >> The short term fix is just skipping clusters that are already assigned
> >> to higher orders.
> >>
> >> In the long term, I want to unify the non-SSD to use clusters for
> >> locking and allocations as well, just try to follow the last
> >> allocation (less seeking) as much as possible.
> >
> > Hi Chris,
> >
> > I am sharing some new test results with you. This time, we used two
> > zRAM devices by modifying get_swap_pages().
> >
> > zram0 -> dedicated for order-0 swpout
> > zram1 -> dedicated for order-4 swpout
> >
> > We allocate a generous amount of space for zRAM1 to ensure it never get=
s full
> > and always has ample free space. However, we found that Ryan's approach
> > does not perform well even in this straightforward scenario. Despite zR=
AM1
> > having 80% of its space remaining, we still experience issues obtaining
> > contiguous swap slots and encounter a high swpout_fallback ratio.
> >
> > Sorry for the report, Ryan :-)
>
> No problem; clearly it needs to be fixed, and I'll help where I can. I'm =
pretty
> sure that this is due to fragmentation preventing clusters from being fre=
ed back
> to the free list.
>
> >
> > In contrast, with your patch, we consistently see the thp_swpout_fallba=
ck ratio
> > at 0%, indicating a significant improvement in the situation.
>
> Unless I've misunderstood something critical, Chris's change is just allo=
wing a
> cpu to steal a block from another cpu's current cluster for that order. S=
o it

No, that is not the main change. The main change is to allow the CPU
to allocate from the nonfull and non-empty cluster, which are not in
any CPU's current cluster, not in the empty list either. The current
patch does not prevent the CPU from stealing from the other CPU
current order. It will get addressed in V2.

> just takes longer (approx by a factor of the number of cpus in the system=
) to
> get to the state where fragmentation is causing fallbacks? As I said in t=
he
> other thread, I think the more robust solution is to implement scanning f=
or high
> order blocks.

That will introduce more fragmentation to the high order cluster, and
will make it harder to allocate high order swap entry later.

Please see my previous email for the usage case and the goal of the change.
https://lore.kernel.org/linux-mm/CANeU7QnVzqGKXp9pKDLWiuhqTvBxXupgFCRXejYhs=
hAjw6uDyQ@mail.gmail.com/T/#mf431a743e458896c2ab4a4077b103341313c9cf4

Let's discuss whether the usage case and the goal makes sense or not.

Chris


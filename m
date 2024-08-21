Return-Path: <linux-kernel+bounces-295985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D595A3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDBE28280A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A41B252F;
	Wed, 21 Aug 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs3AdSMb"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09A13BAC2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261750; cv=none; b=f5hEMZgpU4UlMJtMzfMQyA6EcvqIJydByeQ4xwrvh5NwiuHdCW6p8dW+0qVQ732kxNRWF6OfRyWrbcUp8b7cGCRfSR5WCc9WHGm9fo0Vk1O0XwIlierF/o8y9DsLz9Ul0LaqhOP8+rWUYaoWPMMTzMcz+zsi2nQ19ziFWYO/6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261750; c=relaxed/simple;
	bh=+pNeo36Vkbvqnl/W0Y1gbeBo9+nQQhKB3WvKM/c4qug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK05imr0d21HCywf5iiyDGR9/s1oIp9qOjw9j9YyBJbyvWrjQv+dLSDlGAJJaswjsZWQd7BlM4tY4mFvYQfojmecfhPIVlOq1PjL9/UvF+cAnujYddbyxraFEVJiKxK7Sxl8Nh9RlJ+aOX4iyhFCW5CdeZN9N0pnTD5c1YjLx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs3AdSMb; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f040733086so68926401fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724261747; x=1724866547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pNeo36Vkbvqnl/W0Y1gbeBo9+nQQhKB3WvKM/c4qug=;
        b=Xs3AdSMbUnC8gjHyO/F/Uq+dIwBQJfqURSSpaUcugYL7TI8wn5A7E1ehxP/hhXzP3G
         kj4Ag9D3G7wBca2/oYWQFHiauqGqOTm4/Q1vZ83rug/BK35QV4YW1CpmvOoKglfvU/Xu
         AHokiZomdwr0ThsI2rK6Af8k+fu/mxP6PZ6yNGL0AYQABkiBjNG194LgzNRGcVa2bxke
         +hAXt1cGbinYK+IN/xFDJoT56HStHBYreNEgyGiCRZc2Zdux3Zb2BU5QbvQVSJ0igP3e
         dfMutD3NpIQZXTx+k3oMdsQCXHOe2y7rOpKoLxEClZwzzT1/JXYyBuB52zfqktdKdOaH
         tvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261747; x=1724866547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pNeo36Vkbvqnl/W0Y1gbeBo9+nQQhKB3WvKM/c4qug=;
        b=kAxzKOXUTIlMM5NZWpNQCgFfGerm/h88SZjs/07esiKFg9ChbsddAaodyWXwii8CCl
         ahaYrsVQlEt51wUFnLkjc8+HaJ+kxe8wyZC5xeekTPxVMylHe0Di/Dnowr7GT5sXyazl
         SQNeyPszDEVMjUyiP/Sc2CnirVyRfHO9YEH8gFpc0Fb/IlA0ATke/4DHcHtR+M7k5y4M
         RHrhuIogCPI7nzO8lttOjWWSBJD8CzjfmxVZIsQvz3ecgdgYNfomWznGGBM27AJg0SIr
         jONwchgJrCORU6kLRobTDePrkSGkc9LPwQEFyhwD3P97jfN8yTrP/hNNUEq04yNekTw4
         Fzmw==
X-Forwarded-Encrypted: i=1; AJvYcCWRXKcuc4QiTlYMv80+lER3+pthAnsAcfOS0bIhBtolFgP5lZcgJR3QKNKNCYy9mNdB1tWctko1Wo3LOMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYrCO0D4hGmHZLOWRuatSSFJkWnhNOLGHXv8zHDVt5FyIKUqJ
	Nb18qLOhRMxb3j8dwJfK57dUELp9J+254SV3D1GIhrloqRu2VjhwXAJjwYYt/YNtcDfcBMhu3a9
	9hBMImrwbo3LB8YCA4xMlEpbXJTw=
X-Google-Smtp-Source: AGHT+IG/NZBOOu/e0wcNbV4g6vmKqzLubweH30ahIufDqXDEuPhI8DLL2aZsvxWeDKTodOxc7q/1B5XTeoM6Z4gFm/g=
X-Received: by 2002:a2e:a592:0:b0:2f3:f170:8ec3 with SMTP id
 38308e7fff4ca-2f3f88643f8mr21573881fa.21.1724261746690; Wed, 21 Aug 2024
 10:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820092359.97782-1-ryncsn@gmail.com> <az5fhwmdwxpsgsxb7j3ruzbjevmxqrmx5xswwzuazh6zq5ytrs@bmgbu44mz3po>
In-Reply-To: <az5fhwmdwxpsgsxb7j3ruzbjevmxqrmx5xswwzuazh6zq5ytrs@bmgbu44mz3po>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 22 Aug 2024 01:35:29 +0800
Message-ID: <CAMgjq7D9WWXWFKcGs1ZsU7pNykoWV7RmsoBdP9CcGEa4N7d3fg@mail.gmail.com>
Subject: Re: [PATCH] mm/swap, workingset: make anon shadow nodes memcg aware
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Muchun Song <muchun.song@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Shakeel Butt <shakeel.butt@linux.dev> =E4=BA=8E 2024=E5=B9=B48=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 08:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 20, 2024 at 05:23:59PM GMT, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently, the workingset (shadow) nodes of the swap cache are not
> > accounted to their corresponding memory cgroup, instead, they are
> > all accounted to the root cgroup. This leads to inaccurate accounting
> > and ineffective reclaiming. One cgroup could swap out a large amount
> > of memory, take up a large amount of memory with shadow nodes without
> > being accounted.
> >
> > This issue is similar to commit 7b785645e8f1 ("mm: fix page cache
> > convergence regression"), where page cache shadow nodes were incorrectl=
y
> > accounted. That was due to the accidental dropping of the accounting
> > flag during the XArray conversion in commit a28334862993
> > ("page cache: Finish XArray conversion").
> >
> > However, this fix has a different cause. Swap cache shadow nodes were
> > never accounted even before the XArray conversion, since they did not
> > exist until commit 3852f6768ede ("mm/swapcache: support to handle the
> > shadow entries"), which was years after the XArray conversion.
> >
> > It's worth noting that one anon shadow Xarray node may contain
> > different entries from different cgroup, and it gets accounted at recla=
im
> > time, so it's arguable which cgroup it should be accounted to (as
> > Shakeal Butt pointed out [1]). File pages may suffer similar issue
> > but less common. Things like proactive memory reclaim could make thing
> > more complex.
> >
> > So this commit still can't provide a 100% accurate accounting of anon
> > shadows, but it covers the cases when one memory cgroup uses significan=
t
> > amount of swap, and in most cases memory pressure in one cgroup only
> > suppose to reclaim this cgroup and children. Besides, this fix is clean=
 and
> > easy enough.
> >
> > Link: https://lore.kernel.org/all/7gzevefivueqtebzvikzbucnrnpurmh3scmfu=
iuo2tnrs37xso@haj7gzepjur2/ [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >

Hi, Thanks for the comments.

> Is this a real issue? Have you seen systems in the production with
> large amount of memory occupied by anon shadow entries? This is still
> limited to the amount of swap a cgroup is allowed to use.

No, this patch is cherry picked from previous series, this help
separating the shadows to different cgroup properly according to my
test, and reduces the lock contention of list_lru by a lot combined
with later patches. Not very convincing on its own indeed, so I
hesitated to send it alone.

> The reason I am asking is that this solution is worse than the perceived
> problem at least to me. With this patch, the kernel will be charging
> unrelated cgroups for the memory of swap xarray nodes during global
> reclaim and proactive reclaim.

Yes, this could be a problem.

I didn't observe this happening frequently with tests though, SWAP
tends to cluster the SWAP allocations, and reclaiming tends to batch
reclaim pages, so usually there is a fair high chance that shadows of
pages of the same memcg stay on the same node.

It could end up completely random when the SWAP device is getting
fragmented or reclaim is struggling though.

> You can reduce this weirdness by using set_active_memcg() in
> add_to_swap_cache() using the given folio's memcg but still you have the
> case of multiple unrelated folios and shadow entries of different
> cgroups within the same node. For filesystem case, the userspace can
> control which files are shared between different cgroups and has more
> control on it. That is not the case for swap space.

Right, this fix is not perfect, it's arguable if this new behaviour is
better or worse than before. There is some ongoing work from the SWAP
side so things may get fixed differently in the future, but I'll also
check if this patch can be improved.


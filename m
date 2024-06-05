Return-Path: <linux-kernel+bounces-201891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521028FC4BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076C92835D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806A18C359;
	Wed,  5 Jun 2024 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsMhGd81"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8401922D6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573244; cv=none; b=lK0qeRohxfo88bZ2D7hO+OTS+HsG52cecgTHCG+pmYXnCE1qYTQObMPGomZgaZFrZFwrn7XUsJr4UOR0sL+/ZD/FtGlERn3b1l1wR2tXgSr4Tej/DtnfyyEHaWEbOlDRpdDrs/TBh39blXZ3p0lTtWXPuBDqJbsaf68UY38PwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573244; c=relaxed/simple;
	bh=zK6BX1O+d9Bs1RfAOR1UlWcy9231mkCd/UkoYZoWvME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKKtIh7XdQcOjMbv6piZy3wda3ZfBLKtfxE1ytQ7bCxjUtFK2mJ35nuLtvCEKFCgkPfTcQHzN67avrvtHEcqOc51acGm0n3e25Ckv34gJE+FX1pKK0qsG4ExLjHHqOVEtlzPbej6R7WFGJzONNOirYKcrd/US5AYCDGiwuVWZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsMhGd81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BA5C4AF08
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717573243;
	bh=zK6BX1O+d9Bs1RfAOR1UlWcy9231mkCd/UkoYZoWvME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bsMhGd81xhOyZsDPXSqMm7AYxU0NpI2Ubbqp9kbARXQ7Uvqvv3mNR4vuz3h4/TpCb
	 rDdz2yPNbBQyNvBaD43YeDPdzpoIAahmshACWOpzB3TqOyPaLMXwY7kk0nKr4LWuyl
	 0LTo/Xdda1IinzgSEJtIIh2YQ4x9L2rTQodHnS9TnVXgFBuRvAnkvdG4Bp5X1/Qg+L
	 zJcfW866AfSJOahjsfIjZKXGuFqjGriw10jjyKJiPSoxO8ASovlqXe2EP13oNhCXik
	 QGvrQYUvyp1yY8MjrVV0cQvQwWKyvwImeexM9p9VTFTMmDX/BUO5pjsdL/vknuet4I
	 rnzGPKnwocFUA==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-37494bf9b5cso16151615ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:40:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVX47ifmJ87LW/1+pEL284dk9NitrLK93v4lRou0+Wz7NZ0Kx6tHX/jlsXT3pfOmGRYeH0UBlDv+4lNDWaEayuTgywXdIBpI0Tbmad/
X-Gm-Message-State: AOJu0YwceDWQ8uiSSK7DdKRLC9Q7J6tlVMwO5MCXgLT64pWZ2rnLwr6t
	4Yk9u3Oun9w/IZ1xYxicZbNTgEjzHgaQQHWQVL8xRVT6Bngv6JN3PW0geISfmymEaukbSQ+07NH
	TxZ1wST2D9wq364eFUq+KQcEyxplAzx8quDxP
X-Google-Smtp-Source: AGHT+IHmGJ8AhtUCXqb4hQ7CJ6bgjOcHsu08a3szb0FbGiC0M4Xtvt6GWTF+CzaO09z1WICKVBny5kKUN5BKkPKB0fM=
X-Received: by 2002:a05:6e02:148b:b0:374:aa48:1a86 with SMTP id
 e9e14a558f8ab-374b1ef313emr18335855ab.13.1717573242656; Wed, 05 Jun 2024
 00:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
 <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7C+rtbbnH+utGkUmwaTzB82zrO8qvotPx9Z6A4fMiO_4A@mail.gmail.com>
 <87frttcgmc.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frttcgmc.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 5 Jun 2024 00:40:31 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPVAvPVGze9dutzDGxJBYQ3T1vp8xOxYXX_iXqDwxHDTw@mail.gmail.com>
Message-ID: <CAF8kJuPVAvPVGze9dutzDGxJBYQ3T1vp8xOxYXX_iXqDwxHDTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 12:29=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Fri, May 31, 2024 at 10:37=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> > Isn't limiting order-0 allocation breaks the bottom line that order-0
> > allocation is the first class citizen, and should not fail if there is
> > space?
>
> Sorry for confusing words.  I mean limiting maximum number order-0 swap
> entries allocation in workloads, instead of limiting that in kernel.

What interface does it use to limit the order 0 swap entries?

I was thinking the kernel would enforce the high order swap space
reservation just like hugetlbfs does on huge pages.
We will need to introduce some interface to specify the reservation.

>
> > Just my two cents...
> >
> > I had a try locally based on Chris's work, allowing order 0 to use
> > nonfull_clusters as Ying has suggested, and starting with low order
> > and increase the order until nonfull_cluster[order] is not empty, that
> > way higher order is just better protected, because unless we ran out
> > of free_cluster and nonfull_cluster, direct scan won't happen.
> >
> > More concretely, I applied the following changes, which didn't change
> > the code much:
> > - In scan_swap_map_try_ssd_cluster, check nonfull_cluster first, then
> > free_clusters, then discard_cluster.
> > - If it's order 0, also check for (int i =3D 0; i < SWAP_NR_ORDERS; ++i=
)
> > nonfull_clusters[i] cluster before scan_swap_map_try_ssd_cluster
> > returns false.
> >
> > A quick test still using the memtier test, but decreased the swap
> > device size from 10G to 8g for higher pressure.
> >
> > Before:
> > hugepages-32kB/stats/swpout:34013
> > hugepages-32kB/stats/swpout_fallback:266
> > hugepages-512kB/stats/swpout:0
> > hugepages-512kB/stats/swpout_fallback:77
> > hugepages-2048kB/stats/swpout:0
> > hugepages-2048kB/stats/swpout_fallback:1
> > hugepages-1024kB/stats/swpout:0
> > hugepages-1024kB/stats/swpout_fallback:0
> > hugepages-64kB/stats/swpout:35088
> > hugepages-64kB/stats/swpout_fallback:66
> > hugepages-16kB/stats/swpout:31848
> > hugepages-16kB/stats/swpout_fallback:402
> > hugepages-256kB/stats/swpout:390
> > hugepages-256kB/stats/swpout_fallback:7244
> > hugepages-128kB/stats/swpout:28573
> > hugepages-128kB/stats/swpout_fallback:474
> >
> > After:
> > hugepages-32kB/stats/swpout:31448
> > hugepages-32kB/stats/swpout_fallback:3354
> > hugepages-512kB/stats/swpout:30
> > hugepages-512kB/stats/swpout_fallback:33
> > hugepages-2048kB/stats/swpout:2
> > hugepages-2048kB/stats/swpout_fallback:0
> > hugepages-1024kB/stats/swpout:0
> > hugepages-1024kB/stats/swpout_fallback:0
> > hugepages-64kB/stats/swpout:31255
> > hugepages-64kB/stats/swpout_fallback:3112
> > hugepages-16kB/stats/swpout:29931
> > hugepages-16kB/stats/swpout_fallback:3397
> > hugepages-256kB/stats/swpout:5223
> > hugepages-256kB/stats/swpout_fallback:2351
> > hugepages-128kB/stats/swpout:25600
> > hugepages-128kB/stats/swpout_fallback:2194
> >
> > High order (256k) swapout rate are significantly higher, 512k is now
> > possible, which indicate high orders are better protected, lower
> > orders are sacrificed but seems worth it.
>
> Yes.  I think that this reflects another aspect of the problem.  In some
> situations, it's better to steal one high-order cluster and use it for
> order-0 allocation instead of scattering order-0 allocation in random
> high-order clusters.

Agree, the  scan loop on swap_map[] has the worst pollution.

Chris


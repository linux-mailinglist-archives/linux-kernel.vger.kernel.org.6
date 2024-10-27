Return-Path: <linux-kernel+bounces-383453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8E9B1BE7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 03:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8966A2822C4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C350F9F8;
	Sun, 27 Oct 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGP7RVL0"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EA2F46
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729997156; cv=none; b=EDHD6vVcyPAhBuPVw6SCqi56+eO5U/uO38P/ECLPLbx5xPkLyM3jeaE3RA0bu6YOicYrT/k2pyQYi2ojHpXOjQ3Dbis9qT/MEvxazBdH0nkxuOFrVAIbUW2u2fiXVUixRj6h8E1osCuaqyEk/jtOKo9DFd1nZNx659tut5KgzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729997156; c=relaxed/simple;
	bh=CgagS/O3iJFPk0jh3DCNk1vzjuL5/uReh3FNYc6S190=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWWApeG4kzl2OoDdKbjGXo9ZftDS1poIl2IlmK1ecU6tYPv/yDJM8QkYmhQDMHDz9ssTwyFvqe2wVwCZpDSx2+s7Bdi2P3eOQ8R0kKFgVuR+JOCIzDyStbDsnzIKiXPesAg0d3y0v/ZaB4pbi5NfE/ocOHu+J+NBVG+xHuY0QOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGP7RVL0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso22555006d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 19:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729997153; x=1730601953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgagS/O3iJFPk0jh3DCNk1vzjuL5/uReh3FNYc6S190=;
        b=kGP7RVL09yHQgAoMk++QAn6l6eWccrjZQJfmSSffEAn76lTTObXtcniIxsTgBE6E4b
         uPrrG5aPyzF1Fepv7Cdkw19Y3yl1WbY+yQabUCsB6b/oXsgiVpT/Pc3GseWGtRk5S6Ly
         e2n4JM6edj0gH/9S3dstXAbkJ+5HQRFROMNqhG/wLp0zOcgoAXXCjp2G4gNJu2Ak4Vm7
         ystMVg3uBgM1XpvRrALneXOt3ZdNl8ard98lh4WpNxjkFWVyIrv5A9/8UrPjyZut+KpQ
         uCF11vr2ezY2pER6FKdM0EWF4ZExPS4r2EV8zvsj4yHkDpLq3VotpZm3Ch13M8aGqnVb
         tiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729997153; x=1730601953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgagS/O3iJFPk0jh3DCNk1vzjuL5/uReh3FNYc6S190=;
        b=hfKxmXMC925nnXlObzHV/S8iGgKHMwvZ16B4/N+aTajWKpPM6DFJNAbm0cKU3M6JFH
         OPvQF2l9jlkwFAL3lWig7VDPmBPLUoBQJAUPzK3jB7BLgimEjpPfYX5Ue//qh2Yce2P3
         8Yxyj+PJ7tARbbQsL8nXhDavpyKDnI4R1kQDrbWiD6u2dg6jRf0TYRvVrYYP9iqSegbw
         1rh2kk0mfAi2kMgha3yU7mBJMMUES4fRLtLLFo6aXSy5hu7Jw5nvZogg3EhB7JMkZXAk
         PJ1ucJTCVk08kW3U3iOkYXqiTVys53aD+YQJSvBtE1kSQ6r5ElvORlihN5CMaqAynG/c
         ToIA==
X-Forwarded-Encrypted: i=1; AJvYcCXNWPg0OHkAcKZgkgCoOt6iltcQLKt/tiHVDiEvq7yWeKe2vXC/YhXnnkcEFFbK61Cc5rVunDOJmwd912w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc40Io2BRi3wwMNGFHlph6v0mUJk4ZOVZ3GV8oo5OuSUuSNn2r
	M6jyUfz92uktsNISE5aq3HbnYhlyRdva/gCk/qwQSNxxDYM8IbPV8xMdQoxlvFG/YrOGznQUfwR
	W2XMSoFMZFIeagzXZiAX27Q8t1lo=
X-Google-Smtp-Source: AGHT+IFEhsaeNT9jZrxkEeOGaHktAe3pn15HbGpKN2WloMrpUzXtqAMv81NwMrj0rirhmo7aLJ644QuYCWUrr1EBlLY=
X-Received: by 2002:a05:6214:4805:b0:6d1:83ec:32f9 with SMTP id
 6a1803df08f44-6d1858409a3mr71809056d6.35.1729997152913; Sat, 26 Oct 2024
 19:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com>
In-Reply-To: <20241027011959.9226-1-21cnbao@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 26 Oct 2024 19:45:42 -0700
Message-ID: <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 6:20=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> When the proportion of folios from the zero map is small, missing their
> accounting may not significantly impact profiling. However, it=E2=80=99s =
easy
> to construct a scenario where this becomes an issue=E2=80=94for example,
> allocating 1 GB of memory, writing zeros from userspace, followed by
> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> and swap-in counts seem to vanish into a black hole, potentially
> causing semantic ambiguity.

I agree. It also makes developing around this area more challenging.
I'm working on the swap abstraction, and sometimes I can't tell if I
screwed up somewhere, or if a proportion of these allocated entries go
towards this optimization...

Thanks for taking a stab at fixing this, Barry!

>
> We have two ways to address this:
>
> 1. Add a separate counter specifically for the zero map.
> 2. Continue using the current accounting, treating the zero map like
> a normal backend. (This aligns with the current behavior of zRAM
> when supporting same-page fills at the device level.)

Hmm, my understanding of the pswpout/pswpin counters is that they only
apply to IO done directly to the backend device, no? That's why we
have a separate set of counters for zswap, and do not count them
towards pswp(in|out).

For users who have swap files on physical disks, the performance
difference between reading directly from the swapfile and going
through these optimizations could be really large. I think it makes
sense to have a separate set of counters for zero-mapped pages
(ideally, both at the host level and at the cgroup level?)


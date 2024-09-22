Return-Path: <linux-kernel+bounces-335339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D497E446
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BF61F2157E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BC78C8B;
	Sun, 22 Sep 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC+ievag"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518C7E1
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727049460; cv=none; b=Bqnih3v0BIHhtClQkz9zXIJYfLbn60hyTo6s2OWXPoCCkMbgSSJQWwYt6L1/o6DBxvr147i1g58ZfkBX980PT71bHttNc5u6mrI7aOeXXf1Jw3aSIMJ75qcTmr4yBqNefBCOIBEndafte1nce3ZDKhRcSWXMR4KD95pSkbj9YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727049460; c=relaxed/simple;
	bh=CAD1Nttxi1tuaZ4G5Nuq1uTbsGqc46vm2EtT7QAKfXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnUukLrPp8ZGOyvZKKsE4jjHQgYcn+Ml9q+cWseLElEUwuewMcG5FHlzKI3+nOq3bKz3IjoECdc/O++aKCgWCSICEDz122cUaWwpoHepKHf+J91ZMLhtoWIxS+g8Lxu36QS6wDTUZLJFAu8feI7YA5NWby3aczPNBZV0Cs/lrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC+ievag; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5011f85bca0so1153796e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727049458; x=1727654258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAD1Nttxi1tuaZ4G5Nuq1uTbsGqc46vm2EtT7QAKfXg=;
        b=WC+ievagM+dA+ni02oS3qBu0dY+k0x0kJnBAkUnJZE23sEsXcSdEVYemY0y9mYJhqO
         vmRETFvOsnTeA1l4uEBzLZy+7U7tHZY75TM4iGtldpiSAdb7iRxkdrGXsxrVL7EPWQCt
         D2qMIaF7SBeIU6cGSNhDRcMLTLULE5NAdQq/a6ESc5zcpopMkq4UjBJfFyyCw+U9DjMl
         MBoFWJRRyD1SrY85z7yGCTy4t1mRkFSoCpqT2yWbmo0JxclVgQGFv8FFrP6RUcTycoq1
         ooXDcoIGKrwhSa2q80+bEStZ9Rmh0icuBD//VbW/sot5GLeiqeicLQ89O7oOUdqOb/bE
         L3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727049458; x=1727654258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAD1Nttxi1tuaZ4G5Nuq1uTbsGqc46vm2EtT7QAKfXg=;
        b=tX4otMto7YAbDHKzcEuQtcXZbhpXG0ZYFg8EMR4AX56RhyKSy+7/y9yWEPVmC+urZA
         VOlVQ1Y0GgSOpu+L5/7ndAYzDkBP0hUelci5M2ZxZW8OgLEBIz5ZMriR2hUu/xJxpYVp
         4WA7z9Hvmah0nkcAE7mgFwzebEbt9TNgo0eCXSY3pYg/5EPhgiuGNT0OycAzcWAeOngX
         mu0Nt0Lx8Dy77/UaEaNaKnIGOyCt5QSs97u2ERRJ4atl/DWrIA/bA2b4l9sWF0hWDQe2
         T71kU0k+CfWmH34yA7U36dngYEn9Wutv13QHtHqWcfVBE1oHEUxAkTIPEsE5NyIKSJVj
         MO6w==
X-Forwarded-Encrypted: i=1; AJvYcCVxbtFaFbM2wy2evbv1//I0ULL1a7wbee1xxU3PST3LD3Od7wT0B/hnXH4j8UNQmZfEQ43hfypXj3uu/uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuGKJy5wPT01DVuGkQUDASW1pdELgD4lxmP90bFWmTf12XH7g
	zSPVT5OwHtY3ZoV44h2ynsp4J9MCyf2DIEvRY2fWbVzrOHSSnnjujb4PybjwMwoxBqx6/Jwv0kg
	1SbXD2zgK/amH1fqj3CgX0iRjxcw=
X-Google-Smtp-Source: AGHT+IEqkLE6FvrpXESDtzTTE4utfGcHu21lxH/e6PT9sOSdS7qUrgSqHOXjoAZkp2rkESz9wImJXQXD6+nyNnhGbaY=
X-Received: by 2002:a05:6122:1826:b0:502:6d58:4501 with SMTP id
 71dfb90a1353d-503e03c1293mr5952762e0c.2.1727049457758; Sun, 22 Sep 2024
 16:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
 <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com> <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
 <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com> <CAJD7tkYu2v2VnMizVeOTHTNXXbdnd+UqaKhTRfrTC7THUiPPdA@mail.gmail.com>
In-Reply-To: <CAJD7tkYu2v2VnMizVeOTHTNXXbdnd+UqaKhTRfrTC7THUiPPdA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 23 Sep 2024 07:57:25 +0800
Message-ID: <CAGsJ_4wd=6kuwg7v=_ARb+Ay15M8SU776Vjb4rmtiVp8vQg-qA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org, 
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, hch@infradead.org, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 7:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > >
> > > On the other hand, if you read the code of zRAM, you will find zRAM h=
as
> > > exactly the same mechanism as zeromap but zRAM can even do more
> > > by same_pages filled. since zRAM does the job in swapfile layer, ther=
e
> > > is no this kind of consistency issue like zeromap.
> > >
> > > So I feel for zRAM case, we don't need zeromap at all as there are du=
plicated
> > > efforts while I really appreciate your job which can benefit all swap=
files.
> > > i mean, zRAM has the ability to check "zero"(and also non-zero but sa=
me
> > > content). after zeromap checks zeromap, zRAM will check again:
> > >
> >
> > Yes, so there is a reason for having the zeromap patches, which I have =
outlined
> > in the coverletter.
> >
> > https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail=
.com/
> >
> > There are usecases where zswap/zram might not be used in production.
> > We can reduce I/O and flash wear in those cases by a large amount.
> >
> > Also running in Meta production, we found that the number of non-zero f=
illed
> > complete pages were less than 1%, so essentially its only the zero-fill=
ed pages
> > that matter.
> >
> > I believe after zeromap, it might be a good idea to remove the page_sam=
e_filled
> > check from zram code? Its not really a problem if its kept as well as I=
 dont
> > believe any zero-filled pages should reach zram_write_page?
>
> I brought this up before and Sergey pointed out that zram is sometimes
> used as a block device without swap, and that use case would benefit
> from having this handling in zram. That being said, I have no idea how
> many people care about this specific scenario.

Hi Usama/Yosry,

We successfully gathered page_same_filled data for zram on Android.
Interestingly,
our findings differ from yours on zswap.

Hailong discovered that around 85-86% of the page_same_filled data
consists of zeros,
while about 15% are non-zero. We suspect that on Android or similar
systems, some
graphics or media data might be duplicated at times, such as a red
block displayed
on the screen.

Does this suggest that page_same_filled could still provide some
benefits in zram
cases?

Thanks
Barry


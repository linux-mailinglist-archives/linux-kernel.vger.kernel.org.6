Return-Path: <linux-kernel+bounces-262849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B4C93CDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3026E2830E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2F155327;
	Fri, 26 Jul 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEmm70sJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70401552E4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973131; cv=none; b=M7M7gryKv07VlyfsyEQd++eNspHTKf6Ta/eVn8V0t3aABurcLemvRRjc5jtNT/QFqg82sD0bvhgUge6ZD+UGwZRtQEKBQD/sdVyjBgK4CewmPOJ6tQUYDEj4cWKeHS846P2818PJq2CxTyPjWBc+KI2e2LzmxqwNOgD65X5YMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973131; c=relaxed/simple;
	bh=55MZc/wVm8UcZqrdQXwtWT6wfPW4QnzsGMf95xAMunU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRV73DXEUOAMWDzbhuieXRk8a1Sc02Ft4xN2Yw/q+Z8XTXuSEUyvQKiFY88UVwD6x3oj7or2Y0L52BItr06WD5t14O7iSea2h+3/rqRmnqEIqar/OkQdp96oRcsladccZ3/p7vfwa7PJsmEuszmFII6djVqXCbdJ1TPurvyzjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEmm70sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C82C4AF0E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721973131;
	bh=55MZc/wVm8UcZqrdQXwtWT6wfPW4QnzsGMf95xAMunU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rEmm70sJ6l+2BjQxqwvqmzrFV0qk8hjStgKQlpxHLlUqmvv+OInu91efyqCBNo19j
	 wKwvT9/J6L66NE5RpNsfAA2MxTKuSSNiW1hZelkXIj0G4ozlCdmBrzBPFYMn9EOinT
	 245PXIuXwgOTTJ9MIjcq97nOEcjPPXnKq25Cm3ywwyB/PH/oaf6f/elORzeoiXyEGK
	 5jM5Kq71Y11vaw76bf0KyHt7G8d/x4pbDd6nLW47Si2Wx0tW6zVCPKk+saWS7JtEVY
	 znaLr7tKLmUXe7sZrBux2JIigvXLU1Uqx4D3VI5QSAq09rM3InDTzVv+pyV1Q4NC1K
	 xAxEY/3JTEUKw==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-664ccd158b0so15104177b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:52:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2r9fINNV9Ssx91zPsM25bOzDKrNoqjSWdCHo1wuvcO+wqOeEMPcfkbkP7AeAfbhudV/EWB6D0X8nNK4BsonTS2/Y2fQOVd78RK7mQ
X-Gm-Message-State: AOJu0YzMD3g/JxKyMrkzp4ps08TsMOsBJ3ypgh9uUYFa4jNMQyRT6THO
	YC5ofQ3BjeLXdRSNKCixeUeNkLZtfFXvTpdqWPP6iAot987uULbxg9XWH3L9H2mqWxMPA00k1k8
	E5ff6HrxSrITJCKW4oFIZKT1HXG7Hp2iRgT4/tQ==
X-Google-Smtp-Source: AGHT+IGvBUT1tDhncfh91DJY1WlS37LbkBfdz6tgAtI3DjY9RI63TBM0254gjG1YiX6EVVRc4wN1MxoCXIYwlAT/+iI=
X-Received: by 2002:a0d:d002:0:b0:62f:a250:632b with SMTP id
 00721157ae682-67510dee934mr55444067b3.8.1721973130523; Thu, 25 Jul 2024
 22:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org> <87cynbxn8e.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87cynbxn8e.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jul 2024 22:51:59 -0700
X-Gmail-Original-Message-ID: <CACePvbX7ozXhFhfcX+Dy3Aq8A7MQm=iRt9LzFacumFansHLRMQ@mail.gmail.com>
Message-ID: <CACePvbX7ozXhFhfcX+Dy3Aq8A7MQm=iRt9LzFacumFansHLRMQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:54=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
> > - HDD swap allocation does not need to consider clusters any more.
>
> It appears that my comments in the following emails are ignored?
>

Sorry for missing some email catching up.

> https://lore.kernel.org/linux-mm/87bk3pzr5p.fsf@yhuang6-desk2.ccr.corp.in=
tel.com/

Will reply to that. BTW, V4 already reverted to the previous SSD
behavior and allocated a new cluster before nonfull cluster.

> https://lore.kernel.org/linux-mm/874j9hzqr3.fsf@yhuang6-desk2.ccr.corp.in=
tel.com/

Already replied to the renaming in another email.

Chris

>
> > changes in v3:
> > - Using V1 as base.
> > - Rename "next" to "list" for the list field, suggested by Ying.
> > - Update comment for the locking rules for cluster fields and list,
> >   suggested by Ying.
> > - Allocate from the nonfull list before attempting free list, suggested
> >   by Kairui.
> > - Link to v2: https://lore.kernel.org/r/20240614-swap-allocator-v2-0-2a=
513b4a7f2f@kernel.org
> >
> > Changes in v2:
> > - Abandoned.
> > - Link to v1: https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47=
861b423b26@kernel.org
> >
> > ---
> > Chris Li (3):
> >       mm: swap: swap cluster switch to double link list
> >       mm: swap: mTHP allocate swap entries from nonfull list
> >       RFC: mm: swap: seperate SSD allocation from scan_swap_map_slots()
> >
> >  include/linux/swap.h |  30 ++--
> >  mm/swapfile.c        | 490 +++++++++++++++++++++++--------------------=
--------
> >  2 files changed, 238 insertions(+), 282 deletions(-)
> > ---
> > base-commit: ff3a648ecb9409aff1448cf4f6aa41d78c69a3bc
> > change-id: 20240523-swap-allocator-1534c480ece4
> >
>
> --
> Best Regards,
> Huang, Ying


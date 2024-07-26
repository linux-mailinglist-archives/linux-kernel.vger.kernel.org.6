Return-Path: <linux-kernel+bounces-262825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A918F93CD63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E911F21C66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB5926AFB;
	Fri, 26 Jul 2024 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwRjHiIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B428EF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721969469; cv=none; b=Wrnv2yBAVwcchibPUamljNdoAyKo7hb+/m+1MqBQpT+4EnXzgGUwEY+qiecGWdqR4r1uNpQ47nIYOEq+BbNjUC+ZkgFW61qvQ/++OCku+5kzvrsaOPcdDhC6uXisyol6A3mVslahzrBV4qre7FZMQ3bJCQKNxLGLAyV11OoLOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721969469; c=relaxed/simple;
	bh=41U3J3A3A9ZA5BCLpOFkq85Qoqhlbjx7I/O2B4k/1oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XM95NZrh8wGhLmKL0HJ+hQ1tF8/1GK6C8hEu/h2jBBX4+Bi1AY5XBmiCmp8Q+lc01v4UcT/BSdOl3RUrGtvccNleuSUJVQOl3P9Wk1IRCmLS+S26V+C4zsBv3Ofr8Jc+yqgZHLyLXKjwc5/J22G4kHQM51HeZOEV+K4sBlsw6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwRjHiIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE914C4AF0E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721969468;
	bh=41U3J3A3A9ZA5BCLpOFkq85Qoqhlbjx7I/O2B4k/1oU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WwRjHiIs+WJJ+/NzzD5nz3y+W5eqrAczgaszDEpZJcB935264DyyVTEuXAexr1dx3
	 deXg5G1g1TxICwze7GrnZ2LwRzIripmKCk6TvrAA+XmLPI/6V2jGG85a28AUcfO2RN
	 HiHC8VKs7EZ92qAwmkm2t/lKuoXeUZ6chzWVNoNG26VYT+sa3j4Jq5/AfHt04RIFyM
	 v/8R+ZNYCI9cTCj1jGY9scx7XoylXwt6fHN57PGJXbJVIRPsgLBrwUUbdMTJ9lsu0m
	 fJ3wbWjT1HdN6YlzTmw59SMFUBexz/OqoXAPe1WoCQYPSMvHHKIcSuQgpdUXCcEAub
	 FteAm6E+zBJOw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65f7bd30546so14226007b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 21:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSUZGaTU61P5gV3Y1yDpRuzyCO1bcEWl+aeVA2WCcoSCpLOsGdVvea2X9G9tHP3EcIxg+GMSkQeq07DEr+7KFxjW3d9xSNVP5xMXSX
X-Gm-Message-State: AOJu0YzxXkOFd0J1+L+vBAHwktf5SGG2btnVnB5gp/uXAxhB8GSF0UwD
	nLeUqO0vuyF8jXocllMQ6WlBEhJC8tN155u0U1WfWj31kKM+87HyvRvDFkh7LB5OnDIgITedUhL
	W1DAwlUPm+3q25z3gyYnEbagMZmMzwbkqIcZl5Q==
X-Google-Smtp-Source: AGHT+IF+O4lS4JpENJT6yNGqLEYFk/y/UK2OSsAnM3uMh/CQu9R+YmD9uaEELQc5QrI3dV5t6PdyhDtrQV2Tim5bUBA=
X-Received: by 2002:a81:9c54:0:b0:65f:7e5a:648a with SMTP id
 00721157ae682-672c025edeemr62028157b3.16.1721969468010; Thu, 25 Jul 2024
 21:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org> <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
 <CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
 <b4b31314-1125-40ee-b784-20abc78bd468@arm.com> <CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
 <874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com> <a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com>
 <87o76qjhqs.fsf@yhuang6-desk2.ccr.corp.intel.com> <43f73463-af42-4a00-8996-5f63bdf264a3@arm.com>
 <87jzhdkdzv.fsf@yhuang6-desk2.ccr.corp.intel.com> <f6fa3965-38db-4bdc-b6fd-6cd472169322@arm.com>
 <87sew0ei84.fsf@yhuang6-desk2.ccr.corp.intel.com> <4ec149fc-7c13-4777-bc97-58ee455a3d7e@arm.com>
 <87le1q6jyo.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXu268d2cBmm0a2Azr3=Aum19cSgY+7YijESrBCVK3a9w@mail.gmail.com>
 <87zfq43o4n.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87zfq43o4n.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jul 2024 21:50:56 -0700
X-Gmail-Original-Message-ID: <CACePvbXZ_DqxwiNPckBPAhxqoDoMRFRzhM24_8TcHQz-LTop_w@mail.gmail.com>
Message-ID: <CACePvbXZ_DqxwiNPckBPAhxqoDoMRFRzhM24_8TcHQz-LTop_w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:07=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
> > If the freeing of swap entry is random distribution. You need 16
> > continuous swap entries free at the same time at aligned 16 base
> > locations. The total number of order 4 free swap space add up together
> > is much lower than the order 0 allocatable swap space.
> > If having one entry free is 50% probability(swapfile half full), then
> > having 16 swap entries is continually free is (0.5) EXP 16 =3D 1.5 E-5.
> > If the swapfile is 80% full, that number drops to 6.5 E -12.
>
> This depends on workloads.  Quite some workloads will show some degree
> of spatial locality.  For a workload with no spatial locality at all as
> above, mTHP may be not a good choice at the first place.

The fragmentation comes from the order 0 entry not from the mTHP. mTHP
have their own valid usage case, and should be separate from how you
use the order 0 entry. That is why I consider this kind of strategy
only works on the lucky case. I would much prefer the strategy that
can guarantee work not depend on luck.

> >> - Order-4 pages need to be swapped out, but no enough order-4 non-full
> >>   clusters available.
> >
> > Exactly.
> >
> >>
> >> So, we need a way to migrate non-full clusters among orders to adjust =
to
> >> the various situations automatically.
> >
> > There is no easy way to migrate swap entries to different locations.
> > That is why I like to have discontiguous swap entries allocation for
> > mTHP.
>
> We suggest to migrate non-full swap clsuters among different lists, not
> swap entries.

Then you have the down side of reducing the number of total high order
clusters. By chance it is much easier to fragment the cluster than
anti-fragment a cluster.  The orders of clusters have a natural
tendency to move down rather than move up, given long enough time of
random access. It will likely run out of high order clusters in the
long run if we don't have any separation of orders.

> >> But yes, data is needed for any performance related change.
>
> BTW: I think non-full cluster isn't a good name.  Partial cluster is
> much better and follows the same convention as partial slab.

I am not opposed to it. The only reason I hold off on the rename is
because there are patches from Kairui I am testing depending on it.
Let's finish up the V5 patch with the swap cache reclaim code path
then do the renaming as one batch job. We actually have more than one
list that has the clusters partially full. It helps reduce the repeat
scan of the cluster that is not full but also not able to allocate
swap entries for this order.  Just the name of one of them as
"partial" is not precise either. Because the other lists are also
partially full. We'd better give them precise meaning systematically.

Chris


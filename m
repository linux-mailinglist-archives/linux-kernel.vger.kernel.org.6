Return-Path: <linux-kernel+bounces-262936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35993CED8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581331F22357
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C325176248;
	Fri, 26 Jul 2024 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8gVGG65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2723A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978819; cv=none; b=NmLoHEyG2VJFAwaEXbrQDI6kLF64IlmLobdKm9QtJWvxhgu8836jr+ORdn2WyqacTLtzHJDcXe64M3bDbd7CQWpUabrGy6h7IrQTEIZaDrk2CgfcxyBFOdA8Z6fgRrQhb9UCKY3wSjZ9NJuqEK4mZEtqqi9gt/WzMgt0m8XEYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978819; c=relaxed/simple;
	bh=kPxU1OON3IvpJ9O8NrD8HbE7eAdVGMynVpQbkVljyWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGdUzwGiW5yTOkjyrTix/zkQHqbeXjV889hVSS3AXIqzyAqf/qsaFj8KfSFlNQ6Ru074i2/UBQdtE8cCZ435cuUB9ihLY0ggx+y1Pp1yNV/a7JqBGv/sh7dzyIfWAySDR1oC2WEw4bEf9E24tTLSBTUZ50YOiAxnIjebkUWtt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8gVGG65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34070C4AF0C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721978819;
	bh=kPxU1OON3IvpJ9O8NrD8HbE7eAdVGMynVpQbkVljyWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O8gVGG65w2XFrr3SgoGyzy8pGCFpDKHLjuOeoFhFLezUW4OVU2i/Mgr4A1eOxelg0
	 CKfY6+U52uZX427bjdXd0L9CUE+toiew632QmJ2RGEU1v7vp7I8fB7cJOlBuZijQlA
	 xzcCpTJzMDy0vE0Hifc3S6BA1L15djPzjwUHXmUdShT088muGgyuTvXRz9++usmQjH
	 MSCOg6hcy0KCA9dU9dB923Js5N8vvEk4tNUsWdtilCgoKhC5kle3q8vn4Ednmau1vK
	 khCMcCDzY7A71YOL8R7+lGQDj5rkhzVzl3TS4kWuPxMkCEgl8W7VYh/0msJNb3pAzD
	 +PyX7jXivXQdA==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-661d7e68e89so13395897b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:26:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHikngsU2N1JppUwxlfh4dRNtA/xcFuskt84U+BYR3VC3n/jQRqyDzNVNhcgJE84SdvGb6LPVN0wzWFhnFRWxe3g9BUAEeBmZDpxqO
X-Gm-Message-State: AOJu0YxYLrC4WjMRiT76Nxvab8CP084/lugFNcTOezeaLixODdakv7hQ
	QMkIIHJkVinfONEpMHjT5AWCjvTIj07XYbdjv5keSYhZJRkN3WbWwbuqlYtWkok6TBYw40v4ork
	nb4I7FGoZz0DqDTTMzdALCIEiMqUD/h0vrAS+9Q==
X-Google-Smtp-Source: AGHT+IGvY6UJVtnciFwYJb04nTJUm+NyUa1h/z8v+I1kZ2Jq1rkw45M099OmOdE7bbXs61N6v2oh6oLMSVNL2AS8XcM=
X-Received: by 2002:a0d:efc3:0:b0:630:4fab:a090 with SMTP id
 00721157ae682-672c0f4420dmr59106467b3.22.1721978818451; Fri, 26 Jul 2024
 00:26:58 -0700 (PDT)
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
 <87zfq43o4n.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXZ_DqxwiNPckBPAhxqoDoMRFRzhM24_8TcHQz-LTop_w@mail.gmail.com>
 <87o76k3dkt.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbWe9wraG2FjBcX9OmHN5ynB4et9WEHqh6NPSVK5mzJi2A@mail.gmail.com>
 <87bk2k39lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk2k39lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jul 2024 00:26:47 -0700
X-Gmail-Original-Message-ID: <CACePvbVFJ_TO6cX7GJqzZ7u4K2dv0HX2-mc7mVBuXDF3JyqEFg@mail.gmail.com>
Message-ID: <CACePvbVFJ_TO6cX7GJqzZ7u4K2dv0HX2-mc7mVBuXDF3JyqEFg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 12:21=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Thu, Jul 25, 2024 at 10:55=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > On Thu, Jul 25, 2024 at 7:07=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >> > If the freeing of swap entry is random distribution. You need 16
> >> >> > continuous swap entries free at the same time at aligned 16 base
> >> >> > locations. The total number of order 4 free swap space add up tog=
ether
> >> >> > is much lower than the order 0 allocatable swap space.
> >> >> > If having one entry free is 50% probability(swapfile half full), =
then
> >> >> > having 16 swap entries is continually free is (0.5) EXP 16 =3D 1.=
5 E-5.
> >> >> > If the swapfile is 80% full, that number drops to 6.5 E -12.
> >> >>
> >> >> This depends on workloads.  Quite some workloads will show some deg=
ree
> >> >> of spatial locality.  For a workload with no spatial locality at al=
l as
> >> >> above, mTHP may be not a good choice at the first place.
> >> >
> >> > The fragmentation comes from the order 0 entry not from the mTHP. mT=
HP
> >> > have their own valid usage case, and should be separate from how you
> >> > use the order 0 entry. That is why I consider this kind of strategy
> >> > only works on the lucky case. I would much prefer the strategy that
> >> > can guarantee work not depend on luck.
> >>
> >> It seems that you have some perfect solution.  Will learn it when you
> >> post it.
> >
> > No, I don't have perfect solutions. I see puting limit on order 0 swap
> > usage and writing out discontinuous swap entries from a folio are more
> > deterministic and not depend on luck. Both have their price to pay as
> > well.
> >
> >>
> >> >> >> - Order-4 pages need to be swapped out, but no enough order-4 no=
n-full
> >> >> >>   clusters available.
> >> >> >
> >> >> > Exactly.
> >> >> >
> >> >> >>
> >> >> >> So, we need a way to migrate non-full clusters among orders to a=
djust to
> >> >> >> the various situations automatically.
> >> >> >
> >> >> > There is no easy way to migrate swap entries to different locatio=
ns.
> >> >> > That is why I like to have discontiguous swap entries allocation =
for
> >> >> > mTHP.
> >> >>
> >> >> We suggest to migrate non-full swap clsuters among different lists,=
 not
> >> >> swap entries.
> >> >
> >> > Then you have the down side of reducing the number of total high ord=
er
> >> > clusters. By chance it is much easier to fragment the cluster than
> >> > anti-fragment a cluster.  The orders of clusters have a natural
> >> > tendency to move down rather than move up, given long enough time of
> >> > random access. It will likely run out of high order clusters in the
> >> > long run if we don't have any separation of orders.
> >>
> >> As my example above, you may have almost 0 high-order clusters forever=
.
> >> So, your solution only works for very specific use cases.  It's not a
> >> general solution.
> >
> > One simple solution is having an optional limitation of 0 order swap.
> > I understand you don't like that option, but there is no other easy
> > solution to achieve the same effectiveness, so far. If there is, I
> > like to hear it.
>
> Just as you said, it's optional, so it's not general solution.  This may
> trigger OOM in general solution.

Agree it is not a general solution. This option is simple and useful.
The more general solution is just write out discontiguous swap entries.

Chris


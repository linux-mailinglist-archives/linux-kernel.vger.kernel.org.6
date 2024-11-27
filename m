Return-Path: <linux-kernel+bounces-422924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A14B9D9FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27356168B83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089484689;
	Wed, 27 Nov 2024 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc6AruXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB92907
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666635; cv=none; b=WL+sr1A3l73i8lu/n3mDlrbM/5kd80OztWzEk4c5/bs2ulRa/gFI1DzAdY59Ge1q+jgX3oY3cvs8y+1b1wnaGcMz9IXzRyAYbcUtw8cXltGnonl+GmgdbqKqw1Z5wBEADrfsbc1Ru6cjAhylc+HRs231gztxjrpOVIxZ4twfGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666635; c=relaxed/simple;
	bh=sBwY6OuAGJlWYY/aLMf6AmX2I9z8yQu0PCqyCoQw4II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOEYadWsP8/XW2HthqMzkCMWNu+u2RkaZnlT4Z7qLsBjjRMLxM5S8NA/APvPxZEF2V63Eo5r5MgVE0rp2/tHSQS6pEsDdswHOmX8MwWpudCCxOesa9LKtE36ZrkA6xu8C2XNZMWIGjL0/5tXDVkBWypjb4SACziAWot2NgJG23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc6AruXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E233C4CED3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732666635;
	bh=sBwY6OuAGJlWYY/aLMf6AmX2I9z8yQu0PCqyCoQw4II=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vc6AruXlZK5jhklUDKrsrOscsvZlUHI2ugvt2S8EB98Y3znXQa4K56ooZrA/OrBPa
	 wb6Tc82KGpOmChap6GU80tQvSRHBZTT1LJ3hYUoYRUSBFd6jSVOjCMHaQaK0fu4pm0
	 OxsQjFcTJdylI3JvCd3cExJZCPGv8R6lY4GPrcrdedOIoKJleFoRzAiUrUEpxx4GR8
	 czycCzuOUbwZjg3vrM8+V403lOquhqQ7ZQbOm6kHRF3QKRVN1k2XeVMFpJDK0OWZeI
	 Tk78++08tJHJRtWqYcgbT2OPohkQnzkLHkbfdzdEwvCaKCKNLnyETF56C2BtEheMp4
	 NLCSXhDf53iVQ==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ee7a400647so66939677b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:17:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9G12oTOY6QI4z+a01NUha7Ir+JkmYGbPtoP9PZM4NN4bxaF3DPyM7y2ZcV4chvA+vezWhKFrHt1/1Qag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTey3txjNs4HMyqzaUADGz+HD0rEtm3z9u85xYk6GWdFX6E9Q7
	16Fgn+HdG+9eBLYCLY4jRYt9RhZALCdj/LXqTwcHtDPubTFAXTGE2XhaygqOFQVvHCEHy0dBSod
	3x5NUEXwP9MEgM3af6iU4cBFPFJUwgizVunrt3g==
X-Google-Smtp-Source: AGHT+IGjB9saCzLKHjgxnnKPjGwq5oWgpFsEfJQQXxRtcDAABh36q/sUVARVGrb3gCXafCOgLYlSa8FALTgkvFhqZLE=
X-Received: by 2002:a05:690c:74c9:b0:6ec:b108:e5ce with SMTP id
 00721157ae682-6ef37279c69mr18243317b3.28.1732666634411; Tue, 26 Nov 2024
 16:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com> <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
 <03c18a7b-24fa-4ee6-8682-63f1a81363e5@huawei.com> <CAGsJ_4w5Tna1c0xO7w4=c+SRw1jQgHCCzNELkBURbCiAgxZ-cg@mail.gmail.com>
In-Reply-To: <CAGsJ_4w5Tna1c0xO7w4=c+SRw1jQgHCCzNELkBURbCiAgxZ-cg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Nov 2024 16:17:03 -0800
X-Gmail-Original-Message-ID: <CACePvbWpbGa9w3MNsATYHMcTSkzOu6OWw6tdiGS_=PdXYXzH1w@mail.gmail.com>
Message-ID: <CACePvbWpbGa9w3MNsATYHMcTSkzOu6OWw6tdiGS_=PdXYXzH1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Barry Song <21cnbao@gmail.com>
Cc: chenridong <chenridong@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
	Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, yuzhao@google.com, 
	david@redhat.com, ryan.roberts@arm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, wangweiyang2@huawei.com, xieym_ict@hotmail.com, 
	Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:56=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Nov 18, 2024 at 10:41=E2=80=AFPM chenridong <chenridong@huawei.co=
m> wrote:
> >
> >
> >
> > On 2024/11/18 12:14, Barry Song wrote:
> > > On Mon, Nov 18, 2024 at 5:03=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > >>
> > >> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> > >>> 2. In shrink_page_list function, if folioN is THP(2M), it may be sp=
lited
> > >>>    and added to swap cache folio by folio. After adding to swap cac=
he,
> > >>>    it will submit io to writeback folio to swap, which is asynchron=
ous.
> > >>>    When shrink_page_list is finished, the isolated folios list will=
 be
> > >>>    moved back to the head of inactive lru. The inactive lru may jus=
t look
> > >>>    like this, with 512 filioes have been move to the head of inacti=
ve lru.
> > >>
> > >> I was hoping that we'd be able to stop splitting the folio when addi=
ng
> > >> to the swap cache.  Ideally. we'd add the whole 2MB and write it bac=
k
> > >> as a single unit.
> > >
> > > This is already the case: adding to the swapcache doesn=E2=80=99t req=
uire splitting
> > > THPs, but failing to allocate 2MB of contiguous swap slots will.
> > >
> > >>
> > >> This is going to become much more important with memdescs.  We'd hav=
e to
> > >> allocate 512 struct folios to do this, which would be about 10 4kB p=
ages,
> > >> and if we're trying to swap out memory, we're probably low on memory=
.
> > >>
> > >> So I don't like this solution you have at all because it doesn't hel=
p us
> > >> get to the solution we're going to need in about a year's time.
> > >>
> > >
> > > Ridong might need to clarify why this splitting is occurring. If it=
=E2=80=99s due to the
> > > failure to allocate swap slots, we still need a solution to address i=
t.
> > >
> > > Thanks
> > > Barry
> >
> > shrink_folio_list
> >   add_to_swap
> >     folio_alloc_swap
> >       get_swap_pages
> >         scan_swap_map_slots
> >         /*
> >         * Swapfile is not block device or not using clusters so unable
> >         * to allocate large entries.
> >         */
> >         if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
> >           return 0;
> >
> > In my test, I use a file as swap, which is not 'SWP_BLKDEV'. So it
> > failed to get get_swap_pages.
>
> Alright, a proper non-rotating swap block device would be much
> better. In your case, though, cluster allocation isn=E2=80=99t supported.

Ah yes. The later part of the swap allocation series removes the non
cluster allocation code path.
It is not merged to mm-unstable yet. So even a swapfile not block
device will get the cluster allocator.

>
> >
> > I think this is a race issue between 'shrink_folio_list' executing and
> > writing back asynchronously. In my test, 512 folios(THP split) were
> > added to swap, only about 60 folios had not been written back when
> > 'move_folios_to_lru' was invoked after 'shrink_folio_list'. What if
> > writing back faster? Maybe this will happen even 32 folios(without THP)
> > are in the 'folio_list' of shrink_folio_list's inputs.
>
> On a real non-rotate swap device, the race condition would occur only whe=
n
> contiguous 2MB swap slots are unavailable.
>
> Hi Chris,
> I recall you mentioned unifying the code for swap devices and swap files,=
 or
> for non-rotating and rotating devices. I assume a swap file (not a block =
device)
> would also be a practical user case?

I assume you mean non-SSD vs SSD device. In this follow up series of
the swap allocator from Kairui, the old non cluster allocator gets
removed, the cluster allocator will be used all the time.

https://lore.kernel.org/linux-mm/20241022192451.38138-4-ryncsn@gmail.com/

Chris


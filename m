Return-Path: <linux-kernel+bounces-262831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06CF93CD75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2704C1F22189
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9B39FD7;
	Fri, 26 Jul 2024 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBbASsLf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AD3987B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970578; cv=none; b=f5aGCgqDetlPlQkNOLhju73hqIKx2mdhuF5KLiY89Wazc+Xsoqm6kfHZ3MU4KNZhbkxt4WpLlWZQo2oVQsAfmShD5jEVBboZZ/0yKbVQOp/VXeu5E92Zykoaa6Urwq78PyuvnxHd4ZZbvmj5HWqRSsgT+wY5e4g29JDcdtDMQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970578; c=relaxed/simple;
	bh=//iDyBxo+r8RcJtGYYYsaOgOpdscsUiSYG0DkPtUfKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3Y1A7lcifYm/5i8qZHNsVUCdf0pkF9B9b2aQA6FUW2W0DJ3JFSAHanByNfFRIW8i94yttqQHXXTq6C1+NPuHFKtxWKwiyYHkDvG30Wkxx3t9+rFNS0nksE1XNMlbgR3/C4ySHF0PXp3UfjFgZwJ0HNwTt+p/rAyqJqoY7g/ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBbASsLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9500CC4AF0E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721970577;
	bh=//iDyBxo+r8RcJtGYYYsaOgOpdscsUiSYG0DkPtUfKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lBbASsLfKOumKuvKadGACr9CNlyibAY/3Q2unPEWxMZ+dB/gVPdKYlQFfXO8+uTQi
	 aRx+8t5GP7OuBL1VATppTU8aIxSTSYwHv9ay7AeiCH91ulM8kXTGuPiZuOhe0lfHwe
	 c3EaBMzqwDyY+wRQMU354yLqQIz3epV0vj6gaHP7BK113Ze85+UsscvXxZ/dyNbq4t
	 z0zZRGBtqVQ62ChWQ4IAhbxDXvAQXFtEEGX2hbBJh5XnYuNH9Yfq2S0Ih/26cXGQ3C
	 UDD9rIB11xb5B0P2dPxnqYn5xXfLQp6ZSrBZim6jeSUeaZCPnY2OHqBUIs+WM3Lstv
	 VJVAn0Vie6eMQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-66493332ebfso14902137b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:09:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuKjx69hEigbm3rg/7mFW2qcTFTm/CzftPwcMljdn0vuJv+rjQBlWBU5yoKBFGMPvaItwA83loFci5JDEQsfW0HM4q6wqUcmu5vkbH
X-Gm-Message-State: AOJu0Yz79tQe6H0f+T7Tleq9XrGHwUSEW1JZ6hgbQZno7JpvYNGnxKkd
	uGdQy/yFGOXWhy4hZlzuXcuh6BRa0WiS/7lkGA/A0EG6XbwjDjI9I5sQWGm2WkmlBme8OGZGpJE
	5KQjnUjmP5FPWwKqnFCWMGjyjwE2K0zNbkjotmg==
X-Google-Smtp-Source: AGHT+IGtpsJrBWSHApI4c7dhatc88pRK9QokLUHgzF6yUg2zLMGGr5C78O75wzHSCmpjANJpmPdIQVcO/8WsPR4cv44=
X-Received: by 2002:a81:ab51:0:b0:64b:7500:2e9 with SMTP id
 00721157ae682-675b3823c7bmr40845767b3.9.1721970576710; Thu, 25 Jul 2024
 22:09:36 -0700 (PDT)
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
 <CACePvbV9cx6Le1cYgYo2D922E4Com45+XXquMZugog2+w5K_yg@mail.gmail.com>
 <87plr26kg2.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXC6SwD1mx_s_9yCZpqTXZhRKMetbCcBNPOgT-ZtLmGCA@mail.gmail.com>
 <87v80s3nvs.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v80s3nvs.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jul 2024 22:09:25 -0700
X-Gmail-Original-Message-ID: <CACePvbWW6YLZe=47+kfuz76J+WWGmfKHvqatGGm=RyRX=D-WeQ@mail.gmail.com>
Message-ID: <CACePvbWW6YLZe=47+kfuz76J+WWGmfKHvqatGGm=RyRX=D-WeQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:13=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
> >
> > The current proposed order also improves things step by step. The only
> > disagreement here is which patch order we introduce yet another list
> > in addition to the nonfull one. I just feel that it does not make
> > sense to invest into new code if that new code is going to be
> > completely rewrite anyway in the next two patches.
> >
> > Unless you mean is we should not do the patch 3 big rewrite and should
> > continue the scan_swap_map_try_ssd_cluster() way of only doing half of
> > the allocation job and let scan_swap_map_slots() do the complex retry
> > on top of try_ssd(). I feel the overall code is more complex and less
> > maintainable.
>
> I haven't look at [3/3], will wait for your next version for that.  So,
> I cannot say which order is better.  Please consider reviewers' effort
> too.  Small step patch is easier to be understood and reviewed.

That is exactly the reason I don't want to introduce too much new code
depending on the scan_swap_map_slots() behavior, which will be
abandoned in the big rewrite. Their constraints are very different. I
want to make the big rewrite patch 3 as small as possible. Using
incremental follow up patches to improve it.

>
> >> > That is why I want to make this change patch after patch 3. There is
> >> > also the long test cycle after the modification to make sure the swa=
p
> >> > code path is stable. I am not resisting a change of patch orders, it
> >> > is that patch can't directly be removed before patch 3 before the bi=
g
> >> > rewrite.
> >> >
> >> >
> >> >>
> >> >> > Your original
> >> >> > suggestion appears like that you want to keep all cluster with or=
der-N
> >> >> > on the nonfull list for order-N always unless the number of free =
swap
> >> >> > entry is less than 1<<N.
> >> >>
> >> >> Well I think that's certainly one of the conditions for removing it=
. But agree
> >> >> that if a full scan of the cluster has been performed and no swap e=
ntries have
> >> >> been freed since the scan started then it should also be removed fr=
om the list.
> >> >
> >> > Yes, in the later patch of patch, beyond patch 3, we have the almost
> >> > full cluster that for the cluster has been scan and not able to
> >> > allocate order N entry.
> >> >
> >> >>
> >> >> >
> >> >> >>> And, I understand that in some situations it may
> >> >> >>> be better to share clusters among CPUs.  So my suggestion is,
> >> >> >>>
> >> >> >>> - Make swap_cluster_info->order more accurate, don't pretend th=
at we
> >> >> >>>   have free swap entries with that order even after we are sure=
 that we
> >> >> >>>   haven't.
> >> >> >>
> >> >> >> Is this patch pretending that today? I don't think so?
> >> >> >
> >> >> > IIUC, in this patch swap_cluster_info->order is still "N" even if=
 we are
> >> >> > sure that there are no order-N free swap entry in the cluster.
> >> >>
> >> >> Oh I see what you mean. I think you and Chris already discussed thi=
s? IIRC
> >> >> Chris's point was that if you move that cluster to N-1, eventually =
all clusters
> >> >> are for order-0 and you have no means of allocating high orders unt=
il a whole
> >> >> cluster becomes free. That logic certainly makes sense to me, so th=
ink its
> >> >> better for swap_cluster_info->order to remain static while the clus=
ter is
> >> >> allocated. (I only skimmed that conversation so appologies if I got=
 the
> >> >> conclusion wrong!).
> >> >
> >> > Yes, that is the original intent, keep the cluster order as much as =
possible.
> >> >
> >> >>
> >> >> >
> >> >> >> But I agree that a
> >> >> >> cluster should only be on the per-order nonfull list if we know =
there are at
> >> >> >> least enough free swap entries in that cluster to cover the orde=
r. Of course
> >> >> >> that doesn't tell us for sure because they may not be contiguous=
.
> >> >> >
> >> >> > We can check that when free swap entry via checking adjacent swap
> >> >> > entries.  IMHO, the performance should be acceptable.
> >> >>
> >> >> Would you then use the result of that scanning to "promote" a clust=
er's order?
> >> >> e.g. swap_cluster_info->order =3D N+1? That would be neat. But this=
 all feels like
> >> >> a separate change on top of what Chris is doing here. For high orde=
rs there
> >> >> could be quite a bit of scanning required in the worst case for eve=
ry page that
> >> >> gets freed.
> >> >
> >> > Right, I feel that is a different set of patches. Even this series i=
s
> >> > hard enough for review. Those order promotion and demotion is headin=
g
> >> > towards a buddy system design. I want to point out that even the bud=
dy
> >> > system is not able to handle the case that swapfile is almost full a=
nd
> >> > the recently freed swap entries are not contiguous.
> >> >
> >> > We can invest in the buddy system, which doesn't handle all the
> >> > fragmentation issues. Or I prefer to go directly to the discontiguou=
s
> >> > swap entry. We pay a price for the indirect mapping of swap entries.
> >> > But it will solve the fragmentation issue 100%.
> >>
> >> It's good if we can solve the fragmentation issue 100%.  Just need to
> >> pay attention to the cost.
> >
> > The cost you mean the development cost or the run time cost (memory and=
 cpu)?
>
> I mean runtime cost.

Thanks for the clarification. Agree that we need to pay attention to
the run time cost. That is given.

> >> >> >>> My question is whether it's so important to share the per-cpu c=
luster
> >> >> >>> among CPUs?
> >> >> >>
> >> >> >> My rationale for sharing is that the preference previously has b=
een to favour
> >> >> >> efficient use of swap space; we don't want to fail a request for=
 allocation of a
> >> >> >> given order if there are actually slots available just because t=
hey have been
> >> >> >> reserved by another CPU. And I'm still asserting that it should =
be ~zero cost to
> >> >> >> do this. If I'm wrong about the zero cost, or in practice the sh=
aring doesn't
> >> >> >> actually help improve allocation success, then I'm happy to take=
 the exclusive
> >> >> >> approach.
> >> >> >>
> >> >> >>> I suggest to start with simple design, that is, per-CPU
> >> >> >>> cluster will not be shared among CPUs in most cases.
> >> >> >>
> >> >> >> I'm all for starting simple; I think that's what I already propo=
sed (exclusive
> >> >> >> in this patch, then shared in the "big rewrite"). I'm just objec=
ting to the
> >> >> >> current half-and-half policy in this patch.
> >> >> >
> >> >> > Sounds good to me.  We can start with exclusive solution and eval=
uate
> >> >> > whether shared solution is good.
> >> >>
> >> >> Yep. And also evaluate the dynamic order inc/dec idea too...
> >> >
> >> > It is not able to avoid fragementation 100% of the time. I prefer th=
e
> >> > discontinued swap entry as the next step, which guarantees forward
> >> > progress, we will not be stuck in a situation where we are not able =
to
> >> > allocate swap entries due to fragmentation.
> >>
> >> If my understanding were correct, the implementation complexity of the
> >> order promotion/demotion isn't at the same level of that of discontinu=
ed
> >> swap entry.
> >
> > Discontinued swap entry has higher complexity but higher payout as
> > well. It can get us to the place where cluster promotion/demotion
> > can't.
> >
> > I also feel that if we implement something towards a buddy system
> > allocator for swap, we should do a proper buddy allocator
> > implementation of data structures.
>
> I don't think that it's easy to implement a real buddy allocator for
> swap entries.  So, I avoid to use buddy in my words.

Then such a mix of cluster order promote/demote lose some benefit of
the buddy system. Because it lacks the proper data structure to
support buddy allocation. The buddy allocator provides more general
migration between orders. For the limited usage case of cluster
promotion/demotion is supported (by luck). We need to evaluate whether
it is worth the additional complexity.

Chris


Return-Path: <linux-kernel+bounces-262920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646293CEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8ED1F22B80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E429176ABD;
	Fri, 26 Jul 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klrnYHcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AF176AB3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978170; cv=none; b=TtTc+ZS8oJiD62/ZbATxM53GKMSv3lZ27Pn75vjc757OSFCHvkxGkv33nIvbnvd81E5AusbjF5MlzZPNJvbSxM9xIhSLUaaJCX+qOfm2Y3894g8FS+QxaJsvC09x+usv97hY3QOWRH9EqTplXuaiSAOZVNPonV59KYfBe6lXry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978170; c=relaxed/simple;
	bh=vquLMJU43gL517xgZnwq1RxLEm/blqJGVCY1MLs4jl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc4nXJyMGdOCH75yeH7gSGN3P02VV/y8vaEx2p3ehP9f/MlZiOO6BmDmjFkriYCeUah7rykY+JUvHf8b9ZeFEwlFWwcnmUvsFuK0YSD8yOGMgGPMCP/vpD3sL0J7YV9zya0qN12sG5ztpSaQJCEMYD69+8nsWv+WEYqvEVDlCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klrnYHcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB702C4AF0A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721978169;
	bh=vquLMJU43gL517xgZnwq1RxLEm/blqJGVCY1MLs4jl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=klrnYHcZrKOmzKV4V6jvNdzfHgKub3pXZ5cMPxxABSHbUjxHCpDF8nV2qSPoelyEp
	 mtEIy9wyOO+y6B8GstkU3xKC7WEGr8Bzrtuav6ND2ue5ZZ4syYetPMUx8xQybR9PTQ
	 xOEZowSvqlKe3Z8Bxu+BBErtg4mxxxqnBmMoZo9M34OtVXS6H6imlXizI66fsGCLZv
	 9vPgIE3FyAyKvaINDp4D3KYBsqh/JsUv+ua4cJtn/h09A7Nc7ds3bsoK79uaa2K973
	 e6ypr45XLdELTCbVkF4MplqNgtP380iu3WJLOc7Dj7Db5GEseFgNzn8pIPE5PkKMiP
	 +0wsOHPA1M+iA==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6512866fa87so17632737b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:16:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhopAKq03lAlo/XhWJG9YKhON6trSMG90cixwBR5D6MWPvUIrjmQwQKY9sYfsRbk9gitHIWVOqe7LI4A/fvolV40XcIVIqtrXVRbA8
X-Gm-Message-State: AOJu0YzZ+ziHJktDCEGZnzLgA0h4ZgjB9c7Emc8BEIwfIpwisTQgIl6w
	QZMq/ynBwU6RuAYv2hLJoaj0/J1jwD3nDn94femgmPz7NObb+IVEjb7DK8cK7oOCDFBgzcGouqG
	S8kVq7ZEkBimGXudyYbYPzj9pJbaP4sQZRTNx3w==
X-Google-Smtp-Source: AGHT+IGSvT53kHctBypvPedag4oAQC+VdpV81oBlF2bTSY9zy5lQI33IPoGCzXXI8+854SurcXr6jkGPhZdGSvWHi6o=
X-Received: by 2002:a0d:da82:0:b0:64b:2665:f92c with SMTP id
 00721157ae682-67510920816mr54930527b3.8.1721978168915; Fri, 26 Jul 2024
 00:16:08 -0700 (PDT)
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
 <87v80s3nvs.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbWW6YLZe=47+kfuz76J+WWGmfKHvqatGGm=RyRX=D-WeQ@mail.gmail.com>
 <87jzh83d3o.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzh83d3o.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jul 2024 00:15:58 -0700
X-Gmail-Original-Message-ID: <CACePvbWJ8c8pF0nQ=_bidJU2qoaJn6ygOAGVz4H07Kf0Rzxaag@mail.gmail.com>
Message-ID: <CACePvbWJ8c8pF0nQ=_bidJU2qoaJn6ygOAGVz4H07Kf0Rzxaag@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 11:05=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Thu, Jul 25, 2024 at 7:13=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >> >
> >> > The current proposed order also improves things step by step. The on=
ly
> >> > disagreement here is which patch order we introduce yet another list
> >> > in addition to the nonfull one. I just feel that it does not make
> >> > sense to invest into new code if that new code is going to be
> >> > completely rewrite anyway in the next two patches.
> >> >
> >> > Unless you mean is we should not do the patch 3 big rewrite and shou=
ld
> >> > continue the scan_swap_map_try_ssd_cluster() way of only doing half =
of
> >> > the allocation job and let scan_swap_map_slots() do the complex retr=
y
> >> > on top of try_ssd(). I feel the overall code is more complex and les=
s
> >> > maintainable.
> >>
> >> I haven't look at [3/3], will wait for your next version for that.  So=
,
> >> I cannot say which order is better.  Please consider reviewers' effort
> >> too.  Small step patch is easier to be understood and reviewed.
> >
> > That is exactly the reason I don't want to introduce too much new code
> > depending on the scan_swap_map_slots() behavior, which will be
> > abandoned in the big rewrite. Their constraints are very different. I
> > want to make the big rewrite patch 3 as small as possible. Using
> > incremental follow up patches to improve it.
> >
> >>
> >> >> > That is why I want to make this change patch after patch 3. There=
 is
> >> >> > also the long test cycle after the modification to make sure the =
swap
> >> >> > code path is stable. I am not resisting a change of patch orders,=
 it
> >> >> > is that patch can't directly be removed before patch 3 before the=
 big
> >> >> > rewrite.
> >> >> >
> >> >> >
> >> >> >>
> >> >> >> > Your original
> >> >> >> > suggestion appears like that you want to keep all cluster with=
 order-N
> >> >> >> > on the nonfull list for order-N always unless the number of fr=
ee swap
> >> >> >> > entry is less than 1<<N.
> >> >> >>
> >> >> >> Well I think that's certainly one of the conditions for removing=
 it. But agree
> >> >> >> that if a full scan of the cluster has been performed and no swa=
p entries have
> >> >> >> been freed since the scan started then it should also be removed=
 from the list.
> >> >> >
> >> >> > Yes, in the later patch of patch, beyond patch 3, we have the alm=
ost
> >> >> > full cluster that for the cluster has been scan and not able to
> >> >> > allocate order N entry.
> >> >> >
> >> >> >>
> >> >> >> >
> >> >> >> >>> And, I understand that in some situations it may
> >> >> >> >>> be better to share clusters among CPUs.  So my suggestion is=
,
> >> >> >> >>>
> >> >> >> >>> - Make swap_cluster_info->order more accurate, don't pretend=
 that we
> >> >> >> >>>   have free swap entries with that order even after we are s=
ure that we
> >> >> >> >>>   haven't.
> >> >> >> >>
> >> >> >> >> Is this patch pretending that today? I don't think so?
> >> >> >> >
> >> >> >> > IIUC, in this patch swap_cluster_info->order is still "N" even=
 if we are
> >> >> >> > sure that there are no order-N free swap entry in the cluster.
> >> >> >>
> >> >> >> Oh I see what you mean. I think you and Chris already discussed =
this? IIRC
> >> >> >> Chris's point was that if you move that cluster to N-1, eventual=
ly all clusters
> >> >> >> are for order-0 and you have no means of allocating high orders =
until a whole
> >> >> >> cluster becomes free. That logic certainly makes sense to me, so=
 think its
> >> >> >> better for swap_cluster_info->order to remain static while the c=
luster is
> >> >> >> allocated. (I only skimmed that conversation so appologies if I =
got the
> >> >> >> conclusion wrong!).
> >> >> >
> >> >> > Yes, that is the original intent, keep the cluster order as much =
as possible.
> >> >> >
> >> >> >>
> >> >> >> >
> >> >> >> >> But I agree that a
> >> >> >> >> cluster should only be on the per-order nonfull list if we kn=
ow there are at
> >> >> >> >> least enough free swap entries in that cluster to cover the o=
rder. Of course
> >> >> >> >> that doesn't tell us for sure because they may not be contigu=
ous.
> >> >> >> >
> >> >> >> > We can check that when free swap entry via checking adjacent s=
wap
> >> >> >> > entries.  IMHO, the performance should be acceptable.
> >> >> >>
> >> >> >> Would you then use the result of that scanning to "promote" a cl=
uster's order?
> >> >> >> e.g. swap_cluster_info->order =3D N+1? That would be neat. But t=
his all feels like
> >> >> >> a separate change on top of what Chris is doing here. For high o=
rders there
> >> >> >> could be quite a bit of scanning required in the worst case for =
every page that
> >> >> >> gets freed.
> >> >> >
> >> >> > Right, I feel that is a different set of patches. Even this serie=
s is
> >> >> > hard enough for review. Those order promotion and demotion is hea=
ding
> >> >> > towards a buddy system design. I want to point out that even the =
buddy
> >> >> > system is not able to handle the case that swapfile is almost ful=
l and
> >> >> > the recently freed swap entries are not contiguous.
> >> >> >
> >> >> > We can invest in the buddy system, which doesn't handle all the
> >> >> > fragmentation issues. Or I prefer to go directly to the discontig=
uous
> >> >> > swap entry. We pay a price for the indirect mapping of swap entri=
es.
> >> >> > But it will solve the fragmentation issue 100%.
> >> >>
> >> >> It's good if we can solve the fragmentation issue 100%.  Just need =
to
> >> >> pay attention to the cost.
> >> >
> >> > The cost you mean the development cost or the run time cost (memory =
and cpu)?
> >>
> >> I mean runtime cost.
> >
> > Thanks for the clarification. Agree that we need to pay attention to
> > the run time cost. That is given.
> >
> >> >> >> >>> My question is whether it's so important to share the per-cp=
u cluster
> >> >> >> >>> among CPUs?
> >> >> >> >>
> >> >> >> >> My rationale for sharing is that the preference previously ha=
s been to favour
> >> >> >> >> efficient use of swap space; we don't want to fail a request =
for allocation of a
> >> >> >> >> given order if there are actually slots available just becaus=
e they have been
> >> >> >> >> reserved by another CPU. And I'm still asserting that it shou=
ld be ~zero cost to
> >> >> >> >> do this. If I'm wrong about the zero cost, or in practice the=
 sharing doesn't
> >> >> >> >> actually help improve allocation success, then I'm happy to t=
ake the exclusive
> >> >> >> >> approach.
> >> >> >> >>
> >> >> >> >>> I suggest to start with simple design, that is, per-CPU
> >> >> >> >>> cluster will not be shared among CPUs in most cases.
> >> >> >> >>
> >> >> >> >> I'm all for starting simple; I think that's what I already pr=
oposed (exclusive
> >> >> >> >> in this patch, then shared in the "big rewrite"). I'm just ob=
jecting to the
> >> >> >> >> current half-and-half policy in this patch.
> >> >> >> >
> >> >> >> > Sounds good to me.  We can start with exclusive solution and e=
valuate
> >> >> >> > whether shared solution is good.
> >> >> >>
> >> >> >> Yep. And also evaluate the dynamic order inc/dec idea too...
> >> >> >
> >> >> > It is not able to avoid fragementation 100% of the time. I prefer=
 the
> >> >> > discontinued swap entry as the next step, which guarantees forwar=
d
> >> >> > progress, we will not be stuck in a situation where we are not ab=
le to
> >> >> > allocate swap entries due to fragmentation.
> >> >>
> >> >> If my understanding were correct, the implementation complexity of =
the
> >> >> order promotion/demotion isn't at the same level of that of discont=
inued
> >> >> swap entry.
> >> >
> >> > Discontinued swap entry has higher complexity but higher payout as
> >> > well. It can get us to the place where cluster promotion/demotion
> >> > can't.
> >> >
> >> > I also feel that if we implement something towards a buddy system
> >> > allocator for swap, we should do a proper buddy allocator
> >> > implementation of data structures.
> >>
> >> I don't think that it's easy to implement a real buddy allocator for
> >> swap entries.  So, I avoid to use buddy in my words.
> >
> > Then such a mix of cluster order promote/demote lose some benefit of
> > the buddy system. Because it lacks the proper data structure to
> > support buddy allocation. The buddy allocator provides more general
> > migration between orders. For the limited usage case of cluster
> > promotion/demotion is supported (by luck). We need to evaluate whether
> > it is worth the additional complexity.
>
> TBH, I believe that the complexity of order promote/demote is quite low,
> both for development and runtime.  A real buddy allocator may need to
> increase per-swap-entry memory footprint much.

I mostly concern its effectiveness. Anyway, the series is already
complex enough with the big rewrite and reclaim on swap cache.

Let me know if you think it needs to be done before the big rewrite.

Chris


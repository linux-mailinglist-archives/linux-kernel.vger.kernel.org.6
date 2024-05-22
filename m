Return-Path: <linux-kernel+bounces-186063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BF8CBF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D931F23333
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3589823DE;
	Wed, 22 May 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XboQguBB"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC2405CC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374434; cv=none; b=cWP1Hpzyq+FLZKdJF7ztrfnKXNBelF58vaNHLjdRnvpmxnec9ERugpKywusBH1Qlvmo/25UgsI2jLL09/zlE9LZuprj34Y+3UkDy0orVfvZWw+M6APm77UQCWeOWTJvBwxiK894jDq9Un947s9HwU+w9cj9BX8Nh34uRDUcU39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374434; c=relaxed/simple;
	bh=DX3D6Q/G2nkV8/MDn0wGoCxEIYLxKvAtTiLNkBqKcxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dohg1vg1o+/a2L0PI68Ah8G+IQLFD3m4aXi/FgFAlihPKtEQCJNmHhcypef1cAbn6SGtlRcfU3RruyzYMpGAzR9boLnohvocRP/jzT9eHLffgQz49Wq6/rAOWscQoV3W7KAx3+YmDXkNQ1L455eeerj4uY7WSvyO3TmDLbJLQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XboQguBB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4df456bbf86so1594681e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716374432; x=1716979232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGBrCiYdmQ4B6wnJrGx67czT3yLNOBqFphtPVjs664s=;
        b=XboQguBBcyo0ACzQubO5Hte4hmO4+Ie9JIa/jX9y4yBFEvOV/aAvchX0StWXVs6NC9
         0XvpU9H96wg7Un6axZ0fRqZ/0ORCEicNGinmb5F4c5dlPRb9C12Gh5csovuZx/PYiOcm
         QnbxjDsnlZgFq4OhFd6yFlsfrN2nqCqF6id9nUbSyPiG/bagspczylbVY/boMqXqnJUi
         RJHE19j01twowLkQsFHCmKR7XmyGV2Qry74dQurSe+uSn3WImBTLpoLc9dY6Met6jqI8
         JGMTgMBxQsdTzNCS9y/Rx1qVdxSwW81ijRAsJyYQ3jq/kvg0VoPAzYZ+tPBQG5JoTpb3
         M88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716374432; x=1716979232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGBrCiYdmQ4B6wnJrGx67czT3yLNOBqFphtPVjs664s=;
        b=AjtmVqq/0erXcOXZjUU0CWk5v7qUHBukUqNnGSrzj/iSmG3sDtQAYw8IvQa7G+J192
         RAidKF5+PGPfmgsMmSFe7FVUDC/GfMlAm3H35PoX1OKC+sRtdRGiw3fTK2IyhixMVgmQ
         OKdqyMhGGpXSWZApa4sZgNZhgrMGNwm58IB4ZBoTJPgLMRmjOwnVkJxc/w263Gwdlkwm
         j3SRYH3lnteI1/D+nA7NI7TT/xyqlYsijCqzQlhYp6w1sceKlINrxku9E5ahgg3u0hsp
         QXP+Ckl6fEuNQORJXH9uGMQHbS83YFW/VdFD+uX7P3O9p9hV306TQkY6RKg4vokdM2bj
         gQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx4z4ho2EqBOXS0jqoHG+6pPtLqyh3ZQn/Lrq6ugG918ScBVDOJjF3wiblvfC6QygvQDfPJsSNCTgN1CfoBb17ESQZQ9GoiS4T9bwe
X-Gm-Message-State: AOJu0YzOY3Cg4V1xatO91JdzBVqbw80AfyZfCQ7xta2tvZB1bebUXOm1
	ZFJVWtHMpD8Q3o7wX+HOeUOA41oQscVmIYJ2Rk+91VM/rElokYpiGuDpC66+isSM8EcYH7Xgr1a
	BZQqvhpQO0/33RfCA8UX/P4zmWeJKbbrq
X-Google-Smtp-Source: AGHT+IFz/+FulVn/L4GngDGNYyGatHQM4h9w9g4/jURT3l7FTQh1zUzhDggmL2PIlEtdWuaZYnIBue2iy9mAn20e0uE=
X-Received: by 2002:a05:6122:168b:b0:4cb:fc25:7caa with SMTP id
 71dfb90a1353d-4e2185dfe36mr1512317e0c.14.1716374432152; Wed, 22 May 2024
 03:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
 <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com> <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
In-Reply-To: <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 May 2024 22:40:20 +1200
Message-ID: <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, willy@infradead.org, 
	ying.huang@intel.com, ryan.roberts@arm.com, ziy@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 9:38=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/22 16:58, David Hildenbrand wrote:
> > On 22.05.24 10:51, Baolin Wang wrote:
> >> The mTHP swap related counters: 'anon_swpout' and
> >> 'anon_swpout_fallback' are
> >> confusing with an 'anon_' prefix, since the shmem can swap out
> >> non-anonymous
> >> pages. So drop the 'anon_' prefix to keep consistent with the old swap
> >> counter
> >> names.
> >>
> >> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >
> > Am I daydreaming or did we add the anon_ for a reason and discussed the
> > interaction with shmem? At least I remember some discussion around that=
.
>
> Do you mean the shmem mTHP allocation counters in previous
> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can
> not find previous discussions that provided a reason for adding the
> =E2=80=98anon_=E2=80=99 prefix. Barry, any comments? Thanks.

HI Baolin,
We had tons of emails discussing about namin and I found this email,

https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redhat.com=
/

David had this comment,
"I'm wondering if these should be ANON specific for now. We might want to
add others (shmem, file) in the future."

This is likely how the 'anon_' prefix started being added, although it
wasn't specifically
targeting swapout.

I sense your patch slightly alters the behavior of thp_swpout_fallback
in /proc/vmstat.
Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even though we
always split them.

                if (folio_test_anon(folio) && folio_test_swapbacked(folio))=
 {
                        ...
                                if (!add_to_swap(folio)) {
                                        int __maybe_unused order =3D
folio_order(folio);

                                        if (!folio_test_large(folio))
                                                goto activate_locked_split;
                                        /* Fallback to swap normal pages */
                                        if (split_folio_to_list(folio,
folio_list))
                                                goto activate_locked;
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
                                        if (nr_pages >=3D HPAGE_PMD_NR) {
                                                count_memcg_folio_events(fo=
lio,
                                                        THP_SWPOUT_FALLBACK=
, 1);

count_vm_event(THP_SWPOUT_FALLBACK);
                                        }
                                        count_mthp_stat(order,
MTHP_STAT_ANON_SWPOUT_FALLBACK);
#endif
                                        if (!add_to_swap(folio))
                                                goto activate_locked_split;
                                }
                        }
                } else if (folio_test_swapbacked(folio) &&
                           folio_test_large(folio)) {
                        /* Split shmem folio */
                        if (split_folio_to_list(folio, folio_list))
                                goto keep_locked;
                }



If the goal is to incorporate pmd-mapped shmem under thp_swpout* in
/proc/vmstat,
and if there is consistency between /proc/vmstat and sys regarding
their definitions,
then I have no objection to this patch. However, shmem_swpout and shmem_swp=
out_*
appear more intuitive, given that thp_swpout_* in /proc/vmstat has
never shown any
increments for shmem until now - we have been always splitting shmem in vms=
can.

By the way, if this patch is accepted, it must be included in version
6.10 to maintain
ABI compatibility. Additionally, documentation must be updated accordingly.

>
> [1]
> https://lore.kernel.org/all/05d0096e4ec3e572d1d52d33a31a661321ac1551.1713=
755580.git.baolin.wang@linux.alibaba.com/

Thanks
Barry


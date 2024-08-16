Return-Path: <linux-kernel+bounces-289181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC599542D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D141F2725F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4412C478;
	Fri, 16 Aug 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bANrtMWn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519E12AAC6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793822; cv=none; b=QNi/TfpI/5kTigxODo1nHJK+tAwwUG+8ML4lQOpIx+bwEFLM2egwE/uCvWHJ8iJ0A8ErCaXVYO39liIWnGPJ6MSZUMQofBsxaru6vYq7MEFMiR2Hj+5SUwq6r3RN/TwAatqK6oKfY1M1i0A5lxoh2eehUc0sEqg3ALOt9NxtDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793822; c=relaxed/simple;
	bh=uzuJfTXPe7neM6t/yzL0dWNGEP8CEt+SIWppqKHzaes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNG2DB80z3unRwkjIZIoaVlRS6QBJgm+c7Xan64J4ex2OO75SITboUgesV1GkFoXPo/IMK2pNP3tZJbt38clXa2BeWz55BEgVj+CUdqMeR0jlyjoPy07SNrEpArr0WDnq1HLKW63Hn9vclfnucrblM0gH0o+Qylu2vcL78KywmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bANrtMWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5572C4AF0B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793821;
	bh=uzuJfTXPe7neM6t/yzL0dWNGEP8CEt+SIWppqKHzaes=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bANrtMWnXhse6awDD8O6xOJSQCsp+s1gI9ha2zGs9gx6SoIKn1hfNUPloeM9Ib5B3
	 JHnmd8FnEMcFyPusaLbZceR2SY5CL+nIw1gF5ID+TYDu5tgyd8Mtzzt2muUuwSoxR1
	 w1UyFP0IZR9NLbjiSY4WV97l0aTPkj6/gBK2SSt1pns4GrBmv7Y/1HIBEMUH7EEaid
	 l6pPDo2JwGHYhDYCPwrXZbqPesa4aySioQY9sdMyaHSosioBUwO7sLje6l454lt0NR
	 mIOumSZh/6AJK9ucUuW58Aj1Apb+WXeVDFa5Djlf84PPvCy+fjHiuN5/GZIyauCQOu
	 iGqnmvBvaQg0A==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6510c0c8e29so17317727b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:37:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2+hpRVAkx+gdYnWi8meSafnWRPLYnvXYboTMJLTLZlC91JhKUQB6Y+4GiIC2QDzX0oGayKD0FCI5soLjO3VhslWbqqLcolhI+lf2p
X-Gm-Message-State: AOJu0YxHkOpWNj3K53yRHPzEFPF09V4l3AOsp55N1xGlIyqt/qH844T5
	Fec/kEB/BKrctEsBeFGRig7B/nqUyv9b50jUXIS/gmhD77mw9sQDQ7AGMqhzItjoILa+tNYZ/Fi
	lyxXlEbnrjAmTc7xFv8EqwMMfDTyX9tD/j5BkXg==
X-Google-Smtp-Source: AGHT+IH750XFcbd3RlLlGRypRDvl9yZV+Lcv0nO3OSNd4+FHM7UHtJv3wC7eYlkX6F3NpWWbXqA9Pt+z/HqB40SHDYM=
X-Received: by 2002:a05:690c:7489:b0:6b1:9dc9:23d6 with SMTP id
 00721157ae682-6b1bc019d96mr26833207b3.41.1723793821164; Fri, 16 Aug 2024
 00:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <3c79021a-e9a0-4669-a4e7-7060edf12d58@redhat.com> <CAMgjq7CWwK75_2Zi5P40K08pk9iqOcuWKL6khu=x4Yg_nXaQag@mail.gmail.com>
 <87le17z9zr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87le17z9zr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 16 Aug 2024 00:36:50 -0700
X-Gmail-Original-Message-ID: <CACePvbX1EWQk03YcC47s7+vn40kEFb_3wp3D_GmJV-8Fn2j+=Q@mail.gmail.com>
Message-ID: <CACePvbX1EWQk03YcC47s7+vn40kEFb_3wp3D_GmJV-8Fn2j+=Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <ryncsn@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:40=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> [snip]
>
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -450,7 +450,10 @@ static void __free_cluster(struct swap_info_struct=
 *si, struct swap_cluster_info
> >       lockdep_assert_held(&si->lock);
> >       lockdep_assert_held(&ci->lock);
> >
> > -     list_move_tail(&ci->list, &si->free_clusters);
> > +     if (ci->flags)
> > +             list_move_tail(&ci->list, &si->free_clusters);
> > +     else
> > +             list_add_tail(&ci->list, &si->free_clusters);
>
> If we use list_del_init() to delete the cluster, we can always use
> list_move_tail()?  If so, the logic can be simplified.

Thanks for the suggestion.

I feel that list_del_init() generates more instruction than necessary.
It is my bad that I leave the discard list without not a list flag bit
for it.

I do want to clean this up. While we are at it, because the cluster
can only belong to one list at a time. We can use a list indicator as
integer rather than bits mask. If we give the discard list the same
treatment, that should remove the special condition to add a cluster
to another list as well.

Chris

> >       ci->flags =3D CLUSTER_FLAG_FREE;
> >       ci->order =3D 0;
> >  }
> > @@ -474,7 +477,6 @@ static void swap_do_scheduled_discard(struct swap_i=
nfo_struct *si)
> >                               SWAPFILE_CLUSTER);
> >
> >               spin_lock(&si->lock);
> > -
> >               spin_lock(&ci->lock);
> >               __free_cluster(si, ci);
> >               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> > @@ -666,7 +668,7 @@ static void cluster_alloc_range(struct swap_info_st=
ruct *si, struct swap_cluster
> >               if (ci->flags & CLUSTER_FLAG_FRAG)
> >                       si->frag_cluster_nr[ci->order]--;
> >               list_move_tail(&ci->list, &si->full_clusters);
> > -             ci->flags =3D 0;
> > +             ci->flags =3D CLUSTER_FLAG_FULL;
> >       }
> >  }
>
> --
> Best Regards,
> Huang, Ying


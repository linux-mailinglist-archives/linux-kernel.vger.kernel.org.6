Return-Path: <linux-kernel+bounces-430008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD49E2C77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587D6B2CF57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D531FCCFE;
	Tue,  3 Dec 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwL75Ckd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439391F4733
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250522; cv=none; b=ogaklY90KoG64lYpmh9jFuHCpVqVSTeIjxL1Fpq4RqwzCP/kAjrK4cTqa8RQubUCd3oSHVbV0y2bc8m4+GtGquCTrcxxHmjSyF6VF4yW1mRIYTMZM7KByiIIst4j06GBej2dxSmUawt2Qdz0RUHQVzL1x5djhn/5ECRbpYB1T4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250522; c=relaxed/simple;
	bh=dAqSBQldDaZM671klLg3Yg9EMBKSJ+lOZ+zy13Gx/6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFE/eMs2RqlZxBE2Y7Ol8nkNZRvSBV0wbTyVLuBgkL/s2WPnQU25za8sgXN4wf52bpUSgLcJALN2S4oQYAeHowqhiPUUp39NgOtcMvj855szI7kk5esu7sy81mJX1AR73RdEYy6jqarlqSkdYNhaTDO3P511NnAsofl3wUpRU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwL75Ckd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35B8C4CED9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733250521;
	bh=dAqSBQldDaZM671klLg3Yg9EMBKSJ+lOZ+zy13Gx/6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hwL75CkdeBDhrjUsHjwt6FxBozK3oio/abGFNlYmVkF0YdSZJbxWk7Ze6cOoBAsy2
	 zkPp/crslZWdv1roZaqcWQsUUcw1Lvwh4FxFR8vWqLB+j2Ps+fhl8MeTWVc0ovg/k1
	 TcxAICEf4qgBkvIjqN9+xei+Rkq0OsAxzQmZ+x0qXS5U9YbifqzmQ4u6Y4y+PxBjrr
	 j5wYgnRZUxtePYjI099/IKQLM7KyGXJW3x6M2Yg6asvj8avpaNMniajCpJzJ+c4z36
	 5vyENYiw8jYJBCJHARQZcc1yXpRWXSCsOWSkebUYpAMfDn8ECGCXmoL34zuwyLJn/D
	 MntdrE92jHZpA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efa1e49ef0so25018007b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:28:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBtmDthUE9mQCio1YKY+hkl8p0jA+08S3JIpZRCbANoKnQPahGXvBtb9wIGIeFXd8TVDCoD1d3mMu+YTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jZPz0bWsEaQucU6yKrD2bMvPfM0AlK615uKC2a9kNJgUPg4C
	YM9mxxG/FDVbSM/8nGzFjV3QQi3sYTjitznElDgQXTBhZfCVkrJne1MRwiTnduvXaGXvKtVpH6q
	Qmg7kTetCySPSS2pKdBpmEoEDyoqcQtgeBy6AEQ==
X-Google-Smtp-Source: AGHT+IGNscgGi/J3gltdmjKTXwoNsW1FgKvacF3vttSA4/t31ZEm4yvkbQRpe7jS+6C9t00e36FkVfR3giW2+ryb1As=
X-Received: by 2002:a05:690c:6106:b0:6ef:910d:7847 with SMTP id
 00721157ae682-6efad1be677mr52023427b3.24.1733250521018; Tue, 03 Dec 2024
 10:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-2-ryncsn@gmail.com>
 <CAJD7tkYemGu0iqt+ZW9t5zr21PbHkFBRnc=EixiwoNbq0xq5Ew@mail.gmail.com> <CAMgjq7Aeh9LCtSkG_RMrZjO_tvGryYA-QuvU9k1ahOzEv8LkgQ@mail.gmail.com>
In-Reply-To: <CAMgjq7Aeh9LCtSkG_RMrZjO_tvGryYA-QuvU9k1ahOzEv8LkgQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 3 Dec 2024 10:28:29 -0800
X-Gmail-Original-Message-ID: <CACePvbUjmWC9YzdHKW_yeTZBVa0O1oW=ypuWhhHxm2Xwf7Gswg@mail.gmail.com>
Message-ID: <CACePvbUjmWC9YzdHKW_yeTZBVa0O1oW=ypuWhhHxm2Xwf7Gswg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
To: Kairui Song <ryncsn@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

On Tue, Dec 3, 2024 at 12:26=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Dec 3, 2024 at 3:11=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
> > > which is already checked by the caller here. Skip it by calling
> > > __mem_cgroup_uncharge_swap() directly.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/memcontrol.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 7b3503d12aaf..d3d1eb506eee 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -4615,7 +4615,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_=
t entry, unsigned int nr_pages)
> > >                  * let's not wait for it.  The page already received =
a
> > >                  * memory+swap charge, drop the swap entry duplicate.
> > >                  */
> > > -               mem_cgroup_uncharge_swap(entry, nr_pages);
> > > +               __mem_cgroup_uncharge_swap(entry, nr_pages);
> >
> > Would it be better to instead remove the mem_cgroup_disabled() check
> > here and have a single check in this path?
>
> Good suggestion, and the kernel test bot just reported
> __mem_cgroup_uncharge_swap is undefined with !CONFIG_SWAP, so better
> to fix it by removing the check instead.

Agree with Yosry on the suggestion of calling
mem_cgroup_uncharge_swap() instead. With that.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

>
> >
> > Anyway, FWIW:
> >
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > >         }
> > >  }
> > >
> > > --
> > > 2.47.0
> > >
> >


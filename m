Return-Path: <linux-kernel+bounces-445241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C949F132D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192921651D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9B1E32DD;
	Fri, 13 Dec 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+TwbICB"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB771BBBFD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109593; cv=none; b=EfHMT/88/6DJ5trEghpYCQWLu2bfdvi3oHu7hOOGW6F30Xy9HW8cFicpkGC108X2Yq9brHHKa9k65qg2u2LvcI2WpnpoVT7EI69tKkT9k2hy0TEg3mOJ3ui4dRZFKy5AEZBKU7a1GspLGCK5A1QiPnPWoPGAlxiBXVzG1Mc4zjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109593; c=relaxed/simple;
	bh=4OyxjogFiZnKWEOamvaLWoYsu0eej91BOwaJnjMTqUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W58s0ndUv/IzzZSXVvhejX9Mon7C8CYypl5gps9rX+sZOavb7YgGsbcu06HL0AabWw2tI9CCT7LzgVjkULK+mxct6wpi8COvXzyKzYBTXLeBTwfOgFFv/FHTV7a6WX6ue423qLkKXxpUoaEJbADXVFGFD4HGBEdDvvjXg9Tu/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+TwbICB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4678c9310afso260211cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734109590; x=1734714390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyIlfqeTSYnGwoVUw2fO+COs34egMKzATNjjOmDg8bc=;
        b=f+TwbICBgc4MnElP7xGW6gwGypIREJqMroJrfFmxXByGE/kH3Fg4lMQPPCPNPCxoLi
         CxoGatd9mm8+ncHKr3X73kEAwzHlOcfP6riIT7iVnTFwyEhuhviLBlLOCRrn1UArgxNE
         Zg2PAikwqb8SIwyQBNA4h5Rd6AURm9P/+Ma/879WijAE5JxvWgMIh2oBLUKI5C8KJXg8
         mzWJS40mrWWYerwn3jOT2TGzMnYqO7QwIYUz9LPKOEO9roZM/hOJnwhIv+E48ZpVKo2Q
         jyYHkBO/g7chC86co8OWBp/oeAzIMD06mIrRVF0JXYHmh5w1+drqgB7eS+epNT7CKVp3
         mYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109590; x=1734714390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyIlfqeTSYnGwoVUw2fO+COs34egMKzATNjjOmDg8bc=;
        b=Jckzs6TFgqJiPae6WXnrsTZGMPphzYBR2HKwL7RA/5etK95hdVAt3k5Wtuap/fKB2P
         5ENN+W/ZFrMk6FMvwEmWSyPbNJiwL8uRq1+B5OAh27KyZknVbNv+C417xnTHvdu9dfwF
         BibkdXmUrTE4g9OvgaYrpS9Z1vOiFV4+IBYZad/3dKVlQiB3eNpUyInRHNaORwPfzWOl
         897XWrsEyYk6p12fdsZNmRzWnxuCe3OBlsBc8OqIpIr/IN+GdiO4JYO7K0ztQGSdK4G8
         izpYUz+5qojs4uEbDI4Khl8B0mL5Nso+t3umv264XKe9az5VaQNEK+504JcDcRlJKb6s
         mv4w==
X-Forwarded-Encrypted: i=1; AJvYcCUs5kkX2izya/cH4BELXJF0uphMRYox6zguXRcBM4U/fuSMRVNw4B8AwoqmVky6we0FTZiiB28X5K6cC/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmoIQXNq6ibgUy7r3gGZKdNm/IckJih/JpzpBBD4+hq+JM5Ymk
	2w+7hWAP5HOibhLEfTWYEEMwM58ZGiNdPvzI4rbdpErnTzGFuisADc6edmkIui9twGGNouj14Rz
	0iX744FWVO7hLhvoioHLq3Ij9HlXm94LhP+w8
X-Gm-Gg: ASbGncuJqbFlZXoAsNbBWOMDlZb+ejCrpBac+SncHMgAZgBvg8SxuzMJICZJYp9v4L8
	tNnt4yDJCCdRAl+ae0LpJu4rpd5U+cM8MvALQ
X-Google-Smtp-Source: AGHT+IGRkRuDW6q7/PmvB1JStrDpLKLNbu6M5WFn/fBcivNwgYnFcQLVKnDyWTz0mgKKzXPtocJrva8gm3CGJ42jf/A=
X-Received: by 2002:a05:622a:1924:b0:467:7c30:3446 with SMTP id
 d75a77b69052e-467a59cdbebmr3184701cf.25.1734109590181; Fri, 13 Dec 2024
 09:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212095646.16164-1-hailong.liu@oppo.com> <CABdmKX2__wuSLH2x=5=SqQR0wo86R-Xknua-q9BC44XQDjwgug@mail.gmail.com>
 <20241213022619.ph22z2mxxyh3u3tw@oppo.com>
In-Reply-To: <20241213022619.ph22z2mxxyh3u3tw@oppo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 13 Dec 2024 09:06:17 -0800
Message-ID: <CABdmKX1AE=PYB+grWH6pSjjA2_io70eSH3FjZZpbOwUEiduTSg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mglru: keep the root_memcg reclaim behavior the
 same as memcg reclaim
To: hailong <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yuzhao@google.com, 21cnbao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:26=E2=80=AFPM hailong <hailong.liu@oppo.com> wrot=
e:
>
> On Thu, 12. Dec 10:22, T.J. Mercier wrote:
> > On Thu, Dec 12, 2024 at 1:57=E2=80=AFAM hailong <hailong.liu@oppo.com> =
wrote:
> > >
> > > From: Hailong Liu <hailong.liu@oppo.com>
> > >
> > > commit a579086c99ed ("mm: multi-gen LRU: remove eviction fairness saf=
eguard") said
> > > Note that memcg LRU only applies to global reclaim. For memcg reclaim=
,
> > > the eviction will continue, even if it is overshooting. This becomes
> > > unconditional due to code simplification.
> > >
> > > Howeven, if we reclaim a root memcg by sysfs (memory.reclaim), the be=
havior acts
> > > as a kswapd or direct reclaim.
> >
> > Hi Hailong,
> >
> > Why do you think this is a problem?
> >
> > > Fix this by remove the condition of mem_cgroup_is_root in
> > > root_reclaim().
> > > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > > ---
> > >  mm/vmscan.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 76378bc257e3..1f74f3ba0999 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -216,7 +216,7 @@ static bool cgroup_reclaim(struct scan_control *s=
c)
> > >   */
> > >  static bool root_reclaim(struct scan_control *sc)
> > >  {
> > > -       return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->targe=
t_mem_cgroup);
> > > +       return !sc->target_mem_cgroup;
> > >  }
> > >
> > >  /**
> > > --
> > > Actually we switch to mglru on kernel-6.1 and see different behavior =
on
> > > root_mem_cgroup reclaim. so is there any background fot this?
> >
> > Reclaim behavior differs with MGLRU.
> > https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/
> >
> > On even more recent kernels, regular LRU reclaim has also changed.
> > https://lore.kernel.org/lkml/20240514202641.2821494-1-hannes@cmpxchg.or=
g/
>
> Thanks for the details.
>
> Take this as a example.
>                root
>              /  |   \
>         /       |    \
>            a    b     c
>                     | \
>                     |  \
>                     d   e
> IIUC, the mglru can resolve the direct reclaim latency due to the
> sharding. However, for the proactive reclaim, if we want to reclaim
> b, b->d->e, however, if reclaiming the root, the reclaim path is
> uncertain. The call stack is as follows:
> lru_gen_shrink_node()->shrink_many()->hlist_nulls_for_each_entry_rcu()->s=
hrink_one()
>
> So, for the proactive reclaim of root_memcg, whether it is mglru or
> regular lru, calling shrink_node_memcgs() makes the behavior certain
> and reasonable for me.

The ordering is uncertain, but ordering has never been specified as
part of that interface AFAIK, and you'll still get what you ask for (X
bytes from the root or under). Assuming partial reclaim of a cgroup
(which I hope is true if you're reclaiming from the root?) if I have
the choice I'd rather have the memcg LRU ordering to try to reclaim
from colder memcgs first, rather than a static pre-order traversal
that always hits the same children first.

The reason it's a choice only for the root is because the memcg LRU is
maintained at the pgdat level, not at each individual cgroup. So there
is no mechanism to get memcg LRU ordering from a subset of cgroups,
which would be pretty cool but that sounds expensive.

- T.J.

> Help you, Help me,
> Hailong.


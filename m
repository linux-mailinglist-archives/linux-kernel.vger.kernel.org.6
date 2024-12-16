Return-Path: <linux-kernel+bounces-447802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C029F3727
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE397A1158
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B66206F09;
	Mon, 16 Dec 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3oVI5zaN"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67022066F3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369241; cv=none; b=jUb97aUKoWxxorFxF0AulRSRpadD1F289/LAIOAJY9vqzyXTwwE8EsUh860v/vHKRY5YImEbZqgLpfXaMcGDjQM3NAepIiHOU/KgfDKNWWucGQ1W9DEDePBocbXtSvOtrRawIecDpyWOv/gSI0iqhi2RKidq9ONJ2x/pTi4Qfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369241; c=relaxed/simple;
	bh=EDZA1Ml1xIhw4Wuw6XxfNFC1lIRUwTha/ePj0s6Tg34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEORXn0kjs0cSFTxVapSptBi7Cn/FIyNN2CiFM53guNW3CjihyIbzZTkGSu8OIJQ5NWx7rIBUV6zokR7y7vCbmcWWw/lvearEzSUJVf1gcLis3YgI0h8mpatbQe8oaQuBJzqkZaT+KofXvYvF2+to0h8Z9DEwcwSJeoWIWdbTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3oVI5zaN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467abce2ef9so503161cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734369239; x=1734974039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/ntJ6j/Y1Xc/BjPB7fRlzVU5CR9ZvIvXv4aJ+9WBXY=;
        b=3oVI5zaNHSCisGAMIjdCaqAMO3MgpPc5yDw5ZhfHNaXlEG857dmRsv9w722z9Z1Bd4
         dPKnXW0iyl4vqdQd0VkJhQD6ei4epmCeE97dTgAdshVcLMw7Q/6fJKixlTimM+dP4RdA
         ROEb/JCZhI32FgzikYc921/Wi76PBXNVZnY02wUoXC9MQrTlQzg5ujI8xjW07WCsyheg
         mDnC/sP65yINQOPs96RNy2U5FzOG9mGEQwj6MryV1taF7Y6QYJo+geKCnWZBExuZlvz0
         ZQOgfebh3cCBW5mvctE45W83kfapcE3nVf5mcO71qCpJmDv9hbVy4KqGGJuZu1M7Gfe0
         ZARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369239; x=1734974039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/ntJ6j/Y1Xc/BjPB7fRlzVU5CR9ZvIvXv4aJ+9WBXY=;
        b=a8Ucyt021B+gxhV+Fx0R99+PDX38IPTWYNk2tKSVur8W9cnTmoaPdkNDYQCjr3nY0l
         QR69omMkNO5j7tq21WtUtCZxr33mJuebMzPntpGPCjar3Ql2mwWRcUaTa178G3Y1x1GB
         8JAf5mdqWtpN0e64h3XrhPwpeXS0L4hcOZX3G3ROFqcw/qieDBGsAs39sYhr54SzrwZF
         w6SFJ/7lsgf9sQJ23fteWgiF6LLJMwTw6EBwFUNhp3ShHZDdlJdinJpQXSNrKPVOI8gP
         fKDaDvlghXhrykvqee5+iON5bC8pjXROIUY+Y7NfCp1C3CQsCrndMkVLOtT1o1/XmtSt
         RxDA==
X-Forwarded-Encrypted: i=1; AJvYcCWD/cH6qvF+3qpQusThJhEN14ESojf4BuztXCEiH5NCa1jnBnoCHQg0U7FAdwOLMp9gjhT/VMm30maWaP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCrIHli60aLpnh5CtAqWX3NEzNw0+ptRkgEWi88OceabQYVCv
	fA5+i829REs50mh5z31qWbNcFEDi/l7ditvkHQiWwi/cBBqJ3k8sJEg/6Z6mMqg+Q/XFXDT58zT
	2OGcrsrv8SK28q4OX3sW9Z5F/XLIBTuqfFLpn8thOilEDUSXeBw==
X-Gm-Gg: ASbGncsQTszaQ0rZDWmlzKidR3A5hTEgib66j6UHawiumFkhleiQpkvKDjOvHIHsnNo
	pS1MBso60JUmpQ/BkeyNwe2BqBxnP7bO05MSs
X-Google-Smtp-Source: AGHT+IGVB/0ZaWKVMH3A4ijYzGT1MsPFrraEYIAjCZuljtOQqsdVXqkCb/hzo5E3cdZYsCRlW/f8WP6ZDfH99rTaKGw=
X-Received: by 2002:a05:622a:d6:b0:466:8906:159a with SMTP id
 d75a77b69052e-467b4a6d8c0mr5763861cf.19.1734369238509; Mon, 16 Dec 2024
 09:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212095646.16164-1-hailong.liu@oppo.com> <CABdmKX2__wuSLH2x=5=SqQR0wo86R-Xknua-q9BC44XQDjwgug@mail.gmail.com>
 <20241213022619.ph22z2mxxyh3u3tw@oppo.com> <CABdmKX1AE=PYB+grWH6pSjjA2_io70eSH3FjZZpbOwUEiduTSg@mail.gmail.com>
 <20241216015414.ujbwsr6mtwgo4goe@oppo.com>
In-Reply-To: <20241216015414.ujbwsr6mtwgo4goe@oppo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 16 Dec 2024 09:13:46 -0800
Message-ID: <CABdmKX1XRw3z9-vXKzin+Ee601vw2remSHheXxeVwv51r2Nxiw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mglru: keep the root_memcg reclaim behavior the
 same as memcg reclaim
To: hailong <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yuzhao@google.com, 21cnbao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 5:54=E2=80=AFPM hailong <hailong.liu@oppo.com> wrot=
e:
>
> On Fri, 13. Dec 09:06, T.J. Mercier wrote:
> > On Thu, Dec 12, 2024 at 6:26=E2=80=AFPM hailong <hailong.liu@oppo.com> =
wrote:
> > >
> > > On Thu, 12. Dec 10:22, T.J. Mercier wrote:
> > > > On Thu, Dec 12, 2024 at 1:57=E2=80=AFAM hailong <hailong.liu@oppo.c=
om> wrote:
> > > > >
> > > > > From: Hailong Liu <hailong.liu@oppo.com>
> > > > >
> > > > > commit a579086c99ed ("mm: multi-gen LRU: remove eviction fairness=
 safeguard") said
> > > > > Note that memcg LRU only applies to global reclaim. For memcg rec=
laim,
> > > > > the eviction will continue, even if it is overshooting. This beco=
mes
> > > > > unconditional due to code simplification.
> > > > >
> > > > > Howeven, if we reclaim a root memcg by sysfs (memory.reclaim), th=
e behavior acts
> > > > > as a kswapd or direct reclaim.
> > > >
> > > > Hi Hailong,
> > > >
> > > > Why do you think this is a problem?
> > > >
> > > > > Fix this by remove the condition of mem_cgroup_is_root in
> > > > > root_reclaim().
> > > > > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > > > > ---
> > > > >  mm/vmscan.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index 76378bc257e3..1f74f3ba0999 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -216,7 +216,7 @@ static bool cgroup_reclaim(struct scan_contro=
l *sc)
> > > > >   */
> > > > >  static bool root_reclaim(struct scan_control *sc)
> > > > >  {
> > > > > -       return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->t=
arget_mem_cgroup);
> > > > > +       return !sc->target_mem_cgroup;
> > > > >  }
> > > > >
> > > > >  /**
> > > > > --
> > > > > Actually we switch to mglru on kernel-6.1 and see different behav=
ior on
> > > > > root_mem_cgroup reclaim. so is there any background fot this?
> > > >
> > > > Reclaim behavior differs with MGLRU.
> > > > https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.=
com/
> > > >
> > > > On even more recent kernels, regular LRU reclaim has also changed.
> > > > https://lore.kernel.org/lkml/20240514202641.2821494-1-hannes@cmpxch=
g.org/
> > >
> > > Thanks for the details.
> > >
> > > Take this as a example.
> > >                root
> > >              /  |   \
> > >         /       |    \
> > >            a    b     c
> > >                     | \
> > >                     |  \
> > >                     d   e
> > > IIUC, the mglru can resolve the direct reclaim latency due to the
> > > sharding. However, for the proactive reclaim, if we want to reclaim
> > > b, b->d->e, however, if reclaiming the root, the reclaim path is
> > > uncertain. The call stack is as follows:
> > > lru_gen_shrink_node()->shrink_many()->hlist_nulls_for_each_entry_rcu(=
)->shrink_one()
> > >
> > > So, for the proactive reclaim of root_memcg, whether it is mglru or
> > > regular lru, calling shrink_node_memcgs() makes the behavior certain
> > > and reasonable for me.
> >
> > The ordering is uncertain, but ordering has never been specified as
> > part of that interface AFAIK, and you'll still get what you ask for (X
> > bytes from the root or under). Assuming partial reclaim of a cgroup
> > (which I hope is true if you're reclaiming from the root?) if I have
> > the choice I'd rather have the memcg LRU ordering to try to reclaim
> > from colder memcgs first, rather than a static pre-order traversal
> > that always hits the same children first.
> >
> > The reason it's a choice only for the root is because the memcg LRU is
> > maintained at the pgdat level, not at each individual cgroup. So there
> > is no mechanism to get memcg LRU ordering from a subset of cgroups,
> > which would be pretty cool but that sounds expensive.
>
> Got it, thanks for clarifying. From the perspective of memcg, it
> behaves differently. But if we change the perspective to the global
> reclaim, it is reasonable because root memcg is another way of global
> reclaim. It makes global reclaim consistent. NACK myself :)

Yeah, that's another way to look at it. :)

> >
> > - T.J.
> >
> > > Help you, Help me,
> > > Hailong.
> --
> Help you, Help me,
> Hailong.


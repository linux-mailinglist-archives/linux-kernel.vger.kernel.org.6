Return-Path: <linux-kernel+bounces-290026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00923954E91
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84292B208DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB951BCA1C;
	Fri, 16 Aug 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yv32sMAq"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E076F2F0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824916; cv=none; b=gMRnW6cd15c+6hQ67xWzlPrgv3zh9DzIVmXsCcRIhaWSMtzFoKLbpT+7jkP2oUXOQzZTwb0KOoYamOglkVQtWgskv8fAE/qtF/V+yQtqcsnJ3NGr9SrgwmL86Dhi1aTP93KLk7Jo29XzdFu7rz7fNzO4leKta7YafikMu8C07Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824916; c=relaxed/simple;
	bh=9yAwGCZHdgmyh1W/M4Ieg+n7bg/nBi73jrflY+JfztM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAB+6ZiRh9f+1kK5SxupVQ3DOpr3YK5+hn61BuBJZNSKU0duDiGrSa0QyVxAf8kpLBN3ZOEnG27cP2viBeT+6IZqUE7qeCByd0GgQbxc9RrKsYoCLjp1/wA1WdEtxDmdbsvQjIgRIA3zr1xtwqp+OgzVD3mO4TwZIjoFwhybXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yv32sMAq; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-690ad83d4d7so21692947b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723824914; x=1724429714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGB75WNp2k3B7jPw4mKOAIQo0L1IpYb0wqaeqHh4s6w=;
        b=yv32sMAqJhjfY4d/490XlQxNRr/9zncBJDEV/S9vJkxqjBEu8YJoh6gK5IAaiKtZDw
         ISPvf8K4v2RQCf3Hl05coFNYkjAARj+VWDtjGrYHBs8e0NVp06SLaicCiWS698ZoK21X
         RTTKUcbLBltEzCKdQG/RipJ0xIgq3fIf6AYHeNxNT5F5QrjwSrnCxFuhYM4hTLYq8fnm
         Paw7UUBmKYaXq48mvhYKGgJMmAPZA5tESRpxAe1n7oyOKrcvJiYzwDiOambjO9cK3NFm
         gn60OU3KFyWcWod0SCv+TO6EHRICiP4EZnLt29lWEOBBNLPAcj1274NbZu7+4QcW3zIk
         9QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723824914; x=1724429714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGB75WNp2k3B7jPw4mKOAIQo0L1IpYb0wqaeqHh4s6w=;
        b=fhD9prIQEtnCUC6n0x+9k7AeszCUXEvLDoy2zS35bs1UKd5ZqkOrNpE2CKZphCMckO
         1EOgORiNRXH3SMouS0bUEXP/CUr2IhhNnPxZ6zeK1aph+PErcl1bO2ZXGNMFnZ30wZRE
         8AemgWsJDNGJYySUtqzWeXAvPRKxGJSNgtWIglXYT+tkBWlbgdGmGhH06d6y2ot1GxfZ
         Ig3LPK1f/XT+GGcyKJpQRcZ5J95a/9T/Wkt4WDpvM8OB5CLTKS/V4oNV4QTumVeOGwom
         Azat3GXEGubGPs00jBuB6XStq1WBastjX0pHdWfGGlXqRK9WU3MU45o/PskCGKSufL5G
         fWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcmgtqTBcIPgaPgFqhAmUKPoxIvUtkGzEZoOFj82EYRjCwFZCdYnskOnPgEfu128qXLz5SiPPaPwPeMEJbp4JVRuT6CyGZs5ldDti8
X-Gm-Message-State: AOJu0YwT9J2KE0XPW49fNKIcAObXHQcHwECalrkTmzlU8wYFTwqzyaX1
	Ou3WiHJmWP5CARtZH5RjsRGW5y+VfiUscCHb0GGaFp3xGnZ1m5A6Bm9BLIM6Pt5XYByHyivvUq9
	bM01LxkpBQqkt8YpN+kjN0PgSlUE+D8SIZG9x
X-Google-Smtp-Source: AGHT+IGN9bKv/c0GyHlyxEeZPUueQdw36mZHlzwKYbGCbDIVXo6Qmf8fAlROL3QiPP9HsyO4r754ovZtBdYN34UZpiU=
X-Received: by 2002:a05:690c:c8c:b0:6b0:ea82:9760 with SMTP id
 00721157ae682-6b1b996ce64mr44413447b3.27.1723824913603; Fri, 16 Aug 2024
 09:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813204716.842811-1-kinseyho@google.com> <20240813204716.842811-3-kinseyho@google.com>
 <qh77aw6nnsytwtux6f2bkzmene3fzrh4skegvqktlw4b47jgea@oxovqnsrulef>
In-Reply-To: <qh77aw6nnsytwtux6f2bkzmene3fzrh4skegvqktlw4b47jgea@oxovqnsrulef>
From: Kinsey Ho <kinseyho@google.com>
Date: Fri, 16 Aug 2024 12:15:01 -0400
Message-ID: <CAF6N3nV3RPaiS9E4=-ABXQ-F++J=E8goSquN1cq2S_TuftUNxg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 2/5] mm: don't hold css->refcnt during traversal
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Thank you for reviewing this patchset!

On Wed, Aug 14, 2024 at 5:00=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Aug 13, 2024 at 08:47:12PM GMT, Kinsey Ho <kinseyho@google.com> w=
rote:
> > To obtain the pointer to the next memcg position, mem_cgroup_iter()
> > currently holds css->refcnt during memcg traversal only to put
> > css->refcnt at the end of the routine. This isn't necessary as an
> > rcu_read_lock is already held throughout the function. The use of
> > the RCU read lock with css_next_descendant_pre() guarantees that
> > sibling linkage is safe without holding a ref on the passed-in @css.
> >
> > Remove css->refcnt usage during traversal by leveraging RCU.
> >
> > Signed-off-by: Kinsey Ho <kinseyho@google.com>
> > ---
> >  include/linux/memcontrol.h |  2 +-
> >  mm/memcontrol.c            | 18 +-----------------
> >  2 files changed, 2 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 90ecd2dbca06..1aaed2f1f6ae 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -75,7 +75,7 @@ struct lruvec_stats_percpu;
> >  struct lruvec_stats;
> >
> >  struct mem_cgroup_reclaim_iter {
> > -     struct mem_cgroup *position;
> > +     struct mem_cgroup __rcu *position;
>
> I'm not sure about this annotation.
> This pointer could be modified concurrently with RCU read sections with
> the cmpxchg which would assume that's equivalent with
> rcu_assign_pointer(). (Which it might be but it's not idiomatic, so it
> causes some head wrapping.)
> Isn't this situation covered with a regular pointer and
> READ_ONCE()+cmpxchg?

Yes, that's a good point =E2=80=93 this situation is covered with a regular
pointer and READ_ONCE() + cmpxchg(). I'll make the change to remove
the __rcu tag and replace rcu_dereference() with READ_ONCE() and send
it out in v3. (This also rids of the sparse errors seen in v1)

Thanks for pointing this out.

Best,
Kinsey


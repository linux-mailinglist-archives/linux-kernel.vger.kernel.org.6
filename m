Return-Path: <linux-kernel+bounces-187019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A308CCBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051C01F21C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE713B58A;
	Thu, 23 May 2024 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SiDCqeyp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F958005C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716443618; cv=none; b=fyOW46XnlgZ4dAobr3BWWU0OEVKVRvhV59UH7IlCrlPwWaVv1nn190bGonLz8Jjj04H5dX01kAcN29i+l+q+MIQrIqL37TEY3PN33M0Qnc2MawqRLjaRwh3H2r4mfw5nCiUUZaM4JVObha949o+QGtEJCTOMllo6Z7kpFAkb1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716443618; c=relaxed/simple;
	bh=TScXAmQ7ItjsWXhE0MXY3TZ8XQzm4GmwG6Kh5HVmAL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzFmqEe7jwCTXTgbtEHvUS99jPOP8wlpvKUMGvg8r6eIRLhglyvA3YCbVMxXuSOInrptW3D6hZFmFrjYh4yGKmkvd1uSJLOvxj0T6N+TaU+PoTX5j7q8jPHtci4o/xys1Mqk+WpOY5kdsLUzSJ32fpyBP1YbW9H0Q1fENNNGwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiDCqeyp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so10971887a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716443615; x=1717048415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NE4Ia1OfNQ96VRogomKZai/04wbpvQ4U9VVM90Atwk=;
        b=SiDCqeypSL84xvCe30OPI0DGBH5AGSDCc0u5N6IyNaLmBl1mEA5WbJ6nsucuKnmqQw
         W5v3XGcKwH9sp7nIBdmpUObt0p3yl/325dLgNF1AF/lCWSOOFFf7STzpFGtVKvfKWhlW
         r2Jm54z4hDZ20PphUIAhD2WmDVKTVJoniKHKuHY9WKMjTwQS5l0mkDNPWr/odSQMloVu
         uswlydnqNUaQ7OPBeC0tgOyvw6BnejnFD0vaBPdYQDx6BzhaUf0Qer1t+N67pAFjYsMw
         P72ywxoSdPru+UeITYmV4qk1Ja5U7mvbsKIVQjfaYUgSRrIRI2t4h/l8f1dKNLk0uBxM
         QsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716443615; x=1717048415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NE4Ia1OfNQ96VRogomKZai/04wbpvQ4U9VVM90Atwk=;
        b=X1pyQ6rOrDKQOkVyqnKRwjF+WnaV2jZ+EIi6Mhv7ByLKCd3SwNrjH59CUWFReyVpyN
         Y7JoenPQz1EsUn8PPXgmTAAK0ERixHI5q+Nq9ZLw1xIZj7YkqjTCTylS2LI1Kw1yqUVd
         A0lvj7EofeWmCA0bLoC9aoxcBJ6uKJsmtFsBialv2fvHPEjZejyLWi1i9VBtuen3MccI
         tDR5GxhTK4DzkLuBQtEh5AQY2ptAbBpiUXWzlxaxXwFCHh15RSMvoqBQwlPwfryeKdhw
         S3xwo2vb2KrDk9dWX+k/x2mO4A+a9zEgRSpHMckuwE7tazw77UmbOY47WdcWMgReRY4b
         u8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ11UfMBYcs2UjvwAbP3Wt2MM34VQJgZnGKALyRxdBLAjKr47/0riAxQ6nLczYMJtrjONpFbd9f4LwRiRqOSVlt5cOBB14CF/wqnUS
X-Gm-Message-State: AOJu0Yxfr7ohBf5z0t4Qti8dgyJrFFC8+OB8WhRkM+wxf/R090M2Icb6
	mxNuq/xTfdMXvuwLcNiveiyMi3Dt5uFIdlpJu6Ihos+MFBPJUuNVuw6VAA4ypwT/s8tD3zqc3t/
	xcCj0rbYRgSjYg8PqYJTeekHGUgaqPEBvXWcN
X-Google-Smtp-Source: AGHT+IFRCEo0DSlUwuM9NVea1wb5doYjdeL4viv68jGc9TuZBAXigzRYsnoWu4zchKZ8TYpXIcX7MoZR9CHLoPoSDj8=
X-Received: by 2002:a17:906:fb04:b0:a59:a0c1:2624 with SMTP id
 a640c23a62f3a-a62280a0833mr246971666b.39.1716443615264; Wed, 22 May 2024
 22:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523034824.1255719-1-shakeel.butt@linux.dev>
 <CAJD7tkaaEn+2G46taRD1V1W=okBfZtPPOFFyj5A+MVfGzqPDqw@mail.gmail.com> <m4ixafl5ajnr6tgkjwead3bmgglqqcpfwsgqijb6mlz2rfgjtu@yi3jwlnfpqpx>
In-Reply-To: <m4ixafl5ajnr6tgkjwead3bmgglqqcpfwsgqijb6mlz2rfgjtu@yi3jwlnfpqpx>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 22 May 2024 22:52:56 -0700
Message-ID: <CAJD7tka2QnbjxZ=7YtRu-ufBUfREmayahsgR1_-oXhmYf8AQ9A@mail.gmail.com>
Subject: Re: [PATCH] memcg: rearrage fields of mem_cgroup_per_node
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, oliver.sang@intel.com, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:34=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Wed, May 22, 2024 at 09:35:57PM -0700, Yosry Ahmed wrote:
> > On Wed, May 22, 2024 at 8:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> [...]
> > >
> > >  struct mem_cgroup_per_node {
> > > -       struct lruvec           lruvec;
> > > +       /* Keep the read-only fields at the start */
> > > +       struct mem_cgroup       *memcg;         /* Back pointer, we c=
annot */
> > > +                                               /* use container_of  =
      */
> > >
> > >         struct lruvec_stats_percpu __percpu     *lruvec_stats_percpu;
> > >         struct lruvec_stats                     *lruvec_stats;
> > > -
> > > -       unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LI=
STS];
> > > -
> > > -       struct mem_cgroup_reclaim_iter  iter;
> > > -
> > >         struct shrinker_info __rcu      *shrinker_info;
> > >
> > > +       /* memcg-v1 only stuff in middle */
> > > +
> > >         struct rb_node          tree_node;      /* RB tree node */
> > >         unsigned long           usage_in_excess;/* Set to the value b=
y which */
> > >                                                 /* the soft limit is =
exceeded*/
> > >         bool                    on_tree;
> > > -       struct mem_cgroup       *memcg;         /* Back pointer, we c=
annot */
> > > -                                               /* use container_of  =
      */
> >
> > Do we need CACHELINE_PADDING() here (or maybe make struct lruvec
> > cache-aligned) to make sure the false cacheline sharing doesn't happen
> > again with the fields below, or is the idea that the fields that get
> > read in hot paths (memcg, lruvec_stats_percpu, lruvec_stats) are far
> > at the top, and the memcg v1 elements in the middle act as a buffer?
> >
> > IOW, is sharing between the fields below and memcg v1 fields okay
> > because they are not read in the hot path? If yes, I believe it's
> > worth a comment. It can be easily missed if the memcg v1 soft limit is
> > removed later for example.
> >
>
> For 6.10, I wanted to keep the change simple and yes, the memcg v1 stuff
> as a buffer between the pointers and lruvec/lru_zone_size fields. For

Fair enough, could we update the comment to explicitly mention this?

> 6.11 or later kernels, I am planning to use some asserts to make sure
> these fields don't share a cacheline, so later when we remove the
> v1-only stuff, the asserts will make sure we keep the separate cacheline
> property intact.
>

Makes sense to me.

With the comment update, feel free to add:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>


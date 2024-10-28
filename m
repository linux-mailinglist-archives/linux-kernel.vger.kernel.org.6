Return-Path: <linux-kernel+bounces-385454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB079B375B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06962813D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4421DF246;
	Mon, 28 Oct 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmF/e2PQ"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE613AD11
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135346; cv=none; b=Xa9jr8/FvjLQQ1/11FtZ8lA2Vjdarp4Kx9+bNORQX0xByu1gU2y99VpXak4qcjr12uP5cir/IJiHA3G+csE1cq4WWYD0zTI8sDN5K3yRBfdesnKm5CzdOd951bWhC8D1K9E5u0J+dYvW5QVqimc6iOvF9bMeXeh/f9seHWIbDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135346; c=relaxed/simple;
	bh=hVYwHgZdQjvMKbrkzQEcpOl++/2Fy888VkRK7VN6y2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWSNHkQSaBbkpEFcskNpx9OkOzu/ZQdve0AbHc6Vur8kLZnwNvzFfH+PK26gdohVCXeWIcDUX9OFWPz5jSzustssMfUScCiOMPktStS2CroItF9Em9/lWqsJd6iBKeFzcFLDALGQC0qN3A3zkYs5ckfShdl8LIk87ejVF2FgV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmF/e2PQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbf0769512so30867166d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730135344; x=1730740144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVYwHgZdQjvMKbrkzQEcpOl++/2Fy888VkRK7VN6y2k=;
        b=TmF/e2PQzG5WmrB4pPqRCDEpGHJsudCNOVYvW2yfX8ZlfkW7dYyTXVGwbb+2Zfa0ni
         hsHpUXR4T2Rbnw2zzKsq+tsscvfxWk+e5X3U4tRUk9RPhn3cdltNvjLg+wYexnYVYazU
         Vpa+kdGR2PLXuSZl5ivAKOQlQoS3VnQHoVfMnzjzZFQWLCxb++Hj3CRpRJvAOc0EUNdR
         CfylkLfCpepZAcqCxrOG0IfqJAPXBMtBtbEQpCNaFNONCoieGa2Q9hYVN45ShgtTENqK
         0IQkGTOmD7+dTKm9ifYkxntE80JxvmsUXz7FzqVbO1ZKjVa421dS4oytkcWNpPEKzr4A
         GgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135344; x=1730740144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVYwHgZdQjvMKbrkzQEcpOl++/2Fy888VkRK7VN6y2k=;
        b=V5Mn2YYkrvt+6OZKG38RpxyHG/WVw8EiTdYy2gOIax+tnLEJjT+O5qica10/MFBmwj
         +uxBFu0v47IJOHzXZNH4S0tcvYxTZDGb7MHKUKPYxcyu+Q8q4VihtI7jPl2iAthEXVoG
         V+BJAc7EOv874S936mD2TcKvHG/QbYPW8cDw/VtLjTl3n6VRSkLm+LVNQIrEQeCUs1bB
         4RqWHCCCOO8Kl71c6Fx3TAYehGngE5JTCUxIyTGsXrymdYLSi0DyUsOMmXXYu/hdwErI
         0rhfVz0hoI+O8WnAYWFSWacrzSIEHvjkDhtzkqLwkhD5nMp1l5sPGpbCFf1cf1h7RriX
         kn+A==
X-Forwarded-Encrypted: i=1; AJvYcCV1MR/7/68D+LGIze5adhmPcR01BjW277qNnoyIqtBS3p27bF7Rj7bb1KN5TtP6NcaMo9qzc3QFbuf/X3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55cTfjgmaHCf6pZh1KjYfvYOgsSn/Mv8DD52hfORL+rQ/lbTd
	LHngU8cmx4noSkmYag/FSYExwomKnpNVWc98oPoUGoYnjcamp1vSY28qO98V5piFQiIi96y930A
	/i9NAAOrPbccEmsoQXyXaFXNUEAvnCFwrBWYy
X-Google-Smtp-Source: AGHT+IEf8Xan5YN2lxVFxkPlg5MJ8Vug9skFQs3j11e9BUUzumrE5tyW5bdmM5Xp8uNUl5TYbvlM0f6UV9BYTCns0FE=
X-Received: by 2002:a05:6214:4588:b0:6d1:8261:174f with SMTP id
 6a1803df08f44-6d185816d6fmr136359396d6.36.1730135343409; Mon, 28 Oct 2024
 10:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com>
In-Reply-To: <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 28 Oct 2024 10:08:26 -0700
Message-ID: <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 10:00=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 28/10/2024 16:33, Nhat Pham wrote:
> > On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >> I wonder if instead of having counters, it might be better to keep tra=
ck
> >> of the number of zeropages currently stored in zeromap, similar to how
> >> zswap_same_filled_pages did it. It will be more complicated then this
> >> patch, but would give more insight of the current state of the system.
> >>
> >> Joshua (in CC) was going to have a look at that.
> >
> > I don't think one can substitute for the other.
>
> Yes agreed, they have separate uses and provide different information, bu=
t
> maybe wasteful to have both types of counters? They are counters so maybe
> dont consume too much resources but I think we should still think about
> it..

Not for or against here, but I would say that statement is debatable
at best for memcg stats :)

Each new counter consumes 2 longs per-memcg per-CPU (see
memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
quickly add up with a large number of CPUs/memcgs/stats.

Also, when flushing the stats we iterate all of them to propagate
updates from per-CPU counters. This is already a slowpath so adding
one stat is not a big deal, but again because we iterate all stats on
multiple CPUs (and sometimes on each node as well), the overall flush
latency becomes a concern sometimes.

All of that is not to say we shouldn't add more memcg stats, but we
have to be mindful of the resources.


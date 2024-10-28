Return-Path: <linux-kernel+bounces-385726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A3B9B3AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63A2282AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A41DFD83;
	Mon, 28 Oct 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MERr9wKg"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E91DF25A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145568; cv=none; b=Qs6XXMGmZztCBFjdr9aUxWDwE5TShUgi7k7UWys1kNTrM6qoKYHET7whMdOYuvK6jD16nXcGmOUwkkyuB/UwHJrWKRuR+kXPDvOWcVBouW/7SDVHRaNEzCcHLn8MWZxESwIabmXDu5gY2yeUW/VvILk2EyrShKzA4TUi/PqNad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145568; c=relaxed/simple;
	bh=bzK8bSJWPNgz0T4X+RKgoWG+FMl2NSfatdicRFAzrw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAyXmARkqPS9LXvPo9A415jL+mqSWXYNHm40SsLxcXzksGinXfbgWgLIT44oLu02cYmLFWsP9zxPQ/FYCLRdFztuIa+YhlQd+XALyMLsLj3Rbf0867+pq1kmPLm1On0ffVMNuzX/LikjX6iV9oEcZxVf7Muk8YQNSWbJpgYKAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MERr9wKg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso29272196d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730145565; x=1730750365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzK8bSJWPNgz0T4X+RKgoWG+FMl2NSfatdicRFAzrw0=;
        b=MERr9wKg2c0abcVWAL3VMuM1wATJeZL6Ft7VDmcbuResw4lO+nAegHTO05dGinlL0L
         4gt5gNt9h2m+I76bBWC+fPvu0PUBigl5pxgo1/0rripY0XMfrVxbgtpEQFGUDTgrzpyH
         dTMhaq0INpw8T1AHxI7zkJvdFKZTdE+EmRF8hPvnqfy1YPVz9RjyN+mVcjPU+TnbHvxX
         OQSpwsNZmBm+UsIAzFppdDpDGC4pNLv+EGge/KQeuH21M+uaG7kUH2A7VKRUZeuQOfO4
         SGqBhvunoiL0tkUpJJDHH4BS//rSVblfMwO3j+pHEL5V/rCBlj3QO2K7amh+jnyW4I9U
         AaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145565; x=1730750365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzK8bSJWPNgz0T4X+RKgoWG+FMl2NSfatdicRFAzrw0=;
        b=GkjwzRAJE0qozlovc629raQxdWYGFGN8KfrF24hlUgYs5J19SSX7z8XG9wbLkmqdND
         8dL5c5xSDgqA8efQJyG29j7+6jEchB9emOMm1/wA6LjGNQ4QJhQTkPDm7poXa90omuKG
         Of4h5v1IwoQ4EUXERsVlSDAmJK9SiIfcLzvLnyglkZv86EReGBdLFd2AMnI5A3wl/vxg
         Jq56avpex0VWNsKZQee+uKJJC+VE6PDVD57cGAE1/tSFEEjDNyF5/yzei771d9q4dRVv
         I9JWoVraQytsOBpixoIPSRpjOhPbVEaOzGSQ+RVSBUOhcdWlPgVYCqmN3W+9BHOkSaSF
         0U5w==
X-Forwarded-Encrypted: i=1; AJvYcCXOMxoXyoBfATdtx01roqIU3gdsyQvL9sA4oX65/0sEBrNvF/0LkbKsGmevnsQNfPzehEdKjM5OJ+lubuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPEQhtj6oexxyIEN5sZyLrfu3iQc1Y/mZ8nwTE/pYuYUAugjW
	CM49wU6hTUEeWHz28547gzzXVSaztnw4HnyjFEQAFTSapsRqSl7WzUOBGzEAIo+sx2WUMA08Faj
	HySV2D6P+CRvp93MDrlLA7xiHJtepALNw4IRy
X-Google-Smtp-Source: AGHT+IG88AsOvVV2ML4+CNKXrKvi7+ZeC2LKq1piSFh+j2GY6sy2X5YWIr3GwjtASAX89CsNlSbS5yb0Q3NcFrIMXT8=
X-Received: by 2002:a05:6214:5705:b0:6cb:c994:160b with SMTP id
 6a1803df08f44-6d18580d0edmr169199966d6.18.1730145564954; Mon, 28 Oct 2024
 12:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com> <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com> <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 28 Oct 2024 12:58:47 -0700
Message-ID: <CAJD7tkYUAeEYiX0OLTUPh7x23aT82sUrits0US47Phjioa-tKQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:54=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Tue, Oct 29, 2024 at 1:20=E2=80=AFAM Usama Arif <usamaarif642@gmail.co=
m> wrote:
> >
> >
> >
> > On 28/10/2024 17:08, Yosry Ahmed wrote:
> > > On Mon, Oct 28, 2024 at 10:00=E2=80=AFAM Usama Arif <usamaarif642@gma=
il.com> wrote:
> > >>
> > >>
> > >>
> > >> On 28/10/2024 16:33, Nhat Pham wrote:
> > >>> On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> > >>>>
> > >>>> I wonder if instead of having counters, it might be better to keep=
 track
> > >>>> of the number of zeropages currently stored in zeromap, similar to=
 how
> > >>>> zswap_same_filled_pages did it. It will be more complicated then t=
his
> > >>>> patch, but would give more insight of the current state of the sys=
tem.
> > >>>>
> > >>>> Joshua (in CC) was going to have a look at that.
> > >>>
> > >>> I don't think one can substitute for the other.
> > >>
> > >> Yes agreed, they have separate uses and provide different informatio=
n, but
> > >> maybe wasteful to have both types of counters? They are counters so =
maybe
> > >> dont consume too much resources but I think we should still think ab=
out
> > >> it..
> > >
> > > Not for or against here, but I would say that statement is debatable
> > > at best for memcg stats :)
> > >
> > > Each new counter consumes 2 longs per-memcg per-CPU (see
> > > memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
> > > quickly add up with a large number of CPUs/memcgs/stats.
> > >
> > > Also, when flushing the stats we iterate all of them to propagate
> > > updates from per-CPU counters. This is already a slowpath so adding
> > > one stat is not a big deal, but again because we iterate all stats on
> > > multiple CPUs (and sometimes on each node as well), the overall flush
> > > latency becomes a concern sometimes.
> > >
> > > All of that is not to say we shouldn't add more memcg stats, but we
> > > have to be mindful of the resources.
> >
> > Yes agreed! Plus the cost of incrementing similar counters (which ofcou=
rse is
> > also not much).
> >
> > Not trying to block this patch in anyway. Just think its a good point
> > to discuss here if we are ok with both types of counters. If its too wa=
steful
> > then which one we should have.
>
> Hi Usama,
> my point is that with all the below three counters:
> 1. PSWPIN/PSWPOUT
> 2. ZSWPIN/ZSWPOUT
> 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
>
> Shouldn't we have been able to determine the portion of zeromap
> swap indirectly?

What about swap entries that get freed without being swapped in (e.g.
swapped out anon memory freed, MADV_FREE, shmem truncate, etc)?

>
> Thanks
> Barry


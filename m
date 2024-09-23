Return-Path: <linux-kernel+bounces-336367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19638983A32
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66071F22AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF70126C05;
	Mon, 23 Sep 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyP3gfTc"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E47F460
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131131; cv=none; b=AYzAV+O1N239x6AiIKJaFQSpSZ4TVVQLyeGaMDMeRLQ4HtVxLX0qYEtuelFuWbxw6Dnz43JwjIjGX87LWAeGXyviSdgzNlyZtP/eWSjpQbtNGB5ZwYEqdn1yhXs8HaFIxiXBzqrXVEhpmBCcYRKb/K4E7s9K3QjFnFEKgpHR/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131131; c=relaxed/simple;
	bh=ieQiIqp4mUc0jaqrAQ7oZWNURsFcF+oahPDsRs9kBnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YySR4OvCIMeY6ATqjdskxJkmVbQbInQywOYyV4XfnSreu+72qEtR4hG1u/3HSDkigc4fIi0f2wqkS4ciNOxOd4CzTvYnFtZgVZfA25hqdkdPtbiGzEwhZfXXxjZhXMXs4lEezDAfAoQcqXaHqvjqgaJKbK7pPW7tjV+j6qFx7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyP3gfTc; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49bd7809c84so1553588137.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727131129; x=1727735929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieQiIqp4mUc0jaqrAQ7oZWNURsFcF+oahPDsRs9kBnQ=;
        b=OyP3gfTcfAheOMspaiZkq6pRHrbalHX4bSOL7xeNTpI3sbeJ/q6u7rRinQhl/Ag0r+
         +/6RJ7Xgdul7J5iHipONp7qmdi/zGr1IVjGANY4lnz29kEX3vP3C0yImtUE72bEEwgf5
         lV9tYe61h81ZVjffYUVslxpOQiCRJFlYlJrUlmyc/dwz4pYNR2VJgJjH2AAKcNR6EqeD
         KZaNBsbblbSCHTjYZjc9M+4CZw4fLaomIK8cPIbLL7Z0Ge5do+9CamcqkaMH+qe/CAP7
         haWA+ltNH+AUwFzQ3S6bQaZY+nkYPv/1pUuqG5NwGZtF7lP+iZhdnFSWpRFw6uUkrJNo
         5d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131129; x=1727735929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieQiIqp4mUc0jaqrAQ7oZWNURsFcF+oahPDsRs9kBnQ=;
        b=RBTAq0TIFgAQduCrO60fl/F7eqa665yDpftNXzywclfnzUKEqk+KLTFpye3h/6yXex
         /CWyxXZ+HrRbnqi0cGkGDoJGLRKH6RoprnYqVQrhNedHWOuFoBDJooQuhzAaFqZc8ib1
         BgcDD4o6lFVgcU14lGqlM6RqueG7L4pOHMiX2fIp+zOvgUmS9LJBYmgZgGtNSui3b/GV
         75O5vzRj2tBsZ3LnaCQmowOBE+PZXVCjInWvZU8CuhOg7c6Xgde9E3L8IlxZIjUFVF8/
         4DREgv/l1npeSvE8vK5C02VbG3yUhh0T+wSdjO6WuvKIu1Bib0H9ox4UjY2ZY9ah6+MV
         w1YA==
X-Forwarded-Encrypted: i=1; AJvYcCVE5c7IS1FX+YgmUREha+6PuE2phJIwz7fn/otUn2h96VrEMuCYS8OKJOn+VV3tWTs60dGK+mK77x+UJOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVubnFm+YQ2ngXItFkKWldk+sOCH5A8sIp3a5hm18w4UsCRk+
	aH5gtbA76t18I+z51Jmir6hcXRpmYW06LISBaBeUFJlkzyklsZ17opNRTWFPmfI37Fz9JB090dZ
	Fdxqq/CfaNPQ3udPeNV9SsApVHnyLaT8Eczk=
X-Google-Smtp-Source: AGHT+IFgBa+rRuJXH89S8k+th0g/DzvyW19043d/dOWE/cReImEge/pzPQpG9Z0RNe1xCE77XrqFrFmM/WdHfVLicBE=
X-Received: by 2002:a05:6102:442a:b0:49b:cfbc:63ac with SMTP id
 ada2fe7eead31-49fc7532c9emr8946718137.6.1727131128647; Mon, 23 Sep 2024
 15:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914063746.46290-1-21cnbao@gmail.com> <92f97c8e-f23d-4c6e-9f49-230fb4e96c46@redhat.com>
 <CAGsJ_4zdqXtvUS8fHzUhM=iGrPpC8X7uw8wt4sSfCvsrh7um3w@mail.gmail.com> <ZvHpYqzt9Rj5W8mt@google.com>
In-Reply-To: <ZvHpYqzt9Rj5W8mt@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 24 Sep 2024 10:38:37 +1200
Message-ID: <CAGsJ_4xKuY4P2e4KFJ4pA0Q53b+tOn5ki3An0ZiciH08ZBhr+w@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon folios
To: Minchan Kim <minchan@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mhocko@suse.com, fengbaopeng@honor.com, gaoxu2@honor.com, 
	hailong.liu@oppo.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	lokeshgidra@google.com, ngeoffray@google.com, shli@fb.com, surenb@google.com, 
	yipengxiang@honor.com, yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 10:19=E2=80=AFAM Minchan Kim <minchan@kernel.org> w=
rote:
>
> On Fri, Sep 20, 2024 at 01:23:57PM +1200, Barry Song wrote:
> > On Wed, Sep 18, 2024 at 12:02=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> > >
> > > On 14.09.24 08:37, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > This follows up on the discussion regarding Gaoxu's work[1]. It's
> > > > unclear if there's still interest in implementing a separate LRU
> > > > list for lazyfree folios, but I decided to explore it out of
> > > > curiosity.
> > > >
> > > > According to Lokesh, MADV_FREE'd anon folios are expected to be
> > > > released earlier than file folios. One option, as implemented
> > > > by Gao Xu, is to place lazyfree anon folios at the tail of the
> > > > file's `min_seq` generation. However, this approach results in
> > > > lazyfree folios being released in a LIFO manner, which conflicts
> > > > with LRU behavior, as noted by Michal.
> > > >
> > > > To address this, this patch proposes maintaining a separate list
> > > > for lazyfree anon folios while keeping them classified under the
> > > > "file" LRU type to minimize code changes. These lazyfree anon
> > > > folios will still be counted as file folios and share the same
> > > > generation with regular files. In the eviction path, the lazyfree
> > > > list will be prioritized for scanning before the actual file
> > > > LRU list.
> > > >
> > >
> > > What's the downside of another LRU list? Do we have any experience on=
 that?
> >
> > Essentially, the goal is to address the downsides of using a single LRU=
 list for
> > files and lazyfree anonymous pages - seriously more files re-faults.
> >
> > I'm not entirely clear on the downsides of having an additional LRU
> > list. While it
> > does increase complexity, it doesn't seem to be significant.
>
> It's not a catastrophic[1]. I prefer the idea of an additional LRU
> because it offers flexibility for various potential use cases[2].
>
> orthgonal topic(but may be interest for someone)
>
> My main interest in a new LRU list is to enable the system to maintain a
> quickly reclaimable memory pool and expose the size to the admin with
> a knob to decide how many memory pool they want.
>
> This pool would consist of clean, unmapped pages from both the page cache
> and/or the swap cache. This would allow the system to reclaim memory quic=
kly
> when free memory is low, at the cost of minor fault overhead.

My current implementation only handles the MADV_FREE anonymous case. If the=
y
are placed in a single LRU, they should be able to be reclaimed very
quickly, simply
discarded without needing to be swapped out.

I've been thinking about the issue of unmapped pagecache recently.
These unmapped
pagecaches can be reclaimed much faster than mapped ones, especially
when the latter
have a high mapcount and incur significant rmap costs. However, many
pagecaches are
inherently unmapped (e.g., from syscall read). If they are placed in a
single LRU, the
challenge would be comparing the age of unmapped pagecache with mapped ones=
.
Currently, with the mglru tier mechanism, frequently accessed unmapped
pagecaches
have a chance to be placed in a spot where they are harder to reclaim.

personally I am quite interested in putting unmapped pagecache
together as right now
reclamation could be like this:

lru list:
unmapped pagecache(A) - mapped pagecached(B) - unmapped pagecache(C) - mapp=
ed
pagecached with huge mapcount(D)

A and C can be reclaimed with zero cost but they have to wait for D and B.

But the question is that if make two lists:

list1: A - C
list2: B - D

How can we ensure that A and C won't experience many refaults, even though
reclaiming them would be cost-free? Or that B and D might actually be
colder than
A and C?

If this isn't an issue, I'd be very interested in implementing it. Any thou=
ghts?

>
> [1] https://lore.kernel.org/linux-kernel//1448006568-16031-15-git-send-em=
ail-minchan@kernel.org/
> [2] https://lkml.org/lkml/2012/6/19/24

Thanks
Barry


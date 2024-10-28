Return-Path: <linux-kernel+bounces-383899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F1A9B218C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37211C208EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 00:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3EB6FB6;
	Mon, 28 Oct 2024 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="078OBQMW"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24744A11
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075134; cv=none; b=sl+R4mTvH6ZMWSuGK4d0mX9N6aZ8QmaLQ0txphE4XpiRY+DlnGviYEjhE/2+EGptSG+JvMvu0cs0sr2eZJXOYVoOxYvcEimoF/nVukPk/YgELvFQsDizVoLC7kQzzK9O+23AJzhkofhDrP6sAHi76IjNG1+GgpgemsPA5+IbWIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075134; c=relaxed/simple;
	bh=6Exmuwcg0qlmPlUZ27wK6bMJyM2Kn+WmfeYT+nUTkKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KS7EK60oTx5gcyg6H2OfcDw5VTo/RXIYc4eXSA7cFzfZw6t3RyLcotMHhnE3V65QE/JWeFJLUK+KMrqz3HS39vpiX/BIVCVItrDIejPaT9gRlyiRMq/4AgSUbeHMxoaAXuv4w+6Tu9U9rPQ1/PCzl+JNV35HxMzD1TJBdN2PupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=078OBQMW; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a484e9d537so1135708137.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730075131; x=1730679931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Exmuwcg0qlmPlUZ27wK6bMJyM2Kn+WmfeYT+nUTkKI=;
        b=078OBQMWdr5jKcV2hh4wZV7DDWz+9eibBmInnFWAb3Ve+HiK40ySOv2Y0ya4hMhFSe
         vznful+AwyFzWto8S9hpSBVi+2XDqAtJZMIirukfCI5tZjERYeOBdwIyYVZ5+Q34C7li
         thKpCCJieqyi9hxWosjhb4dBFq141O+fuImOJI1GOZRvTJ7sRQxJWVjMHR03ZR6445t2
         19UBDb4HSCySGlv6G0mHKBNp9TVb0s6XaYpmfjI/ZZlZ0E2brYCDn6OBc1o2MnOt2KFO
         qskwuZ4+u7tVm8CnhmvwQAkpNWtzV4lKfrefFmWOMQ91AHdyiaskgFWNT3fsq6N1SJDf
         GujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730075131; x=1730679931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Exmuwcg0qlmPlUZ27wK6bMJyM2Kn+WmfeYT+nUTkKI=;
        b=bane1l8HZy6L9Aov7AgE/wSNRPH6OqISehlottbs+0hggaZQfYPJkhwgzSIqLEOW91
         komvq/c2sayoqd/Z+kvchthBsccrywJiyAiJFWwUFxNksfcqYat8cur6xZNgMB7+W33z
         0+4XrW344ulBAMhwJJo6FlXlJN4NMme3E6rJRYa4XZ2QlBU4oVCVCcu5wFCKfAzkqkRb
         yBa0kPNoyutYKz+AZaSJDD+qCHY+1hBco1fLZK62kkfKFwSIQvGCBFGYt8bofHcxQDuO
         hWIxIjJLVP3eDi58UtLPLhuY7vTqbV9Dl/9Cm3tIu5yROvR8/ovtH+L0sZkqIGWTjA4l
         se/A==
X-Forwarded-Encrypted: i=1; AJvYcCUyPQUVMz4D1n98QJkYjyOXotMpZnlHU0jd0G7pSwkvOVYGnA4u1rIaDD9nOPWnvJ6u/1UZWVNYNlAOL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzznba9cZDYs7CeDo+RKpCoHQFspfRvroNwXsnVkBXxvdSWdazI
	/KWLaG9mVbj2JWtThp+GA6AJP2COoiKcNy/hX0qFEds9EQyT9qLYqv9HWR1HpE4Z8NXJHkcxoZS
	DIb+3oUdkxqZqnDz9F8CedkK0xdvj3HCltisb
X-Google-Smtp-Source: AGHT+IFSJBZecszQ20YVP/M3LwFCJvvvxHjk0DXh985IX3HUMPgl7i2cj+lXxs2d3KZP5jUlYop583LH85GYa/xWD7k=
X-Received: by 2002:a05:6102:c86:b0:4a4:8928:7181 with SMTP id
 ada2fe7eead31-4a8cfd69b87mr3199010137.29.1730075131439; Sun, 27 Oct 2024
 17:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026033625.2237102-1-yuzhao@google.com> <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
 <CAOUHufaS-dGAPGs1Y1=imW_nusaTDeysN3qfJc9-76DBVEHScQ@mail.gmail.com>
 <8459b884-5877-41bd-a882-546e046b9dad@suse.cz> <CAOUHufbHVXNZpW1mVhuF+4p8PbPq44w4chQX7Q6QYVDCjSqa1Q@mail.gmail.com>
 <6ac7a38f-30df-4403-8723-a43829bcdba5@suse.cz>
In-Reply-To: <6ac7a38f-30df-4403-8723-a43829bcdba5@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 27 Oct 2024 18:24:54 -0600
Message-ID: <CAOUHufYyEjDG1+MEqRhuWPL037aSqrDhi_FT5gfyktbpQBmDVA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Matt Fleming <mfleming@cloudflare.com>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 3:05=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/27/24 21:51, Yu Zhao wrote:
> > On Sun, Oct 27, 2024 at 2:36=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 10/27/24 21:17, Yu Zhao wrote:
> >> > On Sun, Oct 27, 2024 at 1:53=E2=80=AFPM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> >> >>
> >>
> >> For example:
> >>
> >> - a page is on pcplist in MIGRATE_MOVABLE list
> >> - we reserve its pageblock as highatomic, which does nothing to the pa=
ge on
> >> the pcplist
> >> - page above is flushed from pcplist to zone freelist, but it remember=
s it
> >> was MIGRATE_MOVABLE, merges with another buddy/buddies from the
> >> now-highatomic list, the resulting order-X page ends up on the movable
> >> freelist despite being in highatomic pageblock. The counter of free
> >> highatomic is now wrong wrt the freelist reality
> >
> > This is the part I don't follow: how is it wrong w.r.t. the freelist
> > reality? The new nr_free_highatomic should reflect how many pages are
> > exactly on free_list[MIGRATE_HIGHATOMIC], because it's updated
> > accordingly.
>
> You'd have to try implementing your change in the kernel without that
> migratetype hygiene series, and see how it would either not work, or you'=
d
> end up implementing the series as part of that.

A proper backport would need to track the MT of the free_list a page
is deleted from, and I see no reason why in such a proper backport
"the counter could drift easily" or "the counter of free highatomic is
now wrong wrt the freelist reality". So I assume you actually mean
this patch can't be backported cleanly? (Which I do agree.)


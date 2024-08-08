Return-Path: <linux-kernel+bounces-280152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552BE94C667
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7EB1F2530C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5C15D5DE;
	Thu,  8 Aug 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBwZsufc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFC158D8F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153395; cv=none; b=Qv8qv0T+ygfG1yfvRrUo5FH+6GfinVf1sPuURT+3ujmPiQrx88bA8Av2Um6yHf1RiPnjz9OXXEhyXIACPDeJfq+8kaVU4ezNkcHeXLNnpNQ2p/rxP9ZLFirGSEqT3Pa5hBonl9hjQcdbdCNO8ZfxB7b031GEm0eNUsW9StyZbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153395; c=relaxed/simple;
	bh=F3HAG9cERt0HZrldBR6qvUxJ0ROrnb/caFVAXJMZG9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptR3Oxpc9UYAs0ozB3fRo+MeyKOk22uH9JkC01tcU/g8dobJFcHQNzN1x309R/yfsJc69t2YXtowBgWhMqLcwINsF/4MUkKy5DYZUHjna/+g4ypIb/sdXFZJO4ZHSK79v300pmkS/e2CF/VzP+TffyDf8EvmdlBV++tdpCTGgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TBwZsufc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so624a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723153391; x=1723758191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3HAG9cERt0HZrldBR6qvUxJ0ROrnb/caFVAXJMZG9w=;
        b=TBwZsufcW8bQPI1pZRqOZJrIoRNdrlIpPfJfPoRCd0I0+ltY370IlpL4WiLzYtdw+a
         udJykwL++144sim/JbPRfarSD06bQbNkr+yjgbGtbcukMf0Dnetix8b4h1Wv7tCi8EOr
         x8N/iX4d+oBQi0Q2NM4I2Huu8HKcbPLcmerhXuk08sQArZXW/OC3keSrVgh4UGUVxwoK
         rshy9GzFOb3iDuuVpqAT1EsR18SLonzwBaPdpA3z9QDlE8R1Fk6v5l+GulsSi28RmPUq
         tvYwwP7rfntUUoI5NPI8SXQ9n7XZLQ7nDG1rLdoN3X9eghsZv86hK9HspOlwS8yg0N6J
         e9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723153391; x=1723758191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3HAG9cERt0HZrldBR6qvUxJ0ROrnb/caFVAXJMZG9w=;
        b=DjySpLgIDTLoR69UZj66pHs6FJWBXqDiCVohJRHVCZpefWNWTtL9kyqrHf2W1hEHlG
         yABRd5A1r2leLMigdvHApNqj0vvEBCK5Kt2KfFq5zVWX31JqFkN6C8tHfNTVWKrYH3gG
         1GYnjwwebVz+yWiWb4FZmo6ep3XWV+U/ppnN6wjbfp94GRZIDF4PewhvPFe547hwkOTd
         FzJiNdR0PSCCO9Vxt3OIyjItYBDGynvpAtD8XC6quoEYGHPe295LLdv/AIi8ptfgbd9T
         XiskzkDc4aHik9S3oKJzR1FN/rlxSyst0ZEaTLrZx7R2tpA0bGyZVchzCJZeEOOoULSo
         DLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwMkAMHlMd2MfkxRJsLMbiYAkvk/exhwsKsT0hr+Ud4EsGCzwkpxdIeo4wrMhZ3TfdUcqHf4cBCPnCIMpdi/Ql66nDtDB2geDoIhpn
X-Gm-Message-State: AOJu0Yz6DdKbQzmDB8XSQSfurO/QBTro9xKcDWHwr0p0stQEyXR6IHy1
	bi7T9bsI2ev4zL7FW10qsg1mJOmuM2DAs3FR4vFMBkU8YChxqHL3vM/NYVx0I5287WV5Op3/lsr
	YHB6KFBy2rGDd6KmslRXiklcrxByL6DXv8xGd
X-Google-Smtp-Source: AGHT+IEH1V3AUKZFLyjOwF0Qksh4Jg69gvv/7gEV5z4JKgxe7+5RAl2VUU75yiE7fK1wQur24yXm5KzLy8M6xQfmK9Y=
X-Received: by 2002:a05:6402:350b:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5bc4b4363f2mr17670a12.7.1723153390883; Thu, 08 Aug 2024
 14:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807182325.2585582-1-surenb@google.com> <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
 <CAJuCfpHsvhjYxj=aovZjTd2qUvJWHpcnEn1kYfd0m23HVrPwDg@mail.gmail.com> <CAEf4BzYqKAaGE6GEcMs9MTcrV4cA+i0M5pniqFTy1LQ+g0Yxkw@mail.gmail.com>
In-Reply-To: <CAEf4BzYqKAaGE6GEcMs9MTcrV4cA+i0M5pniqFTy1LQ+g0Yxkw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 8 Aug 2024 23:42:33 +0200
Message-ID: <CAG48ez08f0GNfkqtKa3EV6-miRs3AbXej9WdVh4TvB8ErA6S3w@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > Add helper functions to speculatively perform operations without
> > > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > > write-locked and mm is not modified from under us.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > ---
> > >
> > > This change makes sense and makes mm's seq a bit more useful and
> > > meaningful. I've also tested it locally with uprobe stress-test, and
> > > it seems to work great, I haven't run into any problems with a
> > > multi-hour stress test run so far. Thanks!
> >
> > Thanks for testing and feel free to include this patch into your set.
>
> Will do!
>
> >
> > I've been thinking about this some more and there is a very unlikely
> > corner case if between mmap_lock_speculation_start() and
> > mmap_lock_speculation_end() mmap_lock is write-locked/unlocked so many
> > times that mm->mm_lock_seq (int) overflows and just happen to reach
> > the same value as we recorded in mmap_lock_speculation_start(). This
> > would generate a false positive, which would show up as if the
> > mmap_lock was never touched. Such overflows are possible for vm_lock
> > as well (see: https://elixir.bootlin.com/linux/v6.10.3/source/include/l=
inux/mm_types.h#L688)
> > but they are not critical because a false result would simply lead to
> > a retry under mmap_lock. However for your case this would be a
> > critical issue. This is an extremely low probability scenario but
> > should we still try to handle it?
> >
>
> No, I think it's fine.

Modern computers don't take *that* long to count to 2^32, even when
every step involves one or more syscalls. I've seen bugs where, for
example, a 32-bit refcount is not decremented where it should, making
it possible to overflow the refcount with 2^32 operations of some
kind, and those have taken something like 3 hours to trigger in one
case (https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2478),
14 hours in another case. Or even cases where, if you have enough RAM,
you can create 2^32 legitimate references to an object and overflow a
refcount that way
(https://bugs.chromium.org/p/project-zero/issues/detail?id=3D809 if you
had more than 32 GiB of RAM, taking only 25 minutes to overflow the
32-bit counter - and that is with every step allocating memory).
So I'd expect 2^32 simple operations that take the mmap lock for
writing to be faster than 25 minutes on a modern desktop machine.

So for a reader of some kinda 32-bit sequence count, if it is
conceivably possible for the reader to take at least maybe a couple
minutes or so between the sequence count reads (also counting time
during which the reader is preempted or something like that), there
could be a problem. At that point in the analysis, if you wanted to
know whether it's actually exploitable, I guess you'd have to look at
what kinda context you're running in, and what kinda events can
interrupt/preempt you (like whether someone can send a sufficiently
dense flood of IPIs to completely prevent you making forward progress,
like in https://www.vusec.net/projects/ghostrace/), and for how long
those things can delay you (maybe including what the pessimal
scheduler behavior looks like if you're in preemptible context, or how
long clock interrupts can take to execute when processing a giant pile
of epoll watches), and so on...

> Similar problems could happen with refcount_t,
> for instance (it has a logic to have a sticky "has overflown" state,
> which I believe relies on the fact that we'll never be able to
> increment refcount 2bln+ times in between some resetting logic).
> Anyways, I think it's utterly unrealistic and should be considered
> impossible.

IIRC refcount_t protects against this even in theoretical, fairly
pessimal scenarios, because the maximum number of tasks you can have
on Linux is smaller than the number of refcount decrements you'd have
to do in parallel to bring a pinned refcount back down to 0.

I know this is a weakness of seqcount_t (though last time I checked I
couldn't find any examples where it seemed like you could actually
abuse this).

But if you want a counter, and something bad would happen if the
counter wraps, and you don't have a really strong guarantee that the
counter won't wrap, I think it's more robust to make it 64-bit. (Or an
unsigned long and hope there aren't too many people who still run
32-bit kernels on anything important... though that's not very
pretty.)


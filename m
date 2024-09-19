Return-Path: <linux-kernel+bounces-333114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE697C413
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890C21F22A75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B614A4D2;
	Thu, 19 Sep 2024 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ayshrwd"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9614B064
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725621; cv=none; b=ooYulArhGdlDH12rIZLHg3EHJQ8epmDcOLKf1AWmnKDb3iq7xtDMTGOiG5T+n/zDG3r00DMZ9ijGiazKt1zmMDxhfsAU3zjwuaYOZZVUweVm9VR42qM7JWdDOTzqaoDy96yRX6eiUq1pQvUF20Rj71GCSlFXQkkof8uErq6MlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725621; c=relaxed/simple;
	bh=wZY0B8uClIPnS+4rX2HGmW/x3INl9lgkVOi/Ss4oZ2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh6po9gb3opgTuR8q7R4n2Y5GlbiiXni/ozN3qZTzS0jWwwVHEG6Obv3izzgzEO0dq5DjJH1a5Ni4YPlNoKcYyBYRXiZX+JAwP3SlMJMHg9R7KW3hbNn8yrQXI1eRcRLBIOwSuzrX69UN5jIZFS2C5uzJPTP3Amy7eO1Zo+xX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ayshrwd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-710f388621fso221131a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726725619; x=1727330419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZY0B8uClIPnS+4rX2HGmW/x3INl9lgkVOi/Ss4oZ2M=;
        b=4AyshrwdbpAXlUxilhsN45bvwYX5zOXrhP27mkukq11Jv8zjpGPeIxujyGVPDxqjYx
         fLGnY8CP0Tpv0f+ED7rkveeCzypM8Dfq1ncnvYQPS0Nl/4n9QjXX0NsT9iB8gqi+LNeE
         1D3muTa76n8y/9pXWGEvwIDro7fgpJdGUEQcNIu2W4fzuNcPrpgbbNnLKaH2m234nCcg
         qLrn/0pYbH1XbXd7Yg1SnKOyF/AUEXYsAkP592jplTHnqYYfUa5b344a8pqG1ACIscj6
         /r3e8d0DX65FHfAxlS1wU0bydIy3LgffoOoofoeVvbey6A2mnuuKB6Q3BGIcaKbgi47Z
         26fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726725619; x=1727330419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZY0B8uClIPnS+4rX2HGmW/x3INl9lgkVOi/Ss4oZ2M=;
        b=di+H66IU3061bugHRaNulc8U4jIs4+ZEiaBKOaLFUmnMUuA1s2jCJLb1KXs4ptNMU0
         wlc22ewTP+wr+5BqH9M36y4pfGx0lwDeWSzhP4cKywTtx4YcDIqsJI/xE6ksuTFMKAmx
         5GdOrG+tAbff0rJfhaS0sPIxttLkyfksTVDcV8ZmV2XynUAnFp4IofzJaFpozP+o0reK
         pFiI/dhmIqs7zCOn2opDseaGQ4+4E+faqiITO5V+0vhusS0bxQ7MABIi0x8g0wjAwo/2
         EmbQ+qTg0reKgITNMfDkkNppUqHqq0RWuQ03PWWMeemZGYVYApGvePLN0FIL3IkSwmDM
         Ulkg==
X-Forwarded-Encrypted: i=1; AJvYcCUt7AWdB+OVwf7OGfM9BOYB8uCvh+HkfAmPVMoZi3o6l/wonUl39d+IhCY3/8c9IC5pBh8VHcKjmeLVwIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFqjQSgLadeh1saQiMCgbWPG1MO4Q+jp2mHmlOdwGP0UKGYRz
	XDMjt6K/ByZmO+60zN5tukCS5y+qkQAnc1/NuQ0kJM1SNaNRVAdHSPlLIpn+jfuhG6cwFyXdufo
	tsqkcbvsvuSKdxiJcdWY3FeE3ryEsZdvUHkYz
X-Google-Smtp-Source: AGHT+IEnAs2aCz8JyONyy/WuuYLnmkZnOS5WuzPFbZIPIIeHWx4iKe/LYNTIJ9dBscjH/HFJnxc5Keli2GenKhkHrvk=
X-Received: by 2002:a05:6870:854a:b0:261:2072:7b5d with SMTP id
 586e51a60fabf-27c3f6469c8mr14147636fac.29.1726725619042; Wed, 18 Sep 2024
 23:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909211506.326648-1-mathieu.desnoyers@efficios.com>
 <20240909211506.326648-2-mathieu.desnoyers@efficios.com> <CANpmjNMjndyBAO3HKHkC+v7zNZv1XHvH5Fjd9S5q0Jj-sEkx-w@mail.gmail.com>
 <0edc398e-d193-4c2d-907e-f5db93143f79@efficios.com> <CANpmjNOPJm7nfzuF2VXLmixBZ0ygQ84AkxG8jH0E79XzWPu8xQ@mail.gmail.com>
 <5cf2c0a5-7a99-4294-b316-eee07896ddf6@efficios.com>
In-Reply-To: <5cf2c0a5-7a99-4294-b316-eee07896ddf6@efficios.com>
From: Marco Elver <elver@google.com>
Date: Thu, 19 Sep 2024 08:00:00 +0200
Message-ID: <CANpmjNM0TGU9qtS35dHBxQ_TZdSnaJviK=sGqY9kiH049AJXXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Valentin Schneider <vschneid@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 12:12, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
[...]
> > Either migrate it along, _or_ pick a CID from a different thread that
> > ran on a CPU that shares this L3. E.g. if T1 is migrated from CPU2 to
> > CPU3, and T2 ran on CPU3 before, then it would be ok for T1 to get its
> > previous CID or T2's CID from when it ran on CPU3. Or more simply,
> > CIDs aren't tied to particular threads, but tied to a subset of CPUs
> > based on topology. If the user could specify that topology / CID
> > affinity would be nice.
>
> There is probably something to improve there, but I suspect this
> is beyond the scope of this patch, and would prefer tackling this
> topology-aware CID stealing as a separate effort. I fear that attempting
> to be too aggressive in keeping the CID allocation compact on migration
> may require us to set/clear bits in the mm_cidmask more often, which may
> impact some workloads. If we look into this we need to be careful about
> regressions.

As discussed at LPC, narrowing down a generically optimal policy is
hard. It's easy to overfit for any one particular workload, system,
etc. So the current approach certainly works. One step at a time. :-)

To cater better to different systems or workloads, it might make sense
to consider giving user space more control over the policy. Various
options exist, from tweaking sysctl knobs to eBPF hooks. My preference
here would be towards eBPF hooks that can influence CID partitioning
dynamically. But that's probably something to think about for the
future - I have no good answer, only that some way to experiment more
rapidly would help to narrow down what's optimal.

> >> When the number of threads is < number of mm allowed cpus, the
> >> migrate hooks steal the concurrency ID from CPU 2 and moves it to
> >> CPU 3 if there is only a single thread from that mm on CPU 2, which
> >> does what you wish.
> >
> > Only if the next CPU shares the cache. What if it moves the thread to
> > a CPU where that CPU's L3 cache != the previous CPU's L3 cache. In
> > that case, it'd be preferable to pick a last-used CID from the set of
> > CPUs that are grouped under that L3 cache.
>
> Without going all the way towards making this topology-aware, one
> improvement I would do for the next version of this patch is to
> prevent moving the src CID to the destination cpu (on migration)
> when the dst cpu has a recent_cid set. Basically this:

I think that makes sense.

Thanks,
-- Marco


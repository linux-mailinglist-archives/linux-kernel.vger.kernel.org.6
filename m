Return-Path: <linux-kernel+bounces-171965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F68BEB3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE271C212E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7643416C85B;
	Tue,  7 May 2024 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+qPOwVT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076FE14E2EF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105330; cv=none; b=l7yDL1B1Xl1jRTnm6FzhTih7y7flSNpXbgBu/PtAmYrx9/lECeDfr/xTQki+VfMjtNqjkkysGFGKZTZOCMW8DIwMetV2i5suOs6TtvdthQj1aj+rzYABw0vTnAhVvyedV5Ds/4P7CrxIaunWW99rvYFos6y8uuK1mVp8R7tH0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105330; c=relaxed/simple;
	bh=NEAgvMs4q2JHSmrcpkS6qtCqto9boJGo1FciZHaMhHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rbg3JBi8YSzH8wUiLBKrZoe4w1BvuHB5m63Exi5g/YG3Bi/T/iCG3mlqLKdoFuG1i51FWsU2vvhBS2o3n9SNW9hqYV2vGsCtfwECwgdi3eFFLq7NI/0qnlYaGytFiOiYI0URn8giSWC0t82Fu3VecVgdnaknryjtUI8ulaR+3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+qPOwVT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so18501731fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715105327; x=1715710127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSD4Y0wwauuEygpT3nwe+oQyvRjWt3XYsYKblcPp7m4=;
        b=Q+qPOwVTSWA5X5RbRcbphDeQJV6NKE1Oxta4tXvIuQJR+0MyY5lxlHlBPeU1ttJvKf
         +knHemuuVjFqdLs2kD2aScM7DdQw9wZh0RdP+m5tpcEcew0WLREcDvsv3sAfbMvO1tu2
         f9fizsd3+QriPd7U4/LSYUc0bEz5yLmpcP1SJXjfhMLGuc9ruP7HPkuzm15tx+3UUtVg
         r2418LFTT0al/DqY34OXbT10df/FXQmWkMFROWHkiZx+e+mzIB3aOalyjKumgtCKA1J3
         UtKTOrgZuiMn1iJDtmCovvSRM+32ovDvvJYL3eoiL9BvGCjZsi7fEi8AxDvd5EBpZFE7
         0nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105327; x=1715710127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSD4Y0wwauuEygpT3nwe+oQyvRjWt3XYsYKblcPp7m4=;
        b=CkJjahJMHETEmPC57VC60AvgYub0WW3kQ6EowsUhFuhiOcdSzYYhvtVSXNdH/igkdG
         rXu5gQO8xEp360NGz3Yo0Zm3M930BFx4cA1SDYD2eyfWIRjOWO+zj4/C6DtY4YL/VWCE
         MpMcTBNnD/pcHU+24aOfzbgbIDHefurPNT+qaCIW0/SKJNk7CbklUipPotoyuhSwLVnU
         mDdbUR4MYHpD54N0SQvsCXTLQX89LZTYxdJfx/79IfhEj3D0AW+3Z8zywlnvCBGcYP4B
         Qjsi4YNfuSYspRiOINaPpj3fVvxaSdeRdZQCe8xPPAduFfpK4fsVK6bgWsCuXUnrZNge
         IOmg==
X-Forwarded-Encrypted: i=1; AJvYcCUim5QkbdyPQQCrm63g3+9pQukBPdZ6sIjXcxfXeOKhk/ijdwSKlPnOy5blgp8JUm8dgkaIUTeXILOBrJ5fuM/LnhgQSLIfK6PFw3XI
X-Gm-Message-State: AOJu0YxfEo6kQy977/bNeN4fIqOtsyJkbU3ZS/oO/nwZheDqZyXCxcUA
	SNkTzSPjGywDehfQN/du3XKgHcoQE8ImDu7ygGMlRErfn+6PvpQbEsKqAukVwO9+ikvVUrkN5k3
	fzjvad8JNyzSDXnPFtoJIPVS1yYRlJ2Gas61c
X-Google-Smtp-Source: AGHT+IFt0R7BfebKvG+JJRTdFCiGDS50YFGKplqdUY2j9QyIWURq8EJbZJ+S/o4OKvOffwGI4qWO0S/hem+M+0wMsk0=
X-Received: by 2002:a2e:9d91:0:b0:2e0:ffea:4298 with SMTP id
 38308e7fff4ca-2e4475a1987mr2510301fa.34.1715105326873; Tue, 07 May 2024
 11:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507022939.236896-1-jhubbard@nvidia.com> <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
 <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com> <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
In-Reply-To: <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Tue, 7 May 2024 11:08:07 -0700
Message-ID: <CAJHvVcgYsZJ3Hm1Hpc1pifH49uVniAedL-YxUpS8q7=Y8veZ5g@mail.gmail.com>
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andy Lutomirski <luto@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:43=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.05.24 18:28, John Hubbard wrote:
> > On 5/7/24 1:13 AM, David Hildenbrand wrote:
> >> The patch subject is misleading. This should be "don't flood the syste=
m
> >
> > I went back and forth on that subject line. :)
> >
> >> log". Nobody cares about the speed of a unittest ;)
> >
> > Yes they do. People should actually run the selftests, which in turn ha=
ve
> > enshrined their guidelines in kernel doc. See dev-tools/kselftest.rst,
> > "Contributing new tests", which says, as you would hope, "Don't take
> > too long".
> >
> > It's important. Tests need to be quick, and having one out of 50 that
> > blows it up is worth fixing.
>
> I'm pretty sure you got my point: it's much more important to not let
> unprivileged users flood the log (possibly harming the system?) than
> making a test run faster :)
>
> >
> >>
> >> On 07.05.24 04:29, John Hubbard wrote:
> >>> If a system experiences a lot of memory failures, then any associated
> >>> printk() output really needs to be rate-limited. I noticed this while
> >>> running selftests/mm/uffd-unit-tests, which logs 12,305 lines of outp=
ut,
> >>> adding (on my system) an extra 97 seconds of runtime due to printk ti=
me.
> >>
> >> Recently discussed:
> >>
> >> https://lkml.kernel.org/r/a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.uni=
zg.hr
> >>
> >> See the pros/cons of using ratelimiting, and what an alternative for
> >> uffd is that Axel is working on.
> >>
> >> (CCing Peter and Axel)
> >>
> >
> > That thread seems to have stalled.
>
> Yes, there was no follow-up.

Apologies, I had completely forgotten about this. I blame the weekend. :)

No objections from me to the simple rate limiting proposed here, if
useful you can take:

Acked-by: Axel Rasmussen <axelrasmussen@google.com>

But, it seems to me the earlier proposal may still be useful.
Specifically, don't print at all for "synthetic" poisons from
UFFDIO_POISON or similar mechanisms. This way, "real" errors aren't
gobbled up by the ratelimit due to spam from "synthetic" errors. If
folks agree, I can *actually* send a patch this time. :)

>
> > I *do* have MCE experience (writing a
> > handler,
> > dealing with MCEs and related bugs), and what they wrote so far is exac=
tly
> > correct: if you were going to flood the log, then no, we don't need to =
see
> > every single line printed. The first 10 or so, plus the fact that rate
> > limiting
> > kicked in, is sufficient to proceed with debugging and/or hardware
> > replacement.
> >
> > I'd like to just do this patch almost as-is, just with a fixed up subje=
ct,
> > perhaps:
> >
> >       x86/fault: rate-limit to avoid flooding dmesg with "MCE: Killing"
> > reports
> >
> > Yes?
>
>
> Makes sense to me (and thanks for confirming that we don't need
> complexity elsewhere).
>
> I think we at least need "Fixes:" (not sure if stable is warranted as
> well, 1b0a151c10a6d823f033023b9fdd9af72a89591b didn't CC stable).
>
> Consider adding a link to the report in that thread.
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>


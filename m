Return-Path: <linux-kernel+bounces-349603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4AE98F8E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0609C1F22580
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA31B85FB;
	Thu,  3 Oct 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tl4+iOe8"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9371AAE11
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990805; cv=none; b=TLzFDsSPu5qwGRpcNhW5i8EV7ovViuZZKl0mw6urY4LTSvrX9v6dr6OGHGMarOilWn7W+aloC4u4mLAlAo4uUR9sj0QnFusHeXxJAhIGvAPpcILEvHRQ9s7XUNxqgX+CDhTKKm41FXMi4FvqDh8c3Jc2dshWpog+qcf7gH1tzhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990805; c=relaxed/simple;
	bh=pQCwlOr13oN+EnmUtTwBgm8SPbkokVUxSY33E+ZuzVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeF1x4dNIjIeNZEezpnbOMHizpBkg8shT9EKe7Ka5GtSds3jeFOnNUYc4S6YpXaV1kai1jLUZBO2qUontVScM2pA24z5KCdd/13vimIrekEud7fglxDiNjskwkbpwiSQglQMtj/ihBnM5V8d6nw4amNKYGOIoAo8xpOa/mNRyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tl4+iOe8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582a5b495cso31341cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727990803; x=1728595603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4WtY2bvRWZ4+NgXaQuZNQ1yHok2nQ+f0JDWrnSqQak=;
        b=Tl4+iOe8eMefWCPJ6uS+ckGwGNbsfSIzz4ykUee7iofmDlnjULGeT9zSSfqWz9C1St
         2CJ2IS7/Rr0mCUJHhnqi6HSmi4YloprZxsouS5ccUNNr/UjQSaHcDcc6aCqFMMMWpOx0
         zZOJQvaD0IUywmRZKxJ2ktSHBY5YLUHGUfXEpm0/JWnLhSA7HryZX/eFNpCkky5C9WpP
         GDusPqd65GqTumx/jywWN0X+6VjjaSlLmUUrNO0mX74qnBEz78OU8fQ34wMBqxUvXQml
         HURMRQdvEduU6jXNGoWUBb7nW5DycEJIsLw3KgaLf1dp7etE6UbSbOfyUAZyTobDWGQK
         lo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990803; x=1728595603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4WtY2bvRWZ4+NgXaQuZNQ1yHok2nQ+f0JDWrnSqQak=;
        b=E34MiyKOdysweVrAWBz7EyjD/7Xxk5o/FLzLnD9pAr8gVKRnV5A1QkPsq/sEXcaoJZ
         77kJbMjzooR0lr9o33E3Bj9dAh4G4wj6T3jXYnxW3HzT8P28gDFCRQ0Qa0O5M1SJTcA9
         tW6k/7DD4GwZq2b1/12cnqBmyh5VInrBlw65tcwKTPVKVlkYHseqPJHIUlopfvFP7rDi
         1Oh0iEJdMfWYu4wogOAT2cUtWlaoeFmfNqwgbbquoJg2zrfhQYpBpCXjnfwH/PEdXfEj
         +bWC372eBsyv7ufhyx8gKgj2umCM1jmjDUyNrhSCN7y0W50Q+FnZQCEhtBoOxkp1FiQe
         rmag==
X-Forwarded-Encrypted: i=1; AJvYcCUcrzd3Kor+vvrX8AHFrULBM9iRq3I06wRDyxpKMb9flPn8Ho1GslVjSMcIi6p6VFWg8mqCRyihxktZFIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcJxI3Kh9jEm3kGUFhAQ4p2RUQh+zOmiagzN8rZZ3LhCmcOT+
	EHwfTFpzHb6CGo1DAUp7y8O+N4IvKNtm0q4Ow2qzWMJUSZjXKalpsMl5wQKt+J0v4D7MYdJxlLH
	Y9klgsupUKAPr9DFK1/2DbW+lMIsoiVGKlONK
X-Google-Smtp-Source: AGHT+IHQMfj44WuDJwqO6Sa9xOAGNe+JQavB7OPjFpxmc0IL9zzE0mfas3KNbjQH8+PFCsnfTCMYv27Tm/TSsr1uxx0=
X-Received: by 2002:a05:622a:5e86:b0:45c:9e26:ae3 with SMTP id
 d75a77b69052e-45d9c050a2dmr506191cf.27.1727990802507; Thu, 03 Oct 2024
 14:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com> <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com> <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com> <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
In-Reply-To: <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Oct 2024 14:26:29 -0700
Message-ID: <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:45=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-10-03 12:45 p.m., Namhyung Kim wrote:
> >>> If the algorithms cannot be changed, can you please give some
> >>> suggestions, especially for the sample read failure?
> >> So this is symmetric:
> >> ```
> >> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> >>   return -1;
> >> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> >>   return 1;
> >> ```
> >> That is were lhs and rhs swapped then you'd get the expected compariso=
n order.
> >> ```
> >> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
> >> lhs->core.leader !=3D rhs->core.leader)
> >>   return -1;
> >> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> >> lhs->core.leader !=3D rhs->core.leader)
> >>   return 1;
> >> ```
> >> Is symmetric as well.
> >> ```
> >> if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> >>   return -1;
> >> if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> >> lhs->core.leader !=3D rhs->core.leader)
> >>   return 1;
> >> ```
> >> (what this patch does) is not symmetric as the group leader impacts
> >> the greater-than case but not the less-than case.
> >>
> >> It is not uncommon to see in a sort function:
> >> ```
> >> if (cmp(a, b) <=3D 0) {
> >>   assert(cmp(b,a) >=3D 0 && "check for unstable/broken compare functio=
ns");
> >> ```
> > I see.  So are you proposing this?
> >
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/ut=
il/evlist.c
> > index 438e4639fa892304..46884fa17fe658a6 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -70,7 +70,8 @@ int arch_evlist__cmp(const struct evsel *lhs, const s=
truct evsel *rhs)
> >                 if (arch_is_topdown_slots(rhs))
> >                         return 1;
> >                 /* Followed by topdown events. */
> > -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_me=
trics(rhs))
> > +               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_me=
trics(rhs) &&
> > +                   lhs->core.leader !=3D rhs->core.leader)
> >                         return -1;
> >                 /*
> >                  * Move topdown events forward only when topdown events
> >
> > Dapeng and Kan, can you verify if it's ok?  My quick tests look ok.
>
> I verified the above change. It works well.
>
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Dapeng's comment should cover replace the comment /* Followed by
topdown events. */ but there are other things amiss. I'm thinking of
something like: "slots,cycles,{instructions,topdown-be-bound}" the
topdown-be-bound should get sorted and grouped with slots, but cycles
and instructions have no reason to be reordered, so do we end up with
slots, instructions and topdown-be-bound being grouped with cycles
sitting ungrouped in the middle of the evlist? I believe there are
assumptions that grouped evsels are adjacent in the evlist, not least
in:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2106
Does cycles instructions end up being broken out of a group in this
case? Which feels like the case the code was trying to avoid.

Thanks,
Ian


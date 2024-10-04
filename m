Return-Path: <linux-kernel+bounces-349728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9F98FAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D5A281575
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E61ABEAB;
	Thu,  3 Oct 2024 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8zWeMne"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779D186E3D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998600; cv=none; b=s+Xp3mnZ2ny/mNCZXhPksUG14WFbtXlhSTUALMRnT8PjMnGJ1giNN/0IFFp7xefsZV6Q6yhjOV/TwqiFycMIw9RmDo2K7Qd+wFEXOnvcOO6jcf/T2jaif2rezuQSi/SlXoilQIihc2J6XEAqRzsY3G/mQg2Iiitj7mQMejEBhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998600; c=relaxed/simple;
	bh=ZCp+CKRjoXCNym+W48FUt99ydz8le3g/mUr+XsICn3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcVkyANmT6y04Dc6d2cz1CaV/4gIyHPvFVcTgCoQDDknrQnEmbbQ+ywSlhRMwl6rxZgFZIT92ngodvugTz/1aatMkC4RorKS8o5bUy3P8YituMFuDHRLSVHNKFln12ie9gX3k+0MZZPkotRzbgUaTgVcDn6zLk+o8164Loo20ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8zWeMne; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso109655ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727998598; x=1728603398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KH29pr2XtOOMfCWZEzBebYdYWBiRFt4d6qnh+7X9Nw=;
        b=m8zWeMnewOhwYzkSt8jc+ociY4y8MBnBaP9/CkrU/LogsrWVyQ3awTO7LvDn6v/n+R
         HEHShafVsObak3YDZwaTUWfZ0RnUD5+Dqws8rjguPxYWW6kQW46W2RDG7xj2VD6G5maO
         MQqqH4FQOREafBFmL22/bL10PNLVTx/DdCzg4q5I4ZrQ3RwwO8GlldbtB7ORaDL6TwzP
         v+rHtkULaivQPhSnjGppdyVk8JSeYiEBCnqkwQ9V4r69FkR9j5tTw2mYWUce/DnZANVE
         KjFCpw9Vrwh8CvoFc2iroo70mkaUOu5SrgyIrYvWnzFyjIw3iavraELhVeio11QSdQ9r
         +eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998598; x=1728603398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KH29pr2XtOOMfCWZEzBebYdYWBiRFt4d6qnh+7X9Nw=;
        b=HjkxGi/dLeVa7pYef0nODzYIv6ltyIeZ+WO8kzSR9i5Z89fom6PTghT/gZ5LAQFZot
         B10ZIPY4R67moJfVzulQenRc9srss5VGsWsAVLpM+PWbR5mhl7EOVh6st5lzNMX4E+6H
         Iut4EEuRVX92QilB5o9h8dSuz7XZI9rADM62YvnwT6HYC4Z5HD23pqn8IOaDnYCCsvCJ
         59SBd0wwvNPsbCrkhzSM83kBpmD00nYs6aVsZilyiWct809XjWeeYgNrp4nSw8blvAiS
         GHulZEczKH5dIgTG5R239/YwohQAK6qrCTb+7cZtaoDmD7PyjzIUehPt0doam3tic+S4
         Dn2w==
X-Forwarded-Encrypted: i=1; AJvYcCXM4aYvkvnISwMquTkxDyJCaQYx1gks+xu1wFAziS0yYDa4o+E/S/i12QKO975mx00/3Jn+JmZpVdwr/Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0iCDSyz0BSmIIwqGDZU/N/mcp3h3SuTSw5IwS61Q02TtNvmj
	XAXRH70SRXWFSBP1VCJCUxClGg9iEzlMeldtAbNQnvF9u+RI2ZMp8t0ZZmigWzSrU7pHvYrTKRX
	zsEfUilrfc9DoYmRtNIovtNt6d4Kd48WICIF1xjfvpXPLZeaTzy3j
X-Google-Smtp-Source: AGHT+IGfrvSTVD0UVZiFZ/rWiY6uCQefM+D6KNIWuAb0BwJfgzCYhcx9Gg5THlT+NyRWsTZzZZC0mB5XLt2tlIhwuOU=
X-Received: by 2002:a92:cd8c:0:b0:3a0:9cb6:cb with SMTP id e9e14a558f8ab-3a37680f1c0mr333995ab.7.1727998598308;
 Thu, 03 Oct 2024 16:36:38 -0700 (PDT)
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
 <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
 <Zv8XIZAwfoTtzOl4@google.com> <8df24fe8-4d90-4105-acf0-e4f2667c42c9@linux.intel.com>
In-Reply-To: <8df24fe8-4d90-4105-acf0-e4f2667c42c9@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Oct 2024 16:36:25 -0700
Message-ID: <CAP-5=fUVNa_JKz7WweWsQjobhFCoknbPuPGzPGFGcaDJ8wxLQw@mail.gmail.com>
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

On Thu, Oct 3, 2024 at 4:29=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-10-03 6:13 p.m., Namhyung Kim wrote:
> >> Dapeng's comment should cover replace the comment /* Followed by
> >> topdown events. */ but there are other things amiss. I'm thinking of
> >> something like: "slots,cycles,{instructions,topdown-be-bound}" the
> >> topdown-be-bound should get sorted and grouped with slots, but cycles
> >> and instructions have no reason to be reordered, so do we end up with
> >> slots, instructions and topdown-be-bound being grouped with cycles
> >> sitting ungrouped in the middle of the evlist? I believe there are
> >> assumptions that grouped evsels are adjacent in the evlist, not least
> >> in:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.g=
it/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2106
> >> Does cycles instructions end up being broken out of a group in this
> >> case? Which feels like the case the code was trying to avoid.
> > I got this:
> >
> >   $ sudo ./perf record -a -e "slots,cycles,{instructions,topdown-be-bou=
nd}" true
> >   Error:
> >   The sys_perf_event_open() syscall returned with 22 (Invalid argument)=
 for event (topdown-be-bound).
> >   "dmesg | grep -i perf" may provide additional information.
>
> To be honest, I think the "slots,cycles,{instructions,topdown-be-bound}"
> is a meaningless case. Why a user wants to group instructions and
> topdown events, but leave the slots out of the group?
> There could be hundreds of different combinations caused by the perf
> metrics mess. I don't think the re-ordering code should/can fix all of th=
em.

I'm happy with better code and things don't need to be perfect. Can we
fix the comments though? It'd be nice to also include that some things
are going to be broken. I can imagine groups with topdown events but
without slots, for example we group events in metrics and in
tma_retiring we add "0 * tma_info_thread_slots" to the metric so that
we get a slots event. If the multiply were optimized away as redundant
then we'd have a topdown group without slots, we could pick up slots
and other events from other metrics.

> For the case which the re-ordering cannot cover (like above), an error
> out is acceptable. So the end user can update their command to a more
> meaningful format, either {slots,cycles,instructions,topdown-be-bound}
> or {slots,topdown-be-bound},cycles,instructions still works.

Perhaps we can add an arch error path that could help more for topdown
events given they are a particular pain to open.

> I think what the patch set really fixed is the failure of sample read
> with perf metrics. Without the patch set, it never works no matter how
> you change the order of the events.
> A better ordering is just a nice to have feature. If perf cannot
> provides a perfect re-ordering, I think an error out is also OK.

Agreed, we don't need to fix everything and focussing on the common
use cases makes sense.

Thanks,
Ian


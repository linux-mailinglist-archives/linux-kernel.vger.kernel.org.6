Return-Path: <linux-kernel+bounces-348457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFA98E7F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D598D286DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9F8101DE;
	Thu,  3 Oct 2024 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jt5qNLG1"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AEC8FE
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917041; cv=none; b=NdbnTZ38mnw2j/ZcJ7TPv7GQxDcDPoElcUapJqULo2n0UMc8BIO8GqfwRqxz67U/8yQWR/I84uLCCWMsIKaMACvOzrO9S7ZqZbPGnh8UO0kJZqEYigh18c52m0EwG/sqHtqOy5VTe7CKgDmmQx8Nv3uE4yRZpKxronQS4zua+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917041; c=relaxed/simple;
	bh=s3iRuWwOgs+Srvkadird9HGJaS6D5KVuQ+qqizag/4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY71YHhtW0UtKNKUpqBZzO7tEehjPAg1j2wLkBsPbjkm3RAhIEhV4rBV+k59RF9jbE8MWlso2glofWhzQNsy0MF4rhdjevgKLNXBZloOs8/tcuENeFmv494h7sDshVobpG55LYiFAYQUIRLW1620aqheXO8gdlPqK3H5HCSyfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jt5qNLG1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4581cec6079so127461cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727917037; x=1728521837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANXmoLN1XfUZ7NwwxdIIk7pwwoVnVYkzkVOhLe1c/iw=;
        b=Jt5qNLG1ayY2BBd2mjKEX3MDn68LncHbe6p59RjnCIoO4cRFN4x/WRy/ytZNaNltwK
         csnoIRytzLd7wfZSzsACIpxmmHgqrNFn7fZSBU3JdWT68BbXfvxycgwo8X/+1sa82Asz
         wQXtSxn5dSxV8WWdKEE+TaphmtN9i1Kp3c3iSdN1RQN+Tcl6/HzoLq6mSip6E5wNWWyd
         coYoAKpktqzypgAvLICXmJqRO8auMRlJKSv4NGJkGS0m+G4Q8pCH9Rq6WqTlCfXNfwOl
         aTRxA1r6+BKUKzXV7n3C1CwyW/IONS8R3Ux08WEKnwBTEm+NnhRKWUi+jjwRIZXsZaN+
         hQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917037; x=1728521837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANXmoLN1XfUZ7NwwxdIIk7pwwoVnVYkzkVOhLe1c/iw=;
        b=uZbM6UVI57iVZPOVK9WYpkeT1bakWL03KMz6PLLHSz54sd+K3vpamWJoqacuTQ7uNK
         NDHZlXztO93mU18YYtZ1P/jsoCmQkEsNXSHa4bhoitg6fSpoGMC8iY+Zgso1dvYYcI/d
         Yt6BkxO9BB9XW5zWSQhs6q0yigjOFNS3dk7g4jbyjYlkdSxxF4ljyE41lOST3Fmd/PK1
         NYuZbpVtZxJugrsBVtDQDWbE7RtN7+sxP0AjuiOaqIFJlt4TBsYCVlYJywGVXXAxCKQt
         iY972NAac9xlom04ubfI2ze/wLWWYPciH3OLs4i3c0JN8eJv/iYAxKMdWKeoL9ufAER+
         X8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAkA33GJvK7UDuwp7sMVNlqVL5xRIA1Lck4Hg+Zi5AgcNI5lrP8xnpbyp/7BLmz70f1U18CqeymEEeyHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xsx5fp7VCpmzfoz7Q1RNEFj/I9yGbBxQFtU4pYl8a6SVcyB6
	1Y1PUV1U/6Pdp7k6sJMD/Cwyb/92HKsUPws+h84IiTVPvblB2tvBGSkvtybJhjzTlo2Da9hpfBc
	xdLbbrSlZf9tBId+kSOfdKYWhozZraM2Euk1l
X-Google-Smtp-Source: AGHT+IGX3u/6eYc5RZL3XEYxz5kTciKsC+sGmiql7sxjQSsmsxEvmLJoyqZ1xq3VKZMHX02okJ3u+zN+RIEd9qCAuLE=
X-Received: by 2002:a05:622a:7892:b0:456:7740:c874 with SMTP id
 d75a77b69052e-45d8f871157mr891271cf.1.1727917037409; Wed, 02 Oct 2024
 17:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com> <Zv3ek7aBkQo0Z9To@google.com>
In-Reply-To: <Zv3ek7aBkQo0Z9To@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Oct 2024 17:57:04 -0700
Message-ID: <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Oct 01, 2024 at 03:32:04PM -0700, Ian Rogers wrote:
> > On Tue, Oct 1, 2024 at 2:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Fri, 13 Sep 2024 08:47:06 +0000, Dapeng Mi wrote:
> > >
> > > > Changes:
> > > > v5 -> v6:
> > > >   * no function change.
> > > >   * rebase patchset to latest code of perf-tool-next tree.
> > > >   * Add Kan's reviewed-by tag.
> > > >
> > > > History:
> > > >   v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi=
@linux.intel.com/
> > > >   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.m=
i@linux.intel.com/
> > > >   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.m=
i@linux.intel.com/
> > > >   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.m=
i@linux.intel.com/
> > > >
> > > > [...]
> > >
> > > Applied to perf-tools-next, thanks!
> >
> > I disagreed with an early patch set and the issue wasn't resolved. Spec=
ifically:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3D3b5edc0421e2598a0ae7f0adcd592017f37e3cdf
> > ```
> >   /* Followed by topdown events. */
> >   if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
> >   return -1;
> > - if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
> > + /*
> > + * Move topdown events forward only when topdown events
> > + * are not in same group with previous event.
> > + */
> > + if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> > +     lhs->core.leader !=3D rhs->core.leader)
> >   return 1;
> > ```
> > Is a broken comparator as the lhs then rhs behavior varies from the
> > rhs then lhs behavior. The qsort implementation can randomly order the
> > events.
> > Please drop/revert.
>
> Can you please provide an example when it's broken?  I'm not sure how it
> can produce new errors, but it seems to fix a specific problem.  Do you
> have a new test failure after this change?

It may work with a particular sort routine in a particular library
today, the issue is that if the sort routine were say changed from:

if (cmp(a, b) < 0)

to:

if (cmp(b, a) > 0)

the sort would vary with this change even though such a change in the
sorting code is a no-op. It is fundamental algorithms that this code
is broken, I'm not going to spend the time finding a list of
instructions and a sort routine to demonstrate this.

Thanks,
Ian


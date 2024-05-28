Return-Path: <linux-kernel+bounces-192640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7878D200E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9240928559F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A57172791;
	Tue, 28 May 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZJtQSBg"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F0170855
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909268; cv=none; b=pxLxLTPdXKGBKSizHyhqkZP6MGEkfUbhlDz1Niko1m5XFMGOUqNgGsHgp0n/s9Z1dvKF0V5TsTfrXVlaUPyBT0lEvFfu5+LHNR3tUNh9nY4jCe5EMVBvkoRq3ktyIW5QmkMv5UzymVsjrtA0r6fWvTjQv3AIuOyKc5mNXM29jHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909268; c=relaxed/simple;
	bh=7zkV/QiMvzWQFm6NnJjVGe7wPYyMdu52nuGtEcAhgFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff316rANbGc62B4l+5AcQBMGt1s9Y9hlbQVYJJPm7vATIdcrgg92/tgddjIN5D9lGGE5zdmwP1dpjQ+9h59mzWVkMI1lElBl577m7HOUfHQm+NL+Cvwm6k3MGZRv5OaB4+LYByEsz1IF0uRvmOOflNYi8FXcWhp8eUm3Y50os0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZJtQSBg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f48e9871e2so353535ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716909267; x=1717514067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOq1EEVKQaCb9aX3l6DWWD7raLtaTMMF6DMvMc5Iem8=;
        b=IZJtQSBgkzsZ/TUscEvr0i50KMg5jxxFv6yBmvYQM2094dGujl12H2iUomqTamFlHm
         Dy5rfTzr9Y7C+K+cd9lhw2IJmV1/ZGpqxwIEh/ySkZg7N5PSGEMWxvVYFwzXraP15IR5
         YnRQvehyf1b5+mZjVz2we5TmR75GlIq5bbiwPD1z4RQCx7l8XeLy67H2fuUrHv7tjJtS
         60+ZDBQapx+YX/46deLXIAuxMx9Ha5W68aBlF1Ss/txf6zIhWI84iIFRq3fy9PT9BQMU
         hNuMCr6MC31liem3JeN57p+fKenZiwZJwKfXnudIEc8O0gWLVWBKbvOOUKMsC2tFvo2C
         QVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909267; x=1717514067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOq1EEVKQaCb9aX3l6DWWD7raLtaTMMF6DMvMc5Iem8=;
        b=AWlBgzOZ07wUDMG6+iylz04qXePqpYq7vI8Ucir058edGsk5Ts7HV3J1DCTZmCu3zG
         91Xp6bpGl/ubs1U4bJNHZXO/m0lQsgwvgK9eOZYAs6t/v0xPWCAabljj9crIUdy1SUB4
         G50BzkM0x9cYyesLuyMkMYkFadn3WBn5T6l4W/FMqwQemlOemFJvThHeT7EqI1iaxSO/
         CxR13Kw/VNKYm0QtlG0CtAYklC4ZovKY3Nvrr3G8h0Xt2MpVLVsTU1DXAldzFQE2aZGG
         IGi9wKnhFLWi3MNEiYgKewxdfowDTiWgYa0xIwDlFb36iMGpOxtq+v8UTw6zz5idv4c+
         qIkw==
X-Forwarded-Encrypted: i=1; AJvYcCX+v6/GWCh8xVMfRJSEF6Uluhzddz2s3AYk0ZH3gU0XkSJihSzGkjOfkILpWcgr73Udw9oE56Z9QpQakEpTS7l0edZX030NcPLyI1hy
X-Gm-Message-State: AOJu0YyGudlXOZ2wQoGb1xMj+iR0DzjGJMrg6ZOZX3MdLmWjI3I08Kmh
	knm45b8GyuGfswSMFwtN5bZUdXRdfRr9H5yVNcys6/U/7tRoJ6c90sM1ZxkbsBRf/VZde1gu0Ud
	AUxgn10GHQFLYp5ZiMj3LrdUzdgHqHhg0Zn42
X-Google-Smtp-Source: AGHT+IEha5xjBFdu0Tm0od9AENlIKbc0aQju8WJYZG0W/5COt2X+dDeelI/K8FDkd466ZllWl3keQuk7t4jcOuUKAfE=
X-Received: by 2002:a17:902:c3cd:b0:1ea:2838:e599 with SMTP id
 d9443c01a7336-1f4693f832dmr5209955ad.17.1716909266517; Tue, 28 May 2024
 08:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-1-irogers@google.com> <20240525013021.436430-2-irogers@google.com>
 <a173525f-33a9-43ee-8b03-a277810025fc@oracle.com>
In-Reply-To: <a173525f-33a9-43ee-8b03-a277810025fc@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 08:14:14 -0700
Message-ID: <CAP-5=fXXhmQNSP1aRzT7Kd27vx60HQ+0PjL91c9Jq-zufthfQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: John Garry <john.g.garry@oracle.com>
Cc: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:01=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 25/05/2024 02:30, Ian Rogers wrote:
> > empty-pmu-events.c exists so that builds may occur without python
> > being installed on a system. > Manually updating empty-pmu-events.c to
> > be in sync with jevents.py is a pain, let's use jevents.py to generate
> > empty-pmu-events.c.
> >
> > 1) change jevents.py so that an arch and model of none cause
> >     generation of a pmu-events.c without any json. Add a SPDX and
> >     autogenerated warning to the start of the file.
> >
> > 2) change Build so that if a generated pmu-events.c for arch none and
> >     model none doesn't match empty-pmu-events.c the build fails with a
> >     cat of the differences. Update Makefile.perf to clean up the files
> >     used for this.
> >
> > 3) update empty-pmu-events.c to match the output of jevents.py with
> >     arch and mode of none.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
>
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks!

> > ---
> >   tools/perf/Makefile.perf                 |   2 +
> >   tools/perf/pmu-events/Build              |  12 +-
> >   tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++--------=
-
> >   tools/perf/pmu-events/jevents.py         |   6 +-
> >   4 files changed, 562 insertions(+), 352 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.per
>
> ...
>
> > -     },
> > +struct pmu_table_entry {
> > +        const struct compact_pmu_event *entries;
> > +        uint32_t num_entries;
> > +        struct compact_pmu_event pmu_name;
> > +};
> > +
> > +static const char *const big_c_string =3D
> > +/* offset=3D0 */ "default_core\000"
> > +/* offset=3D13 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000"
> > +/* offset=3D72 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000"
>
> Please remind me: how to figure out this number when adding a new entry?

So this shouldn't be generated by hand. The old one was, this one is
created by jevents.py as maintaining something by hand is a pain. If
you need to add entries then they are in the
`tools/perf/pmu-events/arch/test/` directory. When you build with
NO_JEVENTS=3D1 then this file will be used. When building normally
jevents.py will be used and used to check that the empty-pmu-events.c
isn't out-of-date - the build will break if it is. The fix is just to
copy `test-empty-pmu-events.c` to `empty-pmu-events.c`, which is
hopefully implied by the result of the diff being shown.

Thanks,
Ian

> > +/* offset=3D131 */ "l3_cache_rd\000cache\000L3 cache access, read\000e=
vent=3D0x40\000\00000\000Attributable Level 3 cache access, read\000"


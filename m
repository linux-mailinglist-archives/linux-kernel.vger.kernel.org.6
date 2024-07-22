Return-Path: <linux-kernel+bounces-259273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB593934E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39BC1F21EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1C16EBE6;
	Mon, 22 Jul 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPpDbRCm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE616C864
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670630; cv=none; b=INeZRZiSldP+dGTM395aMRHw60ePllfnh5fb3CnD3wDnrjLaZdXXJPNKS39pmtE9AKyLQvAr0FwXf7ad9+4r7OfY0pu6umuHYaijZaNYDmqrNBKmLzfHAgTwav8+4020TRBU6VhRJmcRLwoX4A+ekF1IhmtNos64G+qdNmM74GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670630; c=relaxed/simple;
	bh=BJWiWO6DuidO5bDFJg3juQXqIB6fLQ7u4eqftzcVm34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQYhW951uXSKJPYERw43xZBIix91//87QTUnis57riGqYnQ0IpVnZG65uui1ZfqDNTelUTDMQx8Mve9FleBuw2aa3m4VfoaIgd9WbCw2yHM351CEk9xoMbcTnccGaevJHq7+OHxXdjPG+HpqyC5JMaok1g/36MmH8S3ROrwHf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VPpDbRCm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd7509397bso14315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721670628; x=1722275428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAd7mdk40tiWhlxmPyk9C759iztuYOFsSYWWSaawEQ0=;
        b=VPpDbRCmwqlkZWAkp78jiG2ihuX6cyFgFxNfhJDdQ+gALp3SSDKmINTAeiZqNNmm4x
         c9tTPgqv5NeRijlZktfunuKPY6u7d3ful+9Wb0R1ygZdMDlDSR/tpOldV6GHXEgQoQXM
         8Y4A3OhIoiDOkUcJS/B7GhLPBYBm4i41MCGH++0y3v6nLyk7V3m49fT0K0o2nzZYgZT1
         ru4TJhH8beYy3lNfT8OTbC2npa3gWsaJIwvtzJmC77JTKbRDontaznYwsbr9dwKbQJAp
         BcwyPsSd/p7f5HVgiQde46X83lVJ4KxUXyCFtHgCtyfGKBJaWQWZ9j8fyhfaxtZsTu/a
         SG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670628; x=1722275428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAd7mdk40tiWhlxmPyk9C759iztuYOFsSYWWSaawEQ0=;
        b=dXEj0dwKsy6Ai9j4LW0rYzH+0uNCf9ptFkXJdUkzdbf+PSccrodepUyLXNse/Ftkud
         AjyEblQlGY6GYQdzYB6nZx250Qirq1+Ta3Vf0vQ5aFIOKFltwTNJLKvgfbf22OWbnfUv
         +W9EaF6ZWdhFteMfJ2qahITboZplmGNLOv++MlKrYXRmPPK1jDIIPE+Ilfip88pA0Pqw
         lZllKmIUDRwl0M+HT9XlsDl2DlOHOra+ye7LkWWQqPYYeDLiKdcpfD0EWNAJlAduWwBR
         arkJaSqTwW3+qr8Eq7NsUvpQzmwoVArN62YIV+6FclB9sNOO9h8aHHv/Sgn0iNgixTOx
         8xww==
X-Forwarded-Encrypted: i=1; AJvYcCVaKMaQEShPV7MtYZ5nzFdPdeKxOQCdoW4qd3gzF63nMXW+2XF2xyR+xNPsxCu1iroE0OPLY6x1GXZfjXZbJfWZjNKMudDiAuGhlkdy
X-Gm-Message-State: AOJu0YxygCROx7sL2cJ97vQv2wVirJPGDR6bxL1xoJ9Uy+TsuKrx/KrW
	af0v2GU1DpPR477iD1woSHj3GPQVRQPQsTcmNzssiZekciDTmyMoYTu869Sn9ztKdnxaeaihVeW
	7IBNvvZMfjYAamSVR3/1pFVGiyoaFAiNrvI/K
X-Google-Smtp-Source: AGHT+IH/jY8cSEjiWeal21TuyCVinwhT10EG7TOMUepYpcU5+BC8sTlS7JaDhRE+PNcW9Rbe1SbdFak+CgL3sIQ/Z0k=
X-Received: by 2002:a17:903:22c5:b0:1f6:8836:e43f with SMTP id
 d9443c01a7336-1fd7ff48846mr4485415ad.17.1721670626342; Mon, 22 Jul 2024
 10:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com> <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
 <05fa0449-4fd4-41ed-93e8-db825e48268f@intel.com> <CAP-5=fU9riOR7onxCE3a2xOs_bVdQdTSkAHD5QLb=SO6SCzkzQ@mail.gmail.com>
 <CAM9d7cjbi_P+V=QkLFg6OuEJqmCOsOoDBddQbyhMYD3aF8do4g@mail.gmail.com>
In-Reply-To: <CAM9d7cjbi_P+V=QkLFg6OuEJqmCOsOoDBddQbyhMYD3aF8do4g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jul 2024 10:50:06 -0700
Message-ID: <CAP-5=fXd3t4pXKU7hVDRZp5DnRbZpJRp9zO3ia8cwbRSROKMRQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi,
>
> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Jul 22, 2024 at 1:29=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> > >
> > > On 19/07/24 19:26, Ian Rogers wrote:
> > > > On Fri, Jul 19, 2024 at 1:51=E2=80=AFAM Adrian Hunter <adrian.hunte=
r@intel.com> wrote:
> > > >>
> > > >> On 18/07/24 03:59, Ian Rogers wrote:
> > > >>> struct perf_tool provides a set of function pointers that are cal=
led
> > > >>> through when processing perf data. To make filling the pointers l=
ess
> > > >>> cumbersome, if they are NULL perf_tools__fill_defaults will add
> > > >>> default do nothing implementations.
> > > >>>
> > > >>> This change refactors struct perf_tool to have an init function t=
hat
> > > >>> provides the default implementation. The special use of NULL and
> > > >>> perf_tools__fill_defaults are removed. As a consequence the tool
> > > >>> pointers can then all be made const, which better reflects the
> > > >>> behavior a particular perf command would expect of the tool and t=
o
> > > >>> some extent can reduce the cognitive load on someone working on a
> > > >>> command.
> > > >>>
> > > >>> v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested=
-by.
> > > >>
> > > >> The tags were really meant only for patch 1, the email that was re=
plied to.
> > > >>
> > > >> But now for patches 2 and 3:
> > > >>
> > > >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > > >
> > > > Sorry for that, you'd mentioned that pt and bts testing which is
> > > > impacted by more than just patch 1.
> > > >
> > > >> Looking at patches 4 to 25, they do not seem to offer any benefit.
> > > >>
> > > >> Instead of patch 26, presumably perf_tool__fill_defaults() could
> > > >> be moved to __perf_session__new(), which perhaps would allow
> > > >> patch 27 as it is.
> > > >
> > > > What I'm trying to do in the series is make it so that the tool isn=
't
> > > > mutated during its use by session. Ideally we'd be passing a const
> > > > tool to session_new, that's not possible because there's a hack to =
fix
> > > > ordered events and pipe mode in session__new:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/session.c?h=3Dperf-tools-next#n275
> > > > Imo, it isn't great to pass a tool to session__new where you say yo=
u
> > > > want ordered events and then session just goes to change that for y=
ou.
> > > > Altering that behavior was beyond the scope of this clean up, so to=
ol
> > > > is only const after session__new.
> > >
> > > Seems like a separate issue.  Since the session is created
> > > by __perf_session__new(), session->tool will always be a pointer
> > > to a const tool once there is:
> > >
> > > diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> > > index 7f69baeae7fb..7c8dd6956330 100644
> > > --- a/tools/perf/util/session.h
> > > +++ b/tools/perf/util/session.h
> > > @@ -43,7 +43,7 @@ struct perf_session {
> > >         u64                     one_mmap_offset;
> > >         struct ordered_events   ordered_events;
> > >         struct perf_data        *data;
> > > -       struct perf_tool        *tool;
> > > +       const struct perf_tool  *tool;
> > >         u64                     bytes_transferred;
> > >         u64                     bytes_compressed;
> > >         struct zstd_data        zstd_data;
> >
> > That's the case after these changes, but not before.
> >
> > > >
> > > > The reason for doing this is to make it so that when I have a tool =
I
> > > > can reason that nobody is doing things to change it under my feet.
> > >
> > > It still can be changed by the caller of __perf_session__new(), since
> > > the tool itself is not const.
> > >
> > > Anything using container_of() like:
> > >
> > > static int process_sample_event(const struct perf_tool *tool,
> > >                                 union perf_event *event,
> > >                                 struct perf_sample *sample,
> > >                                 struct evsel *evsel,
> > >                                 struct machine *machine)
> > > {
> > >         struct perf_script *scr =3D container_of(tool, struct perf_sc=
ript, tool);
> > >
> > > can then change scr->tool without even having to cast away const.
> >
> > Agreed, but such things happen in builtin_cmd where the tool is
> > defined and presumably they know what they are doing. My objection is
> > to code in util mutating the tool as I want the tool to have
> > predictable behavior. As callers that take a tool can call fill in
> > defaults (not all) then the tool has to be mutable and I don't want
> > this to be the case.
> >
> > > Really, 'tool' needs to be defined as const in the first place.
> >
> > I'd like this. The problem is initializing all the function pointers
> > and making such initialization robust to extra functions being added
> > to the tool API. It can be done in a long winded way but I couldn't
> > devise macro magic to do it. The other problem is around variables
> > like ordered_events that can't currently be const. The patches move us
> > closer to this being a possibility.
> >
> > > > My
> > > > builtin_cmd is in charge of what the tool is rather than some code
> > > > buried in util that thought it was going to do me a favor. The code=
 is
> > > > a refactor and so the benefit is intended to be for the developer a=
nd
> > > > how they reason about the use of tool.
> > >
> > > It creates another question though: since there is a lot of code
> > > before perf_tool__init() is called, does the caller mistakenly
> > > change tool before calling perf_tool__init()
> >
> > If they do this their function pointers will be clobbered and their
> > code won't behave as expected, which I'd expect to be easy to observe.
> > In C++ if you were to initialize memory and then use the memory for a
> > placement new to create an object which would call the constructor,
> > the expected behavior would be that the initialized memory's values
> > would get overridden. I see the use of _init and _exit in the code as
> > being our poor man replacements of constructors and destructors.
> >
> > > > how they reason about the use of tool. We generally use _init
> > > > functions rather than having _fill_defaults, so there is a consiste=
ncy
> > > > argument.
> > >
> > > The caller does not need the "defaults", so why would it set them up.
> > > The session could just as easily do:
> > >
> > >         if (tool->cb)
> > >                 tool->cb(...);
> > >         else
> > >                 cb_stub(...);
> >
> > Multiplied by every stub, we'd probably need a helper function, how to
> > handle argument passing. There's nothing wrong with this as an idea
> > but I think of this code as trying to create a visitor pattern and
> > this is a visitor pattern with a hard time for the caller.
> >
> > > > I don't expect any impact in terms of performance... Moving
> > > > perf_tool__fill_defaults to __perf_session__new had issues with the
> > > > existing code where NULL would be written over a function pointer
> > > > expecting the later fill_defaults to fix it up, doesn't address cod=
ing
> > > > consistency where _init is the norm, and adds another reason the to=
ol
> > > > passed to session__new can't be const.
> > >
> > > perf_tool__init() is not a steeping stone to making 'tool' a
> > > const in the first place.
> >
> > It is because the patch series gets rid of fill in defaults which is
> > why we have a mutable tool passed around. I don't think this is up for
> > debate as the patch series clearly goes from a non-const
> > tool to a const tool at the end. Changing perf_tool__init to make all
> > the function pointers NULL and then making every caller have to do a:
> >
> >          if (tool->cb)
> >                  tool->cb(...);
> >          else
> >                  cb_stub(...);
> >
> > I think it is a less elegant solution at the end, it is also a large
> > and more invasive change. The various refactorings to make tool const,
> > changing the aux use of tool, etc. wouldn't be impacted by such a
> > change but I think it is out of scope for this patch series.
>
> I don't think it's a large and invasive change.  The tools are mostly
> zero-initialized so we don't need to reset to NULL.  And tool->cb is
> called mostly from two functions: machines__deliver_event() and
> perf_session__process_user_event().  Can we change them to check
> NULL and get rid of perf_tool__fill_defaults() to keep it const?

As I said above, I don't think that is good style and is out of scope
here. It clearly can be done as follow up, but I don't see how that
fixes the style issue.

Thanks,
Ian


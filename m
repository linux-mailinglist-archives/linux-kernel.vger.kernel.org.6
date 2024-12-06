Return-Path: <linux-kernel+bounces-435303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E9E9E75DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F13289258
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FB2309A3;
	Fri,  6 Dec 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUv+Q0kf"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62620E31F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502320; cv=none; b=mQlY0Wjbsv82e5cJrdEtN9aDFtwR8RfY2e3ZbziXB+KGpY9byPbmmrEmyblS719DABOOk/imkNIj8kVWQO420SWqn1BwH+c60CawUEJHVhLbOl445TH1OXBl94C80Z+wP4v8If46XSOKOMX0vA4LoBYnT+dyRUWFrNX+dH7MpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502320; c=relaxed/simple;
	bh=ei0FtpHHrZUcxUt8WzTuRuIK31qZw6OThe6/aKViKtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5PbhvMpAO931TTpc34sUO4aM73BNB4SOPbxPeQ0q+MzzTSZKfwU9Pgd0yPgtUEqOuxp++HzSF0fsRmCpJl45wTX08l+K2aVP9HQcIJMQQkQj14MapLB7iW4CP4JJ9nKucipRXBNSdf93e4MC6Yn6sPypUsh7qc7J77lSo9KHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUv+Q0kf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so85575ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733502318; x=1734107118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7AN4YKGkPuhBlqSxu9pcW9rYzEsgmg57zAfnSADqwM=;
        b=BUv+Q0kf6WC4j5MEVOF5XMOgQUm6qHL2SAZbquaC0PjG9wVkbvYyq+HAzHC5aN1ctR
         0gHG7+Q0Af8v574fnmCfFQdy1D2p+2DQqYyeRYwStluLprTpQVwV9oByDZuEfa7xxxlu
         WPvJtmi2n7NfHcuKHA0AN2DTIItAZxpudBUiQUvgRJVzp7iC4TvMCM/rXs/bFlmfu/HU
         iVY7+ZDfR/ovKD5/jOoRGcXlclpJRyPjccolrqXoWWYvjM0fotLvxbfX7cTJvXb2dCRu
         sEsrr5btkXdAmzcr4K094EcB/lPEYoHgwjk04fybbJEvk1SwiDDBjy4Y0Bjvmkk1907z
         oMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502318; x=1734107118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7AN4YKGkPuhBlqSxu9pcW9rYzEsgmg57zAfnSADqwM=;
        b=RLLUulHgiLH7M++TapO4V8BVo9ZCDnttAGmOEDmK2GAUrkXvm5jB3wGcmwelT+apPB
         8qGXjVAsttPMnKF9727L7HJLUS7N5xo9Prnx+EvpbtzgnHbziiDIw8dSK+AzXfqlcE72
         Y0mA1NdbekNtWJJu9LlIgVdDkiRJYkqZZjDFJSZmV3qseK59MnX05IE1Pp2WFdCWxAh8
         7nooQBacZ8uVATr7sGOOhNYZAH5uB6+iaiHlt0LZJmlFyriUjz0U8F5vEwhvknW5f/Za
         VNKNuC+K4kREYjVSg8nqY7Z/ZoRshaaQIkf1vYpJCvUSNd1qrNrDYnM78dCxAjoJngVl
         OGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2+0/JKn4e9aCLkpvzipb8mN4JxHEsbjf+wK1hcbcKhK27b3BlzDERlmNyzrpSmSm4gYsQwmbxPoi3W9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/pdbMYt9hyrusNskAryYfLOJnw97vcUCT3ozD5zJDaQjhG6h
	nZSKwytmZI2dUjeIDJkO29PUj0YtODCrCkNIXRnSu3WjSR0jXrj9aV1ObO336Pee9Qwg+yGYxHl
	15VFqNMpXRW6567GaTcMBeftQVIKKHpo4Xbfr
X-Gm-Gg: ASbGnct0ryA1BLIqxx1bgQFv6s2kMS+YnTH1Ml9sba+TR1YLOSStmS1heM6Z1vU6MYS
	LSF+bBEspTMjMoOmuqGgJHggsvB9qXXjL
X-Google-Smtp-Source: AGHT+IEwiUM7lSchJOJMWcRstd5T/zhaT5EPwLxomkR/JEk3yV8g29msWYUMSgXl/Nhrl5J83dk6tUOv/1uuSGw6VLg=
X-Received: by 2002:a05:6e02:3a86:b0:3a7:aa54:ce04 with SMTP id
 e9e14a558f8ab-3a812c4d915mr3484025ab.18.1733502318069; Fri, 06 Dec 2024
 08:25:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com> <20241206044035.1062032-2-irogers@google.com>
 <20241206102451.GA3418674@e132581.arm.com>
In-Reply-To: <20241206102451.GA3418674@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Dec 2024 08:25:06 -0800
Message-ID: <CAP-5=fVDH6k7rW3_LXK5Y9Givs3WO5MQ8XMKsuUXXY5nQ66qDg@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:24=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Ian,
>
> On Thu, Dec 05, 2024 at 08:40:28PM -0800, Ian Rogers wrote:
> >
> > From: Kyle Meyer <kyle.meyer@hpe.com>
> >
> > Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.
> >
> > Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
> > cpus_runtime will increase from 81960B to 163880B, and max_entries will
> > increase from 8192B to 16384B.
> >
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/include/internal/cpumap.h | 2 +-
> >  tools/perf/perf.h                        | 2 +-
> >  tools/perf/util/bpf_skel/kwork_top.bpf.c | 4 +++-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/=
include/internal/cpumap.h
> > index 49649eb51ce4..3cf28522004e 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
> >  };
> >
> >  #ifndef MAX_NR_CPUS
> > -#define MAX_NR_CPUS    2048
> > +#define MAX_NR_CPUS    4096
> >  #endif
>
> This series is fine for me.  Just wandering if we can use a central
> place to maintain the macro, e.g. lib/perf/include/perf/cpumap.h.  It
> is pointless to define exactly same macros in different headers.  As
> least, I think we can unify this except the kwork bpf program?
>
> P.s. for dynamically allocating per CPU maps in eBPF program, we can
> refer to the code samples/bpf/xdp_sample_user.c, but this is another
> topic.

Thanks Leo,

can I take this as an acked-by? Wrt a single constant I agree,
following these changes MAX_NR_CPUS is just used for a warning in
libperf's cpumap.c. I think we're agreed that getting rid of the
constant would be best. I also think the cpumap logic is duplicating
something that libc is providing in cpu_set:
https://man7.org/linux/man-pages/man3/CPU_SET.3.html
And we have more than one representation in perf for the sake of the
disk representation:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/include/perf/event.h?h=3Dperf-tools-next#n227
Just changing the int to be a s16 would lower the memory overhead,
which is why I'd kind of like the abstraction to be minimal.

Thanks,
Ian


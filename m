Return-Path: <linux-kernel+bounces-391282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C210F9B84B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1211C2094F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B421CCEF1;
	Thu, 31 Oct 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvICJ3Sj"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F61C8FCF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408141; cv=none; b=tkKcB4joAQ62vnvyJtTpv/FXCpoMwXNflaCbMGec3OiToZ/Jj63T/rWjyV95nabb+gUNGhQGJksyFkyS5P6uVS6gIf9D+tlhJQqCYCUejmuJipNXw2irXpSmw1Uy75H4K4Ad5eFtD+RP+PEEWzLUkH7S4dxPsNPYY23YEmscwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408141; c=relaxed/simple;
	bh=9Rd2TkMcA9fVhu68Ovy75vya9w++kpFgTz+yhcbBG+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhmSKkheNc7nKb8BdtMJfbfdkz1xJW42Qd3oio32Jtudr8n1GX/lGC67ZZ6+87m9NoyJ/orwkJlISpPx4vIHtwroGsy/3ROXUMOVg6FsBK5ttJCHOPM0i9iNVJXANg5lKG86c1DbPRzBTFzZhxwBiH8SPnqxAAG2gShJ8WIQcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvICJ3Sj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460b295b9eeso25561cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730408134; x=1731012934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+KxeuLVX+tE03TpilYSJT4wjTu/mfE3FRXVaPVyu8Y=;
        b=fvICJ3SjDhGhaLpXDdDVZNv1QbBgC7w+zOCB4NTi5n4gg0XiBIuFv0B1xCkxkB5Vsk
         kRdgIWZbJ+Vc1NKQMyMoooAEzuzqnH/5hDUEbYwJfw71qv1cZBY/jW2m1t17CxACp529
         9NvHnOOZjK2p7mr1hqaeoS94CfMKlQ4dLXJ+9pHgALonsYwowPp5tlaHmEebfPxjSrEm
         E3W7KMTiftZCk30Z0SwrS3CPV1jUNj5nqXG2lr4BK1Ja16XUXnMefwh6raCsBsP2yK/W
         Sf7ZYYJR3ChKTaWweIo9/Cs5lDv9WiMmJOxXyVUMr14cPfmQbdJrbxNELhM+KEbVnqjj
         2l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408134; x=1731012934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+KxeuLVX+tE03TpilYSJT4wjTu/mfE3FRXVaPVyu8Y=;
        b=kEgFu22NL8ZzYSjMV6kpATWrw25brIEQar/j81HeQ6QCPy5D8ATGGI9tUMiKC9uqy4
         8m9mU2071f2wkCpLTPsKWUnYTmJY31mbTrO20KkdJr3mst8OHKhRVNul9Mnbw6dfX8lM
         bnukEcqEySbBxqWdhyK5aPI+0ZlMYYySErKtS0UVH62qTXrVk/PRm1QwzQnh7Zz2DnHA
         zHezT9nlcPeJzYnxGzImCif5QWuhGOvLMZB8DrS3Jrhvvl2lCP/KWZdY+Q6wSsRr5UHq
         KDFXx/k5A2D/bbN6pAqcloGpicblUSPVYB/bSjopJcIyrcX3GkLidhkI7f5K/cqcZAZS
         zSTw==
X-Forwarded-Encrypted: i=1; AJvYcCVPOsxr4cxy01PWZ/5D4uoCHNQYXgol6gw2zdh1QZyWeqE0BGkBvCR9KkZYAwY3hT2fKBSE7b0obh5YoCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS9WqCZ+aRUdjj9kmDlNKbx1vSC+N/zAIadMQRtnoPZFkvELXQ
	De/JOMWFX0uyyFmJ68pCcTBQm3IdS3sDvdYphojnVBYcdzDGiPOjUjLj7eVwAhckhy8mf3conGO
	DHVKukrIwDlYxFDZPgEWi5oOiIHgYgBN5GKun
X-Gm-Gg: ASbGnctsYlczl/Xw3MJTH3vMFJUx8d7cOfD/GntEwSJaMRbSCn68hX0uzrbfLWnVTj4
	Zk0U83FEGo8YHj42bgU93iNmoeQVNFxQeFXq0EmOIFR3K+c9BoHmGEneek9BJavU=
X-Google-Smtp-Source: AGHT+IHeUtbTCvIWJIbctfZ40HjYELPWH3dcsZHSiQzYyy54WP1139DwIfmJcUr3NN4kGvqzC7SLLW3yMoAxSPAckmc=
X-Received: by 2002:a05:622a:15cd:b0:462:9e4:de13 with SMTP id
 d75a77b69052e-462ad29cbe8mr4441871cf.9.1730408133773; Thu, 31 Oct 2024
 13:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <ZyPdDaaqwy7PM57S@x1>
In-Reply-To: <ZyPdDaaqwy7PM57S@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 31 Oct 2024 13:55:22 -0700
Message-ID: <CAP-5=fWyQmVNJXU+wH7RuiDDAVNs_JSxiSpSWHDorn0f5e8fmA@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Python module cleanup
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 12:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 30, 2024 at 06:42:31PM -0700, Ian Rogers wrote:
> > This patch:
> >  - removes workarounds for Python 2 module support due to long
> >    deprecation and challenges in developing new code;
> >  - constifies variables and parameters to functions;
> >  - removes python.c stub code which existed due to missing functions
> >    that are defined in the builtin-* files, in general the builtin-*
> >    code is moved into util;
> >  - remove bench and test perf C code from the python module;
> >  - adds parse_events to the python perf module.
> >  - improves upon some of the existing python perf module functins.
> >
> > v5. Rebase. Fix NO_LIBBPF and NO_AUXTRACE related build failures
> >     caught by Arnaldo and the build-test. Fix NO_AUXTRACE x86
> >     arch_fetch_insn in the process, which was incorrectly using an
> >     empty weak symbol stub.
>
>
> I created a 'perf test' shell entry to test the python binding and ran
> it after each relevant patch in this series, as well as doing 'perf
> script -' to list available scripts, all seem to work.
>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

There is coverage of just "import perf" in:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/python-use.c?h=3Dperf-tools-next
Which I'd been using throughout creating the series.

Thanks,
Ian

> I'll send the perf test entry now.
>
> - Arnaldo
>
>
> > v4. Rebase. Fix the parse events evsel to be embedded in a
> >     pyrf_evsel. Add __str__/__repr__ functions to evlist and
> >     evsel. Throw an exception for a bad evlist index.
> > v3. Move is_directory_at to patch 6 rather than patch 7, respond to
> >     review feedback on the list from Namhyung.
> > v2. Add the bottom 4 bullet points - 13 more patches.
> >
> > Ian Rogers (21):
> >   perf python: Remove python 2 scripting support
> >   perf python: Constify variables and parameters
> >   perf python: Remove unused #include
> >   perf script: Move scripting_max_stack out of builtin
> >   perf kvm: Move functions used in util out of builtin
> >   perf script: Move find_scripts to browser/scripts.c
> >   perf stat: Move stat_config into config.c
> >   perf script: Move script_spec code to trace-event-scripting.c
> >   perf script: Move script_fetch_insn to trace-event-scripting.c
> >   perf script: Move perf_sample__sprintf_flags to
> >     trace-event-scripting.c
> >   perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
> >   perf intel-pt: Remove stale build comment
> >   perf env: Move arch errno function to only use in env
> >   perf lock: Move common lock contention code to new file
> >   perf bench: Remove reference to cmd_inject
> >   perf kwork: Make perf_kwork_add_work a callback
> >   perf build: Remove test library from python shared object
> >   perf python: Add parse_events function
> >   perf python: Add __str__ and __repr__ functions to evlist
> >   perf python: Add __str__ and __repr__ functions to evsel
> >   perf python: Correctly throw IndexError
> >
> >  tools/perf/Makefile.perf                      |   7 +-
> >  tools/perf/arch/x86/util/Build                |   2 +-
> >  tools/perf/bench/inject-buildid.c             |  13 +-
> >  tools/perf/builtin-kvm.c                      |  61 ----
> >  tools/perf/builtin-kwork.c                    |   3 +-
> >  tools/perf/builtin-lock.c                     | 137 +------
> >  tools/perf/builtin-script.c                   | 304 +---------------
> >  tools/perf/builtin-stat.c                     |  27 --
> >  tools/perf/builtin-trace.c                    |   1 -
> >  tools/perf/builtin.h                          |   6 -
> >  .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
> >  tools/perf/tests/stat.c                       |  16 +-
> >  tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
> >  tools/perf/ui/browsers/scripts.c              | 177 ++++++++-
> >  tools/perf/util/Build                         |   4 +-
> >  tools/perf/util/bpf_kwork.c                   |   2 +-
> >  tools/perf/util/bpf_kwork_top.c               |   2 +-
> >  tools/perf/util/bpf_lock_contention.c         |   2 +-
> >  tools/perf/util/cgroup.c                      |   2 +-
> >  tools/perf/util/config.c                      |  27 ++
> >  tools/perf/util/dlfilter.c                    |   3 +-
> >  tools/perf/util/env.c                         |   4 +
> >  tools/perf/util/env.h                         |   2 -
> >  tools/perf/util/evsel.c                       |  19 +-
> >  tools/perf/util/evsel.h                       |   2 +-
> >  tools/perf/util/intel-pt-decoder/Build        |  18 +-
> >  .../intel-pt-decoder/intel-pt-insn-decoder.c  |   3 -
> >  tools/perf/util/kvm-stat.c                    |  70 ++++
> >  tools/perf/util/kvm-stat.h                    |   3 +
> >  tools/perf/util/kwork.h                       |   6 +-
> >  tools/perf/util/lock-contention.c             | 170 +++++++++
> >  tools/perf/util/lock-contention.h             |  37 +-
> >  tools/perf/util/path.c                        |  10 +
> >  tools/perf/util/path.h                        |   1 +
> >  tools/perf/util/python.c                      | 338 ++++++++----------
> >  .../scripting-engines/trace-event-python.c    |  63 +---
> >  tools/perf/util/stat.h                        |   3 +-
> >  tools/perf/util/trace-event-scripting.c       | 177 +++++++++
> >  tools/perf/util/trace-event.h                 |   5 +-
> >  39 files changed, 872 insertions(+), 878 deletions(-)
> >  create mode 100644 tools/perf/util/kvm-stat.c
> >  create mode 100644 tools/perf/util/lock-contention.c
> >
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >


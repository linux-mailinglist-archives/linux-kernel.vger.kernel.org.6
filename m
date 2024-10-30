Return-Path: <linux-kernel+bounces-389683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 648DA9B6FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46DA1F22362
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0901E3776;
	Wed, 30 Oct 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tATKwgS3"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590391946A0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326920; cv=none; b=hRWKfOVuKYOdxy3+J50upr31v+l2y79Bc0YWZqWWzNwpBP+aDDolJwA0B5TR7g2f0VWhDCr3ZLNkhRGiqDXG32TWhX73TekmjQQyryMmfSvR2boY3Wp98CQVNHzv8WAybGKRUXFl7xsAKXrW6rCi86G3kFAmgb3QEx7mgMjSmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326920; c=relaxed/simple;
	bh=jvGe0HDxcO7364fcG+8/C+TC2l46IF/D+VoDUdr90vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+3G/UzDejWdV+MhKxrk5Ad/8r7034xVE6xnhYWg1IG4bWkxi/ulE6QhhHSbk1Px437HqFlyOFpXG6zs6eLbk6nubIFMvvZUCrGLKf14F1DyLdPaKREwEYkfTwWG78CJRgINKPrKf6+zbTU9HhlqmMLv228NyQQlwGAAMOGpgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tATKwgS3; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so30305ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730326917; x=1730931717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRGsAQXc6hKMsPfCCaVeG8sxm+0YkudS/vlbw2qGOas=;
        b=tATKwgS3OtKB82iYoKP0pH/ecu+GQth3wXHPMr/Fj8rCKTpbXsj0+6Hd812HL4gFCq
         LiPtyIy3MM6ljJOWSnRUgvTx1Ko8Y8Ai+nq+QwMQ+8Xo88VJgwjzGO84duiom8s6yvwH
         gwyMBblwvxSevpgljnNvZ/14ahPpRUrBLZV0fM/Yt7klSUy7sF6494TBoE5AVQE9xrbU
         NeuDMxysmg+hObWETDA99kQWXfTUo/Ya9ZtiEkYI5alEmrI6QievayAMPkePZBiv3REG
         nGmy/TCe3mSlMZQ9qR4Ja5QqrdyFRaAxK7zIRQrtxPudgFAgniy5E40xtPJd3dQasCp7
         Z8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730326917; x=1730931717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRGsAQXc6hKMsPfCCaVeG8sxm+0YkudS/vlbw2qGOas=;
        b=PkPu5sN7iyT8wEbj45ONwLf9N2Qvhvn3lf2lUI02WXYVQ3Ml42IOEtrm3QLhYTfvRp
         T7haarL9tNS3WM0uyiOzqg21MdU323eeEwAw3RePBVoPsZRPEt4MXJYYU8GC51Zd4ZFV
         j4oZrL3lTi5ZikeoKY/CHQxVWyxCt2St1aX9HEbyq0/76PH5v04BAa/CoRk1y5xN2+P7
         QjgynNV7+jXNuX2vifeWTIKFAKNfKKXZvYkbbm2RXG/d0ZSu1ule7oQwWrDruO8ebCvB
         PXl8uX/TaVhwE6ZNJbJr19xq7fIEouFVEUiDOaPG+k8vEeNxM4Z5Q61qI4dye3F2n40Q
         O0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv+/2vGFtOxT2hlnsHrg8l7Qt+au1sOwsG5zSXtGc89J5Y/XHd761AbDoMQiFVxv4Hm/HOwYCsXt+6tUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcv/i7SZRc8VSrLI4kGH5KNC4YgWiPv4NHx/EaQWIh3IitZ1X
	VeUcyBEvyJc7SHv2OQ1FU5Opkd00z4+wbPeM3TF/HGIPC6XkpxM0pIzYsAfiHnCTx6z/FIzOwKd
	ibHoz3rTGG806Xgiap5+qQa5YvMGvkDFOTiJlHHd8yhglMU2d9vZq
X-Gm-Gg: ASbGnctyncN7XUoqP55uVt6doP3ItHbazh1l97umQ/NGhWDwJEmjvFW0P9zoO7T6urR
	7FyMHlaNGSuzpxVSL5M2lw/LrKaYaHpNOwfsRDVpk0NyJMtYa/UeaUWMYoyj1Iw==
X-Google-Smtp-Source: AGHT+IFatAgmgzH3oP3UBwbrJsVRXuI16XO6/VLcrjvSG0jRbuu3VzG9dFdiSUHhrYiO10e9acpKNCyDo2qZqOSY3AA=
X-Received: by 2002:a05:6e02:1907:b0:3a1:a8a3:50f0 with SMTP id
 e9e14a558f8ab-3a6a93d176fmr523525ab.13.1730326917179; Wed, 30 Oct 2024
 15:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com> <ZyKjabJ9zHRcx-rl@x1>
In-Reply-To: <ZyKjabJ9zHRcx-rl@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Oct 2024 15:21:42 -0700
Message-ID: <CAP-5=fWGzDO7RZDzaSY5MZxQMnG8GWyLmQV87+6Hr5+z0DS7zw@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] Python module cleanup
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
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:21=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Oct 29, 2024 at 03:44:12PM -0700, Ian Rogers wrote:
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
>
> I'll review later or tomorrow, but it passes preliminary testing modulo
> a build test, see below:
>
> root@number:/home/acme/git/perf-tools-next# export PYTHONPATH=3D/tmp/buil=
d/perf-tools-next/python/
> root@number:/home/acme/git/perf-tools-next# strace -o /tmp/perf.openat.tx=
t -e openat tools/perf/python/twatch.py
> <SNIP libperf debug messages>
> cpu: 18, pid: 6023, tid: 6023 { type: fork, pid: 6023, ppid: 6023, tid: 7=
07358, ptid: 6023, time: 94073002926291}
> cpu: 21, pid: 6023, tid: 707358 { type: comm, pid: 6023, tid: 707358, com=
m: StreamT~s #1565 }
> cpu: 21, pid: 6023, tid: 707358 { type: comm, pid: 6023, tid: 707358, com=
m: StreamT~s #1565 }
> cpu: 9, pid: 624123, tid: 624123 { type: fork, pid: 624123, ppid: 624123,=
 tid: 707359, ptid: 624123, time: 94073240462968}
> cpu: 23, pid: 624123, tid: 707359 { type: comm, pid: 624123, tid: 707359,=
 comm: StreamT~ns #509 }
> cpu: 23, pid: 624123, tid: 707359 { type: comm, pid: 624123, tid: 707359,=
 comm: StreamT~ns #509 }
> cpu: 10, pid: 5800, tid: 707326 { type: exit, pid: 5800, ppid: 5554, tid:=
 707326, ptid: 5554, time: 94073371926048}
> ^CTraceback (most recent call last):
>   File "/home/acme/git/perf-tools-next/tools/perf/python/twatch.py", line=
 61, in <module>
>     main()
>   File "/home/acme/git/perf-tools-next/tools/perf/python/twatch.py", line=
 33, in main
>     evlist.poll(timeout =3D -1)
> KeyboardInterrupt
>
> root@number:/home/acme/git/perf-tools-next#
> root@number:/home/acme/git/perf-tools-next# grep perf.cpy /tmp/perf.opena=
t.txt
> openat(AT_FDCWD, "/tmp/build/perf-tools-next/python/perf.cpython-312-x86_=
64-linux-gnu.so", O_RDONLY|O_CLOEXEC) =3D 3
> root@number:/home/acme/git/perf-tools-next# perf -v
> perf version 6.12.rc3.g8f126aaf577f
> root@number:/home/acme/git/perf-tools-next#
> logout
> acme@number:~$ cd git/perf-tools-next/
> acme@number:~/git/perf-tools-next$
> acme@number:~/git/perf-tools-next$ git log --oneline -5
> 8f126aaf577fc14c (HEAD -> perf-tools-next) perf python: Correctly throw I=
ndexError
> c43f13fa5302c897 perf python: Add __str__ and __repr__ functions to evsel
> ec01eeed20cae234 perf python: Add __str__ and __repr__ functions to evlis=
t
> 33ba8db9526a525e perf python: Add parse_events function
> e9d5ea61dd9ac48a perf build: Remove test library from python shared objec=
t
> acme@number:~/git/perf-tools-next$
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time mak=
e -C tools/perf build-test
> 8f126aaf577fc14c (HEAD -> perf-tools-next) perf python: Correctly throw I=
ndexError
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> - tarpkg: ./tests/perf-targz-src-pkg .
>                  make_static: cd . && make LDFLAGS=3D-static NO_PERF_READ=
_VDSO32=3D1 NO_PERF_READ_VDSOX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO_L=
IBELF=3D1 -j28  DESTDIR=3D/tmp/tmp.lNgk7LV5IW
>               make_with_gtk2: cd . && make GTK2=3D1 -j28  DESTDIR=3D/tmp/=
tmp.l1z8oz3HTv
>             make_no_libbpf_O: cd . && make NO_LIBBPF=3D1 FEATURES_DUMP=3D=
/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=3D=
/tmp/tmp.0rqszvPdKm DESTDIR=3D/tmp/tmp.wBzOcarpDh
> cd . && make NO_LIBBPF=3D1 FEATURES_DUMP=3D/home/acme/git/perf-tools-next=
/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=3D/tmp/tmp.0rqszvPdKm DESTDIR=3D=
/tmp/tmp.wBzOcarpDh
>   BUILD:   Doing 'make -j28' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h
>   diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
>   diff -u tools/include/linux/bits.h include/linux/bits.h
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr=
-index.h
>   diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm=
/kvm.h
>   diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/u=
api/asm/unistd.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/c=
putype.h
>   diff -u tools/include/linux/unaligned.h include/linux/unaligned.h
>   diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
> Makefile.config:687: Warning: Disabled BPF skeletons as libbpf is require=
d
> Makefile.config:979: No libllvm 13+ found, slower source file resolution,=
 please install llvm-devel/llvm-dev
> Makefile.config:1161: No openjdk development package found, please instal=
l JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>
>   GEN     /tmp/tmp.0rqszvPdKm/common-cmds.h
> <SNIP>
>  CC      /tmp/tmp.0rqszvPdKm/util/env.o
>   CC      /tmp/tmp.0rqszvPdKm/tests/hists_link.o
>   CC      /tmp/tmp.0rqszvPdKm/builtin-timechart.o
>   CC      /tmp/tmp.0rqszvPdKm/tests/hists_filter.o
>   CC      /tmp/tmp.0rqszvPdKm/bench/numa.o
> util/env.c: In function =E2=80=98perf_env__arch_strerrno=E2=80=99:
> util/env.c:479:38: error: implicit declaration of function =E2=80=98arch_=
syscalls__strerrno_function=E2=80=99 [-Wimplicit-function-declaration]
>   479 |                 env->arch_strerrno =3D arch_syscalls__strerrno_fu=
nction(perf_env__arch(env));
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> util/env.c:479:36: error: assignment to =E2=80=98const char * (*)(int)=E2=
=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a cast=
 [-Wint-conversion]
>   479 |                 env->arch_strerrno =3D arch_syscalls__strerrno_fu=
nction(perf_env__arch(env));
>       |                                    ^
> make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
05: /tmp/tmp.0rqszvPdKm/util/env.o] Error 1
> make[6]: *** Waiting for unfinished jobs....

Thanks, build testing shows some other errors so I'll clean them all up in =
v5.

Thanks,
Ian

> > v4. Rebase. Fix the parse events evsel to be embedded in a
> >     pyrf_evsel. Add __str__/__repr__ functions to evlist and
> >     evsel. Throw an exception for a bad evlist index.
> > v3. Move is_directory_at to patch 6 rather than patch 7, respond to
> >     review feedback on the list from Namhyung.
> > v2. Add the bottom 4 bullet points - 13 more patches.
> >
> > Ian Rogers (19):
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
> >  tools/perf/bench/inject-buildid.c             |  13 +-
> >  tools/perf/builtin-kvm.c                      |  61 ----
> >  tools/perf/builtin-kwork.c                    |   3 +-
> >  tools/perf/builtin-lock.c                     | 137 +------
> >  tools/perf/builtin-script.c                   | 303 +---------------
> >  tools/perf/builtin-stat.c                     |  27 --
> >  tools/perf/builtin-trace.c                    |   1 -
> >  tools/perf/builtin.h                          |   6 -
> >  .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
> >  tools/perf/tests/stat.c                       |  16 +-
> >  tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
> >  tools/perf/ui/browsers/scripts.c              | 177 ++++++++-
> >  tools/perf/util/Build                         |   2 +
> >  tools/perf/util/bpf_kwork.c                   |   2 +-
> >  tools/perf/util/bpf_kwork_top.c               |   2 +-
> >  tools/perf/util/bpf_lock_contention.c         |   2 +-
> >  tools/perf/util/cgroup.c                      |   2 +-
> >  tools/perf/util/config.c                      |  27 ++
> >  tools/perf/util/dlfilter.c                    |   3 +-
> >  tools/perf/util/env.c                         |   2 +
> >  tools/perf/util/env.h                         |   2 -
> >  tools/perf/util/evsel.c                       |  19 +-
> >  tools/perf/util/evsel.h                       |   2 +-
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
> >  tools/perf/util/trace-event-scripting.c       | 176 +++++++++
> >  tools/perf/util/trace-event.h                 |   5 +-
> >  36 files changed, 854 insertions(+), 867 deletions(-)
> >  create mode 100644 tools/perf/util/kvm-stat.c
> >  create mode 100644 tools/perf/util/lock-contention.c
> >
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >


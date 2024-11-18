Return-Path: <linux-kernel+bounces-412433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613A9D08FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BDF281E38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0013D508;
	Mon, 18 Nov 2024 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mh4T9yl1"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B813B2B4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731908272; cv=none; b=YgRyXuYGGDe503PHdIxKZgCgn4/d8wSAqRMHTmh5yq2SJTwwvTt5MA9tS0hdhOKlETpQ3h7oynlnSQBvDBfjT1eGnpTEydBcxPjrMWMYkb5Plv1buLlJH0iQ/IKECI1yY8NintNdXls9wS1d6+Owyawb/0UGZXW6vgtvAoDRM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731908272; c=relaxed/simple;
	bh=y1VkZrZVHhRn0h7Tdc3FIrbSDrURfzyeHuGmFe5Nzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nofn5L/wdxuGpPkO8lU+B3ppwQi68LUjq+Kd/icpQeOWxsTXAuyU48I9fyRuEo1hJJNlh9xEAYFOYVb6ur38NJwZuIjium4Ib09+GPdu2+wmzghTQr0T27KfDPYtaaox1vtdz14XuOKEki5ZvDxB/potcMrnSQ/aKGvj+u16yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mh4T9yl1; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a716d74c28so346515ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731908269; x=1732513069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehcVCFL1HkdyDozm24tcaoEc2721vQWa7hy6lyye0hk=;
        b=Mh4T9yl1OLMo16ULlF1PKRsvn6m0pX2bmS0lk2PEsg+oTa6OVCKGYCjGxkGCCvcU01
         5RAdh6V/gcbsprC3TAt3ghkpin/Vg6F5x4CuEP4qVf6Rtd9p2Q9lac4TzzzLFxQRYMJ8
         7TUtm+KcSbmvJhVegfcP4cFJ/5Ott/Lb1M+AMc6xGvQPIPBexLglVQgpp7l8Ezxggw8t
         7OM9bcmR9FXWzq1ZcifZB6vGKjDiYxcauA0AMshptwWIi40IoDh5Bin2hfMUHUDORi3R
         ZRf9vjtDfi3f7Of1XccqRV33Utql6EaHq6Pgzv50aT+Avncl2MEMSrxbb6fbBg7BwUWv
         RM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731908269; x=1732513069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehcVCFL1HkdyDozm24tcaoEc2721vQWa7hy6lyye0hk=;
        b=GTxRHo+Iis1dAVh6fCdbXddWcyoq7W2YZYZXfIb1MdFUm6LzbgITK31DyB7PihCkBo
         RpM9SEtq3hnI4RnqQ3WIUmZ/cEBZAGxoUCam6uT6pYMI1AXOBnZOEFnHwikwmpZDq9tE
         BfrX8GPKJzv92xBdWAYx3GKThCMA77f5QwjC+Ip5jIrAWJGwandzwysjzsMnVGS8rmhb
         tXcXBUtIdr3123Tpirehmev8NJ0Sg6VN6xBF+rz4JTjeb5Crzfpg1w60RTp0MKsIB77O
         Mc/tp3P1297US16eaf5FNOq9rp4WP6Qjl0kWStpMU+E0iPOMLvl84MPRkLaiXTZRvVxK
         7N+g==
X-Forwarded-Encrypted: i=1; AJvYcCV4N7w8zxFF79q6IK7/qO+nLtQaMXvfI+K3RrdWeQn6aaGmcg1aPBqQy/N4A6egi1ARenZQHuPyE1OTwyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9eii6R+30FWPOPUVMYKqvJg7w8/zyljzsohMdbb6Bsy3+ktY
	PU82PiRUWNF8r+6Toi1rFtHMWDxVj3lLK3ckkYg/WU5iPnv5FzPbCwHdHRZbTr+S2F+8nwq80IZ
	EEaLOQlVdH4T3ON4iSIcsDGyxhbpX39fhm/WK
X-Gm-Gg: ASbGncsuOr1Jty6cqBTnAsdbqbdjSKUWbEXawMWqTdfZ9IoKj5Y2B0o9+zBf8ME0tak
	3VMC4JKFSRLYVVzHmSX7zZqsxN+uKxs4+
X-Google-Smtp-Source: AGHT+IEUJI6aBY+oIWzc6vJZ89cjxcmKfXIXhsywqZc835zjSCr7r5khdRqnWPu6p4DFsb4PhkrZwkB0hrye77xgHZg=
X-Received: by 2002:a05:6e02:1c21:b0:3a7:6404:9982 with SMTP id
 e9e14a558f8ab-3a764049ac8mr1333135ab.27.1731908269059; Sun, 17 Nov 2024
 21:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zzdtj0PEWEX3ATwL@x1> <CAP-5=fX7JZNmiaNDezExqGk9FMXdHihxvLNmnD8HHB3YCehemg@mail.gmail.com>
 <Zzj6eoDDQbvZ25jX@x1>
In-Reply-To: <Zzj6eoDDQbvZ25jX@x1>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 Nov 2024 21:37:37 -0800
Message-ID: <CAP-5=fXfofa4NOPWibBo43eLj4HNcLR0p1ZAUYo9naLb1wb_jg@mail.gmail.com>
Subject: Re: perf test failures with tmp.perf-tools-next
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 12:03=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Nov 15, 2024 at 09:54:56AM -0800, Ian Rogers wrote:
> > On Fri, Nov 15, 2024 at 7:49=E2=80=AFAM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > Not a hwmon file 'name'
> > > FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_e=
vent1', err 1
> > > event syntax error: 'temp_test_hwmon_event1'
> > >                      \___ Bad event name
> > >
> > > Unable to find event on a PMU of 'temp_test_hwmon_event1'
> > >
> > > ---- unexpected signal (11) ----
> > >  11.3: Parsing with PMU name                                         =
: FAILED!
> > > root@x1:~#
>
> > I'm trying to repro the hwmon issue on tmp.perf-tools-next, with asan
> > root/non-root I get:
> > ```
> >  11: Hwmon PMU                                                       :
> > 11.1: Basic parsing test                                            : O=
k
> > 11.2: Parsing without PMU name                                      : O=
k
> > 11.3: Parsing with PMU name                                         : O=
k
> > ```
> > I'm trying more machines to try to get a reproduction.
>
> So, I cleaned up everything, rebuilt and the problem persists on a
> Fedora 40 lenovo x1 carbon, full verbose mode output at the end.
>
> It also fails on a Raspberry Pi 3:
>
> acme@raspberrypi:~ $ cat /etc/os-release
> PRETTY_NAME=3D"Raspbian GNU/Linux 12 (bookworm)"
> NAME=3D"Raspbian GNU/Linux"
> VERSION_ID=3D"12"
> VERSION=3D"12 (bookworm)"
> VERSION_CODENAME=3Dbookworm
> ID=3Draspbian
> ID_LIKE=3Ddebian
> HOME_URL=3D"http://www.raspbian.org/"
> SUPPORT_URL=3D"http://www.raspbian.org/RaspbianForums"
> BUG_REPORT_URL=3D"http://www.raspbian.org/RaspbianBugs"
> acme@raspberrypi:~ $
> root@raspberrypi:~# tail -14 /proc/cpuinfo
> processor       : 3
> model name      : ARMv7 Processor rev 4 (v7l)
> BogoMIPS        : 38.40
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva=
 idivt vfpd32 lpae evtstrm crc32
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x0
> CPU part        : 0xd03
> CPU revision    : 4
>
> Hardware        : BCM2835
> Revision        : a020d3
> Serial          : 00000000783939e0
> Model           : Raspberry Pi 3 Model B Plus Rev 1.3
> root@raspberrypi:~#
>
> root@raspberrypi:~# ~acme/bin/perf -v
> perf version 6.12.rc6.gdb26a8c9e3c2
> root@raspberrypi:~# ~acme/bin/perf -vv
> perf version 6.12.rc6.gdb26a8c9e3c2
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>             debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
>                  dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
>           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>               auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>               libaudit: [ on  ]  # HAVE_LIBAUDIT_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>             libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>          syscall_table: [ OFF ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> root@raspberrypi:~# ~acme/bin/perf test 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> root@raspberrypi:~# ~acme/bin/perf test -vv 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test:
> --- start ---
> test child forked, pid 6983
> hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
> hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
> ---- end(0) ----
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name:
> --- start ---
> test child forked, pid 6984
> Testing 'temp_test_hwmon_event1'
> Attempt to add: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> ..after resolving event: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'in0' that has no input file
> Testing 'temp1'
> Attempt to add: hwmon_a_test_hwmon_pmu/temp1/
> ..after resolving event: hwmon_a_test_hwmon_pmu/temp1/
> temp1 -> hwmon_a_test_hwmon_pmu/temp1/
> Attempt to add: hwmon_cpu_thermal/temp1/
> ..after resolving event: hwmon_cpu_thermal/temp1/
> temp1 -> hwmon_cpu_thermal/temp1/
> FAILED tests/hwmon_pmu.c:180 Unexpected config for 'temp1', 2114584577 !=
=3D 655361
> ---- end(-1) ----
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name:
> --- start ---
> test child forked, pid 6985
> Testing 'temp_test_hwmon_event1'
> Attempt to add: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> ..after resolving event: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'in0' that has no input file
> Testing 'temp1'
> Attempt to add: hwmon_a_test_hwmon_pmu/temp1/
> ..after resolving event: hwmon_a_test_hwmon_pmu/temp1/
> temp1 -> hwmon_a_test_hwmon_pmu/temp1/
> Attempt to add: hwmon_cpu_thermal/temp1/
> ..after resolving event: hwmon_cpu_thermal/temp1/
> temp1 -> hwmon_cpu_thermal/temp1/
> FAILED tests/hwmon_pmu.c:180 Unexpected config for 'temp1', 2114584577 !=
=3D 655361

Ok, sent:
https://lore.kernel.org/lkml/20241118052638.754981-1-irogers@google.com/
for this.

> ---- end(-1) ----
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> root@raspberrypi:~#
>
> You asked this via chat:
>
> (gdb) b hwmon_pmu__have_event
> Breakpoint 1 at 0x661071: file util/hwmon_pmu.c, line 559.
> (gdb) run test 11
> Starting program: /root/bin/perf test 11
>
> This GDB supports auto-downloading debuginfo from the following URLs:
>   <https://debuginfod.fedoraproject.org/>
> Enable debuginfod for this session? (y or [n]) n
> Debuginfod has been disabled.
> To make this setting permanent, add 'set debuginfod enabled off' to .gdbi=
nit.
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 595037]
> [Detaching after fork from child process 595039]
> [Detaching after fork from child process 595040]
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> [Inferior 1 (process 594467) exited normally]
> (gdb) bt
> No stack.
> (gdb)
>
> Hope this helps, will go AFK now, happy to try more stuff and will also
> try to figure this out myself if you don't do it first.
>
> Since this doesn't seem to be something related to the patches processed
> this week I'll just push what we have to perf-tools-next so that it gets
> tested on linux-next.
>
> - Arnaldo
>
> On the Fedora 40 system:
>
> root@x1:~# perf test hwmon
> root@x1:~# perf test 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> root@x1:~# perf test -v 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> root@x1:~# perf test -vv 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test:
> --- start ---
> test child forked, pid 406656
> hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
> hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
> ---- end(0) ----
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name:
> --- start ---
> test child forked, pid 406657
> Testing 'temp_test_hwmon_event1'
> Using CPUID GenuineIntel-6-BA-3
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'pwm1'
> Not a hwmon file 'pwm1'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'pwm1' that has no input file
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event=
1', err 1
> event syntax error: 'temp_test_hwmon_event1'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'temp_test_hwmon_event1'
> free(): invalid pointer
>
> ---- unexpected signal (6) ----
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name:
> --- start ---
> test child forked, pid 406658
> Testing 'temp_test_hwmon_event1'
> Using CPUID GenuineIntel-6-BA-3
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'pwm1'
> Not a hwmon file 'pwm1'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'pwm1' that has no input file
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event=
1', err 1
> event syntax error: 'temp_test_hwmon_event1'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'temp_test_hwmon_event1'
>
> ---- unexpected signal (11) ----
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> root@x1:~#

Still not clear to me why the test PMU isn't present and no warning
was generated. If you could do the gdb, breakpoint on
hwmon_pmu__have_event then that might help explain what's going on.

Thanks,
Ian


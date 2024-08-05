Return-Path: <linux-kernel+bounces-275257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA5A948273
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90931F21E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DDA16BE27;
	Mon,  5 Aug 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMrfo+X3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94716A397;
	Mon,  5 Aug 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886836; cv=none; b=TyK/fBAdX49yPxcMJbdntkd0PsdBdXaOIvBf5fS21ATpLpV9xedV2oDItuhPf0G7qR5cOWMd7ON2a9JAjOxcrP4NSTFeJmXYZ7M8VQUKYrXBnyIn2oHoY2tRCSslZdGCUZROLSqriE+0/xki64Xo96AY9HI6XdSqCE3a0DGUny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886836; c=relaxed/simple;
	bh=rBes9OKEAhd6B5f0LnJlhELJimiJ89BTj3C5/o1F60A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXvioeUj/LJrxogKyWu0UKcg73l1pJIissUdQhDbe2K+LcTaaZ3RsMhUsxeHwsq5egOigsr3exMrOXjaUNnlx0nb5kZ6AnY7I5IDhFGi5gGnML+quBy5OdJ1o4l3z4sOVaZV+9zb/9zL5yQYyOB5OsBMwgjXKMjjNgxGp6h7Fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMrfo+X3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88370C32782;
	Mon,  5 Aug 2024 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722886836;
	bh=rBes9OKEAhd6B5f0LnJlhELJimiJ89BTj3C5/o1F60A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMrfo+X3ubu980qtTERNXVXYNxgM/aVfOFLVT7Tyu2f9A9LXRXBmt+ixqsRPx2pkO
	 W+rvdQDR9LqgrMDVjs3+vUfmnfabwG777e1WknBca5auX0V25oSLytLsVMqLbyBxad
	 wBFX+aigwyGvIwc9sWBxAjw9YMaWnMrcMHg53gm/+ceF2X5gFc8difCtedzk0K5QaV
	 PGwnULayBaIv5b9PEj/UU/PZJsQC5b7+94rTFWLrUdtDUVzWViLMfRB5Thwg8wUCI9
	 1sISBlNDsLwNrnjiN0jG5URbmhBAXfKXQDNlaF/7V9AZILOLD18QCfB31FOl3OX+T6
	 Y27FS8KolwsqQ==
Date: Mon, 5 Aug 2024 16:40:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <ZrEqr36sukDW66uV@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-4-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720062102.444578-4-weilin.wang@intel.com>

On Sat, Jul 20, 2024 at 02:20:56AM -0400, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> When retire_latency value is used in a metric formula, evsel would fork a perf
> record process with "-e" and "-W" options. Perf record will collect required
> retire_latency values in parallel while perf stat is collecting counting values.
> 
> At the point of time that perf stat stops counting, evsel would stop perf record
> by sending sigterm signal to perf record process. Sampled data will be process
> to get retire latency value. Another thread is required to synchronize between
> perf stat and perf record when we pass data through pipe.
> 
> Retire_latency evsel is not opened for perf stat so that there is no counter
> wasted on it. This commit includes code suggested by Namhyung to adjust reading
> size for groups that include retire_latency evsels.

Failing at this point:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -5
13430131acc4f88b (HEAD) perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
b7b9adefb5d57aaf perf data: Allow to use given fd in data->file.fd
3a442bf266d1f3c7 perf parse-events: Add a retirement latency modifier
ce533c9bc6deb125 (perf-tools-next.korg/tmp.perf-tools-next, acme.korg/tmp.perf-tools-next) perf annotate: Add --skip-empty option
bb588e38290fb723 perf annotate: Set al->data_nr using the notes->src->nr_events
⬢[acme@toolbox perf-tools-next]$

I'll see if when a followup patch gets applied this gets solved, if so
will try to fixup things or ask for help, since this seems to be
breaking 'git bisect' for this codebase.

⬢[acme@toolbox perf-tools-next]$ m
rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/__pycache__/Core.cpython-312.pyc': Permission denied
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j2' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
  diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/lib/list_sort.c lib/list_sort.c
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
  diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h include/uapi/linux/stat.h
  diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h
git showMakefile.config:1223: libtracefs is missing. Please install libtracefs-dev/libtracefs-devel

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                             libcapstone: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libsubcmd_headers
  INSTALL libsymbol_headers
  PERF_VERSION = 6.11.rc1.g13430131acc4
  CC      /tmp/build/perf-tools-next/perf-read-vdso32
  INSTALL libbpf_headers
  GEN     perf-archive
  GEN     perf-iostat
  CC      /tmp/build/perf-tools-next/util/evlist.o
  CC      /tmp/build/perf-tools-next/builtin-stat.o
  CC      /tmp/build/perf-tools-next/util/evsel.o
  LD      /tmp/build/perf-tools-next/perf-in.o
  LINK    /tmp/build/perf-tools-next/libperf-jvmti.so
  CC      /tmp/build/perf-tools-next/util/header.o
util/evsel.c: In function ‘evsel__group_has_tpebs’:
util/evsel.c:1562:21: error: implicit declaration of function ‘evsel__is_retire_lat’ [-Werror=implicit-function-declaration]
 1562 |                 if (evsel__is_retire_lat(evsel))
      |                     ^~~~~~~~~~~~~~~~~~~~
util/evsel.c: In function ‘evsel__open_cpu’:
util/evsel.c:2258:24: error: implicit declaration of function ‘tpebs_start’ [-Werror=implicit-function-declaration]
 2258 |                 return tpebs_start(evsel->evlist);
      |                        ^~~~~~~~~~~
util/evsel.c: In function ‘evsel__close’:
util/evsel.c:2453:17: error: implicit declaration of function ‘tpebs_delete’; did you mean ‘timer_delete’? [-Werror=implicit-function-declaration]
 2453 |                 tpebs_delete();
      |                 ^~~~~~~~~~~~
      |                 timer_delete
cc1: all warnings being treated as errors
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/util/evsel.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: util] Error 2
make[2]: *** [Makefile.perf:787: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢[acme@toolbox perf-tools-next]$



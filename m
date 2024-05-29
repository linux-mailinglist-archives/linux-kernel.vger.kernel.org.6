Return-Path: <linux-kernel+bounces-194609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD238D3EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12E3282824
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1351C2324;
	Wed, 29 May 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3VDwdF/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A06167DA0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010751; cv=none; b=e8xSpVQXqDsaYmDDFCWZGpOTk/zyaUSejhuF84y/5/WNuMIg6/9dGWEgTMeRaBKukFnC4t7NtBeLvfjQXJGZLAtpbamuiCh5S6w+vm+lFIPBkL6WQJVWZBnFBYYxNO3DB74cx3z8llAPrTEaLH+52+45BWOUsSXpfS39uw6JVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010751; c=relaxed/simple;
	bh=qau4TnQTLCJ6dUG1JfmjEBzgHhFNhUeMEavfqama7/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4RsMALjAdniB4mip+KunEfe+Ts/nujmQycrFfTEgYNFa/MhODMxez4/9lhTwNHM0UOJqOl7I1b17C+KAyEl/UUvrnAV+mp6Xenr4h9hFTVnqIByHaCDAQMs7E8UFWFUgxp3xH+7nA4Vv8TC/pJ4lwcgr+jt1pdp0bhG+0nk8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3VDwdF/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f61742a024so22695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717010748; x=1717615548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcHXZYNVAPb5sy+gdGpxU0Vb6UWtbp2PlB65rDFp4R8=;
        b=k3VDwdF/d+u1RTv2AQZG5cXuaaTOJzngzMJJdNBIA/ZC1RNHEVBAHLM6pnCPLvrpW2
         /XUFTpmF3bQZLMErCdVPQT+a/vfjRc45o6cTaC/KCYg6qtd7I0JUYxiHlyD7OfmTm38/
         E1XCkI1LhRzRS4f5Zu7e+n5y0vaajPhZSyoNTdbNvG55Fa6fggkDDzms/PQ2lzadACzH
         FBM1toi9Ixld0Teg4vmENNOCOfnWV/vpoNl/tHCG3gac/hizyl7YUfLSIZy7S446Ptgd
         twp8wk3nKHd4zT6wrlW/v68OeoUh9vxLPA6D60tv8Rlh0tlVnfYRWQVgupFskLt1/Jwz
         zjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717010748; x=1717615548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcHXZYNVAPb5sy+gdGpxU0Vb6UWtbp2PlB65rDFp4R8=;
        b=uuXvttrklRv0tLmXJNVmEJZCuwoNEou3wg6vBcaPkqVzrmrbLf9S25PkWDYOoJJWZa
         iD6b2VjBGOG+u5eWo5TiHsbznfroi9qVj2zx3njJQrYRgGir50ekt/IJivzMwe6Dais0
         x3xXE+XqOITWFdcOSXq+y1Vys8ycyi6+D03yTy5xWoNeFIpQPbPMKyUbhBeW9sJ5x6wg
         KhPW27jZOK/zNrrCqx2gWaJ1sN1SmUGw7yxLuuZXJqK3bnxBn3fb+y6neKUVF9ACM0Sm
         iJvX5mknEda8eaJ73zR6cNMXc+hCY+IGctHu8XFyjQLp2MtK5uWqr6s0BEkX+bLTsuME
         EMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmoqhvZzAHfirUwUxYSP7JjRrqv5exUjvJrlTD+A7kxNK1vlrkk+1HQceWgXpnrLnNK/FypwOF2VoAvLVLXsq8VvhRT/BDSzfVXhhK
X-Gm-Message-State: AOJu0YxJRZR9rgE1T4llI4Xl2n6hiVAAU0YNSHMGcl7ouSy8UKalEbEg
	gtHLy/ZoWo6tDGC0x9xXNKwPluk/dhKlB/+hwQJ5l407HCqUMpCslZT8HU23zwc5LdXezCNW6zB
	1alup76NclD/lE4S2CGGIyceMj8rWR2kTi+ND
X-Google-Smtp-Source: AGHT+IGSCJx+bQ7X2TShWPPI1eMhVXTbq+LVM0Up0WzEjPwsP/uMWfjL2f/dbjeBogtFNQhbppMx73Zn+IuAb/o6MHk=
X-Received: by 2002:a17:902:c382:b0:1f1:8fd9:b99f with SMTP id
 d9443c01a7336-1f6174f42bamr333315ad.11.1717010748193; Wed, 29 May 2024
 12:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1> <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <Zld3dlJHjFMFG02v@x1>
In-Reply-To: <Zld3dlJHjFMFG02v@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 May 2024 12:25:35 -0700
Message-ID: <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:44=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 29, 2024 at 03:50:53PM +0100, James Clark wrote:
> > Is the problem you are referring to that there are multiple PMUs with
> > 'cycles' events? Surely that's only a problem in the context of the new
> > proposed behavior, otherwise it's not really a problem. It's just
> > something that happens to exist.
>
> > Because the user could always use the defaults (no argument) or -e
> > cycles and historically Perf correctly picked the one that could be
>
> See below to see if mixing up "cycles" for efficiency and performance
> cores is something sane or if I am missing something.
>
> > opened. Or if they want the DSU one they could specify it. That can all
> > still work _and_ we can support "prefer sysfs/JSON" as long as we don't
> > prefer it when opening the event doesn't work.
>
> Yeah, getting all the events in all the PMUs that match a string (after
> it is normalized to cover historical artifacts, as in the case of
> "cycles", "cpu_cycles" and "cpu-cycles", all of which should mean
> "cycles" the special, default event) and that can sample if that is what
> is being asked seems to be a sane outcome from this discussion.
>
> But lemme do try to show the differences from my Lenovo Intel Hybrid
> system (13th gen) and a Libre Computer Rockchip ARM64 hybrid system:
>
> There are some differences on how ARM64 supports hybrid that we may find
> interesting to fix or at least to (better) document, for instance:
>
> root@roc-rk3399-pc:~# dmidecode -H 1
> # dmidecode 3.4
> Getting SMBIOS data from sysfs.
> SMBIOS 3.0 present.
> 7 structures occupying 283 bytes.
> Table at 0xEAE7A020.
>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: libre-computer
>         Product Name: roc-rk3399-pc
>         Version: Not Specified
>         Serial Number: b03c01a7179278b7
>         UUID: 63333062-3130-3761-3137-393237386237
>         Wake-up Type: Reserved
>         SKU Number: Not Specified
>         Family: Not Specified
>
> root@roc-rk3399-pc:~#
>
> This is a hybrid architecture:
>
> root@roc-rk3399-pc:~# ls -la /sys/devices/*/events/cpu_cycles
> -r--r--r-- 1 root root 4096 May 29 16:27 /sys/devices/armv8_cortex_a53/ev=
ents/cpu_cycles
> -r--r--r-- 1 root root 4096 May 29 16:27 /sys/devices/armv8_cortex_a72/ev=
ents/cpu_cycles
> root@roc-rk3399-pc:~#
>
> In an intel hybrid system we instead have:
>
> root@number:~# ls -la /sys/devices/*/events/cpu-cycles
> -r--r--r--. 1 root root 4096 May 29 13:59 /sys/devices/cpu_atom/events/cp=
u-cycles
> -r--r--r--. 1 root root 4096 May 29 14:00 /sys/devices/cpu_core/events/cp=
u-cycles
> root@number:~#
>
> Small difference, a - versus a _, but then both hybrid, efficiency
> cores (armv8_cortex_a53 vs cpu_atom) and performance ones
> (armv8_cortex_a72 vs cpu_core).
>
> On the Intel Hybrid system:
>
> root@number:~# perf record -e cycles -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 4.709 MB perf.data (46911 samples) ]
> root@number:~# perf evlist
> cpu_atom/cycles/
> cpu_core/cycles/
> dummy:u
> root@number:~#
>
> root@number:~# perf evlist -v
> cpu_atom/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa000=
00000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|P=
ERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, s=
ample_id_all: 1, exclude_guest: 1
> cpu_core/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x4000=
00000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|P=
ERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, s=
ample_id_all: 1, exclude_guest: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY)=
, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIE=
R, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap=
: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_e=
xec: 1, ksymbol: 1, bpf_event: 1
> root@number:~#
>
> So it is recording CPU cycles in all the CPUs in the system, performance
> and efficiency ones and that gets clear on a per-sample base:
>
> root@number:~# perf script
>             perf 2465078 [000] 73716.379947:          1 cpu_core/cycles/:=
  ffffffffb40a55fa native_write_msr+0xa ([kernel.kallsyms])
>             perf 2465078 [001] 73716.379966:          1 cpu_core/cycles/:=
  ffffffffb40a55fa native_write_msr+0xa ([kernel.kallsyms])
> <SNIP more cpu_core/cycles/ samples>
>      gnome-shell    2608 [018] 73716.380704:    6721618 cpu_atom/cycles/:=
  ffffffffc0b8419c fw_domains_get_with_fallback+0xfc ([kernel.kallsyms])
>           podman  688107 [017] 73716.380706:    6695621 cpu_atom/cycles/:=
      564fc6110da0 [unknown] (/usr/bin/podman)
>           podman  687246 [000] 73716.380842:    8844997 cpu_core/cycles/:=
  ffffffffb515150c _raw_spin_lock_irqsave+0xc ([kernel.kallsyms])
>           podman  688108 [016] 73716.380913:    6737580 cpu_atom/cycles/:=
  ffffffffb515205c native_queued_spin_lock_slowpath+0x28c ([kernel.kallsyms=
])
>          swapper       0 [004] 73716.380932:    2090132 cpu_core/cycles/:=
  ffffffffb513ad49 poll_idle+0x59 ([kernel.kallsyms])
> <SNIP>
>
> But on the ARM hybrid system, without Ian's patch, i.e. with what is in
> torvalds/master right now (plus some header copies updates I'm working
> on that are unrelated):
>
> root@roc-rk3399-pc:~# perf record -e cycles -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.135 MB perf.data (359 samples) ]
> root@roc-rk3399-pc:~# perf evlist
> cycles
> dummy:u
> root@roc-rk3399-pc:~#
>
> It records just one "event" even tho it is recording for all CPUs, both
> efficiency and performance:
>
> root@number:~# perf script
> <SNIP>
>  kworker/2:1-eve   10124 [002]  9687.302790:      60674  cycles:  ffffc4c=
65bdd7380 vmap_small_pages_range_noflush+0x190 ([kernel.kallsyms])
>  kworker/2:1-eve   10124 [002]  9687.302957:      66040  cycles:  ffffc4c=
65bdd7438 vmap_small_pages_range_noflush+0x248 ([kernel.kallsyms])
>  kworker/2:1-eve   10124 [002]  9687.303139:      71011  cycles:  ffffc4c=
65cde0210 ww_mutex_lock+0x60 ([kernel.kallsyms])
>          swapper       0 [002]  9687.303342:      75390  cycles:  ffffc4c=
65bbc31c8 update_blocked_averages+0x188 ([kernel.kallsyms])
>          swapper       0 [000]  9687.309276:      45496  cycles:  ffffc4c=
65ca38978 cpuidle_enter_state+0xc8 ([kernel.kallsyms])
> <SNIP>
>
> Everything appears as "cycles" but we're getting samples for all CPUs,
> again, performance and efficiency ones, different kinds of processors,
> right?
>
> root@roc-rk3399-pc:~# perf report --stdio --sort cpu
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> # Total Lost Samples: 0
> #
> # Samples: 359  of event 'cycles'
> # Event count (approx.): 23873034
> #
> # Overhead  CPU
> # ........  ...
> #
>     31.34%  003
>     22.44%  004
>     19.30%  000
>     12.94%  002
>      9.14%  001
>      4.84%  005
>
> root@roc-rk3399-pc:~#
>
> If we try, instead with cpu-cycles:
>
> root@roc-rk3399-pc:~# perf record -e cpu-cycles -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.135 MB perf.data (346 samples) ]
> root@roc-rk3399-pc:~# perf evlist
> cpu-cycles
> dummy:u
> root@roc-rk3399-pc:~#
> root@roc-rk3399-pc:~# perf evlist -v
> cpu-cycles: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUN=
T_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID=
|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1,=
 freq: 1, sample_id_all: 1, exclude_guest: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY)=
, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIE=
R, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap=
: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_e=
xec: 1, ksymbol: 1, bpf_event: 1
> root@roc-rk3399-pc:~#
>
> Both 'cycles' and 'cpu-cycles' end up the same as type: 0
> (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES).
>
> But if we use something equivalent but with that - replaced with a _ we
> get a behaviour that is closer to the Intel one:
>
> root@roc-rk3399-pc:~# perf record -e cpu_cycles -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.137 MB perf.data (390 samples) ]
> root@roc-rk3399-pc:~#
> root@roc-rk3399-pc:~# perf evlist
> armv8_cortex_a53/cpu_cycles/
> armv8_cortex_a72/cpu_cycles/
> dummy:u
> root@roc-rk3399-pc:~#
>
> root@roc-rk3399-pc:~# perf evlist -v
> armv8_cortex_a53/cpu_cycles/: type: 7 (armv8_cortex_a53), size: 136, conf=
ig: 0x11 (cpu_cycles), { sample_period, sample_freq }: 4000, sample_type: I=
P|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inheri=
t: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
> armv8_cortex_a72/cpu_cycles/: type: 8 (armv8_cortex_a72), size: 136, conf=
ig: 0x11 (cpu_cycles), { sample_period, sample_freq }: 4000, sample_type: I=
P|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inheri=
t: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY)=
, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIE=
R, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap=
: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_e=
xec: 1, ksymbol: 1, bpf_event: 1
> root@roc-rk3399-pc:~#
>
> That doesn't mixes up CPU cycles for different CPU types:
>
> root@roc-rk3399-pc:~# perf script
> <SNIP>
>             perf   16726 [005] 12632.206216:       3798 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65be618d8 do_vfs_ioctl+0x424 ([kernel.kallsyms])
>          swapper       0 [000] 12632.206235:      78413 armv8_cortex_a53/=
cpu_cycles/:  ffffc4c65ca38978 cpuidle_enter_state+0xc8 ([kernel.kallsyms])
>             perf   16726 [005] 12632.206272:      20279 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65be113b4 kmem_cache_alloc+0x44 ([kernel.kallsyms])
>          sugov:4     166 [004] 12632.206409:      52979 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65cde5de8 _raw_spin_unlock_irqrestore+0x14 ([kernel.ka=
llsyms])
>             perf   16726 [005] 12632.206443:      67123 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65be26bbc arch_local_irq_restore+0x8 ([kernel.kallsyms=
])
>             perf   16726 [005] 12632.206690:      96987 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65bdb4a84 fault_in_readable+0xe4 ([kernel.kallsyms])
>        perf-exec   16727 [004] 12632.206836:      84199 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65bd6c3b4 next_uptodate_page+0x264 ([kernel.kallsyms])
>             perf   16726 [005] 12632.206950:     102567 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65bbe2aa4 up_write+0xa4 ([kernel.kallsyms])
>          swapper       0 [000] 12632.207030:      78413 armv8_cortex_a53/=
cpu_cycles/:  ffffc4c65ca38978 cpuidle_enter_state+0xc8 ([kernel.kallsyms])
>        perf-exec   16727 [004] 12632.207037:      79507 armv8_cortex_a72/=
cpu_cycles/:  ffffc4c65c48b89c strnlen_user+0x16c ([kernel.kallsyms])
> <SNIP>
>
> So from the point of view of the user its important to differentiate
> samples for each type of CPU, so grouping everything into the same
> basket as ARM did in its big.LITTLE seems strange/"wrong".
>
> The way that in Intel when it "does the right thing" (I think no quotes
> are needed here, but I may be missing something) and at the tool level
> translates the special event name "cycles" into what the Intel PMU
> kernel drivers advertises to the world via sysfs as
> /sys/devices/cpu_{atom,core}/events/cpu-cycles (with that -) and ARM
> advertises as /sys/devices/armv8_cortex_a{53,72}/events/cpu_cycles (note
> the _) but gets translated in terms of 'struct perf_event_attr' as
>
> Intel:
>
> cpu_atom/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa000=
00000
> cpu_core/cycles/: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x4000=
00000

Here there is a legacy encoding of config 0 meaning
PERF_COUNT_HW_CPU_CYCLES the high bits are (from perf_event.h):
```
 * PERF_TYPE_HARDWARE:                  0xEEEEEEEE000000AA
 *                                      AA: hardware event ID
 *                                      EEEEEEEE: PMU type ID
```
Intel has a cpu-cycles sysfs event and depending on whether you do or
don't have the reverted patch the priority of that over a legacy event
is going to vary.

> Versus ARM as:
>
> armv8_cortex_a53/cpu_cycles/: type: 7 (armv8_cortex_a53), size: 136, conf=
ig: 0x11 (cpu_cycles)
> armv8_cortex_a72/cpu_cycles/: type: 8 (armv8_cortex_a72), size: 136, conf=
ig: 0x11 (cpu_cycles)

Here cpu_cycles isn't a legacy event which use hyphens and not underscores:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.l#n335
The two sysfs events were programmed. Were another PMU advertising
cpu_cycles we'd also try to program that.

> can possibly be made more consistent in a way that doesn't break any
> user experience using the perf command line.
>
> I would propose that 'cycles' explicitely asked or as the default,
> translates into armv8_cortex_a{53,72}/cpu_cycles/ on ARM and on
> /sys/devices/cpu_{atom,core}/events/cpu-cycles on Intel, and that
> whatever other architecture that comes to this party tries to learn from
> this botched experience.

I don't understand this paragraph. My expectation is that sysfs and
json are priority over legacy, we transitioned to this to fix ARM,
this does mean reverting the revert. We use legacy for core PMUs when
the sysfs/json lookup fails and there is a legacy name. We may or may
not have a notion of special events where special events are only
programmed on core PMUs. My preference is no notion, as what flavor of
cycles, .. go in it is just madness. Linus disagrees and won't talk
about it to clear up the ambiguity. If we do have special events then
can we keep scanning all PMUs by having test logic that complains when
a PMU uses a special name for one of their events or must we put
special case logic in the event parser?

We can fix the arm_dsu bug by renaming cycles there. If that's too
hard to land, clearing up ambiguity by adding a PMU name has always
been the way to do this. My preference for v6.10 is revert the revert,
then add either a rename of the arm_dsu event and/or the change here.

We can make perf record tolerant and ignore opening events on PMUs
that don't support sampling, but I think it is too big a thing to do
for v6.10.

I don't know what state perf test is in, and I expect the answer
varies greatly between perf-next and linus/master. There is stuff
queued up to go in perf-next further building on the expectations of
the reverted patch.

Could someone at ARM please set up a build/test server on linux-next
for whatever machine is Linus' flavor of the day so that we don't see
this happen in a PR again. I build test ARM on a Raspberry Pi and the
BIG.little devices are similarly at the low end of the
price/performance spectrum. In all likelihood they all lack precise
samples, Linus' command lines show he cares about this.

Thanks,
Ian


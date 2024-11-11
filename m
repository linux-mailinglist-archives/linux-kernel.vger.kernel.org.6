Return-Path: <linux-kernel+bounces-404878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7B39C49AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D41B264FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E21ABEA1;
	Mon, 11 Nov 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="M4yy66o2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D715B122
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367412; cv=none; b=s9UKNoLZ7dsPw6tfgYzSUMN480FpU/GpM5CbNedynfmr57Mw2nmlIC9h/AXykcD/UnC5bBQ1v6uKA3IZJT0hHXcrhPF17HbRgU4ztmtHGx04Y+IjwsgRfjtba3yW3y+iRlw1Pwcn9MQRlKGdTA1sMtymJ0Bq2mwKMG0nGMExEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367412; c=relaxed/simple;
	bh=pezunZPY1Pnl/E71gvuB423SjwlhMvE+i0G93CIYoR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqsAsc3RKzxwlvjE02HEldPNsTGsKNb93R3fUDt1u/g86gF+6YN2pWjgFiL8BblNx1LD6HA6ddU5qp2WOTbsnCynatfJZWWvYyLYU+odbHGeNBIacroOQTEFn5jjsXBik5ugEOKwTosn7UYyNdqI8FB2jyWYdSIaTTh+glK6wqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=M4yy66o2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso3582652b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731367409; x=1731972209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfkKwHEqEKuvC0xVezU0FnOzboDm7id7i17WV79t3rw=;
        b=M4yy66o2menQefM4+xNOZrb38RKYKKy5izdI86diaAtNrrhloI/bm5PhK27bijbivG
         qlEINHIpqpa0Xuw6xM++vutpyv4HUtTldgZK22rn3t/aLvYTQ4iEWwH080vhSBHLA6PM
         OO+V5/Ysx8wyANMyOLBD+WEx6X5xZuicw5BSFNt8osxuwxOxPi7k8IT6rM4m3EWpIzc8
         St0qqw4LL9ZHmVSE6koT4TrYfwH3kntbvpAbgWYWLqtcQNS4PIwUvXvcurOdaM+f3cAz
         ZafJIUc+6MZ9TIhbw1/XCtCwtRF9D/of8BHaJRfDNmdpHAdDVLjw7LlomU44ECQRfctq
         ggKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731367409; x=1731972209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfkKwHEqEKuvC0xVezU0FnOzboDm7id7i17WV79t3rw=;
        b=Nixi7meD74Pox0/r8uDF5vnZXmDjtcHYhs2xa7x2HaBWTyD1rRTQZ92NIXEuobTCec
         pIXEZnl3SlXdRkuy8HpRKUWpTio7Wuz7xN0Z2pscBQRkEwLU7NW/ZZYjyYYCBsE1Ib7W
         wCv/0AUsfkNQDfyvvoek9Nf7cyCJ4uH6oS9M8ZAX82KBSHs4C4lESMou27J5yAh9lezK
         8MRfMn7EEJII6d+fmnBR+VtvQkayT3OpcNXd+2Pa/0dmH4YsoV+Smnmuy3N1nT/o013R
         8F7+woDlo7Jxr2iHLiPwymWZvPMq1kyY1IacwltkQ4iaI/8Rm1uBmeZa7iSzlJOk5sOn
         oF5A==
X-Forwarded-Encrypted: i=1; AJvYcCVd5BCgWmGmLDtYCxc5F4d0Zn50YICjXVyh2i0s6PvYe+Baxz0V67qNuIpN791MBACWDOvZNbeb4koLDrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qIlq5VpGO0VC0Gmr7T9uC9ltUUhVXapsPq3n2o20qIfOH//h
	V1QcRVU/pJrR7IkMtEGsS+1a40X8veYwzCCSDe+JbOY53imL5nr3+clvk8v9iV6DcNZt3UuHL93
	xGkbPAWEsulyJWL50NhAWTUmY3eyZh14kHyVfvg==
X-Google-Smtp-Source: AGHT+IFB+aENPfYJcxrY/B/QgxvxxyBcebWQTXtdrGQMviuRc2OeVXcpmuwNdw+GfRFld6Cwnlx4fxFV61+mb2R453c=
X-Received: by 2002:a05:6a00:14d3:b0:71e:659:f2e7 with SMTP id
 d2e1a72fcca58-724132a1a87mr19143630b3a.8.1731367408901; Mon, 11 Nov 2024
 15:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com>
In-Reply-To: <20241026121758.143259-1-irogers@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 11 Nov 2024 15:23:18 -0800
Message-ID: <CAHBxVyF5c4CW7kdPoBENv7o7mObo=yaHdf7peATY+Jq6Aug=Bw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> At the RISC-V summit the topic of avoiding event data being in the
> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> events being the priority when no PMU is provided so that legacy
> events maybe supported via json. Originally Mark Rutland also
> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> M? processors, but James Clark more recently tested this and believes
> the driver issues there may not have existed or have been resolved. In
> any case, it is inconsistent that with a PMU event names avoid legacy
> encodings, but when wildcarding PMUs (ie without a PMU with the event
> name) the legacy encodings have priority.
>
> The patch doing this work was reverted in a v6.10 release candidate
> as, even though the patch was posted for weeks and had been on
> linux-next for weeks without issue, Linus was in the habit of using
> explicit legacy events with unsupported precision options on his
> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> where ARM decided to call the events bus_cycles and cycles, the latter
> being also a legacy event name. ARM haven't renamed the cycles event
> to a more consistent cpu_cycles and avoided the problem. With these
> changes the problematic event will now be skipped, a large warning
> produced, and perf record will continue for the other PMU events. This
> solution was proposed by Arnaldo.
>
> Two minor changes have been added to help with the error message and
> to work around issues occurring with "perf stat metrics (shadow stat)
> test".
>
> The patches have only been tested on my x86 non-hybrid laptop.
>
> Ian Rogers (4):
>   perf evsel: Add pmu_name helper
>   perf stat: Fix find_stat for mixed legacy/non-legacy events
>   perf record: Skip don't fail for events that don't open
>   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>     legacy"
>
>  tools/perf/builtin-record.c    | 22 +++++++---
>  tools/perf/util/evsel.c        | 10 +++++
>  tools/perf/util/evsel.h        |  1 +
>  tools/perf/util/parse-events.c | 26 +++++++++---
>  tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>  tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>  tools/perf/util/pmus.c         | 20 +++++++--
>  tools/perf/util/stat-shadow.c  |  3 +-
>  8 files changed, 145 insertions(+), 73 deletions(-)
>

Thanks for the series. Tested on RISC-V qemu with counter delegation enable=
d.
I am able to get the event encodings specified in the json file
instead of legacy event encodings.

--------------------------------
root@debian:~/host# ./perf stat -e cycles -e instructions -vvv ls
Control descriptor is not initialized
Opening: cycles
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             136
  config                           0x1 (cycles)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  { bp_len, config2 }              0x7f9
------------------------------------------------------------
sys_perf_event_open: pid 424  cpu -1  group_fd -1  flags 0x8 =3D 3
Opening: instructions
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             136
  config                           0x2 (instructions)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  { bp_len, config2 }              0x7fc
------------------------------------------------------------
sys_perf_event_open: pid 424  cpu -1  group_fd -1  flags 0x8 =3D 4
---------------------------------------------------------------------------=
--------

However, we may still have to provide the encodings in the driver for
vendors due to the reasons described in the
thread. Hopefully, we can get rid of legacy PMU events one day which
will allow us to remove those driver bindings in the future.

Tested-by: Atish Patra <atishp@rivosinc.com>

> --
> 2.47.0.163.g1226f6d8fa-goog
>


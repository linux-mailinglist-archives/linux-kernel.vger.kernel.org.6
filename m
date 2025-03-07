Return-Path: <linux-kernel+bounces-550470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F2A55FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2C73B3018
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81348194C77;
	Fri,  7 Mar 2025 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALEhraHS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C91624E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325111; cv=none; b=h+LWlitSPQim+YZEQRPQbTFw2lV/FtqZSbzQb9RncaM5RSBGebpw7ll+WkYHq5Dnbq2XDI1Zf3OrpCrjVYRnQkiG25b6tG6w8GnjnMmgiVi5Z31B3fNh0bIyGKspLnQM3uIKe3SYw8TRvGutNs/h9kI27nupaNMzoIkeTrkeSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325111; c=relaxed/simple;
	bh=bI3OybnSxdkVjgMf7Q+ee/FOm4jiD9TYuTB8jpdlQGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5Ildh590QnyVb7rTq9tGq5BWE4nvd5yC9PyXue4eeW+7ptj+l0rvhQzqEQbMABuCO4SCnl7KNKMw2REUc3QC65l1KnpgeIInu/6TIUK2EVpD0/r+tW4OiA7WPlfcBDQPml79tnaL3XonrbSwM4r4auldmcVwrph3V0i2F1Rn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALEhraHS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so106405ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 21:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741325109; x=1741929909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWlAu5LA7bOZxdM/Sjg+8r3QT3/ix5LQ+eNaKjKWuzs=;
        b=ALEhraHSo01EIwIZGcdsHaije/Mdo9/vDEY20i2rGp8OfCYrzHwAcdlQYuS4bfDMpY
         ShRhrjg7EmsP1TtunRbWS45ULJvGyKeNuN0ADjUNNzfMpYs7XmatA4s2eDCBla3pRY+V
         sH8Q59YaSSO91ylBj2PVfkQd0IbdgfUdU4f+DuhYpU77atGIYUS0cNZfXTSYXZaUu9qv
         s63lFrAz227LZPX9UZsLnNccua/p160o9ajZiqtiZg0/LjFS+iGVFsm/iIQd1z6V6oKC
         KrAU7BPPNlC3S3iwQRBS3ZyA8gJ9eLO9YvcuLANNN20UuEaRlk6Qr23KMB/GPkOv3X6O
         ADhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741325109; x=1741929909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWlAu5LA7bOZxdM/Sjg+8r3QT3/ix5LQ+eNaKjKWuzs=;
        b=fk7ifanfUvyMIjhvvvgRvDNa/NUAduO+1swLDWf63tge4lUsfEIP+Un6JatPu4ME9S
         dk4X6j69bmJVoMjbJqtrlqb85sgJOjB93nxL6XUWVdQOx1GvdMFB4yAWcoC2KwnLJJbc
         eXVwhGsQo8gB/WayCr04EkRuVA/A4Y91Xn3eS7v71wnj1taTQeVAo5xveZddyla4mYFe
         dUJJVhlduiIZduRwrXje1JZK6AnVPB7ep21oMKwe8oZMLk6D3EDQi7l5WJ52OA48TJLI
         T/53W8TFEswGVlG+VXbg82Uhp2hSwtPScDn53fdA1RbB5LEaPw0fOekmG4d5H+f2u4QK
         6pBw==
X-Forwarded-Encrypted: i=1; AJvYcCXS93pK5yErGJdTYVHhvxVXbzJNBjOQ5NZnK6+PuoAsAxNjljz0kFZTLGNMi5cqKz/YC3jntDapiOxFdKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+lL53LBtmYQ+cNc9ul0/VDTGQH7SLepUFZ2bjfi+SYhXHKAk
	RqYufVYdY82T8KYXgnRHAPTTkXyY+nmqL5lJS4x7PD8hp+qyoVss2agxmDVU9njDPyajcXj6r7T
	GNVpP3YtjlQtzZVdsnN3cF4x3LQf0DYwnfCyA
X-Gm-Gg: ASbGncsEmp6rv1V+EW5RKSPgR8/9vKaQ+hEhkXpp72zXss+RcCqC06NnAfYigqqJ7AB
	5GAl8vRuFyQWPyNU8ByEYvySlQe95L35Mb31ZmfzCtlBQ8RVkaJeWAlbflqZULp+N/5JUZAEgpo
	mlfSgBOGT3izEccWl85qTHBrsgrck=
X-Google-Smtp-Source: AGHT+IFRYVGJBUyqfEgEEPGl0XuJoVigNi9zw8+vpDfrTRYYJhLTf6i1tLXkipTYynSySNJGHrvuHKwIth5hC2cOdhc=
X-Received: by 2002:a17:902:e810:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-224297f2337mr1643855ad.24.1741325109250; Thu, 06 Mar 2025
 21:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7Z5kv75BMML2A1q@google.com> <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1> <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
In-Reply-To: <CAP-5=fXSgpZaAgickZSWgjt-2iTWK7FFZc65_HG3QhrTg1mtBw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Mar 2025 21:24:58 -0800
X-Gm-Features: AQ5f1JpJ-b0lCDiYR38BKsmRp5-QxDImcV_6P1n0_NI2oBbV65AfpBr4ZBGs4EQ
Message-ID: <CAP-5=fX3U3JsRebOLWNQ-0n+W8aGWSLoDWYNZ9f4T7+sPa4H4g@mail.gmail.com>
Subject: Re: [RFC] perf tools: About encodings of legacy event names
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:36=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The series is trying to make "most people" happy with "no surprise"

So the patch [1] fixes a number of event grouping bugs present on all
Intel CPUs post Icelake (released April 2021). I think the code isn't
trivial, and I've tried to simplify everything as much as possible.
Again it shows the event parsing isn't a static problem and I am
trying to contribute fixes which this RFC on [2] is holding up.

On Alderlake I see problems:
```
$ perf stat -vv -e
'instructions,cpu_core/instructions/,cpu_atom/instructions/' perf test
-w noploop
Using CPUID GenuineIntel-6-B7-1
...
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0xa00000001
(cpu_atom/PERF_COUNT_HW_INSTRUCTIONS/)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 1157109  cpu -1  group_fd -1  flags 0x8 =3D 5
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 size                             136
 config                           0x400000001
(cpu_core/PERF_COUNT_HW_INSTRUCTIONS/)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 1157109  cpu -1  group_fd -1  flags 0x8 =3D 6
------------------------------------------------------------
perf_event_attr:
 type                             4 (cpu_core)
 size                             136
 config                           0xc0 (instructions)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 1157109  cpu -1  group_fd -1  flags 0x8 =3D 7
------------------------------------------------------------
perf_event_attr:
 type                             10 (cpu_atom)
 size                             136
 config                           0xc0 (instructions)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
------------------------------------------------------------
...
Performance counter stats for 'perf test -w noploop':

   13,323,070,728      cpu_atom/instructions/
                        (1.87%)
   26,695,170,453      cpu_core/instructions/
                        (98.13%)
   26,695,170,453      cpu_core/instructions/
                        (98.13%)
   13,323,070,728      cpu_atom/instructions/
                        (1.87%)

      1.007358136 seconds time elapsed

      1.003129000 seconds user
      0.004012000 seconds sys
```
That is the instructions event, literally the 2nd legacy event after
cycles, getting 2 different encodings but the stat output showing the
events as if they are the same. The multiplexing numbers obviously
look off.

There is still work to do. Specifying a topdown event twice in an
event list currently breaks (e.g. `perf stat -e "slots,slots" ..`). I
see situations in perf-tools-next where a wildcard tries to open a
legacy event on even uncore PMUs.

Given [2] under pins so much I think merging it has to be a priority.
I suspect it needs rebasing and checking in the light of the changes
in [1]. Given it has extensive reviewing and testing by vendors, it
helps RISC-V and ARM Apple-M, I hope that after 2 weeks of this thread
that hasn't stimulated additional comment (beyond the original
comments on the series) things can move forward and fixing things can
continue.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20250307023906.1135613-3-irogers@google.co=
m/
[2] https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-iroger=
s@google.com/#r


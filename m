Return-Path: <linux-kernel+bounces-539854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137AA4A9EB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3587AA7C9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481A1CAA9A;
	Sat,  1 Mar 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="ZrIwghHt"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B7189BB0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740820912; cv=none; b=FPsaIEX3Gd4XKj0hlZdqr2cT3J+Nrc5Hb87vJ+KaemcPlqLC8nSB84p4mwfP6TmW7C9oo6szx/y+uXvV0mn12F4vLsyNKh0ROvnwxS0qzgcUSSLz8ky3VTO3N4RpT2ezJKguVLYMmuGMLaXSbBGk2hGp/Hi6M385ecTNAuPWzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740820912; c=relaxed/simple;
	bh=470EBXt8fl6XJkf8ZJRFwnw5P+hQer58Ix6/GEv8Ywo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFvOsZBNfoEZ182aHY8JOHi63Tjh1O3kL/e/mszZO/iB2Z1llSxK8wkUp7KM6gIgpSXa1d3MIExZCKzwQcFMvF0dN8LbZHrQm0a7Xg0//rt7d1VXxK+/QKxX9xrrvt7Y7QVFiVoclF8BpCogSOoZ92MNgzd2H3F1XG8WjQUu7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=ZrIwghHt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54298ec925bso4351091e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1740820908; x=1741425708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GWaeb76LjLymBzAsvZgprQtrlh/Mis5wEPFqb9KAZI=;
        b=ZrIwghHtV1xRxUBo3+tju0AqDJqo6mX0AsNghcEftzITwuK6dgHIMQsTNSLYH5ZrKj
         ojMgce0wY070Ftv7yqNuYYkMDGKDLXdQb0wBTo9mdPcu2+XjzHmX2YEZ5dH1rHwBMJby
         S0kyodNSrWPv9h2+sRzuSsMRRATquRIqBeuME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740820908; x=1741425708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GWaeb76LjLymBzAsvZgprQtrlh/Mis5wEPFqb9KAZI=;
        b=Dp6269oAU/DyCLgiuCJJG/vZU/6DkvcKfzyBoHnehS2IFUOdsghwiVQY0E8TCGXEOI
         vtZWp3yfhYk0+HR7N8ssQAbuGyGyH45NjcN9HNmQ5WmNmbWYG5xc5bwTZMidNeGzUu8o
         RpPtGDfu5SO7CAB1Hop0tn3q6JHuBeCo+SpB1n4uzKcJhNAZREfewsD8GtHZ0iOou4v6
         eGStFvegHmUHDN2poDuKzm+n9z68BEcLTEfD84cINxH1qCcGlrW8xOZHYdOEQZG8QGdY
         7h05hOypvWsikHlV1ume4RsIRo6Yjtlxn3VpGnaZ80suv6z1g9L97Ng3Ffjcocx49a6M
         AluQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz1Dmc+heeexz1C5hSwTcJXBhJG1h2mWh57lgu/xkp5XE1MCcX6ZsfEPZdQF9wYV4QXAuG3m+JTgbcjSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwELy/9l7u18OqCUxACuS0RXbLZ04usDGr/tZ9RzG4wzk0AD5b3
	rkzV9llPnqI1Udq2kfHrAhvJnWltyIR74/sSReLTr5ahbKkx4FWXLn5naLfgpIjoCeYBJfRm+BK
	9EUm5krA37Ik0UCn0Duc95SlO38FNUSKrXaj4
X-Gm-Gg: ASbGncty74JX5FbmuPFEHywuIxjbUDPEm3H9bXoZY1IU/pmmnAUGSAd5/Wv1F4Gu4+R
	1fggeLh8Kc7JzA6vg6+u416WjTG9ZJ6GOzx+fOYVdruO/TTzv/mNfJfzsTXeP8ztf0VTEQmGjjy
	gPI5xPu0+U0C5bxyhwT8lCY00=
X-Google-Smtp-Source: AGHT+IH15LwzPfPF+oS2EZqpdH0JXfZ6W3b7ZvXs4eNLlzum83DD24jadEspiQYjcnBJSYtYXwDADT20S0Zkkl9QYD0=
X-Received: by 2002:a05:6512:2398:b0:547:6733:b5a3 with SMTP id
 2adb3069b0e04-5494c31955emr2721323e87.28.1740820907633; Sat, 01 Mar 2025
 01:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213220341.3215660-1-samuel.holland@sifive.com> <Z7ZLB-wZY9wTZSBZ@google.com>
In-Reply-To: <Z7ZLB-wZY9wTZSBZ@google.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Sat, 1 Mar 2025 01:21:35 -0800
X-Gm-Features: AQ5f1JqfruEFIOIrVnD5AKoYs2RXp5ctBzcsS8Mgvh9B2UED9CdH6vJZUSYebtM
Message-ID: <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
To: Namhyung Kim <namhyung@kernel.org>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Feb 12, 2025 at 05:21:33PM -0800, Samuel Holland wrote:
> > This series updates the PMU event JSON files to add support for newer
> > SiFive CPUs, including those used in the HiFive Premier P550 board.
> > Since most changes are incremental, symbolic links are used when a set
> > of events is unchanged from the previous CPU series.
> >
> > I originally sent this series about a year ago[1], but received no
> > feedback. The P550 board is now available (and I have tested this serie=
s
> > on it), so it would be good to get perf support for it upstream.
> >
> > [1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-s=
amuel.holland@sifive.com/
> >

Tested the patches that are part of sifive's release tree for p550.
Both perf stat/record seems to work fine
for a bunch of events.

Based on that
Tested-by: Atish Patra <atishp@rivosinc.com>

@Samuel Holland : perf report that the following two events are not
supported on the p550 board.

cycle and instruction count:
  core_clock_cycles
       [Counts core clock cycles]
  instructions_retired
       [Counts instructions retired]

I assumed that these are raw events cycle/instruction retired events
that can support
perf sampling as well. Maybe I am missing something ? DT binding ?

> >
> > Eric Lin (5):
> >   perf vendor events riscv: Update SiFive Bullet events
> >   perf vendor events riscv: Add SiFive Bullet version 0x07 events
> >   perf vendor events riscv: Add SiFive Bullet version 0x0d events
> >   perf vendor events riscv: Add SiFive P550 events
> >   perf vendor events riscv: Add SiFive P650 events
> >
> > Samuel Holland (2):
> >   perf vendor events riscv: Rename U74 to Bullet
> >   perf vendor events riscv: Remove leading zeroes
>
> It'd be nice if anyone in the RISC-V community can review this.
>
> Thanks,
> Namhyung
>
> >
> >  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  6 +-
> >  .../cycle-and-instruction-count.json          | 12 +++
> >  .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
> >  .../riscv/sifive/bullet-07/instruction.json   |  1 +
> >  .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
> >  .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++
> >  .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++
> >  .../cycle-and-instruction-count.json          |  1 +
> >  .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
> >  .../riscv/sifive/bullet-0d/instruction.json   |  1 +
> >  .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
> >  .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++
> >  .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
> >  .../sifive/{u74 =3D> bullet}/firmware.json      |  0
> >  .../arch/riscv/sifive/bullet/instruction.json | 92 +++++++++++++++++++
> >  .../arch/riscv/sifive/bullet/memory.json      | 32 +++++++
> >  .../arch/riscv/sifive/bullet/microarch.json   | 57 ++++++++++++
> >  .../arch/riscv/sifive/p550/firmware.json      |  1 +
> >  .../arch/riscv/sifive/p550/instruction.json   |  1 +
> >  .../arch/riscv/sifive/p550/memory.json        | 47 ++++++++++
> >  .../arch/riscv/sifive/p550/microarch.json     |  1 +
> >  .../p650/cycle-and-instruction-count.json     |  1 +
> >  .../arch/riscv/sifive/p650/firmware.json      |  1 +
> >  .../arch/riscv/sifive/p650/instruction.json   |  1 +
> >  .../arch/riscv/sifive/p650/memory.json        | 57 ++++++++++++
> >  .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++
> >  .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
> >  .../arch/riscv/sifive/u74/instructions.json   | 92 -------------------
> >  .../arch/riscv/sifive/u74/memory.json         | 32 -------
> >  .../arch/riscv/sifive/u74/microarch.json      | 57 ------------
> >  30 files changed, 555 insertions(+), 182 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/c=
ycle-and-instruction-count.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/f=
irmware.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/i=
nstruction.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/m=
emory.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/m=
icroarch.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/w=
atchpoint.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/c=
ycle-and-instruction-count.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/f=
irmware.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/i=
nstruction.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/m=
emory.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/m=
icroarch.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/w=
atchpoint.json
> >  rename tools/perf/pmu-events/arch/riscv/sifive/{u74 =3D> bullet}/firmw=
are.json (100%)
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/inst=
ruction.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/memo=
ry.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/micr=
oarch.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmwa=
re.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instru=
ction.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory=
.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microa=
rch.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-=
and-instruction-count.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmwa=
re.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instru=
ction.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory=
.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microa=
rch.json
> >  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchp=
oint.json
> >  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instruc=
tions.json
> >  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.=
json
> >  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microar=
ch.json
> >
> > --
> > 2.47.0
> >
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish


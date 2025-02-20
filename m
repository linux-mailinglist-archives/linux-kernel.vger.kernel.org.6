Return-Path: <linux-kernel+bounces-524413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655AA3E2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C15705E88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698321421A;
	Thu, 20 Feb 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdWphGH9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBD214215
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073086; cv=none; b=fc24wnLccDo8I3FwIOSHzZeMDxA6WUEwRzTVpD+jx+WlPsSLCcDhn/mCV1mhRIFuhnpv8avwAOBTeliTHmbbv1flCtD4DOfYGLXGhk6QKBVbzwkvXzcWes53bQ7/wt2cbjoCr8AgBE45RLXgtANm468+6rpV+U8CKAgg6aOj5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073086; c=relaxed/simple;
	bh=Z7Q6jLvBKPVoaN863zlBRG1AWyWlcDaw51zJcJY/YUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9H4/24AKvZqI3uzijPVMt9IWAs5mhJUrmtS8QsbHBnlGPjprJHf/MUlbyf3OGy2ckRdxlXUhixD64VoyFvlTA0xquDIbdos6wq2ofnXpjTpIDw3etSzY9qF9qpDSQj8WfUzDhfCrpLpEQnq+5rcf/+k/HElivNGNmQSCumFb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdWphGH9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f6ca9a81so170485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740073084; x=1740677884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Zt8TbTFLCvdcJDQPNYalgDYvJB11g+s/hwDIBn89f0=;
        b=gdWphGH9/1tkMQT0zEl84U2DGuSPwp1XSiTEbpOL2aWY/ulXpw6Xg52tfRFTEWvlHB
         kTJ1etWEZjx5WqdAmXaDQcUbUyIECdsnr3esZZQ5Myjc7PzEDj0AzzKllfhVLyDAO53f
         nGKWB06tOv4uCLrY0BEORshIPD3ZZyf2X9GIZbt3CgDbPsCIvlw5ZUb1EiumYP2TFzuL
         VddRs67fuLi+CgSBNKUJn5EV2PrjFDmfRtnlDGP3wJcxGtZ2oFeK4cbfUUQ/t+vz8SKB
         k6MyAlUxsf6ZpdSTLq9HiZ+EEE07jaBJMb9aCjGGlVrVotkr1cK6NOp/+H3daWFcy53R
         /rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073084; x=1740677884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Zt8TbTFLCvdcJDQPNYalgDYvJB11g+s/hwDIBn89f0=;
        b=w73vQwMng1lzSI9pVjpWDwKgykznXbTvH377IncPGsVZ+iVIXNmG+0P21dioN7YJqo
         Uzd2IG9ZAO7+TOMD6REQe/9J6ZlQV6u7SWkLfCa6xFlyyrVT3cw39uR5E4UIkiR3eyuK
         zTmY2YCJBI+jvgrNBoYkRO/MBsUgaJD5y8QsOKQrKQFv2+Yi8KhfwPsLZSzX9sFoz0t2
         vuhQtM1nPManGf3QvQfjMR7FZYNQ446ZkahYU1672rKtPQK1BmHTbt5jQnvfbArKNwt8
         qieNYRAWgKMgUG0kv1kJpc92zjTgI8p4JiwzcLlaabHSWVbSqVxafDvPOsBZHm/J7u2j
         U92Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMdn61b6A49PdjBDIxoodwJ5XpQMAhF0HJu/VJoBfQXjoy2HrapIZQ4L5QvO2STd33zYqICGTjFzDF2u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88oUPHIjw3C7NaI14GthOX0/PPDlVOORSEF6sEC7OZm0y4CGj
	S3yKMtOByuaOB+NB1/6sfD6WlEiHwO8bHYL1ePcDvAnImVBj7mqvA7EPYv1imAhN4z8+epmlkui
	B9/OvjZkZxWGBtqt/SeHiHl5J0ft+Ns7zXvtE
X-Gm-Gg: ASbGncs0al90tqOD3IZtXVqA5O0DewTsdXsmdMWjuXmbGuYM5OiRcjvQysJM+5ifxFm
	OxEVSFCVAcTIp0A20ygmeA/FWGWa62GRDDyxpzL1srTxdhNjreotY5J2hFtQTwNMNASgGnjK2WM
	1mJwib7BaFGJZ2Pbz2z4hgmsYy
X-Google-Smtp-Source: AGHT+IG5eD1d/34A/ma2l3agabxcu/jqWI6KO736c7ZnA0VLIWNC0HxJtPeN09ZtWyHb0S2Hmc+rMpeoUaXF+34Ar4c=
X-Received: by 2002:a17:902:ce8b:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-2218fe2de58mr2936735ad.1.1740073084261; Thu, 20 Feb 2025
 09:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213220341.3215660-1-samuel.holland@sifive.com> <Z7ZLB-wZY9wTZSBZ@google.com>
In-Reply-To: <Z7ZLB-wZY9wTZSBZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Feb 2025 09:37:52 -0800
X-Gm-Features: AWEUYZkM1J8XXujqhsMzCByDWam7Acafx_SwZqRr_AvhB1vHCga40P4J3rWis-E
Message-ID: <CAP-5=fW0KdRQpmKddLfwbVcJeOkkZ7xzmX8uDvwkuUGVsJAqwg@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
To: Namhyung Kim <namhyung@kernel.org>, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
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

I can add a:
Tested-by: Ian Rogers <irogers@google.com>
tag, for testing with a build with JEVENTS_ARCH=3Dall on an x86.

The changes use symlinks but generally we've not done this for Intel.
I'm not sure this matters and didn't see mention in the style guide.

The model naming and events are all coming from SiFive so I trust
they're happy with it, I didn't spot anything glaringly wrong.
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


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


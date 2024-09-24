Return-Path: <linux-kernel+bounces-337379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE58398494D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C96B23F69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E71ABEBC;
	Tue, 24 Sep 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ujvtm6JT"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EA1B960
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194319; cv=none; b=CyZd3b35uXc9jyj/RHznXhfZS9Sj7wo3EbKp2yHDU8bQ0MHH70/aKmEpqIrjUD2fy7EavqG3o95UM9ITWh0OzMSPdNlxdH4x5IA5YRDx29Dktqihg7Jyqq5WZTqRR0hTxpjyaE9ZGUta3vfemNN5fs/8/QmS4nyPipeStZFt9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194319; c=relaxed/simple;
	bh=yL3SPCS7ha4gVZmF/jL6dtueVPQCVEjaP3dTRzBpBV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw9sNF3vyUgBO2OBKMOG0hK7yq9CSp05xVhtwNdCfgF5tp+4LHeeaRk4vm68nnssp3MMOF4LA1dvmBLKNqzo6XBbU6x9tfcMmhnQpVda4N+vtUrrN/tToObv9RAXlKBaVC42TfwP8dSiuutAjpWFrqg6rD7G2SUwW1QyME0nLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ujvtm6JT; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so215195ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727194316; x=1727799116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK+8nqvRO7dO5/4/shw4l0Rx/ZNh1LhM3L6aL1WqmLo=;
        b=Ujvtm6JTf1Iib2dbQCezEhpWH6pBQv1u6NQG4jzqvv7WRgt2hQbST3lZuZHFxI60sK
         Q/54CV09ZFg46lOfTK8jBIeLnPlZcKrzR1J9iYbHNA9WL5OBsei39iZr3vYXJPIb0pfh
         x4HJWSjzprHFZIVyAFdnxPd+8cuRM+OEuiPCC/6jsWGDUWGS1zu8029P3Z2ZTv1MJ+F1
         yfmlUkrCFe5R2nWt/LDl5SQJ4ElkAWFmUoNZr9dYLCG64355LFu+FNE/xJ8Ao5xetveL
         l6T7InHFkbzLBxQbMR/D7w/HiQBck3s39Ipla+/FRoEHY7L/gpwERlmMqt1ZhsJ3ZWL4
         Rq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194316; x=1727799116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK+8nqvRO7dO5/4/shw4l0Rx/ZNh1LhM3L6aL1WqmLo=;
        b=Ll7tFNKd0wddTwsCYnJIFj119rAlgd6BkpIDrO3aWSn8e8hnPxHJDKO+jQQnQzU0Kj
         UoJKf2kyweocHvK9RW6tTxydAx2h3rIb65wUSbBQH1N5P7/rFnjonO1ArAyrgzRh06vQ
         e3jPCQ0+2f8z2PYAcZyip6wy7FqVWvfpxnjhfEtyjV6+77x9/OKARPBafx35aENJZbZ6
         Vd2mmUTE+QG/IrWEevSUZagKmaCX66rB+SgIdpBZRXtpRR1uLAwRr2PAqpHrXBklMFSS
         P1/5gfpfuCmynurV3jrjCMPWYv/wwTO7J7CKJpGDg5GnZUk/jUROPT1QOLwrekZVJHK1
         wR2g==
X-Forwarded-Encrypted: i=1; AJvYcCW9G0VNU0BMbzpODT3+7jy9Xz1v216b5zuDEKQhxBIdj5yGIrivMDCAf0oHpLBKA57b/dCeHeJ1/UYvFZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/aty29tjBamG+jQTA1IoOWswxArVoEYOIh55kL4gMf3fZGAk
	jQ2nfzVetTgJHDqtc77u6lD88KPBD48hDaB9VgyCYEM18xrkI9tzFRBIM5vT2me1a/bSovLOy5w
	0wpo+4io7nIicDNznJMzSJluRzOtOoiieyYeX
X-Google-Smtp-Source: AGHT+IEDgO319xABlz3mm6Gouan+c85GCidD435zCa45qz34uLpw1tJ1xfxblbnmMiqV9LbkkULcbf/jlji4psKbtjg=
X-Received: by 2002:a05:6e02:170b:b0:376:3026:9dfc with SMTP id
 e9e14a558f8ab-3a1a3f9fb73mr4541725ab.24.1727194315929; Tue, 24 Sep 2024
 09:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830-perf_syscalltbl_fix-v1-1-e2ff61ee5e8e@rivosinc.com> <ZvLaGy7jRa9Q/5fQ@ghost>
In-Reply-To: <ZvLaGy7jRa9Q/5fQ@ghost>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Sep 2024 09:11:41 -0700
Message-ID: <CAP-5=fVWFUA4LpchM1MZdMhDvSFhTUtqdVR-s59WtAcpj1fO=g@mail.gmail.com>
Subject: Re: [PATCH] perf syscalltbl: Add syscalltbl__id_at_idx() with no
 syscall table support
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Howard Chu <howardchu95@gmail.com>, David Abdurachmanov <davidlt@rivosinc.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:26=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Fri, Aug 30, 2024 at 09:30:50PM -0700, Charlie Jenkins wrote:
> > When HAVE_SYSCALL_TABLE_SUPPORT is not defined, neither is
> > syscalltbl__id_at_idx(). However, this function is expected to be
> > defined when HAVE_BPF_SKEL is defined.
> >
> > Return -1 from syscalltbl__id_at_idx() to match the other functions whe=
n
> > HAVE_SYSCALL_TABLE_SUPPORT is not defined.
> >
> > Without this, compiling perf on riscv when libtraceevents, libelf, and
> > clang are available will cause the functions trying to call
> > syscalltbl__id_at_idx() to be compiled. This results in the following
> > error:
> >
> > /usr/bin/ld: perf-in.o: in function `.L0 ':
> > builtin-trace.c:(.text+0x60b14): undefined reference to `syscalltbl__id=
_at_idx'
> > /usr/bin/ld: builtin-trace.c:(.text+0x60c6c): undefined reference to `s=
yscalltbl__id_at_idx'
> > /usr/bin/ld: perf-in.o: in function `.L2564':
> > builtin-trace.c:(.text+0x60cb6): undefined reference to `syscalltbl__id=
_at_idx'
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [Makefile.perf:793: perf] Error 1
> > make[1]: *** [Makefile.perf:290: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > make: Leaving directory '/src/linux-6.11-rc5/tools/perf'
> >
> > This patch resolves this issue for all architectures which do not defin=
e
> > HAVE_SYSCALL_TABLE_SUPPORT.
> >
> > $ ./perf trace -e syscalls:sys_enter_mmap --max-events=3D1 ls
> > 0.000 ls/287 syscalls:sys_enter_mmap(__syscall_nr: 222, len: 9939, prot=
: READ, flags: PRIVATE, fd: 3)
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reported-by: David Abdurachmanov <davidlt@rivosinc.com>
> > Suggested-by: David Abdurachmanov <davidlt@rivosinc.com>
> > Fixes: 7a2fb5619cc1 ("perf trace: Fix iteration of syscall ids in sysca=
lltbl->entries")
> > ---
> >  tools/perf/util/syscalltbl.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.=
c
> > index 0dd26b991b3f..12654460428f 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -188,4 +188,9 @@ int syscalltbl__strglobmatch_first(struct syscalltb=
l *tbl, const char *syscall_g
> >  {
> >       return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> >  }
> > +
> > +int syscalltbl__id_at_idx(struct syscalltbl *tbl __always_unused, int =
idx __always_unused)
> > +{
> > +     return -1;
> > +}
> >  #endif /* HAVE_SYSCALL_TABLE_SUPPORT */
> >
> > ---
> > base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
> > change-id: 20240830-perf_syscalltbl_fix-4f586221795e
> > --
> > - Charlie
> >
>
> Can this please be picked up? Compilation on riscv (along with any of
> the other architectures that don't have syscall table support) is
> broken. The long term solution is to add support for the syscall table
> on riscv. I will send out a patch for that, but in the meantime it would
> be great to have this in the tree.

I thought something had been done:
https://lore.kernel.org/lkml/739001a4-4df1-4dec-a141-926c78c5c07e@kernel.or=
g/
Not sure what's happened.

Thanks,
Ian


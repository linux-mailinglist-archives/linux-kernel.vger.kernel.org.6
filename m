Return-Path: <linux-kernel+bounces-205466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893F8FFC77
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE6A1F23D2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610B153565;
	Fri,  7 Jun 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="sNZ5eiD8"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82214F9C7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743053; cv=none; b=NahiXtFm3c+jLSHyUwWNOWTBQr/0JgPRP7sYzTp3lmqJKF98/cUamEQ7wrzX6WXxF0+ScshWv9Gean/MRzsS9/YvXQU3elsPbSxMGAKnSfLwkNEANOPRms+UVaOrr25RoStCZ2wX0su+FBQO03qvi8AORg6jiA+JM7bARgiTKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743053; c=relaxed/simple;
	bh=YxnUjqjrG54ExIhoCC/0uOO2+B3BPD6p+rL1db2c9pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOr7oxuSeMmbS6m9bpwKxW9R/aI5JXjGhdOO8ztQKSEmtxOy2SoIUYeoHt0VrLMA9AtAzBZY7pqzEDImHZ4k7anftZGH4XsirWh545nBCACs7mG2BK3fh98E2k/WBPSklOxIwmX7h7isItUSBw19O9CFUswthQdh0TvQVPbryg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=sNZ5eiD8; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3748bdcd442so7360655ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1717743051; x=1718347851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjDSRqEWAwegeqG4zEsY1iBt/B9KydFgkWi7QxJ97PU=;
        b=sNZ5eiD81ouwWz5nPliFqs1v1n71BBnvpijH7wM5FWW7b20S8rxXt//jrd2DwDK8cI
         iFiC3ojZI8jWKce7cl3XkGPr0gpBt8reiQRJXXGO0gZtlR9kxY60MAy8nOCJoAkAHwHC
         tDMllFPQM5NmYMwIAkCOX0d/MK0SFg4mRplinbbqk2oE6u9YbhU7imCo7YTXUTBC9zTY
         UqGuqGbvR2vy5D+wQh3sGvK0YCoy0MmCvJraqeif72BFxVk2YA6YTiN/g1Xb7PnK15qu
         pHf+CLwhAPRSkyctwazbe8OT2Z6yD3Qr2akoEimbS8fFZOsFxcHdzRQEraHFP+R3SSNQ
         /gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717743051; x=1718347851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjDSRqEWAwegeqG4zEsY1iBt/B9KydFgkWi7QxJ97PU=;
        b=xKk0wurMXg10BKCoerI7R6IG98xRcQQBFRhsCP7t8HiWBGxNaTl51B3qdlBNyD2HsF
         Y1WfE1QmeQeYv3oJ5VxdmH2VLoNZ46VbhhgPtm7dIHSfxEUX4S9e2VJFinMRIItSjkjk
         QumDv24V2sFYywyqZBl1O7EfHnOJTzSTcHiwzEDls/l3Dr3nbm3vfloCKo9zcjTkZXH+
         SJbVSIpSMDf1iYvaO1l7aPJxsOn6ohh7GP5vhULKb89tbriZmESlONB8X3m+QF7F9fwp
         RDIHTtoqMNN0IrkRGyJJXfeVii8dMf4Fm638OB8W5Cnbo3qx/I281+eVcmGClTar8VI8
         5AXw==
X-Forwarded-Encrypted: i=1; AJvYcCVmb1WQALV5qcyb/xjr2kiWnvtNhaxwSJWebIZacfWM81ew1eg0p67UprD8eDA7wOCNiQRzWuBWqP84S73JxlEcTlYWNRVuhqbPZLla
X-Gm-Message-State: AOJu0Ywbdi/r9s1jAgfcWm/u0Sk7+Q1/39cDC2RW/03SGZ6gYOlHz8eY
	Bs1Yg2rUlaFQZKkksFo5jTcNDm1umkV1C7iCQObu5mFivOrTuZRKMuiOlWC4eocYeifv+CFYeXO
	AYdVdabEc8LL+zwaYg44+4LR6FED7pucDjJVM3Q==
X-Google-Smtp-Source: AGHT+IHGncPUe5kirPrJyebgFCEDrE0X5fRHydHeBVB/rM13lmXnpE+P/4RJYRanjCkR9BGJ1QQrd2dlx1+d7doSpg8=
X-Received: by 2002:a05:6e02:1645:b0:374:ad9b:f031 with SMTP id
 e9e14a558f8ab-375803c4f3cmr19121725ab.32.1717743051100; Thu, 06 Jun 2024
 23:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422080833.8745-1-liangshenlin@eswincomputing.com>
 <20240422080833.8745-3-liangshenlin@eswincomputing.com> <ZmJUCJwavWXsesKn@google.com>
 <5fa1e23d.1f4a.18ff07726a1.Coremail.liangshenlin@eswincomputing.com>
In-Reply-To: <5fa1e23d.1f4a.18ff07726a1.Coremail.liangshenlin@eswincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Jun 2024 12:20:40 +0530
Message-ID: <CAAhSdy1DVEwAMVKPH0Pi3vUCumw1Rhg7Dz5pCp6G+WfF29nc9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf kvm/riscv: Port perf kvm stat to RISC-V
To: Shenlin Liang <liangshenlin@eswincomputing.com>
Cc: Namhyung Kim <namhyung@kernel.org>, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 7:44=E2=80=AFAM Shenlin Liang
<liangshenlin@eswincomputing.com> wrote:
>
>
> On 2024-06-07 08:27, Namhyung Kim <namhyung@kernel.org> wrote:
>
> >
> > Hello,
> >
> > On Mon, Apr 22, 2024 at 08:08:33AM +0000, Shenlin Liang wrote:
> > > 'perf kvm stat report/record' generates a statistical analysis of KVM
> > > events and can be used to analyze guest exit reasons.
> > >
> > > "report" reports statistical analysis of guest exit events.
> > >
> > > To record kvm events on the host:
> > >  # perf kvm stat record -a
> > >
> > > To report kvm VM EXIT events:
> > >  # perf kvm stat report --event=3Dvmexit
> > >
> > > Signed-off-by: Shenlin Liang <liangshenlin@eswincomputing.com>
> > > ---
> > >  tools/perf/arch/riscv/Makefile                |  1 +
> > >  tools/perf/arch/riscv/util/Build              |  1 +
> > >  tools/perf/arch/riscv/util/kvm-stat.c         | 79 +++++++++++++++++=
++
> > >  .../arch/riscv/util/riscv_exception_types.h   | 35 ++++++++
> > >  4 files changed, 116 insertions(+)
> > >  create mode 100644 tools/perf/arch/riscv/util/kvm-stat.c
> > >  create mode 100644 tools/perf/arch/riscv/util/riscv_exception_types.=
h
> > >
> > > diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/M=
akefile
> > > index a8d25d005207..e1e445615536 100644
> > > --- a/tools/perf/arch/riscv/Makefile
> > > +++ b/tools/perf/arch/riscv/Makefile
> > > @@ -3,3 +3,4 @@ PERF_HAVE_DWARF_REGS :=3D 1
> > >  endif
> > >  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
> > >  PERF_HAVE_JITDUMP :=3D 1
> > > +HAVE_KVM_STAT_SUPPORT :=3D 1
> > > \ No newline at end of file
> > > diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv=
/util/Build
> > > index 603dbb5ae4dc..d72b04f8d32b 100644
> > > --- a/tools/perf/arch/riscv/util/Build
> > > +++ b/tools/perf/arch/riscv/util/Build
> > > @@ -1,5 +1,6 @@
> > >  perf-y +=3D perf_regs.o
> > >  perf-y +=3D header.o
> > >
> > > +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > >  perf-$(CONFIG_DWARF) +=3D dwarf-regs.o
> > >  perf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > > diff --git a/tools/perf/arch/riscv/util/kvm-stat.c b/tools/perf/arch/=
riscv/util/kvm-stat.c
> > > new file mode 100644
> > > index 000000000000..58813049fc45
> > > --- /dev/null
> > > +++ b/tools/perf/arch/riscv/util/kvm-stat.c
> > > @@ -0,0 +1,79 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Arch specific functions for perf kvm stat.
> > > + *
> > > + * Copyright 2024 Beijing ESWIN Computing Technology Co., Ltd.
> > > + *
> > > + */
> > > +#include <errno.h>
> > > +#include <memory.h>
> > > +#include "../../../util/evsel.h"
> > > +#include "../../../util/kvm-stat.h"
> > > +#include "riscv_exception_types.h"
> > > +#include "debug.h"
> > > +
> > > +define_exit_reasons_table(riscv_exit_reasons, kvm_riscv_exception_cl=
ass);
> > > +
> > > +const char *vcpu_id_str =3D "id";
> > > +const char *kvm_exit_reason =3D "scause";
> > > +const char *kvm_entry_trace =3D "kvm:kvm_entry";
> > > +const char *kvm_exit_trace =3D "kvm:kvm_exit";
> > > +
> > > +const char *kvm_events_tp[] =3D {
> > > +   "kvm:kvm_entry",
> > > +   "kvm:kvm_exit",
> > > +   NULL,
> > > +};
> > > +
> > > +static void event_get_key(struct evsel *evsel,
> > > +                     struct perf_sample *sample,
> > > +                     struct event_key *key)
> > > +{
> > > +   key->info =3D 0;
> > > +   key->key =3D evsel__intval(evsel, sample, kvm_exit_reason);
> > > +   key->key =3D (int)key->key;
> >
> > Looks unnecessary..
> >
> > Thanks,
> > Namhyung
>
> Yes=EF=BC=8Cit's unnecessary...
> @Anup, Could you delete this line when merging, or should I send another =
revision ?

No need for another revision, I have updated the riscv_kvm_queue.

Regards,
Anup

> Thanks,
> Shenlin
>
> >
> >
> > > +   key->exit_reasons =3D riscv_exit_reasons;
> > > +}
> > > +
> > > +static bool event_begin(struct evsel *evsel,
> > > +                   struct perf_sample *sample __maybe_unused,
> > > +                   struct event_key *key __maybe_unused)
> > > +{
> > > +   return evsel__name_is(evsel, kvm_entry_trace);
> > > +}
> > > +
> > > +static bool event_end(struct evsel *evsel,
> > > +                 struct perf_sample *sample,
> > > +                 struct event_key *key)
> > > +{
> > > +   if (evsel__name_is(evsel, kvm_exit_trace)) {
> > > +           event_get_key(evsel, sample, key);
> > > +           return true;
> > > +   }
> > > +   return false;
> > > +}
> > > +
> > > +static struct kvm_events_ops exit_events =3D {
> > > +   .is_begin_event =3D event_begin,
> > > +   .is_end_event   =3D event_end,
> > > +   .decode_key     =3D exit_event_decode_key,
> > > +   .name           =3D "VM-EXIT"
> > > +};
> > > +
> > > +struct kvm_reg_events_ops kvm_reg_events_ops[] =3D {
> > > +   {
> > > +           .name   =3D "vmexit",
> > > +           .ops    =3D &exit_events,
> > > +   },
> > > +   { NULL, NULL },
> > > +};
> > > +
> > > +const char * const kvm_skip_events[] =3D {
> > > +   NULL,
> > > +};
> > > +
> > > +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __mayb=
e_unused)
> > > +{
> > > +   kvm->exit_reasons_isa =3D "riscv64";
> > > +   return 0;
> > > +}
> > > diff --git a/tools/perf/arch/riscv/util/riscv_exception_types.h b/too=
ls/perf/arch/riscv/util/riscv_exception_types.h
> > > new file mode 100644
> > > index 000000000000..c49b8fa5e847
> > > --- /dev/null
> > > +++ b/tools/perf/arch/riscv/util/riscv_exception_types.h
> > > @@ -0,0 +1,35 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#ifndef ARCH_PERF_RISCV_EXCEPTION_TYPES_H
> > > +#define ARCH_PERF_RISCV_EXCEPTION_TYPES_H
> > > +
> > > +#define EXC_INST_MISALIGNED 0
> > > +#define EXC_INST_ACCESS 1
> > > +#define EXC_INST_ILLEGAL 2
> > > +#define EXC_BREAKPOINT 3
> > > +#define EXC_LOAD_MISALIGNED 4
> > > +#define EXC_LOAD_ACCESS 5
> > > +#define EXC_STORE_MISALIGNED 6
> > > +#define EXC_STORE_ACCESS 7
> > > +#define EXC_SYSCALL 8
> > > +#define EXC_HYPERVISOR_SYSCALL 9
> > > +#define EXC_SUPERVISOR_SYSCALL 10
> > > +#define EXC_INST_PAGE_FAULT 12
> > > +#define EXC_LOAD_PAGE_FAULT 13
> > > +#define EXC_STORE_PAGE_FAULT 15
> > > +#define EXC_INST_GUEST_PAGE_FAULT 20
> > > +#define EXC_LOAD_GUEST_PAGE_FAULT 21
> > > +#define EXC_VIRTUAL_INST_FAULT 22
> > > +#define EXC_STORE_GUEST_PAGE_FAULT 23
> > > +
> > > +#define EXC(x) {EXC_##x, #x }
> > > +
> > > +#define kvm_riscv_exception_class                                   =
      \
> > > +   EXC(INST_MISALIGNED), EXC(INST_ACCESS), EXC(INST_ILLEGAL),       =
  \
> > > +   EXC(BREAKPOINT), EXC(LOAD_MISALIGNED), EXC(LOAD_ACCESS),         =
  \
> > > +   EXC(STORE_MISALIGNED), EXC(STORE_ACCESS), EXC(SYSCALL),          =
  \
> > > +   EXC(HYPERVISOR_SYSCALL), EXC(SUPERVISOR_SYSCALL),                =
  \
> > > +   EXC(INST_PAGE_FAULT), EXC(LOAD_PAGE_FAULT), EXC(STORE_PAGE_FAULT)=
, \
> > > +   EXC(INST_GUEST_PAGE_FAULT), EXC(LOAD_GUEST_PAGE_FAULT),          =
  \
> > > +   EXC(VIRTUAL_INST_FAULT), EXC(STORE_GUEST_PAGE_FAULT)
> > > +
> > > +#endif /* ARCH_PERF_RISCV_EXCEPTION_TYPES_H */
> > > --
> > > 2.37.2
> > >


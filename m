Return-Path: <linux-kernel+bounces-208350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281CA9023D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60D0287131
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341E84DE7;
	Mon, 10 Jun 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSYtOfJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA178289;
	Mon, 10 Jun 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028959; cv=none; b=A4lqZHMJ+XnRzazEpWCQNEhkolO88Oz/ILCIkS5YlCLKfvNeFW47tF6Jf+4ME777xaCz3JTn2J2NrIqbTyBWKImcyMg7UMOxVvRPnWJkaEuLgDQ03MxdU3AvbqT3dtAMPDwZZkAWLyih2VCRzeZjMVlWlgWBeTtMvJkG1jKyNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028959; c=relaxed/simple;
	bh=21Kh5EHajTVsMBV+QWXnVBo4LdTC4GC6f73loIWkRhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5fv9rtHb0IekeNl4TT866hN7H8bsN8svn0Wzg75wyADTV71aZ476Rf5I23I2LoKKjyoEG6Q2+9wmjO+UMUFhIP0ACIg09c5myGL0SI6EIxEBBm9JS9/HanAvwOWd9OlepbqZr5yi4Qr8K8/0BMgli6zHpu+H7zYJ/i8/cWvXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSYtOfJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC025C4AF50;
	Mon, 10 Jun 2024 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718028958;
	bh=21Kh5EHajTVsMBV+QWXnVBo4LdTC4GC6f73loIWkRhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VSYtOfJgIR+mp6SoVN7TVDw31txrKLi2G1oJdEkkhMNW7eGibqpECprnS2xNheycl
	 37ZlaojtvB4Tzp73AW2EqganzVYZ/VQHgxaHcb1oUhS/KtjDiPT7j+eXlkuUTpie4d
	 TtKnCreIS8E08enLENF6y1DgEWAS+jWmvAFyowlysJ8/HDToiv88xFWG0R4prHf9Yv
	 8dg5EbWcR7+IK8IYzKKjv78icwlT5wuADPwC5wgr0a40xCdUa71fmCnK3DJwrSGn6F
	 19Qyk8GWmsXc9oAC07AhS04SAh62nZoJ8DG1GhqmJuGS21WAbK5Jip6HXnFvrdTwj/
	 ucOnHbIhy1ZNw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c819f6146so2425365e87.1;
        Mon, 10 Jun 2024 07:15:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVo8xt+lXwtzC+HgcPc9ylqPLXLckCF8OBUJ8polDGHgUicOeFYfAHdcWhiW0R8fnOC2wnUcoDiyfecUecw322x7z83yEsseUv/BlF/lqcHQZUTsuBVsp7XWRLxFHNDCY0+DF6nwXODu3s0+PiIPQ==
X-Gm-Message-State: AOJu0YzSIjoFthgHtf4Sk5iPxkl1FJkjCAKD68fudaaPdJlqO7s+xOny
	gmYUzi5nNjwWGFus1M6sbpG2bsHSEyeAUDBQ7xxuh6XT2awzve5fPTLkbpG5oaiBNMYCEHNNxfT
	Mch7eKzkaz/2DL3F7Z630WvEZGQ==
X-Google-Smtp-Source: AGHT+IF1FqhNgnMilwBpUYwKFCS7SjNBHaPMgfRaSiWiRwC1GxxkGk257Dm2RFGaXs90YLlwwvs7LrWA/frcv8Qksfw=
X-Received: by 2002:a05:6512:1386:b0:52c:890e:e8e7 with SMTP id
 2adb3069b0e04-52c890ee93emr2598213e87.50.1718028957128; Mon, 10 Jun 2024
 07:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-arm-pmu-3-9-icntr-v1-0-c7bd2dceff3b@kernel.org>
 <20240607-arm-pmu-3-9-icntr-v1-9-c7bd2dceff3b@kernel.org> <ZmbpnHU3YM0q6YeA@J2N7QTR9R3>
In-Reply-To: <ZmbpnHU3YM0q6YeA@J2N7QTR9R3>
From: Rob Herring <robh@kernel.org>
Date: Mon, 10 Jun 2024 08:15:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKt7sGU3HVMQow7AoWrbU7uvXJY3So4LyZM2Q-sWdd1=w@mail.gmail.com>
Message-ID: <CAL_JsqKt7sGU3HVMQow7AoWrbU7uvXJY3So4LyZM2Q-sWdd1=w@mail.gmail.com>
Subject: Re: [PATCH 9/9] perf: arm_pmuv3: Add support for Armv9.4 PMU
 instruction counter
To: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev, 
	James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:55=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Fri, Jun 07, 2024 at 02:31:34PM -0600, Rob Herring (Arm) wrote:
> > Armv9.4/8.9 PMU adds optional support for a fixed instruction counter
> > similar to the fixed cycle counter. Support for the feature is indicate=
d
> > in the ID_AA64DFR1_EL1 register PMICNTR field. The counter is not
> > accessible in AArch32.
> >
> > Existing userspace using direct counter access won't know how to handle
> > the fixed instruction counter, so we have to avoid using the counter
> > when user access is requested.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  arch/arm/include/asm/arm_pmuv3.h   | 21 +++++++++++++++++++++
> >  arch/arm64/include/asm/arm_pmuv3.h | 29 +++++++++++++++++++++++++++++
> >  arch/arm64/kvm/pmu.c               |  8 ++++++--
> >  arch/arm64/tools/sysreg            | 25 +++++++++++++++++++++++++
> >  drivers/perf/arm_pmuv3.c           | 28 ++++++++++++++++++++++++++--
> >  include/linux/perf/arm_pmu.h       |  8 ++++++--
> >  include/linux/perf/arm_pmuv3.h     |  4 +++-
> >  7 files changed, 116 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/ar=
m_pmuv3.h
> > index ac2cf37b57e3..b836537ddfbf 100644
> > --- a/arch/arm/include/asm/arm_pmuv3.h
> > +++ b/arch/arm/include/asm/arm_pmuv3.h
> > @@ -10,6 +10,7 @@
> >  #include <asm/cputype.h>
> >
> >  #define ARMV8_PMU_CYCLE_IDX          31
> > +#define ARMV8_PMU_INSTR_IDX          32 /* Not accessible from AArch32=
 */
>
> As with ARMV8_PMU_CYCLE_IDX, I reckon this should live in
> <linux/perf/arm_pmuv3.h> (with the comment above) so that we don't need
> separate definitions for arm & arm64.

Sure. My only reasoning was to not pull in everything defined in
<linux/perf/arm_pmuv3.h> where it is not needed (KVM).

Of course, the normal pattern here is that linux/foo.h includes
asm/foo.h. We should probably do that here because the arm64 version
of arm_pmuv3.h depends on defines (e.g. PMEVN_SWITCH) in
perf/arm_pmuv3.h, but there is no explicit include. I'll add doing
that into the series.

> [...]
>
> > diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> > index 231817a379b5..8ab6e09871de 100644
> > --- a/arch/arm64/tools/sysreg
> > +++ b/arch/arm64/tools/sysreg
> > @@ -2029,6 +2029,31 @@ Sysreg FAR_EL1 3       0       6       0       0
> >  Field        63:0    ADDR
> >  EndSysreg
> >
> > +Sysreg       PMICNTR_EL0     3       3       9       4       0
> > +Field        63:0    ICNT
> > +EndSysreg
>
> LGTM per ARM DDI 0487K.a, section D23.5.15, pages 8989 to 8992.
>
> > +
> > +Sysreg       PMICFILTR_EL0   3       3       9       6       0
> > +Res0 63:59
> > +Field        58      SYNC
> > +Field        57:56   VS
>
> The 'VS' field doesn't seem to be in the ARM ARM (ARM DDI 0487K.a); is
> that defined in a supplement?

It is in the A-profile Arch Registers doc:
https://developer.arm.com/documentation/ddi0601/2024-03/AArch64-Registers/P=
MICFILTR-EL0--Performance-Monitors-Instruction-Counter-Filter-Register?lang=
=3Den

> > +Res0 55:32
> > +Field        31      P
> > +Field        30      U
> > +Field        29      NSK
> > +Field        28      NSU
> > +Field        27      NSH
> > +Field        26      M
> > +Res0 25
> > +Field        24      SH
> > +Field        23      T
> > +Field        22      RLK
> > +Field        21      RLU
> > +Field        20      RLH
> > +Res0 19:16
> > +Field        15:0    evtCount
> > +EndSysreg
>
> Aside from 'VS', this LGTM per ARM DDI 0487K.a, section D23.5.14, pages
> 8981 to 8988.
>
> One important thing to note is that this doesn't have the threshold
> controls (TC, TE, TH); so if threshold events make sense for instruction
> events, we cannot place those in the dedicated isntruction counter.

Talking to James C, he thinks there could be. Counting cycles which
retired more than 1 instruction was what he came up with.

Also, looks like we need to handle thresholds for the cycle counter as
well. Either reject thresholds for cycles events or don't place cycles
on the fixed cycle counter if thresholds are used. While thresholds
with cycles doesn't make much sense, James prefers the latter as he
did do that for testing.

Rob


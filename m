Return-Path: <linux-kernel+bounces-520581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA58A3ABBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510A9174D37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9B1DC184;
	Tue, 18 Feb 2025 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDh0iWYQ"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655F1D0F5A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918042; cv=none; b=U8kuLy3HSICF5rl1ziGL1ERet4M4tJ7syLgkUtQ9BTPx9jk8/stLnTK12qDqwJ7iRiiPfXOHktzwk+Idl4Ux+vLoNVeMQPut/67rNglJpos99xqZlVuLSHXcsg7GDgfRWdXNm4Lwl9fPCmt/3UfEalVmG3uPRD1MM6sI4+JI2OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918042; c=relaxed/simple;
	bh=LMr3mAVEp9T0899OdsHcYNuOQbKwWhoX8JpQNIYLZ+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eegnbYZtCXjnpJXFcMn1e3mSrYjC3/yIyj2LdFAld3XaVDSZ7dDLHuGTW5E2kPGF3Vx5F4/w/0slBRejfhDULjnOFd6oFA9bbF7SetPtUwl/MYwu4fO3ZdkebSQOioG9FTzAXdh/ZBlesAyRKPBMdqNSzWTP0pRA3yf3JypOk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDh0iWYQ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so632745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739918040; x=1740522840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/cgij1lFdZqKfhJzvdkh7LmAc2T325VXWYvJrhG6fY=;
        b=oDh0iWYQRl2y+GBgwCET+eh4ecnW7iVY77Dsnn76nyKeV8bCkR2JJk3ll47VX4r+wb
         bza3Wy8vKeeWSu0wuyeEu2RDuRdMym6Za6kRwB5WgsCu3GMBb2NVyoDEHNDZZdJihhOP
         3YGJsaNy/Rrk6XdXZ5VPLTmfUNYP59jsEt2QlirZwOPBNrTDPZr+t/sk9sq0PU2PV2Od
         jqLlzSXQ71PasDFriIHi0Mtz8xDDgqUMJXdobwUv1mSMdK9tA7TIC5Q7Q8xFAouApiqt
         wihFAAyEST2b423lZr3n250/+gZ5iYsnPVNBWS59cIYmOfQo7qGEnRLWgxSnfTXDRcEi
         1jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918040; x=1740522840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/cgij1lFdZqKfhJzvdkh7LmAc2T325VXWYvJrhG6fY=;
        b=URX5B/te78N4G/5vG6S8JtanhzIEck7lqvS0Skm0zuL0OpJIgmjJzpLdsVA0e/MWSR
         eQB72sPfvy4/kRsjUYlLAQWT9cCGgjk8hgf6mZOAfDqnA8EDdz99gXAmwoz2sKVB8/c+
         iy7N7D/mbRaZfRa5tjVjf/CaPRMiFP9NoR2U8rD4VPc3BjLpXZrvpbSbRLnOTpXZkjK4
         imZUWq+6pJNSBu0VcBfnozBYjLV+x9pagJ6EtIdovZCeOUk8dz3xxumSzHwx2e9JrEst
         PX0WAlXjioHoSutQiTXdTXMYhuZ6204CiT3PJlRNe5gbK0/Bj57OBEkvec/oNBmVvn9f
         J7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjqxF9/69Yz8ank8EQ+a0/xJeC20Rbw+WG+WGMCRWr9ubWL8WQ2EGn8yPXhr3hNHKvtsIg9aWilYLNNjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+T2SZnXrgV5EA0DQwVbuOFCGWLCD9YHJxU4GkSgvasPcRiucl
	ub1xk70UI8M+qlGVP8fEwlhAz26VEj0E4zRWznNJ34XMx8WNStes/V/k7O/lA4/v0R7bfgAmOpX
	Gb1Lwm1S/rzCOVNFDiJW61MAcbSw9HXw5nhXT
X-Gm-Gg: ASbGnctubhabLCL5nBz+C/UZHwImri4h5IuN5M1U8A/uch5v7tvEphuZc5qdZBFjpxp
	ob0tkV+yHgZySJ/VWhifCGdVnvVIMnw5HD6jYxrGaa/Xg4B85AxyLsyj9oALX0UyOlh5YO9C+QZ
	4HJkh0X9CkycukVCoAghJnd6dh
X-Google-Smtp-Source: AGHT+IHw3DoO4qf0xpi1Amzv3pmc+X9SJTYSaoh3aiUz35JKe6rXdAzYIXkiqfdS7Bg/GHnOCWs6r2oDH8RnN6nJDDg=
X-Received: by 2002:a05:6e02:3287:b0:3d1:7971:e6d5 with SMTP id
 e9e14a558f8ab-3d2b6236f8amr1406365ab.0.1739918039639; Tue, 18 Feb 2025
 14:33:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com> <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org> <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
 <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org> <Z7UHieRRnvRb5_oU@google.com>
In-Reply-To: <Z7UHieRRnvRb5_oU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Feb 2025 14:33:47 -0800
X-Gm-Features: AWEUYZnCIRZ8gA78AOy7d6LlsQyiSAxYf8f5kf90YgWTOUXfQDLRg9JD7T1vwFY
Message-ID: <CAP-5=fWXmNoFLyWv+vo7hhLSqTDy7hf+-huKRD9OUWnO-GESRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520 events/metrics
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Yangyu Chen <cyy@cyyself.name>, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Feb 18, 2025 at 09:30:23AM +0000, James Clark wrote:
> >
> >
> > On 18/02/2025 12:41 am, Ian Rogers wrote:
> > > On Fri, Feb 14, 2025 at 2:02=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> > > >
> > > >
> > > >
> > > > On 14/02/2025 5:49 am, Yangyu Chen wrote:
> > > > >
> > > > >
> > > > > > On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wr=
ote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
> > > > > > > This patchset adds the perf JSON files for the Cortex-A720 an=
d Cortex-A520
> > > > > > > processors. Some events have been tested on Raxda Orion 6 wit=
h Cix P1 SoC
> > > > > > > (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
> > > > > >
> > > > > > I'm curious how the name of PMUs look like.  It is cortex_a720 =
(or a520)?
> > > > >
> > > > > The name of PMUs comes from Arm's documentation. I have included =
these
> > > > > links in each patch.
> > > > >
> > > > > > I remember there's a logic to check the length of hex digits at=
 the end.
> > > > > >
> > > > >
> > > > > Could you provide more details about this?
> > > > >
> > > > > > Ian, are you ok with this?
> > > > > >
> > > >
> > > > I think they wouldn't be merged because they're core PMUs, so shoul=
d be
> > > > fine? Even though they would otherwise be merged because they're mo=
re
> > > > than 3 hex digits.
> > >
> > > Do we know the PMU names? If they are cortex_a520 and cortex_a720 the=
n
> >
> > It will be "armv9_cortex_a720" from this line:
> >
> >   PMUV3_INIT_SIMPLE(armv9_cortex_a720)
>
> I see, thanks!
>
> >
> > > this comment at least reads a little stale:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n76
> > > ```
> > > /*
> > > * There is a '_{num}' suffix. For decimal suffixes any length
> > > * will do, for hexadecimal ensure more than 2 hex digits so
> > > * that S390's cpum_cf PMU doesn't match.
> > > */
> > > ```
> > > James is right that core PMUs aren't put on the same list as uncore/o=
ther PMUs.
>
> Ok, then I guess we're good.

I think you may be able to do things that look odd, like today the
"i915" PMU can be called just "i", I think the a520/a720 naming will
allow "armv9_cortex/cycles/" as an event name, then open it on two
PMUs if they are present. We may only show one PMU in perf list as
that code I think assumes they're the same PMU as they only differ by
suffix:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n384
I can imagine aggregation possibly being broken, but I think that
works off the number of PMUs not the names of the PMUs, so it should
be okay. Probably the only thing broken that matter is perf list when
you have a BIG.little system with a520 and a720, this may be broken
with say a a53 and a72 today as both of those suffix lengths are >2,
but maybe they use the "armv8._pmuv3_0", "armv8._pmuv3_1", etc. naming
convention. I suspect the >2 here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n80
would still work and be correct if it were >4. If that changes then
this will also need to change:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/Documentation/ABI/testing/sysfs-bus-event_source-devices?h=3Dperf-tools-=
next#n12

Thanks,
Ian

>
> Thanks,
> Namhyung
>


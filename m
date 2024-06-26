Return-Path: <linux-kernel+bounces-231275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D9918A14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55028283CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792F18FDD3;
	Wed, 26 Jun 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggq3iXj+"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BD18FC63
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422838; cv=none; b=ntgGIsyxpJng84unTZD2l887DH2O4S7rPzWk/4TzFg7RtOyE4KJNMN3ygJM8mem8d3XItry3AEmMAOyMGUzZKlqiCgEexT9GG8WY8INnQc5iEPRhPBdUII+OWhK2FOQDEgZO3wM43WnhD25aBCH3eojWHeYESUtL0Lv5Rc8WIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422838; c=relaxed/simple;
	bh=cwFV6cXnZvvdb46gn7OCr2S3Z++ezeLyzLje0Wp6HTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV+AWh216FrjLnLXnIs14VhrDjrJwAA4+Csn9Xb3cIz7HahcKRDTmq2q3eT2nzF5E+HEZFKSfKLQJM5lOYwNaC4qxCzb/KcmccILIIdtskVLh50PWHS8Gx8NWTp1p530oT8WekdT0JAhIxSaT5ERI0tgaH8mYvchAnUknktya6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggq3iXj+; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3762775e9ebso9405ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719422836; x=1720027636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odCzTyLKcmA7UwpT1SGmpvnHQ/qubaerHoVlU19xubU=;
        b=ggq3iXj+QQJIMpPj/WcYHdWq8PJ+5aZS6TYJc668tE7Ck15/KaAb75WMjhz8b4Z9nF
         dmggt6X3bGGuZJ8S82gdJwDLkAzdqeRO4PDs8Kl16oxobtUvm4Fe6LQdrpHfWiNv0qXs
         zsKC0cySEF+Iaj15ubicln8sb+xEYk6bgxMVc95MjeIfokpz3Fd+BJB5MyPWrPCv1Dch
         M9XAmXm7WvK3LQvmhen4Xxr8ZWszx9zomk8hHTi6d0C8RD/rhzy5CXvMsquAoSqAIg2i
         sT47fXFhItLpk+K73KSWzBU9jZzId4mMBX10bL//s+DMhGZG0usy7RY0treGpVP/Zv7o
         B2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422836; x=1720027636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odCzTyLKcmA7UwpT1SGmpvnHQ/qubaerHoVlU19xubU=;
        b=t9K/idvtkf7YEPIGfQIibTkc1Khp+HZOpayFZwzkH0hrpJEwXn3LIKv5AE5LZB5t/r
         D8k/kGWotLWADqNKyHjH0KjGtfitD8KHc9phxsMfxvVDD5NJBMsi81SP5oO1Y1BcyyfM
         W4FmaLIEFN91dM0hHeuclmi4UiZ+W3HDSub6bk2XUoFkm3UBa+DlJGZtYYSdCi7ypG0C
         lHhKNwRMfTcfNj5axf8NXROM/kgQpc7Mfk1UBPd8EPr05TCMM6+lIVB0muuhd0HP/w11
         rgd3XOv7Ex4ie9nb/Qehlo9nvkBgF+7Q/t6tnh5Q1qtn/oc7lgwAUWxuJE0rVSQPnQwF
         TmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0hhrsvC1ceQvlsxa9FybVrsfi7fXDSqIu2mgD58xmfeX6wNQOddxeaqRm7FyZcP8PM4BbrZEg2JALv8vMDRnFWM7piM/mdoWZAYS4
X-Gm-Message-State: AOJu0Yzj/759d3A3RYk3VGjXq9d3MAdS3La6LeS4e/CZlFmPqE5v+0oN
	XwW/WLbU8CIJpZVO4kfOM1lyCw+Oty1bpUuQFub4lyIkFTBTDh245zqpLGd63jZUQI/+yEp8yAo
	kZ8HeWCYr2VW1YaXUtOhj10dHdz24STdbJdNl
X-Google-Smtp-Source: AGHT+IHPkqcUdOsYg4z8gPGwIHU7Tn6w6J5eeyaZ5CFTnx+zpL0OTnv3VCDHUR7YF8O8/7cg9iO54S/AxvqRAxvLwwo=
X-Received: by 2002:a92:cda7:0:b0:377:14ab:42ea with SMTP id
 e9e14a558f8ab-3795d5c0e5fmr234695ab.16.1719422836106; Wed, 26 Jun 2024
 10:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625182256.291914-1-kan.liang@linux.intel.com>
 <20240625182256.291914-8-kan.liang@linux.intel.com> <CAP-5=fU4Mn0BhgS3n_aUmfamtD77d-VDhnZ1OoiRvXFrGJERCQ@mail.gmail.com>
 <e57cf98a-89c6-4913-99af-6a70e098f37b@linux.intel.com>
In-Reply-To: <e57cf98a-89c6-4913-99af-6a70e098f37b@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Jun 2024 10:27:04 -0700
Message-ID: <CAP-5=fVcr6SPH-g=AEK96rbMnMQBOBoKckAZUHQvX4UZ_n01VA@mail.gmail.com>
Subject: Re: [PATCH V2 07/13] perf/x86/intel: Support PERFEVTSEL extension
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, 
	ak@linux.intel.com, eranian@google.com, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 6:25=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-06-25 9:34 p.m., Ian Rogers wrote:
> > On Tue, Jun 25, 2024 at 11:22=E2=80=AFAM <kan.liang@linux.intel.com> wr=
ote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Two new fields (the unit mask2, and the equal flag) are added in the
> >> IA32_PERFEVTSELx MSRs. They can be enumerated by the CPUID.23H.0.EBX.
> >>
> >> Update the config_mask in x86_pmu and x86_hybrid_pmu for the true layo=
ut
> >> of the PERFEVTSEL.
> >> Expose the new formats into sysfs if they are available. The umask
> >> extension reuses the same format attr name "umask" as the previous
> >> umask. Add umask2_show to determine/display the correct format
> >> for the current machine.
> >>
> >> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  arch/x86/events/intel/core.c      | 69 +++++++++++++++++++++++++++++-=
-
> >>  arch/x86/include/asm/perf_event.h |  4 ++
> >>  2 files changed, 69 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core=
.c
> >> index 23e074fd25e1..9d50e1049e30 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -4632,8 +4632,55 @@ PMU_FORMAT_ATTR(pc,      "config:19"     );
> >>  PMU_FORMAT_ATTR(any,   "config:21"     ); /* v3 + */
> >>  PMU_FORMAT_ATTR(inv,   "config:23"     );
> >>  PMU_FORMAT_ATTR(cmask, "config:24-31"  );
> >> -PMU_FORMAT_ATTR(in_tx,  "config:32");
> >> -PMU_FORMAT_ATTR(in_tx_cp, "config:33");
> >> +PMU_FORMAT_ATTR(in_tx,  "config:32"    );
> >> +PMU_FORMAT_ATTR(in_tx_cp, "config:33"  );
> >
> > nit: It seems unfortunate these 2 lines change for the sake of spaces
> > before the ')'. Perhaps leave unchanged.
>
> The two lines don't follow the existing formats. It kind of ugly when
> reading the code.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/intel/core.c#n4569
>
> I just want to make the format consistent to facilitate the future code
> review.

Thanks, I'm easy on just keeping it the same or changing the
whitespace. When I saw the lines changing I was figuring the config
encoding was being modified which could break things like libpfm4 that
directly use configs rather than formats.

Thanks,
Ian


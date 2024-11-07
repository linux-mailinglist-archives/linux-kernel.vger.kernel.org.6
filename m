Return-Path: <linux-kernel+bounces-400380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29339C0CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE651F230CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33442161FA;
	Thu,  7 Nov 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpO/v9Fa"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F7213EC7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999998; cv=none; b=gLJfQ4E8hkUTdOPrNENdT25/0MIquYUm70Ek+sz+zWrS9UhwMFdRSCL0xwIkqzCNVqtL+uvZlFM6HPlMzM+HPPgB/mrQFxuTxDoTHigbi0DKW79+iQGsm7mRoQSB0TRPsRsGrqAeP9StV/vJAUEyUYUFEMqQoGvrzl5tnzBkauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999998; c=relaxed/simple;
	bh=JTPuW4PZyq89fLpBrtc/ssCzFTqf4qKDjVoaJe+kTjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5uI/7x1XZ4ZLmuoaqLcLJBgRaqXdpko3ThXS2kNPoc7TCOqxXnaWyoQ3GrLWPVdGZpnvDQhR1o7HyQaf2Cxm49OFMmFqjqpHqOFaEmk2Kg7S6/ALtfuveuyrXM+t76vQTrRK+1TUmfWvcU8si5taXDwjYviVWqFKodBwddUjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpO/v9Fa; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso283895ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730999995; x=1731604795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Pmfgs/0v+XbFp50mKYzJUI7uvNg0hCPjGC3BVtEAA=;
        b=GpO/v9FanojaJuAsqtiJFY6mfw8nLcexTTjKwehuwQ47T88iMukAegThvTeFa4kgGF
         j44alqTmQvobQ5qKWG3s1jIy34dg9jCgMDIjYFZTH5kSggh2c7Y8RlsWbXoRBXlI857l
         87AmDOzRRqTGgH5dXqU3lMd/FqpOZL3h9W7+Tl2xLSObePltYOLHzr+IZ6DuL+AqDyLn
         UpEmBWC3Ibs7u/k4DaxOBL8r+82WGUxlsIt2jybqlRhd7yfsKSSilcafk1tBpAuBTg2w
         Fhq/GbjLto3IYy/W4UPamJPL//Royqi5GyIqBHOtLdnPFDmKLAeK37aXov3Srbvqptr/
         wVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730999995; x=1731604795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8Pmfgs/0v+XbFp50mKYzJUI7uvNg0hCPjGC3BVtEAA=;
        b=JCPIPVjXpfpsGwyhGF15zURc35iGg2bMrJ/+ZZgWclFLWvgJ1qkpyigu8TLI63/e3e
         MWxUlENxKne41vJ7tCqxOZK3sZyPwlA9ztFmUNKGHgRdwidfzHhuXZY0e6rIImRH9LPj
         UkzOd445VQrAUr4s99cGQuiBFahBl9E8pWqQph4HZeY6yvb8zNk8LRlWnQ7RryyPzdXv
         njfBNhfXAVM0qyl4gfWIZt+hfYGQ0z/KNzPZduyLjXRAhlqTYVXuudk4IXUnpRFB71YE
         MpoguCVrvZ8h6CK9QgNh0TE7QvHpW3rBll8x0Da1n/wSB0sd1FUcwF0cXb/JRj6t1u/8
         jkOg==
X-Forwarded-Encrypted: i=1; AJvYcCUTT/00vnR2iEuPsm5d2uGdG5rRNRjPFq2xqcDWacljmxnwNapN8xG1mwMBVdg78Y8Jy4/MLRZIjwEERGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcuEXzoqO/Qg8NVf2W/Kd0RwYLPOLiL2F9sp/z34u/fijnyBzk
	16HTVW18ko8Njav3ApYvZXzAtCzFCu4LOwob1dP/E7NJUSb8557aDulmMYRAHBgBCHc55Mvh56H
	19vnLuLpxO1ozu5Av8A8XOXeDVWQ8GnlItM2M
X-Gm-Gg: ASbGncsB4QOmNY8cpGda7624J8j4YMGjzvFjxL9IzW1b3Brg20yrCWjGAMbfgfS9nXs
	tuIv3fkaCxbRT0sTtrj0SfzOHKo9q/Qizomo5IESeHuVzjy695fLGyLdnigFlLo0=
X-Google-Smtp-Source: AGHT+IHaS+JTHy0Vg1p9y3j9GDZO2w//PgmlhtK3jCyBjRM3bvzSq0AhNH1Xb/EebLokRXndkUGOf1Q+DpZInOKxiXI=
X-Received: by 2002:a05:6e02:20ce:b0:3a0:9ffd:2b7a with SMTP id
 e9e14a558f8ab-3a6e7a2daf7mr5600235ab.9.1730999994915; Thu, 07 Nov 2024
 09:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <20240926175035.408668-8-irogers@google.com>
 <20a6d424-c3a5-4fa9-b5d4-bcbe684a4a6f@linux.intel.com>
In-Reply-To: <20a6d424-c3a5-4fa9-b5d4-bcbe684a4a6f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 09:19:43 -0800
Message-ID: <CAP-5=fVwdaACaYCG8Jn-w+wHDNugcon8OiN9-mOAcXisVV5N0w@mail.gmail.com>
Subject: Re: [PATCH v4 07/22] perf jevents: Add br metric group for branch
 statistics on Intel
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:35=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> > The br metric group for branches itself comprises metric groups for
> > total, taken, conditional, fused and far metric groups using json
> > events. Conditional taken and not taken metrics are specific to
> > Icelake and later generations, so the presence of the event is used to
> > determine whether the metric should exist.
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 58e243695f0a..09f7b7159e7c 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -123,6 +123,143 @@ def Tsx() -> Optional[MetricGroup]:
> >    ], description=3D"Breakdown of transactional memory statistics")
> >
> >
> > +def IntelBr():
> > +  ins =3D Event("instructions")
> > +
> > +  def Total() -> MetricGroup:
> > +    br_all =3D Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED=
.ANY")
> > +    br_m_all =3D Event("BR_MISP_RETIRED.ALL_BRANCHES",
> > +                     "BR_INST_RETIRED.MISPRED",
> > +                     "BR_MISP_EXEC.ANY")
> > +    br_clr =3D None
> > +    try:
> > +      br_clr =3D Event("BACLEARS.ANY", "BACLEARS.ALL")
> > +    except:
> > +      pass
>
> There is no guarantee to the event name. It could be changed later.
> The renaming already occurred several times, even for architectural event=
s.
>
> I think we should test all events' presence, not just a few of them.

So the idea with the Event names is that we look for each name in turn
in the json, stopping with the first one we find. If none are found
then an exception is thrown. This means a typo can cause issues so we
also check that the event name exists in some json somewhere:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/pmu-events/metric.py#L89
I agree it isn't super perfect, we're dealing with strings, things can
be fragile..

> There could be some effort in the future to sync with the event list for
> each new generation and check if there is a renaming.

So the worst case is that a metric isn't present in a new generation,
then we update the script for a new event name and things will be
fixed. I think testing can keep this in check.

Thanks,
Ian

> Thanks,
> Kan
> > +
> > +    br_r =3D d_ratio(br_all, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_all)
> > +    misp_r =3D d_ratio(br_m_all, br_all)
> > +    clr_r =3D d_ratio(br_clr, interval_sec) if br_clr else None
> > +
> > +    return MetricGroup("br_total", [
> > +        Metric("br_total_retired",
> > +               "The number of branch instructions retired per second."=
, br_r,
> > +               "insn/s"),
> > +        Metric(
> > +            "br_total_mispred",
> > +            "The number of branch instructions retired, of any type, t=
hat were "
> > +            "not correctly predicted as a percentage of all branch ins=
trucions.",
> > +            misp_r, "100%"),
> > +        Metric("br_total_insn_between_branches",
> > +               "The number of instructions divided by the number of br=
anches.",
> > +               ins_r, "insn"),
> > +        Metric("br_total_insn_fe_resteers",
> > +               "The number of resync branches per second.", clr_r, "re=
q/s"
> > +               ) if clr_r else None
> > +    ])
> > +
> > +  def Taken() -> MetricGroup:
> > +    br_all =3D Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.=
ANY")
> > +    br_m_tk =3D None
> > +    try:
> > +      br_m_tk =3D Event("BR_MISP_RETIRED.NEAR_TAKEN",
> > +                      "BR_MISP_RETIRED.TAKEN_JCC",
> > +                      "BR_INST_RETIRED.MISPRED_TAKEN")
> > +    except:
> > +      pass
> > +    br_r =3D d_ratio(br_all, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_all)
> > +    misp_r =3D d_ratio(br_m_tk, br_all) if br_m_tk else None
> > +    return MetricGroup("br_taken", [
> > +        Metric("br_taken_retired",
> > +               "The number of taken branches that were retired per sec=
ond.",
> > +               br_r, "insn/s"),
> > +        Metric(
> > +            "br_taken_mispred",
> > +            "The number of retired taken branch instructions that were=
 "
> > +            "mispredicted as a percentage of all taken branches.", mis=
p_r,
> > +            "100%") if misp_r else None,
> > +        Metric(
> > +            "br_taken_insn_between_branches",
> > +            "The number of instructions divided by the number of taken=
 branches.",
> > +            ins_r, "insn"),
> > +    ])
> > +
> > +  def Conditional() -> Optional[MetricGroup]:
> > +    try:
> > +      br_cond =3D Event("BR_INST_RETIRED.COND",
> > +                      "BR_INST_RETIRED.CONDITIONAL",
> > +                      "BR_INST_RETIRED.TAKEN_JCC")
> > +      br_m_cond =3D Event("BR_MISP_RETIRED.COND",
> > +                        "BR_MISP_RETIRED.CONDITIONAL",
> > +                        "BR_MISP_RETIRED.TAKEN_JCC")
> > +    except:
> > +      return None
> > +
> > +    br_cond_nt =3D None
> > +    br_m_cond_nt =3D None
> > +    try:
> > +      br_cond_nt =3D Event("BR_INST_RETIRED.COND_NTAKEN")
> > +      br_m_cond_nt =3D Event("BR_MISP_RETIRED.COND_NTAKEN")
> > +    except:
> > +      pass
> > +    br_r =3D d_ratio(br_cond, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_cond)
> > +    misp_r =3D d_ratio(br_m_cond, br_cond)
> > +    taken_metrics =3D [
> > +        Metric("br_cond_retired", "Retired conditional branch instruct=
ions.",
> > +               br_r, "insn/s"),
> > +        Metric("br_cond_insn_between_branches",
> > +               "The number of instructions divided by the number of co=
nditional "
> > +               "branches.", ins_r, "insn"),
> > +        Metric("br_cond_mispred",
> > +               "Retired conditional branch instructions mispredicted a=
s a "
> > +               "percentage of all conditional branches.", misp_r, "100=
%"),
> > +    ]
> > +    if not br_m_cond_nt:
> > +      return MetricGroup("br_cond", taken_metrics)
> > +
> > +    br_r =3D d_ratio(br_cond_nt, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_cond_nt)
> > +    misp_r =3D d_ratio(br_m_cond_nt, br_cond_nt)
> > +
> > +    not_taken_metrics =3D [
> > +        Metric("br_cond_retired", "Retired conditional not taken branc=
h instructions.",
> > +               br_r, "insn/s"),
> > +        Metric("br_cond_insn_between_branches",
> > +               "The number of instructions divided by the number of no=
t taken conditional "
> > +               "branches.", ins_r, "insn"),
> > +        Metric("br_cond_mispred",
> > +               "Retired not taken conditional branch instructions misp=
redicted as a "
> > +               "percentage of all not taken conditional branches.", mi=
sp_r, "100%"),
> > +    ]
> > +    return MetricGroup("br_cond", [
> > +        MetricGroup("br_cond_nt", not_taken_metrics),
> > +        MetricGroup("br_cond_tkn", taken_metrics),
> > +    ])
> > +
> > +  def Far() -> Optional[MetricGroup]:
> > +    try:
> > +      br_far =3D Event("BR_INST_RETIRED.FAR_BRANCH")
> > +    except:
> > +      return None
> > +
> > +    br_r =3D d_ratio(br_far, interval_sec)
> > +    ins_r =3D d_ratio(ins, br_far)
> > +    return MetricGroup("br_far", [
> > +        Metric("br_far_retired", "Retired far control transfers per se=
cond.",
> > +               br_r, "insn/s"),
> > +        Metric(
> > +            "br_far_insn_between_branches",
> > +            "The number of instructions divided by the number of far b=
ranches.",
> > +            ins_r, "insn"),
> > +    ])
> > +
> > +  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
> > +                     description=3D"breakdown of retired branch instru=
ctions")
> > +
> > +
> >  def main() -> None:
> >    global _args
> >
> > @@ -150,6 +287,7 @@ def main() -> None:
> >        Rapl(),
> >        Smi(),
> >        Tsx(),
> > +      IntelBr(),
> >    ])
> >
> >
>


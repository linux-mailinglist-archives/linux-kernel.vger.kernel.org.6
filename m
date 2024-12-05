Return-Path: <linux-kernel+bounces-432637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E419E4E01
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4B1881755
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9381AC8A6;
	Thu,  5 Dec 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo9d5HUd"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E602F56
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382604; cv=none; b=u2jk8cEyDoshgz4/qOT6/f4YmeaY8dp0z4SSCX7vRZkqKgpGJuFc/bvoI+swEdm7GVh2SXsE6jxbvz8C3N3yNjd35oQ3f66BDL0WYyOMAb733qhqdAVvLEr8fdFRoZblUYPblSB1tMIimORVnCRVT5ltbbESAGuhuORAkStEDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382604; c=relaxed/simple;
	bh=m9PAgqLMEdONGInteiZwMJWeLAyp9JtTMil42/JBwso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V19dlzXWxDvoxpoEgByTcfnbsNSRsqX+srBuuJOPb+Q7F5s1qNtbofz28tPOH/e77kBCSko+bRUL+Ue4PTASVxGtMrm8o4MW4R1gKGf1YslGmw9zx2KgWF+fvCP7F0aSjvBhvNVegoEhdfd7N0c0aJdoFdtfzzU4BTKDb296YpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uo9d5HUd; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a7bc2d7608so65225ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733382602; x=1733987402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPDL9SY/CBHi33tr/kgPHOHPuPtSjT4Zve0V9QYVUns=;
        b=Uo9d5HUdM2Jwlp2Jwa90/00PTltNjViX3HKNiq/XXKqHg3qk2Ms/bzFQu0rOSUjR6X
         1Z/URjpSyYGQCTaDE/7vSr34zJ9f8EYC13MugLblnGHRDM78oUCwnf8WF/QGiz6pgxXN
         Gx9guUVAcua5lh2scu0vFdSqabmHmgxBrdMvrVmQ1iqQcqLkELuLRiYLb36zzlbDPuAv
         HWoD/5Uxq9K1ngrIc07tF5ijI2sJymYsk1jSBnYH9eyXg71bJs02Bjq3HhzQU2j/rQU4
         vW6Xs1uctGfs+jBC59gsKbuui3uU1b//bLMsmbJ8skjt8gyijJ18FAucwPKq7poKk4Lc
         en9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382602; x=1733987402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPDL9SY/CBHi33tr/kgPHOHPuPtSjT4Zve0V9QYVUns=;
        b=L2M16uQuPth28tVo0IdzMcPf6SSPln0GCjHMUWwUQL4XdRUwasfCCvWw9l4Ud5N2iM
         rKjke+BlZA5yG7oYlXnQwkHTffs8mF3IPTR5BomexfSCH8s1rkUtRVGKESsKlUiB09Ia
         I+tEAMtcyo8d0izWKmlg2yxSy3aDiC4WrtBAhRTLYZ1amGcFb6iOWziKv/BLpe24j+Vy
         zJiIbhx7lA53l+LFP2GEcd2BhXUKEYj3iwV3szp/nQoMB9EZn+TmLXaDw9mH7TBI1dtb
         GGHhpODhlwI4krlk94UUkYpHELM53Zi2ptODvMr5336zM8FjV4BdNvip0WGTB2zm4dN+
         Awkg==
X-Forwarded-Encrypted: i=1; AJvYcCWFsPh512GNTme7KgvOa6enOdBvHhx2R6SH7ZWMaZA9Gwq78ffd6rufCmSOr+sGt0d6zaAIad4aOaGN6Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSoVjciRlf9Tqw+XrkLgT9HugKrusgwpPabP/1zXQz8ymYlS0H
	C3uR8J49+Kp9kBnxu8hcZaO9GFNu/yAGZSvrU3I7Df3ePmhKZo48pXopBJJ1FibUgUceiOso/n/
	xtT5WyWXjrQz5SIwJFqhiDbXUMnfYE15AFjde
X-Gm-Gg: ASbGncsJQX6EVd38oE4/w8hWxO0P4I6qxK8508/AcMAzsoUoou+UnZigHpI7LgkME53
	1QSPppnovuiB9JEBbUoj6pBvXHu0ylQoJ
X-Google-Smtp-Source: AGHT+IECZqE5fteXnXhm7vixb8m+w0qLbQKrsGI/zvrm/ngsLjVg0yiBWZCYVxgp2gk/sSWgzMEK1Gc+/gr5yc7ZgNU=
X-Received: by 2002:a05:6e02:3710:b0:3a5:e506:162b with SMTP id
 e9e14a558f8ab-3a80933eb2emr1476435ab.11.1733382601610; Wed, 04 Dec 2024
 23:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205022305.158202-1-irogers@google.com> <Z1E-WHWSPAezVF4f@google.com>
 <CAP-5=fVPw5wJtVR0fxU-7drXg34vNrBsEzurfcLLvC+wFPMAAg@mail.gmail.com>
In-Reply-To: <CAP-5=fVPw5wJtVR0fxU-7drXg34vNrBsEzurfcLLvC+wFPMAAg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Dec 2024 23:09:50 -0800
Message-ID: <CAP-5=fV6s0=X-+8i2+1O_ZKERTL8+S9S-nyZC8rJPNU_nQpbyg@mail.gmail.com>
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, 
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 10:33=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Dec 4, 2024 at 9:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hi Ian,
> >
> > On Wed, Dec 04, 2024 at 06:23:05PM -0800, Ian Rogers wrote:
> > > The refactoring of tool PMU events to have a PMU then adding the expr
> > > literals to the tool PMU made it so that the literal system_tsc_freq
> > > was only supported on x86. Update the test expectations to match -
> > > namely the parsing is x86 specific and only yields a non-zero value o=
n
> > > Intel.
> > >
> > > Fixes: 609aa2667f67 ("perf tool_pmu: Switch to standard pmu functions=
 and json descriptions")
> > > Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > > Closes: https://lore.kernel.org/linux-perf-users/20241022140156.98854=
-1-atrajeev@linux.vnet.ibm.com/
> > > Co-developed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > It failed on my VM.
> >
> >   root@arm64-vm:~/build# ./perf test -v 7
> >   --- start ---
> >   test child forked, pid 2096
> >   Using CPUID 0x00000000000f0510
> >   division by zero
> >   syntax error
> >   Unrecognized literal '#system_tsc_freq'FAILED tests/expr.c:253 #syste=
m_tsc_freq =3D=3D 0
> >   ---- end(-1) ----
> >     7: Simple expression parser                                        =
: FAILED!
>
> I'll need to check this. The test is looking for parsing failures, so
> it's confusing to me expr__parse is returning 0. I was testing on x86
> but disabling the literal in the tool PMU.

Hmm.. perhaps you had a similar issue to me and that b4 silently
failed as git user.email/user.name weren't configured? When I test on
a raspberry pi 5:
```
$ uname -a
Linux raspberrypi 6.6.51+rpt-rpi-2712 #1 SMP PREEMPT Debian
1:6.6.51-1+rpt3 (2024-10-08) aarch64 GNU/Linux
$ git log -1 --oneline
94733a0e50fd (HEAD -> ptn-expr-test) perf test expr: Fix
system_tsc_freq for only x86
$ /tmp/perf/perf test expr -v
Couldn't bump rlimit(MEMLOCK), failures may take place when creating
BPF maps, etc
  7: Simple expression parser                                        : Ok
```

Thanks,
Ian


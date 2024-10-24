Return-Path: <linux-kernel+bounces-379108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573489ADA14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787711C2182C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030815957D;
	Thu, 24 Oct 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eE228UDk"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886F14D2B9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737794; cv=none; b=MlTIe4mr/0PWjkeLxyc7gCadsYpj3fuvGYjTCc3gXtzdnmu196wnHp8kuM9ACzfiZTGCEufNY/LTMs28apJlGwax57oQOCP+238T4vvptptdFTPc+FcjcWXEnpCoXNFN67jjMUyWu4D9yRQ9q/beNhoGtAwoU68241WwEsnjjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737794; c=relaxed/simple;
	bh=+qFp3TeeQPQRKhqu0qcRmgNw7B51osoKFFrsbOPjRao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQyqRJws7j4RaifINwmxsfcEzj1wQaWPdORKdxcY1Y++UEE+sv0Fw5xHSjIQBtcWfvUOrEJM1COmS7lItdsnudTugkR7txi2PyS6GJAVrKDnkyWdGosFnRfSPwkGkyIqXmuuR8J9W+GuxgCMWxd3Qupvim8kbOc7N/b1/KIgyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eE228UDk; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so41345ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729737791; x=1730342591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyHwur5QJelig3QLV0G8DK/xG9ajEnYR1dsUUnnzJjM=;
        b=eE228UDkH3k8VHS+a2tnQK0JVFYNGUSM3PhbnytkLdUOyA8DBypfiW7jpvmFCKPlDA
         6s6Gg5b1rYTKdyxt35AL3AtHULB9svXJ64D96Z7q/DYRXZkIgfLIAIM8vBfGtOXE7M1j
         sG2SFaYKHz9Auq/yRYEkKlWX2RH4CVjwuQwOo0EcawU3e04Ll4YMrJ6wPZ58/+KiXPZE
         Er+EGIdrY4nERD15C3Fo++pdQi1C14wl2NyGkPyFTSyC65rPM14QntLHWWg0L6KG1/RR
         tcjX8kpdez6fmEGX31b0D+lvPsq1NId+n8BLgfFV9fbUYYqj2eJ5J64cbgngMy6UCe+h
         ED9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729737792; x=1730342592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyHwur5QJelig3QLV0G8DK/xG9ajEnYR1dsUUnnzJjM=;
        b=WCfcjjRrXJ7VAC55uQSUfjUJI+Y+pdL4dfIF3afn8Ftk62CvSsAEAo0/4ViX99uPnF
         YFMXON3yj4V2LilCSoXyzeRiOiLFg1/Kzl4w1bV8VpooUyVebGBQIAG7d5whlaJF5dz9
         jAjtMrrWVebQKuRaqw4ONH1KgjqxFXZpV33GkVMLLYSwiZOOj40eJKRJM4WaH1IV7Ja9
         XpzW+KL6FEvRQ4gndM/BH2tE28uSGMCWJxMNl9KJlwXstL8uANTl+r135/oyWVfnIH53
         R+4fjVPEK6o01aeCIQrAJhqNH0hxqU0LkPTEMPCCrbusAt1ETjYxSWGbFMhrNkL5XglF
         e2oA==
X-Forwarded-Encrypted: i=1; AJvYcCX8iVPAIeuPf8X6Sc42wQKkHoaoCA5zoNv3c++6v1UXJ/eqexRaSGCzCCVqsJ++stjGwo+Qtk6gJCYPhuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIiMHZVysM4KO0/lnpq43siNjJQFMCPEbO//zpRsLff/iztYHf
	8mgqKsqhGbSVVcVsVFoZhkC77ysPZnrRx6M5ZYsM6PH5M4o2HAjtAT3w09yV+7KI747J4H2U2U0
	HPJmMToqUSNdWdiuwPwibLxRsWGq30cJy6YaP
X-Google-Smtp-Source: AGHT+IFsHnYt3q5cMj1wjYuphkOrbWbA+1QoNbLM9tfPRGHRO7ZW8plCmxpEWlscDtcaURUESWm4irsy6yRCNbcY5to=
X-Received: by 2002:a05:6e02:1a42:b0:3a3:b07b:6d3 with SMTP id
 e9e14a558f8ab-3a4ddfdda4dmr1104045ab.9.1729737791542; Wed, 23 Oct 2024
 19:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018055627.1005723-1-irogers@google.com> <Zxc6_jZdDcWgtEom@google.com>
 <CAP-5=fU04PAN4T=7KuHA4h+po=oTy+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com>
 <ZxiVKvmzjeHd4xBQ@google.com> <Zxl2etmBtc5XsQ3p@google.com> <ZxmFwUPyD34LqAHX@google.com>
In-Reply-To: <ZxmFwUPyD34LqAHX@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Oct 2024 19:42:56 -0700
Message-ID: <CAP-5=fV_-Z85b_DMCCPFo1FU2dyUY9ELNEJz6fx+JgZg4iPj7g@mail.gmail.com>
Subject: Re: [PATCH v2] perf check: Add sanitizer feature and use to avoid
 test failure
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 23, 2024 at 03:19:38PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 22, 2024 at 11:18:18PM -0700, Namhyung Kim wrote:
> > > On Tue, Oct 22, 2024 at 10:39:36AM -0700, Ian Rogers wrote:
> > > > Sure, the reproduction is trivial, just add -fsanitize=3Daddress, s=
o I'm
> > > > surprised you're not already seeing it:
> > > > ```
> > > > $ perf test annotate -v
> > > > --- start ---
> > > > test child forked, pid 444258
> > > >  68e8a0-68e96b l noploop
> > > > perf does have symbol 'noploop'
> > > > Basic perf annotate test
> > > >          : 0      0x68e8a0 <noploop>:
> > > >     0.00 :   68e8a0:       pushq   %rbp
> > > >     0.00 :   68e8a1:       movq    %rsp, %rbp
> > > >     0.00 :   68e8a4:       subq    $0x30, %rsp
> > [...]
> > > >     0.00 :   92d6:       shrl    %cl, %edx
> > > >     0.00 :   92d8:       movl    %edx, %ecx
> > > >     0.00 :   92da:       movq    %rax, %rdx
> > > > Basic annotate [Failed: missing disasm output when specifying the t=
arget symbol]
> > >
> > > Hmm.. this is strange.  The error message says it failed when it
> > > specified the target symbol (noploop) for perf annotate.
> > >
> > > As it's the dominant symbol, it should have the same output for the
> > > first function (noploop) whether it has target symbol or not and it
> > > should match the disasm_regex.  I'm curious how it can fail here.
> >
> > Hmm.. ok.  For some reason, it wasn't failed when I add DEBUG=3D1.
>
> Oh, now I'm seeing why.  We skip perf_session__delete() on !DEBUG build.
> :(
>
> >
> > Without DEBUG, I can see it now.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D1053492=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 33 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f1ad78edd20 in strdup ../../../../src/libsanitizer/asan/asan_=
interceptors.cpp:566
> >     #1 0x55eda19cb76f in perf_data__open (linux/tools/perf/perf+0x65276=
f) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
> >     #2 0x55eda18ffafa in __perf_session__new (linux/tools/perf/perf+0x5=
86afa) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
> >     #3 0x55eda15485d3 in cmd_annotate (linux/tools/perf/perf+0x1cf5d3) =
(BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
> >     #4 0x55eda1695467 in run_builtin (linux/tools/perf/perf+0x31c467) (=
BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
> >     #5 0x55eda1695c0e in handle_internal_command (linux/tools/perf/perf=
+0x31cc0e) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
> >     #6 0x55eda153ba72 in main (linux/tools/perf/perf+0x1c2a72) (BuildId=
: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
> >     #7 0x7f1acda43b89 in __libc_start_call_main ../sysdeps/nptl/libc_st=
art_call_main.h:58
> >
> > SUMMARY: AddressSanitizer: 33 byte(s) leaked in 1 allocation(s).
> > Unexpected signal in test_basic
> >
> > No idea how it can leak the data->file.path (that's what I can find
> > where strdup is used in the function).
>
> Maybe we need to revisit how much speed up it can give.

I think this is a different issue and not sanitizer related except for
the sanitizer catching the deliberate leak. My full build command line
is:
```
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g
-fno-omit-frame-pointer -fsanitize=3Daddress" CC=3Dclang CXX=3Dclang++
HOSTCC=3Dclang
```
Of which the -O0 may be the thing that is making the difference and
breaking the test with sanitizers for me.

Thanks,
Ian


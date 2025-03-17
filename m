Return-Path: <linux-kernel+bounces-564481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD420A6560C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82A23BB6BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31024889D;
	Mon, 17 Mar 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9lGMruy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C423248888
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225937; cv=none; b=OU1fJEHd3gGtOg5pc1UhadArJHmHvEWrx9PKJRNh6MNKBPFhWtl01ZkAWpjIrWdg6bbUwcgCJdqrGPFhZ1vGdWtyDcukNNidk/Y4qrHUVxlF7kptKefMVx5fdKecZV2oYon/a8MImKyK7kFwNonN9sPr1YgSkbToUpMWZlQsoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225937; c=relaxed/simple;
	bh=aXdbkkq2W+1zWRXsr9HiUFXu2toowMxmufs/pM82+WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpPglYha/IF4y4pL3kzXQNwUkFUdg3DmwCRYLQwzJGFdWPlYBv9UiQ04IuT1fU3Sa6JTVxqSwoFAK+tMhpoC32BWuKYmulM4cbLRcNTpeAEXh0Jo6vi/jLajkC96WvcCvz9hKjX60YotVHsdWFp3o5AyNHaXY6z9tGJbI2D45iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9lGMruy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so36705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742225935; x=1742830735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibewGAo/J2qRa30YAt10KaER6uAGQ3UTarCl0s1LQn8=;
        b=j9lGMruy3OVVo2lUSg8oEpsJfVlYaWogriZ/QxeO2V03zTyTaJ/hzQWFK4f4JYb2YA
         46IgEcugmVglxjhnmYpZJuRU4QlfYcNyWo5IJGxouTN5RhUyz7ntcf4k8jQXcH4lzG/0
         ePTXMziMc6gj0r+5HhNU1IxZSOgNkX5bC4Ma1UhijfXJ2052gvZEyF3rLS0qNVIUnNRT
         ZWCKwmKM6lBLt458DV5xvd/4KXhJM5NdSUIbJWlzbYNTqsSIPRTSgVW9c5T7hAO1HV/d
         mlKjZA5daOc1pzbSjjLXJbIFHAY0opboGoqB2riawjAg9UYtLECyMoYXt/YCgOPHbbnm
         gqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225935; x=1742830735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibewGAo/J2qRa30YAt10KaER6uAGQ3UTarCl0s1LQn8=;
        b=nc12ivh9Xzt1Z7LHDZkbZAJNGP9gIcsh6794Q6MB4pWR+Lh9fKJ2m/tqN/FoVmFCID
         VRgzKgyn+VgzdsuhNoQGmgO6lYcGxt4Ck1UmCKR47Vjo1NpUkVTln4XAJZCisBqspTa/
         FuqM8v3wRUgWw4HH/cReXBttm/NJe2wdyN78vvKZDaV3yFVnhK3RPEno5q9GzFQeXEMZ
         n0z11rGRPvvMa/yJs6vbO4FvFd9e6yaN5nzATAeq09eUSw52MwXidsbRo30Bgh07O5+K
         OyxzjPQs+mmZzTbqwsVl/8rYr/v+CzaVZlGxY1bN6TTG/0uF4kPX99P2gLed0X7tTUmK
         eeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1dx2RMOp+lKIaCIsrDvIWeUGXtzy7x+Ov+sTeLm2JrU8g2lBypDmh3zl32mPdgi8XKPMR+3HJsQuQoiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8T+4y51v8hVmr3iPNh7fFUZUlY8PYlQk/69m1LFZqO8hen3c2
	qUx4wWl3wBGmEI1cgKUMyUTXJlu6E6QRVw4rUYIer3RMKY+fDXR477HiGycoE1hViv9VlvvWXV1
	YD7zVmXRc7JCwRiUNwEN14QMjrswYyz+8hGvi
X-Gm-Gg: ASbGncscpFfRwlAhIHMucND3eHtZoovzTLKXvjI7Ojt2Zd9SysTALARCrEb+DonjS8A
	Tno6cfRCDF1tMKli84r9NQcq/G2ev5GVLzV02cQcUjLi2Zcx3jJiyhHNhtzxd2n8kJOzyfTWFDq
	MtuFydiSnsNnPmiRP5GdJOIz03m32Fh3pOHAYSywy2CNIl70QeSnPYbVI=
X-Google-Smtp-Source: AGHT+IFmuAire14rm2C35T4pBPTkpwXnhmqypP81Y8wUqO9DVsSx/lXQTrcMGKQYhWRrXY2V7IZoaC+BrdPT5mr0tQI=
X-Received: by 2002:a17:903:906:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-225f374426dmr4632695ad.0.1742225935292; Mon, 17 Mar 2025
 08:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312055846.671522-1-irogers@google.com> <20250312105450.GN9682@e132581.arm.com>
 <Z9M9gK4VS199CRKh@google.com> <20250314091314.GV9682@e132581.arm.com>
In-Reply-To: <20250314091314.GV9682@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 08:38:44 -0700
X-Gm-Features: AQ5f1JqqPslmU7qwiaXwbGhMZe0hBOK2_y6dneuYZ8SwG4h2LXyZ6LgALAdOUn0
Message-ID: <CAP-5=fWM2hqu02nNyBUBgLu01AC=C7mwxayezzs7frCyAsirPg@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Harden branch stack sampling test
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	German Gomez <german.gomez@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 2:13=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Namhyung,
>
> On Thu, Mar 13, 2025 at 01:18:08PM -0700, Namhyung Kim wrote:
>
> [...]
>
> > > >  test_user_branches() {
> > > >   echo "Testing user branch stack sampling"
> > > >
> > > > - perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u =
-- ${TESTPROG} > /dev/null 2>&1
> > > > - perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' =
'\n' > $TMPDIR/perf.script
> > > > + perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,=
u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
> > > > + perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR=
/perf.script"
> > > >
> > > >   # example of branch entries:
> > > >   #       brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> > > >
> > > > - set -x
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*=
$"     $TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"   $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$" $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$" $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"     =
       $TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"  $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"=
       $TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"         $=
TMPDIR/perf.script
> > > > - set +x
> > > > -
> > > > + expected=3D(
> > > > +         "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"
> > > > +         "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > > > +         "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"
> > > > +         "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > > > +         "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"
> > > > +         "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"
> > > > +         "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"
> > > > +         "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"
> > > > + )
> > > > + for x in "${expected[@]}"
> > > > + do
> > > > +         if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1=
 -q "$x"
> > > > +         then
> > > > +                 echo "Branches missing $x"
> > > > +                 if [ "x$err" =3D=3D "x0" ]
> > > > +                 then
> > > > +                         err=3D2
> > >
> > > Here it sets "err=3D2", as a result, if any grep command fails, the s=
cript
> > > exits while reporting to skip the test.  This seems incorrect to me.
> > >
> > > My understanding is the regular expressions above are mandatory to be
> > > matched, otherwise, it must be something is wrong.  We should not ski=
p
> > > the test in this case.
> > >
> > > I can understand that 'perf record' cannot record all branch types, i=
f
> > > this is the case, maybe we can improve the recording quality rather
> > > than reporting skip?  E.g.,
> > >
> > >   cat <<EOF > "$TMPDIR/loop.sh"
> > >   for run in {1..5}; do perf test -w brstack; done
> > >   EOF
> > >
> > >   perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u
> > >     -- sh $TMPDIR/loop.sh
> > >
> > > If we run the test for 5 times, should this can allow us to ensure th=
e
> > > branch samples are recorded?
> >
> > The brstack (and other workload programs) can take an argument to
> > control its duration.  For brstack, it's the number of loop iteration
> > and default is 999999.
>
> Sorry I did not dig into the brstack workload program.
>
> If the workload has run for a large number of loops, the question is:
> why isn't the test capturing the expected branch stacks?

On our testing skipped =3D=3D failed, I can change 2 to 1 above but I'd
made it 2 as it wasn't clear to me all branch filter types would be
supported by perf record and skipping/2 was a less terrible error
message.
I'm keen to land the pulling apart of the perf command from the
tr/grep as if we hit say an asan error currently that is hidden by
code like:
```
perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u --
${TESTPROG} > /dev/null 2>&1
```
where all the output is sent to /dev/null but the asan error code will
cause the "set -e" to fail. If this code fails with asan then
currently the first thing to do is start pulling apart the
expressions.

Code like:
```
perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' |
grep '.' > $TMPDIR/perf.script
```
is problematic as again we lose the asan like errors. Running the previous:
```
 if grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$"
$TMPDIR/perf.script; then
```
could fail because of an unexpected branch filter type, but was
failing for me just because there were blank or similar lines in the
output. The new code doesn't change this but allows the output to be
dumped for later diagnostics. The '|| true' in the expression means we
get to dumping the diagnostics and dump just fail because some
sub-command mismatched its input.

Thanks,
Ian


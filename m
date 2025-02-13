Return-Path: <linux-kernel+bounces-513672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B31A34D48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC2A1649C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B2242929;
	Thu, 13 Feb 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/Py3fMU"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92A241692
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470452; cv=none; b=nC+uwXSz8IiT+2zA15/MGeSfgPX1E55KoCKbg1Zb21i4Q0z60pg2LhANeOy1PbS/w3pNoQR32MDgXiLW941YHE8TFTSPVoWpRluqjFMXyGihWcCjbW7/22XxYCXbzK0voEzHM2XFiVT5gs9MBEU07KT866+Ey0isL/LRlKMTdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470452; c=relaxed/simple;
	bh=VLAThHAQtpFSiqOnyEzPKtmbtdRw94l3smP4s1KAxBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDm4vQqj9u7v74nIIpFv3BDKDjicKvy9VYditHnWZh4T9Z1jFXy+iTgnUoRLja8D7CGZjNWtHPTg0StiFiXXOXdRxMx3Dc/1xqtoUIIc085eSxCg6ENEzl1WBQerUQ6yg3PCweR2A/Ua4YaCzfG3fffCfIQK+u/uORe21dVnRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/Py3fMU; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so6885ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739470449; x=1740075249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kw8Yo3WL5PbbrOqA5FXFu6f9q7N5NMqJ3ZqLlw3kLQ=;
        b=N/Py3fMUbMbLRjlpySmS51r0DRSlyo5CgNoHKneAxc1vl74bTgakhe2bz+1GutplDs
         dTNJ7hHyqvxXsRQ/WYeEiuvvjuWYUAQ8c69nP/jKarYCXG/Cq/bEhuUOdksxz45FeH/j
         +K1P7rnhAAINLVXzkQ6AAM3ByrMHM9oxgXFUqGrI4x8ORWadtSLR1c0Q2mocpNmKhiPy
         dRsaewpZG2q78Dc/6n5e04fRQjiNwNmx0QGMZ1UiutlVus13VJo7+v6kVj5mfMZxw9H0
         sajWEMk71sqMJyQaN4mSpLR+QdNOLo5+yrX+Rw8XB/tw3WPnLG7gnS+PtJvnsj/M+vkk
         NHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470449; x=1740075249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kw8Yo3WL5PbbrOqA5FXFu6f9q7N5NMqJ3ZqLlw3kLQ=;
        b=DYgz/bj1Wun84uKnClA4WL6zmxRV/Cjqc/7cTcOdUpoK3aEfcch+WPDv2UqL/SSLej
         WStqdkPO9bvghW9LFbP29VXcaJk/2wUEmbpMfdgcWaFzSuQWOyI8HSRvH9epkcV48CCq
         vVhmsgfePZO2ZZUu964OLv5Un1ccBrdy/Fe6nUMQIW4bWHZiro89YprSvpGEdtDdSS88
         HvCYOS4sOyNrEEulKGjs0GLllZwzCQyF22+YUsDP25K2niY1H99cZPBea5Ntuxymvc5a
         hAa7a81MkbFg678ExJ9bbIG2J7u+zXMunoLuXDv0V6Y6kRxh7Z4wfYMmU9W7S4zC4Rf1
         duTw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+qGQWyP4NGRso35SiCFtI4aLh1DyfS+DY9GIo3gX8BknSKrmdB1ALx74Hfpo2VukQMyU6+WV7bpGLz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzVVDXqFTHJFz93XcLXppzRURBkuwNdfVKdbMxDJSV465rW+V
	+Qes9OW72rzeesZlm4EliVsweViaQWGyIGFHtpKeZBmkokZU5AHMXcJXkeft3gEcoIb81rcknU/
	dinljONvun/1B/3OKEkL2PntsMbgR1OjX+sPO
X-Gm-Gg: ASbGnctf5m2bFSxrSNgxEOwy/quAOxdmyNGzmY8RUBNqbRtad2lDJLvW5bwYU2tGGDT
	pw7/dpb4mZNESTDmcqEq4YUEn8fd7voT6cnSM2lD0i6fhu8x1RhQQC0VtD3tQJYdQ+7gvgEd4oK
	0hmkSVIm3q/javBwcZF1saHKo6
X-Google-Smtp-Source: AGHT+IH3Ng+6/etX1M0fh9voca4+NMtNw9NEknYbyf185lBT6BpfBx9p0saqNlqyC1dW+bHCnlukH3dVAOXcRhN/NSY=
X-Received: by 2002:a05:6e02:13a6:b0:3d0:5693:d730 with SMTP id
 e9e14a558f8ab-3d18cc98567mr3576825ab.6.1739470449344; Thu, 13 Feb 2025
 10:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6uOGNO6p7i9Fese@google.com> <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com> <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com> <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
 <Z60nBQCetMzhRg5b@google.com> <CAP-5=fWG7JOmQhTa+OccOxSLhik6Du-qy9d90q-zhDTu0P=q3A@mail.gmail.com>
 <Z61OeArP-P-I5NjU@google.com> <CAP-5=fXTLBb1+PghPCraJQcXY518Jtt3AwPLpoXvjXErW79U5w@mail.gmail.com>
 <Z64wSRTXxC6CXey7@google.com>
In-Reply-To: <Z64wSRTXxC6CXey7@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Feb 2025 10:13:57 -0800
X-Gm-Features: AWEUYZnx-AudQHjyJaohSYkcrNOsn-adYCoNHmAiHh0j7fPWp9kR-4mOZYgWtco
Message-ID: <CAP-5=fW3TsODN6+5WF8c8wBa+JYHZKqT5oMTq2MSg9XuSOx2jA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:47=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 12, 2025 at 11:27:38PM -0800, Ian Rogers wrote:
> > On Wed, Feb 12, 2025 at 5:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 03:17:35PM -0800, Ian Rogers wrote:
> > > > On Wed, Feb 12, 2025 at 2:56=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > On Wed, Feb 12, 2025 at 12:00:42PM -0800, Ian Rogers wrote:
> > > > > > On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Namhyung Kim <namhyung=
@kernel.org> wrote:
> > > > > > > It's not completely broken and works sometimes.
> > > > > >
> > > > > > No this is the definition of completely broken. If it only work=
s
> > > > > > sometimes then you can't use it, we can't put a test on it, the=
re is
> > > > > > no point in it. Even when it doesn't fail on perf_event_open, d=
oes it
> > > > > > work for processes that start after /proc is scanned? No, it is
> > > > > > completely broken.
> > > > >
> > > > > Ok, we have a different definition for it.  Let's ignore the imag=
inary
> > > > > users of the broken features.  Have you added a test for this cha=
nge?
> > > > >
> > > > > Anyway I've tested your change and found some issues:
> > > > >
> > > > > 1. It silently exited when BPF-skel is not built.  Better to put =
some
> > > > >    messages at least.
> > > > >
> > > > >   $ sudo ./perf record -u $(id -u) -- sleep 1
> > > > >
> > > > > 2. Even with BPF-skel, perf record doesn't work well.  It did som=
ething
> > > > >    but failed to get sample data for some reason.
> > > > >
> > > > >   $ sudo ./perf record -u $(id -u) -- sleep 1
> > > > >   [ perf record: Woken up 1 times to write data ]
> > > > >   [ perf record: Captured and wrote 0.045 MB perf.data ]
> > > > >
> > > > >    Oh, I think you now need to pass -a because it now works in
> > > > >    system-wide mode and drops samples for other users.
> > > >
> > > > This is a pre-existing problem, no?
> > >
> > > No, it worked without -a in the past.  Please see my previous reply.
> > > I think -u/--uid is one of the supported target in the perf tool (not
> > > for the system call) and it used to disable system-wide mode if -u is
> > > used at the same time.
> >
> > As I keep repeating the '-u' option has never worked in the past, it
> > either early exited or missed recording new processes.
>
> I agree the early exit of existing process is a problem of '-u'.  But
> I'm not sure it would miss all new processes.  IIUC '-u' is a shortcut
> for '-p' with all processes belong to the user.  That means it'll have
> perf_event with attr.inherit set then it can track new processes from
> them.  Of course, there's a race between /proc scanning and process
> creation so it will miss some.  But even '-p' has the same race.
>
> >
> > The documentation for `perf record` is:
> > ```
> > ...
> >        -a, --all-cpus
> >           System-wide collection from all CPUs (default if no target
> > is specified).
> > ...
> >        -u, --uid=3D
> >           Record events in threads owned by uid. Name or number.
> > ...
> > ```
> > So `-a` is implied without a target/workload but you are specifying a
> > workload and `-u`. So do you want samples from the workload or from
> > the user's processes? I can tell from your command line being sleep
> > that you want it to imply `-a` but would that be true if it were a
> > benchmark? For the benchmark case you probably don't want `-a`
> > implied. If you specify `-p` and `-u` should the processes that don't
> > match -u be sampled or are you expecting implicit system wide
> > profiling now?
>
> I don't follow.  You cannot specify two targets at the same time.  If
> you use -a and -u together currently, you will see:
>
>   $ perf record -a -u $(id -u)
>   Warning:
>   UID switch overriding SYSTEM
>
> And for -p and -u:
>
>   $ perf record -p 1 -u $(id -u)
>   Warning:
>   PID/TID switch overriding UID
>
> And specifying a target and a workload means it will profile the target
> while the workload is running.
>
>   $ perf record -u $(id -u) -- sleep 1
>
> So the above command will profile all processes belong to me for 1
> second.  As you're doing system wide for 1 second with below command.
>
>   $ perf record -a -- sleep 1
>
> You can change sleep with any other workload but it's not the target of
> the profile unless it matches to the target specifically.
>
> >
> > I agree the behavior in the patch series doesn't match the existing
> > behavior, but I'm not sure the existing behavior agrees with the
> > documentation nor working as expected. Having the `-u` not select
> > system wide, as in the patch, seems to agree with the documentation
> > better. You have specified a target workload/process/eventual pid and
> > you want samples owned by the uid, why should you now start getting
> > samples from other processes? With `-p` you wouldn't expect `-a` to
> > suddenly get implied, I'm not sure it makes any more sense with any
> > target/workload.
>
> As I said, the existing behavior doesn't imply system wide.  But your
> change now requires it.

The existing behavior doesn't work. If we can't put a test on it, it
doesn't work.

I'm asking what should the behavior be? You are asking to match
something that doesn't work, why? Pointing out warnings ignores my
question, you just seem to be out to prove you can find fault with the
patch series as-is.

The major use-case for `-u` I find being perf top and not perf record,
largely because if you are trying to do perf record you are less
tolerant to the brokeness that is the existing -u behavior. perf top
doesn't have a workload and system wide is implied.

Should the behavior be with -u to imply system wide or should it be a
filter to the user's other options or should we scan /proc and have
that brokenness again? The latter has been your expressed preference
as you don't see -u as broken.

Thanks,
Ian

>
> >
> > > > > 3. With BPF-skel, non-root users will see this.
> > > > >
> > > > >   $ ./perf record -u $(id -u) -- sleep 1
> > > > >   cannot get fd for 'filters' map
> > > > >   failed to set filter "BPF" on event cycles:P with 13 (Permissio=
n denied)
> > > > >
> > > > >    I think it's confusing and better to tell user that you need t=
o run
> > > > >    'perf record --setup-filter pin' as root first.  But maybe due=
 to the
> > > > >    issue #2, you still need to run it as root.
> >
> > I think that is an okay addition to BPF filters in general. I'm wary
> > of having patch series feature crept into requiring the entire tool
> > being reimplemented.
> >
> > Thanks,
> > Ian


Return-Path: <linux-kernel+bounces-251895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECAD930B35
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88311C208E8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924513C832;
	Sun, 14 Jul 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckO4SYwu"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554311CB8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720981970; cv=none; b=f8RlgyuDEuuX4C18oRsmHmJLhCVJk6GlNq6zLHjLxGbSrPM43G9JDUKDvg68MfaH+5d+TBGVCjaQeIcP/UdP7gHnMV559DD3k5ywGbRB+sm5lfJLObLBZn1qfxV5cyBX/7fpUILKAZj2R08UpKMYgViKH+mjyyXymCNG3WlsosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720981970; c=relaxed/simple;
	bh=axVnNVZElN9K+WJ1NqWQrosc7ff7qmHlzItu0G3c2x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0TgdhtupLY4zNvr32MMuUmdENqiMj1LRhQ80wwiJK3WHXSyV3WI6jyJlBek9WUNOMh0foctKAzDpTwAZ1j9XwKhceEoT2UqUmE6WvRL1PZaVDsrZvHyDm77ehrLOOxFjdG59kCJAhlMj10Rn/ncmYMoABRMYE6FpDZAdJky5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckO4SYwu; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so189295ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720981968; x=1721586768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRmNueVfRwx6hSp+wpP2BIcRa8EHHqYFYcUKib3o7+c=;
        b=ckO4SYwuVP9immJV/zRp0RCIlnERuUd8sjPvD3VCbuXH+n5CbDy3rRoZGVgHx0IDgH
         Cq24Kj/JUR9YQnQCl9ajf/v3nWd5J1bbMwhhwLg6nKDRwyq2gb5IamHbK+l/jf1YeTfo
         6EBnWReyjALKqqTqj3yIRvRsFGsG1ahjHuRtHqqzlhVtimLM3cxou3mLZOUU644dIo8B
         5A8yQPWfnoun7EYzIotX4Ghyp4/TPGrnIkz9ch9wHwOhYKdBMD6xuMCVcCNdD55LYqq9
         tRb6zbm7zJ3EN6YMCFCiT+eX+bH6QMa2OIqeVvQ8qRCrXsL5sqf1JHpFk69mXybEki8x
         5pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720981968; x=1721586768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRmNueVfRwx6hSp+wpP2BIcRa8EHHqYFYcUKib3o7+c=;
        b=dSxzZzC6V2foUJT5/7R1R9OybliRrqcLW/uVDJgXWwsk0ugnrutMeOwlKV/A1TCydJ
         u/BnIgMw8CjzcP12LhUyn6qJSATgpvsBF/zRkPOAvj5oyuTHOSDKouQ1b+FBEJNzqmtH
         h2JQAZ6ylfpzkad48k8Uftt/r0qEud1Zgcnt4AgKbTb+SCf3PlBoTA2wYPH8HvkW9BdC
         YLtVmso7VbaITNPPUMqDThR6lvWDPYnKuFLaPWsN7BY/n26U8G3MXfTPQRlI7gF92LpM
         2o2TsbSMy2auFQZt6yJidlvcq90zK+EgC/K85I4bNRRXC5nguN/9Owoo/5SdVxX34Y44
         XQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw90usF/DEBwLEPBiS4NxrBmSs5PuVBN5i6fT5f8gXDwRs3o0OmHmyu2gJIkG2rY0AI3emAzIukRUU7D4+nkwegoM8ENd8qGe7xFjd
X-Gm-Message-State: AOJu0YxqxyI1syo0eImfhEqhjn0VrU8cPdpnZvhhGJ70zyJuaTp7AS/t
	RUUxbuXcanCbonz14Tv2+rLmGsDm5mBwWRWqLjpa1Tb5stCACaH0ngZeXU3OJy86/xgKa1RfYH0
	T5UL1y04MFziwKMrPCia7BKtbD+10Bwv5PCbC
X-Google-Smtp-Source: AGHT+IGcwuwCBkzc1snuxIm9+uDjFVY7qJrNbGsQIoZ14ZJ/BtCljwkcO6OVbWnqyL8PGLkEwim1g9ErlM7UTCDw++I=
X-Received: by 2002:a05:6e02:1c87:b0:377:872:cf6b with SMTP id
 e9e14a558f8ab-38fc91b87a8mr3678635ab.2.1720981967718; Sun, 14 Jul 2024
 11:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
 <CAP-5=fVwZfV+gNWcmEtRnkOtrvozMdXPVrZ37COHkf4BX1VPgw@mail.gmail.com> <CAD2QZ9ZLHQ62d5CDpf14DkrWFs_FggRMdqzGFz3qsmF_vmS00Q@mail.gmail.com>
In-Reply-To: <CAD2QZ9ZLHQ62d5CDpf14DkrWFs_FggRMdqzGFz3qsmF_vmS00Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 14 Jul 2024 11:32:36 -0700
Message-ID: <CAP-5=fX++xsupSisMejFDbs3dFBegbK9VwykbsLMpadX6brATw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] perf: add logic to collect off-cpu samples
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: chu howard <howardchu95@gmail.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	rostedt@goodmis.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, yangjihong1@huawei.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, asmadeus@codewreck.org, 
	siyanteng@loongson.cn, sunhaiyong@loongson.cn, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>, nadav.amit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 12:43=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.co=
m> wrote:
>
> On Fri, Jul 12, 2024 at 3:28=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Jul 11, 2024 at 5:16=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom=
.com> wrote:
> > >
> > > Add --off-cpu-kernel option to capture off-cpu sample alongwith on-cp=
u
> > > samples.
> > >
> > > off-cpu samples represent time spent by task when it was on wait queu=
e
> > > (schedule out to waiting for events, blocked on I/O, locks, timers,
> > > paging/swapping, etc)
> > >
> > > Refer following links for more details:
> > > https://lpc.events/event/17/contributions/1556/
> > > https://www.youtube.com/watch?v=3DsF2faKGRnjs
> >
> > Hi Ajay,
> >
> > I wonder if Howard's improvements (not landed) for `perf record
> > --off-cpu` would solve this problem for you?
> > https://lore.kernel.org/lkml/20240424024805.144759-1-howardchu95@gmail.=
com/
> > Or is that approach problematic due to the use of BPF?
> >
>
> Thanks Ian for your response and sharing Howard's improvements.
>
> Yes, perf --off-cpu is based upon BPF and having following restrictions:
>
> - target binary should be compiled with frame pointer, same mentioned
>   in tools/perf/Documentation/perf-record.txt:
>   =EF=BB=BFNote that BPF can collect stack traces using frame pointer ("f=
p") only,
>   as of now. So the applications built without the frame pointer might se=
e
>   bogus addresses.

Agreed, if you want more than the leaf function. There's some evidence
that frame pointers may become the default:
https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointe=
rs.html

> - perf should be complied with BUILD_BPF_SKEL=3D1:
>   Warning: option `off-cpu' is being ignored because no BUILD_BPF_SKEL=3D=
1

We've made this the default build behavior but probably a bigger issue
is that generally to have permissions you need to run as root.

> - off-cpu, on-cpu samples are not on the same result page.
>   (I guess Howard has improve this, not tried his patches)
>
> I have tried to collect the off-cpu sample same as on-cpu sample with the=
 help
> of  kernel/events/core.c. We will get one off-cpu sample from the target =
task
> sched-out to sched-in. Or we can say off-cpu samples are not dependent on
> frequency provided by the user to perf record.
>
> I am also worried about having so many samples if sched-in/out
> frequency is high.
> Thinking to merge samples if attributes are the same (i.e. stacktrace)
> and add the
> off-cpu period to previous samples with the same attribute.

Right, this would be useful to look at in the context of Howard's
patches. The proposal in his changes are that short off-cpu times are
aggregated in a BPF map and dumped at the end of perf record - this
matches the existing perf record off-CPU behavior. Longer off-CPU
times, where long is open for debate and will be a parameter (perhaps
100 microseconds) and cause a sample to be created. BPF programs
create BPF output events, Howard's last patch series would rewrite the
events in perf record to be off-CPU samples. At the last office hours
it was discussed that we should dump the BPF output events directly,
to keep perf record overhead minimal, and add the ability to rewrite
into samples in tools like perf report, etc.

Thanks,
Ian

> -Ajay
>
> > Thanks,
> > Ian
> >
> > > Ajay Kaher (3):
> > >   perf/core: add logic to collect off-cpu sample
> > >   perf/record: add options --off-cpu-kernel
> > >   perf/report: add off-cpu samples
> > >
> > >  include/linux/perf_event.h            | 16 ++++++++++++++
> > >  include/uapi/linux/perf_event.h       |  3 ++-
> > >  kernel/events/core.c                  | 27 ++++++++++++++++++-----
> > >  tools/include/uapi/linux/perf_event.h |  3 ++-
> > >  tools/perf/builtin-record.c           |  2 ++
> > >  tools/perf/util/events_stats.h        |  2 ++
> > >  tools/perf/util/evsel.c               |  4 ++++
> > >  tools/perf/util/hist.c                | 31 ++++++++++++++++++++++++-=
--
> > >  tools/perf/util/hist.h                |  1 +
> > >  tools/perf/util/record.h              |  1 +
> > >  tools/perf/util/sample.h              |  1 +
> > >  11 files changed, 81 insertions(+), 10 deletions(-)
> > >
> > > --
> > > 2.39.0
> > >


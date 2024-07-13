Return-Path: <linux-kernel+bounces-251389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1E993044F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3491F22B45
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC73D3B3;
	Sat, 13 Jul 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S3bhHixt"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9663A1B6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856588; cv=none; b=PkvoXRGnGv6gw9zyXzegDzrFAy7P0FMsLZfbDIzD0VgqS8ELwK5ayFcItKovo3SzFX9pLuCpJh6wEWlYF8v0zEqm/1kDdFRDMrzzYmwXusr90mt8BQk4O3V8QPPASS27VyXgFBpQX0EM2oRAvAE6d4JBuiqcpmvk5CTb3AJQxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856588; c=relaxed/simple;
	bh=ZWqEdHgcz+4uudQU/sHPR34TpX60s9IZRz8RQ5VkdOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6y2yRVlnc8Zz5YYbRX43VinjSTDIgbhdDqSW5u+sf2i9LsACZkh7brWax7gytbv0fEu/1ItFIt7t5dPBivQ3IEc9yV/qAxei9E9c8seYq9ZxXn0JALMriz0nx481YsZjs5b5QlXcXGRnynihuS19Rtg/zQ/VcLnhQYwolMHGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S3bhHixt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea1a69624so2885108e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720856584; x=1721461384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0ss37jV9lTaJ6DYS3+pxIxXoElnFV986o3Klbi+DcM=;
        b=S3bhHixtFcylGimLnpRTNG63sIKqHOXKuh5E06TUQAk6BXRHojLkUhWCbT9v7FCMCu
         V01oFVg+A3dI8TnZJRLYF02hZAhz7nJ6oNchCbUOv5ULG6Vf5huN8tPXrWr4KLU4xTWZ
         CuDl8OF5GhPxEXavStcv3+p/AazDOMPmeEqa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720856584; x=1721461384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0ss37jV9lTaJ6DYS3+pxIxXoElnFV986o3Klbi+DcM=;
        b=fpMlTugwYCd1Czh2+M/WJheRANXXWkjWsWHskdjqvxeyHnZBayTe3J8fa1lAXpxS6j
         WyulVhe6AgSEW4E8KCHMel4gM0V1E11QBu3cR/COXOYdseqcSY+fzCPhr2t7lukt61Uf
         N4nUj5exAmajDTVBMf0YNydHKeCp5agH0T9+lJeocMexeXodGrT6npfh2GJVyE32dlEh
         KLnwGT+YWORoXmjVvVhQeiPfIB4H41d9PPhIvok5/Nevbs5Dd4bHpQqUBxNNZ6b175Kj
         d4uYWMuK2qV8gM6zGgWY8WsO2WfcvD3MYQ4AGAhSi44Yr9eqgiYxuVZ/Ax6yyb65fbAP
         GNjA==
X-Forwarded-Encrypted: i=1; AJvYcCXFfnSpnKZWj5+MvEIkMExQJ+scjGzqaWVU2844XDZvNjoP4jUO3tfw0Dh/7ii0KOBOc+uNaONAmKXiFZSXTNhcWYT8kRsUWaQnS9+r
X-Gm-Message-State: AOJu0YyiSUVBuic55umTPjbcko/NGxBif9+GwgZNSEEBgMk5HMVHv8sr
	hVHgYCgAO+QRPbXE1gm2wiR962WHhByakAdQzHc6CWhWbtYXUhYytJf3N0DfsSygpkHM56GK5Co
	gg0RIQS6mI/cprc8Ix4VgJQXPTtgzK++qp1yQ
X-Google-Smtp-Source: AGHT+IFPi274+tFWUtAjuaJOoWwBzCxKxVXq5jOkTPqm/Wd71CXr/zbc+FsAJ1xNZz/WbG8M1xvWmwzFo3GKXUEW99U=
X-Received: by 2002:ac2:5972:0:b0:52e:be50:9c55 with SMTP id
 2adb3069b0e04-52ebe509db8mr5677138e87.52.1720856583990; Sat, 13 Jul 2024
 00:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com> <CAP-5=fVwZfV+gNWcmEtRnkOtrvozMdXPVrZ37COHkf4BX1VPgw@mail.gmail.com>
In-Reply-To: <CAP-5=fVwZfV+gNWcmEtRnkOtrvozMdXPVrZ37COHkf4BX1VPgw@mail.gmail.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Sat, 13 Jul 2024 13:12:52 +0530
Message-ID: <CAD2QZ9ZLHQ62d5CDpf14DkrWFs_FggRMdqzGFz3qsmF_vmS00Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] perf: add logic to collect off-cpu samples
To: Ian Rogers <irogers@google.com>
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

On Fri, Jul 12, 2024 at 3:28=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jul 11, 2024 at 5:16=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.c=
om> wrote:
> >
> > Add --off-cpu-kernel option to capture off-cpu sample alongwith on-cpu
> > samples.
> >
> > off-cpu samples represent time spent by task when it was on wait queue
> > (schedule out to waiting for events, blocked on I/O, locks, timers,
> > paging/swapping, etc)
> >
> > Refer following links for more details:
> > https://lpc.events/event/17/contributions/1556/
> > https://www.youtube.com/watch?v=3DsF2faKGRnjs
>
> Hi Ajay,
>
> I wonder if Howard's improvements (not landed) for `perf record
> --off-cpu` would solve this problem for you?
> https://lore.kernel.org/lkml/20240424024805.144759-1-howardchu95@gmail.co=
m/
> Or is that approach problematic due to the use of BPF?
>

Thanks Ian for your response and sharing Howard's improvements.

Yes, perf --off-cpu is based upon BPF and having following restrictions:

- target binary should be compiled with frame pointer, same mentioned
  in tools/perf/Documentation/perf-record.txt:
  =EF=BB=BFNote that BPF can collect stack traces using frame pointer ("fp"=
) only,
  as of now. So the applications built without the frame pointer might see
  bogus addresses.

- perf should be complied with BUILD_BPF_SKEL=3D1:
  Warning: option `off-cpu' is being ignored because no BUILD_BPF_SKEL=3D1

- off-cpu, on-cpu samples are not on the same result page.
  (I guess Howard has improve this, not tried his patches)

I have tried to collect the off-cpu sample same as on-cpu sample with the h=
elp
of  kernel/events/core.c. We will get one off-cpu sample from the target ta=
sk
sched-out to sched-in. Or we can say off-cpu samples are not dependent on
frequency provided by the user to perf record.

I am also worried about having so many samples if sched-in/out
frequency is high.
Thinking to merge samples if attributes are the same (i.e. stacktrace)
and add the
off-cpu period to previous samples with the same attribute.

-Ajay

> Thanks,
> Ian
>
> > Ajay Kaher (3):
> >   perf/core: add logic to collect off-cpu sample
> >   perf/record: add options --off-cpu-kernel
> >   perf/report: add off-cpu samples
> >
> >  include/linux/perf_event.h            | 16 ++++++++++++++
> >  include/uapi/linux/perf_event.h       |  3 ++-
> >  kernel/events/core.c                  | 27 ++++++++++++++++++-----
> >  tools/include/uapi/linux/perf_event.h |  3 ++-
> >  tools/perf/builtin-record.c           |  2 ++
> >  tools/perf/util/events_stats.h        |  2 ++
> >  tools/perf/util/evsel.c               |  4 ++++
> >  tools/perf/util/hist.c                | 31 ++++++++++++++++++++++++---
> >  tools/perf/util/hist.h                |  1 +
> >  tools/perf/util/record.h              |  1 +
> >  tools/perf/util/sample.h              |  1 +
> >  11 files changed, 81 insertions(+), 10 deletions(-)
> >
> > --
> > 2.39.0
> >


Return-Path: <linux-kernel+bounces-204771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31378FF375
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08B9B26088
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F719884A;
	Thu,  6 Jun 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mt+E5LxF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0823224D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693732; cv=none; b=rtuC1yBTxKup07eLXXudx0CY21XL3Aw7WNpfAmGfG2RI1N7hj/wHEiXEuqCw7SSBHAAiXzqmVoPm1BbIMrsg+Kdy5sWp5w4Xe/yfLKLilqoHmbackIqNDfl/DyL+IPTFjbyJNP234zrhgtQSBEFj0bRURt8A2t4VxYehJhA9894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693732; c=relaxed/simple;
	bh=jqdEnsUh5f5u/kzCtZ3UfwvJy3TI4NEJlzUYx8ZL95o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH/oKe0wcYbIxiO8hcEXcE3D8/dq5/PDwu7ble9c2gyCtR4LJKH9ydzxP6GGPM5AHXbM2IcuHws5nLWBtRPx4Y92yCyIqilKtE7XXQkPWY7obp4jX1L0X8BAO/tFeOM0JyRp0/LZOeFqQk1H4AMlhzFX8O8z245oSRB+JGP3e9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mt+E5LxF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4215b888eabso2945e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717693729; x=1718298529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/LLxJUqKq1bvt/TMLmBZz7OUOIkMeU81CHHfdNKgg0=;
        b=mt+E5LxFWY1QzI4ndrmjlatObt+T8LdhaF9nsY731GeyYWsJZNPlkjgpMuWbfUPkAD
         z6GWHmQR5AjKOrcLkIQN3Q6/IYgrKO1lHvex/qjSUk876LhkzhOKVnnCKb5C3RWG7dCw
         qByKkvJ+cpJav7LuRK8XACyNHxawVfnqvEoXgCRJu3FsUeYmIPo1u95jX2Y7OUCYAQsk
         1REEUjYEeIOsqUssR0Ay5alu1imuJhGwudm3bv9ZzjbVWg8EYMstli1HR4NPcC3yEZVp
         7g8eOgQq4dztM2T5Gu/GV0d6kI9hhtVTLEOnKTlcuu2lWSm8nW5nN4oJXl95owNdqBFd
         +kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693729; x=1718298529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/LLxJUqKq1bvt/TMLmBZz7OUOIkMeU81CHHfdNKgg0=;
        b=I4JiHM3Qd25n/hY3sXcDkO0s9pasOq8t1iRO1VxZYrPMbIc4ktAfqX0zIlf10hZTHu
         Bw2LsKWA0lyw9PVi4dweGvSJGQbR10CNzLFcjx6G1yEShd1vdVKyMuOpFqREF35zfk8e
         mc9zzbohqrGUhKt/gfHjFIYYaUr0rAglqpQ8NCAqTpLzxJWT1DQkTqt+4kVowbc9Nman
         6+wwLeUgq51Y5jv6pR46y6DpvuPZvboMVJIF8TlpQgNeTMkKB60XkzLfdSK86Ahex+F4
         95rn7lI+1c+1qFIcoRqUwAElbyHUwnY59DvQ4VAD/uZsUywZxkBA0TmGI2m/hzmmalVv
         O2zw==
X-Forwarded-Encrypted: i=1; AJvYcCXayOBtE5805fRoDXd2Y2TFnD0e1kh/xnKqmCycnnLc204/Fo5QXyw+UCIGsYt6qX52MzafcaSFloAHNIp6xJTxQRq1OZpGeg7rAgJl
X-Gm-Message-State: AOJu0YwT3FcR7FIAdwfYP0XMmBcU8QHdbiloDM/SAmeYybrknyC0LpvG
	d93jMV4TMqMjc+vQbGFHVCiOpchWB0LHicZTaD7G2BXFi6D2yHyAcafSgVPvgS1lSsT4EgNcXld
	WHAgXRdiO7hVEP7VcmoQRAhxhaTIJ13yPt5NW
X-Google-Smtp-Source: AGHT+IGzT+E1H4a1K/U7H5b2gaV84vGydj02geZe0QgGUYltG+Tz1VUCThgVAr8woy8ZYveQdZGYXKelcqo8teX5udI=
X-Received: by 2002:a05:600c:3b1c:b0:41b:e55c:8dca with SMTP id
 5b1f17b1804b1-4215c34b2f8mr2016725e9.7.1717693728830; Thu, 06 Jun 2024
 10:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPqkBQ3LQ_dXQSQVSrriinvSSXm2fHx4yOms=jRsa2WaXSsog@mail.gmail.com>
 <4622060b-b758-4629-9aa4-cc8334111be0@linux.intel.com>
In-Reply-To: <4622060b-b758-4629-9aa4-cc8334111be0@linux.intel.com>
From: Stephane Eranian <eranian@google.com>
Date: Thu, 6 Jun 2024 10:08:34 -0700
Message-ID: <CABPqkBR4CGx9EY4nMmnRT1Uuw0p5iefnFZa0hphh+HBBYqQ71A@mail.gmail.com>
Subject: Re: [RFC] perf_events: exclude_guest impact on time_enabled/time_running
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	"Narayan, Ananth" <ananth.narayan@amd.com>, "Bangoria, Ravikumar" <ravi.bangoria@amd.com>, 
	Namhyung Kim <namhyung@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 8:48=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-06-06 3:57 a.m., Stephane Eranian wrote:
> > Hi Peter,
> >
> > In the context of the new vPMU passthru patch series, we have to look
> > closer at the definition and implementation of the exclude_guest
> > filter in the perf_event_attr structure. This filter has been in the
> > kernel for many years. See patch:
> > https://lore.kernel.org/all/20240506053020.3911940-8-mizhang@google.com=
/
> >
> > The presumed  definition of the filter is that the user does not want
> > the event to count while the processor is running in guest mode (i.e.,
> > inside the virtual machine guest OS or guest user code).
> >
> > The perf tool sets is by default on all core PMU events:
> > $ perf stat -vv -e cycles sleep 0
> > ------------------------------------------------------------
> > perf_event_attr:
> >   size                             112
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> >
> > In the kernel, the way this is treated differs between AMD and Intel be=
cause AMD
> > does provide a hardware filter for guest vs. host in the PMU counters
> > whereas Intel
> > does not. For the latter, the  kernel simply disables the event in the
> > hardware counters,
> > i.e., the event is not descheduled.  Both approaches produce pretty
> > much the same
> > desired effect, the event is not counted while in guest mode.
> >
> > The issue I would like to raise has to do with the effects on
> > time_enabled and time_running
> > for exclude_guest=3D1 events.
> >
> > Given the event is not scheduled out while in guest mode, even though
> > it is stopped, both time_enabled and time_running continue ticking
> > while in guest mode.  If a measurement is 10s
> > long but only 5s are in non-guest mode, then time_enabled=3D10s,
> > time_running=3D10s. The count
> > represents 10s worth of non guest mode, of which only 5s were really
> > actively monitoring, but
> > the user has no way of determining this.
>
>
> For the latest design/implementation, only the exclude_guest=3D1 host
> event can be successfully created for the case.
> The end user should not expect that anything is collected in the guest
> mode. So both the time_enabled and the time_running will be 5s.
>
> >
> > If we look at vPMU passthru, the host event must have exclude_guest=3D1
> > to avoid going into
> > an error state on context switch to the vCPU thread (with vPMU
> > enabled).
>
> That's the design in V1. There is no error state anymore in V2 and later
> as suggested by Sean.
> https://lore.kernel.org/all/ZhmIrQQVgblrhCZs@google.com/
>
> The VM cannot be created if there are host events with exclude_guest=3D0.
> If a VM has been created, user cannot create an event with
> exclude_guest=3D0. So nothing will be moved to an error state on context
> switch to the vCPU thread.
>
Ok, that's new.

> > But this time,
> > the event is scheduled out, that means that time_enabled keeps
> > counting, but time_running
> > stops. On context switch back in, the host event is scheduled again
> > and time_running restarts
> > ticking. For a 10s measurement, where 5s here in the guest, the event
> > will come out with
> > time_enabled=3D10s, time_running=3D5s, and the tool will scale it up
> > because it thinks the event
> > was multiplexed, when in fact it was not. This is not the intended
> > outcome here. The tool should
> > not scale the count, it was not multiplexed, it was descheduled
> > because the filter forced it out.
> > Note that if the event had been multiplexed while running on the host,
> > then the scaling would be
> > appropriate.
>
> The scaling will not happen, since both time_enabled and time_running
> should be the same when there are enough counter resources.
>
If an event with exclude_guest=3D1 is sched out (event_sched_out), time_ena=
bled
will keep running but time_running will stop. Because the code assumes
it is stopped
because of multiplexing. However, here this is not the case. The event
is stopped because
the CPU is entering an execution domain that is excluded for the event.
Unless you've modified the event_sched_out() code or added code to
patch up time_running
I don't see how they could be equal. The alternative, as you suggest,
is to stop time_enabled.
But usually time_enabled is controlled by ENABLE/DISABLE which are
different from
event_sched_out() and event_sched_in().


> >
> > In that case, I argue, time_running should be updated to cover the
> > time the event was not running. That would bring us back to the case I
> > was describing earlier.
> >
> > It boils down to the exact definition of exclude_guest and expected
> > impact on time_enabled
> > and time_running. Then, with or without vPMU passthru, we can fix the
> > kernel to ensure a
> > uniform behavior.
>
> I think the time_enabled should be the one that has a controversial
> definition.
> Should the time in the guest mode count as the enabled time for an host
> event that explicitly sets the exclude_guest=3D1?
>
> I think the answer is NO. So I implemented it in the code.
>
> >
> > What are your thoughts on this problem?
> >
>
> Peter, please share your thoughts. We want to make sure the design is on
> the right track.
>
> Thanks,
> Kan


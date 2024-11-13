Return-Path: <linux-kernel+bounces-407654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC59C70A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A96283C31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8A2003D8;
	Wed, 13 Nov 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeCZdQZ9"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE61E0E13
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504533; cv=none; b=hrPbitLfOXwt/nJBop1zTE3WncToRFE42ISIozoXNOUl8cQNuEpeKpriXy/yxxTa6sPFySZ9LQC2JPX7ha+40qr4oASZt9umzWpb6WtGhWeGosq16wg4nRwYsRHb3dvCGU3Ev8IDrX/9il4kdSr1iGHtJ3zbGSkGndUGaO1ocY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504533; c=relaxed/simple;
	bh=8H/EBTWQ6GIQhNnk8qqpttV0fZ6ci9gtHHzdigT6ygk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYc6dnzFrN1xtrYzvD2gke+meGDIM/8MyfG3nC5vTPi130y3hzE0kVMFmeEPEIcLybjj+nwOgj5lQyC5qPVw1vzOHhFMyIknhXaxEX0V2iQ6YhWDLCK0b3Mu29anXnD23P/y+S3gXzxWO0zgDUZclyf9TJ2HxhpL5qbLgbRJDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aeCZdQZ9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cf04f75e1aso8198117a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731504529; x=1732109329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pxUWTGHp3LlGlPEHcF4gnsn2X1MJ/L5Ga7wnn5OsJo=;
        b=aeCZdQZ99vEuOK6FZWjNkZao63xHK0nHBy5GF101s+OIaWc7YKltnnCbC3TjMH9f4S
         2y7tSUDrYAYg9zQFCeH497cwl4GG3T7H1KuUWInTZELOmVBeacXpTpaXJu1NQt1pshO/
         oH/YR0c1c2lKY61ibIRSL53+5CZwZTx6kJ/QAcrrPV4iEBe2NqQFuvdnFyvegXFhG3x4
         wwMv2uJ2KhHz3B2VfvxkoITpLABb8pnK5J34HjFlqTDPlTZA1nfBmHt9KLpyz/X/GyEe
         qWE5HA/ZG2fLt6ZNdRMnp3Msr5bq+EyzkwhXxKtk85kjni80Ul+UVUIHP3D8ihr+Va9f
         0R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504529; x=1732109329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pxUWTGHp3LlGlPEHcF4gnsn2X1MJ/L5Ga7wnn5OsJo=;
        b=krV1/spuCNJb7wyINWRvI8Trz57gULSsDrhY7OSeXa33/GcNorJ/9nWq+58FJCqZZq
         ZOHv6Gct4dnSZnywfZPHUZnJNyVMEtWNHjgwjhmXirycN7Ptx0ZTs7rss4SWrvQSGQIC
         3VRCh+NEV3UefhkUYeC/Lg5/yD7pdnkXnE6kIefxN+6ozlqvQ5xxi9oCYD6RnRlWElWs
         +3uJlaFKHUBDzo/Egm46Q4bepjN+TJI6+33rJYVQUFlzUVIKvDv9FyC+n3tVn8hzM1gb
         eJ8jaHjU0gUBhdh3rR58wEWn+GIXBoNciL+I+s4Tc9owH5yawLBejFhtfmGR6x13pDqo
         2tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJRR8uOLem/bTjdnY3c6Yb7ng63VgPdd7B46S2q2dVlYpph0GjRDkrlSMFoh3hV4BNZ/1Ens+Vh3KeB8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwOVC3IphtUn5s+kZ0gJl3IPPujojvERN9GGrycC1oy7Dh6V9
	FdcgDhoywp1CmK/syvhw7q7MfrlXYrjuoBmoELDDJdT298Zna7MifnrYfsCNa/LwLBqr2SCir72
	jPM7xDtjFpzPLNuBHJGS94J4HaiccYcbmlpXt
X-Google-Smtp-Source: AGHT+IHeJ7dJeqnM+QjUkv5FQBx1dyY5bLaRqX2EOaowvb87uRAvt5s+XYj9ChGLZDv9wqQDwHC80AceKmSnPn0YZTU=
X-Received: by 2002:a17:907:8693:b0:a9e:211f:7dc6 with SMTP id
 a640c23a62f3a-a9eefe9baf3mr1761486766b.8.1731504529338; Wed, 13 Nov 2024
 05:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com> <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com> <34fd8713-3430-4e27-a2c2-fd8839f90f5a@intel.com>
In-Reply-To: <34fd8713-3430-4e27-a2c2-fd8839f90f5a@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 13 Nov 2024 14:28:38 +0100
Message-ID: <CALPaoCjCWZ4ZYfwooFEzMn15jJM7s9Rfq83YhorOGUD=1GdSyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter reads
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, eranian@google.com, hpa@zytor.com, 
	james.morse@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	nert.pinx@gmail.com, tan.shaopeng@fujitsu.com, tglx@linutronix.de, 
	tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, Nov 7, 2024 at 8:15=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 11/7/24 6:26 AM, Peter Newman wrote:
> > On Thu, Nov 7, 2024 at 12:01=E2=80=AFPM Peter Newman <peternewman@googl=
e.com> wrote:
> >>

> >> Tony had prototyped an MBM rate event[1], which cached a MBps value
> >> per group/domain produced by the overflow workers. If the workers
> >> produce the mbps samples immediately after directly reading the
> >> counters, then this should be the best case in terms of precision and
> >> introduce very little additional system overhead. Also, userspace
> >> reading a rate sample that's 1 second old would be a lot less harmful
> >> than performing an MBps calculation from a count sample that's 1
> >> second old.
>
> I looked at that implementation. Please do note that the implementation
> appears to be a PoC that does not handle the corner cases where issues ma=
y
> arise. For example, when it reads the event values in the overflow handle=
r
> the rate is updated even if there was an error during the counter read.
> The moment a counter read encounters an error it impacts the measured
> rate so this will need more thought.
>
> >> Perhaps combining the per-second bandwidth rate cache with a
> >> per-domain file for each MBM event to aggregate the data for all
> >> groups will be the optimally-performing solution?
>
> I do not see a problem with exposing a per-domain file for each MBM event
> that aggregates the data of all groups. For best accuracy I expect that
> this file will be created on demand, querying hardware counters at the ti=
me
> user space makes the request. This may indeed result in output like below
> (naming used is just a sample for this discussion):
>
>          # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_01
>            <rdtgroup nameA> <MBM total count>
>            <rdtgroup nameB> <MBM total count>
>            <rdtgroup nameC> Error
>            <rdtgroup nameD> Unavailable
>            <rdtgroup nameE> Unassigned
>            ...
>
> As I understand from your earlier description this essentially moves the
> counter reading work from a user space thread to the kernel. There are
> options to do this work, most disruptive can be done with a
> smp_call_function_any() to read all the domain's counters from a CPU
> in the domain without any preemption, less disruptive can be done
> with smp_call_on_cpu(). Some cond_resched() could be included if
> the number of events needing to be read starts impacting other parts of
> the kernel. You already indicated that reading the counters from user spa=
ce
> takes 488usec, which is very far from what will trigger the softlockup
> detector though.
>
> > Factoring ABMC into this, we'd have to decide the interval at which
> > we're comfortable with cycling the available event counters through
> > the group list in order to get valid MBps samples for every group
> > often enough.
> >
> > A counter will have to stay assigned long enough to get two valid
> > counts before an MBps value can be reported. If the regular MBps
> > samples is what we want, maybe we just want a mode where the overflow
> > workers would also drive the counter assignments too in order to
> > produce regular samples from all groups.
>
> The assignable counter implementation currently depends on user space
> assigning counters. In this design the events that do not have counters
> assigned return "Unassigned". The "rate" value can also return
> "Unassigned" in this existing design. "Unassigned" is one scenario that
> needs to be handled, there is also hardware errors and MSR returning
> "Unavailable".
>
> We can surely consider a new mode that does not allow user space to assig=
n
> counters but instead lets resctrl manage counter assignments to support
> rate events when assignable counters are supported.
>
> I see a couple of features being discussed in parallel:
> - A new per-domain file for each MBM event that aggregates the data of al=
l groups.
> - A new "rate" event built on top of user assigned counters.
> - A new "rate" event built on top of resctrl assigned counters.
>
> Which best support the use case you have in mind?

After discussing with my users, it sounds like "all of the above".

They like the idea of resctrl automatically dealing with counter
assignments for them, but they would also like to retain enough
control to provide higher resolution data for groups that concern them
more. The auto-assignment is nice in that they would get reliable
bandwidth numbers on AMD with very little development effort and the
assigning work will be done very efficiently, but eventually they will
want more control.

They also asked whether they would be able to switch between
resctrl-assigned and user-assigned at runtime. I think the importance
of this would depend on how efficient the mbm_assign_control interface
ends up being. If it will necessarily result in floods of IPIs when
cycling counters on a large system, they will be eager to not use it
whenever they can avoid it.

The rate assignment events are easier to deal with because they can
simply be retrieved from memory without the caller needing to worry
about what domain they're reading from, so I don't believe we will
ever want to deal with cached count values paired with timestamps. On
systems with assignable counters, I don't know how much of a problem
the varying update rate will be. The aggregation files reading from
memory are cheap to poll every second, so I don't know how big of an
issue it is for most of the groups to report some sort of N/A-value
for bandwidth most of the time. They won't have any difficulty
remembering how long ago they last saw a valid mbps value because
they're already histogramming all the metrics they watch.

Thanks,
-Peter


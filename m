Return-Path: <linux-kernel+bounces-399706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857E29C0326
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FA0B22972
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CD1EF92F;
	Thu,  7 Nov 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRK8+STn"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A71DDC02
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977326; cv=none; b=YCIpENuBex8It6wAOrc/+XtwBoEkNewMSNEUrJ5s+KMxhf824HaqWMn3WjiV9IHdL9YcNSaRX3v99fD+Kj1X+dVsCuzEp0ZNrUCz7LrCahdmr3bmGbAu7PcIT9lNYYMsCcjeErc9oZwb+8bS/qU6M7qtxtkYXrvey2wLJlfJ63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977326; c=relaxed/simple;
	bh=oIskbHEwC/AB9yJXIt4ToGI3yzEzhHUSztH0FHGtHQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpS0umVCEmGzoWwt7OAh/CNeVgIgfX1oXpgc/xmL9icTo5ogsIlom3/0X/b4K3WEAFiyanAP7VqVF9FClIYroHc5kW2K6N5gtBZIEuE0h1fbxWLF6D7hWwLGwqZfRyumkzUH7wbTh14p6yON+BjtSHLV8U71/OkrWIBKmYNvGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRK8+STn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99cc265e0aso120716666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730977323; x=1731582123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOT4Womtqf5G1oJZS+rchCTYrEEmxwIqsnMwVYVE/0I=;
        b=qRK8+STnCobfIqpo4YbjWUJOHdAHMGFwO/7dTFZKIoV7zNERz4p56E3sMpJbEU6oZ4
         tu9buaeyix/Y66RsfHD5dlSIz8TEeIM60gGf5qiz8cNhkSR74CklCqPYCT+R7SL/XN0E
         dekRCjaNI17uC4GvvyBwThw7D6De8Rz7L0yAtBZ13hlqMi1urpVGJOsfodENUgWtve54
         jwowiEY4ZkTjvl5LYwfAb0scMFiaecpIgGaUOHOWKRi2V5NGxkc6HRKwQhERamFlBJlt
         Smfu4UB6PBR3vcCQvScENobYv38l56rsy99TQW2qULo821FzSEe5u4DMizueW2FPP/8v
         uohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977323; x=1731582123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOT4Womtqf5G1oJZS+rchCTYrEEmxwIqsnMwVYVE/0I=;
        b=MXRMIKJw86aj8BTwLoy4pJw2C6khG575cuGzHi1zHjGqrYGsPvTzpTEDThpzQB2nqW
         VntjkrPXbvxyyicnFzVJ8M6GOZMl6kDyrnmyA8b9e+Yrvj7BkR68udnw60crqE6PVIFv
         5DkFi9YKNLo9ChpCsk5hyVos4dQer3/5R2q1dVLe0wDE3rw61jyVN8ias9+JWtO6Rsmd
         PHLSBhjnyiOVyl8Pk/TL1I+d/lLSZfXT1Slaoeqzy++FZvHhUwEnHC63d+nwDhlcoPv1
         tH8XdFOKdLXGunNw4e7kNdVz+TAlqKPBlEKI2JvVvq/hTkw+q1Vfk4AJdv33tHNqh0p9
         MMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVlkjhNZPc/waI7zwlTNf4rOo+BpkFnHojP0/HrrPc8kv4756iWKIWGnTt/+ytgfgIvzLidfWuM0ZN33vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYSLy0CE5cfTrShlWeiJ7TcCILf3XPCg+6m/bm+nfwcHzxCJK
	0shIMALCsDPfDRk8NHGNTxMLq7Y+NYJHcAy9IvmaJBatZUYHzc1w2ZCelFgOI6v+I7ZGimM8RO5
	MCcIJGYKa5dEY6m2FLgsOEpG2RKzprCuPpBmk
X-Google-Smtp-Source: AGHT+IFfsTA7cfS/7pqYhrkeetyiEp8/4LUDcw1HLD0sgEDeZVErCoF8Cm16TrfUx1asPey1XuGW4cS+7crqJggqI0k=
X-Received: by 2002:a17:907:7d88:b0:a9a:c57f:9634 with SMTP id
 a640c23a62f3a-a9de61d1a97mr4506547266b.42.1730977322667; Thu, 07 Nov 2024
 03:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com> <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
In-Reply-To: <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 7 Nov 2024 12:01:50 +0100
Message-ID: <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 2:10=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 11/6/24 7:43 AM, Peter Newman wrote:
> > Performance-conscious users may use threads bound to CPUs within a
> > specific monitoring domain to ensure that all bandwidth counters can be
> > read efficiently. The hardware counters are only accessible to CPUs
> > within the domain, so requests from CPUs outside the domain are
> > forwarded to a kernel worker or IPI handler, incurring a substantial
> > performance penalty on each read.  Recently, this penalty was observed
> > to be paid by local reads as well.
> >
> > To support blocking implementations of resctrl_arch_rmid_read(),
> > mon_event_read() switched to smp_call_on_cpu() in most cases to read
> > event counters using a kernel worker thread. Unlike
> > smp_call_function_any(), which optimizes to a local function call when
> > the calling CPU is in the target cpumask, smp_call_on_cpu() queues the
> > work unconditionally.
> >
> > Introduce resctrl_arch_event_read_blocks() to allow the implementation
> > to indicate whether reading a particular event counter blocks. Use this
> > to limit the usage of smp_call_on_cpu() to only the counters where it i=
s
> > actually needed. This reverts to the previous behavior of always using
> > smp_call_function_any() for all x86 implementations.
> >
> > This is significant when supporting configurations such as a dual-socke=
t
> > AMD Zen2, with 32 L3 monitoring domains and 256 RMIDs. To read both MBM
> > counters for all groups on all domains requires 32768 (32*256*2) counte=
r
> > reads. The resolution of global, per-group MBM data which can be
> > provided is therefore sensitive to the cost of each counter read.
> > Furthermore, redirecting this much work to IPI handlers or worker
> > threads at a regular interval is disruptive to the present workload.
> >
> > The test program fastcat, which was introduced in an earlier path, was
> > used to simulate the impact of this change on an optimized event
> > counter-reading procedure. The goal is to maximize the frequency at
> > which MBM counters can be dumped, so the benchmark determines the cost
> > of an additional global MBM counter sample.
> >
> > The total number of cycles needed to read all local and total MBM
>
> This optimization proposal aims to reduce the number of cycles used by
> the code that is eventually called after user space reads from a file.
> As you already noted, this causes a regression in this exact optimization=
 area
> in one out of the four scenarios tested.
>
> As I understand this is understood to be a slow path and there are many t=
hings
> that can impact the number of cycles such a query takes.
>
> I wonder if we could perhaps instead change focus from shaving cycles (af=
ter
> obtaining a mutex ... ) from a slow path to understand what the use case
> is so that resctrl could perhaps obtain a better interface that supports =
the
> use case better overall?

Sounds great.

>
> > counters for a large number of monitoring groups was collected using th=
e
> > perf tool. The average over 100 iterations is given, with a 1-second
> > sleep between iterations to better represent the intended use case. The
> > test was run bound to the CPUs of a single MBM domain, once targeting
> > counters in the local domain and again for counters in a remote domain.
>
> This sounds as though user space is essentially duplicating what the
> MBM overflow handler currently does, which is to run a worker in each dom=
ain
> to collect MBM data every second from every RMID for both MBM events.
>
> * What are the requirements of this use case?

Accurate, per-RMID MBps data, ideally at 1-second resolution if the
overhead can be tolerable.

> * Is there some benefit to user space in reading individual counters?

The interface is available today and can retrieve the data with
somewhat acceptable performance. After applying this change (or
selecting a kernel version before the MPAM changes), call-graph
profiling showed that the remaining overhead of reading one counter at
a time from userspace on AMD Zen2 was around 20%, spacing each series
of 250 local reads by 1 second.

With the 1.22M figure I quoted below for a single domain from
userspace, this comes out to 488 usec at 2.5 Ghz, which is manageable.
Even if userspace serializes all of its per-domain reads manually to
avoid contention on the global rdtgroup_mutex, the results should be
consistent as long as the domains are always serialized in the same
order.

(apologies that my figures focus on AMD, but its high MBM domain
counts make it the most sensitive to read performance)

Also, if all of the counter-reading work is performed directly by the
thread, the time spent collecting the information is easier to
attribute to the management software rather than appearing as an
increase in kernel overhead.

Clearly not optimal, but an acceptable baseline.

> * Would it perhaps be acceptable to provide user space with a cached snap=
shot
>   of all the MBM counters in a single query?
>
> User space can use a single read to obtain values of an event for all RMI=
Ds
> on a domain without a single IPI if the architectural state from the over=
flow handler
> is exposed. It could also be possible to present data from all domains in=
 that single
> read.
>
> One complication I can think of is that data from the different domains m=
ay have
> been collected up to a second apart. Is this something this use case can =
tolerate?

This +/- 1-second drift would apply to the denominator of the mbps
calculation, so it could cause some very large errors. To produce
accurate mbps numbers from cached MBM count data, each sample would
need to be accompanied by a timestamp.

>
>
> For example,
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_00
>           <rdtgroup nameA> <MBM total count>
>           <rdtgroup nameB> <MBM total count>
>           ...
>
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
>           <rdtgroup nameA> <MBM total count>
>           <rdtgroup nameB> <MBM total count>
>           ...
>
> If the use case cannot tolerate data up to a second old then resctrl coul=
d add new files
> in info/L3_MON that will take the mutex once and trigger a *single* IPI t=
o a CPU
> from each domain and read all events sequentially (which is essentially m=
bm_overflow()).
>
> For example,
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_00
>           <rdtgroup nameA> <MBM total count>
>           <rdtgroup nameB> <MBM total count>
>           ...
>
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_01
>           <rdtgroup nameA> <MBM total count>
>           <rdtgroup nameB> <MBM total count>
>           ...
>
> As I understand an interface like above would be an improvement over
> what can be achieved by user space by optimizing queries to existing inte=
rface.
>

Yes, this is an option now that the ABMC work is establishing a naming
scheme for groups. It would also significantly cut down on the number
of open file descriptors needed.

Tony had prototyped an MBM rate event[1], which cached a MBps value
per group/domain produced by the overflow workers. If the workers
produce the mbps samples immediately after directly reading the
counters, then this should be the best case in terms of precision and
introduce very little additional system overhead. Also, userspace
reading a rate sample that's 1 second old would be a lot less harmful
than performing an MBps calculation from a count sample that's 1
second old.

Perhaps combining the per-second bandwidth rate cache with a
per-domain file for each MBM event to aggregate the data for all
groups will be the optimally-performing solution?

Thanks!
-Peter

[1] https://lore.kernel.org/lkml/20230620033702.33344-3-tony.luck@intel.com=
/#Z31fs:resctrl2:arch:x86:rdt_mbm_total_rate.c


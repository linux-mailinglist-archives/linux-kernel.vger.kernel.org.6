Return-Path: <linux-kernel+bounces-400090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79F9C08DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31C01C23AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210C4212647;
	Thu,  7 Nov 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ypYgPtxr"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6929CF4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989586; cv=none; b=gnSC5eJ6QEmTpiI67zTWtWvSt5LtWMNaD4N6F8TO8pikca8apkQM4gXfpLNpkwLkAeiSVUMP7L2s6Lr3gOjVCosUFT6GvJZNbAPQbGKvfKKoLYCmaTG1qXcE7IcdIslk7Rk5u5HVHKJz82KgclCC7qRnQ+FrEuhh3oXkAiqCu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989586; c=relaxed/simple;
	bh=59I8XjO6brwNhXGxVI0qpX6H95ZXehdOTHXqSGGrfP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqun+aKvEdrRt0+UDYJAoubebt7BmoFukzSEtvZ7qpY85oSJJsgEVhx4PvGzMwnUGCM/GZSJzEL0KvZlqlWtibW2YHw//1iAGnoS4N89/efMe08/XgRKFy0Zqr45WDS7pWPFUVOGBdrsmp6N7pO8mabg1FVpJPBLuLUqDNSAQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypYgPtxr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a628b68a7so162550466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730989583; x=1731594383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epOV4Xj8000kETtKaxePYFw40P63Eh1XIQxqxDLKC5Y=;
        b=ypYgPtxr0DyC8STK1dYDuhfl3bFD/dY2HFFT6l9zUaj0jNWdW4FL2sKQvTXSumXXSS
         0C8dpCpyGaurEmFWOwFYgCRFlVrKMoWnS4G3F2ghwxy8xi68GN6N2WDWuH7123djYg/E
         xMAxC9EJ5Pl5thMJPR9uIfS3nnlho1XMP4qyWJ6L2lNuI8fM0/VBT8r6eYtCD4/U96ED
         OCsRg262LEKhZb9KAn2ZGpdgpVOUffqZNzvSbPGt4TEZFHSLj8q28SLWIOgMGQYQ/hLj
         TJIQ1hk/6aHDmPeixD3ILWhtCqiC7rnz1S7M9ssjAQa/lqDe2KCGPgw2VrggANRuUczt
         VrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989583; x=1731594383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epOV4Xj8000kETtKaxePYFw40P63Eh1XIQxqxDLKC5Y=;
        b=t9EgpWjBFtctJXRUFimeUykNz4vpmFMi2JINuvunb+0/dkrkS7VY63eTDvCRUS3PKI
         HgrAIAZYssMd7u0pydaXBQfhZHQKMkh1weqvqFnECKzHyN6qikE59xZ4N+mQB2WynvJF
         ngUq3ivLV2RKdEdqB5FasRZnqdMc+lMUjbHUJqW7QTujFSs2AXtITNmmDYTMUIaY9jID
         21hkSb9VkYnUtjuwx85SZ8TulRLyKF7R9ci1fuJ+bfO/rGIUVR9HqfN36rie0rzuT+zl
         wXEW4OBxKlpb2leVeYlZjRahwcFPiec7mqwIA9qlXebDNOCHSL+tynoOANfYa/q3P7cS
         YcKw==
X-Forwarded-Encrypted: i=1; AJvYcCXpRRKxrf6OMSW0CkZWNxbxJzU5uY7seSqXp+u/qs86ff+jijoOGflhgVu38yHdPI8XI+KCozkXtK0rJh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzC3oSrKK6BupE6IqEEX1ztenm9B8RkJusZxOa2uUfCCmA3KPb
	R952OaICHY04/Q4EhH4Mi4ngqaED798AxtS6ebTIJEUz4NtQxtBjydDdqLeUpVAYbbrCvxlhdUz
	ljnAyXtLlGU+57x8/DjY/bn4qJoX2Kjt8DAct
X-Google-Smtp-Source: AGHT+IGJpKlI7+iXf07t7hLJGDLxtTSXqXcvJtodDvgdSlwZ8enag7tYbB4Td0rQtHYfSzS8g+aiB0I4ETmaKpp6QVU=
X-Received: by 2002:a17:907:948f:b0:a9e:3af1:eb1b with SMTP id
 a640c23a62f3a-a9e65506d11mr2138937466b.38.1730989582755; Thu, 07 Nov 2024
 06:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com> <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
In-Reply-To: <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 7 Nov 2024 15:26:11 +0100
Message-ID: <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter reads
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, eranian@google.com, hpa@zytor.com, 
	james.morse@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	nert.pinx@gmail.com, tan.shaopeng@fujitsu.com, tglx@linutronix.de, 
	tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:01=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
>
> Hi Reinette,
>
> On Thu, Nov 7, 2024 at 2:10=E2=80=AFAM Reinette Chatre <reinette.chatre@i=
ntel.com> wrote:

> > This sounds as though user space is essentially duplicating what the
> > MBM overflow handler currently does, which is to run a worker in each d=
omain
> > to collect MBM data every second from every RMID for both MBM events.
> >
> > * What are the requirements of this use case?
>
> Accurate, per-RMID MBps data, ideally at 1-second resolution if the
> overhead can be tolerable.

Sorry, forgot about the assignable counters issue...

On AMD we'll have to cycle the available event counters through the
groups in order to get valid bandwidth counts.

>
> > * Is there some benefit to user space in reading individual counters?
>
> The interface is available today and can retrieve the data with
> somewhat acceptable performance. After applying this change (or
> selecting a kernel version before the MPAM changes), call-graph
> profiling showed that the remaining overhead of reading one counter at
> a time from userspace on AMD Zen2 was around 20%, spacing each series
> of 250 local reads by 1 second.
>
> With the 1.22M figure I quoted below for a single domain from
> userspace, this comes out to 488 usec at 2.5 Ghz, which is manageable.
> Even if userspace serializes all of its per-domain reads manually to
> avoid contention on the global rdtgroup_mutex, the results should be
> consistent as long as the domains are always serialized in the same
> order.
>
> (apologies that my figures focus on AMD, but its high MBM domain
> counts make it the most sensitive to read performance)
>
> Also, if all of the counter-reading work is performed directly by the
> thread, the time spent collecting the information is easier to
> attribute to the management software rather than appearing as an
> increase in kernel overhead.
>
> Clearly not optimal, but an acceptable baseline.
>
> > * Would it perhaps be acceptable to provide user space with a cached sn=
apshot
> >   of all the MBM counters in a single query?
> >
> > User space can use a single read to obtain values of an event for all R=
MIDs
> > on a domain without a single IPI if the architectural state from the ov=
erflow handler
> > is exposed. It could also be possible to present data from all domains =
in that single
> > read.
> >
> > One complication I can think of is that data from the different domains=
 may have
> > been collected up to a second apart. Is this something this use case ca=
n tolerate?
>
> This +/- 1-second drift would apply to the denominator of the mbps
> calculation, so it could cause some very large errors. To produce
> accurate mbps numbers from cached MBM count data, each sample would
> need to be accompanied by a timestamp.
>
> >
> >
> > For example,
> >         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_=
00
> >           <rdtgroup nameA> <MBM total count>
> >           <rdtgroup nameB> <MBM total count>
> >           ...
> >
> >         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_=
01
> >           <rdtgroup nameA> <MBM total count>
> >           <rdtgroup nameB> <MBM total count>
> >           ...
> >
> > If the use case cannot tolerate data up to a second old then resctrl co=
uld add new files
> > in info/L3_MON that will take the mutex once and trigger a *single* IPI=
 to a CPU
> > from each domain and read all events sequentially (which is essentially=
 mbm_overflow()).
> >
> > For example,
> >         # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_0=
0
> >           <rdtgroup nameA> <MBM total count>
> >           <rdtgroup nameB> <MBM total count>
> >           ...
> >
> >         # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_0=
1
> >           <rdtgroup nameA> <MBM total count>
> >           <rdtgroup nameB> <MBM total count>
> >           ...
> >
> > As I understand an interface like above would be an improvement over
> > what can be achieved by user space by optimizing queries to existing in=
terface.
> >
>
> Yes, this is an option now that the ABMC work is establishing a naming
> scheme for groups. It would also significantly cut down on the number
> of open file descriptors needed.
>
> Tony had prototyped an MBM rate event[1], which cached a MBps value
> per group/domain produced by the overflow workers. If the workers
> produce the mbps samples immediately after directly reading the
> counters, then this should be the best case in terms of precision and
> introduce very little additional system overhead. Also, userspace
> reading a rate sample that's 1 second old would be a lot less harmful
> than performing an MBps calculation from a count sample that's 1
> second old.
>
> Perhaps combining the per-second bandwidth rate cache with a
> per-domain file for each MBM event to aggregate the data for all
> groups will be the optimally-performing solution?

Factoring ABMC into this, we'd have to decide the interval at which
we're comfortable with cycling the available event counters through
the group list in order to get valid MBps samples for every group
often enough.

A counter will have to stay assigned long enough to get two valid
counts before an MBps value can be reported. If the regular MBps
samples is what we want, maybe we just want a mode where the overflow
workers would also drive the counter assignments too in order to
produce regular samples from all groups.

-Peter


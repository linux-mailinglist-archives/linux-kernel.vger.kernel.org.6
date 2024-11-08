Return-Path: <linux-kernel+bounces-401654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D349C1D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD101F254A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C731E47D9;
	Fri,  8 Nov 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HIbBSosH"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C0137E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070881; cv=none; b=cdwK1zfdQd6IeND7Iz0ZnzcrQLHp5pcnafsnRr0EPN5k5hqjFO2cVly/W80QTLnzxgK7m81vmWpgyWMH/5ea4AakmK2WfoMVni7iLMLEUjmPkqLFU1EryTSEUpkyMTNaNBVMlb1rsTdvZg7iBlFsqLRFzTLdiGTRw3JP5G4ebyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070881; c=relaxed/simple;
	bh=0WFaDMnnX76pbjjTf38uXET2eQ1bvQjQCRo0vzlg/Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceu+jvzjaL7jWcP1Rwd/epML0QnRVsE0FCSb680ZjmJVFu0WfWHr+mSMWg5Ds4lrkEDjAVQRI6bycTFiliZlBFtp49x65WI7PRbBevdNZQelgyWNK6adpOP3ryx7IVTPH0t62VzNel8Mrc+OLLJWUPOsyn/O8ImqDVSXAxgeWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HIbBSosH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E66840CE5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731070869;
	bh=fgAresm4scXNfDrN2+2oeh4m+cAo7042Rxz3vXjcygw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HIbBSosH1osL9txN4W7HtpNILGWx50vgSRRM52dP4Ib0HxN+TKm4MhmUatcqShqkl
	 Q7GdYif1njl5NHo+BHCKmrb0ulBGRHzLR3Zpn1hkxrSGtlM7BZpvEH7pPZVVCVi15y
	 p2BDmqnpVAfnnoAR+cNHJ5qC+X22/Q5/uMVZ/HeJpxAJdxqP2KP2xuYY028Fr1jbbz
	 BLwVfET71rpLG3gRq1dJZSipKkvlelLUvneCI4zBbsKrbb4P9dlCNY6nbwSsMVIlEv
	 Xcj+dLxp63em1Ey8IGfHaQyStmaAN5wTXOFA2XtP5kI3BrtNrSLUin+iFMUh+q6jM2
	 LIsOIuPQ5J5iw==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b14f4f66a4so530937485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731070868; x=1731675668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgAresm4scXNfDrN2+2oeh4m+cAo7042Rxz3vXjcygw=;
        b=W5usZmca0/M8ZolR0iDu+iEQrVpebi/pUhzpsZ9q9+dqccfkzv2EYokrQFNWBUSsgj
         YYyOMrInZARMmoIw6uXj3M+JXD+YPFRUCA+eVqdKW0HQ7W2eVDZkB7pz2ir8axpadexS
         fOVNwC6WRhlLyEMhg705BnCvptb8a9cH9OhDQKRCw4F0ug4B9E/Pv+dEL9tS2rDNS88y
         qZwm6NBn+e/It9CaXbLkWXyspYo/hBRPnMPW5Dn8f/tnrwP/id0DNjiTHoI1oIq2YF1z
         CTvIN+hWJ2eYcHCfqI7TulLUgwzKuXjthStxCkG1GwIhAiV/c96CperA8P3fk4lm+z6z
         PHFA==
X-Forwarded-Encrypted: i=1; AJvYcCUV7p9Wm8twoAXh3sA990YqfQYgSUfw+nL+6ZUYUrdFdlfqIo56d3Vg+1dNiJlEGTptyeJbpAVxsFmlTpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeYb/pGelOLPuJSvx7dod8I7YLKVnUW25b71wDaxB4JFRD2k1
	PQ/ZRGnKXApoHHmE9CgTJsLBooo4M1RJTUzgkNxGH5WgTSpSC5e9GS8cOTLjLEnrMNqrXqeJlE4
	7LyZtne7446mrTmmAMFq2dQWMtIFy/viKCrvEZdQfLKwCmZ0OXqNbXiYgXwo0p2UIU5eOvNb7i9
	y8ihr8i4tDXgDO6ef1q68KNIjYc/qIVPso6cwcOzwIxRnz9G5nb7+D
X-Received: by 2002:a05:620a:2687:b0:7b1:21c4:ecf8 with SMTP id af79cd13be357-7b33192f706mr509046485a.28.1731070868215;
        Fri, 08 Nov 2024 05:01:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBXMilCt2HvLYXTpmmSMWuHyFdkZpmBtKsyqnrpR6tNY8nd9ye7mDDKpH37Q3gDj9Uq3saFiv8y/OD/gas1o8=
X-Received: by 2002:a05:620a:2687:b0:7b1:21c4:ecf8 with SMTP id
 af79cd13be357-7b33192f706mr509040085a.28.1731070867720; Fri, 08 Nov 2024
 05:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com>
 <CAEivzxdUC=R1oTdrwRDdrfdU7AUcRdTQum_cUUt__Zvi6xr+3w@mail.gmail.com> <20241028110747.00002556@Huawei.com>
In-Reply-To: <20241028110747.00002556@Huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 8 Nov 2024 14:00:56 +0100
Message-ID: <CAEivzxdKg20giNzsSpxhwCeWJM=JuD5=ti8MupibUoLEyOA4Zg@mail.gmail.com>
Subject: Re: [PATCH] sched/cpuacct: show only present CPUs to userspace
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: mingo@redhat.com, James Morse <james.morse@arm.com>, Gavin Shan <gshan@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	Simon Deziel <simon.deziel@canonical.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:07=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 25 Oct 2024 17:35:56 +0200
> Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> wrote:
>
> > Gentle ping.
> >
> > On Thu, Oct 17, 2024 at 12:22=E2=80=AFPM Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > After commit b0c69e1214bc ("drivers: base: Use present CPUs in GENERI=
C_CPU_DEVICES")
> > > changed which CPUs are shown in /sys/devices/system/cpu/ (only "prese=
nt" ones)
> > > it also makes sense to change cpuacct cgroupv1 code not to report CPU=
s
> > > which are not present in the system as it confuses userspace.
> > > Let's make it consistent.
> > >
> > > A configuration when #(present CPUs) < #(possible CPUs) is easy to ge=
t with:
> > > qemu-system-x86_64
> > >         -smp 3,maxcpus=3D12 \
> > >         ...
> > >
>

Dear Jonathan,

> On a general basis, we definitely want these to line up, but I'm not fami=
liar
> enough with this code to give more specific review.
>
> Other than that, I'm curious as to what userspace is tripping over this?

Originally it was reported me with regard to LXD
https://github.com/canonical/lxd/issues/13324

But I can imagine that any userspace can be confused there as what you
see in /proc/cpuinfo (and even /sys/devices/system/cpu/)
is not aligned with that you see in cpuacct.usage_all file). That's
extremely unexpected to see more CPUs in a cgroup-related file
than in /sys/devices/system/cpu/, IMHO.

Kind regards,
Alex

>
> Jonathan
>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Gavin Shan <gshan@redhat.com>
> > > Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Reported-by: Simon Deziel <simon.deziel@canonical.com>
> > > Closes: https://github.com/canonical/lxd/issues/13324
> > > Co-developed-by: Simon Deziel <simon.deziel@canonical.com>
> > > Signed-off-by: Simon Deziel <simon.deziel@canonical.com>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > > ---
> > >  kernel/sched/cpuacct.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> > > index 0de9dda09949..0f07fbfdb20e 100644
> > > --- a/kernel/sched/cpuacct.c
> > > +++ b/kernel/sched/cpuacct.c
> > > @@ -213,7 +213,7 @@ static int __cpuacct_percpu_seq_show(struct seq_f=
ile *m,
> > >         u64 percpu;
> > >         int i;
> > >
> > > -       for_each_possible_cpu(i) {
> > > +       for_each_present_cpu(i) {
> > >                 percpu =3D cpuacct_cpuusage_read(ca, i, index);
> > >                 seq_printf(m, "%llu ", (unsigned long long) percpu);
> > >         }
> > > @@ -247,7 +247,7 @@ static int cpuacct_all_seq_show(struct seq_file *=
m, void *V)
> > >                 seq_printf(m, " %s", cpuacct_stat_desc[index]);
> > >         seq_puts(m, "\n");
> > >
> > > -       for_each_possible_cpu(cpu) {
> > > +       for_each_present_cpu(cpu) {
> > >                 seq_printf(m, "%d", cpu);
> > >                 for (index =3D 0; index < CPUACCT_STAT_NSTATS; index+=
+)
> > >                         seq_printf(m, " %llu",
> > > --
> > > 2.34.1
> > >
>


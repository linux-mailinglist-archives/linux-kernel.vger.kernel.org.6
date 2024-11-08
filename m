Return-Path: <linux-kernel+bounces-401674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8299C1DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8DF1F22ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C11E6DE1;
	Fri,  8 Nov 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PFJM+yFb"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B711E9062
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071891; cv=none; b=irOQXm5N/9Nr9Dpk9pjtklcATM17pQOaMcPVuqChtIYTiZR9WnNS0uKhnEKXUZPM+vP2Ciby71YEm0AdpsbCO77C8P3qhZ0baYm8+nLWURKPNiJT0wU4hy6k72nmaHSJliEFWmoA/2lkgnKyz/HoVzQCOpBUlJMaZUkl4UOXMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071891; c=relaxed/simple;
	bh=LGuzZxQKUKcqZG4ZefmEC/L5wigl1aMz9xbDtWw1iKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUpf5X2nG0tkmcuhVGFS7f/JDvWdwjhQNNV7CCyZPOyKkcxJxUmViWSAPVpCfVtIqGPP1zBzc0IDnjCav7FeOJNHo/kWJgy6PQJSqCrY1tnpWZfwvfe8u7vrAgdYWTMOOnLwzDF/JPf+cXELl1eKNN50DbKI6h4v3xIQ3Vwaae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PFJM+yFb; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA8033F2B5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731071880;
	bh=kzua+I1iA4PK0mSF9uxhSSNEWd9AJXyTU/nZD4/bXMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PFJM+yFbET/eT4R5hrgCKJSiicpx9nkEJ2JHpQpQmAzwwoeJoY/c54YBeIyj16Ipb
	 5Hv47UZtwJGtZ0/EmxBr6xnvPWm51upMAhodGQHl6r1oKtfS1cN9uuwL4Ad+h9+bhO
	 wItuYaMKX5Qa9nxMokPkJ4dGy0bQh9mj7BZzA0WUNDficK/jP4HHVFSJb0uKMw7wug
	 qrx7aORGuiBBLsv9m1i/dc7K8Sjv8fjzRELBLgn8IFHAEme1qW0ME+2HY4VSXNmMDq
	 WGBjAqEHWkycl1NYN+Ds6cmzKE5yEpXdeWVRAFArnJ3USFzI5RwQuKq4NjZckbiZbH
	 vPv01uzQS/90g==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb7db06bf5so1653315eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731071879; x=1731676679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzua+I1iA4PK0mSF9uxhSSNEWd9AJXyTU/nZD4/bXMo=;
        b=ZRb1IJXImm6unxgfhpeKeFOrE/Wc65SAPyyhMv1qA248E4uGAuqGpFLxXOSBmjmx0k
         5ZtneFA6zL5T0+yqk9MxJxAF78OJMNZS7Wz7rhx3UNz61w/tsPjdv1Y8zzX40iRwgR0V
         09u/0SVYroWWB0zmpCWAdrgPm9520FtPEJxyctJQSPDb/95q2XBJONjSEZ+vC/wTxT+2
         MfSosU/0aLa3MBfPDyojHpCGenqLmo0fqJmrEYBALPe2/yaUY4clRv7aWvoQK4oIt7Pe
         gC8Sd2NNNDtNoTTTGws4XWv+3+eqF1QXYE5sHNDV+YEYAiOOTrmgkGsuAtUrieFLj302
         X0zw==
X-Forwarded-Encrypted: i=1; AJvYcCXfRfyTyY+d0det3ps/E4leoSCz7Gwgtl+FM6GASOyxadTIluHhJaXPylSKJXff9w5tfzFiJgfI8q0r2tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGdKGB/d5L8Na33jG7biigD0OZDPRiZx89C85jxrXe/XAJiAj
	Vq+lgqloiAefSdOIer7L4mkipcrk++QwBOLvmhALXOmyIaktnnqrBVVEEAxcYWtMfiZC+T3+sa5
	NfGdwoP0mMa6g9EDHNlEIa5nZ2saT4xoVarV4ouEMwEM2syTiflSwwUFwIOLbz4pDmhf9VXROQv
	PgIEGRPgvZ3v7pZY1oDFeJIVqhdjk3CyIe/LSgoTpOPTFUN8MhWpf5
X-Received: by 2002:a05:6359:428f:b0:1b8:3283:ec6e with SMTP id e5c5f4694b2df-1c641f67de2mr192355155d.24.1731071879464;
        Fri, 08 Nov 2024 05:17:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJzSyroiv02HIUsmUBWhMbxG/AIS7tRK5DxzKIHYsZ/BndyAUa+D18FoRdn2XmKVAly2vqHOiQDvsYvAhE38w=
X-Received: by 2002:a05:6359:428f:b0:1b8:3283:ec6e with SMTP id
 e5c5f4694b2df-1c641f67de2mr192352955d.24.1731071879196; Fri, 08 Nov 2024
 05:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com> <20241028132306.GP14555@noisy.programming.kicks-ass.net>
In-Reply-To: <20241028132306.GP14555@noisy.programming.kicks-ass.net>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 8 Nov 2024 14:17:48 +0100
Message-ID: <CAEivzxdMG-Hfq9muv7LrCJmp-qD-kqt06CqyMZ0ENFRkKmu5XQ@mail.gmail.com>
Subject: Re: [PATCH] sched/cpuacct: show only present CPUs to userspace
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, James Morse <james.morse@arm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Gavin Shan <gshan@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	Simon Deziel <simon.deziel@canonical.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:23=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Oct 17, 2024 at 12:21:38PM +0200, Alexander Mikhalitsyn wrote:
> > After commit b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_=
CPU_DEVICES")
> > changed which CPUs are shown in /sys/devices/system/cpu/ (only "present=
" ones)
> > it also makes sense to change cpuacct cgroupv1 code not to report CPUs
> > which are not present in the system as it confuses userspace.
> > Let's make it consistent.
> >
> > A configuration when #(present CPUs) < #(possible CPUs) is easy to get =
with:
> > qemu-system-x86_64
> >       -smp 3,maxcpus=3D12 \
> >       ...
> >
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Gavin Shan <gshan@redhat.com>
> > Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Reported-by: Simon Deziel <simon.deziel@canonical.com>
> > Closes: https://github.com/canonical/lxd/issues/13324
> > Co-developed-by: Simon Deziel <simon.deziel@canonical.com>
> > Signed-off-by: Simon Deziel <simon.deziel@canonical.com>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  kernel/sched/cpuacct.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> > index 0de9dda09949..0f07fbfdb20e 100644
> > --- a/kernel/sched/cpuacct.c
> > +++ b/kernel/sched/cpuacct.c
> > @@ -213,7 +213,7 @@ static int __cpuacct_percpu_seq_show(struct seq_fil=
e *m,
> >       u64 percpu;
> >       int i;
> >
> > -     for_each_possible_cpu(i) {
> > +     for_each_present_cpu(i) {
> >               percpu =3D cpuacct_cpuusage_read(ca, i, index);
> >               seq_printf(m, "%llu ", (unsigned long long) percpu);
> >       }
> > @@ -247,7 +247,7 @@ static int cpuacct_all_seq_show(struct seq_file *m,=
 void *V)
> >               seq_printf(m, " %s", cpuacct_stat_desc[index]);
> >       seq_puts(m, "\n");
> >
> > -     for_each_possible_cpu(cpu) {
> > +     for_each_present_cpu(cpu) {
> >               seq_printf(m, "%d", cpu);
> >               for (index =3D 0; index < CPUACCT_STAT_NSTATS; index++)
> >                       seq_printf(m, " %llu",
>

Dear Peter,

>
> Doesn't this create problems for machines that support actual physical
> hotplug?
>
> Then all of a sudden, when a CPU with non-zero stats goes from present
> to !present, the stats also go away, and any userspace looking at the
> sum of stats over CPUs sees an unexplained dis-continuity.

Yep, that's what I thought about too. At the same time, if userspace
sum of stat over CPUs,
we already have /sys/fs/cgroup/cpuacct/cpuacct.usage (which uses
for_each_possible_cpu() and I did not
change that on purpose in this patch).

I agree that it's a bit tricky and not obvious which is correct. But
you might agree that it's a bit weird that
cpuacct.usage_all file shows more CPUs than you can see in sysfs
/sys/devices/system/cpu/.

I just wanted to point that problem out so we can discuss and decide.
But of course we should follow a Do-No-Harm principle here.

Kind regards,
Alex


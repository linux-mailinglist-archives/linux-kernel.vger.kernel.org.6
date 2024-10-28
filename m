Return-Path: <linux-kernel+bounces-384796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589C9B2E89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EF11F2251A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFF1D61AC;
	Mon, 28 Oct 2024 11:08:01 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820091D3573
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113681; cv=none; b=Aq0KdecUDCcijupPlPDN0QWSSdI1458c2o0N+i1aPAyFIUxSUcizIk8kivuFe8R8E1i8O4DZrkJJpIG319DbHGZZylh7OnWJrdGmcv+B+AoZQvj92UptYgxKjGclDf3y7qitIL2gPXGJl1GnG5giR0g+a+dvqk9oXSYVfrPeKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113681; c=relaxed/simple;
	bh=XUONsI6HwpAEJTCHhtFfjirndssaQjEyANAOk39iUko=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSpMn3boIAT/3ZPWPGtLVNrrT5rGq48WcFx0AgoWzX5lboNgJF9w9JSdJSeqHCu0yMhT+g8TapWDN6KTh8hMmDhn1q/ez0m92mVVVDc83vCL6K9DNp991mOxjGEFqJBgx4D4L5eCbIllVaJNZi8BU/Be4n+0lvUf6Cu2Vk+pHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XcVt3131Zz6K76L;
	Mon, 28 Oct 2024 19:05:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BB3D140429;
	Mon, 28 Oct 2024 19:07:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 12:07:48 +0100
Date: Mon, 28 Oct 2024 11:07:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
CC: <mingo@redhat.com>, James Morse <james.morse@arm.com>, Gavin Shan
	<gshan@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, Simon Deziel
	<simon.deziel@canonical.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/cpuacct: show only present CPUs to userspace
Message-ID: <20241028110747.00002556@Huawei.com>
In-Reply-To: <CAEivzxdUC=R1oTdrwRDdrfdU7AUcRdTQum_cUUt__Zvi6xr+3w@mail.gmail.com>
References: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com>
	<CAEivzxdUC=R1oTdrwRDdrfdU7AUcRdTQum_cUUt__Zvi6xr+3w@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 17:35:56 +0200
Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> wrote:

> Gentle ping.
>=20
> On Thu, Oct 17, 2024 at 12:22=E2=80=AFPM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
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
> >         -smp 3,maxcpus=3D12 \
> >         ...
> >

On a general basis, we definitely want these to line up, but I'm not famili=
ar
enough with this code to give more specific review.

Other than that, I'm curious as to what userspace is tripping over this?

Jonathan
=20
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
> >         u64 percpu;
> >         int i;
> >
> > -       for_each_possible_cpu(i) {
> > +       for_each_present_cpu(i) {
> >                 percpu =3D cpuacct_cpuusage_read(ca, i, index);
> >                 seq_printf(m, "%llu ", (unsigned long long) percpu);
> >         }
> > @@ -247,7 +247,7 @@ static int cpuacct_all_seq_show(struct seq_file *m,=
 void *V)
> >                 seq_printf(m, " %s", cpuacct_stat_desc[index]);
> >         seq_puts(m, "\n");
> >
> > -       for_each_possible_cpu(cpu) {
> > +       for_each_present_cpu(cpu) {
> >                 seq_printf(m, "%d", cpu);
> >                 for (index =3D 0; index < CPUACCT_STAT_NSTATS; index++)
> >                         seq_printf(m, " %llu",
> > --
> > 2.34.1
> > =20



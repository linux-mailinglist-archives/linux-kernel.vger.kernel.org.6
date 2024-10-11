Return-Path: <linux-kernel+bounces-360404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A71999A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF27B2345A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B551EABB1;
	Fri, 11 Oct 2024 02:31:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7AC23BB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613864; cv=none; b=IQv3Ngd89v8d3Je0IkgpS4/oPgvPkdlpK8kdNIVxg2gOKNyLJdqy/V/zRfneEI88wlpHW42pT4QfSe3I5X0dFZMHyMSILLAou2IKmXP2nw5MQ0M860eQwcEje0Zf+YvTCCzFpv4+0yLFJOkc7O2riujJ5Ycoqun1MElDmF5+hhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613864; c=relaxed/simple;
	bh=AKgmvZloeG9rBATTM1eY7xImhQFUk4SKxo7Qtk8nUcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZTcQZBjWeRW5GmQhPy43unas5IvstjQ/LL/+v0gTc7O0LCUiVKR/kNMjUu9DxwuckucKYtUE07xbQ4bJFzK+G8uJHkPEhF7kCDWOd8bMZ60BWVCGK5T2htn1gzkZw1mvWA3UdHPn951FcuzOKUbR9mWvXaE//92vQbrssjIkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5D3C4CEC5;
	Fri, 11 Oct 2024 02:31:00 +0000 (UTC)
Date: Thu, 10 Oct 2024 22:31:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, Ben
 Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel
 Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
 <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Thomas
 Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 kernel-team@android.com, "Connor O'Brien" <connoro@google.com>
Subject: Re: [RESEND x3][PATCH v12 2/7] locking/mutex: Make mutex::wait_lock
 irq safe
Message-ID: <20241010223109.68235374@gandalf.local.home>
In-Reply-To: <CANDhNCof4=mP9NBonXK9vSvxwbMN6gF9xUxqWgsVAE=Kj+F90w@mail.gmail.com>
References: <20241009235352.1614323-1-jstultz@google.com>
	<20241009235352.1614323-3-jstultz@google.com>
	<20241010100045.321ca4de@gandalf.local.home>
	<CANDhNCof4=mP9NBonXK9vSvxwbMN6gF9xUxqWgsVAE=Kj+F90w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 19:26:24 -0700
John Stultz <jstultz@google.com> wrote:

> On Thu, Oct 10, 2024 at 7:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> > On Wed,  9 Oct 2024 16:53:35 -0700
> > John Stultz <jstultz@google.com> wrote:
> > =20
> > > From: Juri Lelli <juri.lelli@redhat.com>
> > >
> > > mutex::wait_lock might be nested under rq->lock.
> > >
> > > Make it irq safe then. =20
> >
> > Can you expand on this please?
> >
> > If the mutex:wait_lock might be taken under an rq->lock, doesn't that m=
ean
> > a mutex was taken under rq->lock? Or is it something internal?
> >
> > This change log needs to be more explicit. =20
>=20
> Sure! Would the following work for you?
>=20
> "With the proxy-execution series, we traverse the task->mutex->task
> blocked_on/owner chain in the scheduler core. We do this while holding
> the rq::lock to keep the structures in place while taking and
> releasing the alternating lock types.
>=20
> Since the mutex::wait_lock is one of the locks we will take in this
> way under the rq::lock in the scheduler core, we need to make sure
> that its usage elsewhere is irq safe."
>=20
> ?

Yes, that explains things much better. ;-)

Thanks!

-- Steve


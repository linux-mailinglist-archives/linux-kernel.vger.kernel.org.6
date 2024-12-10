Return-Path: <linux-kernel+bounces-439950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D469EB6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB50E18882FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C822FE1A;
	Tue, 10 Dec 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="mRMwgSb1"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D302153DC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848700; cv=none; b=L/yoqBBjdpnGz6qYqV8z6SGFQ8wxoRlkyGlAgWbo5QpnMmUt9tEvbX7OsuRddLf2r1MBL4+ZYketxRvqvBtICQbrn/1ayA64yy4YvNKrRFHtIJBElO7s+q+zN7vEpJ/qX308SNX0WKMbPlh65qVu6YbyiAE5NivpwvfSPrIcdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848700; c=relaxed/simple;
	bh=qpKZ9pzuduyQvfaqltvVZQeQYFOI/8/Vo3WBPQwPcO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bef+8PwGG8Dv4Vh0uGytgGc5wUed/5+wY0VuUgV/KOJg6wi8/jxAls6bUA8Yzr9aZ3DkGKbyjDV1pGBcyKgoVJsmMtZJrAxi0aPr3cGozYA0paMMYXtEJbrXbTF+y0QpXKuXENGn0Sc8OytU/52DCuRUxHjfvu0xkCt1E3tJbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=mRMwgSb1; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ydoEzs65iswV0D9AH6yITF5eFkuvF3IkfC42oOhI+o=; b=mRMwgSb15m0U4vZTrkXM9zL6ow
	Yv7nSLrt13tQyXR9q+aUDyHW6GRN6iE4sE3yVa+mMzseVYyM17FBPoihQDYbbnJUyFu8wP6xzVNXY
	QbJbeuuXU4dYQO2quoS6cUFt9rFwVuGbOEBbgXQnry3WACR1nXVIPVt4u50nBrz/eJ2NdKaZjQLj0
	DK88NFW4Gv+ACoLd0A+uf/xvZulh9gccfCfJrGz+p5m9c47VjrEfaBoxp3jaK13uARKl5lCKjewVZ
	nZ5Md8PxIEGcFUYnHiR417A8iBA0eK1PKmWis+MUXYcOuoxLQMhJn8/vYaUz1ympGalqBQcAy+btq
	oY7yXMsg==;
Received: from [194.230.241.203] (helo=[10.10.1.195])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tL2mX-0047h6-U3; Tue, 10 Dec 2024 16:08:18 +0000
Message-ID: <86b2ef1b47f25c1ae9eb8006f01d1bba2d7a5421.camel@codethink.co.uk>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Peter Zijlstra <peterz@infradead.org>, Vineeth Remanan Pillai
	 <vineeth@bitbyteword.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Ilya Maximets
 <i.maximets@ovn.org>,  LKML <linux-kernel@vger.kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli	 <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, 	vineethrp@google.com, shraash@google.com
Date: Tue, 10 Dec 2024 17:08:16 +0100
In-Reply-To: <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
	 <20241206151819.GA3949140@google.com>
	 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
	 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
	 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
	 <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

On Mon, 2024-12-09 at 13:56 +0100, Peter Zijlstra wrote:
> On Mon, Dec 09, 2024 at 07:29:52AM -0500, Vineeth Remanan Pillai wrote:
> > On Mon, Dec 9, 2024 at 5:55=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >=20
> > > On Fri, Dec 06, 2024 at 11:57:30AM -0500, Vineeth Remanan Pillai wrot=
e:
> > >=20
> > > > I was able to reproduce this WARN_ON couple of days back with
> > > > syzkaller. dlserver's dl_se gets enqueued during a update_curr whil=
e
> > > > the dlserver is stopped. And subsequent dlserver start will cause a
> > > > double enqueue.
> > >=20
> > > Right, I spotted that hole late last week. There is this thread:
> > >=20
> > > =C2=A0 https://lore.kernel.org/all/20241209094941.GF21636@noisy.progr=
amming.kicks-ass.net/T/#u
> > >=20
> > > Where I just added this thunk:
> > >=20
> > > =C2=A0 @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_en=
tity *dl_se)
> > >=20
> > > =C2=A0void dl_server_stop(struct sched_dl_entity *dl_se)
> > > =C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (current->dl_server =3D=3D d=
l_se) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct rq *rq =3D rq_of_dl_se(dl_se);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 trace_printk("stop fair server %d\n", cpu_of(rq));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 current->dl_server =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dl_se->dl_runtime)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > >=20
> > > Which was my attempt at plugging said hole. But since I do not have
> > > means of reproduction, I'm not at all sure it is sufficient :/
> > >=20
> > I think I was able to get to the root cause last week. So the issue
> > seems to be that dlserver is stopped in the pick_task path of dlserver
> > itself when the sched_delayed is set:
> > __pick_next_task
> > =3D> pick_task_dl -> server_pick_task
> > =C2=A0=C2=A0=C2=A0=C2=A0 =3D> pick_task_fair
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> pick_next_e=
ntity (if (sched_delayed))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D> dequeue_entities
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> dl_server_stop
>=20
> Ooh, that's where it happens.
>=20
> So the scenario I had in mind was that we were doing something like:
>=20
> 	current->state =3D TASK_INTERRUPTIBLE();
> 	schedule();
> 	=C2=A0 deactivate_task()
> 	=C2=A0=C2=A0=C2=A0 dl_stop_server();
> 	=C2=A0 pick_next_task()
> 	=C2=A0=C2=A0=C2=A0 pick_next_task_fair()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_balance_newidle()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq_unlock(this_rq)
>=20
> at which point another CPU can take our RQ-lock and do:
>=20
> 	try_to_wake_up()
> 	=C2=A0 ttwu_queue()
> 	=C2=A0=C2=A0=C2=A0 rq_lock()
> 	=C2=A0=C2=A0=C2=A0 ...
> 	=C2=A0=C2=A0=C2=A0 activate_task()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_start()
> 	=C2=A0=C2=A0=C2=A0 wakeup_preempt() :=3D check_preempt_wakeup_fair()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_curr()
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_curr_task()
> 		=C2=A0 if (current->dl_server)
> 		=C2=A0=C2=A0=C2=A0 dl_server_update()
> 		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enqueue_dl_entity()
> 	=C2=A0=20
>=20
> Which then also goes *bang*. The above can't happen if we clear
> current->dl_server in dl_stop_server().
>=20
> I was worried that might not be it, bcause Marcel had biscected it to
> the delayed stuff, but I'd not managed to reach the pick site yet :/
>=20
> > Now server_pick_task returns NULL and then we set dl_yielded and call
> > update_curr_dl_se. But dl_se is already dequeued and now the code is
> > confused and it does all sorts of things including setting a timer to
> > enqueue it back. This ultimately leads to double enqueue when dlserver
> > is started next time(based on timing of dl_server_start)
> >=20
> > I think we should not call update_curr_dl_se when the dlserver is
> > dequeued. Based on this I have a small patch and it seems to solve the
> > issue:
> >=20
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index d9d5a702f1a6..a9f3f020e421 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2419,12 +2419,18 @@ static struct task_struct *__pick_task_dl(struc=
t rq *rq)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_server(dl_se)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 p =3D dl_se->server_pick_task(dl_se);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!p) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (p) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq->dl_serv=
er =3D dl_se;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 } else if (WARN_ON_ONCE(on_dl_rq(dl_se))) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If =
server_pick_task returns NULL and dlserver is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enq=
ueued, we have a problem. Lets yield and do a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pic=
k again.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_se=
->dl_yielded =3D 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 updat=
e_curr_dl_se(rq, dl_se, 0);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
again;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rq->dl_server =3D dl_se;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 p =3D dl_task_of(dl_se);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Hmm.. so fundamentally that yield() makes sense, but yeah, it's lost
> track of the fact that we've stopped the server and it should not
> continue.
>=20
> Does something like the below make sense?

At least it stopped crashing for me.

https://drive.codethink.co.uk/s/XRqN2y9BLwPsD9H

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..abebeb67de4e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -664,6 +664,7 @@ struct sched_dl_entity {
> =C2=A0	unsigned int			dl_non_contending : 1;
> =C2=A0	unsigned int			dl_overrun	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_server=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : 1;
> +	unsigned int			dl_server_active=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer_armed	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer_running=C2=A0 : 1;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a6..e2b542f684db 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
> =C2=A0	if (!dl_se->dl_runtime)
> =C2=A0		return;
> =C2=A0
> +	dl_se->dl_server_active =3D 1;
> =C2=A0	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
> =C2=A0	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->cur=
r->dl))
> =C2=A0		resched_curr(dl_se->rq);
> @@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> =C2=A0	hrtimer_try_to_cancel(&dl_se->dl_timer);
> =C2=A0	dl_se->dl_defer_armed =3D 0;
> =C2=A0	dl_se->dl_throttled =3D 0;
> +	dl_se->dl_server_active =3D 0;
> =C2=A0}
> =C2=A0
> =C2=A0void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> @@ -2420,8 +2422,10 @@ static struct task_struct *__pick_task_dl(struct r=
q *rq)
> =C2=A0	if (dl_server(dl_se)) {
> =C2=A0		p =3D dl_se->server_pick_task(dl_se);
> =C2=A0		if (!p) {
> -			dl_se->dl_yielded =3D 1;
> -			update_curr_dl_se(rq, dl_se, 0);
> +			if (dl_se->dl_server_active) {
> +				dl_se->dl_yielded =3D 1;
> +				update_curr_dl_se(rq, dl_se, 0);
> +			}
> =C2=A0			goto again;
> =C2=A0		}
> =C2=A0		rq->dl_server =3D dl_se;


Return-Path: <linux-kernel+bounces-444592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BED9F092C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFC283943
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2171B4155;
	Fri, 13 Dec 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Jc5qThbK"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F618BBAC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084671; cv=none; b=VVWvpV9ouyD6niBjZsGdauVjle+iI7iO7ii7x2tr1L2D0zapSY5zMb/xTTjIpDVrXm0PhxlcNR9DvSoP7vauOdn6+axzkOVe70CRn4D1Lj+hjtcL1ZjyntayAEoqzvXyRKXunEZ4GR0igmZwLlX8YnwJKbWq2zQFjw3j3+ZIwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084671; c=relaxed/simple;
	bh=HSmqBvg2uJ6E8qwbF/B1PNF8UDQ14sxEkx7Jb98zX0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qyd8mKDK5clG8hOE5v0ABhtO9p+Q5Ugmq9Mg0lndXk4y9c6BxgAGGKYnEMyf4UYM9Ar8OjOLD5TOhnmq+5uze10bTcPWTsxO6bVEDEZuC5VEl95OK+gpRLWbMT0tPqEoGK9/OvtqLUAqZ1y1wuFwsj/T+3kw4VGyRw83FxfpQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=Jc5qThbK; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Gfc+Vrkvd26LKiAmo+TSFm/0LbQBumrfRatOY3carY=; b=Jc5qThbKUnnSg46he/CMIrPw8/
	vZKE5Uye0YTYs8jsNR2sfAlO9tiFy8l6YHvzdPVbHDdzznkxU8mkRnldgaVA4XhaLjG51sP9hVJf3
	+upyRQp0UaBvVkiWlDu8koypheYS4IoXe9kzJ6fyDPRQ/bw+2eDB6GErapwvAaixGW3ZxeAhK7+Z3
	6+7HRkykIouA3OHfIpPFg31JFoLLzoYEAUOYcOdKgt55D7oqjtQZEC/BAPXfmpi1j7PGsC/2FbVUy
	s/OErIuDTAy+TLZiZmpErduJ57YsoKHeMBWWYYX2jVI4kByPsRnuPaeIkHwzcyRLWSdLvb+xRlNIe
	dbNqyImg==;
Received: from [167.98.27.226] (helo=[10.17.3.146])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tM2dE-005wW3-EP; Fri, 13 Dec 2024 10:10:48 +0000
Message-ID: <d047756f075be40dd4e5ed0e2c8a5fd7d5f66736.camel@codethink.co.uk>
Subject: Re: [PATCH 1/2] sched/dlserver: flag to represent active status of
 dlserver
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Peter Zijlstra
	 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>,  Joel Fernandes <joel@joelfernandes.org>,
 shraash@google.com, i.maximets@ovn.org, LKML <linux-kernel@vger.kernel.org>
Date: Fri, 13 Dec 2024 11:10:47 +0100
In-Reply-To: <20241213032244.877029-1-vineeth@bitbyteword.org>
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
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

Thank you very much, Vineeth

On Thu, 2024-12-12 at 22:22 -0500, Vineeth Pillai (Google) wrote:
> dlserver can get dequeued during a dlserver pick_task due to the delayed
> deueue feature and this can lead to issues with dlserver logic as it
> still thinks that dlserver is on the runqueue. The dlserver throttling
> and replenish logic gets confused and can lead to double enqueue of
> dlserver.
>=20
> Double enqueue of dlserver could happend due to couple of reasons:
>=20
> Case 1
> ------
>=20
> Delayed dequeue feature[1] can cause dlserver being stopped during a
> pick initiated by dlserver:
> =C2=A0 __pick_next_task
> =C2=A0=C2=A0 pick_task_dl -> server_pick_task
> =C2=A0=C2=A0=C2=A0 pick_task_fair
> =C2=A0=C2=A0=C2=A0=C2=A0 pick_next_entity (if (sched_delayed))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dequeue_entities
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_stop
>=20
> server_pick_task goes ahead with update_curr_dl_se without knowing that
> dlserver is dequeued and this confuses the logic and may lead to
> unintended enqueue while the server is stopped.
>=20
> Case 2
> ------
> A race condition between a task dequeue on one cpu and same task's enqueu=
e
> on this cpu by a remote cpu while the lock is released causing dlserver
> double enqueue.
>=20
> One cpu would be in the schedule() and releasing RQ-lock:
>=20
> current->state =3D TASK_INTERRUPTIBLE();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 schedule();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deactivate_task()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_sto=
p_server();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pick_next_task()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pick_n=
ext_task_fair()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sched_balance_newidle()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rq_unlock(this_rq)
>=20
> at which point another CPU can take our RQ-lock and do:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_to_wake_up()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttwu_queue()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq_loc=
k()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 activa=
te_task()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dl_server_start() --> first enqueue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wakeup=
_preempt() :=3D check_preempt_wakeup_fair()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 update_curr()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 update_curr_task()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (current->dl_server)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dl_server_update()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enqueue_dl_entity() =
--> second enqueue
>=20
> This bug was not apparent as the enqueue in dl_server_start doesn't
> usually happen because of the defer logic. But as a side effect of the
> first case(dequeue during dlserver pick), dl_throttled and dl_yield will
> be set and this causes the time accounting of dlserver to messup and
> then leading to a enqueue in dl_server_start.
>=20
> Have an explicit flag representing the status of dlserver to avoid the
> confusion. This is set in dl_server_start and reset in dlserver_stop.
>=20
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>

Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # ROCK 5B

> ---
> =C2=A0include/linux/sched.h=C2=A0=C2=A0 | 7 +++++++
> =C2=A0kernel/sched/deadline.c | 8 ++++++--
> =C2=A0kernel/sched/sched.h=C2=A0=C2=A0=C2=A0 | 5 +++++
> =C2=A03 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..66b311fbd5d6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -656,6 +656,12 @@ struct sched_dl_entity {
> =C2=A0	 * @dl_defer_armed tells if the deferrable server is waiting
> =C2=A0	 * for the replenishment timer to activate it.
> =C2=A0	 *
> +	 * @dl_server_active tells if the dlserver is active(started).
> +	 * dlserver is started on first cfs enqueue on an idle runqueue
> +	 * and is stopped when a dequeue results in 0 cfs tasks on the
> +	 * runqueue. In other words, dlserver is active only when cpu's
> +	 * runqueue has atleast one cfs task.
> +	 *
> =C2=A0	 * @dl_defer_running tells if the deferrable server is actually
> =C2=A0	 * running, skipping the defer phase.
> =C2=A0	 */
> @@ -664,6 +670,7 @@ struct sched_dl_entity {
> =C2=A0	unsigned int			dl_non_contending : 1;
> =C2=A0	unsigned int			dl_overrun	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_server=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : 1;
> +	unsigned int			dl_server_active=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer_armed	=C2=A0 : 1;
> =C2=A0	unsigned int			dl_defer_running=C2=A0 : 1;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 33b4646f8b24..0abf14ac5ca7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1667,6 +1667,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
> =C2=A0	if (!dl_se->dl_runtime)
> =C2=A0		return;
> =C2=A0
> +	dl_se->dl_server_active =3D 1;
> =C2=A0	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
> =C2=A0	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->cur=
r->dl))
> =C2=A0		resched_curr(dl_se->rq);
> @@ -1681,6 +1682,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> =C2=A0	hrtimer_try_to_cancel(&dl_se->dl_timer);
> =C2=A0	dl_se->dl_defer_armed =3D 0;
> =C2=A0	dl_se->dl_throttled =3D 0;
> +	dl_se->dl_server_active =3D 0;
> =C2=A0}
> =C2=A0
> =C2=A0void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> @@ -2435,8 +2437,10 @@ static struct task_struct *__pick_task_dl(struct r=
q *rq)
> =C2=A0	if (dl_server(dl_se)) {
> =C2=A0		p =3D dl_se->server_pick_task(dl_se);
> =C2=A0		if (!p) {
> -			dl_se->dl_yielded =3D 1;
> -			update_curr_dl_se(rq, dl_se, 0);
> +			if (dl_server_active(dl_se)) {
> +				dl_se->dl_yielded =3D 1;
> +				update_curr_dl_se(rq, dl_se, 0);
> +			}
> =C2=A0			goto again;
> =C2=A0		}
> =C2=A0		rq->dl_server =3D dl_se;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aef716c41edb..65fa64845d9f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -398,6 +398,11 @@ extern void __dl_server_attach_root(struct sched_dl_=
entity *dl_se, struct rq *rq
> =C2=A0extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
> =C2=A0		=C2=A0=C2=A0=C2=A0 u64 runtime, u64 period, bool init);
> =C2=A0
> +static inline bool dl_server_active(struct sched_dl_entity *dl_se)
> +{
> +	return dl_se->dl_server_active;
> +}
> +
> =C2=A0#ifdef CONFIG_CGROUP_SCHED
> =C2=A0
> =C2=A0extern struct list_head task_groups;

Cheers

Marcel


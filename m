Return-Path: <linux-kernel+bounces-443060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E459EE66C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1EF284460
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A521171A;
	Thu, 12 Dec 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="vsyITNpS"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C71E9B27
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005688; cv=none; b=ses7avdcd4r1h0dsRnPTz718RhHiNreYP1L6m9narCXFy6eEy6AiAV40sF+JAgYbFmAeu4F10TrVGt5wxMJSz2FicK5lYrBbJpE9hLQKuW1/5G1XDTo+j+Ra2/cA16YzGfStE00INTOGnW9CENt7yfItz9zhVjuTQcg/X2PdOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005688; c=relaxed/simple;
	bh=qjItMBMxvIl934fJydmMj4YHZut6uUmLOGvWoBfKruw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWYh6mXZwOGZlE2u+eegtb4m1NE4yZUPkCe+Nx0aYOL/72NHeuGrr+UDbdfioLSfHKi52PTxSQBGzh6/3YPZ5AYHX0hNU6GilH9oKXM6lSlXrPSGyCoxZFZyU4K7IbwpPVPDs/6tn+sillArmeXgXYJYxbw6LPfV67hcndbtAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=vsyITNpS; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734005661; x=1734610461; i=spasswolf@web.de;
	bh=pR08A5t2F8ViOvN+kJKyeSjU/m7nzTAMDPdDRbVetiw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vsyITNpSAXPJpEJqM8eO2DdHBbdDg7VEm95ZFqY4CFHqLxNN24JMDz5vSpqDMqiV
	 3gZr+Pa3Megv8w+BhlWbiigq8Qasmj5NisFS9MMbypab1O6Abg0cADK1BGBlJikzH
	 zupMwI4sRq3/n6wrioT9Z+52GNpOv2LduJ6nfyuqbMPC9UE1kyaOIxJ2/17RY8tuG
	 5gLT20vUouN0jIsAsfUGKrDb8Fe4COG7hNsobRyQ7DgQT55D4fO+CX8Hab4coPP77
	 mQvnBwmjQAKP1byC4yQqhzAdEun0Wu8koKd+wg8vSrg0HC1XXMZugeKMpVRGGd+DZ
	 FIDc1i9/IqKaMDDRcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL4K-1tREOe3VeW-00BzHQ; Thu, 12
 Dec 2024 13:14:20 +0100
Message-ID: <52cbc68b8c54a1abb8f29ab6c84eb917522b2167.camel@web.de>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
From: Bert Karwatzki <spasswolf@web.de>
To: John Stultz <jstultz@google.com>
Cc: Metin.Kaya@arm.com, boqun.feng@gmail.com, bsegall@google.com, 
	daniel.lezcano@linaro.org, dave@stgolabs.net, dietmar.eggemann@arm.com, 
	joelaf@google.com, juri.lelli@redhat.com, kernel-team@android.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, 	qyousef@layalina.io, rostedt@goodmis.org,
 tglx@linutronix.de, 	vincent.guittot@linaro.org, vschneid@redhat.com,
 will@kernel.org, 	xuewen.yan94@gmail.com, zezeozue@google.com,
 spasswolf@web.de
Date: Thu, 12 Dec 2024 13:14:19 +0100
In-Reply-To: <ba23cfd0b7310504598b711311a7c08a64d1e13d.camel@web.de>
References: <20241211213527.3278-1-spasswolf@web.de>
			 <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
			 <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com>
			 <cf6c7a80e3a54e1060f89cf7bc8c741214d1665a.camel@web.de>
			 <CANDhNCqP+zGH5jyfWHeEpALuAxbyc_+XOx5CHoRs_tw4DVjDww@mail.gmail.com>
			 <CANDhNCrKhwVBEjX5m46Mwrm9uixBkS8MSXKyWxkD=-8Urx7nGg@mail.gmail.com>
		 <5325ccfa4f7a0a9925e8133612528237966c2145.camel@web.de>
	 <ba23cfd0b7310504598b711311a7c08a64d1e13d.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NqfrqtBoqEDBsC+7aFpoCK/CTm8gxZIEq8YT3kp+kWHabcTomPC
 +wO+BC/vkW6GcdAhqSbwxzoOXGIVhVRAzlrxRo35e4t3151zOqOzU45J1LjQFHNpwI/4oJN
 4SQMVdnv4t5uDo9SjG8l25jvNO+OW9UQoqZmU8vJjxaxPrfrxWD777UbNj9bd+d3jAyS4L/
 i6mXhv5YAEakWzkbNo4Hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hxax1hQx8Ww=;GA6aVGMPwbpgovO9gi+RRixtpqj
 CQN3riehxHHMX4FqFlEkiZPMAmApP15HYb+r4Jwwz1PEO6w/TAYrNe9efgLhRKOzCi7BkXRFU
 dk9mhZWhnKVAEotz1YUlv5DPmc20socEsI8UWYsMI9QXDwqrW+CLuXPb6dbyIi1qmgzl/hiLN
 l8ld1NdNE8SMgGLFmuPkZMSCvoAYlhmXCpN7o0+5YoHLp7mqEctVRl86Z5LjryKJ2whfsPkPu
 oKXJgjOXYA5tb11RjWO9N00/mvSqEHvb2RS0Cm/E0yfXA1MNFmlHn9f+ZI9ucsHB4nCJ6kxRb
 LGGb/u9LpYtz8I7TVpQdT2oXmgp5BPvPOwwuHsjhx9PKNDx27u1psm6tAubZHTqEKxgrFUv9k
 b27FrwdG9L7CemOjIa5+DUP2aL3at7AnCF4MvJHVUedLOwLiRSvS4uYF0bIhXNGEnVnHKUrhc
 vNTbmVYl27N1FTOpLc7yO8m5f89zNJf066PIEKCYcpbuZjKV3cus2Uo23V4W451rvLMy7oh5i
 8Jf0CJG2/FTR/7mcboUpzAJu0oCqrX19HFUk5kKzvrKrhb1blfa7RS7cDkiPTMDX5qQAoGM1m
 2rFrxB50BqBsiYPZVHNBF4TuvhF0ePAHlkwoRxp0svQpeLcXeCp8h/ePlRHWJC7dh2EXG505E
 i/JF3IcRJzaH6x1ha9+TB9vgcZEo1ovedSeyTqDHYfV3tgvqAntCR0sMY1obNRKRYgH3R0s4N
 hKUq2MTxvkKtQLmaic8FNFMyeW0jWHgJub4OvCJEaAAYbeC9vBv6UhI5bduNRlKyAQNK6lMX9
 yce/tu2rOhIG0teP4CdyZ247DCb+yMKxFx/vonGa90Tf2U9wfkbcygHC3nGnZKtlfvyS2x1je
 ekJWyA1HquXJE2+Q+lDclfmXjV7msFXTdAY2GYV9q9Rotdk2RztLFuzsEdAsME1PpqkhYrHBM
 zdFwwQNgS7hXBzS0o4nNUQC6QgGgPRjHVDVlw6AdEG1eHSW4Kb+w6V4KUpMrYsXV5peqp2y7z
 sQdMPYV6J3gMWgY2lek6YPEfTefFXSfjCJW+cG7fkfYzaEzdj0rmflemscHxislDduX9Mu0Cn
 +aqs5NJ3tYIeNXKgIKJfl5QHKYmrADJAoN1yT/3UmB0nIZ/3nnuKU0R1FYo9F6OMqBUT8Oj8A
 =

Am Donnerstag, dem 12.12.2024 um 12:56 +0100 schrieb Bert Karwatzki:
> Am Donnerstag, dem 12.12.2024 um 11:31 +0100 schrieb Bert Karwatzki:
> > Am Mittwoch, dem 11.12.2024 um 23:40 -0800 schrieb John Stultz:
> > > On Wed, Dec 11, 2024 at 6:41=E2=80=AFPM John Stultz <jstultz@google.=
com> wrote:
> > > >
> > > > On Wed, Dec 11, 2024 at 4:17=E2=80=AFPM Bert Karwatzki <spasswolf@=
web.de> wrote:
> > > > > Am Mittwoch, dem 11.12.2024 um 15:14 -0800 schrieb John Stultz:
> > > > > > On Wed, Dec 11, 2024 at 2:46=E2=80=AFPM Bert Karwatzki <spassw=
olf@web.de> wrote:
> > > > > > >
> > > > > > > Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karw=
atzki:
> > > > > > > > I have confirmed that I that linux-next-20241210 is fixed =
by the same revert
> > > > > > > > as v6.13-rc2 (ten boots without incident is the criterion =
for a good commit)
> > > > > > > >
> > > > > > > >
> > > > > > > > Bert Karwatzki
> > > > > > >
> > > > > > > Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've j=
ust checked v6.13-rc2
> > > > > > > without the revert and the following preempt settings and go=
t 10 clean boots:
> > > > > > >
> > > > > >
> > > > > > Hrm. That matches the case where the fix here helped:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
> > > > > >
> > > > > >
> > > > > > I'm still working on getting a minimal delta from your config =
booting
> > > > > > in my environment, but in the meantime, I'd be curious if the
> > > > > > following reduced revert helps?
> > > > > >   https://github.com/johnstultz-work/linux-dev/commit/60c60f85=
670fb1f4708adbe55e15ab918d96f9f0
> > > > > >
> > > > > > Basically just trying to clarify if the problem is moving the =
wakeup
> > > > > > to the wake_q or if some other interaction (maybe with the
> > > > > > preempt_disables) could be causing the issue.
> > > > > > (I'm assuming you have 82f9cc094975 applied when you test with=
 that change)
> > > > > >
> > > > >
> > > > > I tested linux-next-20241210 (which includes 82f9cc094975) with =
your patch
> > > > >
> > > > > diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex=
.h
> > > > > index 37f025a096c9..724d4c871cf6 100644
> > > > > --- a/kernel/locking/ww_mutex.h
> > > > > +++ b/kernel/locking/ww_mutex.h
> > > > > @@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MU=
TEX_WAITER
> > > > > *waiter,
> > > > >  #ifndef WW_RT
> > > > >                 debug_mutex_wake_waiter(lock, waiter);
> > > > >  #endif
> > > > > -               wake_q_add(wake_q, waiter->task);
> > > > > +               wake_up_process(waiter->task);
> > > > >         }
> > > > >
> > > > >         return true;
> > > > > @@ -332,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *l=
ock,
> > > > >                  * wakeup pending to re-read the wounded state.
> > > > >                  */
> > > > >                 if (owner !=3D current)
> > > > > -                       wake_q_add(wake_q, owner);
> > > > > +                       wake_up_process(owner);
> > > > >
> > > > >                 return true;
> > > > >         }
> > > > >
> > > > > and this fixes the issue for me.
> > > >
> > > > Ok, thanks for validating that!  Hrm. Ok, I suspect I'm missing a =
path
> > > > in rtmutex.c that calls into __schedule() before we pop up to the
> > > > point where we actually wake the wake_q.
> > > >
> > > > I may have found one or two spots that look likely, and I believe =
I've
> > > > also managed to reproduce your problem using the test-ww_mutex dri=
ver.
> > > >
> > > > So I'm working up a proper patch and will share for testing here s=
oon.
> > >
> > > Ok, could you try the patch here:
> > > https://github.com/johnstultz-work/linux-dev/commit/3c902b92c88122cd=
034937e8d40930bac254a7c5
> > >
> > > I've repushed to the test branch I shared earlier, so its against
> > > 6.13-rc2 + fix that has landed upstream + test fix above ( + another
> > > patch that makes stressing the ww_mutexes easier):
> > > https://github.com/johnstultz-work/linux-dev/commits/debug/894d1b3db=
41c-hang-bert/
> > >
> > > Let me know if you still have issues with this.
> > > thanks
> > > -john
> >
> > I cherry-picked your two patches on top of linux-next-20241210:
> >
> > 2029cb31eae9 (HEAD -> master) MAYBEFIX: Make sure we wake anything on =
the wake_q
> > when we release the lock->wait_lock
> > b525e4779098 test-ww_mutex: Allow test to be run (and re-run) from use=
rland
> > 1b2ab8149928 (tag: next-20241210) Add linux-next specific files for 20=
241210
> >
> > This fixes the issue for me.
> >
> > Bert Karwatzki
> >
>
> Just tested half the fix (only the task_blocks_on_rt_mutex() part on top=
 of
> linux-next-20241212 where the bug is also present) and found it to be su=
fficient
> to fix the issue for me:
>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index e858de203eb6..ddbb7423fb69 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1292,7 +1292,13 @@ static int __sched task_blocks_on_rt_mutex(struct
> rt_mutex_base *lock,
>          */
>         get_task_struct(owner);
>
> +       preempt_disable();
>         raw_spin_unlock_irq(&lock->wait_lock);
> +       /* wake up any tasks on the wake_q before calling
> rt_mutex_adjust_prio_chain */
> +       wake_up_q(wake_q);
> +       wake_q_init(wake_q);
> +       preempt_enable();
> +
>
>         res =3D rt_mutex_adjust_prio_chain(owner, chwalk, lock,
>                                          next_lock, waiter, task);
>
>
>
> Bert Karwatzki

I also tried the other half of your fix (again on linux-next-20241212)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e858de203eb6..3b362daa4677 100644
=2D-- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1596,6 +1596,7 @@ static void __sched remove_waiter(struct rt_mutex_ba=
se
*lock,
  *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for
none
  * @waiter:		 the pre-initialized rt_mutex_waiter
+ * @wake_q:		 wake_q of tasks to wake when we drop the lock-
>wait_lock
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
@@ -1603,7 +1604,8 @@ static int __sched rt_mutex_slowlock_block(struct
rt_mutex_base *lock,
 					   struct ww_acquire_ctx *ww_ctx,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
-					   struct rt_mutex_waiter *waiter)
+					   struct rt_mutex_waiter *waiter,
+					   struct wake_q_head *wake_q)
 	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm =3D container_of(lock, struct rt_mutex, rtmutex);
@@ -1634,7 +1636,13 @@ static int __sched rt_mutex_slowlock_block(struct
rt_mutex_base *lock,
 			owner =3D rt_mutex_owner(lock);
 		else
 			owner =3D NULL;
+		preempt_disable();
 		raw_spin_unlock_irq(&lock->wait_lock);
+		if (wake_q) {
+			wake_up_q(wake_q);
+			wake_q_init(wake_q);
+		}
+		preempt_enable();

 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1708,7 +1716,7 @@ static int __sched __rt_mutex_slowlock(struct
rt_mutex_base *lock,

 	ret =3D task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk,
wake_q);
 	if (likely(!ret))
-		ret =3D rt_mutex_slowlock_block(lock, ww_ctx, state, NULL,
waiter);
+		ret =3D rt_mutex_slowlock_block(lock, ww_ctx, state, NULL,
waiter, wake_q);

 	if (likely(!ret)) {
 		/* acquired the lock */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 33ea31d6a7b3..191e4720e546 100644
=2D-- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -383,7 +383,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_b=
ase
*lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret =3D rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to,
waiter);
+	ret =3D rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to,
waiter, NULL);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.

this alone also fixes the issue for me.

Bert Karwatzki


Return-Path: <linux-kernel+bounces-441832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA189ED4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88276188B419
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D6202F99;
	Wed, 11 Dec 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="eKBwscQ6"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13924632E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941560; cv=none; b=ISyu6Gs96ThxxaZLYRan15KNBcVNDEou3x+JB9cCsml5lrt2AMo/ozX95vb/xHZGJZ75Cd3yB8pqJqw7xy+NvsCK33FpTrMWRb1PLOGYtC/B3mAlggmUi4fd/OTLwn3MD3VE2cGwXXHgKXl2XhE5DemMtOq8B2TSvxAchzQwjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941560; c=relaxed/simple;
	bh=ACMk71wEfGRpxg7tpdn8XTwmqS6qtY39oUIyRs4a1Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpVPEZydIySrER8WoULXjq39VG5rWOKsWURxm6M/aG3ITQW7WYF7U3scJneoMhTgFVKxaf1k1JJgdOZ97EuiGJ+vHFu7vfkfFbeIw1OF7qzF7h05SM9/0GPLJO4sCnPYdWiEX/SS2CKJgkCMjkaPK4SkF5M7EMvkIxHqWC/zw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=eKBwscQ6; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733941506; x=1734546306; i=spasswolf@web.de;
	bh=w8Eq24y0dCEBb9KRu/4zRftiNjMcdsn6bcN7VdRYwTk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eKBwscQ6DSp294teR/rUBMlREsweMVVkgFpTY6oemTnHbs1UzbD/wvOOyrACADd+
	 SLPV5q+YU6VChVSEO/O95uTKX4BCnnVvTiuXPwiOFHH1NMIwbmrdril0+QFK/lRug
	 DSQV04sG6PjgKpux7gCWBKtrwCnOTLtj6xNQ9YHtcIbfUIqQGqDBFFqcj+A/5RTxa
	 6vh800oIoX9sEFp5vT1DlvQtcllXIhtvdECfqEWLZ/0KagrJuHX5MlB/X3/t+FwXJ
	 nAwXn/M2ePHQb7pRtqfHPZrpg4g9xkW3mBce4e6woSehmkCKmfti4N1vAInOy5Dz2
	 HySYnW7VY9+CVv87Vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MRW2R-1t0BWR0otx-00Lefi; Wed, 11 Dec 2024 19:25:06 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: jstultz@google.com
Cc: Bert Karwatzki <spasswolf@web.de>,
	Metin.Kaya@arm.com,
	boqun.feng@gmail.com,
	bsegall@google.com,
	daniel.lezcano@linaro.org,
	dave@stgolabs.net,
	dietmar.eggemann@arm.com,
	joelaf@google.com,
	juri.lelli@redhat.com,
	kernel-team@android.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mgorman@suse.de,
	mingo@redhat.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	qyousef@layalina.io,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	xuewen.yan94@gmail.com,
	zezeozue@google.com
Subject: commit 894d1b3db41c leads to frequent hangs when booting
Date: Wed, 11 Dec 2024 19:25:00 +0100
Message-ID: <20241211182502.2915-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20241009235352.1614323-2-jstultz@google.com
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AXwLc3PdKtloVjvzl6UnXFypzrKR0IsvU7T1miNwRBQdPwtLYiw
 rZddguUn12jTQsmoQHM2ldPXHeO1U7+RZ5fGuYyGyD20czFeSbOuPKse4whvZIy6UwEp0QF
 cr8arxwcPKu9SFJvTjolS/9Lhl53bADSD2zy7qLJtMHVeUjPtMroPrsCoxfuUr+gTgXadgU
 vvCk3uv2rt8s5TNzc5uog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TB3XKGiJVHU=;Dn5ef0RC/Cu92FUpQEhIcXouRNk
 y8wdnhVHScm9fIRptZeDXzEZJdud2ngEqgxGdQ78B82YCGZGqehX0tO41rLwT05L5F10754Pz
 6R4QDYQvGbdzfgrdST4GcoX7O0aWDMUWXYQpuYc7zCfK10+hJTz5ZyMKKNT11gKeqLS3602cp
 3ve4h4Uh5Ds31dp37PchPbrqVhxfGs3778JHYKGZWCJ8RYg8yGdAsun1K+qgZ3eyCKP6d+TUY
 6ZmBv8AWZIh246aTXzyvxSspRhjU6h8915rUp+dQJdrXfbfDjifSZHpPp6o+sKMVU7p4U38rt
 Eht7o995iYk7qu8lmRpVkgEx241gnhgWxjtvUVBfjM11oHLHo311kzcGcksg2d4HhXbF8zWvU
 o0bfp4R4xWd5flqnkx0O8L2bom8VTUYNWXw82IriyKCIwrWMFZLEJIINVvnb7Xc64dYuheT6i
 nhi0UDJZEgZ0QnLIfQ7T/N3CTlTLdyeBdn7fNnJM0L0gavHctKtTxRGX4n3B2CUGpvxJXPULQ
 rsmE4hJ7Lssw7SdKr37PjUCVFH/7U+m8l0t1UO0zR5yWVNnm2P2d+zzg+jRMyQo/2Y+Xxdb00
 ZyrpEYizUTbfcHudxGhYiKQ28p3LNduFbSMViXKJE/FSmB+souKMf2x+PTEjLdeysFSwUc/eJ
 XMSo8hVEQXQLSFi7+7ulS3ih6tknCpjv7IuZ1M7Hn/u0J6bHMkKz8a6QYCXfSf3LY+Xm9c3Wr
 j3H1YPb1Ajc2EaXTVsXIgCAKSb+gJ+n9Ptig6HaEsHE8ZnNSejoFacjgznV6otV5KZjI1xa8G
 RZc5dUbQxymWKwd2L7bTIVeyfKD9ZbcJR1zayOfB4QqFitT8ZN63mFlUFgnftWHyMmXCH2gWA
 HRaHfp0rEykBQ+J28xCniNO6xDpVbsss6NYJA4IiwMi9fb7WbRbNbwhdNNhO3B3kuqy+x5cbS
 41u79vyTNrF+6Jj4Favz13lcB74ujO8klTsrixKTmYBD+etkecPENRk717esyxDhHxM8NdJxV
 ezatiTy30AjVOS8wsoAZZqEZjkFNdnolPMc/o1lR/gK5DRLLWebsuhR1mFpWaZk6Xv1Kj56jF
 Vx90L6Nbc=

Since linux-next-6.13-rc2 I noticed that my debian unstable (amd64 on an M=
SI Alpha 15
laptop) system hangs when booting. After removing the "quiet" parameter fr=
om the
kernel command line I found that booting gets stuck at (this error can be =
avoided by
pressing some keys while booting!):

Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... _

I bisected this between v6.12 and v6.13-rc12 and the first bad commit was
894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")=
.

Reverting commit 894d1b3db41c fixes the issue in v6.13-rc2 (I posted the
whole patch to show the conflict resolutions):

commit ee75d356c88bded887684453be7985ed0234456d
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Wed Dec 11 18:43:48 2024 +0100

    Revert "locking/mutex: Remove wakeups from under mutex::wait_lock"

    This reverts commit 894d1b3db41cf7e6ae0304429a1747b3c3f390bc.

    This solves the boot hang issue in v6.13-rc2.

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index d62cca5ed8f4..5722467f2737 100644
=2D-- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -922,7 +922,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flag=
s, ktime_t *time, int tryl
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	struct futex_q q =3D futex_q_init;
-	DEFINE_WAKE_Q(wake_q);
 	int res, ret;

 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
@@ -1019,11 +1018,8 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int f=
lags, ktime_t *time, int tryl
 	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
 	 * it sees the futex_q::pi_state.
 	 */
-	ret =3D __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, c=
urrent, &wake_q);
-	preempt_disable();
+	ret =3D __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, c=
urrent);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	wake_up_q(&wake_q);
-	preempt_enable();

 	if (ret) {
 		if (ret =3D=3D 1)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3302e52f0c96..28222f0b510b 100644
=2D-- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -550,7 +550,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
-	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
 	struct ww_mutex *ww;
 	unsigned long flags;
@@ -602,7 +601,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 	 */
 	if (__mutex_trylock(lock)) {
 		if (ww_ctx)
-			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
+			__ww_mutex_check_waiters(lock, ww_ctx);

 		goto skip_wait;
 	}
@@ -622,7 +621,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 		 * Add in stamp order, waking up waiters that must kill
 		 * themselves.
 		 */
-		ret =3D __ww_mutex_add_waiter(&waiter, lock, ww_ctx, &wake_q);
+		ret =3D __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
 		if (ret)
 			goto err_early_kill;
 	}
@@ -658,10 +657,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int =
state, unsigned int subclas
 		}

 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		/* Make sure we do wakeups before calling schedule */
-		wake_up_q(&wake_q);
-		wake_q_init(&wake_q);
-
 		schedule_preempt_disabled();

 		first =3D __mutex_waiter_is_first(lock, &waiter);
@@ -695,7 +690,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 		 */
 		if (!ww_ctx->is_wait_die &&
 		    !__mutex_waiter_is_first(lock, &waiter))
-			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
+			__ww_mutex_check_waiters(lock, ww_ctx);
 	}

 	__mutex_remove_waiter(lock, &waiter);
@@ -711,7 +706,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 		ww_mutex_lock_acquired(ww, ww_ctx);

 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;

@@ -723,7 +717,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
-	wake_up_q(&wake_q);
 	preempt_enable();
 	return ret;
 }
@@ -935,10 +928,9 @@ static noinline void __sched __mutex_unlock_slowpath(=
struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);

-	preempt_disable();
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
 	wake_up_q(&wake_q);
-	preempt_enable();
 }

 #ifndef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ac1365afcc4a..43f2e5042be3 100644
=2D-- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -34,15 +34,13 @@

 static inline int __ww_mutex_add_waiter(struct rt_mutex_waiter *waiter,
 					struct rt_mutex *lock,
-					struct ww_acquire_ctx *ww_ctx,
-					struct wake_q_head *wake_q)
+					struct ww_acquire_ctx *ww_ctx)
 {
 	return 0;
 }

 static inline void __ww_mutex_check_waiters(struct rt_mutex *lock,
-					    struct ww_acquire_ctx *ww_ctx,
-					    struct wake_q_head *wake_q)
+					    struct ww_acquire_ctx *ww_ctx)
 {
 }

@@ -1203,8 +1201,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt=
_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter,
 					   struct task_struct *task,
 					   struct ww_acquire_ctx *ww_ctx,
-					   enum rtmutex_chainwalk chwalk,
-					   struct wake_q_head *wake_q)
+					   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner =3D rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter =3D waiter;
@@ -1248,10 +1245,7 @@ static int __sched task_blocks_on_rt_mutex(struct r=
t_mutex_base *lock,

 		/* Check whether the waiter should back out immediately */
 		rtm =3D container_of(lock, struct rt_mutex, rtmutex);
-		preempt_disable();
-		res =3D __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
-		wake_up_q(wake_q);
-		preempt_enable();
+		res =3D __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
 		if (res) {
 			raw_spin_lock(&task->pi_lock);
 			rt_mutex_dequeue(lock, waiter);
@@ -1681,14 +1675,12 @@ static void __sched rt_mutex_handle_deadlock(int r=
es, int detect_deadlock,
  * @state:	The task state for sleeping
  * @chwalk:	Indicator whether full or partial chainwalk is requested
  * @waiter:	Initializer waiter for blocking
- * @wake_q:	The wake_q to wake tasks after we release the wait_lock
  */
 static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				       struct ww_acquire_ctx *ww_ctx,
 				       unsigned int state,
 				       enum rtmutex_chainwalk chwalk,
-				       struct rt_mutex_waiter *waiter,
-				       struct wake_q_head *wake_q)
+				       struct rt_mutex_waiter *waiter)
 {
 	struct rt_mutex *rtm =3D container_of(lock, struct rt_mutex, rtmutex);
 	struct ww_mutex *ww =3D ww_container_of(rtm);
@@ -1699,7 +1691,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mut=
ex_base *lock,
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
 		if (build_ww_mutex() && ww_ctx) {
-			__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
+			__ww_mutex_check_waiters(rtm, ww_ctx);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
 		return 0;
@@ -1709,7 +1701,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mut=
ex_base *lock,

 	trace_contention_begin(lock, LCB_F_RT);

-	ret =3D task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, w=
ake_q);
+	ret =3D task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
 	if (likely(!ret))
 		ret =3D rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);

@@ -1717,7 +1709,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mut=
ex_base *lock,
 		/* acquired the lock */
 		if (build_ww_mutex() && ww_ctx) {
 			if (!ww_ctx->is_wait_die)
-				__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
+				__ww_mutex_check_waiters(rtm, ww_ctx);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
 	} else {
@@ -1739,8 +1731,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mut=
ex_base *lock,

 static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 					     struct ww_acquire_ctx *ww_ctx,
-					     unsigned int state,
-					     struct wake_q_head *wake_q)
+					     unsigned int state)
 {
 	struct rt_mutex_waiter waiter;
 	int ret;
@@ -1749,7 +1740,7 @@ static inline int __rt_mutex_slowlock_locked(struct =
rt_mutex_base *lock,
 	waiter.ww_ctx =3D ww_ctx;

 	ret =3D __rt_mutex_slowlock(lock, ww_ctx, state, RT_MUTEX_MIN_CHAINWALK,
-				  &waiter, wake_q);
+				  &waiter);

 	debug_rt_mutex_free_waiter(&waiter);
 	return ret;
@@ -1765,7 +1756,6 @@ static int __sched rt_mutex_slowlock(struct rt_mutex=
_base *lock,
 				     struct ww_acquire_ctx *ww_ctx,
 				     unsigned int state)
 {
-	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 	int ret;

@@ -1787,11 +1777,8 @@ static int __sched rt_mutex_slowlock(struct rt_mute=
x_base *lock,
 	 * irqsave/restore variants.
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
-	preempt_disable();
+	ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
 	rt_mutex_post_schedule();

 	return ret;
@@ -1817,11 +1804,8 @@ static __always_inline int __rt_mutex_lock(struct r=
t_mutex_base *lock,
 /**
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
  * @lock:	The underlying RT mutex
- * @wake_q:	The wake_q to wake tasks after we release the wait_lock
  */
-static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
-					   struct wake_q_head *wake_q)
-	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
+static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter waiter;
 	struct task_struct *owner;
@@ -1838,7 +1822,7 @@ static void __sched rtlock_slowlock_locked(struct rt=
_mutex_base *lock,

 	trace_contention_begin(lock, LCB_F_RT);

-	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAIN=
WALK, wake_q);
+	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAIN=
WALK);

 	for (;;) {
 		/* Try to acquire the lock again */
@@ -1849,11 +1833,7 @@ static void __sched rtlock_slowlock_locked(struct r=
t_mutex_base *lock,
 			owner =3D rt_mutex_owner(lock);
 		else
 			owner =3D NULL;
-		preempt_disable();
 		raw_spin_unlock_irq(&lock->wait_lock);
-		wake_up_q(wake_q);
-		wake_q_init(wake_q);
-		preempt_enable();

 		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
 			schedule_rtlock();
@@ -1878,14 +1858,10 @@ static void __sched rtlock_slowlock_locked(struct =
rt_mutex_base *lock,
 static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base =
*lock)
 {
 	unsigned long flags;
-	DEFINE_WAKE_Q(wake_q);

 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	rtlock_slowlock_locked(lock, &wake_q);
-	preempt_disable();
+	rtlock_slowlock_locked(lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
 }

 #endif /* RT_MUTEX_BUILD_SPINLOCKS */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 33ea31d6a7b3..7e79258feb27 100644
=2D-- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -275,7 +275,6 @@ void __sched rt_mutex_proxy_unlock(struct rt_mutex_bas=
e *lock)
  * @lock:		the rt_mutex to take
  * @waiter:		the pre-initialized rt_mutex_waiter
  * @task:		the task to prepare
- * @wake_q:		the wake_q to wake tasks after we release the wait_lock
  *
  * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
  * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
@@ -292,8 +291,7 @@ void __sched rt_mutex_proxy_unlock(struct rt_mutex_bas=
e *lock)
  */
 int __sched __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 					struct rt_mutex_waiter *waiter,
-					struct task_struct *task,
-					struct wake_q_head *wake_q)
+					struct task_struct *task)
 {
 	int ret;

@@ -304,7 +302,7 @@ int __sched __rt_mutex_start_proxy_lock(struct rt_mute=
x_base *lock,

 	/* We enforce deadlock detection for futexes */
 	ret =3D task_blocks_on_rt_mutex(lock, waiter, task, NULL,
-				      RT_MUTEX_FULL_CHAINWALK, wake_q);
+				      RT_MUTEX_FULL_CHAINWALK);

 	if (ret && !rt_mutex_owner(lock)) {
 		/*
@@ -343,16 +341,12 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mute=
x_base *lock,
 				      struct task_struct *task)
 {
 	int ret;
-	DEFINE_WAKE_Q(wake_q);

 	raw_spin_lock_irq(&lock->wait_lock);
-	ret =3D __rt_mutex_start_proxy_lock(lock, waiter, task, &wake_q);
+	ret =3D __rt_mutex_start_proxy_lock(lock, waiter, task);
 	if (unlikely(ret))
 		remove_waiter(lock, waiter);
-	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);
-	wake_up_q(&wake_q);
-	preempt_enable();

 	return ret;
 }
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_comm=
on.h
index c38a2d2d4a7e..1162e07cdaea 100644
=2D-- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -83,8 +83,7 @@ extern void rt_mutex_init_proxy_locked(struct rt_mutex_b=
ase *lock,
 extern void rt_mutex_proxy_unlock(struct rt_mutex_base *lock);
 extern int __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
-				     struct task_struct *task,
-				     struct wake_q_head *);
+				     struct task_struct *task);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 9f4322c07486..34a59569db6b 100644
=2D-- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -69,7 +69,6 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *=
rwb,
 				      unsigned int state)
 {
 	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
-	DEFINE_WAKE_Q(wake_q);
 	int ret;

 	rwbase_pre_schedule();
@@ -111,7 +110,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt=
 *rwb,
 	 * For rwlocks this returns 0 unconditionally, so the below
 	 * !ret conditionals are optimized out.
 	 */
-	ret =3D rwbase_rtmutex_slowlock_locked(rtm, state, &wake_q);
+	ret =3D rwbase_rtmutex_slowlock_locked(rtm, state);

 	/*
 	 * On success the rtmutex is held, so there can't be a writer
@@ -122,12 +121,7 @@ static int __sched __rwbase_read_lock(struct rwbase_r=
t *rwb,
 	 */
 	if (!ret)
 		atomic_inc(&rwb->readers);
-
-	preempt_disable();
 	raw_spin_unlock_irq(&rtm->wait_lock);
-	wake_up_q(&wake_q);
-	preempt_enable();
-
 	if (!ret)
 		rwbase_rtmutex_unlock(rtm);

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2ddb827e3bea..2bbb6eca5144 100644
=2D-- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1413,8 +1413,8 @@ static inline void __downgrade_write(struct rw_semap=
hore *sem)
 #define rwbase_rtmutex_lock_state(rtm, state)		\
 	__rt_mutex_lock(rtm, state)

-#define rwbase_rtmutex_slowlock_locked(rtm, state, wq)	\
-	__rt_mutex_slowlock_locked(rtm, NULL, state, wq)
+#define rwbase_rtmutex_slowlock_locked(rtm, state)	\
+	__rt_mutex_slowlock_locked(rtm, NULL, state)

 #define rwbase_rtmutex_unlock(rtm)			\
 	__rt_mutex_unlock(rtm)
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index db1e11b45de6..d1cf8b2b6dca 100644
=2D-- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -162,10 +162,9 @@ rwbase_rtmutex_lock_state(struct rt_mutex_base *rtm, =
unsigned int state)
 }

 static __always_inline int
-rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int st=
ate,
-			       struct wake_q_head *wake_q)
+rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int st=
ate)
 {
-	rtlock_slowlock_locked(rtm, wake_q);
+	rtlock_slowlock_locked(rtm);
 	return 0;
 }

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 37f025a096c9..1abd385e53f7 100644
=2D-- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -275,7 +275,7 @@ __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acqu=
ire_ctx *b)
  */
 static bool
 __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
-	       struct ww_acquire_ctx *ww_ctx, struct wake_q_head *wake_q)
+	       struct ww_acquire_ctx *ww_ctx)
 {
 	if (!ww_ctx->is_wait_die)
 		return false;
@@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER=
 *waiter,
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
-		wake_q_add(wake_q, waiter->task);
+		wake_up_process(waiter->task);
 	}

 	return true;
@@ -299,8 +299,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER=
 *waiter,
  */
 static bool __ww_mutex_wound(struct MUTEX *lock,
 			     struct ww_acquire_ctx *ww_ctx,
-			     struct ww_acquire_ctx *hold_ctx,
-			     struct wake_q_head *wake_q)
+			     struct ww_acquire_ctx *hold_ctx)
 {
 	struct task_struct *owner =3D __ww_mutex_owner(lock);

@@ -332,7 +331,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner !=3D current)
-			wake_q_add(wake_q, owner);
+			wake_up_process(owner);

 		return true;
 	}
@@ -353,8 +352,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
  * The current task must not be on the wait list.
  */
 static void
-__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ct=
x,
-			 struct wake_q_head *wake_q)
+__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ct=
x)
 {
 	struct MUTEX_WAITER *cur;

@@ -366,8 +364,8 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww=
_acquire_ctx *ww_ctx,
 		if (!cur->ww_ctx)
 			continue;

-		if (__ww_mutex_die(lock, cur, ww_ctx, wake_q) ||
-		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx, wake_q))
+		if (__ww_mutex_die(lock, cur, ww_ctx) ||
+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
 			break;
 	}
 }
@@ -379,7 +377,6 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww=
_acquire_ctx *ww_ctx,
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ct=
x *ctx)
 {
-	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;

 	ww_mutex_lock_acquired(lock, ctx);
@@ -410,11 +407,8 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, =
struct ww_acquire_ctx *ctx)
 	 * die or wound us.
 	 */
 	lock_wait_lock(&lock->base, &flags);
-	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
-	preempt_disable();
+	__ww_mutex_check_waiters(&lock->base, ctx);
 	unlock_wait_lock(&lock->base, &flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
 }

 static __always_inline int
@@ -496,8 +490,7 @@ __ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX=
_WAITER *waiter,
 static inline int
 __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		      struct MUTEX *lock,
-		      struct ww_acquire_ctx *ww_ctx,
-		      struct wake_q_head *wake_q)
+		      struct ww_acquire_ctx *ww_ctx)
 {
 	struct MUTEX_WAITER *cur, *pos =3D NULL;
 	bool is_wait_die;
@@ -541,7 +534,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		pos =3D cur;

 		/* Wait-Die: ensure younger waiters die. */
-		__ww_mutex_die(lock, cur, ww_ctx, wake_q);
+		__ww_mutex_die(lock, cur, ww_ctx);
 	}

 	__ww_waiter_add(lock, waiter, pos);
@@ -559,7 +552,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		 * such that either we or the fastpath will wound @ww->ctx.
 		 */
 		smp_mb();
-		__ww_mutex_wound(lock, ww_ctx, ww->ctx, wake_q);
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
 	}

 	return 0;

I tried to debug this with CONFIG_LOCKDEP=3Dy in v6.13-rc2, but using CONF=
IG_LOCKDEP=3Dy
makes the hangs disappear or far less likely, and I get this warning
(2 examples from two boots):

[   17.203857] [   T1337] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[   17.203860] [   T1337] turning off the locking correctness validator.
[   17.203862] [   T1337] CPU: 10 UID: 1000 PID: 1337 Comm: emacs Not tain=
ted 6.13.0-rc2-debug #352
[   17.203864] [   T1337] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[   17.203866] [   T1337] Call Trace:
[   17.203867] [   T1337]  <TASK>
[   17.203869] [   T1337]  dump_stack_lvl+0x5b/0x80
[   17.203874] [   T1337]  __lock_acquire+0x1f36/0x2590
[   17.203878] [   T1337]  lock_acquire+0xc5/0x2d0
[   17.203880] [   T1337]  ? rcu_note_context_switch+0x120/0x4b0
[   17.203884] [   T1337]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.203886] [   T1337]  ? lock_acquire+0xc5/0x2d0
[   17.203889] [   T1337]  _raw_spin_lock+0x2b/0x40
[   17.203892] [   T1337]  ? rcu_note_context_switch+0x120/0x4b0
[   17.203894] [   T1337]  rcu_note_context_switch+0x120/0x4b0
[   17.203896] [   T1337]  ? lock_is_held_type+0x85/0xf0
[   17.203898] [   T1337]  __schedule+0x97/0x1590
[   17.203902] [   T1337]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.203904] [   T1337]  ? mark_held_locks+0x40/0x70
[   17.203907] [   T1337]  ? lockdep_hardirqs_on_prepare+0xd7/0x190
[   17.203909] [   T1337]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.203912] [   T1337]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   17.203916] [   T1337]  preempt_schedule+0x2e/0x50
[   17.203919] [   T1337]  preempt_schedule_thunk+0x1a/0x30
[   17.203923] [   T1337]  migrate_disable+0x5c/0x70
[   17.203926] [   T1337]  ext4_es_lookup_extent+0x7b/0x2b0 [ext4]
[   17.203951] [   T1337]  ext4_map_blocks+0x1cc/0x4d0 [ext4]
[   17.203973] [   T1337]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.203976] [   T1337]  ? xa_load+0xc8/0x1a0
[   17.203980] [   T1337]  ext4_mpage_readpages+0x2d5/0x660 [ext4]
[   17.204006] [   T1337]  read_pages+0x67/0x240
[   17.204013] [   T1337]  page_cache_ra_unbounded+0x13b/0x1b0
[   17.204017] [   T1337]  filemap_fault+0x326/0x1120
[   17.204021] [   T1337]  ? lock_acquire+0xc5/0x2d0
[   17.204026] [   T1337]  __do_fault+0x2e/0x170
[   17.204029] [   T1337]  do_fault+0x3ee/0x850
[   17.204032] [   T1337]  __handle_mm_fault+0x2ac/0x400
[   17.204038] [   T1337]  handle_mm_fault+0x96/0x280
[   17.204041] [   T1337]  exc_page_fault+0x27d/0x910
[   17.204045] [   T1337]  asm_exc_page_fault+0x26/0x30
[   17.204048] [   T1337] RIP: 0033:0x7f015b0f06d9
[   17.204051] [   T1337] Code: 73 3b 66 66 2e 0f 1f 84 00 00 00 00 00 0f =
1f 40 00 48 8b 32 8b 4a 08 4c 01 e6 48 83 f9 26 74 0a 48 83 f9 08 0f 85 16=
 1e 00 00 <48> 8b 4a 10 48 83 c2 18 4c 01 e1 48 89 0e 48 39 da 72 d4 4d 8b=
 9f
[   17.204053] [   T1337] RSP: 002b:00007ffe8857aac0 EFLAGS: 00010246
[   17.204055] [   T1337] RAX: 00007f015664b868 RBX: 00007f0156972f18 RCX:=
 0000000000000008
[   17.204056] [   T1337] RDX: 00007f01566eaff0 RSI: 00007f0158994480 RDI:=
 00007ffe8857ab60
[   17.204057] [   T1337] RBP: 00007ffe8857abd0 R08: 00007f0156974838 R09:=
 00007f0156974838
[   17.204058] [   T1337] R10: 00007f0156977748 R11: 00007f015664b000 R12:=
 00007f015664b000
[   17.204059] [   T1337] R13: 0000000000000000 R14: 00007f0158d56aa0 R15:=
 00007f0158d56aa0
[   17.204062] [   T1337]  </TASK>


[   17.106212] [   T1346] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[   17.106215] [   T1346] turning off the locking correctness validator.
[   17.106216] [   T1346] CPU: 2 UID: 1000 PID: 1346 Comm: wireplumber Not=
 tainted 6.13.0-rc2-debug #352
[   17.106220] [   T1346] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[   17.106221] [   T1346] Call Trace:
[   17.106223] [   T1346]  <TASK>
[   17.106224] [   T1346]  dump_stack_lvl+0x5b/0x80
[   17.106229] [   T1346]  __lock_acquire+0x1f36/0x2590
[   17.106233] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106236] [   T1346]  ? _raw_spin_unlock_irqrestore+0x3f/0x50
[   17.106239] [   T1346]  lock_acquire+0xc5/0x2d0
[   17.106241] [   T1346]  ? __wait_for_common+0x3a/0x190
[   17.106244] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106247] [   T1346]  ? usb_hcd_submit_urb+0x351/0xc50 [usbcore]
[   17.106258] [   T1346]  _raw_spin_lock_irq+0x33/0x50
[   17.106259] [   T1346]  ? __wait_for_common+0x3a/0x190
[   17.106262] [   T1346]  __wait_for_common+0x3a/0x190
[   17.106264] [   T1346]  ? hrtimer_nanosleep_restart+0x160/0x160
[   17.106266] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106268] [   T1346]  ? lockdep_init_map_type+0x5c/0x220
[   17.106271] [   T1346]  usb_start_wait_urb+0x80/0x160 [usbcore]
[   17.106280] [   T1346]  ? end_buffer_async_write+0x30/0xc0
[   17.106284] [   T1346]  usb_control_msg+0xe0/0x140 [usbcore]
[   17.106291] [   T1346]  hub_ext_port_status+0x86/0x170 [usbcore]
[   17.106300] [   T1346]  usb_port_resume+0xd3/0x850 [usbcore]
[   17.106307] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106310] [   T1346]  usb_generic_driver_resume+0x18/0x50 [usbcore]
[   17.106319] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106321] [   T1346]  usb_resume_both+0xad/0x180 [usbcore]
[   17.106329] [   T1346]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
[   17.106336] [   T1346]  __rpm_callback+0x3f/0x130
[   17.106338] [   T1346]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
[   17.106344] [   T1346]  rpm_callback+0x50/0x60
[   17.106346] [   T1346]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
[   17.106352] [   T1346]  rpm_resume+0x572/0x7a0
[   17.106354] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106356] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106359] [   T1346]  rpm_resume+0x2eb/0x7a0
[   17.106361] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106362] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106365] [   T1346]  __pm_runtime_resume+0x41/0x70
[   17.106367] [   T1346]  usb_autopm_get_interface+0x16/0x50 [usbcore]
[   17.106375] [   T1346]  uvc_v4l2_open+0x33/0xe0 [uvcvideo]
[   17.106380] [   T1346]  v4l2_open+0xac/0x100 [videodev]
[   17.106387] [   T1346]  chrdev_open+0xb4/0x210
[   17.106390] [   T1346]  ? __unregister_chrdev+0x40/0x40
[   17.106392] [   T1346]  do_dentry_open+0x17d/0x4e0
[   17.106395] [   T1346]  vfs_open+0x2f/0xf0
[   17.106398] [   T1346]  path_openat+0x737/0xcc0
[   17.106400] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106403] [   T1346]  do_filp_open+0xc2/0x170
[   17.106407] [   T1346]  ? srso_alias_return_thunk+0x5/0xfbef5
[   17.106409] [   T1346]  ? rt_mutex_slowunlock+0x3da/0x480
[   17.106413] [   T1346]  ? alloc_fd+0x125/0x200
[   17.106417] [   T1346]  do_sys_openat2+0x8f/0xc0
[   17.106421] [   T1346]  __x64_sys_openat+0x50/0xa0
[   17.106424] [   T1346]  do_syscall_64+0x72/0x180
[   17.106427] [   T1346]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[   17.106430] [   T1346] RIP: 0033:0x7fe29cbddbb8
[   17.106432] [   T1346] Code: 48 89 44 24 20 75 96 44 89 54 24 0c e8 a1 =
b6 f8 ff 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00=
 00 0f 05 <48> 3d 00 f0 ff ff 77 30 44 89 c7 89 44 24 0c e8 f4 b6 f8 ff 8b=
 44
[   17.106434] [   T1346] RSP: 002b:00007ffc764ef420 EFLAGS: 00000293 ORIG=
_RAX: 0000000000000101
[   17.106437] [   T1346] RAX: ffffffffffffffda RBX: 0000000000000802 RCX:=
 00007fe29cbddbb8
[   17.106439] [   T1346] RDX: 0000000000000802 RSI: 0000561fa83554c8 RDI:=
 00000000ffffff9c
[   17.106441] [   T1346] RBP: 0000561fa83554c8 R08: 0000000000000000 R09:=
 0000000000000480
[   17.106442] [   T1346] R10: 0000000000000000 R11: 0000000000000293 R12:=
 0000561fa83554c8
[   17.106443] [   T1346] R13: 0000561fa83554c8 R14: 0000000000000000 R15:=
 00007fe29cdb32c0
[   17.106448] [   T1346]  </TASK>



Bert Karwatzki


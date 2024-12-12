Return-Path: <linux-kernel+bounces-443039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C659B9EE615
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C7A2871A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80932215762;
	Thu, 12 Dec 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="p5qUNjSx"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB9212FBF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004641; cv=none; b=IBQkI9vX+cEnf+blWUI2yB7AJ9HpuCcqT1ZqaeYg2ntJlYPcankUppoKV8HvStL7/8cwYXiZZJMmR+DbrWRkwGDZCX+eZLQyciQ23j+sZZO1geoln1OTRLx1UyZ9iThOCWiQ6nPYXLPom6rwIkkqO8gd6uX3H3x03NySzJY30Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004641; c=relaxed/simple;
	bh=EjbOGAZ+TEMMya1ZZATaMN51gKacKT4A+77hkRjb3K0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uYeFq0e/YMKjrmol0/4PGEZpGhsgzTHGrep8a1Q3bIWBssykIlZrQcswkcQooeAuA0zIfpfTxV/9/DWQeqcgbQzv+NCcfLK3SR9vz1PTt0dFcSw6culdRxtCczR/+/YRHD4FXwfyYoXUm/1uxvs6i01oebLWSrwwxlxWnF5V2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=p5qUNjSx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734004612; x=1734609412; i=spasswolf@web.de;
	bh=pQ6qlSdNKTTq5+H5D3pt9PzM5Y8Tl98rMzIxzrGRMoA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p5qUNjSxWyPKeaCNhZhcIm6rBkNQqJF//xuHWoSv/yV64yv3U0+vu4XBVEurMTUf
	 j1ru9hfyT9UGoQNRypqg1PXpcNLdty5a38kntC4dsY1ifZZsYvujU6XWw9y9CRFAP
	 DGEHaJ4snczV7saoFjRFKHSOETUjCKdSPjbFp01hV69xOEpgfwFIDvIj4QRo3Xmcf
	 o5nkckDXnNGqIQBpTCcte/t33TXmA+gghIlf06cZpYn5acfgrK0lkrUy3MoJTTxif
	 hJSzNNxBn4bGkclYwbROoutviy8/RDsIDn3ngUl7fYAnl9YvRK4ywH8+QTOaHR+83
	 di0qH0hzin3YcSDLug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWkj-1tq6YJ2EE7-00bOqQ; Thu, 12
 Dec 2024 12:56:52 +0100
Message-ID: <ba23cfd0b7310504598b711311a7c08a64d1e13d.camel@web.de>
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
Date: Thu, 12 Dec 2024 12:56:50 +0100
In-Reply-To: <5325ccfa4f7a0a9925e8133612528237966c2145.camel@web.de>
References: <20241211213527.3278-1-spasswolf@web.de>
		 <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
		 <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com>
		 <cf6c7a80e3a54e1060f89cf7bc8c741214d1665a.camel@web.de>
		 <CANDhNCqP+zGH5jyfWHeEpALuAxbyc_+XOx5CHoRs_tw4DVjDww@mail.gmail.com>
		 <CANDhNCrKhwVBEjX5m46Mwrm9uixBkS8MSXKyWxkD=-8Urx7nGg@mail.gmail.com>
	 <5325ccfa4f7a0a9925e8133612528237966c2145.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iTRjzjn+T1QigkJz0flX1Y2s7yvoWvu3lUuDFR2vkvDevNs0H7b
 N/CO1MZuw8ePyXyr0NXBRFlyFqZAnbVkTSu+KrcyZAPx0o91vbDotiqpBVbg6/yVbJXlf5d
 5DyV9q59u4lpUM6kv4eamC1enDUtmdT3Yk/wtoNcBOq3Ws96CPLSzaVsBBSt91iC/YjlAAG
 f8Sz0RyHZQoWkVXuaST8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o+xDnXyAZSE=;bN63zlbRC8u0yFcFBoFklkBnAru
 yZO5Xa7ndXqjvgPwX1daDzgpmoT+ag8iaRA5WFfEwjoaT87qs7SjmHj7S0oJMxzPUTG8ISv8C
 HP0OMv8sUBYjSN1onwIGY4/szK0DRjMycdAP/8a03+GkjhEAGzkIFCubwdFGATseAP3ZMlZ/g
 F85R4kLLbuHOowbCWoWXLG1LZQbgGU19qsiRoObIXckF6IFoDMuhoP6vBd9MDtePz0zJeEhPt
 E2ULKlz2Z1OrIUNN1yYRv8Q2WbTsvaEvSjYnM/U2wgEusbQlo8reCxyQfgYdd7dZe3ZP3Y2TB
 S+DPWfMl7NgRVJbtr4aWfsQnwVdYTSchWQ5bJkDTE++RD+ooHarX+RVBtt2JQL/x31ffiE788
 JRFkQDYCsiXJhOqXidorPyS+K72kd/WGHYM/+ibSyg/dkkZwAXCxHM9Mws9leOIe//VaPXbQO
 EbZnOWrmXrXnSEXLxKHILBR/DuomEv62C6a5nkpY83zrUmFWEbliO8x+frVCo1bFjCKY2SPA5
 zXzOkcqZVUgXc9QreV+wZJinwlffKwcknyGZUxdeoCtUpQSZE7gN7ggGvj8GHtuCx44Hs/UBR
 E6DKI/atzU9M6dnKjNzkEDJ9NkTA0k1g8FgB1r8exRJ8U8ClDueZKof7sU2+xl66mOIFW+2wK
 X6voKhJdtLOXCgvvQUjZuLbVmzLkgv1eO3jan/bBXu6zN1vQvHz6R/GpSC2+9OL4RZrrh4Tb8
 2oqyKNwGp2iOfxwcERBfSjdKxOSAFG5NmvuzcMD/KmSFyzm+rf06/DSN26gcl9RA5AoxAT8a0
 WdurFaw3nCA+oMnwuyNCv3j5lcjS5A14ma5QVmgglE8us/FKu5zkbsc9pc1fdvMuZmnC7XS/t
 fmNysHXtXpwEzqaBXQi5BYlC1keDNRoJNNlOtFyHVZCGKxvAzOcDN8q0eisZQdZhFTE/w8HXQ
 oeVz7twEPBaGFXDbrir+uBEhjOSLCYgAlK8snvSEnjenW5xZPVIKzHHuus21ly32I58jDXGXt
 N1LxtrqNmk7kVESBRpiPeae5Nem3wp1ivKw8nEH5Uwrtn3sJ0ywPyZWXkBcM8lbFLlJ3FW6sq
 STLlLOzwDvszZnMDV9dyH1imapoUs5jJ1y3hX3WtgoDcM5DFOjKrChvo2yyiZ/utSMmURhZuI
 =

Am Donnerstag, dem 12.12.2024 um 11:31 +0100 schrieb Bert Karwatzki:
> Am Mittwoch, dem 11.12.2024 um 23:40 -0800 schrieb John Stultz:
> > On Wed, Dec 11, 2024 at 6:41=E2=80=AFPM John Stultz <jstultz@google.co=
m> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 4:17=E2=80=AFPM Bert Karwatzki <spasswolf@we=
b.de> wrote:
> > > > Am Mittwoch, dem 11.12.2024 um 15:14 -0800 schrieb John Stultz:
> > > > > On Wed, Dec 11, 2024 at 2:46=E2=80=AFPM Bert Karwatzki <spasswol=
f@web.de> wrote:
> > > > > >
> > > > > > Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karwat=
zki:
> > > > > > > I have confirmed that I that linux-next-20241210 is fixed by=
 the same revert
> > > > > > > as v6.13-rc2 (ten boots without incident is the criterion fo=
r a good commit)
> > > > > > >
> > > > > > >
> > > > > > > Bert Karwatzki
> > > > > >
> > > > > > Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've jus=
t checked v6.13-rc2
> > > > > > without the revert and the following preempt settings and got =
10 clean boots:
> > > > > >
> > > > >
> > > > > Hrm. That matches the case where the fix here helped:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
> > > > >
> > > > >
> > > > > I'm still working on getting a minimal delta from your config bo=
oting
> > > > > in my environment, but in the meantime, I'd be curious if the
> > > > > following reduced revert helps?
> > > > >   https://github.com/johnstultz-work/linux-dev/commit/60c60f8567=
0fb1f4708adbe55e15ab918d96f9f0
> > > > >
> > > > > Basically just trying to clarify if the problem is moving the wa=
keup
> > > > > to the wake_q or if some other interaction (maybe with the
> > > > > preempt_disables) could be causing the issue.
> > > > > (I'm assuming you have 82f9cc094975 applied when you test with t=
hat change)
> > > > >
> > > >
> > > > I tested linux-next-20241210 (which includes 82f9cc094975) with yo=
ur patch
> > > >
> > > > diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> > > > index 37f025a096c9..724d4c871cf6 100644
> > > > --- a/kernel/locking/ww_mutex.h
> > > > +++ b/kernel/locking/ww_mutex.h
> > > > @@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTE=
X_WAITER
> > > > *waiter,
> > > >  #ifndef WW_RT
> > > >                 debug_mutex_wake_waiter(lock, waiter);
> > > >  #endif
> > > > -               wake_q_add(wake_q, waiter->task);
> > > > +               wake_up_process(waiter->task);
> > > >         }
> > > >
> > > >         return true;
> > > > @@ -332,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *loc=
k,
> > > >                  * wakeup pending to re-read the wounded state.
> > > >                  */
> > > >                 if (owner !=3D current)
> > > > -                       wake_q_add(wake_q, owner);
> > > > +                       wake_up_process(owner);
> > > >
> > > >                 return true;
> > > >         }
> > > >
> > > > and this fixes the issue for me.
> > >
> > > Ok, thanks for validating that!  Hrm. Ok, I suspect I'm missing a pa=
th
> > > in rtmutex.c that calls into __schedule() before we pop up to the
> > > point where we actually wake the wake_q.
> > >
> > > I may have found one or two spots that look likely, and I believe I'=
ve
> > > also managed to reproduce your problem using the test-ww_mutex drive=
r.
> > >
> > > So I'm working up a proper patch and will share for testing here soo=
n.
> >
> > Ok, could you try the patch here:
> > https://github.com/johnstultz-work/linux-dev/commit/3c902b92c88122cd03=
4937e8d40930bac254a7c5
> >
> > I've repushed to the test branch I shared earlier, so its against
> > 6.13-rc2 + fix that has landed upstream + test fix above ( + another
> > patch that makes stressing the ww_mutexes easier):
> > https://github.com/johnstultz-work/linux-dev/commits/debug/894d1b3db41=
c-hang-bert/
> >
> > Let me know if you still have issues with this.
> > thanks
> > -john
>
> I cherry-picked your two patches on top of linux-next-20241210:
>
> 2029cb31eae9 (HEAD -> master) MAYBEFIX: Make sure we wake anything on th=
e wake_q
> when we release the lock->wait_lock
> b525e4779098 test-ww_mutex: Allow test to be run (and re-run) from userl=
and
> 1b2ab8149928 (tag: next-20241210) Add linux-next specific files for 2024=
1210
>
> This fixes the issue for me.
>
> Bert Karwatzki
>

Just tested half the fix (only the task_blocks_on_rt_mutex() part on top o=
f
linux-next-20241212 where the bug is also present) and found it to be suff=
icient
to fix the issue for me:

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e858de203eb6..ddbb7423fb69 100644
=2D-- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1292,7 +1292,13 @@ static int __sched task_blocks_on_rt_mutex(struct
rt_mutex_base *lock,
         */
        get_task_struct(owner);

+       preempt_disable();
        raw_spin_unlock_irq(&lock->wait_lock);
+       /* wake up any tasks on the wake_q before calling
rt_mutex_adjust_prio_chain */
+       wake_up_q(wake_q);
+       wake_q_init(wake_q);
+       preempt_enable();
+

        res =3D rt_mutex_adjust_prio_chain(owner, chwalk, lock,
                                         next_lock, waiter, task);



Bert Karwatzki


Return-Path: <linux-kernel+bounces-442407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F39EDC64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAAF282D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D34A29;
	Thu, 12 Dec 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="RI7RXRZ1"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C665228
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733962656; cv=none; b=sU/Z6NYI19155hXnDgRSz6zlbT4kwdG1fUwW69zPuCrGsZzLVwY+b/+E0YqI6yzqGyskLnbWxo+TpmgkvTNDuqAdaTkvI3pUV4yqdlJdfr2WvUt+LpJJlWCymeqhBQtnW79jVFTucLJbhDBXUMl4nFV3DAQ306FH9xTzWQRRmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733962656; c=relaxed/simple;
	bh=V+X3V+2PqazspXTL9MM4FhzoqCBIKFcNYf4uci784hY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZopExqXH8exM6kYLKIEfSAQ78m0LXOPY3PyIVX2la1StroevOF7Az+bJJEkg9YPz6NtxuURacXTZg+igQaOcE0nUQ3Vy4v4t3IUFdWTBZF6e7fCNTbxQQKJWvFU4BwjyYEPcsNJazOovKL4zSeZ0OQRZdcFUZk4ni0ixivpzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=RI7RXRZ1; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733962621; x=1734567421; i=spasswolf@web.de;
	bh=sDFh0J8SoDOfO6/yGu59Da0Y3YEDwBwUIlURRkOTmt0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RI7RXRZ10Il76zvbMrwmf4J60XKz0KqsFQeYMsmp6Lnl3UzPJVGjOZaKdnFDqGCG
	 JvCgjIzV9PjZm+o5BfltmzbZVcKAquVE82VKmOU7oy8IDjPEdH9IqCt6dL+xAxAIi
	 t45GxztmfIsS9HQdbHWVVqW8q4GSUVv67AaUT94Lsig0yegB00PPR5vhNHGHcjtDa
	 N3LrlE3pBK8r1MW9imtvmsebgjdXtn22R+cbZcB+1ek5KTj6reN7xtkPac1V+5uKW
	 8UXPovANP8QBrObvq+Sq97U+zNKs76I4YUq+6yDg/dgrtU/Gqq5v+cA1w3MKG89/U
	 /r9n5TX4WUG0gjkfQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1tsNWw1bzv-00c1Ka; Thu, 12
 Dec 2024 01:17:01 +0100
Message-ID: <cf6c7a80e3a54e1060f89cf7bc8c741214d1665a.camel@web.de>
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
Date: Thu, 12 Dec 2024 01:16:59 +0100
In-Reply-To: <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com>
References: <20241211213527.3278-1-spasswolf@web.de>
	 <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
	 <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bQE7m080GYNJa4OiUmZzxHErre27NqLkFaG7XKaLeTYYL0iYDz5
 0cxLmvh4iJvOhGkVnDc0XgUjxZd2V/W2HoTBxIB3aCQi4J7XpfOmwBFAqWqSwEm1gfrJlFZ
 xhUa/gYqd7cFgI/UYca7yuhyFWsbOVrCA5UlOBCdnbs9oRs5Bgp/OeAFE/5t1ijh9FTwmsE
 LEpDOWerv6cZb5fePS/nA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lkwjdRE5Rmk=;N7saANrExBeEw0d+8H3i2OAPslG
 D+6g5nwr3YmNYbki+5iUCTQO+P7h1wwTuPNC5lJy+ye+SZUPii0ghNnXoiZoVeXv/ywXcm8zM
 xvf9+S2DKk2nz/fNqnNNgkc+1JW/H17do+Gi0Uyl2+nrunkQtvQmiUuVPrgOFHoKV3iT3tptR
 +xRwtw+YAOr2sel1uUMi4C16SPDcU4Wy4NIV+CwZ53eH4+KkS0CRiq48+51HPcPBrahiagCaJ
 /aJ70PAwyRrzi8ERpNp6RgxVR6dz2MqUkH+1uL97l9BOQFlmTo9QXJIgVmkRRRDOifFMvzluz
 55zgRIqCGkK7BmdonoNktuwW02I+4Cx7kXFlo1RrSSSpIvxHZQA3Va6JCb7CAUJPChQzoe7MR
 Ja8OszaYBAibaEdRtWct3SzzgFHIERCo/XQAJ5eZ5cIJtO6uAVIXu9MdzdlIouXq/AiL/Paks
 zRVV1A+MVoWcq5xZDPvg2HYSB/Hm/S9J1aiv1tQdrWtBWELEU9/dVuth4OajVn4lsjUCkLJAQ
 4UpNSkitdaYZ7teeUqLD4Zex0TWV8xYVV54o4u0Crv1IQEX6JbW9XJAEONQ/6R3EG1+F5pFYG
 vKZPWAL06/2yjOfyunB3aoBuLJmkdyaorCyQcbhMtrOvgKtcb/edodsarEHLUALR7h8HoRoyg
 ljb7bLrT65r7sXMug4rUx+IrU3g+Ub2OJWsxSojU5calzISKgsX5lJZ5gOjzMq79kNRca20ig
 s98pBgKBFRyosgqLuOuOSwz3+e26RrDAiq+6y0jQ2w0jHbWOt11lZmiluQPJ+6wwvqjI8UVq1
 b1ZJOQkFsS7ljhZZNz6DPpLjwLLLnGVncz7uUgVoZXMctj4bROo9qsR8YBs1H8d3pwnH13zex
 HZCQuyC0JQNO9NJXq7vVtyOADTefazAEN1PcjSP+u1sIQdxe2hE2T2blJojgm/XVAqGaeCA8l
 kcElq/Bi49/0JTaNZGFvB8HrAuyUSx5dZ79D4FcrOI5xJRLeRsodQLxMdI2tWIWsD2el6uJAd
 XwE1eFCAMCyWL7EFYUxWpwTGDoHMx+guCds0o5nadDfrg34aNauVOIHVXPnhrJBa/OZm/PUU9
 6mOTDTbutA7dioz0Jp68GE7B/dGKkcTP4kjaHLSC2Q0wcpjyD+M3CJgJ9pCrjAbaDjorYmIUw
 =

Am Mittwoch, dem 11.12.2024 um 15:14 -0800 schrieb John Stultz:
> On Wed, Dec 11, 2024 at 2:46=E2=80=AFPM Bert Karwatzki <spasswolf@web.de=
> wrote:
> >
> > Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karwatzki:
> > > I have confirmed that I that linux-next-20241210 is fixed by the sam=
e revert
> > > as v6.13-rc2 (ten boots without incident is the criterion for a good=
 commit)
> > >
> > >
> > > Bert Karwatzki
> >
> > Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've just checke=
d v6.13-rc2
> > without the revert and the following preempt settings and got 10 clean=
 boots:
> >
>
> Hrm. That matches the case where the fix here helped:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
>
>
> I'm still working on getting a minimal delta from your config booting
> in my environment, but in the meantime, I'd be curious if the
> following reduced revert helps?
>   https://github.com/johnstultz-work/linux-dev/commit/60c60f85670fb1f470=
8adbe55e15ab918d96f9f0
>
> Basically just trying to clarify if the problem is moving the wakeup
> to the wake_q or if some other interaction (maybe with the
> preempt_disables) could be causing the issue.
> (I'm assuming you have 82f9cc094975 applied when you test with that chan=
ge)
>
> thanks
> -john

I tested linux-next-20241210 (which includes 82f9cc094975) with your patch

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 37f025a096c9..724d4c871cf6 100644
=2D-- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER
*waiter,
 #ifndef WW_RT
                debug_mutex_wake_waiter(lock, waiter);
 #endif
-               wake_q_add(wake_q, waiter->task);
+               wake_up_process(waiter->task);
        }

        return true;
@@ -332,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
                 * wakeup pending to re-read the wounded state.
                 */
                if (owner !=3D current)
-                       wake_q_add(wake_q, owner);
+                       wake_up_process(owner);

                return true;
        }

and this fixes the issue for me.

Bert Karwatzki


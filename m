Return-Path: <linux-kernel+bounces-442930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4E9EE424
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742C6283E34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1720B1F7;
	Thu, 12 Dec 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="VeHCwwHH"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97210F2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999528; cv=none; b=q8UbKrwxNJGwZ0g4fwATRP42qdPb9eS7YtKwGadli2KGl/QWoIxorh8Bd9DAUWMwjNUVQU+Lmqu5yVPp6aTyzUTAXZqv4JdEAFj4/6Dtj1SSVx2sOBT34zKVCdCeBhpR2H7qnps7cJrKQAPt6Mj2q+3ds+JhNj+D6om38O+sxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999528; c=relaxed/simple;
	bh=FCCx59r1yNwzCkjwt1Y9sExvuy53RKxiKW1o9TrdhAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OW2uF2/wCmx18o69d41uMMaoNaCE39qH3C/8RPduGBzKqDpRfaiViP3q1DUTPpp44AB03LiyURVguvRlJb+WvkQ1t4c3jtYaBQE7azX7MNgUtpt9fBJmhxqi68AbS2tdJS7oQv4ZlqjUqpEc7tgBMeXL2BN+5Xj2kzrOpZZgbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=VeHCwwHH; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733999480; x=1734604280; i=spasswolf@web.de;
	bh=taAYwCFrgXFPKkySHynJ9x4mKSx6oPeKYYwGzrs3Vj4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VeHCwwHH1spsqOTAOp72dP78tkjdFdzxzF1e/3U7W+H7azwpcu0epwqyp9oqbxcz
	 DL/DImnJKKwjEcEJJuFSp9qnLRtAeaFHQ6wORVHcTt5KPDbRIlmzrU6cieTft44Am
	 8ZPUGkDL0qlFOtWD0e/N2e1ofeahO9Ha9LSTxIFXzXmpiUgojFpDI/D28GStqetD3
	 /Vy4KoWC0du664S2EJ9uVCGwiFia1N5Jqe9nsl8chc1qViQ8gXhN+cFdZvHjukGsf
	 nmGmWHqdACJg0y0p4311vgIBXGEXwL+HulDc+efO09m2ahC9QaaYT2SjME5PAbRI4
	 kfqeUrp89ce0xwJnMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXVX-1tUAeZ27Gt-00Ge68; Thu, 12
 Dec 2024 11:31:20 +0100
Message-ID: <5325ccfa4f7a0a9925e8133612528237966c2145.camel@web.de>
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
Date: Thu, 12 Dec 2024 11:31:19 +0100
In-Reply-To: <CANDhNCrKhwVBEjX5m46Mwrm9uixBkS8MSXKyWxkD=-8Urx7nGg@mail.gmail.com>
References: <20241211213527.3278-1-spasswolf@web.de>
	 <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
	 <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com>
	 <cf6c7a80e3a54e1060f89cf7bc8c741214d1665a.camel@web.de>
	 <CANDhNCqP+zGH5jyfWHeEpALuAxbyc_+XOx5CHoRs_tw4DVjDww@mail.gmail.com>
	 <CANDhNCrKhwVBEjX5m46Mwrm9uixBkS8MSXKyWxkD=-8Urx7nGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gxDDbxfBt1L5gBMqNr+ahG1ElhM14C2clhJFmg2d3vFwgx3TDlc
 1Gxr3lPVmX1JVYQtt+MJm8bjaWNvRMhMa1gv8s4szqZzgc/UY4AIvnDKbLobRV80/7dXYvf
 0szNlJN6R01j3afCswI0esIwxfO6lXXWC6z8sYSdN/z+1EIBnsRv46R/DPeqt0xPpDlmFas
 5WLpkHHxqCEsC6czYPhYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9J3EP4LLcwo=;K1oecyHCBXevq7+ZN9ZR++7AN4Z
 R+PzjM3UxjsbHAPn1lZxBz7WQ/y9MFP+T/gT2zXCsIA58bhOMvO2gHHiVj003ZsthaLLP9rBw
 CjxMcStw6EjsC4D0lCXd+J6GsEjXCQnGh7zhkZjs2Uu675XTiTDUK3wIITim3uArD6P7599VC
 plfaAS5rchR/Su9WZUsWrACLfbQ8tD2poYMargvuwx5pYt8R1nAMLniiFmowXLbtiDW6+sQ35
 fDgN1U8apl5UT5zx521fpRJQkeIzCv9JYT9rPBq4xIGXqrMLp8VHsuYIfPRKgODfKOEq9HOuu
 vQLK3tXMSd2Pg8ODS7b8Oot+E1I/Vkz5J2MtscUVyLYc12dQC0raO8ODlI4h1/HChvLrFf2hR
 VLv9hXHfc0QHOKehqytWUHq96DFjkBW4Tvrj0qBfHzcrC5EIuYEc0FLtGURTAm9LeEfAWXxSr
 iGG0V1xxjiLtUIN9Lo72aGfD8Fh/TXJOIzWNpm0KFW21e5b5DLWQ7R6Hq7jnjCMVI/KI3JcwI
 Qjl1tHxZcuHBiHiDr1fttSLVrtpg/O7aypDclCMEQIN+Se8Cu3c4gLf1PB1MPyOdzUAs0t4cD
 upiRSZ3wAE9xAMe0/4niH6tSLQ0FvIaWbS3Vw5c2TmTwjq6nnQT40RwhhqJ3HP9j3UQQ8+xpV
 PcEXmMek5tY1ZfjpW+0bVUWExr4jNpQpju0N4j+50LjU0KJjsSCvIw7TojkEfysnJansRUs0j
 gM/nQbdPgPPRPY9b9BpwefamTGiUWIVteZzzSd1eDQo7SRHtqnfsvli5lpddjFRGEpXdp0Gu8
 XHWnFu1Bivi4pPW/RDsGe6ErgRMPq80s/AqtGdSGYdtlfaxF97v0XADuyyyYuUZJP/z5tBqnX
 JRVcvl/bzpfUNu32WdBeymRHA94DIp8rBRKx40NQbtdfPSfskapPbnz7aEYc6CaCOD+D90wOK
 gQbqiQUfH1RsPuEWvK8sKYX9P6ikryClHPiYoS2CJLrXFxMll9du+uCWyHxcXC+gkr50Gz5k7
 IzIkNI0GnMW1+XhfSMAAVziVXYN5h5hEDZtdBNzLVbrk+iIudFJz0GHln8lq2TVblMZ4E8N0w
 rdkF/cX3X0l1V9pMN1ZKANQE2HPAmT9vyZHDqW3BDimjAHgVE8sA==

Am Mittwoch, dem 11.12.2024 um 23:40 -0800 schrieb John Stultz:
> On Wed, Dec 11, 2024 at 6:41=E2=80=AFPM John Stultz <jstultz@google.com>=
 wrote:
> >
> > On Wed, Dec 11, 2024 at 4:17=E2=80=AFPM Bert Karwatzki <spasswolf@web.=
de> wrote:
> > > Am Mittwoch, dem 11.12.2024 um 15:14 -0800 schrieb John Stultz:
> > > > On Wed, Dec 11, 2024 at 2:46=E2=80=AFPM Bert Karwatzki <spasswolf@=
web.de> wrote:
> > > > >
> > > > > Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karwatzk=
i:
> > > > > > I have confirmed that I that linux-next-20241210 is fixed by t=
he same revert
> > > > > > as v6.13-rc2 (ten boots without incident is the criterion for =
a good commit)
> > > > > >
> > > > > >
> > > > > > Bert Karwatzki
> > > > >
> > > > > Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've just =
checked v6.13-rc2
> > > > > without the revert and the following preempt settings and got 10=
 clean boots:
> > > > >
> > > >
> > > > Hrm. That matches the case where the fix here helped:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
> > > >
> > > >
> > > > I'm still working on getting a minimal delta from your config boot=
ing
> > > > in my environment, but in the meantime, I'd be curious if the
> > > > following reduced revert helps?
> > > >   https://github.com/johnstultz-work/linux-dev/commit/60c60f85670f=
b1f4708adbe55e15ab918d96f9f0
> > > >
> > > > Basically just trying to clarify if the problem is moving the wake=
up
> > > > to the wake_q or if some other interaction (maybe with the
> > > > preempt_disables) could be causing the issue.
> > > > (I'm assuming you have 82f9cc094975 applied when you test with tha=
t change)
> > > >
> > >
> > > I tested linux-next-20241210 (which includes 82f9cc094975) with your=
 patch
> > >
> > > diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> > > index 37f025a096c9..724d4c871cf6 100644
> > > --- a/kernel/locking/ww_mutex.h
> > > +++ b/kernel/locking/ww_mutex.h
> > > @@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_=
WAITER
> > > *waiter,
> > >  #ifndef WW_RT
> > >                 debug_mutex_wake_waiter(lock, waiter);
> > >  #endif
> > > -               wake_q_add(wake_q, waiter->task);
> > > +               wake_up_process(waiter->task);
> > >         }
> > >
> > >         return true;
> > > @@ -332,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
> > >                  * wakeup pending to re-read the wounded state.
> > >                  */
> > >                 if (owner !=3D current)
> > > -                       wake_q_add(wake_q, owner);
> > > +                       wake_up_process(owner);
> > >
> > >                 return true;
> > >         }
> > >
> > > and this fixes the issue for me.
> >
> > Ok, thanks for validating that!  Hrm. Ok, I suspect I'm missing a path
> > in rtmutex.c that calls into __schedule() before we pop up to the
> > point where we actually wake the wake_q.
> >
> > I may have found one or two spots that look likely, and I believe I've
> > also managed to reproduce your problem using the test-ww_mutex driver.
> >
> > So I'm working up a proper patch and will share for testing here soon.
>
> Ok, could you try the patch here:
> https://github.com/johnstultz-work/linux-dev/commit/3c902b92c88122cd0349=
37e8d40930bac254a7c5
>
> I've repushed to the test branch I shared earlier, so its against
> 6.13-rc2 + fix that has landed upstream + test fix above ( + another
> patch that makes stressing the ww_mutexes easier):
> https://github.com/johnstultz-work/linux-dev/commits/debug/894d1b3db41c-=
hang-bert/
>
> Let me know if you still have issues with this.
> thanks
> -john

I cherry-picked your two patches on top of linux-next-20241210:

2029cb31eae9 (HEAD -> master) MAYBEFIX: Make sure we wake anything on the =
wake_q
when we release the lock->wait_lock
b525e4779098 test-ww_mutex: Allow test to be run (and re-run) from userlan=
d
1b2ab8149928 (tag: next-20241210) Add linux-next specific files for 202412=
10

This fixes the issue for me.

Bert Karwatzki



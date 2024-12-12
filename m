Return-Path: <linux-kernel+bounces-442690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8769EE05C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A721C167608
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524720B21D;
	Thu, 12 Dec 2024 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NfeEQk8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8B204F96
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989235; cv=none; b=c+d33gNptPvrlDNZa+ugwHRaoPTJnkvm/9VtqAvWnrfb4u0IZ4mavcbtjybePxSK8j2j10QIedF8GdtwQvj8RvL9E59or/G3iBrQtCIIDUw9uOCETo3JMVqDsN3WvA/ZMS3q8hTTLS0JZnpC6MviD9a/CMFP2/St6w+iyhy8ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989235; c=relaxed/simple;
	bh=dYvekUClI2W4cex9wLMcGt2mtuPMOKxErwshDAm/guk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs+GuFaZKnsxmh0MmAEYnoghzUETbgM7uR1+vI/+gOzJf9zFlsm3lqdbLyQyRP78EW9pCvPB+QRqJ8qRSH6fZK5qN9jY5MHMqa56zoGWSMzVLJogzTPPSQXSv6nmK9rS5RE4w8mim0qcels2nhrYxfaW9MmzNdBOyXVgZYJgsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NfeEQk8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa689a37dd4so46903766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733989232; x=1734594032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut9nwYJZ0+VEKcLs98YsKngmR5VgzeCRVBHrDNawgTA=;
        b=1NfeEQk8jzLpnPlvtQlASCcLVkJSv/stju3l2+/FAJM8V5TBOaTqzVsj4MNZ9mDanO
         ZsAeU2UCYqQmDK6eJMujTL7b47YSBBjiXTVt27seQAH5NddDkUbzaLblj3wHaM26LMLT
         6JhuO6DjJDFHLuOVpAARCAS8nIvleSHRLP8o6ZyLZmK9IhZ7S7ljA+XtDahPLL6YrWNg
         KAeM05yz1JCyZ0cqWcY4BVLkom3iayCgE/4kP4zhkONjbOJJIPJOTwds7/x6haJRivWK
         GXH84mrOgxtbUwpip7Blb9f7z34fi4uX/vRkkxdZw6TEFhRgym3CEs3PjIuScDyEwEyI
         u4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733989232; x=1734594032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut9nwYJZ0+VEKcLs98YsKngmR5VgzeCRVBHrDNawgTA=;
        b=SkmHe2jMneO9terdHAIeOtunHKsa5DPD8jmuD6upLe53vrPxlFsFij3miqriBVLBt3
         LPZvBPtv0Cuktjg+YxKzwr+UgEk4t+l831FXx+K1xxgsqkM0POUAlHe69QxoUNjNcIoZ
         64GZs+UYUsBdBv2pGS1hGamoDEz8euwOI1PUvp0hgTKwnCzuB1uBwagVQvpFCpSzSDCM
         xHbPFo0moxgyMAGy48m6OKkNfakqrVoq0fAH2nOyzCKSq2kQOF4w1REua8cObg3xp6Rl
         ZbhKeGywkR0etzR5bmbbyEQ7rjMDjsWdjENFyTzmmyekjkgREQ7A5Yypj6GyzapQdDvh
         +9NA==
X-Forwarded-Encrypted: i=1; AJvYcCUYgTKfGDFr9++6LYCMMZhDGeuvX8tP0cCzsKCyUpW2DBoSFXOBac59/f1CRf3eJpwMKSbb67ktTL4rsiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8dUAsklqwAFLa98rloB7VZl0lqISzqwEjI7aqFmHu8+DIk+H
	uDWwLVCZkmzJJlhczMrfgtShtWDvCJppK/e4v7tIBGHebk7gUPtzsaUiF3yZmvACjS6oyHWitG7
	yERgVDF0PdKoqvfTRgnxsfDnop+bvOY7wsBQ=
X-Gm-Gg: ASbGncslT0LurAthI5vShClLgFrXX9uNfigc0+WOIO6SOfM6bUOvXlPmcTC4Qc5Y5Yq
	uVWnEk8CjsN4gLk6fy0DM+6aYgw/V2ElVqO7rQ+jfDprZkyEEi2YBm22HWPcCdA/pfzE=
X-Google-Smtp-Source: AGHT+IGBRxE2EPlaBJr+ZpBbK8Nwm2w1ZzAVnG0WftoBhnbXjVptZ/e2JF0aL+r8E9cOvNJ8ahaOUKYFk28m9sCSPaM=
X-Received: by 2002:a17:906:9c2:b0:aa6:25c6:d94f with SMTP id
 a640c23a62f3a-aa6b11dd450mr523430266b.31.1733989231898; Wed, 11 Dec 2024
 23:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211213527.3278-1-spasswolf@web.de> <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
 <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com>
 <cf6c7a80e3a54e1060f89cf7bc8c741214d1665a.camel@web.de> <CANDhNCqP+zGH5jyfWHeEpALuAxbyc_+XOx5CHoRs_tw4DVjDww@mail.gmail.com>
In-Reply-To: <CANDhNCqP+zGH5jyfWHeEpALuAxbyc_+XOx5CHoRs_tw4DVjDww@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Dec 2024 23:40:18 -0800
X-Gm-Features: AbW1kvYyK5HFDcyZXB6VUPwbz2tE-cx_9XcsEAujYe-qBcX1U_4SrjYxdH8pv6Q
Message-ID: <CANDhNCrKhwVBEjX5m46Mwrm9uixBkS8MSXKyWxkD=-8Urx7nGg@mail.gmail.com>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
To: Bert Karwatzki <spasswolf@web.de>
Cc: Metin.Kaya@arm.com, boqun.feng@gmail.com, bsegall@google.com, 
	daniel.lezcano@linaro.org, dave@stgolabs.net, dietmar.eggemann@arm.com, 
	joelaf@google.com, juri.lelli@redhat.com, kernel-team@android.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, 
	qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de, 
	vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org, 
	xuewen.yan94@gmail.com, zezeozue@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 6:41=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Wed, Dec 11, 2024 at 4:17=E2=80=AFPM Bert Karwatzki <spasswolf@web.de>=
 wrote:
> > Am Mittwoch, dem 11.12.2024 um 15:14 -0800 schrieb John Stultz:
> > > On Wed, Dec 11, 2024 at 2:46=E2=80=AFPM Bert Karwatzki <spasswolf@web=
.de> wrote:
> > > >
> > > > Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karwatzki:
> > > > > I have confirmed that I that linux-next-20241210 is fixed by the =
same revert
> > > > > as v6.13-rc2 (ten boots without incident is the criterion for a g=
ood commit)
> > > > >
> > > > >
> > > > > Bert Karwatzki
> > > >
> > > > Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've just che=
cked v6.13-rc2
> > > > without the revert and the following preempt settings and got 10 cl=
ean boots:
> > > >
> > >
> > > Hrm. That matches the case where the fix here helped:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
> > >
> > >
> > > I'm still working on getting a minimal delta from your config booting
> > > in my environment, but in the meantime, I'd be curious if the
> > > following reduced revert helps?
> > >   https://github.com/johnstultz-work/linux-dev/commit/60c60f85670fb1f=
4708adbe55e15ab918d96f9f0
> > >
> > > Basically just trying to clarify if the problem is moving the wakeup
> > > to the wake_q or if some other interaction (maybe with the
> > > preempt_disables) could be causing the issue.
> > > (I'm assuming you have 82f9cc094975 applied when you test with that c=
hange)
> > >
> >
> > I tested linux-next-20241210 (which includes 82f9cc094975) with your pa=
tch
> >
> > diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> > index 37f025a096c9..724d4c871cf6 100644
> > --- a/kernel/locking/ww_mutex.h
> > +++ b/kernel/locking/ww_mutex.h
> > @@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAI=
TER
> > *waiter,
> >  #ifndef WW_RT
> >                 debug_mutex_wake_waiter(lock, waiter);
> >  #endif
> > -               wake_q_add(wake_q, waiter->task);
> > +               wake_up_process(waiter->task);
> >         }
> >
> >         return true;
> > @@ -332,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
> >                  * wakeup pending to re-read the wounded state.
> >                  */
> >                 if (owner !=3D current)
> > -                       wake_q_add(wake_q, owner);
> > +                       wake_up_process(owner);
> >
> >                 return true;
> >         }
> >
> > and this fixes the issue for me.
>
> Ok, thanks for validating that!  Hrm. Ok, I suspect I'm missing a path
> in rtmutex.c that calls into __schedule() before we pop up to the
> point where we actually wake the wake_q.
>
> I may have found one or two spots that look likely, and I believe I've
> also managed to reproduce your problem using the test-ww_mutex driver.
>
> So I'm working up a proper patch and will share for testing here soon.

Ok, could you try the patch here:
https://github.com/johnstultz-work/linux-dev/commit/3c902b92c88122cd034937e=
8d40930bac254a7c5

I've repushed to the test branch I shared earlier, so its against
6.13-rc2 + fix that has landed upstream + test fix above ( + another
patch that makes stressing the ww_mutexes easier):
https://github.com/johnstultz-work/linux-dev/commits/debug/894d1b3db41c-han=
g-bert/

Let me know if you still have issues with this.
thanks
-john


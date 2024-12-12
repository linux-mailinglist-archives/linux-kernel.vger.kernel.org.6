Return-Path: <linux-kernel+bounces-442524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425149EDDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381A4167EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E613C918;
	Thu, 12 Dec 2024 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0AZ6T8F3"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350E18643
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733971277; cv=none; b=sSgnIKsYPmRdiS1PTfW/GwUVajihk9zUZmpkgkqwb2JHS24Rm+RV53vqL4nQU3EW0VNdx8ivEh+EdM92HpFpGiwSkTHOua6xbj62eFP6EB1BhGoNo517uDemaVOMRPEzEyK18iEcBNR+3HpBJg7gUeN2DJpKJgKYwUn5d3238Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733971277; c=relaxed/simple;
	bh=oJcVi3tvBPxjUf9PbFjYGLaig5BM7kH2819NaKnFX9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBuxBVT6T/FGMxmkkHIXO2CLG+h6wwrNmLVI+D1Owuv3hJWk+a6FiK41RYhzSeTBu7gpAwSWecJLjMqpZClfASxjDx7O6M3qfrVGYmFt2rOHrMAI89ZtXXGaSwpeN+IsJgML8PJKWrR1XEz3s4abyzJQ8K55Zb4VODqBD0Fkhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0AZ6T8F3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso13105266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733971274; x=1734576074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/ZwxbmQuYEfiyrP7t37UBbam1I78VZ6v4CjoZdjpIo=;
        b=0AZ6T8F3vuztbw04TfRGeroXTkCAkmYc/4zzweT1/RNMw8ICsE0+7Ac8TlRXrOCh1h
         AhlPyKEBvjdNarFYGpAvoBDQFDVpddBLgu49SWBLbdy4OpHDEWXI0j3Rkd4oI7LVHkRK
         cRfcI2AMdKdX7HM2cIEw62H92DDJWmStNd1XswA2tL6qI6nyUpJFmyrDYuJl3MafLjF0
         pbXiHdg+02Eni0S3Ol3QP3OIXqftBBwnij2OhGVFu3D8glN7JE+jf2v1HNJ2DlbAIJZ8
         zTgStgGW1f4avqR+6E2rx40v9UeyyNlBy9P678/Q3hZlRwe5mTdQHe2RrVHnRSNel8hL
         W76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733971274; x=1734576074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/ZwxbmQuYEfiyrP7t37UBbam1I78VZ6v4CjoZdjpIo=;
        b=QMdp9RnZNmKyJ/s+RUvnW0M6tFyQOZn72oElBWuc/rqf0x2rNFSHoVH/Wrm7RZfPhM
         wo9tzv6uwSfDFK8vWbZ1/BW8wJVdx208tfBZJ+9T2JGcXfqLb6jyxuPN97tlZzJD4ABy
         VRv9XH8AJ2Pnr66nBM0FZ6igtKO0Ct/8s8Gq/7bunVpkMGAM5TT50MQxDAp1qZMY7Yen
         PV+gLwEce3+oWH6gO8XksA5BX0iAc+GUqKX7k8tzGJKDBhfE+IkM/m+QGqPhmOiOPcmS
         sfqdBVK5RS1MshAhzxrH96Asm+VdvvzILmt4ZCaT4TJspM0NmmvAFNAdvrUijx1ld/co
         Q5zw==
X-Forwarded-Encrypted: i=1; AJvYcCWNCvuhBgirGFlw3C/SAuOzcx7lTHFcGp6jwLSevMNvEPvsK/acymTBurH9NoTQ8qHvUDDr1oNgmigjL3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcax/AgWNm50pS68xNmI4jGXu+A209uNsKUUuwdB1DvbIDoApM
	PCPaahfS/LBMowQfZsd6Q2x4zGa2i097jZMm4tHOH/9e8wz5zijy7rxFdPGOwlcbNcJ6DCofWaS
	55Fmxszd95hC9J2IkIlLbIM++97kYh/NL6/s=
X-Gm-Gg: ASbGncsJnXJfDTTYEy3/fEcnLX3pHDJnBvoUR0Y8oBay2n5KSe4fEnchAE3gd+xRkaC
	vbNH8SUa8ukWCRbsqj5FvvUBVzq1DTDna7WCqtRhraRDKupukC1DXt1wG40y4Ql4f7bs=
X-Google-Smtp-Source: AGHT+IF/zN3mRGNOCJtrloqUSE1odkls5eAyF53t5N0a+9rWxW8zEFhc0Nt2O4EuQZKp6VIl65veE6joMc/48dBU8oI=
X-Received: by 2002:a17:907:7703:b0:aa6:74a9:ce6e with SMTP id
 a640c23a62f3a-aa6b1179ab6mr446581466b.16.1733971273516; Wed, 11 Dec 2024
 18:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211213527.3278-1-spasswolf@web.de> <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
 <CANDhNCoNMtjKmgWbCfScK1xGqQrKTh2a0cw+VYTgiT-dw2haLQ@mail.gmail.com> <cf6c7a80e3a54e1060f89cf7bc8c741214d1665a.camel@web.de>
In-Reply-To: <cf6c7a80e3a54e1060f89cf7bc8c741214d1665a.camel@web.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Dec 2024 18:41:01 -0800
X-Gm-Features: AbW1kvYokAtx0lkkDWMHBR0mRsk2OOZXsFZW4BtY9bJQRc4fnRTwRaI7Zn8tquk
Message-ID: <CANDhNCqP+zGH5jyfWHeEpALuAxbyc_+XOx5CHoRs_tw4DVjDww@mail.gmail.com>
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

On Wed, Dec 11, 2024 at 4:17=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
> Am Mittwoch, dem 11.12.2024 um 15:14 -0800 schrieb John Stultz:
> > On Wed, Dec 11, 2024 at 2:46=E2=80=AFPM Bert Karwatzki <spasswolf@web.d=
e> wrote:
> > >
> > > Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karwatzki:
> > > > I have confirmed that I that linux-next-20241210 is fixed by the sa=
me revert
> > > > as v6.13-rc2 (ten boots without incident is the criterion for a goo=
d commit)
> > > >
> > > >
> > > > Bert Karwatzki
> > >
> > > Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've just check=
ed v6.13-rc2
> > > without the revert and the following preempt settings and got 10 clea=
n boots:
> > >
> >
> > Hrm. That matches the case where the fix here helped:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
> >
> >
> > I'm still working on getting a minimal delta from your config booting
> > in my environment, but in the meantime, I'd be curious if the
> > following reduced revert helps?
> >   https://github.com/johnstultz-work/linux-dev/commit/60c60f85670fb1f47=
08adbe55e15ab918d96f9f0
> >
> > Basically just trying to clarify if the problem is moving the wakeup
> > to the wake_q or if some other interaction (maybe with the
> > preempt_disables) could be causing the issue.
> > (I'm assuming you have 82f9cc094975 applied when you test with that cha=
nge)
> >
>
> I tested linux-next-20241210 (which includes 82f9cc094975) with your patc=
h
>
> diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> index 37f025a096c9..724d4c871cf6 100644
> --- a/kernel/locking/ww_mutex.h
> +++ b/kernel/locking/ww_mutex.h
> @@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITE=
R
> *waiter,
>  #ifndef WW_RT
>                 debug_mutex_wake_waiter(lock, waiter);
>  #endif
> -               wake_q_add(wake_q, waiter->task);
> +               wake_up_process(waiter->task);
>         }
>
>         return true;
> @@ -332,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
>                  * wakeup pending to re-read the wounded state.
>                  */
>                 if (owner !=3D current)
> -                       wake_q_add(wake_q, owner);
> +                       wake_up_process(owner);
>
>                 return true;
>         }
>
> and this fixes the issue for me.

Ok, thanks for validating that!  Hrm. Ok, I suspect I'm missing a path
in rtmutex.c that calls into __schedule() before we pop up to the
point where we actually wake the wake_q.

I may have found one or two spots that look likely, and I believe I've
also managed to reproduce your problem using the test-ww_mutex driver.

So I'm working up a proper patch and will share for testing here soon.

thanks
-john


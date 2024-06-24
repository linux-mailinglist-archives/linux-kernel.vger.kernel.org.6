Return-Path: <linux-kernel+bounces-227534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE769152E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDB91C212CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF319D889;
	Mon, 24 Jun 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ym6V7YxI"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516019D881
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244256; cv=none; b=K5jJQR2abm7ZNYGoRUz3MNqv31/5G2KotTJ28a5PzMThHk1mu+q1V49cFmUmPtkNiCfkvQRr8ybdVeRxuFqyJBmH/0eqYKsnAtiA3D6OoX8IqYdsHKsDBY3DcpVgDk5sCyqG+Odz7OhVrqP2oP4ULcSRF2bzRW3cREB7EDFD4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244256; c=relaxed/simple;
	bh=cUb4t91fkOJFqq3qtAzQsp0q+PY2ZaA0247Ld/sOeek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpWTQGUqSntEOCOKXOpPSm5WcEbuhUW8SCuKRoRNk4aWpfRZFRaDFEzBy/ZuHds+ot3gKYikCWde7HYcVQ9YMwpW4mMYtSt0BvUShAFsSKxuaaQyQMZ76v9Ni5WfHRJY5Z4yzhp1GYZK4FWXrI2S//AreGcMbbBPv1hheHGBRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ym6V7YxI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f991bb9fb8so506505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719244255; x=1719849055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akLaKPvhZ/iM4RU794u9yXTJLAPlEaTaPPmBTznkmMc=;
        b=ym6V7YxIut1k7dsotnjWR3/T5sHzowR4mpDVnyHdcahZJGyNV5JITesOJbYmlINY42
         mU+h4hRJc5BSyVB98OgfGCsOK7ct0cI1FU2GfW8GoDQF8GNinjXTRbc2JK+WYdCIbRnf
         8kAR+fHtOLmegIKXFGc6Ea3x+N2OjjXW3jCWzJmllBXOwPz0chKcp+gsw7VDj1tsqUEX
         LLz3hBmlYB1yLJkHODrOlN5YcR7q53VmMcGeqBMJFLF1b24FEpVmz26npOlOhfVypIbF
         CtWStoKH1rhaF2cK5xZBmlFEEqp/+zOumfhhO1t4wrIi5Tspa6eW7dp/QcemOuxKUDq+
         Fidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244255; x=1719849055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akLaKPvhZ/iM4RU794u9yXTJLAPlEaTaPPmBTznkmMc=;
        b=B0YhtsW49eQNFtmKSqshj7y/MPqDhyP4N5p5b8MaTcN3ep3ZhjR0BfFvl2XNrkO6XA
         IFrvRVX4XDc17OzJ3ZSh4ZFiF9Nns+6U5yZpLr0oeLIJzt4ugWGV2XNrxA903GdubMI3
         AM5fMxD3VoLETv1SYLW9e+N++nHv1G3T6PmIyzVPNec7PNMOGwpAgotcw5kzwvfrDjnX
         /k4p0/y3HpbWVFbwInL8JZX1Hkr310c29yKz/n4bxNzqPD6Ku6YdUIbpdxjAxM1yokYQ
         3UR6rMQbQc7V3Ua/3AIBjlyeJfgZeuUlxeAZophZ8vYFmbnFTT2fBPB5yNrjD8DCGEu8
         MaMA==
X-Forwarded-Encrypted: i=1; AJvYcCXRPJTpq89Mt1VNXiVLMgMUK73GjomDNLi1a2IfRPLfGD1EH6vUh9mY2fRjG39nUWiAAiuwBVHXkUiMkfWK52ZeyMvsqu0EPiRqxdqc
X-Gm-Message-State: AOJu0YyPWBxQqVthvNDd6hqIC7Z14RZqTl2bAfeix7CBMfrG2qrNV2ri
	I/OF4is9F5k45UhV15xT/6Rp1NBweUJtOyT0maQhAq+heSqBZHvyGHvlVzSpOkHobvCbQm0ZSEi
	4fn3exvWMDqqAsdo88YyvUsENZkKcyiV+fgP+
X-Google-Smtp-Source: AGHT+IG+cIjYT+zWx6sVIyxvgnhbvK6mrOxgqxUWkierVX93yNdOjFGi7JUR2V+DrG39+IsLgB6g8fLO14r2YL4vhPc=
X-Received: by 2002:a17:902:9307:b0:1f7:3764:1e16 with SMTP id
 d9443c01a7336-1fa0a224b55mr5292565ad.18.1719244254293; Mon, 24 Jun 2024
 08:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618221347.106627-1-yutingtseng@google.com>
 <20240622031600.3762859-5-yutingtseng@google.com> <CAH5fLgjR7iLHaWGy0NAiKnOUKro7_fBLoqFFzkdjn926jUdyAA@mail.gmail.com>
In-Reply-To: <CAH5fLgjR7iLHaWGy0NAiKnOUKro7_fBLoqFFzkdjn926jUdyAA@mail.gmail.com>
From: Yu-Ting Tseng <yutingtseng@google.com>
Date: Mon, 24 Jun 2024 08:50:43 -0700
Message-ID: <CAN5Drs0Gw6=xYVi0Naxm+A86mqckG4xjbEuvO9+UbAYHoEqYCw@mail.gmail.com>
Subject: Re: [PATCH v2] binder: frozen notification
To: Alice Ryhl <aliceryhl@google.com>
Cc: cmllamas@google.com, tkjos@google.com, gregkh@linuxfoundation.org, 
	arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:25=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Sat, Jun 22, 2024 at 5:22=E2=80=AFAM Yu-Ting Tseng <yutingtseng@google=
.com> wrote:
> >
> > Frozen processes present a significant challenge in binder transactions=
.
> > When a process is frozen, it cannot, by design, accept and/or respond t=
o
> > binder transactions. As a result, the sender needs to adjust its
> > behavior, such as postponing transactions until the peer process
> > unfreezes. However, there is currently no way to subscribe to these
> > state change events, making it impossible to implement frozen-aware
> > behaviors efficiently.
> >
> > Introduce a binder API for subscribing to frozen state change events.
> > This allows programs to react to changes in peer process state,
> > mitigating issues related to binder transactions sent to frozen
> > processes.
> >
> > Implementation details:
> > For a given binder_ref, the state of frozen notification can be one of
> > the followings:
> > 1. Userspace doesn't want a notification. binder_ref->freeze is null.
> > 2. Userspace wants a notification but none is in flight.
> >    list_empty(&binder_ref->freeze->work.entry) =3D true
> > 3. A notification is in flight and waiting to be read by userspace.
> >    binder_ref_freeze.sent is false.
> > 4. A notification was read by userspace and kernel is waiting for an ac=
k.
> >    binder_ref_freeze.sent is true.
> >
> > When a notification is in flight, new state change events are coalesced=
 into
> > the existing binder_ref_freeze struct. If userspace hasn't picked up th=
e
> > notification yet, the driver simply rewrites the state. Otherwise, the
> > notification is flagged as requiring a resend, which will be performed
> > once userspace acks the original notification that's inflight.
> >
> > See https://android-review.googlesource.com/c/platform/frameworks/nativ=
e/+/3070045
> > for how userspace is going to use this feature.
> >
> > Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
>
> [...]
>
> > +               /*
> > +                * There is already a freeze notification. Take it over=
 and rewrite
> > +                * the work type. If it was already sent, flag it for r=
e-sending;
> > +                * Otherwise it's pending and will be sent soon.
> > +                */
> > +               freeze->work.type =3D BINDER_WORK_CLEAR_DEATH_NOTIFICAT=
ION;
>
> I have not done a comprehensive review yet, but this looks wrong.
[resending as plain text]

Thanks for looking at the change!

The code here seems correct to me. Could you please elaborate why this
looks wrong?

This part of code gets executed if freeze->work.entry is in a list.
There are two possibilities:
1. The freeze work of type BINDER_WORK_FROZEN_BINDER is in the work
queue, waiting to be picked up by binder_thread_read. Since it hasn't
been picked up yet, this code rewrites the work type to
BINDER_WORK_CLEAR_DEATH_NOTIFICATION, effectively canceling the state
change notification and instead making binder_thread_read send a
BR_CLEAR_FREEZE_NOTIFICATION_DONE to userspace. The API contract
allows coalescing of events. I can explicitly mention this case if it
helps.
2. The freeze work of type BINDER_WORK_FROZEN_BINDER is in the
proc->delivered_freeze queue. This means a state change notification
was just sent to userspace and the kernel is waiting for an ack.
freeze->sent is true. In this case we set freeze->resend to true. Once
the kernel receives the ack, it would queue up the work again, whose
type was already set to BINDER_WORK_CLEAR_DEATH_NOTIFICATION.

Yu-Ting

>
>
> Is there any chance that we could have a test in aosp that would have
> caught this?
>
> Alice


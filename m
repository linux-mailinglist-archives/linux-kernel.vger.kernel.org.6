Return-Path: <linux-kernel+bounces-227543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C8E9152FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D05B23875
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B519D884;
	Mon, 24 Jun 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/3OJ45s"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAD19B5B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244597; cv=none; b=qNyNFRNt0yA1kF0sLPVynLfnLXQupGB+KrqcZu229Ojt1P1Aa3NcR5tojXOzs2WTGIVUJZDG4J/0f0640HG1Fesx8uFaBEcR6WzglC2GjMNb+W7xUwI9VMzH8dOl6A7l2SsFk7ikXZ6qeB5WJyJVM/vqoo/4GN2aeZwbx2RvKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244597; c=relaxed/simple;
	bh=SY6Wizg3/czVLLVGlwdWH3UfkzLKr3S/t9pYuG+sNLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8Tm0pXYBUHm4ia4tTo/76yqCzM37Zop9x8qMqV9VHDJ5shu4ZcAISXByASTBXAObmeT6yB+O//u7prlMIjeenTWUpH7SE9EnV45ZxHQsE3PguwGwGfiisEYwYxXr401jkxTgCrL7plO7a6LTmc0AFkxZJVYvkkLj8vA92kB+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/3OJ45s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f991bb9fb8so507715ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719244595; x=1719849395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yECxDi5aO9xjPaBHTsAinLHp4+UpHVTMU9WXW6rFg8=;
        b=w/3OJ45sd2TWB0KCwjtwjAFjR6kl55aYDnTJJmPfAk+LjBk0OytzilDb2LR/iZURD5
         zOd1SA8jM1IHBDSDKSwgER6lR/hr4wiRMrG9L4uNzd3e57JGgoAux6zFEqM4XcdzxC8a
         u5+qoRIWWI6JBMyaA84C2UOhIz70FEKA4WH/RLsBEBjtgOPT44VE0EqaZBmZBkvy3Yjh
         xVK4ZdCLibex9az6BWCq+CsLwIUWK1ZwyBpbwjq5aEXPWYX6DWg2VNUEmO2D3xZ9U312
         SehZChwOX7MUuRD5bGQHxR2tl+qLnmnYFHE6dOwYk1BA651e0iEb2xGhc+8LUVBMtXgs
         2sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244595; x=1719849395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yECxDi5aO9xjPaBHTsAinLHp4+UpHVTMU9WXW6rFg8=;
        b=pvmenAUzVWxFBVAh3TBzGzcslepimNqY1Ogc+pErheIkBVvov3NmPPLwruJaPa60ZM
         FnXWXo/awhB2OYcwtiYxsBGxKzb2MkFiMvtXq16rw2Z8jg4U+CB3KQhtSUfDNFQl/1Gt
         i/P1ekk+bE8QS8Qd/2E83EWuV5xSkp50H9mLNkPq1jMwv8FTn01pIcSS7Libexnpct86
         9iFvdD3jxVL6ScMDE88Ee9EzLfdq1WcGRo7KnY1ddyIlw5uUAoZ4fqgcwrUhoyR1JDpA
         7sFNplZy9aJhSgw4BfHYZDDvYWCUhzVjLxii27N1bLF2ZCC1kkr2deN4jFFLOa8b8O0C
         uT3A==
X-Forwarded-Encrypted: i=1; AJvYcCViBbaFQYa1YlLacLBLAbLSCqviPQEuBnJ1sKjnU6M1Wi0ufb/WseLA3Xn8dIikKwsD0OdAXLwb4O4XwO+evQjkp1YA6ULU3zxj+mQW
X-Gm-Message-State: AOJu0Yz+WhhNrCfoFbwpZGO0N2uxe/Z0LF4ZopigI/FRQPE9mY9xK/qR
	3vPHsaLUegoUziAkZHZuZd0CC6oKy/tchloGuvFZmeoip/8GbDRwOPQOB3W7QMr5LtvSs19QIhw
	VOHC8nJzVmwjc6OGRyEPDfSxaeGcrKrAryzF9
X-Google-Smtp-Source: AGHT+IFdtIeIKGwqs8GGh+Lxofd5Z52n9IK+1RzT3qfG+5yEL5/l9ViD+sLIobT0ztc21iosi83VUp5LSoaF8zJfWaY=
X-Received: by 2002:a17:902:6b8b:b0:1f3:3ede:9b0 with SMTP id
 d9443c01a7336-1fa09ef3919mr5294595ad.10.1719244594548; Mon, 24 Jun 2024
 08:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618221347.106627-1-yutingtseng@google.com>
 <20240622031600.3762859-5-yutingtseng@google.com> <CAH5fLgjR7iLHaWGy0NAiKnOUKro7_fBLoqFFzkdjn926jUdyAA@mail.gmail.com>
 <CAN5Drs0Gw6=xYVi0Naxm+A86mqckG4xjbEuvO9+UbAYHoEqYCw@mail.gmail.com> <ZnmWbpPNjQf0UUYB@google.com>
In-Reply-To: <ZnmWbpPNjQf0UUYB@google.com>
From: Yu-Ting Tseng <yutingtseng@google.com>
Date: Mon, 24 Jun 2024 08:56:22 -0700
Message-ID: <CAN5Drs06fbditeSaVLc6i6wEY+A47HHzQmhCS1rzJgacNs1Tjw@mail.gmail.com>
Subject: Re: [PATCH v2] binder: frozen notification
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, tkjos@google.com, gregkh@linuxfoundation.org, 
	arve@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:53=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Mon, Jun 24, 2024 at 08:50:43AM -0700, Yu-Ting Tseng wrote:
> > On Mon, Jun 24, 2024 at 7:25=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > On Sat, Jun 22, 2024 at 5:22=E2=80=AFAM Yu-Ting Tseng <yutingtseng@go=
ogle.com> wrote:
> > > >
> > > > Frozen processes present a significant challenge in binder transact=
ions.
> > > > When a process is frozen, it cannot, by design, accept and/or respo=
nd to
> > > > binder transactions. As a result, the sender needs to adjust its
> > > > behavior, such as postponing transactions until the peer process
> > > > unfreezes. However, there is currently no way to subscribe to these
> > > > state change events, making it impossible to implement frozen-aware
> > > > behaviors efficiently.
> > > >
> > > > Introduce a binder API for subscribing to frozen state change event=
s.
> > > > This allows programs to react to changes in peer process state,
> > > > mitigating issues related to binder transactions sent to frozen
> > > > processes.
> > > >
> > > > Implementation details:
> > > > For a given binder_ref, the state of frozen notification can be one=
 of
> > > > the followings:
> > > > 1. Userspace doesn't want a notification. binder_ref->freeze is nul=
l.
> > > > 2. Userspace wants a notification but none is in flight.
> > > >    list_empty(&binder_ref->freeze->work.entry) =3D true
> > > > 3. A notification is in flight and waiting to be read by userspace.
> > > >    binder_ref_freeze.sent is false.
> > > > 4. A notification was read by userspace and kernel is waiting for a=
n ack.
> > > >    binder_ref_freeze.sent is true.
> > > >
> > > > When a notification is in flight, new state change events are coale=
sced into
> > > > the existing binder_ref_freeze struct. If userspace hasn't picked u=
p the
> > > > notification yet, the driver simply rewrites the state. Otherwise, =
the
> > > > notification is flagged as requiring a resend, which will be perfor=
med
> > > > once userspace acks the original notification that's inflight.
> > > >
> > > > See https://android-review.googlesource.com/c/platform/frameworks/n=
ative/+/3070045
> > > > for how userspace is going to use this feature.
> > > >
> > > > Signed-off-by: Yu-Ting Tseng <yutingtseng@google.com>
> > >
> > > [...]
> > >
> > > > +               /*
> > > > +                * There is already a freeze notification. Take it =
over and rewrite
> > > > +                * the work type. If it was already sent, flag it f=
or re-sending;
> > > > +                * Otherwise it's pending and will be sent soon.
> > > > +                */
> > > > +               freeze->work.type =3D BINDER_WORK_CLEAR_DEATH_NOTIF=
ICATION;
> > >
> > > I have not done a comprehensive review yet, but this looks wrong.
> > [resending as plain text]
> >
> > Thanks for looking at the change!
> >
> > The code here seems correct to me. Could you please elaborate why this
> > looks wrong?
> >
> > This part of code gets executed if freeze->work.entry is in a list.
> > There are two possibilities:
> > 1. The freeze work of type BINDER_WORK_FROZEN_BINDER is in the work
> > queue, waiting to be picked up by binder_thread_read. Since it hasn't
> > been picked up yet, this code rewrites the work type to
> > BINDER_WORK_CLEAR_DEATH_NOTIFICATION, effectively canceling the state
> > change notification and instead making binder_thread_read send a
> > BR_CLEAR_FREEZE_NOTIFICATION_DONE to userspace. The API contract
> > allows coalescing of events. I can explicitly mention this case if it
> > helps.
> > 2. The freeze work of type BINDER_WORK_FROZEN_BINDER is in the
> > proc->delivered_freeze queue. This means a state change notification
> > was just sent to userspace and the kernel is waiting for an ack.
> > freeze->sent is true. In this case we set freeze->resend to true. Once
> > the kernel receives the ack, it would queue up the work again, whose
> > type was already set to BINDER_WORK_CLEAR_DEATH_NOTIFICATION.
> >
> > Yu-Ting
>
> Alice means you want to use BINDER_WORK_CLEAR_FREEZE_NOTIFICATION and
> not BINDER_WORK_CLEAR_DEATH_NOTIFICATION.
Ah, I see. Thanks! Will get this corrected and also look into adding a
test for it.

>
> >
> > >
> > >
> > > Is there any chance that we could have a test in aosp that would have
> > > caught this?
> > >
> > > Alice


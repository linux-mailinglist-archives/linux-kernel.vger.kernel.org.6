Return-Path: <linux-kernel+bounces-259963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DA93A088
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22181F23169
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E351514CE;
	Tue, 23 Jul 2024 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnwK8bAU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EB381B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738007; cv=none; b=bj4idRLZlVcD9IFlmrbC81O2hiL2HzMbSB1ijTErjoVIHj33nRqEHZ/IJ2vtpB53oOXjAmvND6uVOIpCwQYRlvdMxQQVhRrMjioQueKvZpDIqD4LOOYsqruz/0/5wBTLQr3wZRZ/LJdrkiMgxIxaNnkgph1SVB7ramky5jRfyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738007; c=relaxed/simple;
	bh=ozX2oB72wWV2eDTrM+2AnBK6VM7uIxYP5EqSiXL39TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnpOSMuZp8i67XZ3CwIDscS1eKKeu8Iels6nw9FcmvKFPWaLnTbaIeotL0hmKo4cgp/wUFeEtEkeFqTY3gU1wU6CFLrOSMYZzebWKacjH9fUMEBED6OEAqLVOopvCr8/cd5lgt7TQgY6xyHDEDie9ad4bpevho7gBnXkr83U4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnwK8bAU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721738002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umnUvX4TJ7YY7wo7pdX9m1aAVCpxnlv+zSmeSEMm56Y=;
	b=hnwK8bAU2zG+pSQkhIzNeeQJdusi0BUWFWsXNhHotwizDKn/a04UQ6+dDofDbNOfS8WYm4
	g95jGcIBB8dzL20RXjUHUpa2L2XrCt5p/MnQZHQejozQln0W7JA/OP95N3OZ23+qGDvvDw
	zJDFwSWS8vqv1Lr1lAHDQQpJuxoulic=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-ZKNMRQA9Psy3yASWJoyuYg-1; Tue, 23 Jul 2024 08:33:21 -0400
X-MC-Unique: ZKNMRQA9Psy3yASWJoyuYg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7a4ba59bdso98773426d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721738001; x=1722342801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umnUvX4TJ7YY7wo7pdX9m1aAVCpxnlv+zSmeSEMm56Y=;
        b=NPhLtjTeP8xXPvHx8gm2sAb/LdhGWIKlCfFVXg/ZtqQhSGRzHixXAYfiG3/4BhTHdc
         UTLb1xQaUMKCCq1Oaf+Ioigz2iiUVS4knH4cjSBccm8AjDv7QPm7JpNdnh6LrGIH1ue8
         KnbWdEDGalO19w2WlgBUE5jnaRDDEPc92CwsQVPahqJ7oS87iZN+EUBPXgrXn8V9bDAt
         N1n3nWvpxOSnuvuuCUwJhZ3c5ciZi11JMVg99hkULsrd26/aVSNIWLCYVa7ZhyyDZsYm
         PIn/hx+p15oY5suWJNc1Mi5leAj5dLs43LgkRxTLyBV913K18s/+X5rdAyoCb1TSOPPb
         kejA==
X-Forwarded-Encrypted: i=1; AJvYcCXDGgbg/qBhcDKXmOKuE5R1+don3laBA2SPOCj18Ba5uLGWPnpHr8SMaVvgFUHJI6N02+fBsnnwcNAQrLHmDW832G++mnF3VfpOt/eV
X-Gm-Message-State: AOJu0Yxw/pX9ZIuj7PbcS/IlPzhMsfnumCXYuKpwbgq2YtNVI0/aiXhC
	pLRGo4utkOPeBCgLMedDsDhC8isgT6QmgdBkS9YCVCfiShYzuC/EBA71i9AdUPgrCwWNh9L0/8U
	zV4q6XB/lEGbwnHC5vjnuGgFiz9aOHICZeIpGWosLYszEqKD1HTGX4+25u8lzhXlpVxVyCiYf5u
	JluUx2KzZW9Hk3d/4Xuzw9J4AIq4hxKOkbLyfv
X-Received: by 2002:a05:6214:d87:b0:6b5:34b:8c02 with SMTP id 6a1803df08f44-6b95a398513mr163733676d6.27.1721738001157;
        Tue, 23 Jul 2024 05:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVuml5AGzglvuvaUYEFublCEqkLdxahpbdsmbwARm9FY+wxUWbK6X875c/CPEBaFyiuFMjbA1Yznh8fQZ0ZaQ=
X-Received: by 2002:a05:6214:d87:b0:6b5:34b:8c02 with SMTP id
 6a1803df08f44-6b95a398513mr163733426d6.27.1721738000831; Tue, 23 Jul 2024
 05:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722132935.14426-1-wander@redhat.com> <20240722132935.14426-4-wander@redhat.com>
 <Zp90uZSUPkLmluEo@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Zp90uZSUPkLmluEo@jlelli-thinkpadt14gen4.remote.csb>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 23 Jul 2024 09:33:09 -0300
Message-ID: <CAAq0SUmQV6-NJnFGNuCFp-dTpFAft0tV0WL-Cht9dG_Sa1fCDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/deadline: Consolidate Timer Cancellation
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 6:15=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hi Wander,
>
> Guess this might help yes, only a minor naming suggestion below.
>
> On 22/07/24 10:29, Wander Lairson Costa wrote:
> > After commit b58652db66c9 ("sched/deadline: Fix task_struct reference
> > leak"), I identified additional calls to hrtimer_try_to_cancel that
> > might also require a dl_server check. It remains unclear whether this
> > omission was intentional or accidental in those contexts.
> >
> > This patch consolidates the timer cancellation logic into dedicated
> > functions, ensuring consistent behavior across all calls.
> > Additionally, it reduces code duplication and improves overall code
> > cleanliness.
> >
> > Note the use of the __always_inline keyword. In some instances, we
> > have a task_struct pointer, dereference the dl member, and then use
> > the container_of macro to retrieve the task_struct pointer again. By
> > inlining the code, the compiler can potentially optimize out this
> > redundant round trip.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  kernel/sched/deadline.c | 44 ++++++++++++++++++++++++++---------------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 908d5ce79425..8b0bbade2dcb 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -320,6 +320,29 @@ void sub_running_bw(struct sched_dl_entity *dl_se,=
 struct dl_rq *dl_rq)
> >               __sub_running_bw(dl_se->dl_bw, dl_rq);
> >  }
> >
> > +static __always_inline
> > +void cancel_timer(struct sched_dl_entity *dl_se, struct hrtimer *timer=
)
> > +{
> > +     /*
> > +      * If the timer callback was running (hrtimer_try_to_cancel =3D=
=3D -1),
> > +      * it will eventually call put_task_struct().
> > +      */
> > +     if (hrtimer_try_to_cancel(timer) =3D=3D 1 && !dl_server(dl_se))
> > +             put_task_struct(dl_task_of(dl_se));
> > +}
> > +
> > +static __always_inline
> > +void cancel_dl_timer(struct sched_dl_entity *dl_se)
>
> Maybe we could call the above cancel_replenish_timer
>
> > +{
> > +     cancel_timer(dl_se, &dl_se->dl_timer);
>
> and this one cancel_dl_timer?
>

That makes sense, I will change it in v2.

> Best,
> Juri
>



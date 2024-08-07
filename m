Return-Path: <linux-kernel+bounces-277857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59B94A758
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4D1F205A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD051E4EE8;
	Wed,  7 Aug 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeNVrdYS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354C1E485D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031953; cv=none; b=VZ3DA0G8X82VL47ibgWW1EqKXV5bWSmbtW3iiDwTzg2YuFWpri41uq2RIUhQAorxQ/CrGwUwqQr4WRyKEju+bL6XcDkQ0RNf3HzyCFQCFBnGvMKrx+0bUQK5jAVfQ3Bx/1J2f19Bek2g9Y9l3PK25MeSf9IXsm4/u2KHODSZmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031953; c=relaxed/simple;
	bh=H7I/b8FBTTDDpg9mVnitj65fPuFgrpGKKnlp8Dgmty0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFsm58F1tfuO/nWsK/dlX00opv7pZNCfdBsTGf111vy7Trjm0AVmOI/IJR/6AxjZkwIo+0h57zFoA6dWws/IZCHxx5I2zCEdmR99IBYGBnMocWjzaupU0RGWfoiF2Q+4BJtsPZo1z+XqLoWd11DV5ueifBmYpIFjuR2X9tAblsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeNVrdYS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723031950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoCpRuKtZYrCBFKcWq0Q4CeBzsPrhwpKwrFTQG450Yk=;
	b=NeNVrdYSQq3yBSCWs7gbmswIKV6m7bLGER2K0uNFVePVNkY6OMLE10Qra+rMovEa9G18tp
	0kegBWhSMXjzXwWfoUzRJhPllvl5uQVR7Lh5+v1T1scOhltcIDdn2u83srl+u/cR5dQMfi
	P/QhcKH90D6ulojMBqD1VgHl9CwENmE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-wDYXdo1DPlaj_DX7e2CKDg-1; Wed, 07 Aug 2024 07:59:09 -0400
X-MC-Unique: wDYXdo1DPlaj_DX7e2CKDg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4501f17051eso20467681cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031949; x=1723636749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoCpRuKtZYrCBFKcWq0Q4CeBzsPrhwpKwrFTQG450Yk=;
        b=gDt5NSzMjuS4nNNx3A1xIED5/vHL8AmkZCgGbZOGD2Hcp0U29qSrPgmxtruR3Woqq+
         RRS+GoqAM3wb8Ql3LzDoxsXfiqzt7gIa8sOfZle7m7yB34vo6lFBY/dRivIGODaAv+oC
         2gKk1Dui9cfhys73gaGiUymGrIOeJqU2GU9/R4sEMKNzi8rjUGBprJJcGEAyIJIHsgNI
         cHLL5qv2R4fybT7jeiokqpWxrgESdu5Gq39laLlfo4+bSMDyMtg1tDFjE2mB9VPRK4jo
         nqnyDlsbA9nVx8VxLbKOCyHeT1Kp/ia3fB+esD0tMCCDZO8yjbf9NfKMEyHH2x/ruY4H
         RcZA==
X-Forwarded-Encrypted: i=1; AJvYcCW9zxLhh+Cti5kixVliF699QIZCR0wjB/cl/GDWmfwTsCwOD/9JgeTCpUN2hrPaBWWnQC8eHeDkpvuAAQO8h1QcNnu5SA8ofyunG6sa
X-Gm-Message-State: AOJu0YxIObCV4wayEa7i2MxpqKzdLiF5BCHdEKaoo2FJ4nPmBQWAx3hc
	MPEr0RIOCYWUCxEmudVmq4BkMcAVJ+ZC1ArjkD7KBRJB/D9tFs4hEP2Jq1bLcDSd6HJt3b59jyU
	3J2Obc2RKjUXa+VT8gy5kvjCkO0Q4Q9FwbYDwiILeaYvAoq56dhv8fJBR3ZEYn8yeqIbhVwTtmW
	D14Yc0G/2xcUtSGoq9pIJP3hROELe6ZWNVBZ4B
X-Received: by 2002:a05:622a:ca:b0:44f:ee1a:3410 with SMTP id d75a77b69052e-4518928b827mr229397971cf.20.1723031949286;
        Wed, 07 Aug 2024 04:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKz4WSnWrrpqKqowkamPc1AfDXi0WxZc0iQMg97o/pp6TnUpB2iVowRQYh54sUO8DBhDdH50fCAQVJ3dJVzfs=
X-Received: by 2002:a05:622a:ca:b0:44f:ee1a:3410 with SMTP id
 d75a77b69052e-4518928b827mr229397781cf.20.1723031948938; Wed, 07 Aug 2024
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724142253.27145-1-wander@redhat.com> <ZqH-1o9pc062F-hG@jlelli-thinkpadt14gen4.remote.csb>
 <20240807105944.GA31338@noisy.programming.kicks-ass.net>
In-Reply-To: <20240807105944.GA31338@noisy.programming.kicks-ass.net>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Aug 2024 08:58:57 -0300
Message-ID: <CAAq0SU=yzLOajp=0X_HZaTt0ZnKT-mC5ZH-FZmz5=+XZS4tVRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sched/deadline: fixes and improvements
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Jul 25, 2024 at 09:29:26AM +0200, Juri Lelli wrote:
> > Hi Wander,
> >
> > On 24/07/24 11:22, Wander Lairson Costa wrote:
> > > Hello,
> > >
> > > This patch series addresses specific issues and improvements within
> > > the scheduler's deadline (DL) class. The patches aim to fix warnings,
> > > remove redundant checks, and consolidate timer cancellation logic for
> > > better consistency and code quality.
> > >
> > > Patch 1: Fix warning in migrate_enable for boosted tasks
> > >
> > > Fix a warning caused by unnecessary calls to setup_new_dl_entity for
> > > boosted tasks during CPU migate_enable calls.
> > >
> > > Patch 2: sched/deadline: Consolidate Timer Cancellation
> > >
> > > Consolidate timer cancellation logic into dedicated functions,
> > > ensuring consistent behavior and reducing code duplication.
> > >
> > > Changelog
> > > ---------
> > >
> > > v2:
> > > * Drop patch to remove the redundant WARN_ON call.
> > > * Change the "Fixes" tag in the patch 1.
> > > * Change function names in the patch 2.
> > >
> > > Wander Lairson Costa (2):
> > >   sched/deadline: Fix warning in migrate_enable for boosted tasks
> > >   sched/deadline: Consolidate Timer Cancellation
> > >
> > >  kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 29 insertions(+), 16 deletions(-)
> >
> > Looks good to me now.
> >
> > Acked-by: Juri Lelli <juri.lelli@redhat.com>
>
> I stuck this in queue/sched/core, but there was some trivial rejects on
> the second patch, which I stomped on. It builds, but please double check
> I didn't mess it up.
>

I gave it a look and everything seems fine.



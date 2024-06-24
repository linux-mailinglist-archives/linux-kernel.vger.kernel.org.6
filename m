Return-Path: <linux-kernel+bounces-227984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3A915948
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24513B218BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2C813C901;
	Mon, 24 Jun 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAAIKdTB"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E64962C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266056; cv=none; b=YhgImvdy7LWEF+OuX+zCT5XUwzjBJIhbv/NXQnPkBq4P0s8pVsR5ypKwy31eDU3rOTEPL6LwDMn2C5rPSOMF3nY6RaU0Y1XmJQ5x9ld5OyDDCv5K4vOyXyb10evVD+ks5xkuyykAefkb3wmi8hGjwk+lhqtQWQsIB4emDje6Gnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266056; c=relaxed/simple;
	bh=l45P9FyiFLa91DP9dHhK7vXylPyi8T10q6ip0p2RaOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJL7iGyth2swg6HWCiDR4pZeWqVZ5FxW53Yew4zNAphWWYK/YsfdimxX3+ygFJ0iSncP4m36M4a4vVzJCcMyczOraC29TVjkUCoEKo1TFXmtbu8RqrbDjroqp0g2KKyskID4fdlqXcTztv/oye6BugYrVohqibUeDp81plQbBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAAIKdTB; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-254a7fe21aeso2507993fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719266054; x=1719870854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l45P9FyiFLa91DP9dHhK7vXylPyi8T10q6ip0p2RaOg=;
        b=bAAIKdTBfg5zhQOJs3g1TNwvyGrOaVZeyy0UYWPjwpCh/IkiTkRSTlP9/+yYiGOQ/s
         12MMG4BtdiAeiDryt9cTpmdr4Z8Pk0NtS+sKSGgrQBR5V8DkGLB9NEzhmvFDD3+iITCm
         eYnRSr+viw5BC6y0wz9lXOTgtPf8VuGBm4f+Yd1bQt4GV9uRM+7Szi0ffHDkj+BRyzXe
         vEJL2WwBWvkQ3sBZSo7NUN6VbL4ySVU5fUaxiRbqImy4JcPrZLjigCEldj3+6+I4lXc0
         vMVUsXZ6mLeAYjvMR/+6mMQdRlBJ7YIB18kz2gXusXi0rzdRfWleTbO+nUvyidFddfNX
         3PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266054; x=1719870854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l45P9FyiFLa91DP9dHhK7vXylPyi8T10q6ip0p2RaOg=;
        b=fCbJMU6srhkUkHdYkFqwoLcJCAMrlgTqw1fCfj44L5BSLeKE4ZKCat3U62ym225Omz
         a/otjT1p7c5AYqzNUfLdaWKH1J7UZTEHTXjhRFOY4DlGxtolravvvm9SLD41IViwqz/m
         jGX8RfF7gwMA/m0iBTs8bVl0Odc4aYCG2BTwFo1sV52v5a6AYN/LQmhP6awOtPO6NpqS
         x/Ni+o5Mb5OTM9qNx5Sv5j5wkxWcnJS3y3r5nOmKpSiE0tfMPcDiUXxCTLY7COvtzgjL
         5MqIoA68qzghhyMzm83aabg2evWzSi+Od1vWuntGS/mh7JIlvBy+h8Ek04UtW/38PB43
         2FgA==
X-Forwarded-Encrypted: i=1; AJvYcCW0/FU9jSajF5uUsLz2J2B+G7KnJKoqYUYTA4iiKCxt/R6XGx/1Tl1LzTf/t8c2H8lpzzPRthwalyOPbTut4YHDDQIhynLD3btAUklU
X-Gm-Message-State: AOJu0Yzf0sQrNc+I1As/I+1t9jRJaTwfqvrKxsdw1AFzZgBz6OQ5Ha7G
	RTAMLThUw324fSojQv8ZaovjfoSIt2R6F1rRbmUZBPmGGjc1/AoOdLnUOCZwoteDnS1XvNdRvtb
	tpRexY2GPiKvmjBXM710ALbPwep+HnwmR8qSi
X-Google-Smtp-Source: AGHT+IEjJIp9HikBzMGB+GICZNBUfgcYH5qdFxgMJrlty+6si+IJS0JI9tXBlaH3hM/rOLZr454rM1lwjM6FfPmTIbo=
X-Received: by 2002:a05:6870:d1c3:b0:25c:adef:2348 with SMTP id
 586e51a60fabf-25cf8a3839amr2705146fac.12.1719266054293; Mon, 24 Jun 2024
 14:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
In-Reply-To: <878qz0pcir.ffs@tglx>
From: Peter Oskolkov <posk@google.com>
Date: Mon, 24 Jun 2024 14:54:02 -0700
Message-ID: <CAPNVh5cn9N21jC9cbVfPbZQEQgT1MDn-N9R4RgZuvF9h3byhZA@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com, 
	haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com, 
	dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com, 
	himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 7:35=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:

[...]

> Just for the record, the scheduler people and myself spent a lot of time
> to help to get intrusive features like UMCG into mainline, but the
> efforts were dropped by the submitters for no reason. Short time after
> that sched_ext came around.

Hi Thomas,

I'm sorry I missed this callout re: UMCG last week.

The efforts were not dropped on our side, I assure you. For example, I
posted this last year:
https://lore.kernel.org/lkml/CAPNVh5eNEBu+gcex9pAej-_YN3zMKkG+rruXhopqS6EaG=
-izVQ@mail.gmail.com/T/
and I got no indication re: how I should proceed.

There were several earlier LKML posts that similarly did not result in
any actionable feedback. Based on this clear (maybe just perceived? if
so, I apologize) lack of interest in making UMCG ready for
upstream/mainline, we've decided to wait for sched_ext to get merged;
sched_ext already existed at the time, e.g.
https://lore.kernel.org/lkml/20221130082313.3241517-1-tj@kernel.org/.

I believe that sched_ext is flexible enough that, once merged, it will
allow us to build UMCG-like per-process schedulers on top of it, so I
see no reason in pushing both UMCG and sched_ext, given the difficulty
of getting anything merged. If I had to choose between UMCG and
sched_ext getting upstream (and I do not see both UMCG _and_ sched_ext
getting merged together any time soon), I'd choose sched_ext, because
it naturally opens up more opportunities to tailor scheduling to
different workloads.

Again, I appreciate the initial help and feedback you and Peter
provided re: UMCG; but then things stalled and I was not getting any
clear indication how to proceed; and given that UMCG can be built on
top of sched_ext (or ghost), and a clear (or perhaps also just
perceived) preference by sched maintainers to avoid competing
solutions, I now believe that sched_ext should be merged first.

Thanks,
Peter


[...]


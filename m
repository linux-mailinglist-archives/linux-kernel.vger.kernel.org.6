Return-Path: <linux-kernel+bounces-429703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87BC9E20AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66C5168D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCA1F7071;
	Tue,  3 Dec 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XXpsw74m"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E31E3DF9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238040; cv=none; b=JKGTxpS3YR0smK8/3mP3Yl5koKxa7mbrWdQZTxVQxKuKre6zCBN7ifm/hxXhaAFZEzY5mAbcy+MEfMP9gYhzadJ6vzpV5s+dm1WVTPGAt91u3Z2TErAL+p/x5r328/bJgN3yHS2bRxfghtzR616QJJAXYNiwc0a1bZQ8v8fjqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238040; c=relaxed/simple;
	bh=xYdG6YiEKREyfGjp9fPGIDehVO+II6FjrLqDnuvl/CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsQgUAwOOneH/xMlYryHHW9TD2Q1jzn5xZFsPVP8qqV/6MmssyrF9/iOwsNXmTChgduJuBSKXIkOLA7OQF0qlDL/68gLQU7HX09DlRD5O91538AIuYQ4tXFxuSVcCkDaRXm4Md0MxlnpV6YADk6x3HhTHb6DXXSAOF2qtyq1RJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=XXpsw74m; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso5217093276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733238037; x=1733842837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYdG6YiEKREyfGjp9fPGIDehVO+II6FjrLqDnuvl/CI=;
        b=XXpsw74mVrFoPVOUXwd5roI023HY29iVTclpql/74YIJXLwUIzPxhxlLSYIf+7C397
         u2hkzXZ262C4X5tZZ24e30BCVvm1huyx7/0Y5Qmj0XnuB9z7/ftfnf9hv9v/n1vY75tW
         RISI92oeAShx3slFVPLyRj/aRQXSkElLMD8bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238037; x=1733842837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYdG6YiEKREyfGjp9fPGIDehVO+II6FjrLqDnuvl/CI=;
        b=edo6SFvIF5jDnIAJOU7XFXk/QwqNeno5qpgoKoJ2aNXFus8m+xK0j63/k0gWLZolpw
         UcrvKtFTY7l6oKT8sLLhrRAw10VfQPYWsKxKzZxx49bDRu2ETDCHLGYcRhuJBkHLLC2e
         pyy/9Es5mCqf5fhqxrslpHOtusUGsOu3KK4Lj0KOhjqVaoipoSa5yQKrXfeSs5sg1bpH
         pUSHgjO+HmJTIlyl5jqnLEJOsDo3pX8Qz3FzEQHFule9V6GS6dLac3wuWtfsJzJeCscS
         lb125US4A1zSP4szIHxidiwtYNNLSx2SQ9w3R9OOi4Cn2NsF+MP6G8YCyQEJE1nOtQLE
         FTRA==
X-Forwarded-Encrypted: i=1; AJvYcCXVKbXl+8tOa0dy1QtQha+k9VZEiC0KcpYSRwm8IH6uGjqnko+TwNQfVWAjsk2umozfUR/km+77WHLkPbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ph23AmjOfjAZlWnTPmLJaZhCD5c0P2Ta21m/MiGxUMJdFxGp
	AWeA5AGQdf537lqvBl53nprk6PGZ5hZLDGP2QPtHSzoaEEcvFqKA7IwhWA1LVig7u1A4FG+2/kb
	mjjn+oAcr8OcnDzywgxhZ5o+HynvBHAFyf6SyEw==
X-Gm-Gg: ASbGncvbZ/SzeCBb2DZRzd2vIweK3S7sJxsvC7FmFix/LfSIFtYwZHLPmXNwNI6IIPe
	6+0qc9lBJo5/H4l7DbmhjrerNc4KJXZeq
X-Google-Smtp-Source: AGHT+IHRBFQmfm+41Q5jBpD1n0GIw3d9h3v9DOtoxp1AQL7jHIgH+IMa5yeDq7jLQOG5SQPiBGSig1+NhW7ZskWGNiw=
X-Received: by 2002:a05:6902:1b12:b0:e38:a550:89c4 with SMTP id
 3f1490d57ef6-e39d3a29589mr2748197276.14.1733238036551; Tue, 03 Dec 2024
 07:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202140735.56368-1-gmonaco@redhat.com> <20241202140735.56368-3-gmonaco@redhat.com>
 <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
In-Reply-To: <c16481a7-20f1-44b8-981c-fd31cb331cbf@efficios.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 3 Dec 2024 10:00:25 -0500
Message-ID: <CAEXW_YT1NLU2xsBHwDjbBPg_rZWc4hNGNgmkdxF8C_0Dw60N1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	paulmck <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:34=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> +=3D CC RCU maintainers, reviewers and list.
> +=3D RSEQ maintainers.
>
> On 2024-12-02 09:07, Gabriele Monaco wrote:
> > Currently, the task_mm_cid_work function is called in a task work
> > triggered by a scheduler tick. This can delay the execution of the
> > task for the entire duration of the function.
> >
> > This patch runs the task_mm_cid_work in the RCU callback thread rather
> > than in the task context before returning to userspace.
> >
> > The main advantage of this change is that the function can be offloaded
> > to a different CPU and even preempted by RT tasks.
> >
> > On a busy system, this may mean the function gets called less often, bu=
t
> > the current behaviour already doesn't provide guarantees.
>
> I've used the same task work pattern as NUMA here. What makes it
> OK for NUMA and not for mm_cid ?
>
> I wonder why we'd want to piggy-back on call_rcu here when
> this has nothing to do with RCU. There is likely a characteristic
> of the call_rcu worker threads that we want to import into
> task_tick_mm_cid(), or change task_work.c to add a new flag
> that says the work can be dispatched to any CPU.

Also there is no guarantee that RCU callback will run within a thread
context (example, some configurations run it in softirq). Further,
call_rcu() usage as shown in this patch can also delay callback runs
by seconds (with RCU_LAZY enabled).

See also #5 in checklist: https://docs.kernel.org/RCU/checklist.html

thanks,

 - Joel


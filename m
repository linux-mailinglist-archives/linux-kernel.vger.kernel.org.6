Return-Path: <linux-kernel+bounces-246539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481ED92C343
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792191C22A44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EF5180048;
	Tue,  9 Jul 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwCu+Gqq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2F180024
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549746; cv=none; b=ewin7QSFMWjgoqePPiypNL8NnqYpc5SVvsPdQJ7L2P8Qfm0xQU6IDLoDmhfXSAIjvmtnt3ym9HwsbHC6LQLWoNEaSHi3PdUmT6Sr2tqKRtE4FPjPIFlXcrlQ9EhIfpao8plL2EJcnybMgg1TKZq0she6PwNPNAi2I9c1n38J2cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549746; c=relaxed/simple;
	bh=8BUF3uQphB7zNR9GdP2Cs0yHJ1fJJEUEh0wLaKrlRbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU9xqEQgl0+zEXPPRY58mB+wxdOsB8UEudxavgs3BWOKc9oDGby0I7x1mw8JTLy1WnRBjep0fE6X+2Ni4vkzKalT0nJDI07pIYDztg/etcRkvySetkiGbMzBCTM/sQxC3/XQwOn3msJ/ZHJjcM1VjfIk4J4q0fNO3f9ZPvwlGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwCu+Gqq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso1797a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720549743; x=1721154543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BUF3uQphB7zNR9GdP2Cs0yHJ1fJJEUEh0wLaKrlRbc=;
        b=cwCu+Gqq3AC2R4nkhdHlPCL6f2GGLIFvx7m4cCdhtuoCCVVp/kalNiV/dvCeABJCST
         1Sv7f5sv0NzPYi09Cfh2qHU0JOK48vHsxcjtKnzgkb8HSuxM5Z4c9SyC1HjAtnz8oyPd
         2DckLVZtjP2oer1nyWOeEgbbtY9hYMUfFmpD9MKl18KpT8bytvznzU9XQ3ZLIiBAC726
         a2gRd3K+eWK0tIQ/tfOfCM2EzC8NLiGjuebMHqbOs//bG9+gFaTDWH5S4Ek50XJA1Ur5
         CscCHR2Uk3lclEL3zsCM8UD3bDjutL7shXELFwI079Nrsx6aWE+jDgLEJydPLpvY5Sz4
         3ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549743; x=1721154543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BUF3uQphB7zNR9GdP2Cs0yHJ1fJJEUEh0wLaKrlRbc=;
        b=hXYBbX2fAKFICGo1xq3CAv+xu99XBi3TOuka30IGTGjHgweuf10UG63pNI5H6I7q27
         qr473nfdoswbAiOBQlTTVIOl5tmpSId6nByFTGum3vSvVriUsgsXnW7A/zoWpAwWEdZM
         nLUgOsAS4vMYmcP/byOlYOe3B41Ws4vRnEtIiAaifkE+NF5xDoD1hl94U8khpVYlzQ31
         lbNvlvNLUXBtvO7qOyX6D+RtEHvtOXuV+NiVOmfJdAwHw/4qbqtOAdZ/Ng8YbscMUak0
         aQFWFWNZPmxyAilk9nPLet404tp9HBrPeah/MrFzE7kRr49Jr+NYkgAWQAwDX0+nClYf
         LUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbRUd1tdQbKF5IbALoqtXori7JnbIpdt7BE1eXHAWtoHNuaUTt270kMatTRuKIPjoKckj5exORuFXUf8JBPkIvJdVINHclzDvtnIQW
X-Gm-Message-State: AOJu0YwWHeZisSZbnDXA8CFrbrPAsvzmzJOmMWZW8K+kxZ7Uo98OM33g
	jkN9ee4yaK4ou9HQjKra2TO4RsxQaT3saXK31mdAgk+f+1j59JSGKkX6jEHuCjR7CUlNFvpSOaE
	tGQIVWI6VVtRdjFY8mfEw/9+bzDPweMe8iJFZ
X-Google-Smtp-Source: AGHT+IHjWOkBMYlcs0li/LQItrztt29ZGqt8TDBfqfFr7lj9swq71tV17+dO1YLlXFOcFlSiW/jGffQcNTqJjHsBqao=
X-Received: by 2002:a50:9f84:0:b0:58b:dfaa:a5ca with SMTP id
 4fb4d7f45d1cf-596d4daf533mr18543a12.6.1720549742556; Tue, 09 Jul 2024
 11:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
 <20240708120254.GA27299@noisy.programming.kicks-ass.net> <CAKfTPtDxdLpm6cC-vv1PpHaEtiOeLtuCwChgZ6Ypg6owz3Vvsw@mail.gmail.com>
 <20240708142832.GB27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240708142832.GB27299@noisy.programming.kicks-ass.net>
From: Josh Don <joshdon@google.com>
Date: Tue, 9 Jul 2024 11:28:50 -0700
Message-ID: <CABk29NsdA8ebRPjNWSYOeXgTQP3xQDyUw9Vn864hAfuh2+VG8A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Make SCHED_IDLE entity be preempted in
 strict hierarchy
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Tianchen Ding <dtcccc@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 7:28=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Jul 08, 2024 at 02:47:34PM +0200, Vincent Guittot wrote:
> > On Mon, 8 Jul 2024 at 14:02, Peter Zijlstra <peterz@infradead.org> wrot=
e:
<snip>
> > > The 'problem' is that the whole BATCH thing isn't cgroup aware ofcour=
se,
> > > but I'm not sure we want to go fix that -- esp. not in this patch.
> > >
> > > Hmm?
> >
> > Good question, but do we want to make SCHED_BATCH tasks behave
> > differently than SCHED_IDLE tasks in a group in this case ?
>
> I suspect we'll have to. People added the idle-cgroup thing, but never
> did the same for batch. With the result that they're now fundamentally
> different.

It isn't clear to me that cgroup batch behavior is really a useful
thing that is worth adding. After the EEVDF changes, the only real
difference between normal and batch is that batch don't preempt normal
on wakeup. Contrast that to idle, where we have a pretty meaningful
difference from sched_normal, especially with sched_idle_cpu feeding
into wakeup placement and load balancing.

Happy to be proven wrong if there's a use case for batch wherein the
wakeup preempt behavior is useful at the group level as well. Honestly
it feels like it would make sense to revisit the cgroup batch question
when/if additional behaviors were added to further differentiate
batch. For example, maybe a batch cgroup hierarchy could internally
use longer slices and have a slower round-robin preemption rate
amongst its processes. The wakeup bit alone is limited, and the
supposed target workload of low-priority cpu intensive threads are
unlikely to have many wakeup edges anyway.


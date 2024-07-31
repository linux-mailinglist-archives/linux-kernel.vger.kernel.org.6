Return-Path: <linux-kernel+bounces-268830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6F9429F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2001F23025
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC81AAE16;
	Wed, 31 Jul 2024 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSV5AuUP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D37E0E4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417120; cv=none; b=VJNz6lHTpdAfByz5jwh0PfSf5x9HcgnmSbFykpot48EPjes0Y/g8CMJPdIRylTSEQ1Lr8TGAiWVCLVGFAM3/BaetloMgcgJZSRvVYMwknxJ4mNYg6k5uNeFQWgz3PjSy0yffZ0GhvWXTdtFr8r1GCAugn5TEJArLQX8EYGDdaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417120; c=relaxed/simple;
	bh=zFOwlz7RZsJ8oMl5zb5Mc3EfRfbjz3li9FUcBAInntU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H98QCGB7zE1Ekc25348cYrw3kuGsE4NzQgamhl35dO7BpnRoSpPSIh2HlLzPsrknLsz4N36CRayM37Fkq5b6rk8AZFXfrPkhsoa1g/9JliVr1xyAsPEQkkctO1po0D4yNhe3fPHwaPUJ2wtmbWTlAUZKnX1kcvJVop1s9vZa8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSV5AuUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722417117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sirp2+QEfzINAnGuq8bJ5Suh2ooYaHREjKEjCWBban8=;
	b=cSV5AuUPqQ32tr8YGVFZG9NN/rSs4/al3n8W9mNCIrA6KDsqklS8b2VXVbvHtRB0TRpUKz
	ysdPKLsEQf5T/o6GDWqru9CCMkhLshecxn4XmZ3a7ODtX4Y9qqNox0BM4+SvfhXULdGlVp
	Cu7n/UNRwcvdY4+n67fhPFxaFrsKvKo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-i6vyHOAZOQuibCWnFswWbw-1; Wed, 31 Jul 2024 05:11:55 -0400
X-MC-Unique: i6vyHOAZOQuibCWnFswWbw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44fe49fa389so75037561cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722417115; x=1723021915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sirp2+QEfzINAnGuq8bJ5Suh2ooYaHREjKEjCWBban8=;
        b=Berx8FXSp0m03fXm1c8EsAi+6dUbVzeD1gvTdlL63nj1pmyywgKBfH36tdGY8SeDL9
         +D3Ozqk+h7BCwNChHQEBdg1OAQ5Jkky56JJy5vcTizW6O4+RmofjDmKVZve1mpLPKzBV
         iJgQ7AUlo0T14VAo3EU5xc9WAJjl0LzyMmV1F0lDfTNoGZ6wBaAmhlIg0pxRaHLQLEi6
         lv7QfibT30GuW8Kd2ZiYCQzo0m6lsSQJm/+ofjenxsuKYMMCWwmw9OlfkXM/ZIyDLKKY
         mvYb/BA84jhwAkD8h8EKWoe6EmnlySxcaiSpLQquQx+9Sx1UHfRhi7oP/cRkNq/6uEE9
         N02A==
X-Forwarded-Encrypted: i=1; AJvYcCVYTtaCNYGGmMnou2h3fZ+VYWf3rGUzqtQ6bh7l4CNHbS4gc1Zmh+0G1RkX2q62/I3DolPg9+LZnziX5AxyM9w+0Iz5oe8i86Uyb5xq
X-Gm-Message-State: AOJu0YzWbwS7jzhCv9rIE7LeKteICYJR4kh7wHPcehpIEjh02S+LCtYx
	wdvgpjq8EWjrvMWz2iZwkARKsof7N5SKsy4zSt2t683zta7NZbZNfInlfIJWCLjEN3Juz2bM9/S
	ux2f/UVuhs38Eh6mI1a2ePX2tF2iGKnW+KUkxlM4ddxueTyiEmtDvi/JW9BbmvA==
X-Received: by 2002:a05:6214:2b0d:b0:6b7:9bc1:708a with SMTP id 6a1803df08f44-6bb55afc2cfmr127943916d6.55.1722417114905;
        Wed, 31 Jul 2024 02:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrsFWsmEQ/ZqG8MzZSOiY36geaZbDTr1xKB10ZveFrjXlXor+opFKorbcmshQHqYMBAoGVGQ==
X-Received: by 2002:a05:6214:2b0d:b0:6b7:9bc1:708a with SMTP id 6a1803df08f44-6bb55afc2cfmr127943556d6.55.1722417114500;
        Wed, 31 Jul 2024 02:11:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a02:b125:8010:68f9:cb3d:8fb3:24a5:346c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac396esm71342926d6.111.2024.07.31.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:11:54 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:11:45 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
Message-ID: <Zqn_0XIcxTpHxswZ@jlelli-thinkpadt14gen4.remote.csb>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net>
 <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>

Hi John,

On 12/07/24 12:10, John Stultz wrote:
> On Fri, Jul 12, 2024 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 09, 2024 at 01:31:50PM -0700, John Stultz wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Let's define the scheduling context as all the scheduler state
> > > in task_struct for the task selected to run, and the execution
> > > context as all state required to actually run the task.
> > >
> > > Currently both are intertwined in task_struct. We want to
> > > logically split these such that we can use the scheduling
> > > context of the task selected to be scheduled, but use the
> > > execution context of a different task to actually be run.
> > >
> > > To this purpose, introduce rq_selected() macro to point to the
> > > task_struct selected from the runqueue by the scheduler, and
> > > will be used for scheduler state, and preserve rq->curr to
> > > indicate the execution context of the task that will actually be
> > > run.
> >
> > > * Swapped proxy for selected for clarity
> >
> > I'm not loving this naming...  what does selected even mean? What was
> > wrong with proxy? -- (did we have this conversation before?)
> 
> So yeah, this came up earlier:
> https://lore.kernel.org/lkml/CANDhNCr3acrEpBYd2LVkY3At=HCDZxGWqbMMwzVJ-Mn--dv3DA@mail.gmail.com/
> 
> My big concern is that the way proxy was used early in the series
> seemed to be inverted from how the term is commonly used.
> 
> A proxy is one who takes an action on behalf of someone else.
> 
> In this case we have a blocked task that was picked to run, but then
> we run another task in its place. Intuitively, this makes the proxy
> the one that actually runs, not the one that was picked. But the
> earliest versions of the patch had this flipped, and caused lots of
> conceptual confusion in the discussions I had with folks about what
> the patch was doing (as well as my own confusion initially working on
> the patch).

I don't think I have strong preferences either way, but I actually
considered the proxy to be the blocked donor (the one picked by the
scheduler to run), as it makes the owner use its properties, acting as a
proxy for the owner.

I think that in this case find_proxy_task() might have a confusing name,
as it doesn't actually try to find a proxy, but rather the owner of a
(or a chain of) mutex. We could rename that find_owner_task() and it
seems it might make sense, as we would have

pick_again:
        next = pick_next_task(rq, rq_proxy(rq), &rf);
        rq_set_proxy(rq, next);
        if (unlikely(task_is_blocked(next))) {
                next = find_owner_task(rq, next, &rf);

where, if next was blocked, we search for the owner it is blocked on.

Anyway, just wanted to tell you the way I understood this so far. Happy
to go with what you and Peter decide to go with. :)

Best,
Juri



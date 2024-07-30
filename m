Return-Path: <linux-kernel+bounces-267717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A159414B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE8F2838B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F519EED3;
	Tue, 30 Jul 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjGPAUvI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06F79E1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350811; cv=none; b=WhJ0wm1zn3uXwp2ALQLpwgYdlenk6N930sm7MAFrPgTfdx2Is1JxFwo4cnpcLqNvUvXWJIktPm8VFrmuDNPvGTk98bDLnXF/FvXoJQJDqavMMiPoh3U18rL3P5SqEycOYkdm39YhkLUJzcyeiT6k2qCgwyWozS7g4+ihJyRpbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350811; c=relaxed/simple;
	bh=oC98K+/uP2ulEhiSFvaa7r8hmIQrO+uQqJU63EJxnk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZpjEavWQeMROoSXKyesTUtyPtD3UKhFHMHylKAxga4pTS2709hkQskaGBrvb7Z7T4haTrE/XKrYxcVj0VmHAeOJQRdW4uVyObVTUT5HLDydlpvXwSNXBNbUNLWcGs6z2bVgH9ks5W3ti5HXV9Cjox3ajxL2P6UEdDUtuh7vxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjGPAUvI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722350808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DFPl+J7YPtviyTYpbOxx/IbGbVaKmw1fqnbalrTj8A=;
	b=WjGPAUvIk1Fj6vtsGCC6dxBHLv623TGDD++tI/P9RF3unkrXxVwYO1nL2Ct6FkbxSL6Il7
	tua8v3m0n6a1w6e9OodHkI1O5ADJi3wJuJ3hgCpv/bD6FR5sOVtwhMclajsX9kviXODbx7
	Dd9i9d22iexQE+7/u7+Jo169NIUBCLs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-S2LxN0q4OvuUlIt2GOLMgA-1; Tue, 30 Jul 2024 10:46:45 -0400
X-MC-Unique: S2LxN0q4OvuUlIt2GOLMgA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280b4a34c8so28365875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722350804; x=1722955604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DFPl+J7YPtviyTYpbOxx/IbGbVaKmw1fqnbalrTj8A=;
        b=av1YLJdE3oovgSbDc9CssORMi08OV03h65EPf/zDSRPpEGthKOzvG00GkQih7uGkvG
         vD8UGEGDn0qFPqmzzBoir6HXpM4QGMR1ckJnZUK0n2yAeVXr2wNAvbLw0VVN6g4YwkFL
         ZbMBkEC40euQSKKWMMlNgUVJ5tl6XNI2WiQDRtaY9bDaHRHXe5H+4oLrhPCANqcM8WzX
         nr+6vdtCkJDzYspoeQhS0PNTNbRvo7Us09uY2yutuChCPNmICI8KWlkqkhWzR+ayHih7
         VIHu0HKaRzENGkn31LPmSjllq3TJcjozU45BnpgLmwttkVskA7TltMlS7nlaIKR1qZ0Z
         m7pw==
X-Gm-Message-State: AOJu0YwAjheR5UsTasVISdhGD8ibPj42tXu4w9EiDvMPthym5qkKO+2A
	uDYovZQkG7gxGSmfgtnxEpg7bT3o2Vp+QbddQ8rseSOIhRbCuuyrG0lmkELY7R8nLY+koLf9kxF
	DHx0tEhpHiENpq7gpxhGsuc//A3WMcBOUhld14KMKHeXsoy9zU+BcBuPbGPm9SA==
X-Received: by 2002:a5d:59aa:0:b0:367:a49e:746d with SMTP id ffacd0b85a97d-36b5d08f6aemr7903470f8f.39.1722350804148;
        Tue, 30 Jul 2024 07:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SPI5zsjxorLVsr/CkA3sQCWgYktzA4uJcyZ5TlKQS7ItawnJwBcjYn8M51gSBWlR72fkBA==
X-Received: by 2002:a5d:59aa:0:b0:367:a49e:746d with SMTP id ffacd0b85a97d-36b5d08f6aemr7903444f8f.39.1722350803623;
        Tue, 30 Jul 2024 07:46:43 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a02:b125:8013:d373:a79:ad9d:7a67:3bd9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d95c7sm14776744f8f.37.2024.07.30.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:46:43 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:46:37 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [PATCH v11 0/7] Preparatory changes for Proxy Execution v11
Message-ID: <Zqj8zRdEIt4D_fOK@jlelli-thinkpadt14gen4.remote.csb>
References: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>

Hi John,

On 09/07/24 13:31, John Stultz wrote:
> Hey All,
> 
> I wanted to send out v11 of the preparatory patches for Proxy
> Execution - an approach for a generalized form of priority
> inheritance. Here again, I’m only submitting the early /
> preparatory changes for review, in the hope that we can move
> these more straightforward patches along and then iteratively
> move through the more interesting patches in the Proxy Execution
> series. That said, I’ve not gotten a ton of feedback with this
> approach, so I’m open to other suggestions.

I'd actually have some additional thoughts on what we discussed at
OSPM24. Hope it's OK if I use this cover letter as a starting point to
possibly discuss that further. Please don't hesitate to tell if you
would rather prefer we have that discussion separately after we agreed
on this first split of the series (I don't think - or I just hope -
whatever we decide about the migration logic will need changes in this
set).

...

> Issues still to address with the full series:

...

> * The chain migration functionality needs further iterations and
>   better validation to ensure it truly maintains the RT/DL load
>   balancing invariants (despite this being broken in vanilla
>   upstream with RT_PUSH_IPI currently)
> * At OSPM, Juri Lelli and the (very very sadly) late Daniel
>   Bristot de Oliveira raised the point that Proxy Exec may not
>   actually be generalizable for SCHED_DEADLINE tasks, as one
>   cannot always correctly donate the resources of the waiter to
>   an owner on a different cpu. If one was to reverse the
>   proxy-migration direction, migrating the owner to the waiter
>   cpu, this would preserve the SCHED_DEADLINE bandwidth
>   calculations, but would break down if the owner's cpu affinity
>   disallowed it. To my understanding this constraint seems to
>   make most forms of priority inheritance infeasible with
>   SCHED_DEADLINE, but I’ll have to leave that to the
>   folks/academics who know it well. After talking with Juri, my
>   current plan is just to special case find_proxy_task() to not
>   proxy with SCHED_DEADLINE (falling back to the current behavior
>   where we deactivate the waiting task). But SCHED_NORMAL waiter
>   tasks would still be able to benefit from Proxy Exec.

So, I've been discussing this a bit with Luca (now cc-ed), Tommaso and
Enrico (which I think you met at OSPM24 and/or at some previous
editions). Please consider that I am essentially thinking out loud, so
I'm pretty sure I'm missing details and possibly be just wrong, but
tl;dr it looks like we could somewhat reconcile the current
implementation (i.e. donors move to owners CPU) to what SCHED_DEADLINE
proxy execution theory (M-BWI [1]) wants if we maybe try to only migrate
the top-waiter (donor, one task) to the owner's CPU, possibly swapping
that with the next highest priority task enqueued on the owner's CPU so
that global invariants are respected. In this case we would leave other
potential donors on their CPUs and either ignore them when picking tasks
for execution or do slightly more fancy things for DEADLINE (can do that
at a later stage, but we would need to consume runtime of DEADLINE
entities even if the owner is running some place else, let's try to
ignore this detail for now I suggest).

Not sure if it makes any sense at all to you/others, but here it is. :)
Hope we can consider the alternative and discuss about it. I actually
wonder if it wouldn't also simplify blocking chains management a bit (no
need to migrate chains around anymore), but I'd guess it might
complicate local scheduling "a bit".

Please let me know what you think and/or if you would like to leave this
for a later stage.

Best,
Juri

1 - https://retis.santannapisa.it/~tommaso/publications/ECRTS-2010.pdf



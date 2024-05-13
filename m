Return-Path: <linux-kernel+bounces-177759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CB8C4449
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8531F2482D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423F156C49;
	Mon, 13 May 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJOVXwFX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CBF156861
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614323; cv=none; b=Fd526bhjh0cpKYPEu6Nl73WvTdzoGYitJFxBWrEZQDHmLFZBd9p5zdv00Tc2J7vkOpy120dOZ6JqJA8oCPfPZ4E2NPRW1ZkIxsBAGgmswbcCJgDMqHAaNcGmMt3yfTpnBvon+MkHY6kghiKjiIbyLp+8cEve6b2J+UFtYa49qHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614323; c=relaxed/simple;
	bh=9XgQabjgGAZzJXK2jlYawVYFy2EhNnFwkqg78gYlNhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G/FCjWJKPx/2wkJwlHKsh5YY/g6wPh+Qtt0fMxuUkV8EBNnzyYy7BllgaZLWW8pgxwVGCG0M05uc34uraYz7j6EUKMMGpHPoR6XsfVsgEHdxMWLC++PmgPOfJwx1sNew/NvccBvcYuSZiXskEvkwHL3hg30zozJlofUQ/ZdoR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJOVXwFX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de6054876efso8934330276.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715614320; x=1716219120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMgvtz2/Q+j3YoQLH1bJjltvWBvO9e9H4j6SuRwFAj8=;
        b=PJOVXwFXmFCkhzmsox0fcmiNV13775ihOSOjxf0CJ+/lFHYuVxvlv9d6gKuHdv7GyW
         nRHj4lg46W05wcyOaATBCnwQZYfgYZyLKsSdPd8wwjBITrqPXWMYWcoVsBoCgYVtmvJd
         hiOmXRzwOkLl+76Iqed7hkEWOaX6W2gZonvngTzB/iECgc/dbVruLGW2YDQZzjB3V18B
         njp6MKabddBmAlTjCw41O7y81LI3oEzhucC0oCko9dxDuIVPp5K9PHrIslTztwprJSUq
         ixBmGgts/jyZxqFBAhAYYlM1dtLgWbgveBNrunCex4clKG+3XN4clrMc2oXhyessWbfP
         AcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614320; x=1716219120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMgvtz2/Q+j3YoQLH1bJjltvWBvO9e9H4j6SuRwFAj8=;
        b=k5MQm5znQuWjV4atpbkWi3NmLlmH2R8PmD2dow5B2hbc4dgT4EEwrlA6XaAGMlGX3r
         sq7MKPcgMnWAJx1jl1qRZ5KqETC6q+E+Gc0fm2gBlR1MDd7fbFYIaF4dx0JArfic+LeV
         kKSa/psrsSv0Ku7GM8QirtVtiQVW2kJ0axHAk4YhtYRp3rKoyj/dTrIE4hlCjaImutPH
         rwxbXDoJkEqbZ/H0s6pL9AofYT9goP030OyLkNhLvzTRLkP60Ap3HYApUb9iEvjNyQ61
         EnnekyN2swJqJIWMHtJNhtdvgUKcgXvAMkPuoxPIdxLF7t4vrhGw5/oKn+Jx/1ixCV14
         cLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr7rlBc9Bfk9FkgWptx0HzCnUzn+l49PQogXg114Q/DywNcc/zoQIj0DUEiY+XCGbQfjjMGuUr6LOjZylTsq6w8KrJtMEtTbKjRbmf
X-Gm-Message-State: AOJu0Yxl0TmdaAoBc4uE2vUrdwELb2ku5Es/7LW+4+qdMVDiO+4wTDYC
	alc+HrHDP4Y6ueNkJ+9jQvaiggPJwOyU3ZdNSv9uPiIZ9KGsB5Y8LoREv/jqsf/6xCuG+eabzKi
	6qQ==
X-Google-Smtp-Source: AGHT+IHZWBYz9+tTVBadLe59oEaPPBnRDd/Y1wOg2pWyejXNtUymRegfzCexCxQG+dYrcCBcHmTremWD7KA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:102d:b0:dee:6802:dc49 with SMTP id
 3f1490d57ef6-dee6802f337mr1771991276.1.1715614320675; Mon, 13 May 2024
 08:32:00 -0700 (PDT)
Date: Mon, 13 May 2024 08:31:59 -0700
In-Reply-To: <22def35f-5b8d-4424-a03b-c90e9174a14d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110214723.695930-1-seanjc@google.com> <22def35f-5b8d-4424-a03b-c90e9174a14d@redhat.com>
Message-ID: <ZkIyXCBCLeOaAzN4@google.com>
Subject: Re: [PATCH] sched/core: Drop spinlocks on contention iff kernel is preemptible
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-kernel@vger.kernel.org, Valentin Schneider <valentin.schneider@arm.com>, 
	Marco Elver <elver@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 13, 2024, Paolo Bonzini wrote:
> On 1/10/24 22:47, Sean Christopherson wrote:
> > Use preempt_model_preemptible() to detect a preemptible kernel when
> > deciding whether or not to reschedule in order to drop a contended
> > spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
> > built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
> > preemption model is "none" or "voluntary".  In short, make kernels with
> > dynamically selected models behave the same as kernels with statically
> > selected models.
> 
> Peter, looks like this patch fell through the cracks.  Could this be applied
> for 6.10?
> 
> There is a slightly confusing line in the commit message below, so that it
> reads more like an RFC; but the patch fixes a CONFIG_PREEMPT_DYNAMIC
> regression wrt static preemption models and has no functional change for
> !CONFIG_PREEMPT_DYNAMIC.
> 
> > Somewhat counter-intuitively, NOT yielding a lock can provide better
> > latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
> > rwlock, is often contended between an invalidation event (takes mmu_lock
> > for write) and a vCPU servicing a guest page fault (takes mmu_lock for
> > read).  For _some_ setups, letting the invalidation task complete even
> > if there is mmu_lock contention provides lower latency for *all* tasks,
> > i.e. the invalidation completes sooner *and* the vCPU services the guest
> > page fault sooner.
> > 
> > But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
> > can vary depending on the host VMM, the guest workload, the number of
> > vCPUs, the number of pCPUs in the host, why there is lock contention, etc.
> > 
> > In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This should be "deleting the preempt_model_preemptible() guard" given that
> the patch does delete CONFIG_PREEMPTION, and only leaves
> preempt_model_preemptible() in place.

Note, this version won't apply cleanly, v2[*] handles the code movement and still
applies on Linus' tree.

[*] https://lore.kernel.org/all/20240312193911.1796717-1-seanjc@google.com


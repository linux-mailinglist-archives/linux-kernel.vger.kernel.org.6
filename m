Return-Path: <linux-kernel+bounces-566187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1120A67476
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4714219A0310
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF37720A5F2;
	Tue, 18 Mar 2025 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtvT6zqQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F92744E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302990; cv=none; b=Xe2Ksj7xCg6DisVRgapag8pmAsVmnJuKnL6kFzv51J3ecHiwZyLuGRSpU0CPAmHB3AL5VN73sG/Fk0eR0b/zL2TCgNCdRehhht1btVfHEKDqPN022z37m/yg7BueQXs+ubkEEZwN7kaCU2OhbwcAHUPQv3t+REXcnM28qqPO0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302990; c=relaxed/simple;
	bh=83mJiQFk6O/J0Ri3zfmNXBdEj1xk+7UQUDMa6zXq1R8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fp6qH44uOZMrIorAb92AByJnXbXoIhutQdbgY4gTQPwbg9F7GL1ssfCdcBiPOquEcDoujUDGg+u9QWNvbUE3d3Jst0Ypodo3twBO/ebbqOTYmRPPHRjz85tG2ek6BQAVTL8UKNrDVIuNLeI2/OfOl4j5lOQp9EYMfTE9pS7T0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtvT6zqQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so17634985e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742302987; x=1742907787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=whP3Ztar/RkUapRVfDAPzBt4fOO+FCwNAyDQSaMiseQ=;
        b=VtvT6zqQw6EU5I54wA5+NaCLIK0h2XZ2nshxAX9YRw5Cv2S/c05r22QS2TA8MQ1S6E
         qA5M18k2G1JzVTxYMHerRNSfQ1jLY+60lhEzgdblg8GlZPfqlPbqgXMV9aiOaodO6Ukt
         1XBIZ0HcOyAQpGYJZ3eT1O7rV4wfPItoFzdS/H+vOdexS63nK9bmkEFNGjClWdQu9EYH
         l/FnJk07sYCcPGBV3BqcHyPa8I+w9ICFwIFekrdTiIm6vEAWwPQN6S7t/QysmJhcsUeM
         qIDMEebkyhQmWrxWhUDcYymMmsaqAoBO1s2ZvQ1xPZNqpwWDab/Ge30hBZEZxRhBNTqN
         /03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302987; x=1742907787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whP3Ztar/RkUapRVfDAPzBt4fOO+FCwNAyDQSaMiseQ=;
        b=L9gW6uMRU0ARHPuExv83ARiiWRq8yBrmVAb7vQIGYRwZMbL7zb1CLpo9gSJcgPmucV
         QwPXnP59vC5DGJxTu3veS7lru/ELsal7luXxCfUp3xz8LCGgKGpg92vcAoGm9ODQNiLM
         FL9uYPdj+WA0RwqrObH7N8J5TCCd57SfNkpDzcKQyVMOWkY/8VrrQuU5K48XlBDd2mV8
         a9xkpUVqB5eAq/77lomYYHNhv1QAwNUQlQ02DY7R+3nI64b7xEbNREKaYpWmH4b89fqG
         du6OIemk3vFKALK4xcN3XyylRo3Un28XlRjaV59Xtc2QsnvLtFv5h0Oo/DeX5V4Alvxp
         HdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSCxavjqhX0kFSICsHpdl0E1jCxzAiYLGW9r/Orj/tr1ia1tB2HDbTmVc9McCqdOlgJWrL0VNXrSHA1s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXeDOfSUXW78uDZXRf1CqGGmMEFfeEh6psW4bj3bDAFqYOm3W
	8YaNTibG2dWeiUKxDF07iqZPj9NF5+CLuliB/KZYaAnVs9zBqHi6VbUtmdvaxnlvmD7vw8bXEWm
	GVj7MDOSA1g==
X-Google-Smtp-Source: AGHT+IEo/v26Aru3DgRKudIcvvi5iVXlISbjRtcfMMClu/BOmgGyumhv1wki9aUCVQEAJDbjuPXzjomGr/lwuQ==
X-Received: from wmbes18.prod.google.com ([2002:a05:600c:8112:b0:43b:c7e5:66e0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1da4:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-43d3b950035mr23761825e9.5.1742302986910;
 Tue, 18 Mar 2025 06:03:06 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:03:05 +0000
In-Reply-To: <4ce0b11c-d2fd-4dff-b9db-30e50500ee83@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227120607.GPZ8BVL2762we1j3uE@fat_crate.local>
 <20250228084355.2061899-1-jackmanb@google.com> <20250314131419.GJZ9Qrq8scAtDyBUcg@fat_crate.local>
 <5aa114f7-3efb-4dab-8579-cb9af4abd3c0@google.com> <20250315123621.GCZ9V0RWGFapbQNL1w@fat_crate.local>
 <Z9gKLdNm9p6qGACS@google.com> <4ce0b11c-d2fd-4dff-b9db-30e50500ee83@google.com>
X-Mailer: aerc 0.18.2
Message-ID: <D8JEV1QJHY6E.10X36UUX60ECW@google.com>
Subject: Re: [PATCH RFC v2 03/29] mm: asi: Introduce ASI core API
From: Brendan Jackman <jackmanb@google.com>
To: Junaid Shahid <junaids@google.com>, Borislav Petkov <bp@alien8.de>
Cc: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>, 
	<yosryahmed@google.com>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <peterz@infradead.org>, 
	<seanjc@google.com>, <tglx@linutronix.de>, <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue Mar 18, 2025 at 12:50 AM UTC, Junaid Shahid wrote:
> On 3/17/25 4:40 AM, Brendan Jackman wrote:
> > 
> > I don't understand having both asi_[un]lock() _and_
> > asi_{start,enter}_critical_region(). The only reason we need the
> > critical section concept is for the purposes of the NMI glue code you
> > mentioned in part 1, and that setup must happen before the switch into
> > the restricted address space.
> > 
> > Also, I don't think we want part 5 inside the asi_lock()->asi_unlock()
> > region. That seems like the region betwen part 5 and 6, we are in the
> > unrestricted address space, but the NMI entry code is still set up to
> > return to the restricted address space on exception return. I think
> > that would actually be harmless, but it doesn't achieve anything.
> > 
> > The more I talk about it, the more convinced I am that the proper API
> > should only have two elements, one that says "I'm about to run
> > untrusted code" and one that says "I've finished running untrusted
> > code". But...
> > 
> >> 1. you can do empty calls to keep the interface balanced and easy to use
> >>
> >> 2. once you can remove asi_exit(), you should be able to replace all in-tree
> >>     users in one atomic change so that they're all switched to the new,
> >>     simplified interface
> > 
> > Then what about if we did this:
> > 
> > /*
> >   * Begin a region where ASI restricted address spaces _may_ be used.
> >   *
> >   * Preemption must be off throughout this region.
> >   */
> > static inline void asi_start(void)
> > {
> > 	/*
> > 	 * Cannot currently context switch in the restricted adddress
> > 	 * space.
> > 	 */
> > 	lockdep_assert_preemption_disabled();
>
> I assume that this limitation is just for the initial version in this RFC, 
> right? 

Well I think we also wanna get ASI in-tree with this limitation,
otherwise the initial series will be too big and complex. But yea,
it's a temporary thing for sure. Maybe resolving that would be the
highest-priority issue once ASI is merged.

> But even in that case, I think this should be in asi_start_critical() 
> below, not asi_start(), since IIRC the KVM run loop does contain preemptible 
> code as well. And we would need an explicit asi_exit() in the context switch 
> code like we had in an earlier RFC.

Oh. Yeah. In my proposal below I had totally forgotten we had
asi_exit() in the context_switch() path (it is there in this patch).

So we only need the asi_exit() in the KVM code in order to avoid
actually hitting e.g. exit_to_user_mode() in the restricted address
space.

But... we can just put an asi_exit() there explicitly instead of
dumping all this weirdness into the "core API" and the KVM codebase.

So... I think all we really need is asi_start_critical() and
asi_end_critical()? And make everything else happen as part of the
normal functioning of the entry and context-switching logic. Am I
forgetting something else?


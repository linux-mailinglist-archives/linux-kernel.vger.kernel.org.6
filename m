Return-Path: <linux-kernel+bounces-198396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509E8D77A0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965DB1F21269
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4C6F301;
	Sun,  2 Jun 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maK5otCa"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36210795
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717357713; cv=none; b=M0rQq13IzA0bgKq7OZOGXGHog0Lu54Uq8iLP/j0uAi8XgFh+P29QMATzPErJIuOoSz82FvzjxulwopfTDgEy9LV6MH4nTX4215I8s+7QesibYvqix7zqhrcfYZS+m1M4foBP21bYxx5YCqduBdJ/1hI4KjA4XZ3TfmF8ox7+cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717357713; c=relaxed/simple;
	bh=/CAFDMa+pw6FVmmTgabOwR/m6twBQ42kEkoz3ywnXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgKlOXn9xzigfTGuKuRtK9TO7jw4KLxAVId+5V05gclBjrb9tORV/k3lMCKVC+JmaGoef7maEu1FzUqrMNYTqidhMrMKSOEzCKL+f3gTH+w2spogOiy7q60e1u4GoBVJTGLTcjZGDqUqk2BmhDA9ebjgI4VezVCyhAsscv888wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maK5otCa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so48924131fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717357709; x=1717962509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQSzPio2R/73jHcq/X/sBS4Rsq01ybZmkuK5Z9CsC28=;
        b=maK5otCabOTuIbGtNYHNlSK7pJyIXn8H97S/c5rxCOrwjlaiW7bFQD/4Ywn8ATDt91
         aaMNxw334tz4NGcTUO+tJOzgR2eircNL13tQPjtw2FI/lA5lupi7pzII3BDUMxOxj1dU
         Xq8MTdjNpEwzSs4cvkd+YkPyidL7r84mwdm+kvZUIDk6Lxx3KpKVG/OfmyGXm7zJsZUo
         TIR4FZSjfNcWnukXy+ND3PowZ0xpe409YcrNtpC0Yplc+GYI6DW5Ul+EgZzSKSfNBrPR
         F8pB1+gMjRyT9xvJ5/Mu3I6OfDB1gzWqgF70K5mU9jyDLdKzhnQAPnJMOutzsaKV+BCe
         Ro6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717357709; x=1717962509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQSzPio2R/73jHcq/X/sBS4Rsq01ybZmkuK5Z9CsC28=;
        b=sRDJl48h05bDgBV3sbLAshyrihCLe73ngymX6OJHwbXuZy8+JuJyPEMo2m4GNMoiFX
         Rn2Nem2XPTw4Td/EfB4RrIvFrBgc9ily3DBbGwFv8mePMzfURm1HnZO70PN8Y4f4hqHb
         PM4nvOJm5AqIo/DURjo9ddKXB7cueK5bE3BGpWjzMkyf/YyDgO+AAYxypfueMnXF/+el
         DawWqeD/zR9TYYsofn8RfuNXEkS1Wd0bSyI9LIJ3WBoPdkeldK02FDJL8vrsdXwGP45M
         a9Q8YapqJEyQBb0pA0xC0KtHO2Tm2Efek3HWSV/52vK+F4Vg4uZ+pYu9iXDJdz9eO7AL
         ENlA==
X-Forwarded-Encrypted: i=1; AJvYcCXG6jN8Rdy+YfbMR+alDb0v+qh1XYDdmjTUQckJrF6iscNlWA2ifWGTCup73T6Mht/Zj3GxC9KeWnWC/q3sFXYnjqClEDbjT31Clz24
X-Gm-Message-State: AOJu0Yx+UGGtEvybAxhTN0zfHdi43bMlI8jCmPYFlUj8r1d1mljLLVSH
	w9U7ob+gUFqbf+2se2eRcUmNlmaq7aC+HjvHVI+doWPWFTqu2lRC
X-Google-Smtp-Source: AGHT+IGn9CG22o94zA0w4wlgAaXoMTZqKB453JEhmX2ql7S/CETojc+nreFBfGdxNBMasOPV4s/J5g==
X-Received: by 2002:a2e:988f:0:b0:2e9:87b4:f483 with SMTP id 38308e7fff4ca-2ea9510814dmr50174431fa.4.1717357708992;
        Sun, 02 Jun 2024 12:48:28 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc7e19sm9677401fa.85.2024.06.02.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:48:28 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yorha.op@gmail.com
Subject: Re: [PATCH v2 2/2] mm/damon/core: implement multi-context support
Date: Sun,  2 Jun 2024 22:48:14 +0300
Message-ID: <20240602194814.929457-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240602154848.91322-1-sj@kernel.org>
References: <20240602154848.91322-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

[...]

> > 
> > > 
> > > >  
> > > >  /* private: */
> > > >  	/* for waiting until the execution of the kdamond_fn is started */
> > > > @@ -634,7 +632,10 @@ struct damon_ctx {
> > > >  	 * update
> > > >  	 */
> > > >  	unsigned long next_ops_update_sis;
> > > > +	/* upper limit for each monitoring region */
> > > >  	unsigned long sz_limit;
> > > > +	/* marker to check if context is valid */
> > > > +	bool valid;
> > > 
> > > What is the validity?
> > 
> > This is a "flag" which indicates that the context is "valid" for kdamond
> > to be able to call ->check_accesses() on it. Because we have many contexts
> > we need a way to identify which context is valid while iterating over
> > all of them (please, see kdamond_prepare_access_checks_ctx() function).
> 
> It's still not very clear to me.  When it is "valid" or not for kdamond to be
> able to call ->check_accesses()?  I assume you mean it is valid if the
> monitoring operations set's ->target_valid() returns zero?
> 
> The callback is not for preventing unnecessary ->check_accesses(), but for
> knowing if continuing the monitoring makes sense or not.  For example, the
> callback of 'vaddr' operation set checks if the virtual address space still
> exists (whether the target process is still running)  Calling
> ->check_accesses() for ->target_valid() returned non-zero target is totally ok,
> though it is meaningless.  And therefore kdamond stops if it returns non-zero.
> 
> > 
> > Maybe name should be changed,
> 
> At least some more detailed comment would be appreciated, imo.
> 
> > but now I don't see a way how we could merge
> > this into kdamond_valid_ctx() or so, because the main cause of this "valid"
> > bit is that there's no more "valid" targets for this context, but also we could
> > have ->after_sampling() returned something bad.
> 
> As mentioned above, calling ->check_accesses() or others towards invalidated
> targets (e.g., terminated processes's virtual address spaces) should be ok, if
> any of the targets are still valid.  So I don't show special technical
> difficulties here.  Please let me know if I'm missing something.

This is true in case of only 1 context. kdamond can be stopped if there's
no valid targets for this context (e.g. no address space exists anymore),
but when there are many contexts we need to check if any of contexts has
valid target(s). For example, we have 3 contexts per kdamond, at some
point of time we have 1st context having no valid targets (process has been
finished), but other 2 contexts do have valid targets, so we don't need
to call ->prepare_access_checks() and ->check_accesses() as well for 1st
context, but we do need to call them for other contexts.

We can call ->kdamond_valid_ctx() before calling ->check_accesses(),
but then we also need to check if nothing bad has been returned from
->after_sampling() call, so that we're allowed to further call
->check_accesses().

I decided to use a "valid" flag inside damon_ctx structure, so
that if this context isn't valid, we will just skip it while
iterating over all contexts. In case of just 1 context
kdamond_prepare_access_checks() will return false, so that
nr_valid_ctxs will remain zero, so we will break "while"
loop, otherwise we'll see that there's at least one valid
context to call ->check_accesses() for.

The last point is that we need to understand for which
context we can call ->check_accesses(), this is done
by checking ctx->valid bit, if it is "false" (we already called
kdamond_valid_ctx() and ->after_sampling(), and one of this calls
failed) we just skip this context by doing "goto next_ctx;"
in main kdamond loop.

> 
> > 
> > > 
> > > >  
> > > >  /* public: */
> > > >  	struct kdamond *kdamond;
> > > > @@ -682,6 +683,12 @@ static inline struct damon_ctx *damon_first_ctx(struct kdamond *kdamond)
> > > >  	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
> > > >  }
> > > >  
> > > > +static inline bool damon_is_last_ctx(struct damon_ctx *ctx,
> > > > +				     struct kdamond *kdamond)
> > > > +{
> > > > +	return list_is_last(&ctx->list, &kdamond->contexts);
> > > > +}
> > > > +
> > > >  #define damon_for_each_region(r, t) \
> > > >  	list_for_each_entry(r, &t->regions_list, list)
> > > >  
> > > > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> > > > index 23200aabc..d5287566c 100644
> > > > --- a/include/trace/events/damon.h
> > > > +++ b/include/trace/events/damon.h
> > > 
> > > Let's separate this change to another patch.
> > 
> > Separating patches we hardly be able to reach at least build
> > consistency between patches. Moreover DAMON won't be able
> > to function corretly in between.
> 
> I agree that it's not very easy, indeed.  But let's try.  In terms of
> functionality, we need to keep the old behavior that visible to users.  For
> example, this change tries to make the traceevent changed for the multi
> contexts support.  It is for making the behavior _better_, not for keeping old
> behavior.  Rather than that, this is introducing a new change to the tracepoint
> output.  Just make no change here.  Users may get confused when they use
> multiple contexts, but what they see is not changed.
> 
> Further, you can delay letting users (user-space) using the multiple contexts
> (allowing >1 input to nr_contexts of DAMON sysfs interface) after making this
> change in a separate patch.
> 
> > 
> > > 

[...]

> > > >  
> > > > -static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> > > > -		struct damon_region *r, struct damos *s)
> > > > +static void damos_apply_scheme(unsigned int cidx, struct damon_ctx *c,
> > > > +			       struct damon_target *t, struct damon_region *r,
> > > > +			       struct damos *s)
> > > 
> > > Unnecesary change.
> > 
> > What do you mean? Why is this unnecessary? Now DAMON iterates over
> > contexts and calls kdamond_apply_schemes(ctx), so how can we know
> > which context we print trace for? Sorry, maybe I misunderstood
> > how DAMON does it, but I'm a bit confused.
> 
> I believe the above comment to tracevent change explains this.

Just to make it clear, you mean separating this change into different
smaller patch?

[...]

BR,
Alex


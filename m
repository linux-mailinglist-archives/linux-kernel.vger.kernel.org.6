Return-Path: <linux-kernel+bounces-198309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7EC8D7682
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBF1C20BEC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3F42ABE;
	Sun,  2 Jun 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0+YdrBX"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E73EA7B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717340923; cv=none; b=jZo4GPnjvVPW8UTpjg8EeTnQClzpZHe0Vybqq6z+OA2Mx2bdfYkn02J+nYXH8Tkqn7eLkxdwnh8TZZ/mZdNnTfA4un46OIAscccS/yKvG/4MzcmuMOzO84z5RiyjDTEWSbPeI7MzDxFEnTlWDJCIOXPpiHrhtPdhj24hf3ivDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717340923; c=relaxed/simple;
	bh=h2rpPmJ96/Kq5oqhQ9Mqlv0oQ+yGHQ757GDCJa7Tj3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYbdmlCs3z7BXshkw9jD1YzrCZTkSUT4pUYGTa5oynnczdPyL+Lov/XsK2R9sgkTZKrC48Q/qxW8ByzdTNOVAG7n2EMDhN17hkGlSYtSgicQrnd6k/CIMhCBm2IXx5jHMGfPMba1lPpObWw89qUnph8uwmaiQn/BJ7X8aExF/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0+YdrBX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaac465915so3077251fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717340916; x=1717945716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BpkQqyg+kXHUrSPNq0rPD/3G3JgBIdjTPY6bEzMwBg=;
        b=P0+YdrBXc79HgzcPnQKlR1e3eBCTt+AxkzT4d7ttm00D0K81ilvyTZzprN3huIDEzw
         wFvbpKbtWNuKqmTgysdClXVvuzvh1c+6UZlTPcaPw3ohrwZf40FUYnewN4pKWyfSuC7R
         AorQgSVnqP7IhpgPyEtbM7IH8clVK92PgFkCwGL/y2WtTVLFrfmfjhCCGHyNASjso4q6
         TJo2RzcKumNUCWlD95yW2DR/yGEKqGVrNxjJvDItTp/uBXk1wVofUw5ew3f5TAkJ/70t
         1A9DiItmhSCkkvZ6NcyuEaMNjaP3ujycz80dc5g+iS9kKHgiE2wTdJkLZvU7EpT1Imte
         JJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717340916; x=1717945716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BpkQqyg+kXHUrSPNq0rPD/3G3JgBIdjTPY6bEzMwBg=;
        b=Ga39OYrU9PNztW4+yZc/A90idaGSsS8HyHgcgl7aWojnSDsIy953Uv+NEu+N6K5Vsy
         seWKcHiIHJHbcnW/sliTLNadTa8kVBzVu6NGnz+r0mIo35CElPCfixNy5rpqd7waFVVU
         b44YpukEQM7a4Df+cVAbngcrzBdEPovw1qa8C3QFs60ggrlRSl6ewDeGTjroY6bQ8e3L
         e/4VqWH87fZYUKq6AVoTifOKrB7wRDKOToJ1plFnTrirxxBM1lPSrABkXsisVOnMIh/4
         Ym9PhEsQMnwC+3MOR+VzPK4XtizAox7paIcSJwx54ZheOOvFKnTDZs3oZWrWJKzPIKzS
         j0mw==
X-Forwarded-Encrypted: i=1; AJvYcCVhg1VBg29OhlIrLyIwjTBn8lmA0pipK5cn1XlpBu02fVhnabyEhzOnrYLZw6IWCwUgP0kR5eGvNXvev5DRSQjUdjjzbFwbiBfYUBuy
X-Gm-Message-State: AOJu0YxPMfQInHbUQYsUyqznjpX2SV2NMmnGC9IiV/JZ8mcGnNFqXmke
	Y8IMyTktyf+WdZyUjbJcwnSG09RYcq6InGl+I1qRsdLwaGgK8VD0
X-Google-Smtp-Source: AGHT+IHl5e+Uzs/MW1GAJnxmNOUn0sbPQDx3RQLlWpJSrU/pFOuiGtcwhC68SIo7FG2SiK5R1fUIGQ==
X-Received: by 2002:a2e:9290:0:b0:2e9:d4fa:1cc with SMTP id 38308e7fff4ca-2ea951e1b97mr49703301fa.39.1717340914792;
        Sun, 02 Jun 2024 08:08:34 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb4c56sm9150291fa.30.2024.06.02.08.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 08:08:34 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yorha.op@gmail.com
Subject: Re: [PATCH v2 2/2] mm/damon/core: implement multi-context support
Date: Sun,  2 Jun 2024 18:08:16 +0300
Message-ID: <20240602150816.926407-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240531193838.71538-1-sj@kernel.org>
References: <20240531193838.71538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi SJ,

> Hi Alex,
> 
> On Fri, 31 May 2024 15:23:20 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> 
> > This patch actually implements support for
> > multi-context design for kdamond daemon.
> > 
> > In pseudo code previous versions worked like
> > the following:
> > 
> >     while (!kdamond_should_stop()) {
> > 
> > 	/* prepare accesses for only 1 context */
> > 	prepare_accesses(damon_context);
> > 
> > 	sleep(sample_interval);
> > 
> > 	/* check accesses for only 1 context */
> > 	check_accesses(damon_context);
> > 
> > 	...
> >     }
> > 
> > With this patch kdamond workflow will look
> > like the following:
> > 
> >     while (!kdamond_shoule_stop()) {
> > 
> > 	/* prepare accesses for all contexts in kdamond */
> > 	damon_for_each_context(ctx, kdamond)
> > 	    prepare_accesses(ctx);
> > 
> > 	sleep(sample_interval);
> > 
> > 	/* check_accesses for all contexts in kdamond */
> > 	damon_for_each_context(ctx, kdamond)
> > 	    check_accesses(ctx);
> > 
> > 	...
> >     }
> 
> This is not what you do now, but on previous patch, right?  Let's modify the
> mesage appropriately.

No, this is exactly what this patch is for, previous one only introduced
'struct kdamond' and made all interfaces (sysfs/dbgfs/core) to use it.
I mean previous patch doesn't include support for multiple contexts,
functionality was the same as before.

> 
> > 
> > Another point to note is watermarks. Previous versions
> > checked watermarks on each iteration for current context
> > and if matric's value wan't acceptable kdamond waited
> > for watermark's sleep interval.
> 
> Mention changes of versions on cover letter.
> 
> > 
> > Now there's no need to wait for each context, we can
> > just skip context if watermark's metric isn't ready,
> > but if there's no contexts that can run we
> > check for each context's watermark metric and
> > sleep for the lowest interval of all contexts.
> > 
> > Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
> > ---
> >  include/linux/damon.h        |  11 +-
> >  include/trace/events/damon.h |  14 +-
> >  mm/damon/core-test.h         |   2 +-
> >  mm/damon/core.c              | 286 +++++++++++++++++------------
> >  mm/damon/dbgfs-test.h        |   4 +-
> >  mm/damon/dbgfs.c             | 342 +++++++++++++++++++++--------------
> >  mm/damon/modules-common.c    |   1 -
> >  mm/damon/sysfs.c             |  47 +++--
> >  8 files changed, 431 insertions(+), 276 deletions(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 7cb9979a0..2facf3a5f 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -575,7 +575,6 @@ struct damon_attrs {
> >   * @lock:	Kdamond's global lock, serializes accesses to any field.
> >   * @self:	Kernel thread which is actually being executed.
> >   * @contexts:	Head of contexts (&damon_ctx) list.
> > - * @nr_ctxs:	Number of contexts being monitored.
> >   *
> >   * Each DAMON's background daemon has this structure. Once
> >   * configured, daemon can be started by calling damon_start().
> > @@ -589,7 +588,6 @@ struct kdamond {
> >  	struct mutex lock;
> >  	struct task_struct *self;
> >  	struct list_head contexts;
> > -	size_t nr_ctxs;
> 
> Why we add this on first patch, and then remove here?  Let's not make
> unnecessary temporal change.  It only increase review time.

This temporal change is needed only to not break DAMON functionality
once first patch is applied (i.e. only 1st patch is applied). I mean
to have constistancy between patches.

I think, if I change the patch-history (the one you suggested in another
reply) this could be avoided.

> 
> >  
> >  /* private: */
> >  	/* for waiting until the execution of the kdamond_fn is started */
> > @@ -634,7 +632,10 @@ struct damon_ctx {
> >  	 * update
> >  	 */
> >  	unsigned long next_ops_update_sis;
> > +	/* upper limit for each monitoring region */
> >  	unsigned long sz_limit;
> > +	/* marker to check if context is valid */
> > +	bool valid;
> 
> What is the validity?

This is a "flag" which indicates that the context is "valid" for kdamond
to be able to call ->check_accesses() on it. Because we have many contexts
we need a way to identify which context is valid while iterating over
all of them (please, see kdamond_prepare_access_checks_ctx() function).

Maybe name should be changed, but now I don't see a way how we could merge
this into kdamond_valid_ctx() or so, because the main cause of this "valid"
bit is that there's no more "valid" targets for this context, but also we could
have ->after_sampling() returned something bad.

> 
> >  
> >  /* public: */
> >  	struct kdamond *kdamond;
> > @@ -682,6 +683,12 @@ static inline struct damon_ctx *damon_first_ctx(struct kdamond *kdamond)
> >  	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
> >  }
> >  
> > +static inline bool damon_is_last_ctx(struct damon_ctx *ctx,
> > +				     struct kdamond *kdamond)
> > +{
> > +	return list_is_last(&ctx->list, &kdamond->contexts);
> > +}
> > +
> >  #define damon_for_each_region(r, t) \
> >  	list_for_each_entry(r, &t->regions_list, list)
> >  
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> > index 23200aabc..d5287566c 100644
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> 
> Let's separate this change to another patch.

Separating patches we hardly be able to reach at least build
consistency between patches. Moreover DAMON won't be able
to function corretly in between.

> 
> > @@ -50,12 +50,13 @@ TRACE_EVENT_CONDITION(damos_before_apply,
> >  
> >  TRACE_EVENT(damon_aggregated,
> >  
> > -	TP_PROTO(unsigned int target_id, struct damon_region *r,
> > -		unsigned int nr_regions),
> > +	TP_PROTO(unsigned int context_id, unsigned int target_id,
> > +		struct damon_region *r, unsigned int nr_regions),
> >  
> > -	TP_ARGS(target_id, r, nr_regions),
> > +	TP_ARGS(context_id, target_id, r, nr_regions),
> >  
> >  	TP_STRUCT__entry(
> > +		__field(unsigned long, context_id)
> >  		__field(unsigned long, target_id)
> >  		__field(unsigned int, nr_regions)
> >  		__field(unsigned long, start)
> > @@ -65,6 +66,7 @@ TRACE_EVENT(damon_aggregated,
> >  	),
> >  
> >  	TP_fast_assign(
> > +		__entry->context_id = context_id;
> >  		__entry->target_id = target_id;
> >  		__entry->nr_regions = nr_regions;
> >  		__entry->start = r->ar.start;
> > @@ -73,9 +75,9 @@ TRACE_EVENT(damon_aggregated,
> >  		__entry->age = r->age;
> >  	),
> >  
> > -	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
> > -			__entry->target_id, __entry->nr_regions,
> > -			__entry->start, __entry->end,
> > +	TP_printk("context_id=%lu target_id=%lu nr_regions=%u %lu-%lu: %u %u",
> > +			__entry->context_id, __entry->target_id,
> > +			__entry->nr_regions, __entry->start, __entry->end,
> >  			__entry->nr_accesses, __entry->age)
> >  );
> >  
> > diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> > index 0cee634f3..7962c9a0e 100644
> > --- a/mm/damon/core-test.h
> > +++ b/mm/damon/core-test.h
> > @@ -99,7 +99,7 @@ static void damon_test_aggregate(struct kunit *test)
> >  		}
> >  		it++;
> >  	}
> > -	kdamond_reset_aggregated(ctx);
> > +	kdamond_reset_aggregated(ctx, 0);
> >  	it = 0;
> >  	damon_for_each_target(t, ctx) {
> >  		ir = 0;
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index cfc9c803d..ad73752af 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -500,6 +500,8 @@ struct damon_ctx *damon_new_ctx(void)
> >  	ctx->attrs.min_nr_regions = 10;
> >  	ctx->attrs.max_nr_regions = 1000;
> >  
> > +	ctx->valid = true;
> > +
> >  	INIT_LIST_HEAD(&ctx->adaptive_targets);
> >  	INIT_LIST_HEAD(&ctx->schemes);
> >  	INIT_LIST_HEAD(&ctx->list);
> > @@ -513,7 +515,7 @@ struct damon_ctx *damon_new_ctx(void)
> >  void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx)
> >  {
> >  	list_add_tail(&ctx->list, &kdamond->contexts);
> > -	++kdamond->nr_ctxs;
> > +	ctx->kdamond = kdamond;
> >  }
> >  
> >  struct kdamond *damon_new_kdamond(void)
> > @@ -567,10 +569,8 @@ void damon_destroy_ctxs(struct kdamond *kdamond)
> >  {
> >  	struct damon_ctx *c, *next;
> >  
> > -	damon_for_each_context_safe(c, next, kdamond) {
> > +	damon_for_each_context_safe(c, next, kdamond)
> >  		damon_destroy_ctx(c);
> > -		--kdamond->nr_ctxs;
> > -	}
> >  }
> >  
> >  void damon_destroy_kdamond(struct kdamond *kdamond)
> > @@ -735,6 +735,20 @@ bool damon_kdamond_running(struct kdamond *kdamond)
> >  	return running;
> >  }
> >  
> > +/**
> > + * kdamond_nr_ctxs() - Return number of contexts for this kdamond.
> > + */
> > +static int kdamond_nr_ctxs(struct kdamond *kdamond)
> > +{
> > +	struct list_head *pos;
> > +	int nr_ctxs = 0;
> > +
> > +	list_for_each(pos, &kdamond->contexts)
> > +		++nr_ctxs;
> > +
> > +	return nr_ctxs;
> > +}
> > +
> >  /* Returns the size upper limit for each monitoring region */
> >  static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
> >  {
> > @@ -793,11 +807,11 @@ static int __damon_start(struct kdamond *kdamond)
> >   * @exclusive:	exclusiveness of this contexts group
> >   *
> >   * This function starts a group of monitoring threads for a group of monitoring
> > - * contexts.  One thread per each context is created and run in parallel.  The
> > - * caller should handle synchronization between the threads by itself.  If
> > - * @exclusive is true and a group of threads that created by other
> > + * contexts. If @exclusive is true and a group of contexts that created by other
> >   * 'damon_start()' call is currently running, this function does nothing but
> > - * returns -EBUSY.
> > + * returns -EBUSY, if @exclusive is true and a given kdamond wants to run
> > + * several contexts, then this function returns -EINVAL. kdamond can run
> > + * exclusively only one context.
> >   *
> >   * Return: 0 on success, negative error code otherwise.
> >   */
> > @@ -806,10 +820,6 @@ int damon_start(struct kdamond *kdamond, bool exclusive)
> >  	int err = 0;
> >  
> >  	BUG_ON(!kdamond);
> > -	BUG_ON(!kdamond->nr_ctxs);
> > -
> > -	if (kdamond->nr_ctxs != 1)
> > -		return -EINVAL;
> >  
> >  	mutex_lock(&damon_lock);
> >  	if ((exclusive && nr_running_kdamonds) ||
> > @@ -818,6 +828,11 @@ int damon_start(struct kdamond *kdamond, bool exclusive)
> >  		return -EBUSY;
> >  	}
> >  
> > +	if (exclusive && kdamond_nr_ctxs(kdamond) > 1) {
> > +		mutex_unlock(&damon_lock);
> > +		return -EINVAL;
> > +	}
> > +
> >  	err = __damon_start(kdamond);
> >  	if (err)
> >  		return err;
> > @@ -857,7 +872,7 @@ int damon_stop(struct kdamond *kdamond)
> >  /*
> >   * Reset the aggregated monitoring results ('nr_accesses' of each region).
> >   */
> > -static void kdamond_reset_aggregated(struct damon_ctx *c)
> > +static void kdamond_reset_aggregated(struct damon_ctx *c, unsigned int ci)
> >  {
> >  	struct damon_target *t;
> >  	unsigned int ti = 0;	/* target's index */
> > @@ -866,7 +881,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
> >  		struct damon_region *r;
> >  
> >  		damon_for_each_region(r, t) {
> > -			trace_damon_aggregated(ti, r, damon_nr_regions(t));
> > +			trace_damon_aggregated(ci, ti, r, damon_nr_regions(t));
> 
> Separate traceevent change into another patch.
> 
> >  			r->last_nr_accesses = r->nr_accesses;
> >  			r->nr_accesses = 0;
> >  		}
> > @@ -1033,21 +1048,15 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
> >  	return false;
> >  }
> >  
> > -static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> > -		struct damon_region *r, struct damos *s)
> > +static void damos_apply_scheme(unsigned int cidx, struct damon_ctx *c,
> > +			       struct damon_target *t, struct damon_region *r,
> > +			       struct damos *s)
> 
> Unnecesary change.

What do you mean? Why is this unnecessary? Now DAMON iterates over
contexts and calls kdamond_apply_schemes(ctx), so how can we know
which context we print trace for? Sorry, maybe I misunderstood
how DAMON does it, but I'm a bit confused.

Or maybe you mean indentation? The actual change is adding "cidx":

	-static void damos_apply_scheme(struct damon_ctx *c, ...
	+static void damos_apply_scheme(unsigned int cidx, struct damon_ctx *c,

> 
> As also mentioned on the reply to the first patch, I think this patch can
> significantly changed if you agree to my opinion about the flow of patches that
> I mentioned on the reply to the cover letter.  Hence, stopping review from here
> for now.  Please let me know if you have a different opinion.

I see. Anyway, thank you for your comments, I'll try my best to improve the patch.

> 
> 
> Thanks,
> SJ
> 
> [...]

BR,
Alex


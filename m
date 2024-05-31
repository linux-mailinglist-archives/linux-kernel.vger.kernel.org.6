Return-Path: <linux-kernel+bounces-197373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780B8D69D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED7A2853FE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E91157A74;
	Fri, 31 May 2024 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6URObSu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8B1C6BD;
	Fri, 31 May 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184173; cv=none; b=X3vHa7TCP5+K/qUYn3V58q7iQkagSifczB92yqLKQCGN0S2tKtOuKX5cX75gp1F2DJvNDqaZvCluPuU/quMLkqJBPad2iV7xjVFlyjAJANZnxuws1TfgYiNyUROlpV7dtUDl8aJpkq1mESnbGbIDfsXUiRhPcUUsjkw6j+zx7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184173; c=relaxed/simple;
	bh=2xgTRqn/dm9Xd5J+mGio8zCANELXDyWQZzaILOKMCyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0aIEV9jP4CxDyoBdm8vBPjGdQUUHG7OGjHJKSFltB1EfblgtMMkGfFZLXP/cvc+emNERsXgL0/w5QEFmA0oOKCWh/kPr6tXvLf8Ofwc2s7X516030nuCfT83baZJsIU1iV1orI1GRFRqhqEXCHQyUTLoiP5r/2kpS7IVAoc3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6URObSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77557C116B1;
	Fri, 31 May 2024 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184173;
	bh=2xgTRqn/dm9Xd5J+mGio8zCANELXDyWQZzaILOKMCyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6URObSu4yI0UwSNPChDI23Njp8vOLycD+xVySVwtFtbEeJatJthBUA9Xm5Xs85IQ
	 uY4JCVqZT9vgg4IA9SoARA39UP7yOOTTOhsjGyd3u+P/rlJjlb6bygUpcPPpmUcaQ3
	 yeuq82KjvpHnJ26VH9uas4fpQAGAhML4SveYbDDmzm5JBC6gMuZ/spRWxVBZyfpaDl
	 27ubvttNGLGTK7/zom/wS49avQkwHy4kuMMn75rQvD8e8CFZM/YwiCoJB7mFiHAVGZ
	 CsVKR6ESLPDB8cNzsc6EoAQHZ2wJms+LUdWSXymFuq3/elkSdl+l4Md6UIIal9P3rw
	 5okUYNUpxz65w==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: add 'struct kdamond' abstraction layer
Date: Fri, 31 May 2024 12:36:09 -0700
Message-Id: <20240531193609.71485-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531122320.909060-2-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

On Fri, 31 May 2024 15:23:19 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> In current implementation kdamond tracks only 1
> context, that is kdamond _is_ damon_ctx what makes
> it very difficult to implement multiple contexts.
> 
> This patch adds another level of abstraction, that is
> 'struct kdamond' - structure which represents kdamond itself.
> It holds references to all contexts organized in list.
> 
> Few fields like ->kdamond_started and ->kdamond_lock
> (just ->lock for 'struct kdamond') also has been moved
> to 'struct kdamond', because they have nothing to do
> with the context itself, but with the whole kdamond
> daemon.
> 
> Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
> ---
>  include/linux/damon.h     |  73 ++++++++---
>  mm/damon/core.c           | 249 ++++++++++++++++++++++-------------
>  mm/damon/lru_sort.c       |  31 +++--
>  mm/damon/modules-common.c |  36 +++--
>  mm/damon/modules-common.h |   3 +-
>  mm/damon/reclaim.c        |  30 +++--
>  mm/damon/sysfs.c          | 268 ++++++++++++++++++++++++--------------
>  7 files changed, 463 insertions(+), 227 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 886d07294..7cb9979a0 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -568,29 +568,49 @@ struct damon_attrs {
>  	unsigned long max_nr_regions;
>  };
>  
> +/**
> + * struct kdamond - Represents a background daemon that is responsible
> + * for executing each context.
> + *
> + * @lock:	Kdamond's global lock, serializes accesses to any field.
> + * @self:	Kernel thread which is actually being executed.
> + * @contexts:	Head of contexts (&damon_ctx) list.
> + * @nr_ctxs:	Number of contexts being monitored.
> + *
> + * Each DAMON's background daemon has this structure. Once
> + * configured, daemon can be started by calling damon_start().
> + *
> + * Monitoring can be explicitly stopped by calling damon_stop(). Once
> + * daemon is terminated @self is set to NULL, so users can know if
> + * monitoring is stopped by reading @self pointer. Access to @self
> + * must also be protected by @lock.
> + */
> +struct kdamond {
> +	struct mutex lock;
> +	struct task_struct *self;

I'm not sure if 'self' is a good name.  I'd prefer more clear name such as
'task', but this is not a strong opinion.

> +	struct list_head contexts;
> +	size_t nr_ctxs;
> +
> +/* private: */
> +	/* for waiting until the execution of the kdamond_fn is started */
> +	struct completion kdamond_started;
> +};
> +
>  /**
>   * struct damon_ctx - Represents a context for each monitoring.  This is the
>   * main interface that allows users to set the attributes and get the results
>   * of the monitoring.
>   *
>   * @attrs:		Monitoring attributes for accuracy/overhead control.
> - * @kdamond:		Kernel thread who does the monitoring.
> - * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
> + * @kdamond:		Back reference to daemon who is the owner of this context.

Why do we need this?

> + * @list:		List head of siblings.
>   *
>   * For each monitoring context, one kernel thread for the monitoring is
>   * created.  The pointer to the thread is stored in @kdamond.
>   *
>   * Once started, the monitoring thread runs until explicitly required to be
>   * terminated or every monitoring target is invalid.  The validity of the
> - * targets is checked via the &damon_operations.target_valid of @ops.  The
> - * termination can also be explicitly requested by calling damon_stop().
> - * The thread sets @kdamond to NULL when it terminates. Therefore, users can
> - * know whether the monitoring is ongoing or terminated by reading @kdamond.
> - * Reads and writes to @kdamond from outside of the monitoring thread must
> - * be protected by @kdamond_lock.
> - *
> - * Note that the monitoring thread protects only @kdamond via @kdamond_lock.
> - * Accesses to other fields must be protected by themselves.
> + * targets is checked via the &damon_operations.target_valid of @ops.
>   *
>   * @ops:	Set of monitoring operations for given use cases.
>   * @callback:	Set of callbacks for monitoring events notifications.
> @@ -614,12 +634,11 @@ struct damon_ctx {
>  	 * update
>  	 */
>  	unsigned long next_ops_update_sis;
> -	/* for waiting until the execution of the kdamond_fn is started */
> -	struct completion kdamond_started;
> +	unsigned long sz_limit;

What's this?

>  
>  /* public: */
> -	struct task_struct *kdamond;
> -	struct mutex kdamond_lock;
> +	struct kdamond *kdamond;
> +	struct list_head list;
>  
>  	struct damon_operations ops;
>  	struct damon_callback callback;
> @@ -653,6 +672,15 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
>  	return r->ar.end - r->ar.start;
>  }
>  
> +static inline struct damon_target *damon_first_target(struct damon_ctx *ctx)
> +{
> +	return list_first_entry(&ctx->adaptive_targets, struct damon_target, list);
> +}
> +
> +static inline struct damon_ctx *damon_first_ctx(struct kdamond *kdamond)
> +{
> +	return list_first_entry(&kdamond->contexts, struct damon_ctx, list);
> +}
>  
>  #define damon_for_each_region(r, t) \
>  	list_for_each_entry(r, &t->regions_list, list)
> @@ -675,6 +703,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
>  #define damon_for_each_scheme_safe(s, next, ctx) \
>  	list_for_each_entry_safe(s, next, &(ctx)->schemes, list)
>  
> +#define damon_for_each_context(c, kdamond) \
> +	list_for_each_entry(c, &(kdamond)->contexts, list)
> +
> +#define damon_for_each_context_safe(c, next, kdamond) \
> +	list_for_each_entry_safe(c, next, &(kdamond)->contexts, list)
> +
>  #define damos_for_each_quota_goal(goal, quota) \
>  	list_for_each_entry(goal, &quota->goals, list)
>  
> @@ -736,7 +770,12 @@ void damon_destroy_target(struct damon_target *t);
>  unsigned int damon_nr_regions(struct damon_target *t);
>  
>  struct damon_ctx *damon_new_ctx(void);
> +void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx);
> +struct kdamond *damon_new_kdamond(void);
>  void damon_destroy_ctx(struct damon_ctx *ctx);
> +void damon_destroy_ctxs(struct kdamond *kdamond);

Why do we need this?  Wouldn't damon_destroy_kdamond() do that?

> +void damon_destroy_kdamond(struct kdamond *kdamond);
> +bool damon_kdamond_running(struct kdamond *kdamond);

Let's put kdamond control functions outside of functions for damon_ctx control,
like we do for damon_target and damon_ctx.

>  int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
>  void damon_set_schemes(struct damon_ctx *ctx,
>  			struct damos **schemes, ssize_t nr_schemes);
> @@ -758,8 +797,8 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
>  }
>  
>  
> -int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
> -int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> +int damon_start(struct kdamond *kdamond, bool exclusive);
> +int damon_stop(struct kdamond *kdamond);
>  
>  int damon_set_region_biggest_system_ram_default(struct damon_target *t,
>  				unsigned long *start, unsigned long *end);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6d503c1c1..cfc9c803d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -24,7 +24,7 @@
>  #endif
>  
>  static DEFINE_MUTEX(damon_lock);
> -static int nr_running_ctxs;
> +static int nr_running_kdamonds;
>  static bool running_exclusive_ctxs;
>  
>  static DEFINE_MUTEX(damon_ops_lock);
> @@ -488,8 +488,6 @@ struct damon_ctx *damon_new_ctx(void)
>  	if (!ctx)
>  		return NULL;
>  
> -	init_completion(&ctx->kdamond_started);
> -
>  	ctx->attrs.sample_interval = 5 * 1000;
>  	ctx->attrs.aggr_interval = 100 * 1000;
>  	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
> @@ -499,17 +497,41 @@ struct damon_ctx *damon_new_ctx(void)
>  	ctx->next_aggregation_sis = 0;
>  	ctx->next_ops_update_sis = 0;
>  
> -	mutex_init(&ctx->kdamond_lock);
> -
>  	ctx->attrs.min_nr_regions = 10;
>  	ctx->attrs.max_nr_regions = 1000;
>  
>  	INIT_LIST_HEAD(&ctx->adaptive_targets);
>  	INIT_LIST_HEAD(&ctx->schemes);
> +	INIT_LIST_HEAD(&ctx->list);
>  
>  	return ctx;
>  }
>  
> +/**
> + * Adds newly allocated and configured @ctx to @kdamond.

There's no guarantee if @ctx is newly allocated and configured.  We can simply
say "Adds a DAMON context to a given DAMON thread".

And this may cause kerneldoc compilation warning.  I think the format should be
fixed, and parameters should be commented.

> + */
> +void damon_add_ctx(struct kdamond *kdamond, struct damon_ctx *ctx)
> +{
> +	list_add_tail(&ctx->list, &kdamond->contexts);
> +	++kdamond->nr_ctxs;
> +}
> +
> +struct kdamond *damon_new_kdamond(void)
> +{
> +	struct kdamond *kdamond;
> +
> +	kdamond = kzalloc(sizeof(*kdamond), GFP_KERNEL);
> +	if (!kdamond)
> +		return NULL;
> +
> +	init_completion(&kdamond->kdamond_started);
> +	mutex_init(&kdamond->lock);
> +
> +	INIT_LIST_HEAD(&kdamond->contexts);

Among the four fields of the struct, three are manually set here, and the final
one is set as zero by 'kzalloc()'.  I'd prefer using 'kmalloc()' and manually
set all fields.

> +
> +	return kdamond;
> +}
> +
>  static void damon_destroy_targets(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t, *next_t;
> @@ -523,6 +545,11 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
>  		damon_destroy_target(t);
>  }
>  
> +static inline void damon_del_ctx(struct damon_ctx *ctx)
> +{
> +	list_del(&ctx->list);
> +}
> +
>  void damon_destroy_ctx(struct damon_ctx *ctx)
>  {
>  	struct damos *s, *next_s;
> @@ -532,9 +559,27 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
>  	damon_for_each_scheme_safe(s, next_s, ctx)
>  		damon_destroy_scheme(s);
>  
> +	damon_del_ctx(ctx);
>  	kfree(ctx);
>  }
>  
> +void damon_destroy_ctxs(struct kdamond *kdamond)
> +{
> +	struct damon_ctx *c, *next;
> +
> +	damon_for_each_context_safe(c, next, kdamond) {
> +		damon_destroy_ctx(c);
> +		--kdamond->nr_ctxs;
> +	}
> +}

Is there explicit user of this function?  If not, I'd prefer making this
'static', or simply embed in damon_destroy_kdamond() below.

> +
> +void damon_destroy_kdamond(struct kdamond *kdamond)
> +{
> +	damon_destroy_ctxs(kdamond);
> +	mutex_destroy(&kdamond->lock);
> +	kfree(kdamond);
> +}
> +
>  static unsigned int damon_age_for_new_attrs(unsigned int age,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {
> @@ -667,13 +712,27 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
>   */
>  int damon_nr_running_ctxs(void)
>  {
> -	int nr_ctxs;
> +	int nr_kdamonds;
>  
>  	mutex_lock(&damon_lock);
> -	nr_ctxs = nr_running_ctxs;
> +	nr_kdamonds = nr_running_kdamonds;
>  	mutex_unlock(&damon_lock);
>  
> -	return nr_ctxs;
> +	return nr_kdamonds;

Shouldn't we change the name of this function, too?

> +}
> +
> +/**
> + * damon_kdamond_running() - Return true if kdamond is running
> + * false otherwise.
> + */
> +bool damon_kdamond_running(struct kdamond *kdamond)
> +{
> +	bool running;
> +
> +	mutex_lock(&kdamond->lock);
> +	running = kdamond->self != NULL;
> +	mutex_unlock(&kdamond->lock);
> +	return running;
>  }

Seems this function is used by only DAMON sysfs interface.  Don't implement
unnecessary public function.  Implement it in mm/damon/sysfs.c please.

>  
>  /* Returns the size upper limit for each monitoring region */
> @@ -700,38 +759,37 @@ static int kdamond_fn(void *data);
>  
>  /*
>   * __damon_start() - Starts monitoring with given context.

s/context/kdamond/?  Maybe we can simply say "starts given kdamond".

> - * @ctx:	monitoring context
> + * @kdamond:	daemon to be started
>   *
>   * This function should be called while damon_lock is hold.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -static int __damon_start(struct damon_ctx *ctx)
> +static int __damon_start(struct kdamond *kdamond)
>  {
>  	int err = -EBUSY;
>  
> -	mutex_lock(&ctx->kdamond_lock);
> -	if (!ctx->kdamond) {
> +	mutex_lock(&kdamond->lock);
> +	if (!kdamond->self) {
>  		err = 0;
> -		reinit_completion(&ctx->kdamond_started);
> -		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
> -				nr_running_ctxs);
> -		if (IS_ERR(ctx->kdamond)) {
> -			err = PTR_ERR(ctx->kdamond);
> -			ctx->kdamond = NULL;
> +		reinit_completion(&kdamond->kdamond_started);
> +		kdamond->self = kthread_run(kdamond_fn, kdamond, "kdamond.%d",
> +				nr_running_kdamonds);
> +		if (IS_ERR(kdamond->self)) {
> +			err = PTR_ERR(kdamond->self);
> +			kdamond->self = NULL;
>  		} else {
> -			wait_for_completion(&ctx->kdamond_started);
> +			wait_for_completion(&kdamond->kdamond_started);
>  		}
>  	}
> -	mutex_unlock(&ctx->kdamond_lock);
> +	mutex_unlock(&kdamond->lock);
>  
>  	return err;
>  }
>  
>  /**
>   * damon_start() - Starts the monitorings for a given group of contexts.
> - * @ctxs:	an array of the pointers for contexts to start monitoring
> - * @nr_ctxs:	size of @ctxs
> + * @kdamond:	a daemon that contains list of monitoring contexts
>   * @exclusive:	exclusiveness of this contexts group
>   *
>   * This function starts a group of monitoring threads for a group of monitoring
> @@ -743,74 +801,59 @@ static int __damon_start(struct damon_ctx *ctx)
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
> +int damon_start(struct kdamond *kdamond, bool exclusive)
>  {
> -	int i;
>  	int err = 0;
>  
> +	BUG_ON(!kdamond);
> +	BUG_ON(!kdamond->nr_ctxs);

checkpatch complains as below.

    WARNING: Do not crash the kernel unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants
    #432: FILE: mm/damon/core.c:809:
    +       BUG_ON(!kdamond->nr_ctxs);

I don't think we really need above BUG_ON() checks.

> +
> +	if (kdamond->nr_ctxs != 1)
> +		return -EINVAL;

Why do we need this?  To avoid DAMON sysfs interface change?  I think
mm/damon/sysfs.c does this check on its own, so this may not needed?

> +
>  	mutex_lock(&damon_lock);
> -	if ((exclusive && nr_running_ctxs) ||
> +	if ((exclusive && nr_running_kdamonds) ||
>  			(!exclusive && running_exclusive_ctxs)) {
>  		mutex_unlock(&damon_lock);
>  		return -EBUSY;
>  	}
>  
> -	for (i = 0; i < nr_ctxs; i++) {
> -		err = __damon_start(ctxs[i]);
> -		if (err)
> -			break;
> -		nr_running_ctxs++;
> -	}
> -	if (exclusive && nr_running_ctxs)
> +	err = __damon_start(kdamond);
> +	if (err)
> +		return err;
> +	nr_running_kdamonds++;
> +
> +	if (exclusive && nr_running_kdamonds)
>  		running_exclusive_ctxs = true;
>  	mutex_unlock(&damon_lock);
>  
>  	return err;
>  }
>  
> -/*
> - * __damon_stop() - Stops monitoring of a given context.
> - * @ctx:	monitoring context
> +/**
> + * damon_stop() - Stops the monitorings for a given group of contexts.

Let's simply say "Stops a given DAMON thread"

> + * @kdamond:	a daemon (that contains list of monitoring contexts)
> + * to be stopped.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -static int __damon_stop(struct damon_ctx *ctx)
> +int damon_stop(struct kdamond *kdamond)
>  {
>  	struct task_struct *tsk;
>  
> -	mutex_lock(&ctx->kdamond_lock);
> -	tsk = ctx->kdamond;
> +	mutex_lock(&kdamond->lock);
> +	tsk = kdamond->self;
>  	if (tsk) {
>  		get_task_struct(tsk);
> -		mutex_unlock(&ctx->kdamond_lock);
> +		mutex_unlock(&kdamond->lock);
>  		kthread_stop_put(tsk);
>  		return 0;
>  	}
> -	mutex_unlock(&ctx->kdamond_lock);
> +	mutex_unlock(&kdamond->lock);
>  
>  	return -EPERM;
>  }
>  
> -/**
> - * damon_stop() - Stops the monitorings for a given group of contexts.
> - * @ctxs:	an array of the pointers for contexts to stop monitoring
> - * @nr_ctxs:	size of @ctxs
> - *
> - * Return: 0 on success, negative error code otherwise.
> - */
> -int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
> -{
> -	int i, err = 0;
> -
> -	for (i = 0; i < nr_ctxs; i++) {
> -		/* nr_running_ctxs is decremented in kdamond_fn */
> -		err = __damon_stop(ctxs[i]);
> -		if (err)
> -			break;
> -	}
> -	return err;
> -}
> -
>  /*
>   * Reset the aggregated monitoring results ('nr_accesses' of each region).
>   */
> @@ -1582,29 +1625,68 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
>  	}
>  }
>  
> +static bool kdamond_init_ctx(struct damon_ctx *ctx)
> +{
> +	if (ctx->ops.init)
> +		ctx->ops.init(ctx);
> +	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
> +		return false;
> +
> +	kdamond_init_intervals_sis(ctx);
> +	ctx->sz_limit = damon_region_sz_limit(ctx);
> +
> +	return true;
> +}

I think 'int' return type for error code is better.  We can just return
before_start() return value in case of error, otherwise zero.

> +
> +static bool kdamond_init_ctxs(struct kdamond *kdamond)
> +{
> +	struct damon_ctx *c;
> +
> +	damon_for_each_context(c, kdamond)
> +		if (!kdamond_init_ctx(c))
> +			return false;
> +	return true;
> +}
> +
> +static void kdamond_finish_ctx(struct damon_ctx *ctx)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r, *next;
> +
> +	damon_for_each_target(t, ctx) {
> +		damon_for_each_region_safe(r, next, t)
> +			damon_destroy_region(r, t);
> +	}
> +
> +	if (ctx->callback.before_terminate)
> +		ctx->callback.before_terminate(ctx);
> +	if (ctx->ops.cleanup)
> +		ctx->ops.cleanup(ctx);
> +}
> +
> +static void kdamond_finish_ctxs(struct kdamond *kdamond)
> +{
> +	struct damon_ctx *c;
> +
> +	damon_for_each_context(c, kdamond)
> +		kdamond_finish_ctx(c);
> +}
> +
>  /*
>   * The monitoring daemon that runs as a kernel thread
>   */
>  static int kdamond_fn(void *data)
>  {
> -	struct damon_ctx *ctx = data;
> -	struct damon_target *t;
> -	struct damon_region *r, *next;
> +	struct kdamond *kdamond = data;
> +	struct damon_ctx *ctx = damon_first_ctx(kdamond);
>  	unsigned int max_nr_accesses = 0;
> -	unsigned long sz_limit = 0;
>  
>  	pr_debug("kdamond (%d) starts\n", current->pid);
>  
> -	complete(&ctx->kdamond_started);
> -	kdamond_init_intervals_sis(ctx);
> -
> -	if (ctx->ops.init)
> -		ctx->ops.init(ctx);
> -	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
> +	complete(&kdamond->kdamond_started);
> +	if (!kdamond_init_ctxs(kdamond))
>  		goto done;
>  
> -	sz_limit = damon_region_sz_limit(ctx);
> -
>  	while (!kdamond_need_stop(ctx)) {
>  		/*
>  		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could
> @@ -1616,6 +1698,7 @@ static int kdamond_fn(void *data)
>  		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
>  		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
>  		unsigned long sample_interval = ctx->attrs.sample_interval;
> +		unsigned long sz_limit = ctx->sz_limit;
>  
>  		if (kdamond_wait_activation(ctx))
>  			break;
> @@ -1666,28 +1749,20 @@ static int kdamond_fn(void *data)
>  				sample_interval;
>  			if (ctx->ops.update)
>  				ctx->ops.update(ctx);
> -			sz_limit = damon_region_sz_limit(ctx);
> +			ctx->sz_limit = damon_region_sz_limit(ctx);
>  		}
>  	}
>  done:
> -	damon_for_each_target(t, ctx) {
> -		damon_for_each_region_safe(r, next, t)
> -			damon_destroy_region(r, t);
> -	}
> -
> -	if (ctx->callback.before_terminate)
> -		ctx->callback.before_terminate(ctx);
> -	if (ctx->ops.cleanup)
> -		ctx->ops.cleanup(ctx);
> +	kdamond_finish_ctxs(kdamond);
>  
>  	pr_debug("kdamond (%d) finishes\n", current->pid);
> -	mutex_lock(&ctx->kdamond_lock);
> -	ctx->kdamond = NULL;
> -	mutex_unlock(&ctx->kdamond_lock);
> +	mutex_lock(&kdamond->lock);
> +	kdamond->self = NULL;
> +	mutex_unlock(&kdamond->lock);
>  
>  	mutex_lock(&damon_lock);
> -	nr_running_ctxs--;
> -	if (!nr_running_ctxs && running_exclusive_ctxs)
> +	nr_running_kdamonds--;
> +	if (!nr_running_kdamonds && running_exclusive_ctxs)
>  		running_exclusive_ctxs = false;
>  	mutex_unlock(&damon_lock);
>  
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 3de2916a6..76c20098a 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -142,8 +142,18 @@ static struct damos_access_pattern damon_lru_sort_stub_pattern = {
>  	.max_age_region = UINT_MAX,
>  };
>  
> -static struct damon_ctx *ctx;
> -static struct damon_target *target;
> +static struct kdamond *kdamond;
> +
> +static inline struct damon_ctx *damon_lru_sort_ctx(void)
> +{
> +	return damon_first_ctx(kdamond);
> +}
> +
> +static inline struct damon_target *damon_lru_sort_target(void)
> +{
> +	return damon_first_target(
> +			damon_lru_sort_ctx());
> +}

Do we really need above two functions?  Can't we simply add 'kdamond' global
variable but still uses 'ctx' and 'target' as before, except interface changed
function calls?

>  
>  static struct damos *damon_lru_sort_new_scheme(
>  		struct damos_access_pattern *pattern, enum damos_action action)
> @@ -201,6 +211,7 @@ static int damon_lru_sort_apply_parameters(void)
>  	struct damos *scheme, *hot_scheme, *cold_scheme;
>  	struct damos *old_hot_scheme = NULL, *old_cold_scheme = NULL;
>  	unsigned int hot_thres, cold_thres;
> +	struct damon_ctx *ctx = damon_lru_sort_ctx();
>  	int err = 0;
>  
>  	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
> @@ -237,7 +248,8 @@ static int damon_lru_sort_apply_parameters(void)
>  	damon_set_schemes(ctx, &hot_scheme, 1);
>  	damon_add_scheme(ctx, cold_scheme);
>  
> -	return damon_set_region_biggest_system_ram_default(target,
> +	return damon_set_region_biggest_system_ram_default(
> +					damon_lru_sort_target(),
>  					&monitor_region_start,
>  					&monitor_region_end);
>  }
> @@ -247,7 +259,7 @@ static int damon_lru_sort_turn(bool on)
>  	int err;
>  
>  	if (!on) {
> -		err = damon_stop(&ctx, 1);
> +		err = damon_stop(kdamond);
>  		if (!err)
>  			kdamond_pid = -1;
>  		return err;
> @@ -257,10 +269,11 @@ static int damon_lru_sort_turn(bool on)
>  	if (err)
>  		return err;
>  
> -	err = damon_start(&ctx, 1, true);
> +	err = damon_start(kdamond, true);
>  	if (err)
>  		return err;
> -	kdamond_pid = ctx->kdamond->pid;
> +
> +	kdamond_pid = kdamond->self->pid;
>  	return 0;
>  }
>  
> @@ -279,7 +292,7 @@ static int damon_lru_sort_enabled_store(const char *val,
>  		return 0;
>  
>  	/* Called before init function.  The function will handle this. */
> -	if (!ctx)
> +	if (!kdamond)
>  		goto set_param_out;
>  
>  	err = damon_lru_sort_turn(enable);
> @@ -334,11 +347,13 @@ static int damon_lru_sort_after_wmarks_check(struct damon_ctx *c)
>  
>  static int __init damon_lru_sort_init(void)
>  {
> -	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
> +	struct damon_ctx *ctx;
> +	int err = damon_modules_new_paddr_kdamond(&kdamond);

I think we can allocate kdamond struct and set ctx/target here, and remove
unnecessary functions and changes.

>  
>  	if (err)
>  		return err;
>  
> +	ctx = damon_lru_sort_ctx();
>  	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
>  	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
>  
> diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
> index 7cf96574c..436bb7948 100644
> --- a/mm/damon/modules-common.c
> +++ b/mm/damon/modules-common.c
> @@ -9,13 +9,7 @@
>  
>  #include "modules-common.h"
>  
> -/*
> - * Allocate, set, and return a DAMON context for the physical address space.
> - * @ctxp:	Pointer to save the point to the newly created context
> - * @targetp:	Pointer to save the point to the newly created target
> - */
> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
> -		struct damon_target **targetp)
> +static int __damon_modules_new_paddr_kdamond(struct kdamond *kdamond)
>  {
>  	struct damon_ctx *ctx;
>  	struct damon_target *target;
> @@ -34,9 +28,33 @@ int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
>  		damon_destroy_ctx(ctx);
>  		return -ENOMEM;
>  	}
> +
>  	damon_add_target(ctx, target);
> +	damon_add_ctx(kdamond, ctx);
> +
> +	return 0;
> +}
> +
> +/*
> + * Allocate, set, and return a DAMON daemon for the physical address space.
> + * @kdamondp:	Pointer to save the point to the newly created kdamond
> + */
> +int damon_modules_new_paddr_kdamond(struct kdamond **kdamondp)
> +{
> +	int err;
> +	struct kdamond *kdamond;
> +
> +	kdamond = damon_new_kdamond();
> +	if (!kdamond)
> +		return -ENOMEM;
> +
> +	err = __damon_modules_new_paddr_kdamond(kdamond);
> +	if (err) {
> +		damon_destroy_kdamond(kdamond);
> +		return err;
> +	}
> +	kdamond->nr_ctxs = 1;
>  
> -	*ctxp = ctx;
> -	*targetp = target;
> +	*kdamondp = kdamond;
>  	return 0;
>  }
> diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
> index f49cdb417..5fc5b8ae3 100644
> --- a/mm/damon/modules-common.h
> +++ b/mm/damon/modules-common.h
> @@ -45,5 +45,4 @@
>  	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
>  			0400);
>  
> -int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
> -		struct damon_target **targetp);
> +int damon_modules_new_paddr_kdamond(struct kdamond **kdamondp);
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 9bd341d62..f6540ef1a 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -150,8 +150,18 @@ static struct damos_stat damon_reclaim_stat;
>  DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
>  		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
>  
> -static struct damon_ctx *ctx;
> -static struct damon_target *target;
> +static struct kdamond *kdamond;
> +
> +static inline struct damon_ctx *damon_reclaim_ctx(void)
> +{
> +	return damon_first_ctx(kdamond);
> +}
> +
> +static inline struct damon_target *damon_reclaim_target(void)
> +{
> +	return damon_first_target(
> +			damon_reclaim_ctx());
> +}

Ditto.

>  
>  static struct damos *damon_reclaim_new_scheme(void)
>  {
> @@ -197,6 +207,7 @@ static int damon_reclaim_apply_parameters(void)
>  	struct damos *scheme, *old_scheme;
>  	struct damos_quota_goal *goal;
>  	struct damos_filter *filter;
> +	struct damon_ctx *ctx = damon_reclaim_ctx();
>  	int err = 0;
>  
>  	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
> @@ -244,7 +255,8 @@ static int damon_reclaim_apply_parameters(void)
>  	}
>  	damon_set_schemes(ctx, &scheme, 1);
>  
> -	return damon_set_region_biggest_system_ram_default(target,
> +	return damon_set_region_biggest_system_ram_default(
> +					damon_reclaim_target(),
>  					&monitor_region_start,
>  					&monitor_region_end);
>  }
> @@ -254,7 +266,7 @@ static int damon_reclaim_turn(bool on)
>  	int err;
>  
>  	if (!on) {
> -		err = damon_stop(&ctx, 1);
> +		err = damon_stop(kdamond);
>  		if (!err)
>  			kdamond_pid = -1;
>  		return err;
> @@ -264,10 +276,10 @@ static int damon_reclaim_turn(bool on)
>  	if (err)
>  		return err;
>  
> -	err = damon_start(&ctx, 1, true);
> +	err = damon_start(kdamond, true);
>  	if (err)
>  		return err;
> -	kdamond_pid = ctx->kdamond->pid;
> +	kdamond_pid = kdamond->self->pid;
>  	return 0;
>  }
>  
> @@ -286,7 +298,7 @@ static int damon_reclaim_enabled_store(const char *val,
>  		return 0;
>  
>  	/* Called before init function.  The function will handle this. */
> -	if (!ctx)
> +	if (!kdamond)
>  		goto set_param_out;
>  
>  	err = damon_reclaim_turn(enable);
> @@ -337,11 +349,13 @@ static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
>  
>  static int __init damon_reclaim_init(void)
>  {
> -	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
> +	struct damon_ctx *ctx;
> +	int err = damon_modules_new_paddr_kdamond(&kdamond);
>  
>  	if (err)
>  		return err;
>  
> +	ctx = damon_reclaim_ctx();
>  	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
>  	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
>  
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 6fee383bc..bfdb979e6 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

Ditto.  Many of below changes could be separated into another patch in my
opinion.

> @@ -939,7 +939,7 @@ static const struct kobj_type damon_sysfs_contexts_ktype = {
>  struct damon_sysfs_kdamond {
>  	struct kobject kobj;
>  	struct damon_sysfs_contexts *contexts;
> -	struct damon_ctx *damon_ctx;
> +	struct kdamond *kdamond;
>  };
>  
>  static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
> @@ -974,16 +974,6 @@ static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
>  	kobject_put(&kdamond->contexts->kobj);
>  }
>  
> -static bool damon_sysfs_ctx_running(struct damon_ctx *ctx)
> -{
> -	bool running;
> -
> -	mutex_lock(&ctx->kdamond_lock);
> -	running = ctx->kdamond != NULL;
> -	mutex_unlock(&ctx->kdamond_lock);
> -	return running;
> -}

Don't add replacement of this in mm/damon/core.c.  Modify this here.

> -
>  /*
>   * enum damon_sysfs_cmd - Commands for a specific kdamond.
>   */
> @@ -1065,15 +1055,15 @@ static struct damon_sysfs_cmd_request damon_sysfs_cmd_request;
>  static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
>  		char *buf)
>  {
> -	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
> +	struct damon_sysfs_kdamond *sys_kdamond = container_of(kobj,
>  			struct damon_sysfs_kdamond, kobj);

This makes reviewing bit difficult.  Let's keep current name for now.

> -	struct damon_ctx *ctx = kdamond->damon_ctx;
> +	struct kdamond *kdamond = sys_kdamond->kdamond;

Keep 'kdamond' variable name as is, and use shorter name for this variable,
say, kd, or do kdamond->kdamond.

>  	bool running;
>  
> -	if (!ctx)
> +	if (!kdamond)

"if (!kd)" or "if (!kdamond->kdamond)"

>  		running = false;
>  	else
> -		running = damon_sysfs_ctx_running(ctx);
> +		running = damon_kdamond_running(kdamond);
>  
>  	return sysfs_emit(buf, "%s\n", running ?
>  			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
> @@ -1242,13 +1232,15 @@ static bool damon_sysfs_schemes_regions_updating;
>  static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t, *next;
> -	struct damon_sysfs_kdamond *kdamond;
> +	struct damon_sysfs_kdamond *sys_kdamond;
> +	struct kdamond *kdamond;
>  	enum damon_sysfs_cmd cmd;
>  
>  	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
> -	kdamond = damon_sysfs_cmd_request.kdamond;
> +	kdamond = ctx->kdamond;
> +	sys_kdamond = damon_sysfs_cmd_request.kdamond;
>  	cmd = damon_sysfs_cmd_request.cmd;
> -	if (kdamond && ctx == kdamond->damon_ctx &&
> +	if (sys_kdamond && kdamond == sys_kdamond->kdamond &&
>  			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
>  			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES) &&
>  			damon_sysfs_schemes_regions_updating) {

Again, changed names makes me reviewing difficult.

From this point, I think below changes could be significantly changed in next
version of this patchset if you agree to above comments.  So I'm stop reviewing
this patch from here for now.  Please let me know if you have different opinion
about it.


Thanks,
SJ

[...]


Return-Path: <linux-kernel+bounces-416640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19F9D4822
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F78E281180
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4EA1A76C4;
	Thu, 21 Nov 2024 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbfnsFOB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090B230986
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173502; cv=none; b=NTJwgdXpgwkKubJ55di1zECvgjhdc8vIEXGhxoSSYfOW7IwrS6kcKkd/GXibSL2k4pH94C46VudWeLTAiJsQhnHGUaU/CLQTg/2wCW3nWyjBWjpd27mSin4XLCdCM+O/uo09DwRFb4Eq9oWUqX+t8hQnO/M0tJwH27Vc6bVbk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173502; c=relaxed/simple;
	bh=1USHLF7Nt8jO0EXqOCPkzUsLHu3r2P17RWBvuS5otIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFZe/2XFBInZVB97mFC/uXc9H69GIgXWqJC7z552jvkmqpAAN+8z912Yo4+wKLUEIPwp6cORo5CttCmWq7YvSwxw9YU7O67U+//bZi12fHRx6RwTmaB0qIw0D705gfbnMxbUKOmvxKm8QNGZ5/ihkti79GklS17GNQXdUE5rdEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbfnsFOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF833C4CECC;
	Thu, 21 Nov 2024 07:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732173502;
	bh=1USHLF7Nt8jO0EXqOCPkzUsLHu3r2P17RWBvuS5otIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbfnsFOBsmPwj1lkF2VT+gLd+aYl12vlM/CTfYWsQKWC5xf8dyFLtHMunIM7Nn+H+
	 fzCOw09YN+al9BUGTbmkm6vUfQd9M6LiwygMV618ljIV6G4xCd6mX2UVSZ1TOP0Ezf
	 WAqBqSOcpiNEJqhh7DgHK0Gi3DCau0c6xi8HoNHyHS6uDV+1+sHhE7hgzH43cS/WJo
	 PTpvuTMH6kCixryygro/qBGIKeHZlu8DTUohUHV8HOpjaE99dcl0ur/1r54rjlpffG
	 7lXy4YYriUnnrKhxJGPLEUErTaLsClDgMVI78zYWJbpSTYf5VZtUwUcyezi32lX/OI
	 rPVLHYLxC6s4w==
Date: Wed, 20 Nov 2024 23:18:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
Message-ID: <Zz7evEkguMdglxdZ@google.com>
References: <20241121044551.3899270-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121044551.3899270-1-ctshao@google.com>

Hi CT,

On Thu, Nov 21, 2024 at 04:45:51AM +0000, Chun-Tse Shao wrote:
> `parse_lock_type` can only add the first lock flag in `lock_type_table`
> given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> into this perf session. Another example is for `-Y mutex`, it only adds
> the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> so on.

Thanks for working on this.  I think I broke it at some point.

> 
> Testing:
>   $ ./perf lock con -ab -Y rwlock,mutex -- perf bench sched pipe
>   # Running 'sched/pipe' benchmark:
>   # Executed 1000000 pipe operations between two processes
> 
>        Total time: 7.870 [sec]
> 
>          7.870224 usecs/op
>            127061 ops/sec
>    contended   total wait     max wait     avg wait         type   caller
> 
>          122      1.01 ms     18.73 us      8.32 us        mutex   pipe_read+0x57
>           33    149.06 us      8.88 us      4.52 us        mutex   pipe_write+0x50
>            5     56.06 us     15.07 us     11.21 us        mutex   do_epoll_wait+0x24d
>            2     26.43 us     14.62 us     13.22 us        mutex   do_epoll_wait+0x24d
>            2     21.51 us     15.68 us     10.76 us        mutex   pipe_read+0x282
>            2     20.57 us     10.74 us     10.29 us        mutex   do_epoll_ctl+0x3d4
>            1      8.58 us      8.58 us      8.58 us     rwlock:W   do_epoll_wait+0x255
>            1      8.38 us      8.38 us      8.38 us     rwlock:W   do_epoll_ctl+0xb65
>            1      8.11 us      8.11 us      8.11 us     rwlock:R   ep_poll_callback+0x35
>            1      5.49 us      5.49 us      5.49 us        mutex   do_epoll_ctl+0x6c1

It should have

Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")

> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/builtin-lock.c | 118 +++++++++++++++++++++++---------------
>  1 file changed, 71 insertions(+), 47 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 062e2b56a2ab..2692b8e9eb9a 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1575,61 +1575,57 @@ static void sort_result(void)
>  
>  static const struct {
>  	unsigned int flags;
> -	const char *str;
> +	/* Name of the lock, it is unique and 1-1 mapping to flags */
>  	const char *name;
> +	/*
> +	 * Name of the group this lock belongs to.
> +	 * For example, both rwlock:R and rwlock:W belong to rwlock.
> +	 * This is used for reverse parsing while user specify the group name (ex. mutex/rwlock),
> +	 * And for symbol name in LOCK_AGGR_ADDR mode.
> +	 */
> +	const char *affiliated_group_name;
> +	/*
> +	 * This is used for caller type in LOCK_AGGR_CALLER mode.
> +	 */
> +	const char *caller_type;

I admit that the 'str' and 'name' are not good but I'm not sure if we
need those 3 different names because they are mostly the same.  Maybe we
have rename the original fields to 'name' and 'group'?


>  } lock_type_table[] = {
> -	{ 0,				"semaphore",	"semaphore" },
> -	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
> -	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock" },
> -	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock" },
> -	{ LCB_F_READ,			"rwsem:R",	"rwsem" },
> -	{ LCB_F_WRITE,			"rwsem:W",	"rwsem" },
> -	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
> -	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
> -	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
> -	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
> -	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
> -	{ LCB_F_MUTEX,			"mutex",	"mutex" },
> -	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
> -	/* alias for get_type_flag() */
> -	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
> +	{ 0,				"semaphore",	"semaphore",	"semaphore" },
> +	{ LCB_F_SPIN,			"spinlock",	"spinlock",	"spinlock" },
> +	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock",	"rwlock:R" },
> +	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock",	"rwlock:W" },
> +	{ LCB_F_READ,			"rwsem:R",	"rwsem",	"rwsem:R" },
> +	{ LCB_F_WRITE,			"rwsem:W",	"rwsem",	"rwsem:W" },
> +	{ LCB_F_RT,			"rt-mutex",	"rt-mutex",	"rt-mutex" },
> +	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt",	"rwlock-rt:R" },
> +	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt",	"rwlock-rt:W" },
> +	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem",	"pcpu-sem:R" },
> +	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem",	"pcpu-sem:W" },

I've realized that it doesn't match with the documentation.  It should
match with 'pcpu-sem'.  Maybe we can replace the 'pcpu-sem' string in
the parse_lock_type() to 'percpu-rwsem'.

> +	{ LCB_F_MUTEX,			"mutex-nospin",	"mutex",	"mutex" },
> +	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex",	"mutex" },

These are not for users and we don't track mutex-spinning precisely
(yet).  So I think we can name both of them simply as "mutex".

  { LCB_F_MUTEX,		"mutex", "mutex" },
  { LCB_F_MUTEX | LCB_F_SPIN	"mutex", "mutex" },
 
And remove the last alias entry.

>  };
>  
> -static const char *get_type_str(unsigned int flags)
> +static const char *get_lock_caller_type(unsigned int flags)
>  {
>  	flags &= LCB_F_MAX_FLAGS - 1;
>  
>  	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  		if (lock_type_table[i].flags == flags)
> -			return lock_type_table[i].str;
> +			return lock_type_table[i].caller_type;
>  	}
>  	return "unknown";
>  }
>  
> -static const char *get_type_name(unsigned int flags)
> +static const char *get_lock_affiliated_group_name(unsigned int flags)
>  {
>  	flags &= LCB_F_MAX_FLAGS - 1;
>  
>  	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  		if (lock_type_table[i].flags == flags)
> -			return lock_type_table[i].name;
> +			return lock_type_table[i].affiliated_group_name;
>  	}
>  	return "unknown";
>  }
>  
> -static unsigned int get_type_flag(const char *str)
> -{
> -	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].name, str))
> -			return lock_type_table[i].flags;
> -	}
> -	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].str, str))
> -			return lock_type_table[i].flags;
> -	}
> -	return UINT_MAX;
> -}
> -
>  static void lock_filter_finish(void)
>  {
>  	zfree(&filters.types);
> @@ -1732,7 +1728,8 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
>  
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
> -		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
> +		fprintf(lock_output, "  %10s   %s\n",
> +			get_lock_caller_type(st->flags), st->name);
>  		break;
>  	case LOCK_AGGR_TASK:
>  		pid = st->addr;
> @@ -1742,7 +1739,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
>  		break;
>  	case LOCK_AGGR_ADDR:
>  		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
> -			st->name, get_type_name(st->flags));
> +			st->name, get_lock_affiliated_group_name(st->flags));
>  		break;
>  	case LOCK_AGGR_CGROUP:
>  		fprintf(lock_output, "  %s\n", st->name);
> @@ -1783,7 +1780,8 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
>  
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
> -		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
> +		fprintf(lock_output, "%s%s %s",
> +			get_lock_caller_type(st->flags), sep, st->name);
>  		if (verbose <= 0)
>  			fprintf(lock_output, "\n");
>  		break;
> @@ -1795,7 +1793,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
>  		break;
>  	case LOCK_AGGR_ADDR:
>  		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
> -			st->name, sep, get_type_name(st->flags));
> +			st->name, sep, get_lock_affiliated_group_name(st->flags));
>  		break;
>  	case LOCK_AGGR_CGROUP:
>  		fprintf(lock_output, "%s\n",st->name);
> @@ -2333,6 +2331,7 @@ static int parse_max_stack(const struct option *opt, const char *str,
>  	return 0;
>  }
>  
> +
>  static bool add_lock_type(unsigned int flags)
>  {
>  	unsigned int *tmp;
> @@ -2350,29 +2349,54 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
>  			   int unset __maybe_unused)
>  {
>  	char *s, *tmp, *tok;
> -	int ret = 0;
>  
>  	s = strdup(str);
>  	if (s == NULL)
>  		return -1;
>  
>  	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> -		unsigned int flags = get_type_flag(tok);
> +		bool found = false;
>  
> -		if (flags == -1U) {
> -			pr_err("Unknown lock flags: %s\n", tok);
> -			ret = -1;
> -			break;
> +		/* Traverse lock name first. */
> +		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +			if (!strcmp(lock_type_table[i].name, tok)) {
> +				if (add_lock_type(lock_type_table[i].flags)) {
> +					found = true;
> +					break;
> +				}
> +				pr_err("Failed to alloc lock: %s\n", tok);
> +				free(s);
> +				return -1;
> +			}
>  		}
> +		if (found)
> +			continue;

Then I think the logic can be like this.

		if (strchr(tok, ':')) {
			flags = get_type_flag(tok);
			add_lock_type(flag);
			continue;
		}

		if (!strcmp(tok, "pcpu-sem"))
			tok = "percpu-rwsem";

		for (i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
			if (!strcmp(lock_type_table[i].group, tok))
				add_lock_type(...);
		}

Thanks,
Namhyung

>  
> -		if (!add_lock_type(flags)) {
> -			ret = -1;
> -			break;
> +		/*
> +		 * If `tok` can not be found in lock name, look up the lock affiliated group
> +		 * instead. A group would contain more than one lock flag.
> +		 */
> +		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +			if (!strcmp(lock_type_table[i].affiliated_group_name, tok)) {
> +				if (add_lock_type(lock_type_table[i].flags)) {
> +					found = true;
> +				} else {
> +					pr_err("Failed to alloc lock: %s\n", tok);
> +					free(s);
> +					return -1;
> +				}
> +			}
> +		}
> +
> +		if (!found) {
> +			pr_err("Unknown lock flags: %s\n", tok);
> +			free(s);
> +			return -1;
>  		}
>  	}
>  
>  	free(s);
> -	return ret;
> +	return 0;
>  }
>  
>  static bool add_lock_addr(unsigned long addr)
> -- 
> 2.47.0.371.ga323438b13-goog
> 

